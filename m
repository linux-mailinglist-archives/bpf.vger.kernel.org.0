Return-Path: <bpf+bounces-69994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D081BBAAC54
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 02:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39862189C9F1
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 00:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B48168BD;
	Tue, 30 Sep 2025 00:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TEUJlpie"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB18D173
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 00:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759190524; cv=none; b=oyZUmosuCo0cwJBAPWZyVEyHYDcDPsc7bnlRKXSMoteqwPOUyELz736hplF+PLn9FgW6/f/kt4NZiWx+3mWIUlUW2kr5knL/d/bCb7y3TzYIEOSzyFzaVfQdz5U77al1QpFgUubbPDo8IsAlBsxdGyyeejzv4AWQmzbUxjxfXSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759190524; c=relaxed/simple;
	bh=3AVIRJP0nqO+qELyFtR/A5Yl/+5NLyaw3x+oly8XPm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OyxW6IwTBcaTihpp+FPqt6s+3qkaswTuPH6iA3cqXGF5JP9GKBVN8I8ut9RCDPesiZ4vJJH2aZo7i4v3j7wJxMOmjZ3JmuBWkkmw/CZGkqLFAdL2vwR4DI9llkqN2a9Yi2ln8fc0qvGi8TGzRIOs6BeIXKWRO51R3mmRsbYrgsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TEUJlpie; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4df3fabe9c2so71881cf.1
        for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 17:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759190522; x=1759795322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9F+loMYCYWrOcpIXdqB3UxC6d0dMHaZJx1ouukFllGU=;
        b=TEUJlpiejqa1+V8rV1T8wJ0C3nE0QSigfePW9yJtw1WihafH/TJ66gDMd5b88NcQ91
         2f8boJ/Pti5W8IzlPAYRsDTuzA8lFrXVqK91W36Qlm6qIFT0T4c5xqWKaYKXgMsTLuaB
         7PzXk0VqhvBQdUTN7FniUzrUtUMdVCOSfp4725igMf8OmVg6cnDL7vIu/bnVte8SgMOl
         Txo0HANQIiz8lJlsIp/KsVECp2zSaXQ4claKckyITb4PGEBrTvChptxVcel2bHZJLJOp
         lzWF4R1ERvOCNL/uC/wF0qnH8MxIbpZ7shxF+GUfoLgP0sfY0H2kHB03IGuqcJKGwys1
         gXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759190522; x=1759795322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9F+loMYCYWrOcpIXdqB3UxC6d0dMHaZJx1ouukFllGU=;
        b=viWPGaSXZ46RvfBafaXiK+r0XohagoXHsvXLtwGnt4uezBIX0tZpdWD48n3PfkJClc
         x2pWAyBzdqkC0Hpqp5yPQdGzQFMi7bbPVeYwsv97BmWjeK2Zgzvjq46+tC8suVP3EPPp
         QyRUV9ikERP2nSRReB2eVJO4MLTuBtqHtNDB7jy4L/x87VJDWIb9KPXddIJBturZ5hnw
         XLZSRboqGWzRsb7VMnimoBmu8sRTignreFQPm8UYeLxAPWsEqvCDLWWKVsLBW/hcfxuV
         aEXbzyqAzxVIA0OUMd6YuJQAknRgFkEHCxP29ZoTvjMBCkjzG2Pj/Th2j3ZfYLpQXBcT
         etZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVt1Rf2V/y7TmHGNXlfJDhleL86FiwleHdj/e+vhes7RA0ovSKQgKSkrkUaSFjHLvgoPcI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0DUCseRefrg0+tjlu5+iAY1/CQZ5ObmxrkKN4Z2QnhgpqRvzw
	9PLtg+4bNLMqWZ+c5H1s14A3tXkn7m2KU9IHeFJ78/DkyKOE9VVJq+jF0kWo5epNb4hzIrKFO7k
	uwSzUI5uCvepAmHw/nEhOTaUOFV35iwjYop2KDb2S
