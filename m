Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2AD15B3518
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 12:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiIIKWI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 06:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiIIKWI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 06:22:08 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D40EBF36E
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 03:22:06 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id v16so2875185ejr.10
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 03:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=4m33vCG+fVpmCVZX7nTieYKGZQy3TEaWwZ17if8+4TE=;
        b=BfzR/SdqqzFQy8ATO7FfwJOqJazFBEz/kE+/l0ykuN0bMnopAXrWmnbCDm7WbNCFTM
         eMJNgcXj3fmM4UIbdBE/3XqO3y4uspXgIwBzwzbyuTvwLNYsgqeR5FkGR7PtossfWlYP
         +Cr2UlvD5bw+IQPy4BFG1cxSinfCTqD5P5QnwKsBYI3x2GeqyFXvS+QWo9YYsGTjbx3M
         6/Xa4sdovs3/QGZQy8Uco5KcZrpenM4UxTCx4GHYukcDKkmsywukP+UhmryhU5AY9Ojq
         EySwQ/1SLUc6L80XmeJqRN3e9zDVEtPv4ZZAEeJPKFbpX/nFAwg1WgOVlUs5RZfBuFaQ
         JAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=4m33vCG+fVpmCVZX7nTieYKGZQy3TEaWwZ17if8+4TE=;
        b=nYRMQrTGux/or8ac4v7oT3w10V2cZA9l+Y3/gKn/3PaBZwu+UptViH61QCDrGhYbzM
         PJXwUZMW71seGWLMALqoGwtWKxKidJ8dtTwYCoiUsafEZEcsF6Ldwky6om3Gt9RZLNWy
         rZa2QKj5bR11hCFs9r9sC9ziwrs961+DmtZe7Uaen3HDUBk0K9eYDZ3zBDQg7c6V7U+E
         XdY/ZagAdz2B0tXnVGM3G7CsG/Mqlwyo13zWxZojXEFkrnm5K/eIvX2V6xW8VPVIhsmq
         MLlCRn1coa1YilmS6bJp7uDz6C6YAKZIpTpnZjnU3nii8lu3qWpdBXipSejgMGvSygha
         CMVw==
X-Gm-Message-State: ACgBeo0m1b/+5GQE9XjAk6OMVpZhijkDi6IGW8wwilDF+cBupyn5ARUX
        6TnaRzgbb3GE3SUnsUK/e0E=
X-Google-Smtp-Source: AA6agR7hkeTohoGaJjhgtA8CfXg2W0fd0h/bAuB5KrY++D4WwyR1IKFSrp7c1x1jElWjopLCyzN+1g==
X-Received: by 2002:a17:907:2e01:b0:730:9ecc:cd28 with SMTP id ig1-20020a1709072e0100b007309ecccd28mr9199115ejc.360.1662718924383;
        Fri, 09 Sep 2022 03:22:04 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id h19-20020a1709063b5300b0074134543f82sm83874ejf.90.2022.09.09.03.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 03:22:04 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 9 Sep 2022 12:22:02 +0200
To:     kernel test robot <lkp@intel.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, kbuild-all@lists.01.org,
        syzbot+2251879aa068ad9c960d@syzkaller.appspotmail.com,
        bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next] bpf: Prevent bpf program recursion for raw
 tracepoint probes
Message-ID: <YxsTyh5DX07eryh9@krava>
References: <20220908114659.102775-1-jolsa@kernel.org>
 <202209091544.TU8KWEUM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202209091544.TU8KWEUM-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 09, 2022 at 03:27:57PM +0800, kernel test robot wrote:
> Hi Jiri,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on bpf-next/master]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Jiri-Olsa/bpf-Prevent-bpf-program-recursion-for-raw-tracepoint-probes/20220908-194832
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> config: x86_64-randconfig-c022 (https://download.01.org/0day-ci/archive/20220909/202209091544.TU8KWEUM-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/intel-lab-lkp/linux/commit/f68b567cfb6572c20e431242a440cc5f01452485
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Jiri-Olsa/bpf-Prevent-bpf-program-recursion-for-raw-tracepoint-probes/20220908-194832
>         git checkout f68b567cfb6572c20e431242a440cc5f01452485
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    ld: kernel/trace/bpf_trace.o: in function `__bpf_trace_run':
>    kernel/trace/bpf_trace.c:2046: undefined reference to `bpf_prog_inc_misses_counter'
> >> ld: kernel/trace/bpf_trace.c:2046: undefined reference to `bpf_prog_inc_misses_counter'
> >> ld: kernel/trace/bpf_trace.c:2046: undefined reference to `bpf_prog_inc_misses_counter'
> >> ld: kernel/trace/bpf_trace.c:2046: undefined reference to `bpf_prog_inc_misses_counter'
> >> ld: kernel/trace/bpf_trace.c:2046: undefined reference to `bpf_prog_inc_misses_counter'
>    ld: kernel/trace/bpf_trace.o:kernel/trace/bpf_trace.c:2046: more undefined references to `bpf_prog_inc_misses_counter' follow

ah right, trampoline.o is for JIT config only, will move
bpf_prog_inc_misses_counter to some common place

jirka

> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
