Return-Path: <bpf+bounces-75372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77571C81DCB
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 18:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E56EC3A3B86
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 17:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6B5231A30;
	Mon, 24 Nov 2025 17:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0UmR+MY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E361F09AD
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 17:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764004639; cv=none; b=uHmwvaRdg0mzqnBf3g1yHtNKUAZU2NpayLtIkydQtUvo6RRQrGjykdL8R64vkfAAjguOOl1xy9Pb4R/Q2MxFrvIFfjzp1YSOKskoJCBALsbj7jxvPfl5c/oMTaQ6lqsbjMYQcxaCfmMDdhgmz269tmwUR8GpZaSaNrI9tkQCsz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764004639; c=relaxed/simple;
	bh=NiJTw1gYaeUS3I08K4GB011f8QShRwTdVxKu0FaCkb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hFuRqy678QegCoTYzM55tyT0tguN1ZryS3sloMcP3bfxLpwg+Nwn+N1XhF6T73HfQyKunhC4wuZ2DZyRq4WbnJagdDGjNLvvBVXj2mymS1zOxztwT/Dai6uoZ1xdBi/N4PRMB0AWi5yFwIvX34QK6r/YYiTUyR27y90cGnbPo4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0UmR+MY; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42b3377aaf2so2669512f8f.2
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 09:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764004635; x=1764609435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NiJTw1gYaeUS3I08K4GB011f8QShRwTdVxKu0FaCkb0=;
        b=P0UmR+MY8DNKxy3e62e6W5TJrJaTdtfeTOKLkMittHCS+dW8qgr7IS7y9kdEJUzrB9
         0q0ZnE0RBLLHdlVGyWbsE4qIiXwKlk51MrebWwdxm+ZXdPd14v9K9IpOeO0iqBNFkea+
         lf0BymAYD3SS3B3uZpis3AITLrvEVosN4pnxYPi1L+csHJ6O6EYAX1ewGUAnzb98O/kn
         3Kg7ydJO2mXUZT5UMB6v9OPUtQc7enaWEBQAlRpM0tTZwb6jU7WgOqG/B4EwjtsmH1+w
         NUyVNK/WRec1ox+OsGgReIIS9mOQ8XOdDTrs0pCBlXeSt1icIYZTMF7bspa/7b4vxI6C
         qxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764004635; x=1764609435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NiJTw1gYaeUS3I08K4GB011f8QShRwTdVxKu0FaCkb0=;
        b=eJqn2Hlog0j4LqtLhwCxbhXLfOqRSQEXpZyrC6wByPAMjRspbt1ovdqZYqfOXJ12zF
         9JUgMibTR4S0q6L1D33jbgqaUjCV4XBBdeFrAaUaYSgOcEWuDKwZnCIsPaVlbCYU+GqO
         H0H71y3XWUdiEJjHSMHTKCeFI0fI8P4VWDr8fS8SHDsnLB3mJvXNF0WzJnQPlAppL46+
         7KShgTF7TKBO7vfrulyV19DjnbLcXj8Yf11XsV4F4gPCiqmuPu8aOoIx0Z0lCOz/9GvM
         9T/k36FUWEmzAtLERj1Mp+RMhjfSkwy4R14+A/RMnTyLxr4mzgxmvhP3UC+tBXtnCrCz
         gDOg==
X-Forwarded-Encrypted: i=1; AJvYcCXcEfdHCbcG2LiPsfIGpNtbUDPlHxpZY2w88kh5Y5dkdknQfT8Uu1GieJn1W2Qyu0hncHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU+tNDpTXFJhHP3xjA54FPcgumFxxaBeMc5CqztvqjXqA+IFyP
	HGZGx3JJTCsbpOgCnQF+FMhQvTlwDgwL8Yim7LztqQYfYYsI6SVvJAVfcDMP3pd/vY15W//8B66
	9I94KZsfF7eX+eR/zfy7EbGSxBmoZf5JPUw==
X-Gm-Gg: ASbGnctHmSUPGKquIHHH0Yx96Dc4j6z7PrRWBCSKTBIbaiIDIAd/vHBImm1/eYTwCnb
	Lr8ditPzhrvgqh8TjCp73t/zn5U3DmFoWf4cZWoY3STAhpkQm4L6uyss2PZ9PIE8J4RLK7QzwbN
	1782+727Eh8dUjCnYiVAaJE0L2Xf7oXWwM/pNKHC5I5lbIzSvpX+FORJ4tjjXC6v0/akYbdiD6B
	34yf+PUyVTkbiTRTLDufcOjKyGwnQ5d1TD0WskuwETI0N6cN0qWsn+SEav0fOvBdZYEZa2z7gLY
	WweqJ1LpTXU=
X-Google-Smtp-Source: AGHT+IEMbEXQ8U7Ulr37Y82z4hXWobIVPrXbQeECu6nb6f3B/XG9O3+MlfUzREFk78hMdWDNhxcr9Z25Q8Oiv5NcQJA=
X-Received: by 2002:a05:6000:1a8f:b0:42b:5567:857b with SMTP id
 ffacd0b85a97d-42cc1d19e16mr12922761f8f.48.1764004634840; Mon, 24 Nov 2025
 09:17:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c9ac63d7-73be-49c5-a4ac-eb07f7521adb@hust.edu.cn>
In-Reply-To: <c9ac63d7-73be-49c5-a4ac-eb07f7521adb@hust.edu.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 24 Nov 2025 09:17:03 -0800
X-Gm-Features: AWmQ_bk4ltAt_rBPrW0dOnVnOUdPRAfe6xZKKwjn42QabQJe5BqR3Eext7V0Ggw
Message-ID: <CAADnVQ+DEuUXPetJtzzG0qH1bUNwr2B3hfTc4VAgYaRdAWj+cw@mail.gmail.com>
Subject: Re: GPF in bpf_get_local_storage due to missing cgroup storage check
 in tail calls
To: Yinhao Hu <dddddd@hust.edu.cn>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, dzm91@hust.edu.cn, 
	Kaiyan Mei <M202472210@hust.edu.cn>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	hust-os-kernel-patches@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 1:16=E2=80=AFAM Yinhao Hu <dddddd@hust.edu.cn> wrot=
e:
>
> Our fuzzer tool discovered a NULL pointer dereference in the
> `bpf_get_local_storage()` helper function. This issue can lead to a
> general protection fault when executing specific BPF program sequences
> involving tail calls and Cgroup Local Storage. The verification process
> for `BPF_MAP_TYPE_PROG_ARRAY` ensures that the Callee is compatible with
> the map, but it fails to strictly enforce that the Caller has allocated
> the necessary Cgroup Storage resources required by the Callee. If a
> Caller (which does not use Cgroup Storage) tail calls into a Callee
> (which does use `BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE`), the Callee runs
> in a context where the storage pointer is `NULL`. The
> `bpf_get_local_storage()` helper in the Callee attempts to dereference
> this `NULL` storage pointer, causing a crash.

Daniel,

did you fix this exact bug already?

