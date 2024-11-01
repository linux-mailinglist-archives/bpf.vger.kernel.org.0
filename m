Return-Path: <bpf+bounces-43706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B93D9B8B41
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 07:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06A931F224B0
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 06:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E7414F10F;
	Fri,  1 Nov 2024 06:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoYJoHyf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1913D143C7E;
	Fri,  1 Nov 2024 06:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730442863; cv=none; b=sf99KeLEMs5nZcYpMV3m7mvBej9Cs2ioA4le782Len2o8i68GPzTmQDxjN24wrA0IQm/tMq0XkUISsYUSo4zuSECRinM44/PQNtFEuc6o5n7TWjs4QIRnFGRaOheWFsWgbsxzBO4dqiFQoGE48UiMyXHfs/od3oXZQ+GqlLaDbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730442863; c=relaxed/simple;
	bh=95yD769XLoFkFNsg54mOTbkdi1HWHfovV9T61neThs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rBZqXG7UlCQbpI4+VthDZ0WsBV71bWILnJ2khnO4p3Ejdq1fv97d2VdqDSndt4M1ruZ4yr0BuG9B1dpKZGDHPZulCwmhIpbZNzeROCe4FbItK1lnr3efYLMKoAVzZOmm9UBFuWjEnXEsrTgsKV8URBP9vLUGvnZgL5jciYiJaw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IoYJoHyf; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-8323b555a6aso87703339f.3;
        Thu, 31 Oct 2024 23:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730442859; x=1731047659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9JUHJPvvjPGiBQPeFdEOgn0ZyJhRjPJdSvJFrrfo3A=;
        b=IoYJoHyfFzzarOBZiMKw9WlaXLoNSYSzi/QbEc5179sETG7j89vhP26/Jj97IPhjn9
         9Vx2Gbo6qdamENr0uUPxKhodNTwqJ6Si/QAbBJ04A/Ffm1f3QsnzIV78QbhrSWbhwP+0
         k6UVne2kt5ZgE2axLXpnyd3qEA0L2NsX6+v2UfIKenjLAAqWgiMnBv/URGODy7862UyA
         IUlAqRkQEGWsuAzFwV/5KOjUfcGx7gzAIjXMAxRl2nLmyiXqdLad6IZRYKVJhwGvL7jg
         TML1zJLkQdKJ/rlEIE9px2Ob+eig3PT4HpOkgxL3ZOnGyzEL3LYvO9lyyyGrC3gR9w7S
         AFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730442859; x=1731047659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b9JUHJPvvjPGiBQPeFdEOgn0ZyJhRjPJdSvJFrrfo3A=;
        b=b8HMZkhbdm3LSNxwT/I68ttTgqaYgv/f0GOh4nh0x3edahhmY7BL44a9z8P7cvkHlk
         k8OyJnJvNVD65MKjb3dYQCDGwG4n0NfeTdVP+dufx8qh0JvnF/37AEeyPZ3HtOSPlv4p
         YdmtFdPJof71MnJP10zLGlB2o4/5y5Sqfdt9ps3CDeTpJ4LIyo58rH0ep0RGsEj/fD8b
         7049MKuIbn4MIfSnRvv+Y0pj7+N73V/VphZmq3X9r1Wq66b65hyhmmRG+YPnlRcchAqX
         DgK+2ekzY0dqk6dUwuQ3kc4RyyV2sv80MfC3dm75yThhrRY+Ger+F7i9CTmd042sJbEM
         /rPA==
X-Forwarded-Encrypted: i=1; AJvYcCVRiWqDyZnZf7hUzfyCCZ2wrOwMr0avjrOeLJdFLh0kp/lAKArNxb/r8mTUPVSY+LYbSy97Ulny@vger.kernel.org, AJvYcCWFcsHJAsN1rLpLahqBxf4cp3YoUmrRdnWNWoNfQmH5QkaNADTK6lH0nTPkc4NkWa4T2sI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwvnm0xrKBrjUIMPhQ1oLtMLcc2aM/FBHTqLGfZuTylEbPeAaj
	hlr1p6yM+YiJSlHzjrV1WsbM4OezLGyX8P0faI/qpzzUMh0xjshL9Eqcuye64Q0E2MS7tQXw+ER
	v8M/WSIJ68Jlup+YSNfHWSBI3NgI=
X-Google-Smtp-Source: AGHT+IF6WFD2HTtJ7BJ/fBAWqZwQa7v86tjpi6w+MUJjMhbfg7N7EBJVnhVy9JECIJg9hGwf5FogmVQt9k3N/qdZwcI=
X-Received: by 2002:a92:ca06:0:b0:3a4:e856:a8fd with SMTP id
 e9e14a558f8ab-3a6175551f3mr67533785ab.22.1730442859009; Thu, 31 Oct 2024
 23:34:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-11-kerneljasonxing@gmail.com> <8fd16b77-b8e8-492c-ab69-8192cafa9fc7@linux.dev>
 <CAL+tcoBNiZQr=yk_fb9eoKX1_Nr4LuDaa1kkLGbdnc=8JNKnNg@mail.gmail.com>
 <e56f78a9-cbda-4b80-8b55-c16b36e4efb1@linux.dev> <CAL+tcoDi86GkJRd8fShGNH8CgdFu3kbfMubWxCLVdo+3O-wnfg@mail.gmail.com>
 <29a4e6ef-0af0-4905-8511-398fb20619bb@linux.dev>
