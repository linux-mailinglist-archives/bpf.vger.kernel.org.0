Return-Path: <bpf+bounces-61336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D17AE5A40
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 04:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD8E83A98CA
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 02:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5932D1F4161;
	Tue, 24 Jun 2025 02:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAcSdro9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381266EB79;
	Tue, 24 Jun 2025 02:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750733291; cv=none; b=tuGPLpCjvT8zhuQudr7QRbi4hLVtLGTbkMPN/MSnaQTnnJGheCnwtLUwOCmEtCMdoG4nZVxMf5+CtYm666cr426356QGuh2KTTblM7OKfPIMj1CKvh2tiYI/kSfVP7OiNRz9B3QHDzhSqB7TEr5ksTzut4PUqZGq6pnjK5Gp7Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750733291; c=relaxed/simple;
	bh=GwoHZFUY/x5VSSIafll+BCvsf6oyllU7BYoBJr3E3rA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U167RmGRVwNDPZpXvCZCaP3GrE4KKSupH6ESW5qHS7CbKbYdoT4XtMQ/NupGPdwNyGWoLtnerTpNMKPbwNdunuQUP/YNJL6XDqQxLwyTk/XjVwXNz54BWyymeqI1Od83AZxc/Jov1F9NWR81WSr+n1tzyvWqXNUGMxkvm2MQnjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAcSdro9; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-86a052d7897so571009839f.0;
        Mon, 23 Jun 2025 19:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750733289; x=1751338089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bps0R7+n31V6NFhkw8uLBkuMWuwKZagykVn6C69NAWw=;
        b=MAcSdro9v3T/6xuQFfGuAZKUyQ0w4v8KBubW/zgPOUabN77kemkMwjlA5Bezj7OCfz
         A76GY+6IWxo8lGsX3/vNU3jnPIZdLdOmuRTD0RVmtgjaTCnfFjyme65rE30OkGXvXy7m
         z40H49zOVBtT2bI/gtTfPFPnEu9QJzWiBxIcapoRWcwLHvb6yPySvu6JlAWnLzetqSPo
         JULkaGfJvcKQZKa9mE19ta3YO9VjN6BCYBxe5GGN2vsoaH/OX3bwxmK+z1IhX5HcI5Gc
         dRsfkU3mM6zHfI+xbA+cyVROJ18aiwkoTsCy9EBSBjhE7vkvNtat6W2gzSEf/WVuGUfJ
         dahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750733289; x=1751338089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bps0R7+n31V6NFhkw8uLBkuMWuwKZagykVn6C69NAWw=;
        b=sJvJK5XN4NNw7Pfll+cgxPGnL3oqhA93E2cF/HxE8/KCRvuY+ZyVDiXRPJ5OCR5hfA
         RFSlwn2Chs4aD0F46hfXV3T+VGbznjdChEYD4+QzPmglP+OBlVjtpS7GiCcUY1FJvIAH
         P1sfbZn8uiSTJRCipboDwv1ZoKjqjK3jQj+YtIbUbHR1T1JFMp98pu2KH52on8qDmPTi
         ubeOcfSye80Tol9lY5xmkkibRaQeAwurZDY8Q7Z9Wa9TJvQL6V6oLGVex3XW50ISk4za
         XWZU9YsjDt1OnBzaH6ogqKgQBp9SwX543zYHwswiO39YEVe3AIjtPR6KCaIx/i8PPBtj
         clMA==
X-Forwarded-Encrypted: i=1; AJvYcCVIf5tUxY2AfZ41KhRj1kbOE17/Gm4nSBxzjodn9WaDo4PqxTV9POO02AV7iLlp6KEvGyc=@vger.kernel.org, AJvYcCWOMaOeUyWyCb4YEISnpl6MdtL5/TrJAyK4X4Zw0hvZNRboqIC8c+sniU6ml3ee+IYyTlX0nbO3@vger.kernel.org
X-Gm-Message-State: AOJu0Yxon/kd4ShVI4TQuX9ibekHZqzwKLTtJ4whqbSaWguitJH7iloP
	FoP/7Ad4tOxfhmYzxuX/j0nhNrIdekY13g8o98tETn0uVR1PxiSHMx23Y7v3V/KSd/wDaGq+rBx
	9Swpfcx+uBBX4I/6M0hAO/c9ZKpc5GE8=
