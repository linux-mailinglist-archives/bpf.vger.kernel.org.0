Return-Path: <bpf+bounces-8524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E337879EB
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 23:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFC4D1C20F01
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 21:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F8879EE;
	Thu, 24 Aug 2023 21:09:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF057F
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 21:09:44 +0000 (UTC)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E874D1BCA
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 14:09:42 -0700 (PDT)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-76d83954c40so17149985a.1
        for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 14:09:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692911382; x=1693516182;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2eMTRE+HcHR14MWPk5Eh0qDhKI4qrnk3q2PBWCbbXmY=;
        b=g+Rx2bO4Cu/gHGBXCReUFRRzm7LGWZhvv71fdexs3UhrvKz2nr912NtNgAkR9r0cMP
         zV5LxRvHwASr7j0/FGNOh1/Pv1zSya73b3/SXizYiKGW9MyVnEwMQtW3Fmuo4131opQn
         ZuUfqycpgGvEbttzrJP+n6H19tktzIhKoDYsGfU4x/ICS8CcDOXIUhJ67IORh/d0hakh
         CYrYLS7dmoA2QSLo0QpWmDKyRiyVUgvMxI/4BgoC+39etVI9ba9mHXtHsavFxEzJZDAZ
         uxzZEFnGJDowGIuHVAzSZEtK/JS9/hDg+ZP4YNTlL/4xOrF2YepIozNJuNkYOIUZG17A
         mrvw==
X-Gm-Message-State: AOJu0YxXWvKt5T3gXjLxh8WnDDYprxLezMNpPRW8i40VEAyYd+XmjEXd
	fj/AQyyguhIB+Y15XQ/LwGXbKUG3u/826A==
X-Google-Smtp-Source: AGHT+IFZLcQvRh/kgjFEKqRW2wTLJ+TcioxI2dnErGiGHI1pJYL11hpza1m5toq/QdKbV6wjkTcfiA==
X-Received: by 2002:a05:620a:b03:b0:76c:97a9:8ff0 with SMTP id t3-20020a05620a0b0300b0076c97a98ff0mr15725528qkg.77.1692911381851;
        Thu, 24 Aug 2023 14:09:41 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:1df8])
        by smtp.gmail.com with ESMTPSA id cx15-20020a05620a51cf00b007682757a65esm88889qkb.45.2023.08.24.14.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 14:09:41 -0700 (PDT)
Date: Thu, 24 Aug 2023 16:09:39 -0500
From: David Vernet <void@manifault.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrew Werner <awerner32@gmail.com>, Hou Tao <houtao@huaweicloud.com>,
	bpf@vger.kernel.org, kernel-team@dataexmachina.dev
Subject: Re: [PATCH] libbpf: handle producer position overflow
Message-ID: <20230824210939.GB11642@maniforge>
References: <20230724132404.1280848-1-awerner32@gmail.com>
 <CAEf4BzZQQ=fz+NqFHhJcqKoVAvh4=XbH7HWaHKjUg5OOzi-PTw@mail.gmail.com>
 <b226284c-ad1f-ffe8-b10e-94bbf7a00bc7@huaweicloud.com>
 <CAEf4BzZvBP9fPs7cfrvLvnha-v_9=pVM=uN=vuOXzWqKCZGeyw@mail.gmail.com>
 <CA+vRuzMP+Z4hqEK3g1c51wSO7aSfBb9=d54102puFrR_r_FJyg@mail.gmail.com>
 <CAEf4BzbG0UvhYbDK1u8nhBEsgyYQxmoNGHgKyeQSH5Spr6As6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbG0UvhYbDK1u8nhBEsgyYQxmoNGHgKyeQSH5Spr6As6A@mail.gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 23, 2023 at 05:07:42PM -0700, Andrii Nakryiko wrote:

[...]

> > > > > BTW, I think kernel code needs fixing as well in
> > > > > __bpf_user_ringbuf_peek (we should compare consumer/producer positions
> > > > > directly, only through subtraction and casting to signed long as
> > > > > above), would you be able to fix it at the same time with libbpf?
> > > > > Would be good to also double-check the rest of kernel/bpf/ringbuf.c to
> > > > > make sure we don't directly compare positions anywhere else.
> > > >
> > > > I missed __bpf_user_ringbuf_peek() when reviewed the patch. I also can
> > > > help to double-check kernel/bpf/ringbuf.c.
> > >
> > > great, thanks!

Good catch, and thanks!

> >
> > I'll update the code in __bpf_user_ringbuf_peek. One observation is
> > that the code there differs from the regular (non-user) ringbuf and
> > the libbpf code in that it uses u64 for the positions whereas
> > everywhere else (including in the struct definition) the types of
> > these positions are unsigned long. I get that on 64-bit architectures,
> > practically speaking, these are the same. What I'm less clear on is
> > whether there's anything that prevents this code from running (perhaps
> > with bugs) on 32-bit machines. I suppose that on little-endian
> > machines things will just work out until the positions overflow 32
> > bits.
> >
> > Would it make sense for me to make the change to always use unsigned
> > long for these values in the same change?
> 
> I'm not sure, but I suspect that u64 usage is not intentional, so we
> probably do want to use unsigned long consistently.

Yeah, that was an oversight and should be fixed. Thanks for pointing it
out Andrew. FYI, we'd also need to fix user_ring_buffer__reserve() in
libbpf.

Andrew -- I'm happy to send a patch that fixes this. If you'd like to
send it out, please feel free to do so. Just let me know.

Thanks,
David

