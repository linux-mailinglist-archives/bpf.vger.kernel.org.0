Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A655721A7
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 19:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiGLRWw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 13:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbiGLRWv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 13:22:51 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A746FB38E6
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 10:22:50 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id c18-20020a17090a8d1200b001ef85196fb4so7853605pjo.4
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 10:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9np7JlV187kB6fufVQ29K16WlSwRjClb8qUc0r9vt8o=;
        b=cOmIMdGBKCDIQyZ3Lc4T+vgv4Op6fxbBZuf8Tsr6Tyq8ZW9wzTOpy1XGcJMok+lBY6
         y06HD5koq8pTmUAkk9vfeUEj4Psw+LCwKmQbahNSKLEO7+NJ8GPhw4aNDhASMXPUGTW+
         5kRi5Et24vUDvEBvHh4I39mtb5VlTFcBNr1doesiDrCsQDDAw0bp4byF/Mpo93wHl4b6
         4oZ+h10zqjqgnkK+uFx98fC4I3i444zUnLFlvbQXby2YnGOICV9L2yLHlw+a7xL8ERPB
         gwqHLD2YNXom4tr88Yj9S2ElZjP8x8ms+5TrhPOUnbUp8n5gxNXMLM6AiT2o6jlq1pc3
         57rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9np7JlV187kB6fufVQ29K16WlSwRjClb8qUc0r9vt8o=;
        b=6+bzVt6rP19sNvr0Pdb6++g1zDnRSuPyNLFZjSe/TGCG1qOtSb3Ht5ofTCbzXzSaNL
         ksRF0NzQhFzZ25utPFHcWcuxCW5Nn1BijH2+zdrOeDiUIYFd/LKxyq9e3nDpb0KVYEPm
         /InyQRERfSw/LLpoBoiHPwrT1KD11dLb1dx7XAfpXoB+pjs0wvVQHLFKqq7ttqcsD6KJ
         2Bj3f3t4LiiF0S6+0VTBkSY6UvXoh+uuJy9LxPJFLZS63O9o2fF9RwieijrY9KiJZ9VW
         wq9homo+y9Y6bReINsoMQUaLfTiV6HMXlnrk7YkdlSlceq/6fQAWSEUSwHMlTARUjKna
         ADmA==
X-Gm-Message-State: AJIora9JBHyyqWps7UyJK3PATEj1rqZXfxbuz5jQyLoRhurDtK50QMBi
        Y+Z220kBOKy7rKzRydaprh71DRI=
X-Google-Smtp-Source: AGRyM1uIYUFSRvc2259nfFO0LGdYdtB1QP9AZgFb0lTNnAK2I3OjTOfd4ghPSaOwHzK6hTwJrp6S+VY=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90b:4d05:b0:1e2:bf91:8af2 with SMTP id
 mw5-20020a17090b4d0500b001e2bf918af2mr5677578pjb.210.1657646570230; Tue, 12
 Jul 2022 10:22:50 -0700 (PDT)
Date:   Tue, 12 Jul 2022 10:22:48 -0700
In-Reply-To: <BN6PR11MB16332A018C2FAB69B479EA2B92869@BN6PR11MB1633.namprd11.prod.outlook.com>
Message-Id: <Ys2tkthkFE1XkEPh@google.com>
Mime-Version: 1.0
References: <BN6PR11MB16338E9998353C6B239CD27792869@BN6PR11MB1633.namprd11.prod.outlook.com>
 <BN6PR11MB16332A018C2FAB69B479EA2B92869@BN6PR11MB1633.namprd11.prod.outlook.com>
Subject: Re: Build error of samples/bpf
From:   sdf@google.com
To:     oak.zeng@intel.com
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 07/12, Zeng, Oak wrote:
> Hello all,

> I tried to build the latest samples/bpf following instructions in the  
> README.rst in samples/bpf folder. I ran into various issue such as:

> samples/bpf/Makefile:375: *** Cannot find a vmlinux for VMLINUX_BTF at  
> any of "  /home/szeng/dii-tools/linux/vmlinux", build the kernel or set  
> VMLINUX_BTF or VMLINUX_H variable

> I was able to fix above issue by enable CONFIG_DEBUG_INFO_BTF in  
> kernel .config file.

> But I eventually ran into other errors.  I had to fix those errors by  
> install dwarves, updating my clang/llvm to version 10.

> I was able to build it if I comment out all the xdp programs from  
> Makefile. It seems those xdp programs require advanced features such as  
> data structure layout in vmlinux.h (dumped from vmlinux using bpftool)  
> and this require special kernel config support.

> So I thought instead of fixing those errors one by one, I should ask  
> those who are working in this area, is there any instructions on how to  
> build samples/bpf? The README.rst seems out-of-date, for example, it  
> doesn't mention CONFIG_DEBUG_INFO_BTF. The required llvm/clang version in  
> README.rst is also out-of-date.