X-Gm-Gg: ASbGncv+J1YUHr3nLGJ/8Ib5wYVwCrqT66zGcpBtoUhbFYvUGPtFbDjgd/sa5uQ/jLO
	WJbvllD5m8CC8IJ7LP/oNdEqwkeaMcy+hjl0n+6m8QAinqIyEpH337shueAucNnFupYKK85nUyr
	VCu0eMf2TbAUTqlRxAFm/+XHwM7t0HVUq5nAz0D8OAE7U=
X-Google-Smtp-Source: AGHT+IFq/wE38zXX6ncxVSL8f8xayWVxCqU0VNadh/dr0nsQnTVAahk1eMFbTwXGwWgToS4n+Q4FbtO4u3W1WwMc1/4=
X-Received: by 2002:a05:6e02:240f:b0:3d8:2085:a188 with SMTP id
 e9e14a558f8ab-3de38c1dc08mr198253635ab.1.1750733289235; Mon, 23 Jun 2025
 19:48:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619090440.65509-1-kerneljasonxing@gmail.com>
 <20250619080904.0a70574c@kernel.org> <aFVvcgJpw5Cnog2O@mini-arch>
 <CAL+tcoAm-HitfFS+N+QRzECp5X0-X0FuGQEef5=e6cB1c_9UoA@mail.gmail.com>
 <aFWQoXrkIWF2LnRn@mini-arch> <CAL+tcoB-5Gt1_sJ_9-EjH5Nm_Ri+8+3QqFvapnLLpC5y4HW63g@mail.gmail.com>
 <aFliLQiRusx_SzQ4@mini-arch> <CAL+tcoBub4JpHrgWekK+OVCb0frXUaFYDGVd2XL3bvjHOTmFjQ@mail.gmail.com>
 <aFn1ybR3kgSfvL_N@mini-arch>
