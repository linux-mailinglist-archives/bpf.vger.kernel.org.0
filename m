Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D777575D5B
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 10:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiGOI0T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 04:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbiGOI0R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 04:26:17 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CB62C11A
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 01:26:14 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id t3so5414663edd.0
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 01:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d7M+UvYjZ7VRCpuVXl23JLvk8zeDI0EGR+vMoy0DA8E=;
        b=SiRe1QohUhV56Vw2laxLE27u6fys6NgIYQAgORNg6ZixuI3YNg526akDeWXMtOHi2h
         Dg3U56uuLjCfPt48Als4xLkWd4YEhOhNBy7ouj9w3k5l2HjMAQBEF7ZWSHI2gKr9OJON
         DJ/tTRxCbhDtBfosgLSK3OdvcukglWgZ5YaJCj6RwhttXx1kG62kFNgfwbNnPnXn4+FG
         PYv1L2XUqOF2if5b3aYR/FOlD2PgvmCZG0tguhHpGoZgC1hP2UprvfEEP9e0AIozKb85
         Eu49OfG8bIqNgdGSqNKZk16WyrZGZuu6zqRLXnk84j3TzMCBQi7SVyyGVXNW24eOjuLl
         RF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d7M+UvYjZ7VRCpuVXl23JLvk8zeDI0EGR+vMoy0DA8E=;
        b=79/ro8etf3/4G+EIZUDgz8gpBNXjv//wA7T3NgfPkgU4JDqU6u6patySW1ddmbUBEG
         tQ7sg0HEEBjSeZBXO44QqBiRtzJ/kkxygy7WpYA8M3MJ2iZ01MbM0NBKNpSDgdTdC1y9
         Bu9RfwVAoWumpU4Tf97MrBBonhpOu9zcCYESC1AxpIVk73HnE0dE1BPUAsMVLRRjMFBU
         XWDDNsF8En6TJwZzmOJecWdwVNvURpWZNjMV5jQL0zUANpAPD7E+KJfo6HgILWZCv5Bc
         lhx6Z1O4oA7/Fs3He4r/09AE6zYr0KyrGVeNu12DY8sRiRNpdN0k+N6sMZeIzl+xX1x8
         jUZw==
X-Gm-Message-State: AJIora/FcdAYvc3kIxO47OsQVEybHCqd9+9z+CHpSTtFInh5dtr6A0FX
        e6xlZ3Yb7HWX/ZIoAr0yGOGMON4mgZ0ZTg==
X-Google-Smtp-Source: AGRyM1tXrqA7eAsGV2MLpjRIXjASe3oBC/wTdKxgiEs77C0wHXt19vEoCdt1O43+fNb1u4BwLYmIpw==
X-Received: by 2002:a05:6402:354c:b0:43a:dc59:657 with SMTP id f12-20020a056402354c00b0043adc590657mr16837441edd.405.1657873573330;
        Fri, 15 Jul 2022 01:26:13 -0700 (PDT)
Received: from krava (net-37-179-156-241.cust.vodafonedsl.it. [37.179.156.241])
        by smtp.gmail.com with ESMTPSA id n22-20020aa7d056000000b0043a95981050sm2400958edo.79.2022.07.15.01.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 01:26:12 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 15 Jul 2022 10:26:10 +0200
To:     "Zeng, Oak" <oak.zeng@intel.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: Build error of samples/bpf
Message-ID: <YtEkosDJ2O0CXlL/@krava>
References: <BN6PR11MB16338E9998353C6B239CD27792869@BN6PR11MB1633.namprd11.prod.outlook.com>
 <BN6PR11MB16332A018C2FAB69B479EA2B92869@BN6PR11MB1633.namprd11.prod.outlook.com>
 <CAP01T77ZDk8kHGhAy4V1tht0JHqefkmKLdKtKPHj1mJ_shDMhQ@mail.gmail.com>
 <BN6PR11MB163373657888237AB489C996928B9@BN6PR11MB1633.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN6PR11MB163373657888237AB489C996928B9@BN6PR11MB1633.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 15, 2022 at 03:54:42AM +0000, Zeng, Oak wrote:

SNIP

