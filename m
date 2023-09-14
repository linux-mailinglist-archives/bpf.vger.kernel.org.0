Return-Path: <bpf+bounces-9972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F7379F8FC
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 05:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DB1B1F218C8
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 03:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7DF111D;
	Thu, 14 Sep 2023 03:44:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B107F
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 03:44:16 +0000 (UTC)
X-Greylist: delayed 416 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Sep 2023 20:44:15 PDT
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26869193;
	Wed, 13 Sep 2023 20:44:15 -0700 (PDT)
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 69B0472C8D3;
	Thu, 14 Sep 2023 06:37:17 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
	by imap.altlinux.org (Postfix) with ESMTPSA id 5BC0A36D00B7;
	Thu, 14 Sep 2023 06:37:17 +0300 (MSK)
Date: Thu, 14 Sep 2023 06:37:17 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, dwarves@vger.kernel.org,
	bpf@vger.kernel.org
Cc: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: pahole 1.25 SIGSEGV when building kernel (-j when cores > 81)
Message-ID: <20230914033717.mbb2cn2rukndtvlw@altlinux.org>
References: <20230705020040.bqhtd3yxpntk44q5@altlinux.org>
 <ZKwK049Hg7taAxv9@kernel.org>
 <20230710200002.ca4okot5rrvewqvb@altlinux.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20230710200002.ca4okot5rrvewqvb@altlinux.org>

Arnaldo,

On Mon, Jul 10, 2023 at 11:00:02PM +0300, Vitaly Chikunov wrote:
> On Mon, Jul 10, 2023 at 10:42:43AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Jul 05, 2023 at 05:00:40AM +0300, Vitaly Chikunov escreveu:
> > > 
> > > After updating Dwarves to v1.25 we are getting SIGSEGV while building
> > > kernel on 32-bit x86 architecture. It looks like this:
> > 
> > 128 cores, 32-bit system? Interesting :-)
> 
> This is just AMD Zen in 32-bit personality.

This started to reappear for v6.5 on armv7hf with 64 cores (Cortex-A72
aarch64 which supports linux32 personality) even with your proposed
patch. But with different error messages:

    BTF     .btf.vmlinux.bin.o
  [24982] STRUCT super_block's field 's_bdev' offset=1120 bit_size=0 type=25296 Error emitting field
  Encountered error while encoding BTF.
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

With V=1:

  + info BTF .btf.vmlinux.bin.o
  + printf '  %-7s %s\n' BTF .btf.vmlinux.bin.o
    BTF     .btf.vmlinux.bin.o
  + LLVM_OBJCOPY=objcopy
  + pahole -J --btf_gen_floats -j --lang_exclude=rust --skip_encoding_btf_inconsistent_proto --btf_gen_optimized .tmp_vmlinux.btf
  [26109] STRUCT kiocb's field 'ki_waitq' offset=256 bit_size=0 type=26179 Error emitting field
  Encountered error while encoding BTF.

Restricting -j to 32 helped, though.

Thanks,



