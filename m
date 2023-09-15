Return-Path: <bpf+bounces-10125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 063787A1384
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 04:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A59D0281A3A
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 02:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B817BA3C;
	Fri, 15 Sep 2023 02:02:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C350658
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 02:02:50 +0000 (UTC)
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id C559D1FE5;
	Thu, 14 Sep 2023 19:02:49 -0700 (PDT)
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 055AD72C8E4;
	Fri, 15 Sep 2023 05:02:49 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
	by imap.altlinux.org (Postfix) with ESMTPSA id ECCFE36D00B7;
	Fri, 15 Sep 2023 05:02:48 +0300 (MSK)
Date: Fri, 15 Sep 2023 05:02:48 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, dwarves@vger.kernel.org,
	bpf@vger.kernel.org
Cc: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: pahole 1.25 SIGSEGV when building kernel (-j when cores > 81)
Message-ID: <20230915020248.klgd2yjpe2mnphnk@altlinux.org>
References: <20230705020040.bqhtd3yxpntk44q5@altlinux.org>
 <ZKwK049Hg7taAxv9@kernel.org>
 <20230710200002.ca4okot5rrvewqvb@altlinux.org>
 <20230914033717.mbb2cn2rukndtvlw@altlinux.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20230914033717.mbb2cn2rukndtvlw@altlinux.org>

Arnaldo,

On Thu, Sep 14, 2023 at 06:37:17AM +0300, Vitaly Chikunov wrote:
> On Mon, Jul 10, 2023 at 11:00:02PM +0300, Vitaly Chikunov wrote:
> > On Mon, Jul 10, 2023 at 10:42:43AM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Wed, Jul 05, 2023 at 05:00:40AM +0300, Vitaly Chikunov escreveu:
> > > > 
> > > > After updating Dwarves to v1.25 we are getting SIGSEGV while building
> > > > kernel on 32-bit x86 architecture. It looks like this:
> > > 
> > > 128 cores, 32-bit system? Interesting :-)
> > 
> > This is just AMD Zen in 32-bit personality.
> 
> This started to reappear for v6.5 on armv7hf with 64 cores (Cortex-A72
> aarch64 which supports linux32 personality) even with your proposed
> patch. But with different error messages:
> 
>     BTF     .btf.vmlinux.bin.o
>   [24982] STRUCT super_block's field 's_bdev' offset=1120 bit_size=0 type=25296 Error emitting field
>   Encountered error while encoding BTF.
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
> With V=1:
> 
>   + info BTF .btf.vmlinux.bin.o
>   + printf '  %-7s %s\n' BTF .btf.vmlinux.bin.o
>     BTF     .btf.vmlinux.bin.o
>   + LLVM_OBJCOPY=objcopy
>   + pahole -J --btf_gen_floats -j --lang_exclude=rust --skip_encoding_btf_inconsistent_proto --btf_gen_optimized .tmp_vmlinux.btf
>   [26109] STRUCT kiocb's field 'ki_waitq' offset=256 bit_size=0 type=26179 Error emitting field
>   Encountered error while encoding BTF.
> 
> Restricting -j to 32 helped, though.

FYI. This tuned out to be more weird than that. Adding -j32 causes arm32
to not boot in qemu properly with BPF errors (which I did not investigate
further, log below), -j16 with timeouts, so I resorted to just removing
-j for 32-bit architectures from `scripts/pahole-flags.sh`.

Test boot after build with pahole -j32:

  [00:23:50] + timeout 300 vm-run uname -a
  [00:23:52] + time qemu-system-aarch64-bundle -M accel=kvm:tcg -m 3072 -smp cores=6 -serial mon:stdio -nodefaults -nographic -no-reboot -fsdev local,id=root,path=/,security_model=none,multidevs=remap -device virtio-9p-pci,fsdev=root,mount_tag=virtio-9p:/ -device virtio-rng-pci -kernel /usr/src/tmp/kernel-image-un-def-buildroot/boot/vmlinuz-6.5.3-un-def-alt1 -initrd /usr/src/tmp/initramfs-6.5.3-un-def-alt1.img -sandbox on,spawn=deny -M virt,highmem=off -cpu host,aarch64=off -append 'console=ttyAMA0 mitigations=off nokaslr quiet panic=-1 SCRIPT=/usr/src/tmp/vm.eKPHAvWlYq watchdog_thresh=60'
  [00:23:55] [    0.240771] BPF: 	 type_id=0 offset=2944 size=4864
  [00:23:55] [    0.242126] BPF:  
  [00:23:55] [    0.242681] BPF: Invalid type_id
  [00:23:55] [    0.243557] BPF: 
  [00:23:55] init_module 'netfs.ko' Invalid argument
  [00:23:55] init_module '9pnet.ko' Invalid argument
  [00:23:55] init_module 'virtio.ko' Invalid argument
  [00:23:55] init_module 'virtio_ring.ko' Invalid argument
  [00:23:56] init_module 'virtio_pci_modern_dev.ko' Invalid argument
  [00:23:56] init_module 'virtio_pci_legacy_dev.ko' Invalid argument
  [00:23:56] glob: 9p mount_tag not found (ret: 3): No such file or directory
  [00:23:56] rootfs not found.
  [00:23:57] [    2.000050] reboot: Power down

