Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CF1692435
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 18:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjBJRNm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Feb 2023 12:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbjBJRNl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Feb 2023 12:13:41 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E335D79B3A
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 09:13:12 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id mi9so5796871pjb.4
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 09:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KhHlalZmywOH+WNQmjNbQaoqBvPW7xEH+ibb/WHMVVw=;
        b=HetRwpcYUvN9JuRiaOjD6jHqaTowwERRGtkmd80/HGIZX3pxeOuwGBzQLgdA0o3/fB
         fRz6lsapSpJ8c/tDJ22TMtK50PMZ3cGdn9i4KdrXMC/C54CyQY/BfdyEobDvnkd/sn7C
         +1wiyT0ZLuuQechgPicqpqmh1XaXwi8m+gpFWFV2J0wMxmucN9Sy1d4NSqnZWWCNRQ+Z
         YuR5WgfzRNM1DQzazIC+mIWaqnBcG0E8vDt6L8sg4GaqTiUUy6TOlWVUpZZKfEB3IaiY
         1vFrECyYLaCyTbBACG7ky+Tf1zPj+/4aZ8GENi9IpAKmwt+b2nXYNXQnjZGpEEiKpxHD
         6hfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KhHlalZmywOH+WNQmjNbQaoqBvPW7xEH+ibb/WHMVVw=;
        b=55gw6tVwbyTZeP+9kNDcl1F0s0yCclA8vhrr+0DwGDpxkpq4VoGgIdxaZPWRd4ibJv
         zNnBJA/Y203IbQ9s/imSS2X8OhjdEurmPp6t0hGbn2hw45dWHgdKvJitii+AXVhu6Adn
         fLcrhSawDRvdd7CG740bY/SJMUl+3+Dk40ng698ISSakGyJixRgQGEiEEjoGojxEcBgd
         0Wq4nqSmcaL2sTv/MLh8PzcW4XNsFfPXJEDSO/oOjBo9mGi7x5Ji3C8LXH1mNzgXzBAr
         /s09wZWAsOpjoSLY5sjY4ImSG6gH+7+ttgpGfm1sAnq9cmNsnX0OfsOLeq8O8Bkbe5M3
         LlJg==
X-Gm-Message-State: AO0yUKW5h1CqXc11cpVelp37dPQnZ5GErMPTI8OIeNn+Fc9DY3OCJBOK
        cjJt1trzmVrsdu5fT+7tyQXm/rMIm0E=
X-Google-Smtp-Source: AK7set99eeQdSlpoqzZEOHkGW9UzPsJ46GupHy6fg8uH8cA85tZr2KQxiRvPRMIIpFFZ80FZA38i7A==
X-Received: by 2002:a17:903:182:b0:193:2bed:3325 with SMTP id z2-20020a170903018200b001932bed3325mr18842524plg.15.1676049192165;
        Fri, 10 Feb 2023 09:13:12 -0800 (PST)
Received: from MacBook-Pro-6.local ([2620:10d:c090:400::5:c6db])
        by smtp.gmail.com with ESMTPSA id v22-20020a170902e8d600b001949f21e1d2sm21481plg.308.2023.02.10.09.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 09:13:11 -0800 (PST)
Date:   Fri, 10 Feb 2023 09:13:09 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v4 bpf-next 01/11] bpf: Migrate release_on_unlock logic
 to non-owning ref semantics
Message-ID: <20230210171309.mognngvzkzx5vztt@MacBook-Pro-6.local>
References: <20230209174144.3280955-1-davemarchevsky@fb.com>
 <20230209174144.3280955-2-davemarchevsky@fb.com>
 <20230210132413.o3nokabu5vk3mtgn@apollo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210132413.o3nokabu5vk3mtgn@apollo>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 10, 2023 at 02:24:13PM +0100, Kumar Kartikeya Dwivedi wrote:
> > [...]
> > +static void invalidate_non_owning_refs(struct bpf_verifier_env *env,
> > +				       struct bpf_active_lock *lock)
> > +{
> > +	struct bpf_func_state *unused;
> > +	struct bpf_reg_state *reg;
> > +
> > +	bpf_for_each_reg_in_vstate(env->cur_state, unused, reg, ({
> > +		if (reg->non_owning_ref_lock.ptr &&
> > +		    reg->non_owning_ref_lock.ptr == lock->ptr &&
> > +		    reg->non_owning_ref_lock.id == lock->id)
> > +			__mark_reg_unknown(env, reg);
> 
> Probably better to do:
> 
> 	if (!env->allow_ptr_leaks)
> 		__mark_reg_not_init(...);
> 	else
> 		__mark_reg_unknown(...);

That's redundant. kfuncs and any PTR_TO_BTF_ID access requires allow_ptr_leaks.
See first check in check_ptr_to_btf_access()
