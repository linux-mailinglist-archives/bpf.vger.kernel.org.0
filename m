Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3A65B16ED
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 10:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbiIHI0j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 04:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbiIHI00 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 04:26:26 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEED0D9E83
        for <bpf@vger.kernel.org>; Thu,  8 Sep 2022 01:26:17 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id b17so11391357wrq.3
        for <bpf@vger.kernel.org>; Thu, 08 Sep 2022 01:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=p9uUKLveGGOPSRKeoIbIaua3XArD1ngw6AnYvZldqSc=;
        b=fb2YmAH+gOyj4m1dznwDkzxCmVOu3g/DHkxUNsSFdwkJwBHDhc+ozMbAooNRq6LAuB
         C2mT112WpwjG77gY0CSS2YP29SNzPTDA/gfzzo4im3HIWhFqGdKG7bxS5NyBdk1TgTwm
         qS3HPbOuX++jEsHNMCP8n1CilB4FGrrwD8vKCIoIBTJu5W3+3DlWrJditW266k/mP8c+
         Ju4KW2DUH95QABowJIO/h0gGZ4P0VVdzAqhOQZrj2eP0EEly/lHTKYBBUYF2WVMV+aWU
         Jd9HpIsV2ZUjrNbPkQ/r5sfdheiS23UwIQTPH4shuFPF9iW/kn+1U8yK1bd725cfi939
         87Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=p9uUKLveGGOPSRKeoIbIaua3XArD1ngw6AnYvZldqSc=;
        b=eSyeL6TJMOidEI4uW3UwMB1DBDdvujA8dp3m9jLyPqd22YL4t6uEu/YcUCEy/dQbuN
         3Ec+IKM7RaSvmKh1uW5ONxGU1ljnHyIqBjA49HsEo+2939yi40/3tomavUQC8JKJoyyH
         v3bItGXqPGeuH+7BAKkvb/xVPIOy/gZyiIJZWPRY/g9CkgBqJEo0Fdr9c0NXUmNBmiHs
         SI5DhOdd6Cu5trtQRcxRMNpJPQ7ulHff841Az5ryG51eU8iCutHLn5+OyenaIexgy7lb
         DKtkDQFgWOAH0+xhDMmm+lCbrPly+/gHSuwf5e3bJs7gUDcfsdizBcIR2t4bf4t9KllI
         ir0A==
X-Gm-Message-State: ACgBeo1Ki00yTMk2tVbEbqvTI8+wcV8docc60n39psQ6RaEfStqbzUr4
        moBdJ8McQRU77Xt4EUaawjs=
X-Google-Smtp-Source: AA6agR4rBSg3lLNV9w+AQesIq/92G28i2GAbmALr7qe3k3lDilgTt3hS05fg3eAOaFS4g+JCjp/fSg==
X-Received: by 2002:adf:fb8d:0:b0:225:4d57:17a6 with SMTP id a13-20020adffb8d000000b002254d5717a6mr4305631wrr.251.1662625575467;
        Thu, 08 Sep 2022 01:26:15 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id l21-20020a05600c4f1500b003a607e395ebsm2518737wmq.9.2022.09.08.01.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 01:26:15 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 8 Sep 2022 10:26:12 +0200
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCHv2 bpf-next 1/6] kprobes: Add new
 KPROBE_FLAG_ON_FUNC_ENTRY kprobe flag
Message-ID: <YxmnJBEhQ7x2Yy+H@krava>
References: <20220811091526.172610-1-jolsa@kernel.org>
 <20220811091526.172610-2-jolsa@kernel.org>
 <Yw4n/NmFRuYivgi6@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yw4n/NmFRuYivgi6@krava>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

ping, thanks

On Tue, Aug 30, 2022 at 05:08:44PM +0200, Jiri Olsa wrote:
> Masami,
> could you please check on this one?
> 
> thanks,
> jirka
> 
> On Thu, Aug 11, 2022 at 11:15:21AM +0200, Jiri Olsa wrote:
> > Adding KPROBE_FLAG_ON_FUNC_ENTRY kprobe flag to indicate that
> > attach address is on function entry. This is used in following
> > changes in get_func_ip helper to return correct function address.
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/linux/kprobes.h | 1 +
> >  kernel/kprobes.c        | 6 +++++-
> >  2 files changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> > index 55041d2f884d..a0b92be98984 100644
> > --- a/include/linux/kprobes.h
> > +++ b/include/linux/kprobes.h
> > @@ -103,6 +103,7 @@ struct kprobe {
> >  				   * this flag is only for optimized_kprobe.
> >  				   */
> >  #define KPROBE_FLAG_FTRACE	8 /* probe is using ftrace */
> > +#define KPROBE_FLAG_ON_FUNC_ENTRY	16 /* probe is on the function entry */
> >  
> >  /* Has this kprobe gone ? */
> >  static inline bool kprobe_gone(struct kprobe *p)
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index f214f8c088ed..a6b1b5c49d92 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -1605,9 +1605,10 @@ int register_kprobe(struct kprobe *p)
> >  	struct kprobe *old_p;
> >  	struct module *probed_mod;
> >  	kprobe_opcode_t *addr;
> > +	bool on_func_entry;
> >  
> >  	/* Adjust probe address from symbol */
> > -	addr = kprobe_addr(p);
> > +	addr = _kprobe_addr(p->addr, p->symbol_name, p->offset, &on_func_entry);
> >  	if (IS_ERR(addr))
> >  		return PTR_ERR(addr);
> >  	p->addr = addr;
> > @@ -1627,6 +1628,9 @@ int register_kprobe(struct kprobe *p)
> >  
> >  	mutex_lock(&kprobe_mutex);
> >  
> > +	if (on_func_entry)
> > +		p->flags |= KPROBE_FLAG_ON_FUNC_ENTRY;
> > +
> >  	old_p = get_kprobe(p->addr);
> >  	if (old_p) {
> >  		/* Since this may unoptimize 'old_p', locking 'text_mutex'. */
> > -- 
> > 2.37.1
> > 
