Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671BD573AFF
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 18:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiGMQSu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 12:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236343AbiGMQSs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 12:18:48 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F32664F8
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 09:18:45 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id i21-20020aa79095000000b00528bd947f66so4242880pfa.18
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 09:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=san/Jx3q1O+/ULGAUeR8Q5oIYpoEgwqxUfWHCS0X8Gk=;
        b=QvFajQV/IwNw3vTgx3ugkJjHtWq1Mag6X78QtTJO6tKjLokyjH8p8rXoix9H6n8ulX
         lJC/v4eVacqrYIz6Fr5l44JtC1QLimdJrkKnW7O04SskBvZpYZ8ChlNgd4raabBbFD+W
         OMknBpXXqHA53SV+EgxEU1vxi10gerR8O+/UdKQPwpPLdhKrCy9F+AZBWMjHTtzNKwcr
         Sq2FswTy61TNtR3uQQHlyL991zehFWTv6lBlmRVa7VvXszTHas44hmr1OL7VgmRtiEPi
         32i/M1OrdB8f3cMMa3L00o0B/QY5yNID0Dx3fAOe+F6GXgjjPeYshg9OdQapQFfJJX/6
         t4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=san/Jx3q1O+/ULGAUeR8Q5oIYpoEgwqxUfWHCS0X8Gk=;
        b=pjS0IP1OycOcWcdLnD193+SPYGB9Dm4BwHEDlP5WFpTKLSxmdlW2/SnAzkJ3fWxhP9
         7EdMvQG6mPWu4OmTGq/9hTFvDUKPn346+ymdQo8GBexsCcTIta0c1HOvyQK9v0PIIv7T
         WGfrUbg2Dk1s1cYCIB2UUoFcVCAQgQB4lSHWi17f5ZxpZTLi02LIbqi48LEvVxG8deLB
         6tvwVX1we781zyrFEoYP7D4bZRYrVtrE+OgSE1ChLUpyqjuwzgUXLR2zFPlm1faru4w5
         H5WYobe4+9Leknww6bFIlWzcSLlW33dmLqaMJonXnkPTaO9dxXkbb+yjrpcBjuTp0sdw
         UWyQ==
X-Gm-Message-State: AJIora9jupZfC+/EyXp9tGfhKZUNA8YlgIHCBQb4/5ioiGQjnyMebWiw
        /pf9gLC1XteR8Hv/mGeQvtHUqbg=
X-Google-Smtp-Source: AGRyM1sX7qOo4Li8ai08yOMt3G0UFGNGGQVOLP1Gi/QpCs5XbgygITThuW3YEnBZE6w98IqVwyPEqeE=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:249:b0:1e0:a8a3:3c6c with SMTP id
 t9-20020a17090a024900b001e0a8a33c6cmr348071pje.0.1657729124707; Wed, 13 Jul
 2022 09:18:44 -0700 (PDT)
Date:   Wed, 13 Jul 2022 09:18:43 -0700
In-Reply-To: <BN6PR11MB16331BEF1C7F6F37F76C55DD92899@BN6PR11MB1633.namprd11.prod.outlook.com>
Message-Id: <Ys7wVqnuK3QWlnRH@google.com>
Mime-Version: 1.0
References: <BN6PR11MB16338E9998353C6B239CD27792869@BN6PR11MB1633.namprd11.prod.outlook.com>
 <BN6PR11MB16332A018C2FAB69B479EA2B92869@BN6PR11MB1633.namprd11.prod.outlook.com>
 <Ys2tkthkFE1XkEPh@google.com> <BN6PR11MB16331BEF1C7F6F37F76C55DD92899@BN6PR11MB1633.namprd11.prod.outlook.com>
Subject: Re: Build error of samples/bpf
From:   sdf@google.com
To:     oak.zeng@intel.com
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        "song@kernel.org" <song@kernel.org>, "yhs@fb.com" <yhs@fb.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "haoluo@google.com" <haoluo@google.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>
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

On 07/13, Zeng, Oak wrote:
> Thank you sdf for the reply.

> It is news to me that samples/bpf tend to go stale. When I looked the  
> samples/bpf folder git history, the last update is from only 2 months  
> ago. And yes I can see samples/bfp is not actively updated recently. We  
> are from Intel's GPU group and we are working on some bpf tools for GPU  
> profiling purpose. We made our work based on the structure of samples/bpf  
> because we can conveniently use libbpf. We chose bpf c frontend (vs  
> python frontend) because python bpf program seems can't execute under  
> non-root leading to some security concerns. This work is not yet upstream  
> but we planned to upstream it.

