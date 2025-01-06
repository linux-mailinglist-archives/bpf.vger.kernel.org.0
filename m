Return-Path: <bpf+bounces-47904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D954BA01CD4
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 01:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 523461883823
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 00:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335EC134B0;
	Mon,  6 Jan 2025 00:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3JNsYNL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86273224;
	Mon,  6 Jan 2025 00:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736122597; cv=none; b=mI+e7fsrZ4EJLmXNMTSrZTUUxxsoKOKACWRwsZgD6dhNCw+oit26H4WBCOvx2rhkF3oqewKc6UrIm6wCBUtNJcmsP0Os7ljMc7dJ0CIYmu9epr63I5gJgv4eWfAknsMh3OFb7muKBac9c6V1IgbxCOB5lcFdXS6uUbHs/TxbxDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736122597; c=relaxed/simple;
	bh=ojec6Ee3CNoayywAB5Amc17aicUGxD2T3RDpyIPsMPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PsZrDVA217sDCtq0ubJgu302MpzOSBKCgI0fZ5MXPmrtTBdhrkyy7V4WGc64DheMMtZGKZV06ZeKp4gl3B++h/h9FKlIaEY/GAf5fs2qk7RT2sLItNsbrsxkKTwsH2/HediZPgiKRrRiwWQICRI7n3fzGTCvjF95jUq5gI9t1dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3JNsYNL; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43634b570c1so99047205e9.0;
        Sun, 05 Jan 2025 16:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736122594; x=1736727394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIqv1w/KzDHT3jhVDEhZI6SzEmkBsffQKD6siBUIkOQ=;
        b=e3JNsYNL2CWqFiM9Wrb31sn7r41YHC6W73sgfSWYi0NfItL6yQ3rw+uo1PqP5P2TWc
         psIvMwSEd6sgcJhcou87XVDmGzthP0Icg/X9PtG76IGDFYu6LBSmW1mEJeJFM014wx1w
         nS8JGz34i+iKX0n/Xq7hN4BsFZ2iD6g7EP+QBDQDG6MoM9d4UQ+XdqkIGdru+BKhAtG0
         0HrvKuV0YEna/7tkng9F5CdlNOHJ/VrTDnU04qb8jskLcSxgL/RGRA3MIUI/dS+pq9XD
         WQkxT7tuYucwfsG1qBR+SYnBGGnjko+5yEB8I//MROrX4shr3Seyu3GRuhR+UUWgDrIS
         yJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736122594; x=1736727394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KIqv1w/KzDHT3jhVDEhZI6SzEmkBsffQKD6siBUIkOQ=;
        b=Mp/dASgciZ/SfPVef5URWJUOvCTADSL2wc6CA+9WYKxTmiR/jNxampQARksbJ/PwsJ
         VTESFu2K5BbkeG60wGIu2TFijN7OhTMlYpSizgmSxytTUAVq35bZZsw4msA3aaRXugmU
         YC/sYDwtq/YEoLu4JMGKg/LbuZx6G3fbtlwYiFRi2hviFPYK2+tu6crujHomZOM5i+n/
         2Cyy5l0Cc/OS482kqzjaUJfJlxSJqBHpc1Q22xfD5oTXwld9oiEzo5FgfkPqVFGRbbm/
         s/mLvZqfWtp20Ga0s1uNtxV5+R9Pg8HLB5h3OHCuEH/vDX52syW5PKvXBG3+mlQ9YUDs
         kXWw==
X-Forwarded-Encrypted: i=1; AJvYcCUM5Ecz0G7sij1Gbza75Tk75vXG2qmutPUeuF4Y6N0BtQGQiUPWGvcE5ky1XxEb9wuQFtcckV3j@vger.kernel.org, AJvYcCUwDeZvu/o34JrUuVJM20B1cnAP1kLmSJoDuW/7xBtf5SjjdDWtOifkJAiEylesJ1o0IRs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdqgr/mMejwzqxV5PWs4Bju/aoNBOyrdGq2bX3SAwCnBTuQRL2
	CNc28uGfPGb/S4Qjt2b5+9TpxjOPfdhUNW8RNmvkNGKrCUX9V5YqhB+X2zZzXvKRfbYrM1UXtSK
	Kp0e/UxE0dZl1JN+JHyph9AcDWpY=
X-Gm-Gg: ASbGnctj6rguHV0V+et+d+moU0p15cd9HHtOuqfr4dWRtZTx/87PivWPiMNIsxfiIV3
	GDrQDJXndeAidlfDetz4O9M04hHliIOe4iRs1hw==
X-Google-Smtp-Source: AGHT+IGKPz9CgDuluCultGgcXxKmIs38Aua/eInGLsF6WqnbAtAQ7V1TsQkDoEoNOaEWrYHEiayWj9R0UUtkjPK6clA=
X-Received: by 2002:a5d:598f:0:b0:386:424e:32d5 with SMTP id
 ffacd0b85a97d-38a221ea939mr48432959f8f.14.1736122593449; Sun, 05 Jan 2025
 16:16:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250105124403.991-1-laoar.shao@gmail.com> <20250105124403.991-2-laoar.shao@gmail.com>
In-Reply-To: <20250105124403.991-2-laoar.shao@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 5 Jan 2025 16:16:22 -0800
Message-ID: <CAADnVQ+ga1ir9XCDxPiU_-eYzKHTQsiod9Sz4_o3XeqGW2rq4A@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/2] libbpf: Add support for dynamic tracepoint
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Eric Dumazet <edumazet@google.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 5, 2025 at 4:44=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> Dynamic tracepoints can be created using debugfs. For example:
>
>    echo 'p:myprobe kernel_clone args' >> /sys/kernel/debug/tracing/kprobe=
_events
>
> This command creates a new tracepoint under debugfs:
>
>   $ ls /sys/kernel/debug/tracing/events/kprobes/myprobe/
>   enable  filter  format  hist  id  trigger
>
> Although this dynamic tracepoint appears as a tracepoint, it is internall=
y
> implemented as a kprobe. However, it must be attached as a tracepoint to
> function correctly in certain contexts.

Nack.
There are multiple mechanisms to create kprobe/tp via text interfaces.
We're not going to mix them with the programmatic libbpf api.

