Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA4C5EAA05
	for <lists+bpf@lfdr.de>; Mon, 26 Sep 2022 17:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbiIZPPc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Sep 2022 11:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235877AbiIZPOj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 11:14:39 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFFEBE4
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 06:58:13 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id y8so9123758edc.10
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 06:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=YGGpKyh9ea6QVpsV3ythX9W10IeF68hCtLrbkLYrbcU=;
        b=qsBaoWuVqNGVHOvt1rQ9Kv6sC6QNN3/uGcA0b5crilcTGyY9yufqt3oUH+8YmWPFDJ
         dNqZx16PymMscK9v3Q3si0p6fXTVf/vxKbbt7GxDvd6Jr9vA0IOzz78q8EL1duq2Hugp
         zNnI2EPzaLjO9AMGkyot2VHrLS6LcxNwVcW/Rwf5PByt/FjEaCP7j4om89NMNip79Wrl
         Mhedgs9wHupP05JiFjH0NMHUbO76VXQHEW+ZUezz5ggyAfgfnyDCDAXYvhhynv0t5zTM
         Ur8aF/OeNuZH6flFuNmzJCbE1q8Ju/oEPdG7eG8TJNj4cKuFhBpU771PXgVsSbzuw32Y
         Axwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=YGGpKyh9ea6QVpsV3ythX9W10IeF68hCtLrbkLYrbcU=;
        b=XCRlxDIPUlTTz29oegkdzot9X8tMP+dESbayJsqIIwpM6sXEUQP9xDTOxw5ltkttl/
         S8xrXI2o2bJGyUKyS3TSWN/0HB4y0SyxfspOIWovm3IlEOOwMX7JWSq5CJKht9egghAt
         HtrZPRRefV64Yu6yOyFym2C5+QwNSJ96Otbaw53wJNGJkGi2VY8Pof9uP8mcOZDolcQ1
         oweYFgRweVv2FsnmL5mPKq7QUTf1bURDfwLWIp3UUAJoN64NBcnUvz9BDtJ8q8a3Rb3G
         JTsxGbIKdJCDNxFNwW132y6WfYqjoUcedgnD0iYmcRe+GK9AYh/rIYgoxuzwYJ1y3kva
         xcig==
X-Gm-Message-State: ACrzQf3VpHU5pp00SJxAEtLTvJ99YOfP/0Xga4OYdN7FVBWxSiFQ5FhQ
        cVsGBPtof+8NDNn8VB6+XHc=
X-Google-Smtp-Source: AMsMyM4FPeGVkogVk05hRb568RxYDm3S+TB7ODT9cWiIEP3VISQW8TvlaY6b8HGwIe7ftCAHHZUsAA==
X-Received: by 2002:a05:6402:1909:b0:451:ace7:ccbd with SMTP id e9-20020a056402190900b00451ace7ccbdmr22321989edz.276.1664200692230;
        Mon, 26 Sep 2022 06:58:12 -0700 (PDT)
Received: from krava ([83.240.61.46])
        by smtp.gmail.com with ESMTPSA id s21-20020a1709062ed500b0077077b59085sm8254921eji.184.2022.09.26.06.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 06:58:11 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 26 Sep 2022 15:58:09 +0200
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Martynas Pumputis <m@lambda.lt>
Subject: Re: [PATCHv4 bpf-next 5/6] bpf: Return value in kprobe get_func_ip
 only for entry address
Message-ID: <YzGv8XOiRv9INCkI@krava>
References: <20220922210320.1076658-1-jolsa@kernel.org>
 <20220922210320.1076658-6-jolsa@kernel.org>
 <CAEf4BzbuWK3Ud=dwSv9-gDDsqX=ZWpZaFS=YL_SRiYsSBr+W2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbuWK3Ud=dwSv9-gDDsqX=ZWpZaFS=YL_SRiYsSBr+W2w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 23, 2022 at 02:42:07PM -0700, Andrii Nakryiko wrote:
> On Thu, Sep 22, 2022 at 2:04 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Changing return value of kprobe's version of bpf_get_func_ip
> > to return zero if the attach address is not on the function's
> > entry point.
> >
> > For kprobes attached in the middle of the function we can't easily
> > get to the function address especially now with the CONFIG_X86_KERNEL_IBT
> > support.
> >
> > If user cares about current IP for kprobes attached within the
> > function body, they can get it with PT_REGS_IP(ctx).
> >
> > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  kernel/trace/bpf_trace.c                             | 5 ++++-
> >  tools/testing/selftests/bpf/progs/get_func_ip_test.c | 4 ++--
> >  2 files changed, 6 insertions(+), 3 deletions(-)
> >
> 
> Can you please add a note in bpf_get_func_ip() description in
> uapi/linux/bpf.h that this function returns zero for kprobes in the
> middle of the function?

yep, will do that

thanks,
jirka

> 
> With that:
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> 
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index ebd1b348beb3..688552df95ca 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -1048,7 +1048,10 @@ BPF_CALL_1(bpf_get_func_ip_kprobe, struct pt_regs *, regs)
> >  {
> >         struct kprobe *kp = kprobe_running();
> >
> > -       return kp ? (uintptr_t)kp->addr : 0;
> > +       if (!kp || !(kp->flags & KPROBE_FLAG_ON_FUNC_ENTRY))
> > +               return 0;
> > +
> > +       return get_entry_ip((uintptr_t)kp->addr);
> >  }
> 
> [...]
