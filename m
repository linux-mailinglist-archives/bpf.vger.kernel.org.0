Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35303D4FCE
	for <lists+bpf@lfdr.de>; Sun, 25 Jul 2021 22:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbhGYT3W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 25 Jul 2021 15:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhGYT3W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 25 Jul 2021 15:29:22 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B861C061757
        for <bpf@vger.kernel.org>; Sun, 25 Jul 2021 13:09:52 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id a93so11422572ybi.1
        for <bpf@vger.kernel.org>; Sun, 25 Jul 2021 13:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vn+wJqjo2KDpqfa2pUkIzHT/ctjvFz7YtqjXdKfwio4=;
        b=N1iWP7inYqnpQykyH+LXcJeJ3Q4aPaA/25YbIOD2x2U2H0z1ijO0nre6NC9QlA/uC+
         JZ2FrWxisvgF7OZWWZlPAIzfDxb9drSu/Aa8f/C2wB6vkZeyTgTI7ObFdKpceb0uw2Tb
         1ICkFOfvb5MUpDgGIE0Aud2rEzs8VZLpNyTdAMbnh0+hg4vZaCM8Z3y4h2VXl//Fc1lI
         pUt0jsbSdqIQwexfK84u5RNxEUf8NNE9QQIpSgSroyx0ctRnAJpSytbUZG1tokWUPPv/
         KEfA1xyQHGTfA835pSIKA+q81jacdT+IXxtXfE5HW7VBeXofZRU4Vg9eJbqM5w3uWWaj
         kTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vn+wJqjo2KDpqfa2pUkIzHT/ctjvFz7YtqjXdKfwio4=;
        b=OxaR9m4i1xt1Kp60jy8O5icC5Owplz3+39544oPjv0CB2qzhntg0izYnH72kxDN5kP
         7qGokBA+gpc/+dIVCx+1glYeyAD7E47DmIhentyRilOMgGpEQ8iS8hk3p0DKB0Ywj9CE
         Z6ilPtpaTHC3R/PPmCVgUQ0ZMUXDIUmgsfwZt2buUpuR1nsO02zdXbpHt+SgWrNcGI/5
         so+KQw1sy6Wlj3cGlW4aqd9TzIIg1xjDQ4/R76SOYCjmvcjGwcvKvnnFtTRsjNolwMN/
         dNi1xjFO2Tu+GgBT9H9Zt0Q+s77t2Y9w+MwS5I+Cd8o//BaXombZ8YprcjSDYVODX1yP
         9fnw==
X-Gm-Message-State: AOAM532Lm6Lg7Znw+EmacVA5ShjI9MFO/0zk1ggw5zI7AQdbkr5aqBzv
        FRxqJGtpCy/SCZcFc/r2iEr7HZ4XL1rPRtpGbRI=
X-Google-Smtp-Source: ABdhPJwzzmqnri6/Jww47s9pXcOfChbXDdZwYiexx0sWjZv8O98bELQpw2teieTpQ1WKoFSc/Gno28zVXK7e/tPWaO8=
X-Received: by 2002:a25:1455:: with SMTP id 82mr19464852ybu.403.1627243791117;
 Sun, 25 Jul 2021 13:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210725173845.2593626-5-andrii@kernel.org> <202107260340.clhEA5P9-lkp@intel.com>
In-Reply-To: <202107260340.clhEA5P9-lkp@intel.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sun, 25 Jul 2021 13:09:40 -0700
Message-ID: <CAEf4BzYRsZQQ_1ERBd7PB1egt20d7LKEyrXwMz6m4rerggvKgQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 04/14] bpf: implement minimal BPF perf link
To:     kernel test robot <lkp@intel.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        kbuild-all@lists.01.org, Kernel Team <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jul 25, 2021 at 12:52 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Andrii,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on bpf-next/master]
>
> url:    https://github.com/0day-ci/linux/commits/Andrii-Nakryiko/BPF-perf-link-and-user-provided-context-value/20210726-014304
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> config: powerpc64-randconfig-s032-20210725 (attached as .config)
> compiler: powerpc-linux-gcc (GCC) 10.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.3-341-g8af24329-dirty
>         # https://github.com/0day-ci/linux/commit/aebdacfee760371d78456f088ddcc6c5450ce5f5
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Andrii-Nakryiko/BPF-perf-link-and-user-provided-context-value/20210726-014304
>         git checkout aebdacfee760371d78456f088ddcc6c5450ce5f5
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=powerpc64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    kernel/bpf/syscall.c: In function 'bpf_perf_link_release':
> >> kernel/bpf/syscall.c:2919:2: error: implicit declaration of function 'perf_event_free_bpf_prog'; did you mean 'perf_event_detach_bpf_prog'? [-Werror=implicit-function-declaration]
>     2919 |  perf_event_free_bpf_prog(event);
>          |  ^~~~~~~~~~~~~~~~~~~~~~~~

