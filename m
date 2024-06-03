Return-Path: <bpf+bounces-31196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6208D847E
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 15:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F03B0B20D37
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 13:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5A812E1C4;
	Mon,  3 Jun 2024 13:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9+pIp4n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E259612DDB3;
	Mon,  3 Jun 2024 13:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717423072; cv=none; b=d+Lm24cMJ3euwhnvD1LJ7I0zAxItnGhXkhCnnlzgigZ5ThGIh4msHETQXrT3JPW23gMX1k5ZC9RNHIvApgyowzStTSJRdvCo5QkMmLIdswhOKBu4m2zI4aNcFfK7ypxz506nV2JI1EERg/hg8Q+Eg0ZPeVw1gKPo/PJxjbv+65w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717423072; c=relaxed/simple;
	bh=xR7tli7UMq6+0LulCJuMxzoFaNerAfBESDgOjvkKBiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kMCzN/KjW4PnBzaNPUSQA+bJFCeqfq16610alPgYLr5Mv7noRP9AzuidrdTl1NJgG6WjResKXs4qcLfe3yE6GXjBm2ujrCAlCgYAnLNvdca6svYFeIVvM9+vnG6fLbbX1QOSB7gV5JxDxmusbey6LFIzSP1XNotz4nEkRVoy2wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9+pIp4n; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f68834bfdfso3462665ad.3;
        Mon, 03 Jun 2024 06:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717423070; x=1718027870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OxwV1lkxk33yUVookSNHrpCsCZ304NnsFLLe4ku1ykA=;
        b=T9+pIp4nCRP2U3024SFIwMirQ1Jy10m5CfozB9KnP2selNtOrbYrxwXkyuLX272vnt
         RZ3HvpgpSn+TewBRgTkKqCDvF8Cd+yrDzNbNMB3arG0m+yKXO0msMrX2yHo+z296OE6G
         27zcYHNSRzKrigne7m5+GueJWUbdYUkIlXlpHgWx8r4HfgTYvWZxVPUC1LhszFUC0xgc
         X/WCcU32c8QUWsSRBI/BtHwackGxk94944/+4h0Hxf8TgVoEbYuMw4RQsERXl1v6QJi9
         5BHwBLsWP7TJoIUZC9pT3g63bUbuhpqNlfRHhrVCa34KfslfpC1AcApjh1/99aBXmO6T
         rWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717423070; x=1718027870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OxwV1lkxk33yUVookSNHrpCsCZ304NnsFLLe4ku1ykA=;
        b=uhntqigBmxg0jIlpohxqnjLZePQnALpRmnVdZAgfkpcWQBrgWMr4/pOrmAkyTyP6Yl
         BmQ5yA6r3IclWAPE/CAODpNJHum3KUHHB5Syf025RJfcD5CbU1hlha2MpkO/v+TC5/Tc
         f94cp8TdvrFrBR8K8Ri0OipXW2wbBePRjjImOHRDOyEOJh4DNtU+Z7429xnuTlsyB9/F
         WXHfPq0Esc1eqHFi7jhxdCtdMuOpedEJFCgGtOmJeKWgUGUxeyC/1jGzBqFBtEm+9m8r
         /6N0yYP2nM3+Joo8I5ubcE+2/9ykBIdNUXnGHPTg4nLVTwvJ/8C6KnXB7JxU+e4KjS3j
         iTrg==
X-Forwarded-Encrypted: i=1; AJvYcCU2KZ91Ghk0pzDHFL4CeiDrkJdhm1tk40FUJMFRq61IRdQGjWHnPyvZpH70phNrA1+Qg3rWkWGwTKhmB5V22l53VI/t/ayQ
X-Gm-Message-State: AOJu0Yw5l6I1jvBZa8PHni5dHWEUPoBn81ECFtJ4O0cja9U11gJKZq0N
	/5MBPRS1UG7mfLWMJo5jQNUkiEKHIK4RPQdoq1vPkmuahbPeNEq3lm+VQo7AOFcpPwhHHR0L/Hr
	7vTTPtW2Ida+sOvyT8I3UefiQ8Cw=
X-Google-Smtp-Source: AGHT+IF9StXXMxGEGC2HrHgUdtPgFPc+Nv4XSF1AcZj2Wdvbw0Aejjedqn9y9LrfsYO079543383vDgkkmYzUcXpHNs=
X-Received: by 2002:a17:90a:b005:b0:2c1:e379:57c with SMTP id
 98e67ed59e1d1-2c1e37905a1mr7059989a91.39.1717423070142; Mon, 03 Jun 2024
 06:57:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zl2GtXy7+Xfr66lX@kodidev-ubuntu> <cover.1717413886.git.Tony.Ambardar@gmail.com>
 <5416a38a194bb97930f5a2e672165e573b82857b.1717413886.git.Tony.Ambardar@gmail.com>
In-Reply-To: <5416a38a194bb97930f5a2e672165e573b82857b.1717413886.git.Tony.Ambardar@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 3 Jun 2024 15:57:38 +0200
Message-ID: <CANiq72n-s4e=KX9yzf8CivnkxyH-YKShSKGS4upKPpGo=xcRqQ@mail.gmail.com>
Subject: Re: [PATCH bpf v1 1/2] Compiler Attributes: Add __retain macro
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 2:16=E2=80=AFPM Tony Ambardar <tony.ambardar@gmail.c=
om> wrote:
>
> +#if __has_attribute(__retain__) && \
> +       (defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || \
> +        defined(CONFIG_LTO_CLANG))

Since this attribute depends on the configuration, please move it to
`compiler_types.h` instead.

Cheers,
Miguel

