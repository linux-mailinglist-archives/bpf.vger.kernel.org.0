Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C340629FBC
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 17:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiKOQ5w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 11:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiKOQ5k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 11:57:40 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CA92656A
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 08:57:39 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id l2so13679370pld.13
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 08:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SsH2wmFl7WrFBxksdPKExwFloYcnDnh/OUBbKDlx6bI=;
        b=LZT+fTmn9A2v8uLY+zfWA2+1L77en0+uy4LR59P9SJP1d/gR6NoDHhykZgIEaSj0wI
         gdZcOTT/nf0ILgY5sile0HvJ3FgPZ3oxxNcDNuLYFMVK4l55eQfwzf47qejMq7G5sfyk
         TTJv/HMV8QrV41TJhLL90bTF5xr2EzAG0HQMN35smyzTPas7PxQNBz5cYLDIcEPNWQlM
         5URjoGqSCu2PzwzNR62O0V7xNX6TDfM4XsO5+rXTKdvhsY2CJL/yJGoxkdHtbHSvAjjU
         qljyQjedoyuqI2/ELOZCx/Gl9CNpMx7EzWhOQI7vX6oaHFVA7e4aPtq4mDfbf06jSSEL
         eOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SsH2wmFl7WrFBxksdPKExwFloYcnDnh/OUBbKDlx6bI=;
        b=WRFqPSHBQK6LIRkmYnLC7TGY2Dsk05X5+qbk1dfXSyapGk2D/8z1asXZQ42GbdzGpO
         KwTlXAiYulG4/90FLA2vSmT0IYxi1CzYov4nbTbu8mZxgGCIitz0SkhOnok5xXSosXol
         lf81mX4H7XPwvNyVR4KK7nqK/YhxJX1jfxRCrqStaJHwJzWsOGfz9vUPmNWvgH5hx/dV
         KRboLe0yHXepWOkGjP6rCFu21w+S+N93NW4W6VmvG5gCcZ8DhYVhztsBhJ1PMk4UI49l
         uhrT0OvqHbkhZX8zDtA0DylHlCGhKR1Ak25zVEOT2WelX1qK2gVLCkXusnz+PZ03eMSV
         G85Q==
X-Gm-Message-State: ANoB5pnQgSSmY2epkU/JHVCfovDhhMcut0KQN0BJUc5dO7QxljviHmbC
        UNPGVMYCzywoid9cL1uTtqQ=
X-Google-Smtp-Source: AA0mqf6k6IeH5bfwtVatrcA486c8Z+e/wyOiReRaNbrmmNiBO1N/K5Vw02RtM6AWUwJ6kRKT5Qad8g==
X-Received: by 2002:a17:902:d506:b0:186:944d:469 with SMTP id b6-20020a170902d50600b00186944d0469mr4886553plg.29.1668531458789;
        Tue, 15 Nov 2022 08:57:38 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id ij15-20020a170902ab4f00b001869f2120absm10044426plb.294.2022.11.15.08.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 08:57:38 -0800 (PST)
Date:   Tue, 15 Nov 2022 22:27:33 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: Re: [PATCH bpf-next v7 19/26] bpf: Permit NULL checking pointer with
 non-zero fixed offset
Message-ID: <20221115165733.t77fukodwgvv6g72@apollo>
References: <20221114191547.1694267-1-memxor@gmail.com>
 <20221114191547.1694267-20-memxor@gmail.com>
 <20221115062319.3hkphudyakopnqvb@macbook-pro-5.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221115062319.3hkphudyakopnqvb@macbook-pro-5.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 15, 2022 at 11:53:19AM IST, Alexei Starovoitov wrote:
> On Tue, Nov 15, 2022 at 12:45:40AM +0530, Kumar Kartikeya Dwivedi wrote:
> >  	if (type_may_be_null(reg->type) && reg->id == id &&
> >  	    !WARN_ON_ONCE(!reg->id)) {
> > -		if (WARN_ON_ONCE(reg->smin_value || reg->smax_value ||
> > -				 !tnum_equals_const(reg->var_off, 0) ||
> > -				 reg->off)) {
> > +		if (reg->smin_value || reg->smax_value || !tnum_equals_const(reg->var_off, 0) || reg->off) {
> ....
> > +			if (WARN_ON_ONCE(reg->smin_value || reg->smax_value || !tnum_equals_const(reg->var_off, 0)))
>
> That is too much copy-paste between two lines.
> Please combine the checks.

I have rewritten it like this:

if (WARN_ON_ONCE(reg->smin_value || reg->smax_value || !tnum_equals_const(reg->var_off, 0))) ‣a: reg->var_off ‣b: 0 ‣: int
	  return;
if (reg->type != (PTR_TO_BTF_ID | MEM_ALLOC | PTR_MAYBE_NULL) && WARN_ON_ONCE(reg->off)) ‣: int
	  return;

I prefer to keep the WARN, as it would be pretty clearly a verifier bug that
would be silently missed since the return type is void.