(qemu-system-aarch64-bundle is special qemu wrapper to run aarch64 qemu
on arm32 system - which actually is aarch64 with linux32 personality.)

Also in this build, there is 264 errors after `BTFIDS  vmlinux` like
this:

  [00:04:49] WARN: resolve_btfids: unresolved symbol udp6_sock
  [00:04:49] WARN: resolve_btfids: unresolved symbol reuseport_array
  [00:04:49] WARN: resolve_btfids: unresolved symbol bpf_ringbuf_map
  [00:04:49] WARN: resolve_btfids: unresolved symbol vfs_truncate
  [00:04:49] WARN: resolve_btfids: unresolved symbol tcp_slow_start
  [00:04:49] WARN: resolve_btfids: unresolved symbol tcp_reno_undo_cwnd
  [00:04:49] WARN: resolve_btfids: unresolved symbol tcp_reno_ssthresh
  [00:04:49] WARN: resolve_btfids: unresolved symbol tcp_reno_cong_avoid
  [00:04:49] WARN: resolve_btfids: unresolved symbol tcp_cong_avoid_ai
  [00:04:49] WARN: resolve_btfids: unresolved symbol should_failslab
  [00:04:49] WARN: resolve_btfids: unresolved symbol crash_kexec
  [00:04:49] WARN: resolve_btfids: unresolved symbol bpf_sock_destroy
  [00:04:49] WARN: resolve_btfids: unresolved symbol bpf_obj_new_impl
  [00:04:49] WARN: resolve_btfids: unresolved symbol bpf_lsm_xfrm_state_pol_flow_match
  [00:04:49] WARN: resolve_btfids: unresolved symbol bpf_lsm_xfrm_state_free_security
  ... &c.

With -j removed there is still errors like this but a lot less (7):

  [00:04:36] WARN: resolve_btfids: unresolved symbol vfs_truncate
  [00:04:36] WARN: resolve_btfids: unresolved symbol bpf_obj_new_impl
  [00:04:36] WARN: resolve_btfids: unresolved symbol bpf_lsm_path_notify
  [00:04:36] WARN: resolve_btfids: unresolved symbol bpf_lsm_kernel_post_load_data
  [00:04:36] WARN: resolve_btfids: unresolved symbol bpf_lookup_user_key
  [00:04:36] WARN: resolve_btfids: unresolved symbol bpf_dynptr_from_xdp
  [00:04:36] WARN: resolve_btfids: unresolved symbol bpf_dynptr_from_skb

(There are no such errors on the i586 build.)

Thanks,

