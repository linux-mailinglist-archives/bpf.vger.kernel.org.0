Return-Path: <bpf+bounces-41820-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7335899B822
	for <lists+bpf@lfdr.de>; Sun, 13 Oct 2024 05:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014A01F2186D
	for <lists+bpf@lfdr.de>; Sun, 13 Oct 2024 03:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD5E12C549;
	Sun, 13 Oct 2024 03:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WihsZuTQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9124C12B176;
	Sun, 13 Oct 2024 03:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728790141; cv=none; b=p3k6HI69uDrdPptpdANBc7flm+0XTkkGYurqO0epjn9Pt0VF3rVmcRSKpttYCLFmGCOpCeFX/i4pjOW+YfFqRhUcaImuRm3saY+s6f2ZST7/0Dvg2/eqGPaNy4abN0z7G4KLfPhUqtBKJV54dDHM7SMVlszQIZxrWzCfzTPK9co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728790141; c=relaxed/simple;
	bh=RE5D09/ETSo0oJuS9PoJemCypbmSJu/wM/sfzwVWU/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QmUxHDG4M3ez9tT8XnVWcn4bmlyM88LSisGcKamo4vwhf9F04WxkEc7IB6UHw5djTllwF6CX6fihAmPr5nAx9BlPVQo6Xq/yA6kyIdzkUUIscslESviG4MRgdg6HywM6E4RQPDG3Zh+PROKMqXx1BWycjK9EaSuy31fH36mJzLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WihsZuTQ; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a3b67cd89dso5172195ab.0;
        Sat, 12 Oct 2024 20:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728790138; x=1729394938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSCy8XZCN59y6q/2jNyFlpssyR8wul9nt1j85mpQHLw=;
        b=WihsZuTQzNaHOQ8wRiqPeEHGs6aA9aChMDEcjKm3uFJ9IMHU0FXhIa6FsQnXzIDxq+
         8XVP1vudHH2vkujUFwz8LOsxOzl1oJ9oJQ+mSLqY8p3VQXjwvYo8f3q8+m+QzimnKjxK
         9A3dkpdgMCXJSulveT0lwof3BDuneZUCHBzCQhrPrT4ZK/USRb8QamKfbsjphI8WoCVE
         8hdmLtybkjUb6utkCFugnAcybMdJM7ZYQWm2yg9Quy91eNla3SZZ9i5n90rQj5i6D7w1
         gWDf/rkI+Fqgs3rrLypxwHLZCox1hju2CvDYOrCMzCFYN53dPPk6+0Vp4NQNb0qlE8LA
         01vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728790138; x=1729394938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cSCy8XZCN59y6q/2jNyFlpssyR8wul9nt1j85mpQHLw=;
        b=h8ekyDub1IM2lfD68+qPUe+N3npaqJ664EcsMfq/yHaz0CB2rfknpiUr8BPCLLVpYo
         zydEVfYpk+ArB8tZKPlLYEewxa49rWAcIHlcqLpVeG6vnL58LZXY522gAtfVyr+lmSYB
         HqSTUYHWZ8XNgkyJR8dlriiLCVNWu8OR2BVhguZNKLuyDp2cuH/OYL9/LH9VAlsSSBUA
         vMCJdySRrNACBVk0zRAJlrQmWtGVDt4Sai6FxhvCNQWTc1Gq6FvC6AABDjJI0FfJzhSL
         pTaERVJywzARwF+oFGpZzSMpmkwcm1CEioTqc+PeDLPWu3qsvn+DGhz8yYLpd0UbOMq6
         zeqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2pXxInj7DtTJdX5RAMgXOhWue2Ub5gBQjl60B6CJJuEo4FI6AO+LE/eVFoZBu7LReB9U=@vger.kernel.org, AJvYcCVdWrG4ZEMcdwTCM0+9TZbvbDtUM+UPecfs2eStqRyAg2Xuo4/bP9JeOnwTJ3r9RLsp87QJzOdl@vger.kernel.org
