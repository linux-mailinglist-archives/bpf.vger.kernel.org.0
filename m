Return-Path: <bpf+bounces-4016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BE5747B75
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 04:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00642281009
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 02:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8173A29;
	Wed,  5 Jul 2023 02:17:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A127F6
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 02:17:44 +0000 (UTC)
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Jul 2023 19:17:42 PDT
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CD1C10E2;
	Tue,  4 Jul 2023 19:17:42 -0700 (PDT)
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id CBFD372C90D;
	Wed,  5 Jul 2023 05:00:40 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
	by imap.altlinux.org (Postfix) with ESMTPSA id C1F0A36D00E5;
	Wed,  5 Jul 2023 05:00:40 +0300 (MSK)
Date: Wed, 5 Jul 2023 05:00:40 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: dwarves@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: bpf@vger.kernel.org, "Dmitry V. Levin" <ldv@altlinux.org>
Subject: pahole 1.25 SIGSEGV when building kernel (-j when cores > 81)
Message-ID: <20230705020040.bqhtd3yxpntk44q5@altlinux.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

After updating Dwarves to v1.25 we are getting SIGSEGV while building
kernel on 32-bit x86 architecture. It looks like this:

    BTF     .btf.vmlinux.bin.o
  scripts/link-vmlinux.sh: line 111: 395728 Segmentation fault      LLVM_OBJCOPY="${OBJCOPY}" ${PAHOLE} -J ${PAHOLE_FLAGS} ${1}
    LD      .tmp_vmlinux.kallsyms1
    NM      .tmp_vmlinux.kallsyms1.syms
    KSYMS   .tmp_vmlinux.kallsyms1.S
    AS      .tmp_vmlinux.kallsyms1.S
    LD      .tmp_vmlinux.kallsyms2
    NM      .tmp_vmlinux.kallsyms2.syms
    KSYMS   .tmp_vmlinux.kallsyms2.S
    AS      .tmp_vmlinux.kallsyms2.S
    LD      vmlinux
    BTFIDS  vmlinux
  libbpf: failed to find '.BTF' ELF section in vmlinux
  FAILED: load BTF from vmlinux: No data available

What crashes is this command:

  pahole -J --btf_gen_floats -j --lang_exclude=rust .tmp_vmlinux.btf

I found that cause of the crash is that build box having 128 cores. By
experiment I found that with -j81 pahole works OK, but with -j82 or
greater it crashes.

  $ gdb -q --args pahole -J --btf_gen_floats -j111 --lang_exclude=rust .tmp_vmlinux.btf
  Thread 15 "pahole" received signal SIGSEGV, Segmentation fault.
  [Switching to Thread 0xda5ffb40 (LWP 3102466)]
  0xf7f3c944 in btf_encoder__btf (encoder=0x0) at /usr/src/debug/dwarves-1.25/btf_encoder.c:1890
  1890            return encoder->btf;
  (gdb) bt
  #0  0xf7f3c944 in btf_encoder__btf (encoder=0x0) at /usr/src/debug/dwarves-1.25/btf_encoder.c:1890
  #1  0x5655c25d in pahole_stealer (cu=0xd9a01f80, conf_load=0x565640c0 <conf_load>, thr_data=0x56567c18) at /usr/src/debug/dwarves-1.25/pahole.c:3100
  #2  0xf7f452d7 in cu__finalize (cu=cu@entry=0xd9a01f80, conf=0x565640c0 <conf_load>, thr_data=thr_data@entry=0x56567c18)
      at /usr/src/debug/dwarves-1.25/dwarf_loader.c:3001
  #3  0xf7f4541d in cus__finalize (thr_data=0x56567c18, conf=<optimized out>, cu=0xd9a01f80, cus=0x565651c0) at /usr/src/debug/dwarves-1.25/dwarf_loader.c:3008
  #4  dwarf_cus__create_and_process_cu (dcus=dcus@entry=0xffffd19c, cu_die=cu_die@entry=0xda5ff38c, pointer_size=<optimized out>, thr_data=0x56567c18)
      at /usr/src/debug/dwarves-1.25/dwarf_loader.c:3207
  #5  0xf7f461af in dwarf_cus__process_cu_thread (arg=0xffffcbf8) at /usr/src/debug/dwarves-1.25/dwarf_loader.c:3250
  #6  0xf7db4258 in start_thread (arg=<optimized out>) at pthread_create.c:444
  #7  0xf7e3a878 in clone3 () from /lib/libc.so.6
  (gdb) p encoder
  $1 = (struct btf_encoder *) 0x0
  (gdb) f 1
  #1  0x5655c25d in pahole_stealer (cu=0xd9a01f80, conf_load=0x565640c0 <conf_load>, thr_data=0x56567c18) at /usr/src/debug/dwarves-1.25/pahole.c:3100
  3100                                    thread->btf = btf_encoder__btf(thread->encoder);
  (gdb) list -2
  3093                                    thread->encoder =
  3094                                            btf_encoder__new(cu, detached_btf_filename,
  3095                                                             NULL,
  3096                                                             skip_encoding_btf_vars,
  3097                                                             btf_encode_force,
  3098                                                             btf_gen_floats,
  3099                                                             global_verbose);
  3100                                    thread->btf = btf_encoder__btf(thread->encoder);
  3101                            }
  3102                            encoder = thread->encoder;

I think that return value of btf_encoder__new is not checked. But did
not investigate further why is this happening. It would be great to have
this fixed.

Thanks,