In-Reply-To: <29a4e6ef-0af0-4905-8511-398fb20619bb@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 1 Nov 2024 14:33:42 +0800
Message-ID: <CAL+tcoD8jYsFPfAHAppbKSQu3eJS0V2V60xvijaUnN2rJSQiCg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 10/14] net-timestamp: add basic support with
 tskey offset
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, ykolal@fb.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 7:50=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 10/30/24 7:41 PM, Jason Xing wrote:
> >> bpf prog cannot directly access the skops->skb now. It is because the =
sockops
> >> prog sees the uapi "struct bpf_sock_ops" instead of "struct
> >> bpf_sock_ops(_kern)". The conversion is done in sock_ops_convert_ctx_a=
ccess. It
> >> is an old way before BTF. I don't want to extend the uapi "struct bpf_=
sock_ops".
> >
> > Oh, so it seems we cannot use this way, right?
>
> No. don't extend the uapi "struct bpf_sock_ops". Use bpf_cast_to_kern_ctx=
() instead.

Got it!

>
> >
> > I also noticed a use case that allow users to get the information from =
one skb:
> > "int BPF_PROG(trace_netif_receive_skb, struct sk_buff *skb)" in
> > tools/testing/selftests/bpf/progs/netif_receive_skb.c
> > But it requires us to add the tracepoint in __skb_tstamp_tx() first.
> > Two months ago, I was planning to use a tracepoint for some people who
> > find it difficult to deploy bpf.
>
>
> It is a tracing prog instead of sockops prog. The verifier allows accessi=
ng
> different things based on the program type. This patch set is using the s=
ockops
> bpf prog type which is not a tracing prog. Tracing can do a lot of read-o=
nly
> things but here we need write (e.g. bpf_setsockopt), so tracing prog is n=
ot
> suitable here.

Thanks for the explaination.

>
> >
> >>
> >> Instead, use bpf_cast_to_kern_ctx((struct bpf_sock_ops *)skops_ctx) to=
 get a
> >> trusted "struct bpf_sock_ops(_kern) *skops" pointer. Then it can acces=
s the
> >> skops->skb.
> >
> > Let me spend some time on it. Thanks.
>
> Take a look at the bpf_cast_to_kern_ctx() examples in selftests/bpf. I th=
ink
> this can be directly used to get to (struct bpf_sock_ops_kern *)skops->sk=
b. Ping
> back if your selftest bpf prog cannot load.

No problem :)

>
> >
> >> afaik, the tcb->seq should be available already during sendmsg. it
> >> should be able to get it from TCP_SKB_CB(skb)->seq with the bpf_core_c=
ast. Take
> >> a look at the existing examples of bpf_core_cast.
> >>
> >> The same goes for the skb->data. It can use the bpf_dynptr_from_skb().=
 It is not
> >> available to skops program now but should be easy to expose.
>  > I wonder what the use of skb->data is here.
>
> You are right, not needed. I was thinking it may need to parse the tcp he=
ader
> from the skb at the rx timestamping. It is not needed. The tcp stack shou=
ld have
> already parsed it and TCP_SKB_CB can be directly used as long as the sock=
ops
> prog can get to the skops->skb.

Agreed.

>
> >>
> >> In the bpf prog, when the SCHED/SND/ACK timestamp comes back, it has t=
o find the
> >> earlier sendmsg timestamp. One option is to store the earlier sendmsg =
timestamp
> >> at the bpf map key-ed by seqno or the shinfo's tskey. Storing in a bpf=
 map
> >> key-ed by seqno/tskey is probably what the selftest should do. In the =
future, we
> >> can consider allowing the rbtree in the bpf sk local storage for searc=
hing
> >> seqno. There is shinfo's hwtstamp that can be used also if there is a =
need.
> >
> > Thanks for the information! Let me investigate how the bpf map works...
> >
> > I wonder that for the selftests could it be much simpler if we just
> > record each timestamp stored in three variables and calculate them at
> > last since we only send the small packet once instead of using bpf
> > map. I mean, bpf map is really good as far as I know, but I'm a bit
> > worried that implementing such a function could cause more extra work
> > (implementation and review).
>
> Don't worry on the review side. imo, a closer to the real world selftest =
prog is
> actually helping the review process. It needs to test the tskey anyway an=
d it
> needs to store somewhere. bpf map is pretty simple to use. I don't think =
it will
> have much different in term of complexity also.

Got it, will do it soon :)

Thanks,
Jason

