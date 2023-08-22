Return-Path: <bpf+bounces-8238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B8B784145
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 14:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59DC0281028
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 12:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3051C2B5;
	Tue, 22 Aug 2023 12:54:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB687F
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 12:54:28 +0000 (UTC)
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FCACC7
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 05:54:26 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 2adb3069b0e04-50087d47d4dso1821353e87.1
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 05:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692708865; x=1693313665;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qLfF5dkwUQy3iuhgKM3YNOOiHzUS8in6ab8toi9Yd3Q=;
        b=LFAEeNHaJbEe6cMe88bCjgd1xz9W3R7QLWGvCb4gzQ8xt8Ckc2gwNTiJBMpTq891Wa
         miFS3+DptpRH2zeiJa4GD+aZEGn27f2uHYkiEWgyQbP5OZ3NFyDZ+VAGqlcAseqgrDR2
         0OW8Ca9M8RRsxgc74yRXIwb5KJ1NGoT+oYeYiY40t7BbTFkqR1O/oOP2kzpPPn5Mn2wa
         jFa4oh9k3fCDtumulLLH+39YllDScqjlMcc9YWOw7RdfgXfT0NxLuIY53fHIZM+IMrAE
         71KQz9gPpNJp0tU+8/c7eDYg1WwjJwFDVsF7C+bARHJV5S10qCMeJvrTvTiPfa16OeXw
         byfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692708865; x=1693313665;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qLfF5dkwUQy3iuhgKM3YNOOiHzUS8in6ab8toi9Yd3Q=;
        b=LH5bHNfQPKEYKl7y24G4+xK9wbByxXbKLlTrh/wq2mJAxvU4o0fSOW8+Z0dwnCFZRZ
         O0/k/FOJQDCcNz1r6Uhxb+iyUom2C9/wNolxhyQV05vsuAoOlt6um9Uc24y6XPcybSIa
         jdWFjY6C3An21SJuc1qT4RenuTCwn42Mh9cT+U5DNe6FMv/ZEruXUWZcmFANas9134Wc
         z2ecPW+XrkcA6addWd3dHhtB1En3xLToHPECHRUqkZ2gajN0bcxves6cHwBHUR9Fg7yb
         9JJmQmpo6DrkSzi6nMJ5YfrJQG+8VYOkwRnN/GHI8VVVYnh82aoSiu42plnnYo3P7nJf
         xSNQ==
X-Gm-Message-State: AOJu0Yw2uo9fbT52KJyen01RK8XfR9D3y60xbsz5xzdD31XMBHrHhU7g
	BI3S0B9ClZB9llIcUUArgF4kLQFGxz3Ik49ZAJJOd4R2qt9uRg==
X-Google-Smtp-Source: AGHT+IEKgtJYH9ALMHrF0Wn13pwfn4l5ra2i5Om+1CXQNVHNvbUYotqQDC1lb3z0u302VwhrceVbQ7dIGxwyjo3GQqA=
X-Received: by 2002:a05:6512:1587:b0:4fd:d470:203b with SMTP id
 bp7-20020a056512158700b004fdd470203bmr8484078lfb.69.1692708864884; Tue, 22
 Aug 2023 05:54:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230809114116.3216687-1-memxor@gmail.com> <20230809114116.3216687-4-memxor@gmail.com>
 <20230822051256.zzdmff3iilmankpg@macbook-pro-8.dhcp.thefacebook.com>
In-Reply-To: <20230822051256.zzdmff3iilmankpg@macbook-pro-8.dhcp.thefacebook.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 22 Aug 2023 18:23:48 +0530
Message-ID: <CAP01T74bbyMbeh85bNEa1SyW_wOwuE-y4qcRC8u9KQ=QapCH2Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 03/14] bpf: Implement BPF exceptions
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 22 Aug 2023 at 10:43, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Aug 09, 2023 at 05:11:05PM +0530, Kumar Kartikeya Dwivedi wrote:
> > +
> > +static bool bpf_stack_walker(void *cookie, u64 ip, u64 sp, u64 bp)
> > +{
> > +     struct bpf_throw_ctx *ctx = cookie;
> > +     struct bpf_prog *prog;
> > +
> > +     if (!is_bpf_text_address(ip))
> > +             return !ctx->cnt;
> > +     prog = bpf_prog_ksym_find(ip);
> > +     ctx->cnt++;
> > +     if (!prog->aux->id)
> > +             return true;
> > +     ctx->aux = prog->aux;
> > +     ctx->sp = sp;
> > +     ctx->bp = bp;
> > +     return false;
> > +}
>
> Took me some time to understand what !prog->aux->id is doing.
> Let's add a helper: is_subprog() and check:
> prog->aux->func_idx != 0
> since that's what arm64, x64, s390 JITs are using.

Ack, I will fix it.

