Return-Path: <bpf+bounces-64098-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5D1B0E4ED
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 22:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0AE71892AF6
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 20:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48122853FD;
	Tue, 22 Jul 2025 20:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rd/efGhk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0091A28136B;
	Tue, 22 Jul 2025 20:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753215868; cv=none; b=bmPU2cewyh4akCYiDnugY9qYn0F355WoegBR2FD9Aup3JEhnUrHRwVBZQHTcACelAlsVb0MABCGxvMYt8UkMvbekBNGXDPcSRlLW9PuWHybsI/61r7IO5ixwWV3jzIgpzgns2q9qOOyv5BvFolhsfI+/lB011hDNozA85/fiNuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753215868; c=relaxed/simple;
	bh=Zousge6QLM6wIi/QHS/4MsbR60TIVdDrO6kQzrFtWX8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PRedQ4gdQqTTi9GmEEuwVe8IlTlxOQ5DwWzjmFkCuVv4T0Q4WtX/R3HJrtnmq3ZUn5lUK7keYfcLJdbU45wS9r8itneG2kKderOoq0C0lLMHkPgb7yFdgq/U9ScqpAL+Ehn3MEHTEZ2c6aDTNUCS8Nvqb3HDAjgK5su2SP0/n20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rd/efGhk; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7426c44e014so5486556b3a.3;
        Tue, 22 Jul 2025 13:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753215866; x=1753820666; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zousge6QLM6wIi/QHS/4MsbR60TIVdDrO6kQzrFtWX8=;
        b=Rd/efGhkwQshx/a4JHKH6vZViOX8RYLGX1CUlQr3pe6ID93Oelx4R0W306I142/KSf
         TVFGuH5ivzERAowTiWwkGL7cDWTajD0v79X8YTipHmjHH88FTApey6oH/qloPcRVVuwA
         WZf5DqN7OejfVnKaVFKloGX6MxrR7Oma/yf9Wab/+rvwOvVcc1BZH5l9889SK5znD6fo
         ejUWjA3jvjkyZx+fudnPNtP+uSLR44LrEp48LR17KbPYuvFImqe2EZNUTi7JJ3xKkvzD
         d5//EW5veBFdjEmleSL5uluS2LDvTQnNKeujuMTXQ3AfDiM6KiX0GPEZU4YQpL4IfXl/
         mbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753215866; x=1753820666;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zousge6QLM6wIi/QHS/4MsbR60TIVdDrO6kQzrFtWX8=;
        b=SIz4JPJNQ9wVYNFEwPaChV9HgMb2LDsGfEu/mhfrt63Uwjq2VfbDy8Xhjc1eSsaePZ
         GgU2szOmnljkbAlUFwseU0WfHaqFUiGrCUmv8Zqam2ABjuAuTXnTuhw7ab9f6ZUOwwBS
         ISlX9aRiGGCS5Y9PCHSmQM5YNpsPRpMYt/0uOaxaRI8qGbVb617xnOX2DnS2KJMdHizY
         0hwBNa7dX5nn9gaVCR7L6xl7DB618lS0JY9/SNyUzwyRIb0Hzkp8tGB/KtAF1x4t+LnQ
         MU5E9nMfuUcRN8W9TzfdYq1A3ShghfeK+XpmB2B6MQUV+swaeGYroeM6d/5BVoYiQZD+
         eNVA==
X-Forwarded-Encrypted: i=1; AJvYcCUwL4RW+xHUpc+rFOtbLynuC2ZWTJDUvIhZguOwDjZKTinVwcYfSxnVvnUKGwTxXCNhLDc=@vger.kernel.org, AJvYcCWIqGhA17GkJbI5fozuCYBwelWEJidAR/Zxx6J1NuqwY+2vTIq7Ea7bFwIn/gzSJLe3M3aM8Gp5@vger.kernel.org
X-Gm-Message-State: AOJu0YySOPZ44n/Yt81mcWPGIdjlbTkQD22sImGXAJtzwM83JfvyLpXL
	DDi/GSBUCBliP8w2ZyyxqAtaE8K4+gV/pU8ShgwhO26n8JxIXhri4vSk
X-Gm-Gg: ASbGncuV642MJ35vt+XWEuOxtpqENtBYK/cheKHblqEkEZlIpAPM7Qtmyp438oDmGSx
	AAxBnuGPZocUQQxzIzRolk578eKIs4F0e18JI8bPx/ZBGM6eKqjBDoGSCNq/32ibhVHne/uzeUR
	7BMLuDEgC6PPuMDb3AnBt8Ix/cJ34y/6v5dWTjCzdU0OJuRrm2XRuL+wv+Qr0f4b1tb9K6f7Xzg
	RlisgF9F4Qyy/+myo7UqnzM3CFUmo17k0MfSYTReEiPUixhpcQeHWJf4PZXt2BjDJMFMS5er+2i
	MpuTbth+HMSTh0JjvAGa3/ovx/sn2omiP52pnzvzZsj7k1/cli3J8iU10EHMpfkxsOJsCxVtlJe
	5P1bHndYaAIn7wNc3BAmujHA6vzit
X-Google-Smtp-Source: AGHT+IEJI/6T/t0w+LdXmQrY8KYhzew0afv3jFmVBZZl8R6GrpOHy2KCA7rq4AVlNXBOiV1nHk/ZHQ==
X-Received: by 2002:a05:6a20:6a25:b0:232:1be:1e09 with SMTP id adf61e73a8af0-23d4913ec6fmr314043637.34.1753215866302;
        Tue, 22 Jul 2025 13:24:26 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::281? ([2620:10d:c090:600::1:e6e1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb678f14sm8033619b3a.117.2025.07.22.13.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 13:24:25 -0700 (PDT)
Message-ID: <a0ccede15783e8bc34ce4e90c2bc40b8d50c943c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 07/10] selftests/bpf: Parametrize
 test_xdp_context_tuntap
From: Eduard Zingerman <eddyz87@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Arthur Fabre <arthur@arthurfabre.com>, Daniel
 Borkmann <daniel@iogearbox.net>, Eric Dumazet	 <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer	 <hawk@kernel.org>,
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, Joanne Koong	
 <joannelkoong@gmail.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Toke
 =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <thoiland@redhat.com>,  Yan Zhai
 <yan@cloudflare.com>, kernel-team@cloudflare.com, netdev@vger.kernel.org,
 Stanislav Fomichev	 <sdf@fomichev.me>
Date: Tue, 22 Jul 2025 13:24:23 -0700
In-Reply-To: <20250721-skb-metadata-thru-dynptr-v3-7-e92be5534174@cloudflare.com>
References: 
	<20250721-skb-metadata-thru-dynptr-v3-0-e92be5534174@cloudflare.com>
	 <20250721-skb-metadata-thru-dynptr-v3-7-e92be5534174@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-07-21 at 12:52 +0200, Jakub Sitnicki wrote:
> We want to add more test cases to cover different ways to access the
> metadata area. Prepare for it. Pull up the skeleton management.
>=20
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

