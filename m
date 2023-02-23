Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AF26A0BC0
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 15:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbjBWOSZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Feb 2023 09:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234548AbjBWOSD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Feb 2023 09:18:03 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D02F1
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 06:17:48 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id nf5so11151827qvb.5
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 06:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v06fpwCrXEyQmnoiTpLcBC2+yezVadTel4oRfYGKyxQ=;
        b=QHlaYZYbmu1/0IId+KW9vs0WrPiyxjaczZL03mnP97nM/maByIKgciMW+vHsIjQIRz
         oKCFpqiLW71GrbY9NAaQrBLqPpNPCQD2tKwC8Hxad0e5f1vcGf8T7E6olKa/2nBtt361
         5e5/CzIRHkRJNbRL90MB2kD59ezpsCv6Gkza8/9aRWBZZpKUdCv5Km5YHONKoy3NJ4s0
         pPkcQk1QIAUWdPAvNh9oP2pQnSXe2o/u2ZTC9E6rCIbDASJ/lQawVMKoUN8j/CnbDhqu
         HuNxOoNzs5QSFEOZGa2p84vtPUpA+ZgKB6ta7Gh4LStLprQ1XmJ4xKT1HyzbII227wfw
         3Ryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v06fpwCrXEyQmnoiTpLcBC2+yezVadTel4oRfYGKyxQ=;
        b=vJD6R5n/iQpyREbsEP+PbVLrD5C5Qx+Ny4g5yrvMcdFcu0AhR7Bj0IxL83+PhTS6zk
         HlzxKa+CgfP1AZYeivo1/TOvgCWMKiUpfdAYvY4nJCQJmHis9dOJrXgW6eXkJm1MExyf
         JaHzV8VR96medzxofvqYeN0TBA03lJ+nBjlJZ+NllRWhxGfFEkTi1QqOFuxXf0BCiH+J
         9c5hDtKB2VGQO7BEoI0/WGTeRic3kFc2YaSKRcUljF3wC/EHjF1iQtmn1sBgiPgp/J36
         t6Nq1ZiFGiKK7NDp3I16loxngWBu6EPDpNCWepuGHydtWdXdDdqYRRAt5scBGPfjU8uB
         nBog==
X-Gm-Message-State: AO0yUKXNaaPcs1OQ9FDAUE944G8o8LpC8mDrVrU1f0gZ2mp3g78otAZL
        QX6iDVYyx7r4LPkCFK2I77Z1+bejrczzSFAQ/tQ=
X-Google-Smtp-Source: AK7set+BHDVzxE13nEhpE82SbMAWyD1SI+SORikEQB5dZ0YHj4io4EfaQqCNYnaPGV5KyBs0IYygnD4JsuBb1La8VUE=
X-Received: by 2002:a05:6214:14af:b0:56e:9104:ee7 with SMTP id
 bo15-20020a05621414af00b0056e91040ee7mr1736837qvb.10.1677161867753; Thu, 23
 Feb 2023 06:17:47 -0800 (PST)
