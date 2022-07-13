Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443DD573C73
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 20:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiGMSVw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 14:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiGMSVu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 14:21:50 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54332CE20
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 11:21:49 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id p128so11673721iof.1
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 11:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=q9fnYJ2pkJELBXswPOvOB9FxyFIr3ItEdw2BYNFUHCs=;
        b=iaqWwmm1KGt30PHpqK7pFJZq7G00vdE0au5hBsMVssJeVzN5zAKt1xomZbVFC4uNpv
         kZjX8Pqf4gHRRB0Bo/7Ent8z8jBdQLJ+MvhJxzOT0/GkGRFoHhCm2zTRzfaSwSNoVleF
         l+JSCYzLARL24w7gDOryFX09lzdGCwCOuLdyKzHUW3FEKxQ/549svDVqi7fnQCIC3Ibi
         B5Hdk2jaB081gahkSdNES4UqcK5nngPvncCHksjJuV724wM7/Vcaii+e6yiVINv+KV8r
         dXhh/pHLcyAJVMZem92eW3E/Vs8wEbu9P5Kr+cyM7cIRTNwGsngJVFGHwZIzqJ+ITAYe
         f94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q9fnYJ2pkJELBXswPOvOB9FxyFIr3ItEdw2BYNFUHCs=;
        b=uVp9itREC9ETY7MmcKoYb3riE8ZyR4YCmCaxytoFr3Av9YoRzmCeGEA34RjoplNgij
         NmwcDHL8Pzpx+Uk6JCEHLxu6vm3HkjhvCip0TZhrkfEG6DYWQUuJw3suc3BsivFiOYL+
         YdNJgbyREBuIA0Q5fCkMKLUhqZA3n7Vubcoet32sieXLx9vBgF167/RxpRBhyjrZWFdT
         pYvp66WFx2QCJjGMXtRCrrSwY7b1HYGd498seX0uz5HAu6GuD9BzlMVsSxgbpZlaGJUi
         MRukgPB/jMeVc5CDszAKaEM4oV2BqdRalWfpI40wLgFRT4USfl1WQvxyXWtgZOp2K+Hm
         GXQg==
X-Gm-Message-State: AJIora81JOToyyH2V1hiSwfhBMT7EFO67yDU/HZf7N64eEtjaHtdcCKB
        vFNAN6iPWSzqAzDIBD+mtI8vs0KKrhtFDs8tp+Y=
X-Google-Smtp-Source: AGRyM1ufkGi6p29p9qgnDKH9gLyg1JWFmSTYuuSqXFVHBoF9FnM+Y5ecjBlWMnZmBgCHaok3VFzF5yeeiXiFK67ppwM=
X-Received: by 2002:a05:6602:2e8d:b0:64f:b683:c70d with SMTP id
 m13-20020a0566022e8d00b0064fb683c70dmr2359410iow.62.1657736508993; Wed, 13
 Jul 2022 11:21:48 -0700 (PDT)
MIME-Version: 1.0
References: <BN6PR11MB16338E9998353C6B239CD27792869@BN6PR11MB1633.namprd11.prod.outlook.com>
 <BN6PR11MB16332A018C2FAB69B479EA2B92869@BN6PR11MB1633.namprd11.prod.outlook.com>