> More specifically, to build samples/bpf, is there an example  
> kernel .config to use? I tried those config here  
> https://github.com/torvalds/linux/blob/master/tools/testing/selftests/bpf/config  
> but build errors persist.

> Or is there any other tools I need to install/update on my system?

In general, I'd say, samples/bpf tend to go stale. We mostly work on
the selftests and don't pay too much attention to the samples :-(
Ideally, the samples should be part of selftests so they get
exercised by the CI.

One thing I can suggest is to look at tools/testing/selftests/bpf/vmtest.sh
script. It builds the kernels with vetted configs capable of running
selftests. That should be, in theory, be enough to compile the samples.

> My whole build log is as below:

> szeng@linux:~/dii-tools/linux$ make M=samples/bpf
> readelf: Error: Missing knowledge of 32-bit reloc types used in DWARF  
> sections of machine number 247
> readelf: Warning: unable to apply unsupported reloc type 10 to  
> section .debug_info
> readelf: Warning: unable to apply unsupported reloc type 1 to  
> section .debug_info
> readelf: Warning: unable to apply unsupported reloc type 10 to  
> section .debug_info make -C  
> /home/szeng/dii-tools/linux/samples/bpf/../../tools/lib/bpf RM='rm -rf'  
> EXTRA_CFLAGS="-Wall -O2 -Wmissing-prototypes -Wstrict-prototypes  
> -I./usr/include -I./tools/testing/selftests/bpf/  
> -I/home/szeng/dii-tools/linux/samples/bpf/libbpf/include  
> -I./tools/include -I./tools/perf -DHAVE_ATTR_TEST=0" \
>          LDFLAGS= srctree=/home/szeng/dii-tools/linux/samples/bpf/../../ \
>          O= OUTPUT=/home/szeng/dii-tools/linux/samples/bpf/libbpf/  
> DESTDIR=/home/szeng/dii-tools/linux/samples/bpf/libbpf prefix= \
>          /home/szeng/dii-tools/linux/samples/bpf/libbpf/libbpf.a  
> install_headers
>    CC       
> /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/libbpf.o
>    CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/bpf.o
>    CC       
> /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/nlattr.o
>    CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/btf.o
>    CC       
> /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/libbpf_errno.o
>    CC       
> /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/str_error.o
>    CC       
> /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/netlink.o
>    CC       
> /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/bpf_prog_linfo.o
>    CC       
> /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/libbpf_probes.o
>    CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/xsk.o
>    CC       
> /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/hashmap.o
>    CC       
> /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/btf_dump.o
>    CC       
> /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/ringbuf.o
>    CC       
> /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/strset.o
>    CC       
> /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/linker.o
>    CC       
> /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/gen_loader.o
>    CC       
> /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/relo_core.o
>    LD       
> /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/libbpf-in.o
>    LINK    /home/szeng/dii-tools/linux/samples/bpf/libbpf/libbpf.a
>    INSTALL headers
>    CC  samples/bpf/test_lru_dist
>    CC  samples/bpf/sock_example
>    CC  samples/bpf/../../tools/testing/selftests/bpf/cgroup_helpers.o
>    CC  samples/bpf/../../tools/testing/selftests/bpf/trace_helpers.o
>    CC  samples/bpf/cookie_uid_helper_example.o
>    CC  samples/bpf/cpustat_user.o
>    CC  samples/bpf/fds_example.o
>    CC  samples/bpf/hbm.o
>    CC  samples/bpf/i915_latency_hist_user.o
>    CC  samples/bpf/i915_stat_user.o
>    CC  samples/bpf/ibumad_user.o
>    CC  samples/bpf/lathist_user.o
>    CC  samples/bpf/lwt_len_hist_user.o
>    CC  samples/bpf/map_perf_test_user.o
>    CC  samples/bpf/offwaketime_user.o
>    CC  samples/bpf/sampleip_user.o
>    CC  samples/bpf/sockex1_user.o
>    CC  samples/bpf/sockex2_user.o
>    CC  samples/bpf/sockex3_user.o
>    CC  samples/bpf/spintest_user.o
>    CC  samples/bpf/syscall_tp_user.o
>    CC  samples/bpf/task_fd_query_user.o
>    CC  samples/bpf/tc_l2_redirect_user.o
>    CC  samples/bpf/test_cgrp2_array_pin.o
>    CC  samples/bpf/test_cgrp2_attach.o
>    CC  samples/bpf/test_cgrp2_sock.o
>    CC  samples/bpf/test_cgrp2_sock2.o
>    CC  samples/bpf/test_current_task_under_cgroup_user.o
>    CC  samples/bpf/test_map_in_map_user.o
>    CC  samples/bpf/test_overhead_user.o
>    CC  samples/bpf/test_probe_write_user_user.o
>    CC  samples/bpf/trace_event_user.o
>    CC  samples/bpf/trace_output_user.o
>    CC  samples/bpf/tracex1_user.o
>    CC  samples/bpf/tracex2_user.o
>    CC  samples/bpf/tracex3_user.o
>    CC  samples/bpf/tracex4_user.o
>    CC  samples/bpf/tracex5_user.o
>    CC  samples/bpf/tracex6_user.o
>    CC  samples/bpf/tracex7_user.o
>    CC  samples/bpf/xdp1_user.o
>    CC  samples/bpf/xdp_adjust_tail_user.o
>    CC  samples/bpf/xdp_fwd_user.o
> make -C /home/szeng/dii-tools/linux/samples/bpf/../../tools/bpf/bpftool  
> srctree=/home/szeng/dii-tools/linux/samples/bpf/../../ \
>          OUTPUT=/home/szeng/dii-tools/linux/samples/bpf/bpftool/ \
>          LIBBPF_OUTPUT=/home/szeng/dii-tools/linux/samples/bpf/libbpf/ \
>          LIBBPF_DESTDIR=/home/szeng/dii-tools/linux/samples/bpf/libbpf/

