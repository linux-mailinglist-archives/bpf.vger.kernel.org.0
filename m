Return-Path: <bpf+bounces-8998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF10E78DE2B
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 21:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 001342811F6
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 19:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F6B79CA;
	Wed, 30 Aug 2023 19:00:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC94F748D;
	Wed, 30 Aug 2023 19:00:17 +0000 (UTC)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6314EE8;
	Wed, 30 Aug 2023 11:59:46 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-65165ea56aaso179826d6.0;
        Wed, 30 Aug 2023 11:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693421901; x=1694026701; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XayPDM/Q6z4NHuTXzOPghRcTKtk8xgsMvhLMaVYQlLY=;
        b=WXHyEe6BSGlq7Ae4Cc1C2pMSrqtKAm297DmmBErXwEWYl4faHEO9eljIkgyw/a5G9S
         gXSTzeilpzFDNcRqPNZRILzwZ8mB1en9EekhlHq6gpRBSCWktu5UoypL6LMJd++ZjQAM
         k3/irSrC3zk3y4DR+q8cVIYYf2BK9je6r6oHABcIKaAhv0uhSR70/WqJUpv7PLC6wNUj
         HYBtjMx++ij8eQPeXC58cjXZDpa2j8HpXZvB0h7tbF4vL9exEQLzdiE7mO5f82GqMXsi
         4kA4RsJnkT+Hf4RbgSM3qJZ/4s3zkLClIb3087PFBD4V8FbUYF9XSDyqXJTU+py9xdxP
         7Snw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693421901; x=1694026701;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XayPDM/Q6z4NHuTXzOPghRcTKtk8xgsMvhLMaVYQlLY=;
        b=SjW+X0BCcFKFTKn2BsoQfc+9x6x9VjA1shVjgiyYAS2PupGsu3YLEkD2jMXqdiC9I2
         WYVEymXDneg5lAIQD8bT3O2nmrRSNvVCTEBjuRQ2m94FUebLfSzMP6oM31wHSLBkKg3u
         3eZKET+3OpthNWEW3untT8rgUhnye8nrE1F7WFuwcgZxEV3Bo5gTlW91/heypQ1yQEcW
         tZuYig+hQwlolNstavYjEtX+YS/oiGXmJkDEvzQEneZK8RykIPDLsh5efLq/HBYl3E63
         xSN0fgItCxbMTa4ZSDpJdzLhI3//WZtLjZZpS3l+PPFETpZSNY4GSg0q1HszV0zG4iVn
         m3ag==
X-Gm-Message-State: AOJu0YyB7u/sXGPGmSH5YUotAvWKt9unB4jdn8MjFJHmPLUQHf2FiQpU
	KQ0dcsn6miclxSdK9dJlBpLL3eL1E8sHEM7WCdavlt6C2pMjbQ==
X-Google-Smtp-Source: AGHT+IEOYE36KD7fq3CXb00LAr3zekftfRR9VWvEMfuvUaU8T1WYD1DXWa+HnV6U5K7+ykRfZfw1FSsxVgbNBZG1z5M=
X-Received: by 2002:a05:6214:487:b0:63c:fd2d:6ff1 with SMTP id
 pt7-20020a056214048700b0063cfd2d6ff1mr3238905qvb.1.1693421900906; Wed, 30 Aug
 2023 11:58:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230830151704.14855-1-magnus.karlsson@gmail.com> <ZO92QCe1s7yUiHRR@boxer>
In-Reply-To: <ZO92QCe1s7yUiHRR@boxer>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Wed, 30 Aug 2023 20:58:09 +0200
Message-ID: <CAJ8uoz2SMuwrO_OvrvJyWynfKMYuNNcxwNzt_O=T_=TnY4sA2g@mail.gmail.com>
Subject: Re: [PATCH bpf] xsk: fix xsk_diag use-after-free error during socket cleanup
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: magnus.karlsson@intel.com, bjorn@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, netdev@vger.kernel.org, jonathan.lemon@gmail.com, 
	bpf@vger.kernel.org, syzbot+822d1359297e2694f873@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 30 Aug 2023 at 19:03, Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Wed, Aug 30, 2023 at 05:17:03PM +0200, Magnus Karlsson wrote:
> > From: Magnus Karlsson <magnus.karlsson@intel.com>
> >
> > Fix a use-after-free error that is possible if the xsk_diag interface
> > is used at the same time as the socket is being closed. In the early
>
> I thought our understanding is: socket is alive, we use diag interface
> against it but netdev that we bound socket to is being torn down.

If the socket was not going down at the same time, we would still have
a reference to the netdevice and it would not disappear. So the socket
needs to be going down for this to happen.

> since xs->dev was freed but not NULLed, xsk_diag_put_info() uses this ptr
> to retrieve ifindex.
>
> > days of AF_XDP, the way we tested that a socket was not bound or being
> > closed was to simply check if the netdevice pointer in the xsk socket
> > structure was NULL. Later, a better system was introduced by having an
> > explicit state variable in the xsk socket struct. For example, the
> > state of a socket that is going down is XSK_UNBOUND.
> >
> > The commit in the Fixes tag below deleted the old way of signalling
> > that a socket is going down, setting dev to NULL. This in the belief
> > that all code using the old way had been exterminated. That was
> > unfortunately not true as the xsk diagnostics code was still using the
> > old way and thus does not work as intended when a socket is going
> > down. Fix this by introducing a test against the state variable. If
>
> Again, I believe it was not the socket going down but rather the netdev?
>
> > the socket is going down, simply abort the diagnostic's netlink
> > operation.
> >
> > Fixes: 18b1ab7aa76b ("xsk: Fix race at socket teardown")
> > Reported-by: syzbot+822d1359297e2694f873@syzkaller.appspotmail.com
>
> Nit: I see syzbot wanted you to include:
> Reported-and-tested-by: syzbot+822d13...@syzkaller.appspotmail.com
>
> > Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > ---
> >  net/xdp/xsk_diag.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/net/xdp/xsk_diag.c b/net/xdp/xsk_diag.c
> > index c014217f5fa7..da3100bfa1c5 100644
> > --- a/net/xdp/xsk_diag.c
> > +++ b/net/xdp/xsk_diag.c
> > @@ -111,6 +111,9 @@ static int xsk_diag_fill(struct sock *sk, struct sk_buff *nlskb,
> >       sock_diag_save_cookie(sk, msg->xdiag_cookie);
> >
> >       mutex_lock(&xs->mutex);
> > +     if (xs->state == XSK_UNBOUND)
> > +             goto out_nlmsg_trim;
>
> With the above I feel like we can get rid of xs->dev test in
> xsk_diag_put_info(), no?

It has to stay since the socket does not get a reference to the device
until it is bound. It is fine to use the xsk_diag interface on an
unbound socket to query its state.

> > +
> >       if ((req->xdiag_show & XDP_SHOW_INFO) && xsk_diag_put_info(xs, nlskb))
> >               goto out_nlmsg_trim;
> >
> >
> > base-commit: 35d2b7ffffc1d9b3dc6c761010aa3338da49165b
> > --
> > 2.42.0
> >

