Return-Path: <bpf+bounces-4608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3792574D7F2
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 15:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02475281159
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 13:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1628125D1;
	Mon, 10 Jul 2023 13:42:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A1211C96
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 13:42:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A729C433C7;
	Mon, 10 Jul 2023 13:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688996566;
	bh=pBP8F7yBfJgAm5D+LdVVqjiQazXnBnYgWkEsrCgjcOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EFUCipZ1AnRXfwmsRGhVw8MFE5dcIkHasM1VObaMJHGy2K0zVTwDvs2zTXiDey2db
	 QrYZT+Uwd5OevSXb3l/UjFrIy4PLQPSsjoLmbuF2lY6VQw6TUulJDRfwBC/Np1/DDc
	 N2OC0K4tZOTOUh+ddoAAadPVbGlXIpFGnRq6kHLNQasXqr+DVJrWwM1B6ukJ38sNcx
	 8/qIRWksRcaV2+0sUpVvzpxVkgERfp4WOtMf4Kb/uWOcJy0vO2hOwvAoAAdrN0GEIN
	 ia1EuHoCKaANEfukZXgMxdpsRIO1gclEprmxGdMYQh01xUciw4FVokddPRTVi3aKIM
	 bYQ478l8mt4QQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id A1ECC40516; Mon, 10 Jul 2023 10:42:43 -0300 (-03)
Date: Mon, 10 Jul 2023 10:42:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Vitaly Chikunov <vt@altlinux.org>
Cc: dwarves@vger.kernel.org, bpf@vger.kernel.org,
	"Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: pahole 1.25 SIGSEGV when building kernel (-j when cores > 81)
Message-ID: <ZKwK049Hg7taAxv9@kernel.org>
References: <20230705020040.bqhtd3yxpntk44q5@altlinux.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705020040.bqhtd3yxpntk44q5@altlinux.org>
X-Url: http://acmel.wordpress.com

Em Wed, Jul 05, 2023 at 05:00:40AM +0300, Vitaly Chikunov escreveu:
> Hi,
> 
> After updating Dwarves to v1.25 we are getting SIGSEGV while building
> kernel on 32-bit x86 architecture. It looks like this:

128 cores, 32-bit system? Interesting :-)
 
>     BTF     .btf.vmlinux.bin.o
>   scripts/link-vmlinux.sh: line 111: 395728 Segmentation fault      LLVM_OBJCOPY="${OBJCOPY}" ${PAHOLE} -J ${PAHOLE_FLAGS} ${1}
>     LD      .tmp_vmlinux.kallsyms1
>     NM      .tmp_vmlinux.kallsyms1.syms
>     KSYMS   .tmp_vmlinux.kallsyms1.S
>     AS      .tmp_vmlinux.kallsyms1.S
>     LD      .tmp_vmlinux.kallsyms2
>     NM      .tmp_vmlinux.kallsyms2.syms
>     KSYMS   .tmp_vmlinux.kallsyms2.S
>     AS      .tmp_vmlinux.kallsyms2.S
>     LD      vmlinux
>     BTFIDS  vmlinux
>   libbpf: failed to find '.BTF' ELF section in vmlinux
>   FAILED: load BTF from vmlinux: No data available
> 
> What crashes is this command:
> 
>   pahole -J --btf_gen_floats -j --lang_exclude=rust .tmp_vmlinux.btf
> 
> I found that cause of the crash is that build box having 128 cores. By
> experiment I found that with -j81 pahole works OK, but with -j82 or
> greater it crashes.
> 
>   $ gdb -q --args pahole -J --btf_gen_floats -j111 --lang_exclude=rust .tmp_vmlinux.btf
>   Thread 15 "pahole" received signal SIGSEGV, Segmentation fault.
>   [Switching to Thread 0xda5ffb40 (LWP 3102466)]
>   0xf7f3c944 in btf_encoder__btf (encoder=0x0) at /usr/src/debug/dwarves-1.25/btf_encoder.c:1890
>   1890            return encoder->btf;
>   (gdb) bt
>   #0  0xf7f3c944 in btf_encoder__btf (encoder=0x0) at /usr/src/debug/dwarves-1.25/btf_encoder.c:1890
>   #1  0x5655c25d in pahole_stealer (cu=0xd9a01f80, conf_load=0x565640c0 <conf_load>, thr_data=0x56567c18) at /usr/src/debug/dwarves-1.25/pahole.c:3100
>   #2  0xf7f452d7 in cu__finalize (cu=cu@entry=0xd9a01f80, conf=0x565640c0 <conf_load>, thr_data=thr_data@entry=0x56567c18)
>       at /usr/src/debug/dwarves-1.25/dwarf_loader.c:3001
>   #3  0xf7f4541d in cus__finalize (thr_data=0x56567c18, conf=<optimized out>, cu=0xd9a01f80, cus=0x565651c0) at /usr/src/debug/dwarves-1.25/dwarf_loader.c:3008
>   #4  dwarf_cus__create_and_process_cu (dcus=dcus@entry=0xffffd19c, cu_die=cu_die@entry=0xda5ff38c, pointer_size=<optimized out>, thr_data=0x56567c18)
>       at /usr/src/debug/dwarves-1.25/dwarf_loader.c:3207
>   #5  0xf7f461af in dwarf_cus__process_cu_thread (arg=0xffffcbf8) at /usr/src/debug/dwarves-1.25/dwarf_loader.c:3250
>   #6  0xf7db4258 in start_thread (arg=<optimized out>) at pthread_create.c:444
>   #7  0xf7e3a878 in clone3 () from /lib/libc.so.6
>   (gdb) p encoder
>   $1 = (struct btf_encoder *) 0x0
>   (gdb) f 1
>   #1  0x5655c25d in pahole_stealer (cu=0xd9a01f80, conf_load=0x565640c0 <conf_load>, thr_data=0x56567c18) at /usr/src/debug/dwarves-1.25/pahole.c:3100
>   3100                                    thread->btf = btf_encoder__btf(thread->encoder);
>   (gdb) list -2
>   3093                                    thread->encoder =
>   3094                                            btf_encoder__new(cu, detached_btf_filename,
>   3095                                                             NULL,
>   3096                                                             skip_encoding_btf_vars,
>   3097                                                             btf_encode_force,
>   3098                                                             btf_gen_floats,
>   3099                                                             global_verbose);
>   3100                                    thread->btf = btf_encoder__btf(thread->encoder);
>   3101                            }
>   3102                            encoder = thread->encoder;
> 
> I think that return value of btf_encoder__new is not checked. But did
> not investigate further why is this happening. It would be great to have
> this fixed.

Can you try with this minimal patch? Maybe we can with some more work
auto-limit the number of threads or make the threads without a
btf_encoder be processed at the end, reusing the main btf_encoder, but
this first patch would at least help diagnosing the problem more
quickly.

- Arnaldo

diff --git a/pahole.c b/pahole.c
index e843999fde2a8a37..887b3403dcff18c0 100644
--- a/pahole.c
+++ b/pahole.c
@@ -3097,6 +3097,15 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
 							 btf_encode_force,
 							 btf_gen_floats,
 							 global_verbose);
+				if (thread->encoder == NULL) {
+					fprintf(stderr, "Not enough memory to instantiate new BTF encoder.\n");
+
+					if (conf_load->nr_jobs > 1)
+						fprintf(stderr, "HINT: Maybe reduce the -j/--jobs command line value?.\n");
+
+					ret = LSK__STOP_LOADING;
+					goto out_btf;
+				}
 				thread->btf = btf_encoder__btf(thread->encoder);
 			}
 			encoder = thread->encoder;