I'm mostly talking from the following perspective:
http://vger.kernel.org/bpfconf2022_material/lsfmmbpf2022-bpf-ci.pdf

BPF maintainers have a CI that continuously builds and runs
tools/testing/selftests/bpf. I don't think it includes samples/bpf;
that's what I mean by "go stale". Eventually, people fix samples, but
there is no continuous system to verify they are healthy.

> Now if samples/bpf is going stale, we need to change our plan.  
> Specifically I have a few questions for our future planning:

> 1. does bpf community accept more bpf samples such as using bpf to  
> kprobe/tracepoint GPU activities? Is such work helpful/welcome to/by the  
> community? I can see the existing samples and selftest are mainly for  
> general linux profiling such as fs, network etc. Do you accept more  
> samples for specific driver profiling - in our case it is profiling of  
> Intel's i915 GPU driver.

> 2. Should we port our samples/bpf to tools/testing/selftests/bpf for  
> upstream purpose? I am not sure whether tools/testing/selftests/bpf is a  
> good place for our gpu profiling samples. If tools/testing/selftests/bpf  
> is not a good place for gpu profilers, any suggestion where we can  
> upstream our gpu profilers?

> Cc other bpf reviewers. Thank you for your considerations!

I'll let others chime in, but IMO it's a gray area. This can probably
go into samples, but if you want to have a profiler that you want others
to use, why not distribute it as part of real profiling tools like perf or
bpftrace?

> Thanks,
> Oak