> Auto-detecting system features:
> ...                        libbfd: [ OFF ]
> ...        disassembler-four-args: [ OFF ]
> ...                          zlib: [ on  ]
> ...                        libcap: [ OFF ]
> ...               clang-bpf-co-re: [ on  ]


>    CC       
> /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/libbpf.o
>    CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/bpf.o
>    CC       
> /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/nlattr.o
>    CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/btf.o
>    CC       
> /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/libbpf_errno.o
>    CC       
> /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/str_error.o
>    CC       
> /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/netlink.o
>    CC       
> /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/bpf_prog_linfo.o
>    CC       
> /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/libbpf_probes.o
>    CC      /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/xsk.o
>    CC       
> /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/hashmap.o
>    CC       
> /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/btf_dump.o
>    CC       
> /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/ringbuf.o
>    CC       
> /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/strset.o
>    CC       
> /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/linker.o
>    CC       
> /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/gen_loader.o
>    CC       
> /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/relo_core.o
>    LD       
> /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/libbpf-in.o
>    LINK    /home/szeng/dii-tools/linux/samples/bpf/libbpf/libbpf.a
>    CLANG   /home/szeng/dii-tools/linux/samples/bpf/bpftool/profiler.bpf.o
>    GEN     /home/szeng/dii-tools/linux/samples/bpf/bpftool/profiler.skel.h
>    CC      /home/szeng/dii-tools/linux/samples/bpf/bpftool/prog.o
>    CLANG   /home/szeng/dii-tools/linux/samples/bpf/bpftool/pid_iter.bpf.o
>    GEN     /home/szeng/dii-tools/linux/samples/bpf/bpftool/pid_iter.skel.h
>    CC      /home/szeng/dii-tools/linux/samples/bpf/bpftool/pids.o
>    LINK    /home/szeng/dii-tools/linux/samples/bpf/bpftool/bpftool
>    CC  samples/bpf/xdp_router_ipv4_user.o
>    CC  samples/bpf/xdp_rxq_info_user.o
>    CC  samples/bpf/xdp_sample_pkts_user.o
>    CC  samples/bpf/xdp_tx_iptunnel_user.o
>    CC  samples/bpf/xdpsock_ctrl_proc.o
>    CC  samples/bpf/xsk_fwd.o
>    CLANG-BPF  samples/bpf/xdp_sample.bpf.o
>    CLANG-BPF  samples/bpf/xdp_redirect_map_multi.bpf.o
>    CLANG-BPF  samples/bpf/xdp_redirect_cpu.bpf.o
>    CLANG-BPF  samples/bpf/xdp_redirect_map.bpf.o
>    CLANG-BPF  samples/bpf/xdp_monitor.bpf.o
>    CLANG-BPF  samples/bpf/xdp_redirect.bpf.o
>    BPF GEN-OBJ  samples/bpf/xdp_monitor
>    BPF GEN-SKEL samples/bpf/xdp_monitor
> libbpf: map 'rx_cnt': unexpected def kind var.
> Error: failed to open BPF object file: Invalid argument
> samples/bpf/Makefile:430: recipe for  
> target 'samples/bpf/xdp_monitor.skel.h' failed
> make[1]: *** [samples/bpf/xdp_monitor.skel.h] Error 255
> make[1]: *** Deleting file 'samples/bpf/xdp_monitor.skel.h'
> Makefile:1868: recipe for target 'samples/bpf' failed
> make: *** [samples/bpf] Error 2


> Thanks,
> Oak