X-Gm-Gg: ASbGncsuaNZ/5imVhjrBKKFtB7OfTaL/W32aBqJulX7Y1Y0LLkusfuV0qgwm9sRonxk
	S6iJ10QVkiz1rV/zBFe6+/zffwUAkoiFY4DgTT5gbVhK4brQOpmLs+JcC4UXeTyc+JzMOAih+DM
	0rnpnxwneh3FOIP4tI69GaoU/NPXqileUurwRS81Xbn/jUoEpDewzq1cTBgMwk2Xk0mhoc4aTXZ
	pKDZ9W3KY/C6P168Og3fLsTB6dFTJ6gv6bch3PkmtrEJaufczI1zYCKxJwg1+kthULDdl33
X-Google-Smtp-Source: AGHT+IHyFixTMv37JFGgdfgR3NetprEXaidZPluXal7gyPyVZujOxk/XFuZfwHbPtOO0KW2caMWqJjNIRb8Wpqa75y8=
X-Received: by 2002:a05:622a:106:b0:4b3:19b2:d22 with SMTP id
 d75a77b69052e-4e2f7ee12aemr1919421cf.13.1759190521092; Mon, 29 Sep 2025
 17:02:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924060843.2280499-1-tavip@google.com> <20250924170914.20aac680@kernel.org>
 <CAGWr4cQCp4OwF8ESCk4QtEmPUCkhgVXZitp5esDc++rgxUhO8A@mail.gmail.com>
 <aNUObDuryXVFJ1T9@boxer> <20250925191219.13a29106@kernel.org>
 <CAGWr4cSiVDTUDfqAsHrsu1TRbumDf-rUUP=Q9PVajwUTHf2bYg@mail.gmail.com>
 <aNZ33HRt+SxltbcP@boxer> <20250926124010.4566617b@kernel.org>
In-Reply-To: <20250926124010.4566617b@kernel.org>
From: Octavian Purdila <tavip@google.com>
Date: Mon, 29 Sep 2025 17:01:49 -0700
X-Gm-Features: AS18NWBuATz_lr0JYRD9JYPmM_LItRpBbCQQJlPRqJq-XgoqeJytNn1U8iu8TfU
Message-ID: <CAGWr4cSwEbuSPEJp6=-8gRbD7O-pOqzn_1fXPxWv-ZX3b7NX_w@mail.gmail.com>
Subject: Re: [PATCH net] xdp: use multi-buff only if receive queue supports
 page pool
To: Jakub Kicinski <kuba@kernel.org>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, 
	ahmed.zaki@intel.com, aleksander.lobakin@intel.com, toke@redhat.com, 
	lorenzo@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com, 
	Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 12:40=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Fri, 26 Sep 2025 13:24:12 +0200 Maciej Fijalkowski wrote:
> > On Fri, Sep 26, 2025 at 12:33:46AM -0700, Octavian Purdila wrote:
> > > On Thu, Sep 25, 2025 at 7:12=E2=80=AFPM Jakub Kicinski <kuba@kernel.o=
rg> wrote:
> > > Ah, yes, you are right. So my comment in the commit message about
> > > TUN/TAP registering a page shared memory model is wrong. But I think
> > > the fix is still correct for the reported syzkaller issue. From
> > > bpf_prog_run_generic_xdp:
> > >
> > >         rxqueue =3D netif_get_rxqueue(skb);
> > >         xdp_init_buff(xdp, frame_sz, rxq: &rxqueue->xdp_rxq);
> > >
> > > So xdp_buff's rxq is set to the netstack queue for the generic XDP
> > > hook. And adding the check in netif_skb_check_for_xdp based on the
> > > netstack queue should be correct, right?
> >
> > Per my limited understanding your change is making skb_cow_data_for_xdp=
()
> > a dead code as I don't see mem model being registered for these stack
> > queues - netif_alloc_rx_queues() only calls xdp_rxq_info_reg() and
> > mem.type defaults to MEM_TYPE_PAGE_SHARED as it's defined as 0, which
> > means it's never going to be MEM_TYPE_PAGE_POOL.
>
> Hah, that's a great catch, how did I miss that..
>
> The reason for the cow is that frags can be shared, we are not allowed
> to modify them. It's orthogonal.
>