MIME-Version: 1.0
References: <20230222014553.47744-18-laoar.shao@gmail.com> <202302221852.mOd5T9T6-lkp@intel.com>
In-Reply-To: <202302221852.mOd5T9T6-lkp@intel.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 23 Feb 2023 22:17:11 +0800
Message-ID: <CALOAHbCuVZxWutUCpOgwG5uq8KsWuMC+uc095DzZUHwmXUne=g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 17/18] bpf: offload map memory usage
To:     kernel test robot <lkp@intel.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com, oe-kbuild-all@lists.linux.dev,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 22, 2023 at 7:01 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Yafang,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on bpf-next/master]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Yafang-Shao/bpf-add-new-map-ops-map_mem_usage/20230222-094856
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> patch link:    https://lore.kernel.org/r/20230222014553.47744-18-laoar.shao%40gmail.com
> patch subject: [PATCH bpf-next v2 17/18] bpf: offload map memory usage
> config: um-x86_64_defconfig (https://download.01.org/0day-ci/archive/20230222/202302221852.mOd5T9T6-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/intel-lab-lkp/linux/commit/e5742e839659b59ea26bc7a5804d04e577604aab
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Yafang-Shao/bpf-add-new-map-ops-map_mem_usage/20230222-094856
>         git checkout e5742e839659b59ea26bc7a5804d04e577604aab
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=um SUBARCH=x86_64 olddefconfig
>         make W=1 O=build_dir ARCH=um SUBARCH=x86_64 SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202302221852.mOd5T9T6-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    In file included from kernel/fork.c:98:
> >> include/linux/bpf.h:2644:1: error: expected identifier or '(' before '{' token
>     2644 | {
>          | ^
>    kernel/fork.c:162:13: warning: no previous prototype for 'arch_release_task_struct' [-Wmissing-prototypes]
>      162 | void __weak arch_release_task_struct(struct task_struct *tsk)
>          |             ^~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/fork.c:862:20: warning: no previous prototype for 'arch_task_cache_init' [-Wmissing-prototypes]
>      862 | void __init __weak arch_task_cache_init(void) { }
>          |                    ^~~~~~~~~~~~~~~~~~~~
>    kernel/fork.c:957:12: warning: no previous prototype for 'arch_dup_task_struct' [-Wmissing-prototypes]
>      957 | int __weak arch_dup_task_struct(struct task_struct *dst,
>          |            ^~~~~~~~~~~~~~~~~~~~
>    In file included from kernel/fork.c:98:
>    include/linux/bpf.h:2643:19: warning: 'bpf_map_offload_map_mem_usage' declared 'static' but never defined [-Wunused-function]
>     2643 | static inline u64 bpf_map_offload_map_mem_usage(const struct bpf_map *map);
>          |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> --
>    In file included from include/linux/filter.h:9,
>                     from kernel/sysctl.c:35:
> >> include/linux/bpf.h:2644:1: error: expected identifier or '(' before '{' token
>     2644 | {
>          | ^
>    In file included from include/linux/filter.h:9,
>                     from kernel/sysctl.c:35:
>    include/linux/bpf.h:2643:19: warning: 'bpf_map_offload_map_mem_usage' declared 'static' but never defined [-Wunused-function]
>     2643 | static inline u64 bpf_map_offload_map_mem_usage(const struct bpf_map *map);
>          |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> --
>    In file included from include/linux/filter.h:9,
>                     from kernel/kallsyms.c:25:
> >> include/linux/bpf.h:2644:1: error: expected identifier or '(' before '{' token
>     2644 | {
>          | ^
>    kernel/kallsyms.c:663:12: warning: no previous prototype for 'arch_get_kallsym' [-Wmissing-prototypes]
>      663 | int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
>          |            ^~~~~~~~~~~~~~~~
>    In file included from include/linux/filter.h:9,
>                     from kernel/kallsyms.c:25:
>    include/linux/bpf.h:2643:19: warning: 'bpf_map_offload_map_mem_usage' declared 'static' but never defined [-Wunused-function]
>     2643 | static inline u64 bpf_map_offload_map_mem_usage(const struct bpf_map *map);
>          |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> --
>    In file included from include/linux/bpf-cgroup.h:5,
>                     from net/socket.c:55:
> >> include/linux/bpf.h:2644:1: error: expected identifier or '(' before '{' token
>     2644 | {
>          | ^
>    net/socket.c: In function '__sys_getsockopt':
>    net/socket.c:2300:13: warning: variable 'max_optlen' set but not used [-Wunused-but-set-variable]
>     2300 |         int max_optlen;
>          |             ^~~~~~~~~~
>    In file included from include/linux/bpf-cgroup.h:5,
>                     from net/socket.c:55:
>    net/socket.c: At top level:
>    include/linux/bpf.h:2643:19: warning: 'bpf_map_offload_map_mem_usage' declared 'static' but never defined [-Wunused-function]
>     2643 | static inline u64 bpf_map_offload_map_mem_usage(const struct bpf_map *map);
>          |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> --
>    In file included from include/linux/filter.h:9,
>                     from kernel/bpf/core.c:21:
> >> include/linux/bpf.h:2644:1: error: expected identifier or '(' before '{' token
>     2644 | {
>          | ^
>    kernel/bpf/core.c:1631:12: warning: no previous prototype for 'bpf_probe_read_kernel' [-Wmissing-prototypes]
>     1631 | u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
>          |            ^~~~~~~~~~~~~~~~~~~~~
>    kernel/bpf/core.c:2070:6: warning: no previous prototype for 'bpf_patch_call_args' [-Wmissing-prototypes]
>     2070 | void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
>          |      ^~~~~~~~~~~~~~~~~~~
>    In file included from include/linux/filter.h:9,
>                     from kernel/bpf/core.c:21:
>    include/linux/bpf.h:2643:19: warning: 'bpf_map_offload_map_mem_usage' declared 'static' but never defined [-Wunused-function]
>     2643 | static inline u64 bpf_map_offload_map_mem_usage(const struct bpf_map *map);
>          |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> --
>    In file included from include/linux/filter.h:9,
>                     from include/net/sock_reuseport.h:5,
>                     from include/net/tcp.h:35,
>                     from net/ipv4/route.c:95:
> >> include/linux/bpf.h:2644:1: error: expected identifier or '(' before '{' token
>     2644 | {
>          | ^
>    net/ipv4/route.c: In function 'ip_rt_send_redirect':
>    net/ipv4/route.c:880:13: warning: variable 'log_martians' set but not used [-Wunused-but-set-variable]
>      880 |         int log_martians;
>          |             ^~~~~~~~~~~~
>    In file included from include/linux/filter.h:9,
>                     from include/net/sock_reuseport.h:5,
>                     from include/net/tcp.h:35,
>                     from net/ipv4/route.c:95:
>    net/ipv4/route.c: At top level:
>    include/linux/bpf.h:2643:19: warning: 'bpf_map_offload_map_mem_usage' declared 'static' but never defined [-Wunused-function]
>     2643 | static inline u64 bpf_map_offload_map_mem_usage(const struct bpf_map *map);
>          |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
>
> vim +2644 include/linux/bpf.h
>
>   2642
>   2643  static inline u64 bpf_map_offload_map_mem_usage(const struct bpf_map *map);

Thanks for the report. I forgot to build it with COFNIG_BPF=n.

> > 2644  {
>   2645          return 0;
>   2646  }
>   2647
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests



-- 
Regards
Yafang
