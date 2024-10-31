Return-Path: <bpf+bounces-43635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 063D09B7509
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 08:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 281621C23368
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 07:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AA514A635;
	Thu, 31 Oct 2024 07:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJEFgQeX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96F2148318;
	Thu, 31 Oct 2024 07:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730358320; cv=none; b=C+A3XxkO9ZrL1IJ8JmjmBn+ps8ogOAt1YrbmCYfrm8YvVliuzl7O/e1WFbip2cn4fYLpsH9iRFo+6RzGZyQuxXPyg0nfN7ti8OzUufYmSbCI1Rs+F2JlwLuZhcxrDTZdAyw5BqMd/CZjynKnWE8M0nWn12FxBIBcBvcdcwDDyGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730358320; c=relaxed/simple;
	bh=ziFMZhcj+leFELwUEjmBQ1LaRWWwukmoQhg8YxVAOco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQxphmjFiW3ZpDo5bffcved0b9EhJh5ILiCthpgTlvRQUHueoLEVmCE9PtWPn+KxPegq95nPhzLSTHl55E4RssHxvAIK6e6Cjb+NqPikhGxC7FaCh2Byafd2dE7ezt1Ao2gjtraNC/B4XEtJ6P+r201rwi5oje64JmZpML5C7zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJEFgQeX; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-83ab21c26f1so24065339f.2;
        Thu, 31 Oct 2024 00:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730358317; x=1730963117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2SkXndThhCcf1/mGVvarO7LUr9qmr9Xt0h6PkdmTHY=;
        b=GJEFgQeXPqhxU8VYGW1rDzfX5aEbhPPB8gTcibKea1wcl0LFFt39oT2g/gNKHGVIY7
         x1JBwRdXqK1GGZbid7eiMRrJ4QdoJvhGCi/ljEZy2Gi1Ljn8dGKHXkPMixfiHiv/gMUz
         AfvZ9yYdGvIBnMYwKYsiMXWn7f57fI9AfYb4pfUtozUelSFFvW7xQr+0kerNcPlzVchc
         V7R7pH2yVNvaA8pBjAyixEkBTiYW6v3ZqAczhv30PbEYp/qeAiow0He+sIIEj/sqi90y
         AQKIo69wnMHEr4dJ6Rvfti0LSlW7c5JSW3vPnIWC0mvl/Qveyu+4uumxnJW/YVJOrDUb
         P8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730358317; x=1730963117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2SkXndThhCcf1/mGVvarO7LUr9qmr9Xt0h6PkdmTHY=;
        b=HcQ0jGmtOXuXOvqINYg4oxlOGa6FdBl86yAgSUWLccSpvIvWjrQ1enlzvdbq4y9z6M
         EBvXgjVQtpqwf7vzpccaBCT4OUqabqlruZSYzP5F2O1us0+X7vOTz0+lxMJsc3lH7+Ym
         Mjx2ol7bgd9cCOk2NAmy6dd9VJbg0ps9xbXqN4O7R/nH8AyOdKz1hNJcTqwuriEMfY72
         9DC7P4/PtUhGssPGTXO8TcPxksLbzFhLEw3TPwkJB3X8keE6ahbN2f3Przu8Ioby8TE4
         d5c1ylZ4c3qjhxoLcvoMiaCyrJ+s7IsFrncDbSBKAafXQU6utFJJyQeSWz+N3Um0wgPB
         F4HA==
X-Forwarded-Encrypted: i=1; AJvYcCVI2EWp9ZZoENTLqN+1+aLNJyls3hxoNp796u/nW4qq48eAzmlomRJtw84RGgNNyaocg/vGLRsu@vger.kernel.org, AJvYcCWdfcLOoKR+tSn5UNwzVNsa/0YVW3iryNueB/bzq6bw+G298fnIoHxFnl8ipZvB3EOaAo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMJ/2DeX3pvoo/g/fBC9BsFf/pwSHirxTSuBqBOeYRemEcFvtT
	TScJQBFGg66QuYC9+SSlKFaiCv75sWNknoSLrTxsrnShU6VdWEiQ/df7xTzBB9pdB5jpAc1R1se
	9je1+AATFsgewd87vKRzHQCYgjsI=