> 
> >  
> > >     BTF     .btf.vmlinux.bin.o
> > >   scripts/link-vmlinux.sh: line 111: 395728 Segmentation fault      LLVM_OBJCOPY="${OBJCOPY}" ${PAHOLE} -J ${PAHOLE_FLAGS} ${1}
> > >     LD      .tmp_vmlinux.kallsyms1
> > >     NM      .tmp_vmlinux.kallsyms1.syms
> > >     KSYMS   .tmp_vmlinux.kallsyms1.S
> > >     AS      .tmp_vmlinux.kallsyms1.S
> > >     LD      .tmp_vmlinux.kallsyms2
> > >     NM      .tmp_vmlinux.kallsyms2.syms
> > >     KSYMS   .tmp_vmlinux.kallsyms2.S
> > >     AS      .tmp_vmlinux.kallsyms2.S
> > >     LD      vmlinux
> > >     BTFIDS  vmlinux
> > >   libbpf: failed to find '.BTF' ELF section in vmlinux
> > >   FAILED: load BTF from vmlinux: No data available
> > > 
> > > What crashes is this command:
> > > 
> > >   pahole -J --btf_gen_floats -j --lang_exclude=rust .tmp_vmlinux.btf
> > > 
> > > I found that cause of the crash is that build box having 128 cores. By
> > > experiment I found that with -j81 pahole works OK, but with -j82 or
> > > greater it crashes.
> > > 
> > >   $ gdb -q --args pahole -J --btf_gen_floats -j111 --lang_exclude=rust .tmp_vmlinux.btf
> > >   Thread 15 "pahole" received signal SIGSEGV, Segmentation fault.
> > >   [Switching to Thread 0xda5ffb40 (LWP 3102466)]
> > >   0xf7f3c944 in btf_encoder__btf (encoder=0x0) at /usr/src/debug/dwarves-1.25/btf_encoder.c:1890
> > >   1890            return encoder->btf;
> > >   (gdb) bt
> > >   #0  0xf7f3c944 in btf_encoder__btf (encoder=0x0) at /usr/src/debug/dwarves-1.25/btf_encoder.c:1890
> > >   #1  0x5655c25d in pahole_stealer (cu=0xd9a01f80, conf_load=0x565640c0 <conf_load>, thr_data=0x56567c18) at /usr/src/debug/dwarves-1.25/pahole.c:3100
> > >   #2  0xf7f452d7 in cu__finalize (cu=cu@entry=0xd9a01f80, conf=0x565640c0 <conf_load>, thr_data=thr_data@entry=0x56567c18)
> > >       at /usr/src/debug/dwarves-1.25/dwarf_loader.c:3001
> > >   #3  0xf7f4541d in cus__finalize (thr_data=0x56567c18, conf=<optimized out>, cu=0xd9a01f80, cus=0x565651c0) at /usr/src/debug/dwarves-1.25/dwarf_loader.c:3008
> > >   #4  dwarf_cus__create_and_process_cu (dcus=dcus@entry=0xffffd19c, cu_die=cu_die@entry=0xda5ff38c, pointer_size=<optimized out>, thr_data=0x56567c18)
> > >       at /usr/src/debug/dwarves-1.25/dwarf_loader.c:3207
> > >   #5  0xf7f461af in dwarf_cus__process_cu_thread (arg=0xffffcbf8) at /usr/src/debug/dwarves-1.25/dwarf_loader.c:3250
> > >   #6  0xf7db4258 in start_thread (arg=<optimized out>) at pthread_create.c:444
> > >   #7  0xf7e3a878 in clone3 () from /lib/libc.so.6
> > >   (gdb) p encoder
> > >   $1 = (struct btf_encoder *) 0x0
> > >   (gdb) f 1
> > >   #1  0x5655c25d in pahole_stealer (cu=0xd9a01f80, conf_load=0x565640c0 <conf_load>, thr_data=0x56567c18) at /usr/src/debug/dwarves-1.25/pahole.c:3100
> > >   3100                                    thread->btf = btf_encoder__btf(thread->encoder);
> > >   (gdb) list -2
> > >   3093                                    thread->encoder =
> > >   3094                                            btf_encoder__new(cu, detached_btf_filename,
> > >   3095                                                             NULL,
> > >   3096                                                             skip_encoding_btf_vars,
> > >   3097                                                             btf_encode_force,
> > >   3098                                                             btf_gen_floats,
> > >   3099                                                             global_verbose);
> > >   3100                                    thread->btf = btf_encoder__btf(thread->encoder);
> > >   3101                            }
> > >   3102                            encoder = thread->encoder;
> > > 
> > > I think that return value of btf_encoder__new is not checked. But did
> > > not investigate further why is this happening. It would be great to have
> > > this fixed.
> > 
> > Can you try with this minimal patch? Maybe we can with some more work
> > auto-limit the number of threads or make the threads without a
> > btf_encoder be processed at the end, reusing the main btf_encoder, but
> > this first patch would at least help diagnosing the problem more
> > quickly.
> 
> With this patch applied and run on 20 core:
> 
>   builder@i586:kernel-source-6.3$ pahole -J --btf_gen_floats -j111 --lang_exclude=rust .tmp_vmlinux.btf
>   Not enough memory to instantiate new BTF encoder.
>   HINT: Maybe reduce the -j/--jobs command line value?.
>   ... 40 times this message ....
>   Not enough memory to instantiate new BTF encoder.
>   HINT: Maybe reduce the -j/--jobs command line value?.
>   builder@i586:kernel-source-6.3$ echo $?
>   0
> 
> Thanks,
> 
> > 
> > - Arnaldo
> > 
> > diff --git a/pahole.c b/pahole.c
> > index e843999fde2a8a37..887b3403dcff18c0 100644
> > --- a/pahole.c
> > +++ b/pahole.c
> > @@ -3097,6 +3097,15 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
> >  							 btf_encode_force,
> >  							 btf_gen_floats,
> >  							 global_verbose);
> > +				if (thread->encoder == NULL) {
> > +					fprintf(stderr, "Not enough memory to instantiate new BTF encoder.\n");
> > +
> > +					if (conf_load->nr_jobs > 1)
> > +						fprintf(stderr, "HINT: Maybe reduce the -j/--jobs command line value?.\n");
> > +
> > +					ret = LSK__STOP_LOADING;
> > +					goto out_btf;
> > +				}
> >  				thread->btf = btf_encoder__btf(thread->encoder);
> >  			}
> >  			encoder = thread->encoder;

