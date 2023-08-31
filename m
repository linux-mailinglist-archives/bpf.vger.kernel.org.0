Return-Path: <bpf+bounces-9028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B02978E732
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 09:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC719280D69
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 07:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F6A63BF;
	Thu, 31 Aug 2023 07:30:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79DF5258
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 07:30:03 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9445A1B1
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 00:30:01 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bc63ef9959so3697845ad.2
        for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 00:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1693467001; x=1694071801; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kHkD8InmtdxNYFBphrJMG48olpat1cNrjKg/T++oikw=;
        b=X2LJhVLDLe3qiBlg6znrNnaI62Id/93YkpkURgRh3gEty6ipgaRXVK/bZIy7KA2JHL
         7CqZfO+R7upsJaReVacXqxYhFSWyjS2uTl2PFkerymU9wuobdqp0nRleNM8V+GO6ROT1
         Seg9vo2SNrxpCSUACFD5RCX0kU4sKFCmGke3soI0bQeglm02KGiHiAt62dBMVR6O/Dx0
         cHJysZpTc0KMZHesn4KDuqxlx3JCM8FLskTtYa+HCwSnsrYvMvNCOgUw614bP39G2rGM
         MWFCuT0fgaICHCoEM+SCeJ2WgVjtcMq8+9M/jQ3fNDVijtWbc7BhfVC3+0gQxvhRPAkj
         kLsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693467001; x=1694071801;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kHkD8InmtdxNYFBphrJMG48olpat1cNrjKg/T++oikw=;
        b=HAxT5Mr7GbKL9RrsKdvUTg9Bxjacv1C72NlZN9JwAFrLe+PG9pYN+L97FPZeqgIJlN
         y+wJCDQSe99w4LS9qcOkxJRDWRw9XIvdIl3mRW8E9QiI3Tht5QCzeaATiJWX9/RMOJur
         zpu0ye7r2KvavemVyvm5sSdiheHrsQ7bVL7RqyMwAyLVcPpMvnIPvc428gLvHHWUf1jY
         LrClt7Iee/1A+DygTAZ3omyIvAep5M2T0v2CVPtxeX+zvFbVX9ZpgUxmbPw98JTgHn0K
         p8OjCtWhNk4ksPW743lR1ImuVlCebQziSP2dCDeb1EyYStD82tUsMLgAaGfzWmnvWhv3
         CtGw==
X-Gm-Message-State: AOJu0YzQqH0jsOxAffKU08F+aeMsFC4dvj7gesovXVL8TDV9zYe5DLdt
	+9aA6KybsW7kCPzQovBvy1oNeg==
X-Google-Smtp-Source: AGHT+IE5O2NqR8s3cBctEV1BFg7RgqUoh1WdEYsOUTORcefwrWw6BJhLjj6CuS6Bcy8/aQitmNUHGw==
X-Received: by 2002:a17:902:d4c9:b0:1c0:d777:3224 with SMTP id o9-20020a170902d4c900b001c0d7773224mr4655799plg.50.1693467000995;
        Thu, 31 Aug 2023 00:30:00 -0700 (PDT)
Received: from medusa.lab.kspace.sh (c-98-207-191-243.hsd1.ca.comcast.net. [98.207.191.243])
        by smtp.googlemail.com with ESMTPSA id ji5-20020a170903324500b001b80d399730sm647892plb.242.2023.08.31.00.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 00:30:00 -0700 (PDT)
Date: Thu, 31 Aug 2023 00:29:57 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Eric Dumazet <edumazet@google.com>
Cc: willemdebruijn.kernel@gmail.com, alexanderduyck@fb.com,
	bpf@vger.kernel.org, brouer@redhat.com, davem@davemloft.net,
	dhowells@redhat.com, keescook@chromium.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, willemb@google.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] skbuff: skb_segment, Call zero copy functions before
 using skbuff frags
Message-ID: <20230831072957.GA3696339@medusa>
References: <64ed7188a2745_9cf208e1@penguin.notmuch>
 <20230830232811.9876-1-mkhalfella@purestorage.com>
 <CANn89iJVnS_dGDtU7AVWgVrun-p68DZ0A3Pde47MHNeeQ2nwRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJVnS_dGDtU7AVWgVrun-p68DZ0A3Pde47MHNeeQ2nwRA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-08-31 08:58:51 +0200, Eric Dumazet wrote:
> On Thu, Aug 31, 2023 at 1:28 AM Mohamed Khalfella
> <mkhalfella@purestorage.com> wrote:
> >         do {
> >                 struct sk_buff *nskb;
> >                 skb_frag_t *nskb_frag;
> > @@ -4465,6 +4471,10 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
> >                     (skb_headlen(list_skb) == len || sg)) {
> >                         BUG_ON(skb_headlen(list_skb) > len);
> >
> > +                       nskb = skb_clone(list_skb, GFP_ATOMIC);
> > +                       if (unlikely(!nskb))
> > +                               goto err;
> > +
> 
> This patch is quite complex to review, so I am asking if this part was
> really needed ?

Unfortunately the patch is complex because I try to avoid calling
skb_orphan_frags() in the middle of processing these frags. Otherwise
it would be much harder to implement because as reallocated frags do not
map 1:1 with existing frags as Willem mentioned.

> <1>  : You moved here <2> and <3>

<2> was moved here because skb_clone() calls skb_orphan_frags(). By
moving this up we do not need to call skb_orphan_frags() for list_skb
and we can start to use nr_frags and frags without worrying their value
is going to change.

<3> was moved here because <2> was moved here. Fail fast if we can not
clone list_skb.

> 
> If this is not strictly needed, please keep the code as is to ease
> code review...
> 
> >                         i = 0;
> >                         nfrags = skb_shinfo(list_skb)->nr_frags;
> >                         frag = skb_shinfo(list_skb)->frags;
> > @@ -4483,12 +4493,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
> >                                 frag++;
> >                         }
> >
> > -                       nskb = skb_clone(list_skb, GFP_ATOMIC);
> 
> <2>
> 
> >                         list_skb = list_skb->next;
> >
> > -                       if (unlikely(!nskb))
> > -                               goto err;
> > -
> 
> <3>
> 
> >                         if (unlikely(pskb_trim(nskb, len))) {
> >                                 kfree_skb(nskb);
> >                                 goto err;
> > @@ -4564,12 +4570,16 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
> >                 skb_shinfo(nskb)->flags |= skb_shinfo(head_skb)->flags &
> >                                            SKBFL_SHARED_FRAG;
> >
> > -               if (skb_orphan_frags(frag_skb, GFP_ATOMIC) ||
> > -                   skb_zerocopy_clone(nskb, frag_skb, GFP_ATOMIC))
> > +               if (skb_zerocopy_clone(nskb, list_skb, GFP_ATOMIC))
> 
> Why using list_skb here instead of frag_skb ?
> Again, I have to look at the whole thing to understand why you did this.

Oops, this is a mistake. It should be frag_skb. Will fix it run the test
one more time and post v3.

