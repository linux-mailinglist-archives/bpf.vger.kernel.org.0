Return-Path: <bpf+bounces-9024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 608CA78E5A0
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 07:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8305D1C20972
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 05:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A861872;
	Thu, 31 Aug 2023 05:21:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7451846;
	Thu, 31 Aug 2023 05:21:38 +0000 (UTC)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E96E0;
	Wed, 30 Aug 2023 22:21:36 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-76f2fea104aso11113085a.1;
        Wed, 30 Aug 2023 22:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693459296; x=1694064096; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SQ/kR67s49mVWQN37mhs3/pVAKkjrDV7dC4+icKBWyc=;
        b=DtvOkhXLn4i/RM6Gdfo4xv+gvXhVer/X8OTqGDmLVaj714RpHg+YRz99kVD6U36hNk
         /fb+zAj8NYDK18wdzojkQMATisM62V0+Qaj4D5fdJqYKiG67lalZr4iiQIZOj2W6wEh+
         9Po5gf5dmvBOrvTiZOKt13NkAgogsKombvRa46m0WrV2iae+DqcD+efyUpOzCawY/0dz
         DZuQu3Y/NV9D/JLxWfGLNdVs/kvVWA5Gf+1cI8qcwvCjKn74LKAZaq99Ee5MNTU5AiZ0
         Uj3Oph/vDcEf2bLSZuKmTWHfGcKdkhL9Rs+XUeYGDbqsLG7i4eqKLqZyY1O+R9y62Mfu
         Htyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693459296; x=1694064096;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQ/kR67s49mVWQN37mhs3/pVAKkjrDV7dC4+icKBWyc=;
        b=Zv+TZuvDZ/5VOuA+K3YY5yaE2HStnsPemZbhw9Uchwqh6YZDCoMEPO5+sIsHaFLCEQ
         nQcHdW2PDSktrcG9xJ3qVsiEExeZvQxSktqSnOFRDUeCr5k5Xoj3C6Ueam8wT9EV4bTZ
         WrY43rKVxjagNr3W4pw6siTPHRVEiZgZDiKqivHJOd3ipVL11/DrC2bVFVcMB0pRmEZs
         TLyzYTbz8zDclvPmgPOgIiHRU+mv/LQ2ujmP6Ye6JYVyNYvjnUVWemogHV+gSRhhje3Z
         Ehfpt2hzGstbeWS48V8A0+SCMbuKu3UjWZu4/+0khDx+xw4E7rMu1QhDq8EDwm4X0kXe
         Cr4w==
X-Gm-Message-State: AOJu0YwEJEXvOWgNZEttlVEbXWRMaYNGEwlZKZesohkPcmPuuNactuTL
	wZd4MoF+eZ5P+N8c27tck9JM9DhwLID2lqaUdonDRo8CbTEuVw==
X-Google-Smtp-Source: AGHT+IHT9YJ5kRm5sWpjJMyVv/ljbooAnugJ09vtzleo4Ivfl8x9tCLk5IWS2mc2lLj3MyvaBB4FVKdWSNc3AwWxkzA=
X-Received: by 2002:a05:6214:19c3:b0:651:675b:37f9 with SMTP id
 j3-20020a05621419c300b00651675b37f9mr4403326qvc.1.1693459295883; Wed, 30 Aug
 2023 22:21:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230830151704.14855-1-magnus.karlsson@gmail.com>
 <ZO92QCe1s7yUiHRR@boxer> <CAJ8uoz2SMuwrO_OvrvJyWynfKMYuNNcxwNzt_O=T_=TnY4sA2g@mail.gmail.com>
 <ZO+7QvZRfCuCIO3Q@boxer>
In-Reply-To: <ZO+7QvZRfCuCIO3Q@boxer>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Thu, 31 Aug 2023 07:21:24 +0200
Message-ID: <CAJ8uoz3-v8tBG7CM6KHYVJRMicZRyDLvR0na+p-4Atwff=WZ4g@mail.gmail.com>
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