X-Google-Smtp-Source: AGHT+IHc/LMy8LqpZcwjtYFeVo2QCen0QKVHW//6tn8HMjIsK7NdA7YSfMTOWbDZvf85L3MKrNFYq6q4iaD6F2GCsSA=
X-Received: by 2002:a05:6e02:1888:b0:3a3:445d:f711 with SMTP id
 e9e14a558f8ab-3a5e23461e1mr68886475ab.0.1730358316992; Thu, 31 Oct 2024
 00:05:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-3-kerneljasonxing@gmail.com> <61e8c5cf-247f-484e-b3cc-27ab86e372de@linux.dev>
 <CAL+tcoDB8UvNMfTwmvTJb1JvCGDb3ESaJMszh4-Qa=ey0Yn3Vg@mail.gmail.com>
 <67218fb61dbb5_31d4d029455@willemb.c.googlers.com.notmuch>
 <CAL+tcoBhfZ4XB5QgCKKbNyq+dfm26fPsvXfbWbV=jAEKYeLDEg@mail.gmail.com>
 <67219e5562f8c_37251929465@willemb.c.googlers.com.notmuch>
 <CAL+tcoDonudsr800HmhDir7f0B6cx0RPwmnrsRmQF=yDUJUszg@mail.gmail.com>
 <3c7c5f25-593f-4b48-9274-a18a9ea61e8f@linux.dev> <CAL+tcoAy2ryOpLi2am=T68GaFG1ACCtYmcJzDoEOan-0u3aaWw@mail.gmail.com>
 <672269c08bcd5_3c834029423@willemb.c.googlers.com.notmuch>
 <CAL+tcoA7Uddjx3OJzTB3+kqmKRt6KQN4G1VDCbE+xwEhATQpQQ@mail.gmail.com>
 <CAL+tcoDL0by6epqExL0VVMqfveA_awZ3PE9mfwYi3OmovZf3JQ@mail.gmail.com> <d138a81d-f9f5-4d51-bedd-3916d377699d@linux.dev>
In-Reply-To: <d138a81d-f9f5-4d51-bedd-3916d377699d@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 31 Oct 2024 15:04:40 +0800
Message-ID: <CAL+tcoBfuFL7-EOBY4RLMdDZJcUSyq20pJW13OqzNazUP7=gaw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/14] net-timestamp: allow two features to
 work parallelly
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, willemb@google.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, ykolal@fb.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 2:27=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 10/30/24 5:13 PM, Jason Xing wrote:
> > I realized that we will have some new sock_opt flags like
> > TS_SCHED_OPT_CB in patch 4, so we can control whether to print or
> > not... For each sock_opt point, they will be called without caring if
> > related flags in skb are set. Well, it's meaningless to add more
> > control of skb tsflags at each TS_xx_OPT_CB point.
> >
> > Am I understanding in a correct way? Now, I'm totally fine with this gr=
eat idea!
> Yes, I think so.
>
> The sockops prog can choose to ignore any BPF_SOCK_OPS_TS_*_CB. The are o=
nly 3:
> SCHED, SND, and ACK. If the hwtstamp is available from a NIC, I think it =
would
> be quite wasteful to throw it away. ACK can be controlled by the
> TCP_SKB_CB(skb)->bpf_txstamp_ack.

Right, let me try this:)

> Going back to my earlier bpf_setsockopt(SOL_SOCKET, BPF_TX_TIMESTAMPING)
> comment. I think it may as well go back to use the "u8
> bpf_sock_ops_cb_flags;" and use the bpf_sock_ops_cb_flags_set() helper to
> enable/disable the timestamp related callback hook. May be add one
> BPF_SOCK_OPS_TX_TIMESTAMPING_CB_FLAG.

bpf_sock_ops_cb_flags this flag is only used in TCP condition, right?
If that is so, it cannot be suitable for UDP.

I'm thinking of this solution:
1) adding a new flag in SOF_TIMESTAMPING_OPT_BPF flag (in
include/uapi/linux/net_tstamp.h) which can be used by sk->sk_tsflags
2) flags =3D   SOF_TIMESTAMPING_OPT_BPF;    bpf_setsockopt(skops,
SOL_SOCKET, SO_TIMESTAMPING, &flags, sizeof(flags));
3) test if sk->sk_tsflags has this new flag in tcp_tx_timestamp() or
in udp_sendmsg()
...

>
> For tx, one new hook should be at the sendmsg and should be around
> tcp_tx_timestamp (?) for tcp. Another hook is __skb_tstamp_tx() which sho=
uld be

I think there are two points we're supposed to record:
1) the moment tcp/udp_sendmsg() is triggered. It represents the syscall tim=
e.
2) another point in tcp_tx_timestamp(). It represents the timestamp of
the last skb in this sendmsg() call.
Users may happen to send a big packet.

> similar to your patch. Add a new kfunc to set shinfo->tx_flags |=3D SKBTX=
_BPF
> and/or TCP_SKB_CB(skb)->bpf_txstamp_ack during sendmsg.

Got it.

>
>
> For rx, add one BPF_SOCK_OPS_RX_TIMESTAMPING_CB_FLAG. bpf_sock_ops_cb_fla=
gs
> needs to move from the tcp_sock to the sock because it will be used by UD=
P also.
> When enabling or disabling this flag, it needs to take care of the
> net_{enable,disable}_timestamp. The same for the __sk_destruct() also.
>

I think if the solution I proposed as above is feasible, then we don't
have to move the tcp_sock which brings more extra work :)

Thanks,
Jason