> > -----Original Message-----
> > From: sdf@google.com <sdf@google.com>
> > Sent: July 12, 2022 1:23 PM
> > To: Zeng, Oak <oak.zeng@intel.com>
> > Cc: bpf@vger.kernel.org
> > Subject: Re: Build error of samples/bpf
> >
> > On 07/12, Zeng, Oak wrote:
> > > Hello all,
> >
> > > I tried to build the latest samples/bpf following instructions in the
> > > README.rst in samples/bpf folder. I ran into various issue such as:
> >
> > > samples/bpf/Makefile:375: *** Cannot find a vmlinux for VMLINUX_BTF at
> > > any of "  /home/szeng/dii-tools/linux/vmlinux", build the kernel or
> > > set VMLINUX_BTF or VMLINUX_H variable
> >
> > > I was able to fix above issue by enable CONFIG_DEBUG_INFO_BTF in
> > > kernel .config file.
> >
> > > But I eventually ran into other errors.  I had to fix those errors by
> > > install dwarves, updating my clang/llvm to version 10.
> >
> > > I was able to build it if I comment out all the xdp programs from
> > > Makefile. It seems those xdp programs require advanced features such
> > > as data structure layout in vmlinux.h (dumped from vmlinux using
> > > bpftool) and this require special kernel config support.
> >
> > > So I thought instead of fixing those errors one by one, I should ask
> > > those who are working in this area, is there any instructions on how
> > > to build samples/bpf? The README.rst seems out-of-date, for example,
> > > it doesn't mention CONFIG_DEBUG_INFO_BTF. The required llvm/clang
> > > version in README.rst is also out-of-date.
> >
> > > More specifically, to build samples/bpf, is there an example kernel
> > > .config to use? I tried those config here
> > > https://github.com/torvalds/linux/blob/master/tools/testing/selftests/
> > > bpf/config
> > > but build errors persist.
> >
> > > Or is there any other tools I need to install/update on my system?
> >
> > In general, I'd say, samples/bpf tend to go stale. We mostly work on the
> > selftests and don't pay too much attention to the samples :-( Ideally,  
> the
> > samples should be part of selftests so they get exercised by the CI.
> >
> > One thing I can suggest is to look at  
> tools/testing/selftests/bpf/vmtest.sh
> > script. It builds the kernels with vetted configs capable of running  
> selftests.
> > That should be, in theory, be enough to compile the samples.
> >
> > > My whole build log is as below:
> >
> > > szeng@linux:~/dii-tools/linux$ make M=samples/bpf
> > > readelf: Error: Missing knowledge of 32-bit reloc types used in DWARF
> > > sections of machine number 247
> > > readelf: Warning: unable to apply unsupported reloc type 10 to section
> > > .debug_info
> > > readelf: Warning: unable to apply unsupported reloc type 1 to section
> > > .debug_info
> > > readelf: Warning: unable to apply unsupported reloc type 10 to section
> > > .debug_info make -C
> > > /home/szeng/dii-tools/linux/samples/bpf/../../tools/lib/bpf RM='rm  
> -rf'
> > > EXTRA_CFLAGS="-Wall -O2 -Wmissing-prototypes -Wstrict-prototypes
> > > -I./usr/include -I./tools/testing/selftests/bpf/
> > > -I/home/szeng/dii-tools/linux/samples/bpf/libbpf/include
> > > -I./tools/include -I./tools/perf -DHAVE_ATTR_TEST=0" \
> > >          LDFLAGS=  
> srctree=/home/szeng/dii-tools/linux/samples/bpf/../../ \
> > >          O= OUTPUT=/home/szeng/dii-tools/linux/samples/bpf/libbpf/
> > > DESTDIR=/home/szeng/dii-tools/linux/samples/bpf/libbpf prefix= \
> > >          /home/szeng/dii-tools/linux/samples/bpf/libbpf/libbpf.a
> > > install_headers
> > >    CC
> > > /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/libbpf.o
> > >    CC       
> /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/bpf.o
> > >    CC
> > > /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/nlattr.o
> > >    CC       
> /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/btf.o
> > >    CC
> > >  
> /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/libbpf_errno.o
> > >    CC
> > > /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/str_error.o
> > >    CC
> > > /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/netlink.o
> > >    CC
> > > /home/szeng/dii-
> > tools/linux/samples/bpf/libbpf/staticobjs/bpf_prog_linfo.o
> > >    CC
> > > /home/szeng/dii-
> > tools/linux/samples/bpf/libbpf/staticobjs/libbpf_probes.o
> > >    CC       
> /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/xsk.o
> > >    CC
> > > /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/hashmap.o
> > >    CC
> > > /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/btf_dump.o
> > >    CC
> > > /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/ringbuf.o
> > >    CC
> > > /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/strset.o
> > >    CC
> > > /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/linker.o
> > >    CC
> > > /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/gen_loader.o
> > >    CC
> > > /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/relo_core.o
> > >    LD
> > > /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/libbpf-in.o
> > >    LINK    /home/szeng/dii-tools/linux/samples/bpf/libbpf/libbpf.a
> > >    INSTALL headers
> > >    CC  samples/bpf/test_lru_dist
> > >    CC  samples/bpf/sock_example
> > >    CC  samples/bpf/../../tools/testing/selftests/bpf/cgroup_helpers.o
> > >    CC  samples/bpf/../../tools/testing/selftests/bpf/trace_helpers.o
> > >    CC  samples/bpf/cookie_uid_helper_example.o
> > >    CC  samples/bpf/cpustat_user.o
> > >    CC  samples/bpf/fds_example.o
> > >    CC  samples/bpf/hbm.o
> > >    CC  samples/bpf/i915_latency_hist_user.o
> > >    CC  samples/bpf/i915_stat_user.o
> > >    CC  samples/bpf/ibumad_user.o
> > >    CC  samples/bpf/lathist_user.o
> > >    CC  samples/bpf/lwt_len_hist_user.o
> > >    CC  samples/bpf/map_perf_test_user.o
> > >    CC  samples/bpf/offwaketime_user.o
> > >    CC  samples/bpf/sampleip_user.o
> > >    CC  samples/bpf/sockex1_user.o
> > >    CC  samples/bpf/sockex2_user.o
> > >    CC  samples/bpf/sockex3_user.o
> > >    CC  samples/bpf/spintest_user.o
> > >    CC  samples/bpf/syscall_tp_user.o
> > >    CC  samples/bpf/task_fd_query_user.o
> > >    CC  samples/bpf/tc_l2_redirect_user.o
> > >    CC  samples/bpf/test_cgrp2_array_pin.o
> > >    CC  samples/bpf/test_cgrp2_attach.o
> > >    CC  samples/bpf/test_cgrp2_sock.o
> > >    CC  samples/bpf/test_cgrp2_sock2.o
> > >    CC  samples/bpf/test_current_task_under_cgroup_user.o
> > >    CC  samples/bpf/test_map_in_map_user.o
> > >    CC  samples/bpf/test_overhead_user.o
> > >    CC  samples/bpf/test_probe_write_user_user.o
> > >    CC  samples/bpf/trace_event_user.o
> > >    CC  samples/bpf/trace_output_user.o
> > >    CC  samples/bpf/tracex1_user.o
> > >    CC  samples/bpf/tracex2_user.o
> > >    CC  samples/bpf/tracex3_user.o
> > >    CC  samples/bpf/tracex4_user.o
> > >    CC  samples/bpf/tracex5_user.o
> > >    CC  samples/bpf/tracex6_user.o
> > >    CC  samples/bpf/tracex7_user.o
> > >    CC  samples/bpf/xdp1_user.o
> > >    CC  samples/bpf/xdp_adjust_tail_user.o
> > >    CC  samples/bpf/xdp_fwd_user.o
> > > make -C
> > > /home/szeng/dii-tools/linux/samples/bpf/../../tools/bpf/bpftool
> > > srctree=/home/szeng/dii-tools/linux/samples/bpf/../../ \
> > >          OUTPUT=/home/szeng/dii-tools/linux/samples/bpf/bpftool/ \
> > >           
> LIBBPF_OUTPUT=/home/szeng/dii-tools/linux/samples/bpf/libbpf/ \
> > >
> > > LIBBPF_DESTDIR=/home/szeng/dii-tools/linux/samples/bpf/libbpf/
> >
> > > Auto-detecting system features:
> > > ...                        libbfd: [ OFF ]
> > > ...        disassembler-four-args: [ OFF ]
> > > ...                          zlib: [ on  ]
> > > ...                        libcap: [ OFF ]
> > > ...               clang-bpf-co-re: [ on  ]
> >
> >
> > >    CC
> > > /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/libbpf.o
> > >    CC       
> /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/bpf.o
> > >    CC
> > > /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/nlattr.o
> > >    CC       
> /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/btf.o
> > >    CC
> > >  
> /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/libbpf_errno.o
> > >    CC
> > > /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/str_error.o
> > >    CC
> > > /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/netlink.o
> > >    CC
> > > /home/szeng/dii-
> > tools/linux/samples/bpf/libbpf/staticobjs/bpf_prog_linfo.o
> > >    CC
> > > /home/szeng/dii-
> > tools/linux/samples/bpf/libbpf/staticobjs/libbpf_probes.o
> > >    CC       
> /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/xsk.o
> > >    CC
> > > /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/hashmap.o
> > >    CC
> > > /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/btf_dump.o
> > >    CC
> > > /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/ringbuf.o
> > >    CC
> > > /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/strset.o
> > >    CC
> > > /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/linker.o
> > >    CC
> > > /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/gen_loader.o
> > >    CC
> > > /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/relo_core.o
> > >    LD
> > > /home/szeng/dii-tools/linux/samples/bpf/libbpf/staticobjs/libbpf-in.o
> > >    LINK    /home/szeng/dii-tools/linux/samples/bpf/libbpf/libbpf.a
> > >    CLANG    
> /home/szeng/dii-tools/linux/samples/bpf/bpftool/profiler.bpf.o
> > >    GEN      
> /home/szeng/dii-tools/linux/samples/bpf/bpftool/profiler.skel.h
> > >    CC      /home/szeng/dii-tools/linux/samples/bpf/bpftool/prog.o
> > >    CLANG    
> /home/szeng/dii-tools/linux/samples/bpf/bpftool/pid_iter.bpf.o
> > >    GEN      
> /home/szeng/dii-tools/linux/samples/bpf/bpftool/pid_iter.skel.h
> > >    CC      /home/szeng/dii-tools/linux/samples/bpf/bpftool/pids.o
> > >    LINK    /home/szeng/dii-tools/linux/samples/bpf/bpftool/bpftool
> > >    CC  samples/bpf/xdp_router_ipv4_user.o
> > >    CC  samples/bpf/xdp_rxq_info_user.o
> > >    CC  samples/bpf/xdp_sample_pkts_user.o
> > >    CC  samples/bpf/xdp_tx_iptunnel_user.o
> > >    CC  samples/bpf/xdpsock_ctrl_proc.o
> > >    CC  samples/bpf/xsk_fwd.o
> > >    CLANG-BPF  samples/bpf/xdp_sample.bpf.o
> > >    CLANG-BPF  samples/bpf/xdp_redirect_map_multi.bpf.o
> > >    CLANG-BPF  samples/bpf/xdp_redirect_cpu.bpf.o
> > >    CLANG-BPF  samples/bpf/xdp_redirect_map.bpf.o
> > >    CLANG-BPF  samples/bpf/xdp_monitor.bpf.o
> > >    CLANG-BPF  samples/bpf/xdp_redirect.bpf.o
> > >    BPF GEN-OBJ  samples/bpf/xdp_monitor
> > >    BPF GEN-SKEL samples/bpf/xdp_monitor
> > > libbpf: map 'rx_cnt': unexpected def kind var.
> > > Error: failed to open BPF object file: Invalid argument
> > > samples/bpf/Makefile:430: recipe for target
> > > 'samples/bpf/xdp_monitor.skel.h' failed
> > > make[1]: *** [samples/bpf/xdp_monitor.skel.h] Error 255
> > > make[1]: *** Deleting file 'samples/bpf/xdp_monitor.skel.h'
> > > Makefile:1868: recipe for target 'samples/bpf' failed
> > > make: *** [samples/bpf] Error 2
> >
> >
> > > Thanks,
> > > Oak