Argh, I knew it was better to move the stub implementation into
include/linux/trace_events.h as static inline, similar to
perf_event_detach_bpf_prog. I'll do this in v2.


>          |  perf_event_detach_bpf_prog
>    kernel/bpf/syscall.c: In function 'bpf_perf_link_attach':
> >> kernel/bpf/syscall.c:2965:8: error: implicit declaration of function 'perf_event_set_bpf_prog'; did you mean 'perf_event_detach_bpf_prog'? [-Werror=implicit-function-declaration]
>     2965 |  err = perf_event_set_bpf_prog(event, prog);
>          |        ^~~~~~~~~~~~~~~~~~~~~~~
>          |        perf_event_detach_bpf_prog
>    cc1: some warnings being treated as errors
>
>
> vim +2919 kernel/bpf/syscall.c
>
>   2913
>   2914  static void bpf_perf_link_release(struct bpf_link *link)
>   2915  {
>   2916          struct bpf_perf_link *perf_link = container_of(link, struct bpf_perf_link, link);
>   2917          struct perf_event *event = perf_link->perf_file->private_data;
>   2918
> > 2919          perf_event_free_bpf_prog(event);
>   2920          fput(perf_link->perf_file);
>   2921  }
>   2922
>   2923  static void bpf_perf_link_dealloc(struct bpf_link *link)
>   2924  {
>   2925          struct bpf_perf_link *perf_link = container_of(link, struct bpf_perf_link, link);
>   2926
>   2927          kfree(perf_link);
>   2928  }
>   2929
>   2930  static const struct bpf_link_ops bpf_perf_link_lops = {
>   2931          .release = bpf_perf_link_release,
>   2932          .dealloc = bpf_perf_link_dealloc,
>   2933  };
>   2934
>   2935  static int bpf_perf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
>   2936  {
>   2937          struct bpf_link_primer link_primer;
>   2938          struct bpf_perf_link *link;
>   2939          struct perf_event *event;
>   2940          struct file *perf_file;
>   2941          int err;
>   2942
>   2943          if (attr->link_create.flags)
>   2944                  return -EINVAL;
>   2945
>   2946          perf_file = perf_event_get(attr->link_create.target_fd);
>   2947          if (IS_ERR(perf_file))
>   2948                  return PTR_ERR(perf_file);
>   2949
>   2950          link = kzalloc(sizeof(*link), GFP_USER);
>   2951          if (!link) {
>   2952                  err = -ENOMEM;
>   2953                  goto out_put_file;
>   2954          }
>   2955          bpf_link_init(&link->link, BPF_LINK_TYPE_PERF_EVENT, &bpf_perf_link_lops, prog);
>   2956          link->perf_file = perf_file;
>   2957
>   2958          err = bpf_link_prime(&link->link, &link_primer);
>   2959          if (err) {
>   2960                  kfree(link);
>   2961                  goto out_put_file;
>   2962          }
>   2963
>   2964          event = perf_file->private_data;
> > 2965          err = perf_event_set_bpf_prog(event, prog);
>   2966          if (err) {
>   2967                  bpf_link_cleanup(&link_primer);
>   2968                  goto out_put_file;
>   2969          }
>   2970          /* perf_event_set_bpf_prog() doesn't take its own refcnt on prog */
>   2971          bpf_prog_inc(prog);
>   2972
>   2973          return bpf_link_settle(&link_primer);
>   2974
>   2975  out_put_file:
>   2976          fput(perf_file);
>   2977          return err;
>   2978  }
>   2979
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
