Return-Path: <bpf+bounces-43642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F439B7A88
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 13:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA44A1C21DBB
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 12:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8EF19ADA2;
	Thu, 31 Oct 2024 12:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmnGX2RY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3861DFFC;
	Thu, 31 Oct 2024 12:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730377852; cv=none; b=qijtmhrZYHMyaC+yvDa0r86C/U7L2GL9+IScchaAx0MsvvRaBnymGBG08M9xmhuDrnnokCyMGCY1NcAFHZaEWgpN1fKrmgcErtcuNVTaQyKLW3embGcr91i3Kwi603mCJytmKq5GaYkCV8H/4nfo8HFyumeZUS7T3aA+AxIFONk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730377852; c=relaxed/simple;
	bh=P55LwGvoDxnXs011gHgWu2FTdb/03vVy6pYDQctqJ4E=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=O+bsfhdfottuEi3zLXsI8In/sQMCKcavQUEPb4MJT6573yiIZZpbamR0KQT3E+dMNQY0TVw4oq2pHh+rS94MRNbp0l99gaceQ2lJbm45EyXlietWcUrbljLl3rt+IBMDSwzpCJx7jAV0v7stw4wC6JHdkzaMInMz4NV3gw7anU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmnGX2RY; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b15d7b7a32so64134285a.1;
        Thu, 31 Oct 2024 05:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730377849; x=1730982649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Np32xWGh4nOX40mzC7RrQhve/lLTHk3smooxRQ3lL8g=;
        b=GmnGX2RY8UOkFeVBetr8q9y7wWsEZenWGucg2nBl+jiJIpTqiI+35y4EXk1K+ex+dy
         aetLwNsEonSNdvnCQEaKDGB/5FMCpY6RdBs8bveeq008fVmLutcDU8w7iYG2+nNh8jCs
         kVkZeSbCEj1Epq8OjHzKJIwHO2VGHUubi9cCtnYNBhUqDr/f7AsLIJzDc9BEMOODr4MZ
         q0V0LE/BrUR4CjhDYls66pQJU/1VK9pfeDgnLSPLBiFgc2ecW/31cNTbuArBOBxIxtau
         ub/q5nCgMoCyb5nSjq5VeCVpn0iXMx8YAu/XeFx0tbSRwibUByPowny88/z9V8givWN1
         srnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730377849; x=1730982649;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Np32xWGh4nOX40mzC7RrQhve/lLTHk3smooxRQ3lL8g=;
        b=FruhmncNY91+uyIJ2xwIB8iIJgVLAqHtEJa4TbI3d9aA6qmJEXY66pY6p0kaOkpMej
         Smw6UtMRK0WSJfxLeHXuDBNX+/r5qPUSfZ+09lUalcrQq1MbbwuSd45StEsBpoWt91oI
         Op2qJk0+u2KoZ/uM79QNJoZo7TPOtyKlVzBMEUdfHYXpLq7RBXNRQkPSJ8UPvzkG0xgX
         4PcxMh1ZwGt9NA+woofFL9bmGXPlGrCA/ThzBWbU/LnZPnfLEzbecjHxjX2uJhEIO6No
         sp4JCkdiG+ysy9txPyR2hx9C0pH7L8e64n5F+LH/KUV3w+vWTAvfB66Pu7kRFfMCKdwI
         oigQ==
X-Forwarded-Encrypted: i=1; AJvYcCVucpRvj1HA5ID393g2BT+h0G5nCkVUPyiHvPMckGYdOsib+rOrxBfro7nk8/U9SiHyG2IdmgIW@vger.kernel.org, AJvYcCXdGVDge1HAi6KdJloKMBuMAx/yBCHsJYOrSK61TTKcwfE6I+MEDcSpHW8RU4efByC2Mrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW5fxbldcuXyXpHbaAUuUU6YUYp3Tc9+SOCwdR1x7apS+ebIvX
	NZgzKeu5uGBN8cXgcm/Xd+aZ5ofmJkST/CvR1Mwx9jZs4Wh4PIe2
X-Google-Smtp-Source: AGHT+IGQYi+pE1TBlsl6XOMQIW5C8tGZCw60fdI6fmH2VlNRs3UfOoT4ZSSn7gCTVZ4cPFCwQ8xq8w==
X-Received: by 2002:a05:620a:2445:b0:7b1:5680:164b with SMTP id af79cd13be357-7b193efa878mr2985041585a.26.1730377849090;
        Thu, 31 Oct 2024 05:30:49 -0700 (PDT)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f39f8fffsm64074385a.29.2024.10.31.05.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 05:30:48 -0700 (PDT)
