Return-Path: <bpf+bounces-9030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6731478E753
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 09:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F1382810B4
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 07:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447066FB4;
	Thu, 31 Aug 2023 07:43:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF146FA2
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 07:43:28 +0000 (UTC)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA9BCE0
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 00:43:26 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-407db3e9669so180571cf.1
        for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 00:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693467805; x=1694072605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/yP9Hex2mzmKq9qt42F0CpGQPzC37DJdUwVClKUJvM=;
        b=Wfzg+DGS8qVa4YrtZG5khX9q/iXJgiAUSYPehA4DGtUjIlh79bUGwbktAHBVpcur+g
         0zJrPXi7snmZ+YIhM0+wTB+E86uuwLGDxH9tCutuCcROVhkLLEZM65zfl0Bxoza5IwsD
         XeuN61RNgZsPA17ciuMzv4w2VyokdEh9C3MheNFzZAdg/OSFYWIoibpAm2lOBC0GTd8w
         yw7780bHoRvfcR2vFLXWrfIDO6h5LPScY2OQCqS3QgvIb528Hq4GpGpRwNQ5wD9deKIj
         Y6b9MzBPCZ/LEcdQpiAsk+iVSR8VlnMOR0LIuyi86YyNQLOmXMbPshQrCPTBYXLJVyqK
         3qPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693467805; x=1694072605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/yP9Hex2mzmKq9qt42F0CpGQPzC37DJdUwVClKUJvM=;
        b=KhkmGWfESYdv7QX9TdzxuNb+10/1WVtk8yhXQim3OkVyhB53+SbQKKU7q3mtRCbPzn
         8BQLzEHJl5TkdpNX4/imouR6SQ700pzYO7CXabVs1wjzGksLnUhLY9cI/SZiGOZapECh
         syKJIkoOZ3/arLTTp+CCm0XlMhY+gQdXpOvWgLKkPNDcbTUwi4pZ41JIIsvri03fKJ2C
         7rDoORTzeZkFDjHTFDaX/kiEn70tp7kLpumy8JkgxVheFlhS19GL1tY/ItQInFsy23np
         rG5+oRuow0byNnggqvBIggyZ9EH/MCOQ9NbmBjOJPIQfJOZfRgF00p8Bq6lvhoHPmrRG
         nfAQ==
X-Gm-Message-State: AOJu0YxzuEur3PYA/DiIIQJtHa8s2zgPM2R9DG+0JSR0ieyP95I7MI+r
	G76SiGBWrJdFd4kGWnQ73XQsMMDRe+nSb3Iq3x/ATA==
X-Google-Smtp-Source: AGHT+IHie0Dk2J204QFPIL1R69ZKhIXfwsmjixwhPxeDxqBowkuZ/sWGD9yhup18zNzoNI9H50sl/FNxkLPX/07WS24=
X-Received: by 2002:a05:622a:130d:b0:403:aa88:cf7e with SMTP id
 v13-20020a05622a130d00b00403aa88cf7emr116118qtk.29.1693467805394; Thu, 31 Aug
 2023 00:43:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <64ed7188a2745_9cf208e1@penguin.notmuch> <20230830232811.9876-1-mkhalfella@purestorage.com>
 <CANn89iJVnS_dGDtU7AVWgVrun-p68DZ0A3Pde47MHNeeQ2nwRA@mail.gmail.com> <20230831072957.GA3696339@medusa>
In-Reply-To: <20230831072957.GA3696339@medusa>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 31 Aug 2023 09:43:14 +0200
Message-ID: <CANn89iL52irOwq+nL=UManHd1m8KQLswcLh9vrz-6u4CC6RchA@mail.gmail.com>
Subject: Re: [PATCH v2] skbuff: skb_segment, Call zero copy functions before
 using skbuff frags
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: willemdebruijn.kernel@gmail.com, alexanderduyck@fb.com, 
	bpf@vger.kernel.org, brouer@redhat.com, davem@davemloft.net, 
	dhowells@redhat.com, keescook@chromium.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	willemb@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 31, 2023 at 9:30=E2=80=AFAM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> On 2023-08-31 08:58:51 +0200, Eric Dumazet wrote:
> > On Thu, Aug 31, 2023 at 1:28=E2=80=AFAM Mohamed Khalfella
> > <mkhalfella@purestorage.com> wrote:
> > >         do {
> > >                 struct sk_buff *nskb;
> > >                 skb_frag_t *nskb_frag;
> > > @@ -4465,6 +4471,10 @@ struct sk_buff *skb_segment(struct sk_buff *he=
ad_skb,
> > >                     (skb_headlen(list_skb) =3D=3D len || sg)) {
> > >                         BUG_ON(skb_headlen(list_skb) > len);
> > >
> > > +                       nskb =3D skb_clone(list_skb, GFP_ATOMIC);
> > > +                       if (unlikely(!nskb))
> > > +                               goto err;
> > > +
> >
> > This patch is quite complex to review, so I am asking if this part was
> > really needed ?
>
> Unfortunately the patch is complex because I try to avoid calling
> skb_orphan_frags() in the middle of processing these frags. Otherwise
> it would be much harder to implement because as reallocated frags do not
> map 1:1 with existing frags as Willem mentioned.
>
> > <1>  : You moved here <2> and <3>
>
> <2> was moved here because skb_clone() calls skb_orphan_frags(). By

Oh right, I think we should amend skb_clone() documentation, it is
slightly wrong.

( I will take care of this change)

> moving this up we do not need to call skb_orphan_frags() for list_skb
> and we can start to use nr_frags and frags without worrying their value
> is going to change.
>
> <3> was moved here because <2> was moved here. Fail fast if we can not
> clone list_skb.
>
> >
> > If this is not strictly needed, please keep the code as is to ease
> > code review...
> >
> > >                         i =3D 0;
> > >                         nfrags =3D skb_shinfo(list_skb)->nr_frags;
> > >                         frag =3D skb_shinfo(list_skb)->frags;
> > > @@ -4483,12 +4493,8 @@ struct sk_buff *skb_segment(struct sk_buff *he=
ad_skb,
> > >                                 frag++;
> > >                         }
> > >
> > > -                       nskb =3D skb_clone(list_skb, GFP_ATOMIC);
> >
> > <2>
> >
> > >                         list_skb =3D list_skb->next;
> > >
> > > -                       if (unlikely(!nskb))
> > > -                               goto err;
> > > -
> >
> > <3>
> >
> > >                         if (unlikely(pskb_trim(nskb, len))) {
> > >                                 kfree_skb(nskb);
> > >                                 goto err;
> > > @@ -4564,12 +4570,16 @@ struct sk_buff *skb_segment(struct sk_buff *h=
ead_skb,
> > >                 skb_shinfo(nskb)->flags |=3D skb_shinfo(head_skb)->fl=
ags &
> > >                                            SKBFL_SHARED_FRAG;
> > >
> > > -               if (skb_orphan_frags(frag_skb, GFP_ATOMIC) ||
> > > -                   skb_zerocopy_clone(nskb, frag_skb, GFP_ATOMIC))
> > > +               if (skb_zerocopy_clone(nskb, list_skb, GFP_ATOMIC))
> >
> > Why using list_skb here instead of frag_skb ?
> > Again, I have to look at the whole thing to understand why you did this=
.
>
> Oops, this is a mistake. It should be frag_skb. Will fix it run the test
> one more time and post v3.

