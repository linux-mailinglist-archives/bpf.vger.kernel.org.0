Return-Path: <bpf+bounces-8958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0137E78D293
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 05:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1EA21C20A6F
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 03:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9271A1377;
	Wed, 30 Aug 2023 03:44:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6878E1106
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 03:44:29 +0000 (UTC)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0382E8
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 20:44:27 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-407db3e9669so115971cf.1
        for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 20:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693367067; x=1693971867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jer61DAaUrTDR+SwmVVUg+r+KPj9qeJLbgBsssAgRXk=;
        b=o1lC2CAzVbqi9EN0i3nOT8lZz/k4so/6dDpdR3zIchGVk3v4QMG0iM7IL0fK1UXpyO
         YrDfShOFQXZ5KYlODZK72srvr/HGv0UiFgdjuuJB0xBrMz1/d5pRNgm+WVmdLA8+7i+e
         qDk1Alq7vuwywxksgnJSTfnkZ6qV5TOOGrwMOmHKsolmAQAEv30ro7E4NUkhwHgKwjVf
         /t0UQC9CfxNu07dP7mP31SiPdthZWo39y+ujf+h2fIMxcX6J4D9BIIbKpGh9JPTDmYD6
         dVlioQSPT0h53rGzoIoAopMV8n3jObh8oGXUUAjcHcyMuSkr3xmbbrGibWpNXMtH6BZ9
         dLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693367067; x=1693971867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jer61DAaUrTDR+SwmVVUg+r+KPj9qeJLbgBsssAgRXk=;
        b=dE602ORJGABAa8p6LjV/rQ/mxZlLMwb8vRPEMSlUXB0bO6Fo/HtlB6Q5OhMM++s4Vg
         XB3cJLCaEA+wcdEF1+XN/pyIaCy7iZzciRK+TvS4DurC+bctKkWBnR73u9zY4XRcHoGT
         NuMPmNpyE9biXSeihRTMRp1mNTeTDChrh4fUZpYkwibnhczOnjFjWTy65GvHi7TAdvSU
         2VnhPzF7GMKklFByHuKxV2mq+tew2MSSn4kGd8VXBdvAS9ApyjJJkNgKBVEjSC20Le+V
         Y/JoZ4vgWCX6Y1OhygPMT/MB38GvQP4DL5dPKn73qqI/+wr0Q7U1A/RcwpXfFeoCQeWn
         KzoQ==
X-Gm-Message-State: AOJu0Yzj2l39H3BzwwzaCLWYIA6+xmwFtU+Cw3JwMp3wRZvhv91ZxaVk
	4jpGPZCk7y4Aui0lz6KyNMDKtl2a5Jd+RlGe6DI6Wg==
X-Google-Smtp-Source: AGHT+IE4GK4wJT4oisQbhyI+jQmldyVAMNSAPb4UnLZig/NheUo25tu9HPU1ry6SGYmSB1eTupRTOb5thEY/GXj6Izw=
X-Received: by 2002:ac8:7d91:0:b0:410:385c:d1e0 with SMTP id
 c17-20020ac87d91000000b00410385cd1e0mr364023qtd.25.1693367066914; Tue, 29 Aug
 2023 20:44:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230828233210.36532-1-mkhalfella@purestorage.com>
 <64ed7188a2745_9cf208e1@penguin.notmuch> <20230829065010.GO4091703@medusa>
 <CANn89iLbNF_kGG9S3R9Y8gpoEM71Wesoi1mTA3-at4Furc+0Fg@mail.gmail.com>
 <20230829093105.GA611013@medusa> <CANn89iLzOFikw2A8HJJ0zvg1Znw+EnOH2Tm2ghrURkE7NXvQSg@mail.gmail.com>
 <20230829222418.GB1473980@medusa>
In-Reply-To: <20230829222418.GB1473980@medusa>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 30 Aug 2023 05:44:15 +0200
Message-ID: <CANn89iKHTaiqyBohSd3sRJJwG1CUD2M_vy6gwLjW=U4VS3EJtQ@mail.gmail.com>
Subject: Re: [PATCH] skbuff: skb_segment, Update nfrags after calling zero
 copy functions
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: willemjdebruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Alexander Duyck <alexanderduyck@fb.com>, 
	David Howells <dhowells@redhat.com>, Jesper Dangaard Brouer <brouer@redhat.com>, 
	Kees Cook <keescook@chromium.org>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 30, 2023 at 12:24=E2=80=AFAM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> On 2023-08-29 12:09:15 +0200, Eric Dumazet wrote:
> > Another way to test this path for certain (without tcpdump having to ra=
ce)
> > is to add a temporary/debug patch like this one:
> >
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index a298992060e6efdecb87c7ffc8290eafe330583f..20cc42be5e81cdca567515f=
2a886af4ada0fbe0a
> > 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -1749,7 +1749,8 @@ int skb_copy_ubufs(struct sk_buff *skb, gfp_t gfp=
_mask)
> >         int i, order, psize, new_frags;
> >         u32 d_off;
> >
> > -       if (skb_shared(skb) || skb_unclone(skb, gfp_mask))
> > +       if (skb_shared(skb) ||
> > +           pskb_expand_head(skb, 0, 0, gfp_mask))
> >                 return -EINVAL;
> >
> >         if (!num_frags)
> >
> > Note that this might catch other bugs :/
>
> I was not able to make it allocate a new frags by running tcpdump while
> reproing the problem. However, I was able to do it with your patch.

I am glad this worked, and looking forward to a v2 of your patch, thanks !