X-Gm-Message-State: AOJu0YysdfKl2xB3nCfBVcBs8I9RtuPoxrDaShe/YQxNXgH7pgNG/woy
	LLwCsXbfsbAJWPwGY7f8MoY7JB50vC8vkzJiz6w1TF3GLUH6xB6yG6AKtEUIAY9/OoF+Csu9wHD
	5gUHNiRWMJJ9qeP4jLI5drdUIwh0=
X-Google-Smtp-Source: AGHT+IE3OYnn9Dnw3m+Eh/WBpmmYAsT5ThgPGL8L8n2dkFeKcFXbL7LXLT+0IKcF+wHiHf6xGZMXHmwVqbS6b0p8lOc=
X-Received: by 2002:a05:6e02:1805:b0:39f:5def:a23d with SMTP id
 e9e14a558f8ab-3a3a70a4785mr72872055ab.5.1728790138430; Sat, 12 Oct 2024
 20:28:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012040651.95616-1-kerneljasonxing@gmail.com> <670ab67920184_2737bf29465@willemb.c.googlers.com.notmuch>
In-Reply-To: <670ab67920184_2737bf29465@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 13 Oct 2024 11:28:22 +0800
Message-ID: <CAL+tcoAv+QPUcNs6nV=TNjSZ69+GfaRgRROJ-LMEtpOC562-jA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 00/12] net-timestamp: bpf extension to equip
 applications transparently
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024 at 1:48=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > A few weeks ago, I planned to extend SO_TIMESTMAMPING feature by using
> > tracepoint to print information (say, tstamp) so that we can
> > transparently equip applications with this feature and require no
> > modification in user side.
> >
> > Later, we discussed at netconf and agreed that we can use bpf for bette=
r
> > extension, which is mainly suggested by John Fastabend and Willem de
> > Bruijn. Many thanks here! So I post this series to see if we have a
> > better solution to extend. My feeling is BPF is a good place to provide
> > a way to add timestamping by administrators, without having to rebuild
> > applications.
> >
> > This approach mostly relies on existing SO_TIMESTAMPING feature, users
> > only needs to pass certain flags through bpf_setsocktop() to a separate
> > tsflags. For TX timestamps, they will be printed during generation
> > phase. For RX timestamps, we will wait for the moment when recvmsg() is
> > called.
> >
> > After this series, we could step by step implement more advanced
> > functions/flags already in SO_TIMESTAMPING feature for bpf extension.
> >
> > In this series, I only support TCP protocol which is widely used in
> > SO_TIMESTAMPING feature.
> >
> > ---
> > V2
> > Link: https://lore.kernel.org/all/20241008095109.99918-1-kerneljasonxin=
g@gmail.com/
> > 1. Introduce tsflag requestors so that we are able to extend more in th=
e
> > future. Besides, it enables TX flags for bpf extension feature separate=
ly
> > without breaking users. It is suggested by Vadim Fedorenko.
> > 2. introduce a static key to control the whole feature. (Willem)
> > 3. Open the gate of bpf_setsockopt for the SO_TIMESTAMPING feature in
> > some TX/RX cases, not all the cases.
> >
> > Note:
> > The main concern we've discussion in V1 thread is how to deal with the
> > applications using SO_TIMESTAMPING feature? In this series, I allow bot=
h
> > cases to happen at the same time, which indicates that even one
> > applications setting SO_TIMESTAMPING can still be traced through BPF
> > program. Please see patch [04/12].
>
> This revision does not address the main concern.
>
> An administrator installed BPF program can affect results of a process
> using SO_TIMESTAMPING in ways that break it.

Sorry, I didn't get it. How the following code snippet would break users?

void __skb_tstamp_tx(struct sk_buff *orig_skb,
                     const struct sk_buff *ack_skb,
                     struct skb_shared_hwtstamps *hwtstamps,
                     struct sock *sk, int tstype)
{
        if (!sk)
                return;

        if (static_branch_unlikely(&bpf_tstamp_control))
                bpf_skb_tstamp_tx_output(sk, orig_skb, tstype, hwtstamps);

        skb_tstamp_tx_output(orig_skb, ack_skb, hwtstamps, sk,
tstype);
}

You can see, the application shipped with SO_TIMESTAMPING still prints
timestamps even when the application stays in the attached cgroup
directory.

Thanks,
Jason

