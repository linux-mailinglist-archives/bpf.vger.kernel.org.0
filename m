Return-Path: <bpf+bounces-50419-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E53E8A27696
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 16:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2F343A41BA
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 15:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA23A21518E;
	Tue,  4 Feb 2025 15:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtWWdq/C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899C521422A;
	Tue,  4 Feb 2025 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738684585; cv=none; b=bTEkXV+cwEq6Rb1PeMPuRn2DoDWm4SAK9OulbnPFxWIbVI49qoRu8ax+3N/8z1/3rL+A9RV9ke2OB1nCCtClKV/OGNQRlu+gOqZEexKk7IhkQxpavBvUDxcAKMyGTh0wL1kR560Bi+QSGkSlVxrJ8ad7bZeOl2KSRxGKka9Xbpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738684585; c=relaxed/simple;
	bh=ZRZGMcls0L0IUxLjtGWCAK6sueHWf782aRTQf9r6r/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a0qrVNjbcgSPFTomu/QYkJxCYEvnj7xDvJ2bhhXCQ4whF94HSF+Jy3EmQ27s0MXIPI5Kqn7r2msdq5QMkgEahs5YV2P/j2lHP4wMMZZQAFIZjLk/BaWTWpuQ/2OJfjaOSNpvFbDbwAm4NCGj8mcKwF2KKlNvg+T/e3V5r/T+L9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jtWWdq/C; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385f06d0c8eso3164225f8f.0;
        Tue, 04 Feb 2025 07:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738684582; x=1739289382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRZGMcls0L0IUxLjtGWCAK6sueHWf782aRTQf9r6r/A=;
        b=jtWWdq/C8UZKECux9w3ccw2MdPtsthDGmtcNwTx54Y5N9aJEkTHVZB0KSYMANA0uj4
         WC174oGVPCaB484b7dhFDGReros6BXWdXZfKCyP0yZQgazfWYdtcVfXmi74TTIpOPE5C
         CNAwq/hYDxd2enYZ6dqTdUJG5aCLQibC4tYViapYrdMiv7GC7r04dGv/W11Q+PAgKCB+
         wXPZOjSWSOVaHizTh7HupuyWeWKQtDvo65sIBUHY+PwpgPV4BG46/nAgMveLyBbQDg/E
         qaRNe+a68xFbqIf5LyoL620VVDprkl/j322jJLXrOQHvL9CGz00niCG6uhmz6p7/9vaP
         PM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738684582; x=1739289382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZRZGMcls0L0IUxLjtGWCAK6sueHWf782aRTQf9r6r/A=;
        b=rs5BBMRyjSGn/P7uwxRE8HdN87CUsz1R1RETE0krkAb2274NJE31sH4sJO+Z3TJeGc
         6bAGiftHmh1tEU1RxPEXJLpg5NJHEu/SIlZ5Vq8lNkagR+39MO5A6aN3F3jD1+l2hMNE
         8rJqIwlDP/QLT2/N3rxc3gFI9Z40YHfKxbXhjZZzzroBAoH2y6VuZrxKB4rnAkOApSWd
         Q8cVbbht10D1RvzaAh8/5Oiakxpt57nLmdF5ZboeVEk0xrXuFnfHUd1cu2QKW0OpLV4W
         hQ3I7sPe6unlCA0GN8Bg3mn5wX49qrXteCWYiaxG/121GkGedtKTJpk2OKqWEZQzghmL
         PFLw==
X-Forwarded-Encrypted: i=1; AJvYcCX5yu0G/kaUQyZZPKLDiohQE0wC1lY16Pyh8Vv82eBNUVxXR9KYr+lg11hQl0qOHSzOEmIZreYu@vger.kernel.org, AJvYcCXhqn+igVo5LbhL4HTRcJ1c89EVEU2/UiRx0ya57CpkFA+FlvJMEegjwOpwF2iJleJsngE=@vger.kernel.org
X-Gm-Message-State: AOJu0YycjVdixNyTrhPhk2NqNnl8OsdIBsIQoSZsHhCQhkbOEFkCyqVr
	pr4Ch7WM9x0aR3G+gn6FLDl1+YjfImcW8uJQyu7gWHX8Bp2mOVBH8m+D7V9M3BEXrhJW9vTxMFP
	DXOHTinC5mtvHtR/qHkOyqXRWrCs=
X-Gm-Gg: ASbGncv0YxrVCXiEG1Fcjo2YKUUQSGsMaPL3xTbsGFtWwKvLDikcWrHMY6w32vR0g+K
	zhzsCJPDZ7mRiml/k+ZkwmqLfo47YG1ln487CR5haOKnzdkSCwywhmXIrqx8eAvtIg7dfc+mAy1
	6WK004xmtuP5nj
X-Google-Smtp-Source: AGHT+IE+nh1GBf5QXxdXSLzn2q9Z/hIEJiXX+A7plmiyVJIO65pdIKeG8KZ9NiD5EeM8+UWjnOIimeYEYhCw9LMmf+Y=
X-Received: by 2002:a05:6000:1faa:b0:385:e38f:8cc with SMTP id
 ffacd0b85a97d-38c520a32ccmr24464323f8f.38.1738684581584; Tue, 04 Feb 2025
 07:56:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1738665783.git.petrm@nvidia.com>
In-Reply-To: <cover.1738665783.git.petrm@nvidia.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 4 Feb 2025 15:56:10 +0000
X-Gm-Features: AWEUYZmTgIT-vAB_mwBtSuKt_flosroFj04cBVtAAKyb2KTj1TuddYvphOQgRbM
Message-ID: <CAADnVQKMN4+Zg9ZG4FpH9pJw4KdmwWmT2d4BiJgHUUQ-Hd7OkQ@mail.gmail.com>
Subject: Re: [PATCH net-next 00/12] mlxsw: Preparations for XDP support
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Network Development <netdev@vger.kernel.org>, Amit Cohen <amcohen@nvidia.com>, 
	Ido Schimmel <idosch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, bpf <bpf@vger.kernel.org>, mlxsw@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 11:06=E2=80=AFAM Petr Machata <petrm@nvidia.com> wro=
te:
>
> Amit Cohen writes:
>
> A future patch set will add support for XDP in mlxsw driver. This set add=
s
> some preparations.

Why?
What is the goal here?
My understanding is that mlxsw is a hw switch and skb-s are used to
implement tap functionality for few listeners.
The volume of such packets is supposed to be small.
Even if XDP is added there is a huge mismatch in packet rates.
Hence the question. Why bother?

