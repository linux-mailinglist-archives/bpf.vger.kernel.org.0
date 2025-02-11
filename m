Return-Path: <bpf+bounces-51112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EADA30482
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 08:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 242B1188AB26
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 07:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6773F1EC00B;
	Tue, 11 Feb 2025 07:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YuKXdiCo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDD51E885C;
	Tue, 11 Feb 2025 07:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739259119; cv=none; b=OIw06Vf6jxaBof4RnMpqemE18cPie9FA1tUmMTnVomfADENVGr5CIVV7RT9KJ9uj0JfdmlsloI5mTfeSOEsbGfflzpS1aeT+l+HdKIsFOzkWxetxVbis70REnpBFz9DNSO9qRJjjmgpD73fDMBCS3nY9pFnyx9qIRMVOxAk3OTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739259119; c=relaxed/simple;
	bh=xQNY808BB3LioFgXF/nrWmeV1f19gsbfNpqDCYchizE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfbbPLmb/0SYS3XGNQlXgNOXv9fP8UP0QlDC6vnHrMwRb85afC2PUOyEgOR/jroOx3qpoVjm4RQ4Sv/EotalvdI5eBH1BVbQRoTKzsBDXjS5qwdI7t2hQSM780xhVmM1TGmhAm31u5Uj8jgtQwXuNcjF7f7M+2oh813Q3QS2Umg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YuKXdiCo; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3d04d767d3aso42281115ab.2;
        Mon, 10 Feb 2025 23:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739259116; x=1739863916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQNY808BB3LioFgXF/nrWmeV1f19gsbfNpqDCYchizE=;
        b=YuKXdiCoHMwG6puDPd5XNplbvGOQhrRsR8u8iLCE7yPcXhEEgBHrCf1/Q9WNQsyubL
         mcscmHH2T5GsPFAEcD2AbpPgk2cjkypkmWmqlJoemgt7UvDfObA1EOseMxfkLmlnIuua
         xcW4E9oEcAFf297jloBcEfkIaipWmzxjJLOwPpPmriByINEl4P27BEPMQTrfWKMOL5M5
         NS4dOfR4qpXIXeJQikXRG9ataceRBg18iHNbMh6n2NykagrlQ86yyTUoVIH2NZgDI86H
         vIZTat7lJN40Wh/BBPhd6Bzc6QqIUyNHoVt7CQi/j6wKM3OR6B0S2ZUoXRA+9YFleWeC
         LIzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739259116; x=1739863916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQNY808BB3LioFgXF/nrWmeV1f19gsbfNpqDCYchizE=;
        b=mjxLeDyMP13sHuyj/WLoIxwuLjp/qiRMiBoEdgSEAwkHDLx4T4tPjLqn4BXTSkBP+D
         L9DbNVdgf0ajOaJ5l94i0RGAp+iJ8iIN5Oy/4DWG7YfgGnBoW8uYixx/JPp9DnMLX8a/
         gYk6u/nLkPLxwWTA6OrH6X0FkhOB7b7jFXS8VIIYYHYwYVEt4WkVw5Q9udL+Ebk/2QCe
         B8I35ERpqlNDFWHnEpazJkAGu83hu0OEhPGHej6B5gQEb0wxy3dJS0agptP2QGXe0WWn
         37RPtGDm4US8r4yfrCI5t/DUOs2BfAUPuedPKjlQxddGZF9nvewlpCcCTHfgdcHMPZ6I
         jGwg==
X-Forwarded-Encrypted: i=1; AJvYcCU0dGxTK17UguXFIrfgxZtIYKTYmBgmdvy+tGMVe/tLEsTTLOqpBUV1RTj4UTUrOsD4b2M=@vger.kernel.org, AJvYcCVz3BoWfKswumePnnJzSeC5azEIrfLiq7XCDnIiYYpf5JbKpb3Vnt8ef90Tu+YGdXH/ZOMLNkWU@vger.kernel.org
X-Gm-Message-State: AOJu0YziiVmVmUlZC3QxkGu2eCuCQvMajHJ8d6t8uIlmO5r/ogYjKwRy
	vdx2V3WfsKJbVKz8fPo9wDspxVHdPmJ1+M5cNdoH0Q2k56Qr6PQZ2CCEG4ZQd5LeP84FFm13l6o
	PBR3UIXpvV6TtFO/AoreYj0NyEyH6bscqCshfGw==
X-Gm-Gg: ASbGnct5JcyAkCxmk2eH5Ol3q86qiuncoTpVlRLpgiEGEd5ZJZxKWKId48RBaFIG5A4
	f/5vih1GlVGnEzbPxdngM6OVBOBzfBdmSIr+pVXUFq8ldhABZgYcyap3d4lBX7yj/0YaCtgdF
X-Google-Smtp-Source: AGHT+IFma4K9XiA0wZQyLiN2i5ZuQVHTUDBcZGUcrvor0pNeHKv7Mp7Huys2fuyKjwFNByuCwRq0WL5szjhPiWNdzCU=
X-Received: by 2002:a05:6e02:1a41:b0:3d0:147a:b5da with SMTP id
 e9e14a558f8ab-3d13de77c41mr137462995ab.5.1739259116595; Mon, 10 Feb 2025
 23:31:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208103220.72294-1-kerneljasonxing@gmail.com>
 <20250208103220.72294-7-kerneljasonxing@gmail.com> <2d9da8b0-5246-4760-abf8-dc70d7a5e3ee@linux.dev>
In-Reply-To: <2d9da8b0-5246-4760-abf8-dc70d7a5e3ee@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 11 Feb 2025 15:31:20 +0800
X-Gm-Features: AWEUYZnGptL5-puf39XfwqHBE2J8nczMGTSGaRuuX-p4rGwZ_oHiL--jr4DXvZE
Message-ID: <CAL+tcoBQrEn=qzak0hnX=8=wr1=JKEF+2fSF4TJu08VGTQMN_w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 06/12] bpf: support SCM_TSTAMP_SCHED of SO_TIMESTAMPING
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 3:12=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 2/8/25 2:32 AM, Jason Xing wrote:
> > Support SCM_TSTAMP_SCHED case. Introduce SKBTX_BPF used as
> > an indicator telling us whether the skb should be traced
> > by the bpf prog.
>
> The BPF side does not exactly support SCM_TSTAMP_SCHED as a report value.
>
> What this patch does is:
>
> Add a new sock_ops callback, BPF_SOCK_OPS_TS_SCHED_OPT_CB. This callback =
will
> occur at the same timestamping point as the user space's SCM_TSTAMP_SCHED=
. The
> BPF program can use it to get the same SCM_TSTAMP_SCHED timestamp without
> modifying the user-space application.
>
> A new SKBTX_BPF flag is added to mark skb_shinfo(skb)->tx_flags, ensuring=
 that
> the new BPF timestamping and the current user space's SO_TIMESTAMPING do =
not
> interfere with each other.
>
> I would remove most of the SO_TIMESTAMPING comments from the commit messa=
ges.
> The timestamping points are the same but there is not much overlapping on=
 the
> API side.
>
> Subject could be:
> bpf: Add BPF_SOCK_OPS_TS_SCHED_OPT_CB callback
>
> [ The same probably for patch 7-9. ]

Thanks. I will similarly adjust them as well :)

Thanks,
Jason