Date: Thu, 31 Oct 2024 08:30:47 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 willemb@google.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 shuah@kernel.org, 
 ykolal@fb.com, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <67237877cd08d_b246b2942b@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoBfuFL7-EOBY4RLMdDZJcUSyq20pJW13OqzNazUP7=gaw@mail.gmail.com>
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-3-kerneljasonxing@gmail.com>
 <61e8c5cf-247f-484e-b3cc-27ab86e372de@linux.dev>
 <CAL+tcoDB8UvNMfTwmvTJb1JvCGDb3ESaJMszh4-Qa=ey0Yn3Vg@mail.gmail.com>
 <67218fb61dbb5_31d4d029455@willemb.c.googlers.com.notmuch>
 <CAL+tcoBhfZ4XB5QgCKKbNyq+dfm26fPsvXfbWbV=jAEKYeLDEg@mail.gmail.com>
 <67219e5562f8c_37251929465@willemb.c.googlers.com.notmuch>
 <CAL+tcoDonudsr800HmhDir7f0B6cx0RPwmnrsRmQF=yDUJUszg@mail.gmail.com>
 <3c7c5f25-593f-4b48-9274-a18a9ea61e8f@linux.dev>
 <CAL+tcoAy2ryOpLi2am=T68GaFG1ACCtYmcJzDoEOan-0u3aaWw@mail.gmail.com>
 <672269c08bcd5_3c834029423@willemb.c.googlers.com.notmuch>
 <CAL+tcoA7Uddjx3OJzTB3+kqmKRt6KQN4G1VDCbE+xwEhATQpQQ@mail.gmail.com>
 <CAL+tcoDL0by6epqExL0VVMqfveA_awZ3PE9mfwYi3OmovZf3JQ@mail.gmail.com>
 <d138a81d-f9f5-4d51-bedd-3916d377699d@linux.dev>
 <CAL+tcoBfuFL7-EOBY4RLMdDZJcUSyq20pJW13OqzNazUP7=gaw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/14] net-timestamp: allow two features to
 work parallelly
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Xing wrote:
> On Thu, Oct 31, 2024 at 2:27=E2=80=AFPM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
> >
> > On 10/30/24 5:13 PM, Jason Xing wrote:
> > > I realized that we will have some new sock_opt flags like
> > > TS_SCHED_OPT_CB in patch 4, so we can control whether to print or
> > > not... For each sock_opt point, they will be called without caring =
if
> > > related flags in skb are set. Well, it's meaningless to add more
> > > control of skb tsflags at each TS_xx_OPT_CB point.
> > >
> > > Am I understanding in a correct way? Now, I'm totally fine with thi=
s great idea!
> > Yes, I think so.
> >
> > The sockops prog can choose to ignore any BPF_SOCK_OPS_TS_*_CB. The a=
re only 3:
> > SCHED, SND, and ACK. If the hwtstamp is available from a NIC, I think=
 it would
> > be quite wasteful to throw it away. ACK can be controlled by the
> > TCP_SKB_CB(skb)->bpf_txstamp_ack.
> =

> Right, let me try this:)
> =

> > Going back to my earlier bpf_setsockopt(SOL_SOCKET, BPF_TX_TIMESTAMPI=
NG)
> > comment. I think it may as well go back to use the "u8
> > bpf_sock_ops_cb_flags;" and use the bpf_sock_ops_cb_flags_set() helpe=
r to
> > enable/disable the timestamp related callback hook. May be add one
> > BPF_SOCK_OPS_TX_TIMESTAMPING_CB_FLAG.
> =

> bpf_sock_ops_cb_flags this flag is only used in TCP condition, right?
> If that is so, it cannot be suitable for UDP.
> =

> I'm thinking of this solution:
> 1) adding a new flag in SOF_TIMESTAMPING_OPT_BPF flag (in
> include/uapi/linux/net_tstamp.h) which can be used by sk->sk_tsflags
> 2) flags =3D   SOF_TIMESTAMPING_OPT_BPF;    bpf_setsockopt(skops,
> SOL_SOCKET, SO_TIMESTAMPING, &flags, sizeof(flags));
> 3) test if sk->sk_tsflags has this new flag in tcp_tx_timestamp() or
> in udp_sendmsg()
> ...
> =

> >
> > For tx, one new hook should be at the sendmsg and should be around
> > tcp_tx_timestamp (?) for tcp. Another hook is __skb_tstamp_tx() which=
 should be
> =

> I think there are two points we're supposed to record:
> 1) the moment tcp/udp_sendmsg() is triggered. It represents the syscall=
 time.
> 2) another point in tcp_tx_timestamp(). It represents the timestamp of
> the last skb in this sendmsg() call.
> Users may happen to send a big packet.

Err on the side of fewer measurement points. It's always possible to
add more later, but not possible to remove them (depending on whether
BPF infra is ABI).

Overall great suggestion. Thanks a lot for sharing your BPF expertise
on this, Martin.

On using the raw seqno: this data is accessible to anyone root in
namespace (ns_capable) using packet sockets, so as long as it does not
open to more than that, it is logically equivalent to the current
setting.

With seqno the BPF program has to be careful that the same seqno can
be retransmitted, so for instance seeing an ACK before a (second) SND
must be anticipated. That is true for SO_TIMESTAMPING today too.

For datagrams (UDP as well as RAW and many non IP protocols), an
alternative still needs to be found.