Could we use the same hack that you mention below (declare rxq on the
stack and fill in the mem info there) for do_xdp_generic?

@@ -5442,7 +5448,10 @@ int do_xdp_generic(const struct bpf_prog
*xdp_prog, struct sk_buff **pskb)
        struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;

        if (xdp_prog) {
-               struct xdp_buff xdp;
+               struct xdp_rxq_info rxq =3D {};
+               struct xdp_buff xdp =3D {
+                       .rxq =3D &rxq,
+               };
                u32 act;
                int err;

and then explicitly set the mem type:

@@ -5331,14 +5332,19 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff
*skb, struct xdp_buff *xdp,
        return act;
 }

-static int
-netif_skb_check_for_xdp(struct sk_buff **pskb, const struct bpf_prog *prog=
)
+static int netif_skb_check_for_xdp(struct sk_buff **pskb,
+                                  const struct bpf_prog *prog,
+                                  struct xdp_rxq_info *rxq)
 {
        struct sk_buff *skb =3D *pskb;
        int err, hroom, troom;
+       struct page_pool *pool;

        local_lock_nested_bh(&system_page_pool.bh_lock);
-       err =3D skb_cow_data_for_xdp(this_cpu_read(system_page_pool.pool),
pskb, prog);
+       pool =3D this_cpu_read(system_page_pool.pool);
+       err =3D skb_cow_data_for_xdp(pool, pskb, prog);
+       rxq->mem.type =3D MEM_TYPE_PAGE_POOL;
+       rxq->mem.id =3D pool->xdp_mem_id;
        local_unlock_nested_bh(&system_page_pool.bh_lock);
        if (!err)
                return 0;


> > IMHO that single case where we rewrite skb to memory backed by page poo=
l
> > should have it reflected in mem.type so __xdp_return() potentially used=
 in
> > bpf helpers could act correctly.
> >
> > > > Well, IDK how helpful the flow below would be but:
> > > >
> > > > veth_xdp_xmit() -> [ptr ring] -> veth_xdp_rcv() -> veth_xdp_rcv_one=
()
> > > >                                                                |
> > > >                             | xdp_convert_frame_to_buff()   <-'
> > > >     ( "re-stamps" ;) ->     | xdp->rxq =3D &rq->xdp_rxq;
> > > >   can eat frags but now rxq | bpf_prog_run_xdp()
> > > >          is veth's          |
> > > >
> > > > I just glanced at the code so >50% changes I'm wrong, but that's wh=
at
> > > > I meant.
> > >
> > > Thanks for the clarification, I thought that "re-stamps" means the:
> > >
> > >     xdp->rxq->mem.type =3D frame->mem_type;
> > >
> > > from veth_xdp_rcv_one in the XDP_TX/XDP_REDIRECT cases.
> > >
> > > And yes, now I think the same issue can happen because veth sets the
> > > memory model to MEM_TYPE_PAGE_SHARED but veth_convert_skb_to_xdp_buff
> > > calls skb_pp_cow_data that uses page_pool for allocations. I'll try t=
o
> > > see if I can adapt the syzkaller repro to trigger it for confirmation=
.
> >
> > That is a good catch.
>
> FWIW I think all calls to xdp_convert_frame_to_buff() must come with
> the hack that cpu_map_bpf_prog_run_xdp() is doing today. Declare rxq
> on the stack and fill in the mem info there. I wonder if we should add
> something to the API (xdp_convert_frame_to_buff()) to make sure people
> don't forget to do this..