> 
> Thanks,
> 
> 
> 
> > 
> > >  
> > > >     BTF     .btf.vmlinux.bin.o
> > > >   scripts/link-vmlinux.sh: line 111: 395728 Segmentation fault      LLVM_OBJCOPY="${OBJCOPY}" ${PAHOLE} -J ${PAHOLE_FLAGS} ${1}
> > > >     LD      .tmp_vmlinux.kallsyms1
> > > >     NM      .tmp_vmlinux.kallsyms1.syms
> > > >     KSYMS   .tmp_vmlinux.kallsyms1.S
> > > >     AS      .tmp_vmlinux.kallsyms1.S
> > > >     LD      .tmp_vmlinux.kallsyms2
> > > >     NM      .tmp_vmlinux.kallsyms2.syms
> > > >     KSYMS   .tmp_vmlinux.kallsyms2.S
> > > >     AS      .tmp_vmlinux.kallsyms2.S
> > > >     LD      vmlinux
> > > >     BTFIDS  vmlinux
> > > >   libbpf: failed to find '.BTF' ELF section in vmlinux
> > > >   FAILED: load BTF from vmlinux: No data available
> > > > 
> > > > What crashes is this command:
> > > > 
> > > >   pahole -J --btf_gen_floats -j --lang_exclude=rust .tmp_vmlinux.btf
> > > > 
> > > > I found that cause of the crash is that build box having 128 cores. By
> > > > experiment I found that with -j81 pahole works OK, but with -j82 or
> > > > greater it crashes.
> > > > 
> > > >   $ gdb -q --args pahole -J --btf_gen_floats -j111 --lang_exclude=rust .tmp_vmlinux.btf
> > > >   Thread 15 "pahole" received signal SIGSEGV, Segmentation fault.
> > > >   [Switching to Thread 0xda5ffb40 (LWP 3102466)]
> > > >   0xf7f3c944 in btf_encoder__btf (encoder=0x0) at /usr/src/debug/dwarves-1.25/btf_encoder.c:1890
> > > >   1890            return encoder->btf;
> > > >   (gdb) bt
> > > >   #0  0xf7f3c944 in btf_encoder__btf (encoder=0x0) at /usr/src/debug/dwarves-1.25/btf_encoder.c:1890
> > > >   #1  0x5655c25d in pahole_stealer (cu=0xd9a01f80, conf_load=0x565640c0 <conf_load>, thr_data=0x56567c18) at /usr/src/debug/dwarves-1.25/pahole.c:3100
> > > >   #2  0xf7f452d7 in cu__finalize (cu=cu@entry=0xd9a01f80, conf=0x565640c0 <conf_load>, thr_data=thr_data@entry=0x56567c18)
> > > >       at /usr/src/debug/dwarves-1.25/dwarf_loader.c:3001
> > > >   #3  0xf7f4541d in cus__finalize (thr_data=0x56567c18, conf=<optimized out>, cu=0xd9a01f80, cus=0x565651c0) at /usr/src/debug/dwarves-1.25/dwarf_loader.c:3008
> > > >   #4  dwarf_cus__create_and_process_cu (dcus=dcus@entry=0xffffd19c, cu_die=cu_die@entry=0xda5ff38c, pointer_size=<optimized out>, thr_data=0x56567c18)
> > > >       at /usr/src/debug/dwarves-1.25/dwarf_loader.c:3207
> > > >   #5  0xf7f461af in dwarf_cus__process_cu_thread (arg=0xffffcbf8) at /usr/src/debug/dwarves-1.25/dwarf_loader.c:3250
> > > >   #6  0xf7db4258 in start_thread (arg=<optimized out>) at pthread_create.c:444
> > > >   #7  0xf7e3a878 in clone3 () from /lib/libc.so.6
> > > >   (gdb) p encoder
> > > >   $1 = (struct btf_encoder *) 0x0
> > > >   (gdb) f 1
> > > >   #1  0x5655c25d in pahole_stealer (cu=0xd9a01f80, conf_load=0x565640c0 <conf_load>, thr_data=0x56567c18) at /usr/src/debug/dwarves-1.25/pahole.c:3100
> > > >   3100                                    thread->btf = btf_encoder__btf(thread->encoder);
> > > >   (gdb) list -2
> > > >   3093                                    thread->encoder =
> > > >   3094                                            btf_encoder__new(cu, detached_btf_filename,
> > > >   3095                                                             NULL,
> > > >   3096                                                             skip_encoding_btf_vars,
> > > >   3097                                                             btf_encode_force,
> > > >   3098                                                             btf_gen_floats,
> > > >   3099                                                             global_verbose);
> > > >   3100                                    thread->btf = btf_encoder__btf(thread->encoder);
> > > >   3101                            }
> > > >   3102                            encoder = thread->encoder;
> > > > 
> > > > I think that return value of btf_encoder__new is not checked. But did
> > > > not investigate further why is this happening. It would be great to have
> > > > this fixed.
> > > 
> > > Can you try with this minimal patch? Maybe we can with some more work
> > > auto-limit the number of threads or make the threads without a
> > > btf_encoder be processed at the end, reusing the main btf_encoder, but
> > > this first patch would at least help diagnosing the problem more
> > > quickly.
> > 
> > With this patch applied and run on 20 core:
> > 
> >   builder@i586:kernel-source-6.3$ pahole -J --btf_gen_floats -j111 --lang_exclude=rust .tmp_vmlinux.btf
> >   Not enough memory to instantiate new BTF encoder.
> >   HINT: Maybe reduce the -j/--jobs command line value?.
> >   ... 40 times this message ....
> >   Not enough memory to instantiate new BTF encoder.
> >   HINT: Maybe reduce the -j/--jobs command line value?.
> >   builder@i586:kernel-source-6.3$ echo $?
> >   0
> > 
> > Thanks,
> > 
> > > 
> > > - Arnaldo
> > > 
> > > diff --git a/pahole.c b/pahole.c
> > > index e843999fde2a8a37..887b3403dcff18c0 100644
> > > --- a/pahole.c
> > > +++ b/pahole.c
> > > @@ -3097,6 +3097,15 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
> > >  							 btf_encode_force,
> > >  							 btf_gen_floats,
> > >  							 global_verbose);
> > > +				if (thread->encoder == NULL) {
> > > +					fprintf(stderr, "Not enough memory to instantiate new BTF encoder.\n");
> > > +
> > > +					if (conf_load->nr_jobs > 1)
> > > +						fprintf(stderr, "HINT: Maybe reduce the -j/--jobs command line value?.\n");
> > > +
> > > +					ret = LSK__STOP_LOADING;
> > > +					goto out_btf;
> > > +				}
> > >  				thread->btf = btf_encoder__btf(thread->encoder);
> > >  			}
> > >  			encoder = thread->encoder;