On Wed, 30 Aug 2023 at 23:57, Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Wed, Aug 30, 2023 at 08:58:09PM +0200, Magnus Karlsson wrote:
> > On Wed, 30 Aug 2023 at 19:03, Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > >
> > > On Wed, Aug 30, 2023 at 05:17:03PM +0200, Magnus Karlsson wrote:
> > > > From: Magnus Karlsson <magnus.karlsson@intel.com>
> > > >
> > > > Fix a use-after-free error that is possible if the xsk_diag interface
> > > > is used at the same time as the socket is being closed. In the early
> > >
> > > I thought our understanding is: socket is alive, we use diag interface
> > > against it but netdev that we bound socket to is being torn down.
> >
> > If the socket was not going down at the same time, we would still have
> > a reference to the netdevice and it would not disappear. So the socket
> > needs to be going down for this to happen.
>
> No, I am able to trigger this now on my local system with KASAN turned on
> via:
>
> window 0:
> sudo ./xdpsock -i enp24s0f0np0 -r -z -q 17
>
> window 1:
> watch -n 0.1 "ss --xdp -e"
>
> window 2:
> sudo rmmod ice
>
> we hold the device via dev_get_by_index() in xsk_bind() but dev_put() is
> called from xsk_unbind_dev() which can happen either from xsk_release() or
> xsk_notifier(), our case refers to the latter.

Nice reproducer! My definition of "going down" is probably not clear.
In both the cases above, the state is set to XSK_UNBOUND and the
reference to the device is dropped, i.e. the socket is on its path to
oblivion. In any case, I will send a v2 to fix the missing READ_ONCE()
and I will try to make this "going down" clearer in the commit
message.

> I don't see currently how ss gets the ifname but after rmmoding ice I am
> getting something bogus over there:
>
> Recv-Q Send-Q Local Address:Port Peer Address:PortProcess
> 0      0               if18:q17              *     ino:18691 sk:2001
>         rx(entries:2048)
>         umem(id:0,size:16777216,num_pages:4096,chunk_size:4096,headroom:0,ifindex:0,qid:17,zc:1,refs:1)
>         fr(entries:4096)
>         cr(entries:2048)
>         stats(rx dropped:0,rx invalid:0,rx queue full:0,rx fill ring empty:0,tx invalid:0,tx ring empty:0)
>
> 'if18' instead 'enp24s0f0np0'. With your patch we bail out early so we
> wouldn't have that problem AFAICT.

"if18"? Interesting. Good thing we get rid of this with the patch.

> > >
> > > > days of AF_XDP, the way we tested that a socket was not bound or being
> > > > closed was to simply check if the netdevice pointer in the xsk socket
> > > > structure was NULL. Later, a better system was introduced by having an
> > > > explicit state variable in the xsk socket struct. For example, the
> > > > state of a socket that is going down is XSK_UNBOUND.
> > > >
> > > > The commit in the Fixes tag below deleted the old way of signalling
> > > > that a socket is going down, setting dev to NULL. This in the belief
> > > > that all code using the old way had been exterminated. That was
> > > > unfortunately not true as the xsk diagnostics code was still using the
> > > > old way and thus does not work as intended when a socket is going
> > > > down. Fix this by introducing a test against the state variable. If
> > >
> > > Again, I believe it was not the socket going down but rather the netdev?
> > >
> > > > the socket is going down, simply abort the diagnostic's netlink
> > > > operation.
> > > >
> > > > Fixes: 18b1ab7aa76b ("xsk: Fix race at socket teardown")
> > > > Reported-by: syzbot+822d1359297e2694f873@syzkaller.appspotmail.com
> > >
> > > Nit: I see syzbot wanted you to include:
> > > Reported-and-tested-by: syzbot+822d13...@syzkaller.appspotmail.com
> > >
> > > > Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > > > ---
> > > >  net/xdp/xsk_diag.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/net/xdp/xsk_diag.c b/net/xdp/xsk_diag.c
> > > > index c014217f5fa7..da3100bfa1c5 100644
> > > > --- a/net/xdp/xsk_diag.c
> > > > +++ b/net/xdp/xsk_diag.c
> > > > @@ -111,6 +111,9 @@ static int xsk_diag_fill(struct sock *sk, struct sk_buff *nlskb,
> > > >       sock_diag_save_cookie(sk, msg->xdiag_cookie);
> > > >
> > > >       mutex_lock(&xs->mutex);
> > > > +     if (xs->state == XSK_UNBOUND)
> > > > +             goto out_nlmsg_trim;
> > >
> > > With the above I feel like we can get rid of xs->dev test in
> > > xsk_diag_put_info(), no?
> >
> > It has to stay since the socket does not get a reference to the device
> > until it is bound. It is fine to use the xsk_diag interface on an
> > unbound socket to query its state.
>
> Yes good point here.
>
> >
> > > > +
> > > >       if ((req->xdiag_show & XDP_SHOW_INFO) && xsk_diag_put_info(xs, nlskb))
> > > >               goto out_nlmsg_trim;
> > > >
> > > >
> > > > base-commit: 35d2b7ffffc1d9b3dc6c761010aa3338da49165b
> > > > --
> > > > 2.42.0
> > > >