> > >   CC  samples/bpf/xdp_router_ipv4_user.o
> > >   CC  samples/bpf/xdp_rxq_info_user.o
> > >   CC  samples/bpf/xdp_sample_pkts_user.o
> > >   CC  samples/bpf/xdp_tx_iptunnel_user.o
> > >   CC  samples/bpf/xdpsock_ctrl_proc.o
> > >   CC  samples/bpf/xsk_fwd.o
> > >   CLANG-BPF  samples/bpf/xdp_sample.bpf.o
> > >   CLANG-BPF  samples/bpf/xdp_redirect_map_multi.bpf.o
> > >   CLANG-BPF  samples/bpf/xdp_redirect_cpu.bpf.o
> > >   CLANG-BPF  samples/bpf/xdp_redirect_map.bpf.o
> > >   CLANG-BPF  samples/bpf/xdp_monitor.bpf.o
> > >   CLANG-BPF  samples/bpf/xdp_redirect.bpf.o
> > >   BPF GEN-OBJ  samples/bpf/xdp_monitor
> > >   BPF GEN-SKEL samples/bpf/xdp_monitor
> > > libbpf: map 'rx_cnt': unexpected def kind var.
> > 
> > IIRC, this error is due to older clang. Can you try with a newer clang
> > (11 and above)?
> 
> Thank you Kumar.
> 
> I updated to llvm/clang to version 12, the issue persists. 
> 
> I also have another problem... To build those xdp samples, I need to enable CONFIG_DEBUG_INFO_BTF. But once this is enabled, I failed to build linux kernel with below errors. I was able to build on a 4.15 ubuntu machine but on a 5.11  ubuntu machine, I had below error to build the same kernel. Any one can give me some hint? I searched google but didn't figure out. I noticed somethings is killed during build of .bpf.vmlinux.bin.o, so I guess some of my tools is not updated?
> 
> 
> 
> szeng@szeng-develop:~/dii-tools/linux$ make -j$(nproc)
>   DESCEND objtool
>   DESCEND bpf/resolve_btfids
>   CALL    scripts/atomic/check-atomics.sh
>   CALL    scripts/checksyscalls.sh
>   CHK     include/generated/compile.h
>   UPD     include/generated/compile.h
>   CC      init/version.o
>   AR      init/built-in.a
>   CHK     kernel/kheaders_data.tar.xz
>   GEN     .version
>   CHK     include/generated/compile.h
>   UPD     include/generated/compile.h
>   CC      init/version.o
>   AR      init/built-in.a
>   LD      vmlinux.o
>   MODPOST vmlinux.symvers
>   MODINFO modules.builtin.modinfo
>   GEN     modules.builtin
>   LD      .tmp_vmlinux.btf
>   BTF     .btf.vmlinux.bin.o
> Killed

looks like something happened during BTF generation and that's
probably the reason why 'BTFIDS' is failing below

I'd double check with V=1 and if it's pahole that's killed,
I'd check that you can run it properly.. maybe some library
mismatch? or try to build and install the latest pahole

there was similar issue recently:
  https://lore.kernel.org/bpf/CAJQ9wQ-0UUAqzyB5P9Xy_0=hpxg9m+2OEzAmk2nWnoX9es9Gnw@mail.gmail.com/T/#t

jira


>   LD      .tmp_vmlinux.kallsyms1
>   KSYMS   .tmp_vmlinux.kallsyms1.S
>   AS      .tmp_vmlinux.kallsyms1.S
>   LD      .tmp_vmlinux.kallsyms2
>   KSYMS   .tmp_vmlinux.kallsyms2.S
>   AS      .tmp_vmlinux.kallsyms2.S
>   LD      vmlinux
>   BTFIDS  vmlinux
> FAILED: load BTF from vmlinux: No such file or directory
> make: *** [Makefile:1183: vmlinux] Error 255
> make: *** Deleting file 'vmlinux'
> 
> 
> Thanks,
> Oak
> 
> > 
> > > Error: failed to open BPF object file: Invalid argument
> > > samples/bpf/Makefile:430: recipe for target
> > 'samples/bpf/xdp_monitor.skel.h' failed
> > > make[1]: *** [samples/bpf/xdp_monitor.skel.h] Error 255
> > > make[1]: *** Deleting file 'samples/bpf/xdp_monitor.skel.h'
> > > Makefile:1868: recipe for target 'samples/bpf' failed
> > > make: *** [samples/bpf] Error 2
> > >
> > >
> > > Thanks,
> > > Oak
> > >