In-Reply-To: <BN6PR11MB16332A018C2FAB69B479EA2B92869@BN6PR11MB1633.namprd11.prod.outlook.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Wed, 13 Jul 2022 20:21:04 +0200
Message-ID: <CAP01T77ZDk8kHGhAy4V1tht0JHqefkmKLdKtKPHj1mJ_shDMhQ@mail.gmail.com>
Subject: Re: Build error of samples/bpf
To:     "Zeng, Oak" <oak.zeng@intel.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 12 Jul 2022 at 16:10, Zeng, Oak <oak.zeng@intel.com> wrote:
>
> Hello all,
>
> I tried to build the latest samples/bpf following instructions in the REA=
DME.rst in samples/bpf folder. I ran into various issue such as:
>
> samples/bpf/Makefile:375: *** Cannot find a vmlinux for VMLINUX_BTF at an=
y of "  /home/szeng/dii-tools/linux/vmlinux", build the kernel or set VMLIN=
UX_BTF or VMLINUX_H variable
>
> I was able to fix above issue by enable CONFIG_DEBUG_INFO_BTF in kernel .=
config file.
>
> But I eventually ran into other errors.  I had to fix those errors by ins=
tall dwarves, updating my clang/llvm to version 10.
>
> I was able to build it if I comment out all the xdp programs from Makefil=
e. It seems those xdp programs require advanced features such as data struc=
ture layout in vmlinux.h (dumped from vmlinux using bpftool) and this requi=
re special kernel config support.
>
> So I thought instead of fixing those errors one by one, I should ask thos=
e who are working in this area, is there any instructions on how to build s=
amples/bpf? The README.rst seems out-of-date, for example, it doesn't menti=
on CONFIG_DEBUG_INFO_BTF. The required llvm/clang version in README.rst is =
also out-of-date.
>
> More specifically, to build samples/bpf, is there an example kernel .conf=
ig to use? I tried those config here https://github.com/torvalds/linux/blob=
/master/tools/testing/selftests/bpf/config but build errors persist.
>
> Or is there any other tools I need to install/update on my system?
>
> My whole build log is as below:
>
> szeng@linux:~/dii-tools/linux$ make M=3Dsamples/bpf
> readelf: Error: Missing knowledge of 32-bit reloc types used in DWARF sec=
tions of machine number 247
> readelf: Warning: unable to apply unsupported reloc type 10 to section .d=
ebug_info
> readelf: Warning: unable to apply unsupported reloc type 1 to section .de=
bug_info
> readelf: Warning: unable to apply unsupported reloc type 10 to section .d=
ebug_info make -C /home/szeng/dii-tools/linux/samples/bpf/../../tools/lib/b=
pf RM=3D'rm -rf' EXTRA_CFLAGS=3D"-Wall -O2 -Wmissing-prototypes -Wstrict-pr=
ototypes -I./usr/include -I./tools/testing/selftests/bpf/ -I/home/szeng/dii=
-tools/linux/samples/bpf/libbpf/include -I./tools/include -I./tools/perf -D=
HAVE_ATTR_TEST=3D0" \
>         LDFLAGS=3D srctree=3D/home/szeng/dii-tools/linux/samples/bpf/../.=
./ \
>         O=3D OUTPUT=3D/home/szeng/dii-tools/linux/samples/bpf/libbpf/ DES=
TDIR=3D/home/szeng/dii-tools/linux/samples/bpf/libbpf prefix=3D \
>         /home/szeng/dii-tools/linux/samples/bpf/libbpf/libbpf.a install_h=
eaders
>   CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/libbp=
f.o
>   CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/bpf.o
>   CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/nlatt=
r.o
>   CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/btf.o
>   CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/libbp=
f_errno.o
>   CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/str_e=
rror.o
>   CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/netli=
nk.o
>   CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/bpf_p=
rog_linfo.o
>   CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/libbp=
f_probes.o
>   CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/xsk.o
>   CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/hashm=
ap.o
>   CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/btf_d=
ump.o
>   CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/ringb=
uf.o
>   CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/strse=
t.o
>   CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/linke=
r.o
>   CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/gen_l=
oader.o
>   CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/relo_=
core.o
>   LD      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/libbp=
f-in.o
>   LINK    /home/szeng/dii-tools/linux/samples/bpf/libbpf/libbpf.a
>   INSTALL headers
>   CC  samples/bpf/test_lru_dist
>   CC  samples/bpf/sock_example
>   CC  samples/bpf/../../tools/testing/selftests/bpf/cgroup_helpers.o
>   CC  samples/bpf/../../tools/testing/selftests/bpf/trace_helpers.o
>   CC  samples/bpf/cookie_uid_helper_example.o
>   CC  samples/bpf/cpustat_user.o
>   CC  samples/bpf/fds_example.o
>   CC  samples/bpf/hbm.o
>   CC  samples/bpf/i915_latency_hist_user.o
>   CC  samples/bpf/i915_stat_user.o
>   CC  samples/bpf/ibumad_user.o
>   CC  samples/bpf/lathist_user.o
>   CC  samples/bpf/lwt_len_hist_user.o
>   CC  samples/bpf/map_perf_test_user.o
>   CC  samples/bpf/offwaketime_user.o
>   CC  samples/bpf/sampleip_user.o
>   CC  samples/bpf/sockex1_user.o
>   CC  samples/bpf/sockex2_user.o
>   CC  samples/bpf/sockex3_user.o
>   CC  samples/bpf/spintest_user.o
>   CC  samples/bpf/syscall_tp_user.o
>   CC  samples/bpf/task_fd_query_user.o
>   CC  samples/bpf/tc_l2_redirect_user.o
>   CC  samples/bpf/test_cgrp2_array_pin.o
>   CC  samples/bpf/test_cgrp2_attach.o
>   CC  samples/bpf/test_cgrp2_sock.o
>   CC  samples/bpf/test_cgrp2_sock2.o
>   CC  samples/bpf/test_current_task_under_cgroup_user.o
>   CC  samples/bpf/test_map_in_map_user.o
>   CC  samples/bpf/test_overhead_user.o
>   CC  samples/bpf/test_probe_write_user_user.o
>   CC  samples/bpf/trace_event_user.o
>   CC  samples/bpf/trace_output_user.o
>   CC  samples/bpf/tracex1_user.o
>   CC  samples/bpf/tracex2_user.o
>   CC  samples/bpf/tracex3_user.o
>   CC  samples/bpf/tracex4_user.o
>   CC  samples/bpf/tracex5_user.o
>   CC  samples/bpf/tracex6_user.o
>   CC  samples/bpf/tracex7_user.o
>   CC  samples/bpf/xdp1_user.o
>   CC  samples/bpf/xdp_adjust_tail_user.o
>   CC  samples/bpf/xdp_fwd_user.o
> make -C /home/szeng/dii-tools/linux/samples/bpf/../../tools/bpf/bpftool s=
rctree=3D/home/szeng/dii-tools/linux/samples/bpf/../../ \
>         OUTPUT=3D/home/szeng/dii-tools/linux/samples/bpf/bpftool/ \
>         LIBBPF_OUTPUT=3D/home/szeng/dii-tools/linux/samples/bpf/libbpf/ \
>         LIBBPF_DESTDIR=3D/home/szeng/dii-tools/linux/samples/bpf/libbpf/
>
> Auto-detecting system features:
> ...                        libbfd: [ OFF ]
> ...        disassembler-four-args: [ OFF ]
> ...                          zlib: [ on  ]
> ...                        libcap: [ OFF ]
> ...               clang-bpf-co-re: [ on  ]
>
>
>   CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/libbp=
f.o
>   CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/bpf.o
>   CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/nlatt=
r.o
>   CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/btf.o
>   CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/libbp=
f_errno.o
>   CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/str_e=
rror.o
>   CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/netli=
nk.o
>   CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/bpf_p=
rog_linfo.o
>   CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/libbp=
f_probes.o
>   CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/xsk.o
>   CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/hashm=
ap.o
>   CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/btf_d=
ump.o
>   CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/ringb=
uf.o
>   CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/strse=
t.o
>   CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/linke=
r.o
>   CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/gen_l=
oader.o
>   CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/relo_=
core.o
>   LD      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/libbp=
f-in.o
>   LINK    /home/szeng/dii-tools/linux/samples/bpf/libbpf/libbpf.a
>   CLANG   /home/szeng/dii-tools/linux/samples/bpf/bpftool/profiler.bpf.o
>   GEN     /home/szeng/dii-tools/linux/samples/bpf/bpftool/profiler.skel.h
>   CC      /home/szeng/dii-tools/linux/samples/bpf/bpftool/prog.o
>   CLANG   /home/szeng/dii-tools/linux/samples/bpf/bpftool/pid_iter.bpf.o
>   GEN     /home/szeng/dii-tools/linux/samples/bpf/bpftool/pid_iter.skel.h
>   CC      /home/szeng/dii-tools/linux/samples/bpf/bpftool/pids.o
>   LINK    /home/szeng/dii-tools/linux/samples/bpf/bpftool/bpftool
>   CC  samples/bpf/xdp_router_ipv4_user.o
>   CC  samples/bpf/xdp_rxq_info_user.o
>   CC  samples/bpf/xdp_sample_pkts_user.o
>   CC  samples/bpf/xdp_tx_iptunnel_user.o
>   CC  samples/bpf/xdpsock_ctrl_proc.o
>   CC  samples/bpf/xsk_fwd.o
>   CLANG-BPF  samples/bpf/xdp_sample.bpf.o
>   CLANG-BPF  samples/bpf/xdp_redirect_map_multi.bpf.o
>   CLANG-BPF  samples/bpf/xdp_redirect_cpu.bpf.o
>   CLANG-BPF  samples/bpf/xdp_redirect_map.bpf.o
>   CLANG-BPF  samples/bpf/xdp_monitor.bpf.o
>   CLANG-BPF  samples/bpf/xdp_redirect.bpf.o
>   BPF GEN-OBJ  samples/bpf/xdp_monitor
>   BPF GEN-SKEL samples/bpf/xdp_monitor
> libbpf: map 'rx_cnt': unexpected def kind var.

IIRC, this error is due to older clang. Can you try with a newer clang
(11 and above)?

> Error: failed to open BPF object file: Invalid argument
> samples/bpf/Makefile:430: recipe for target 'samples/bpf/xdp_monitor.skel=
.h' failed
> make[1]: *** [samples/bpf/xdp_monitor.skel.h] Error 255
> make[1]: *** Deleting file 'samples/bpf/xdp_monitor.skel.h'
> Makefile:1868: recipe for target 'samples/bpf' failed
> make: *** [samples/bpf] Error 2
>
>
> Thanks,
> Oak
>
