Return-Path: <bpf+bounces-74431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAD9C59717
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 19:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 730FB4EC2DA
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 17:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC65358D12;
	Thu, 13 Nov 2025 17:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ZPu7Q5C8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3176F2EA47E
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 17:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763056518; cv=none; b=g5sdDMEhPLJKfgiIHq1Z8Ah609Uc8QmpS1A9UfP5YbIbdshS1O7A1kS5+npkTujth6kDGcgwt5S27IbbSg6Ny3CfBAOMrwXizUPHqt2meqyZ4Z04PaVyjeg3MMAxbEFFMiP/hIfQ6XJ7wOrRnqlxOunECtagOUlssFzLSS453sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763056518; c=relaxed/simple;
	bh=QrP8WSrwxZSwzK10kjIjU69RxuAe7USLzcJZIRglKPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=orijokWeTgNYQs5Ao56l39AJi/CQgky6uZ6RiTAUUl1P7kHXNC70CMqi2gtZTWRLupVS9aqkJqrEaIPsGFqkqmccayTQjFTIf3IZjnMIeu7B6XMGECRrdAc9rRV90KywegR6aHqzmYG1dX8rdf4awnNqLo6OWw8dn9+L3kSmFEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=ZPu7Q5C8; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-343ea89896eso1142653a91.2
        for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 09:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1763056516; x=1763661316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QrP8WSrwxZSwzK10kjIjU69RxuAe7USLzcJZIRglKPs=;
        b=ZPu7Q5C81+7huyDqUOL3tFRjPqqF+yFYfRII+oo3dlzszuEO/bXZtdrrkK8dUB4Qgs
         HqxbuqUW9zLcyjVVWfBkBmCwcqd+orzvGJneUnGwETHRSRPKqsYOXJ9OlpjGpk02SWjf
         w7wFHa7tqfGRb/f811tYXUJ9Memtg/e0TQJHU0H3jzcVCIhrh4Vz97uxZuUg3SMsU9Fr
         e+loG8hmo0AszQqov0j7w73J23ByX82Q1BZaU00PUpcNM3E7BJnR+TaBwOh8Cy0Mn9Qp
         FPofDZ0P8ggOppaDLxpFw1GwA69G7bB/ikG41bY45woZB6i8ollR49ZCikfQNKbzd6l+
         WjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763056516; x=1763661316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QrP8WSrwxZSwzK10kjIjU69RxuAe7USLzcJZIRglKPs=;
        b=PnKBsh+9D7Fy3Yz+PFpplCE8yRl+fAXJKNe/jXCy947TMnIZ57YtP8xKlfjpcoOHIo
         iYcX4UoON5HhD5FpZZD1gdkNuXKf8wa2Bm5W6OLVxiiS7W9rJ4W2wGpj/wueBUJzjT69
         jcXx0X0glx2iQqbRD4+nSHp6sG1jhO3FUMXA8OPmKvm7tkFuTFDRV9P9pDK11ANcx1m0
         v7w2Cf7ztEDBoYYhBNJrvrrEz/jxNIaZvS5RSn6qVM88Z0poOqV17sw3Mp/DCc95ecoU
         d5GmYn+79HlhgLynJoDoCA+NXIK9LxCb6fwwH7MVNNrJRGgJi1SXgxXnQonA6VkM8ZLo
         HVdw==
X-Forwarded-Encrypted: i=1; AJvYcCWtuXconf3RorA1yrU1ZzBv9Oo+0tiJYrYcD6vkvwQY/c5yWAKkfWc/amVJKB3jEyYfSnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZk6vKeyDQzoRPbBpP/Hi2cgw0zOCdMx8HOGhkZDRWShymZKPs
	Km8jVIQZE3IqKaCYWLKyh8iE1o9LSubsGTpkqYz6KpGmme3pJTqOyxY6ENVN+R7DkiAVhA+jCJk
	jqt9LavwygAwHsa1awuk/Ux6pV//X51Pnhhas/Z1x
X-Gm-Gg: ASbGncsjqzhtB9fQP8UXz4zqeev8UYrNLwAnq+d22SyKD2qroNXvH58OvRQv+Ia8UO4
	eBjb50KivmDvRCRGVgUASzAhhj3cK62xx8LJMS44h1yF4wzSw4vbBs1PjqK1YZxoStsFhUVoeGq
	118mbAcLUzyJD3ToMH2lIXxdWR3Ti1fjmEolo9RsedHnKB4xOU4QIIMrOYBIhYXzJbdpYEYrGXV
	qdj3FdqOFbM16wPqyk5vjvDXlBxpRbH+u5jpiT3qZYWPR2tf13GFmc9+h5C9l40U1stvxWK72jc
	KTM=
X-Google-Smtp-Source: AGHT+IE/XO9J/WSX65NFV6ujW2giz3dJ1z7yatj+3YhBvSRx3o+rJltA7da1/5+EbarsW/DKSSLnOVc/DP63PEfFhW8=
X-Received: by 2002:a17:90b:3c89:b0:339:cece:a99 with SMTP id
 98e67ed59e1d1-343f9eb3128mr150252a91.13.1763056516417; Thu, 13 Nov 2025
 09:55:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112125516.1563021-1-edumazet@google.com> <CA+NMeC9WciDGe0hfNTSZsjbHDbO_SyFG3+cO0hHEc5dUyw5tTw@mail.gmail.com>
In-Reply-To: <CA+NMeC9WciDGe0hfNTSZsjbHDbO_SyFG3+cO0hHEc5dUyw5tTw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 13 Nov 2025 12:55:05 -0500
X-Gm-Features: AWmQ_bkH0ZjS_y9MVuYFVLZY4kYzawlEIzY6Roh5Sj879PFCOzb59qsiXNd707Q
Message-ID: <CAM0EoMnFaBkC6Hi8nJMGnAJYp_My7JJTsSpJkwLT86rOMdX1SQ@mail.gmail.com>
Subject: Re: [PATCH net/bpf] bpf: add bpf_prog_run_data_pointers()
To: Victor Nogueira <victor@mojatatu.com>
Cc: Eric Dumazet <edumazet@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>, 
	Paul Blakey <paulb@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 11:18=E2=80=AFAM Victor Nogueira <victor@mojatatu.c=
om> wrote:
>
> On Wed, Nov 12, 2025 at 9:55=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > syzbot found that cls_bpf_classify() is able to change
> > tc_skb_cb(skb)->drop_reason triggering a warning in sk_skb_reason_drop(=
).
> >
> > WARNING: CPU: 0 PID: 5965 at net/core/skbuff.c:1192 __sk_skb_reason_dro=
p net/core/skbuff.c:1189 [inline]
> > WARNING: CPU: 0 PID: 5965 at net/core/skbuff.c:1192 sk_skb_reason_drop+=
0x76/0x170 net/core/skbuff.c:1214
> >
> > struct tc_skb_cb has been added in commit ec624fe740b4 ("net/sched:
> > Extend qdisc control block with tc control block"), which added a wrong
> > interaction with db58ba459202 ("bpf: wire in data and data_end for
> > cls_act_bpf").
> >
> > drop_reason was added later.
> >
> > Add bpf_prog_run_data_pointers() helper to save/restore the net_sched
> > storage colliding with BPF data_meta/data_end.
> >
> > Fixes: ec624fe740b4 ("net/sched: Extend qdisc control block with tc con=
trol block")
> > Reported-by: syzbot <syzkaller@googlegroups.com>
> > Closes: https://lore.kernel.org/netdev/6913437c.a70a0220.22f260.013b.GA=
E@google.com/
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Paul Blakey <paulb@nvidia.com>
>
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