In-Reply-To: <aFn1ybR3kgSfvL_N@mini-arch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 24 Jun 2025 10:47:32 +0800
X-Gm-Features: AX0GCFvJlgUtaKmeTgyZ0cawpH1Ted_HSE0TIoWJJ6ICRgMjhShe1ZkD48R5fzw
Message-ID: <CAL+tcoBqZvrCQVCx0wz+RUAqa-zZjNS_H8AhfAdfcVMmPRT0KA@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: xsk: introduce XDP_MAX_TX_BUDGET set/getsockopt
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, joe@dama.to, willemdebruijn.kernel@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 8:48=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 06/24, Jason Xing wrote:
> > On Mon, Jun 23, 2025 at 10:18=E2=80=AFPM Stanislav Fomichev
> > <stfomichev@gmail.com> wrote:
> > >
> > > On 06/21, Jason Xing wrote:
> > > > On Sat, Jun 21, 2025 at 12:47=E2=80=AFAM Stanislav Fomichev
> > > > <stfomichev@gmail.com> wrote:
> > > > >
> > > > > On 06/21, Jason Xing wrote:
> > > > > > On Fri, Jun 20, 2025 at 10:25=E2=80=AFPM Stanislav Fomichev
> > > > > > <stfomichev@gmail.com> wrote:
> > > > > > >
> > > > > > > On 06/19, Jakub Kicinski wrote:
> > > > > > > > On Thu, 19 Jun 2025 17:04:40 +0800 Jason Xing wrote:
> > > > > > > > > @@ -424,7 +421,9 @@ bool xsk_tx_peek_desc(struct xsk_buff=
_pool *pool, struct xdp_desc *desc)
> > > > > > > > >     rcu_read_lock();
> > > > > > > > >  again:
> > > > > > > > >     list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_li=
st) {
> > > > > > > > > -           if (xs->tx_budget_spent >=3D MAX_PER_SOCKET_B=
UDGET) {
> > > > > > > > > +           int max_budget =3D READ_ONCE(xs->max_tx_budge=
t);
> > > > > > > > > +
> > > > > > > > > +           if (xs->tx_budget_spent >=3D max_budget) {
> > > > > > > > >                     budget_exhausted =3D true;
> > > > > > > > >                     continue;
> > > > > > > > >             }
> > > > > > > > > @@ -779,7 +778,7 @@ static struct sk_buff *xsk_build_skb(=
struct xdp_sock *xs,
> > > > > > > > >  static int __xsk_generic_xmit(struct sock *sk)
> > > > > > > > >  {
> > > > > > > > >     struct xdp_sock *xs =3D xdp_sk(sk);
> > > > > > > > > -   u32 max_batch =3D TX_BATCH_SIZE;
> > > > > > > > > +   u32 max_budget =3D READ_ONCE(xs->max_tx_budget);
> > > > > > > >
> > > > > > > > Hm, maybe a question to Stan / Willem & other XSK experts b=
ut are these
> > > > > > > > two max values / code paths really related? Question 2 -- i=
s generic
> > > > > > > > XSK a legit optimization target, legit enough to add uAPI?
> > > > > > >
> > > > > > > 1) xsk_tx_peek_desc is for zc case and xsk_build_skb is copy =
mode;
> > > > > > > whether we want to affect zc case given the fact that Jason s=
eemingly
> > > > > > > cares about copy mode is a good question.
> > > > > >
> > > > > > Allow me to ask the similar question that you asked me before: =
even though I
> > > > > > didn't see the necessity to set the max budget for zc mode (jus=
t
> > > > > > because I didn't spot it happening), would it be better if we s=
eparate
> > > > > > both of them because it's an uAPI interface. IIUC, if the setso=
ckopt
> > > > > > is set, we will not separate it any more in the future?
> > > > > >
> > > > > > We can keep using the hardcoded value (32) in the zc mode like
> > > > > > before and __only__ touch the copy mode? Later if someone or I =
found
> > > > > > the significance of making it tunable, then another parameter o=
f
> > > > > > setsockopt can be added? Does it make sense?
> > > > >
> > > > > Related suggestion: maybe we don't need this limit at all for the=
 copy mode?
> > > > > If the user, with a socket option, can arbitrarily change it, wha=
t is the
> > > > > point of this limit? Keep it on the zc side to make sure one sock=
et doesn't
> > > > > starve the rest and drop from the copy mode.. Any reason not to d=
o it?
> > > >
> > > > Thanks for bringing up the same question that I had in this thread.=
 I
> > > > saw the commit[1] mentioned it is used to avoid the burst as DPDK
> > > > does, so my thought is that it might be used to prevent such a case
> > > > where multiple sockets try to send packets through a shared umem
> > > > nearly at the same time?
> > > >
> > > > Making it tunable is to provide a chance to let users seek for a go=
od
> > > > solution that is the best fit for them. It doesn't mean we
> > > > allow/expect to see the burst situation.
> > >
> > > The users can choose to moderate their batches by submitting less
> > > with each sendmsg call. I see why having a batch limit might be usefu=
l for
> > > zerocopy to tx in batches to interleave multiple sockets, but not
> > > sure how this limit helps for the copy mode. Since we are not running
> > > qdisc layer on tx, we don't really have a good answer for multiple
> > > sockets sharing the same device/queue..
> >
> > It's worth mentioning that the xsk still holds the tx queue lock in
> > the non-zc mode. So I assume getting rid of the limit might be harmful
> > for other non xsk flows. That is what I know about the burst concern.
>
> But one still needs NET_RAW to use it, right? So it's not like some
> random process will suddenly start ddos-ing tx queues.. Maybe we should
> add need_resched() / signal_pending() to the loop to break it?

I'm not referring to the deliberate attack action. TSQ is an example
that avoids a single tcp flow being very aggressive to occupy the
majority of the available bandwidth, which leads to the unfair and
bufferbloat problem. IMHO, the limit here works very similarly. We
cannot control how the application or the upper layer stack uses the
af_xdp feature. The fact is that too many packets sent from xsk can
cause high latency of other normal packets in the same queue. TSQ has
a tunable value. BQL has something like that too. IMHO, I think the tx
budget for xsk does make sense as well :)

If some application tries to remove the limit, the setsockopt is
surely a choice because the v4 patch doesn't hold the upper bound.

Thanks,
Jason

