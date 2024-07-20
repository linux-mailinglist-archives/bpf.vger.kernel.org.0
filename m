Return-Path: <bpf+bounces-35141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C57937EC7
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 04:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 594581C2139C
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 02:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E43B9449;
	Sat, 20 Jul 2024 02:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/u28uAk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10924B64A
	for <bpf@vger.kernel.org>; Sat, 20 Jul 2024 02:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721444253; cv=none; b=RYQkwCqR1MyYgP14b5uuqlUjqcyBotxICuFAyVQlc2vrISrrNMJKXKfCPSzLOcg2vPq3xV4AjJxqNLhqLBlRSxQWHi0WXtjQPpCCiTsxrD7DbwdrybTzGCGgONv8kK2QYVWv/mD4p1sLKHT7B7meBdhy/MeI6Ok9d3tzi8txGKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721444253; c=relaxed/simple;
	bh=vA5GrdA7zxVcrriAT0JUM10wkpcE3cMJzB9FaKAV5zE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PU+T6h6Zho1VbEOKoCXgXrNY6TLhjembJPRx7g1ye6+LYD7NxbLhHWpC89klT7S0oMcr9Wl/5yGLDnZg6DE+UiE1YNoPTFJNb7rFYCEL6+zljXET6aFFjcokBrtqsZOYHhvmcXPMA9gTLz2EmywC18hJfTWZWaHp/YRTc1SyBvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/u28uAk; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3687ea0521cso1110750f8f.1
        for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 19:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721444250; x=1722049050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vA5GrdA7zxVcrriAT0JUM10wkpcE3cMJzB9FaKAV5zE=;
        b=V/u28uAkdv4sHm+1VzDBqYqrWK7FD1BpIC5vDtds7kR/eZ6oXw15PPDBiOQCAaOmlt
         Sl0EL2Qg2RiRHloB49Z7nmgBiCPdGuU2NYDGNNTLjyly3xj4OrjoPf2B9PYkVdkcnHSp
         a13oSv+j8TpcWgQrZobsRz+8C/xv95kszkrpsJwmx4FqCGhbDbNaMwOL50ICIdZQ80Hp
         x7v7ZhhI8SXONjNCK1KznFwL3km6Kffy6qXtZCZnhUPOpkMeE/ZrYvm+kbAK3kSWb5Hz
         CG7/pRpGVzVBTrXfSClu6JpV/kq+lTrgezioWXBm4AjQ2rlATcVRUnw3tlhMG5zQ4lAX
         nH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721444250; x=1722049050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vA5GrdA7zxVcrriAT0JUM10wkpcE3cMJzB9FaKAV5zE=;
        b=ZHn4n2tCnltuf59tjujeWuR4DKX+S908g+wk4z2dBv6L+EToLaT0KAKbpQUuhd1Na4
         QyjEFjEqnRHZ7yQsUHYcwSU98mTLaU1QezH8XZnMYcUGtq2YQc7DsqdHMu837jhwSU63
         j/m58MQx7kcD++jL/4BnQUjYa0tgE2B2jdMdpkOfXKMHMpgURNXBMujSG8D6SZ6XLaqx
         1SRNM6QVSNpwdn7t8WdfvAYfCaRrM3vs97zs3UTN8aovoKM0oDFosj1Fgwhf06Tl9fA7
         h85sefAuDXAii3FRtLYbtlbzdidVpJ3Myr1cVIbNMbma/gpaCUOSVz0aIv8ZPXoNpnBa
         aZGA==
X-Gm-Message-State: AOJu0YxHQ7cf5905122KCg5BvqxZcc9xHkMFzZZ5ptv9JKqxV5/1BTa6
	TZ0iOAvhvCBSXnWsach+EFbLzYj32HiNKJOPp9YYs70ez5J4c9RoxNajIKFkoC3Rs9bxIbdx5qy
	5jpJwm8KkqkDzCa+S5TBwWKf9p4w=
X-Google-Smtp-Source: AGHT+IHwRDedOw7PAVKJA3wp2qrPamgrUALckMPbQKxpyd2t0uqdf+t8P8nJxxYhC7xeSwy8YSgnigkaAr7lwtYDWn8=
X-Received: by 2002:a5d:420c:0:b0:368:3384:e9da with SMTP id
 ffacd0b85a97d-369bb2d6208mr146959f8f.62.1721444250220; Fri, 19 Jul 2024
 19:57:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240714123902.32305-1-hffilwlqm@gmail.com>
In-Reply-To: <20240714123902.32305-1-hffilwlqm@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 19 Jul 2024 19:57:18 -0700
Message-ID: <CAADnVQ+TOFOA0Ya4qzrLDFV331uxZy8ay0svBMt-2Sh5E0tr2A@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 0/3] bpf: Fix tailcall hierarchy
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, Eddy Z <eddyz87@gmail.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Pu Lehui <pulehui@huawei.com>, kernel-patches-bot@fb.com, 
	John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 14, 2024 at 5:39=E2=80=AFAM Leon Hwang <hffilwlqm@gmail.com> wr=
ote:
>
> This patchset fixes a tailcall hierarchy issue.

Thank you for sticking to it. Applied to bpf-next.

It took almost a year, but the final fix is imo much better
than all the previous attempts.
I suspect some tail_call users may see a small performance
degradation, but it's a trade off we had to make.
The evolution of the fix made the perf hit as small as possible.

