Return-Path: <bpf+bounces-50268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DBAA247B0
	for <lists+bpf@lfdr.de>; Sat,  1 Feb 2025 09:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58F98167176
	for <lists+bpf@lfdr.de>; Sat,  1 Feb 2025 08:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA2614A4D1;
	Sat,  1 Feb 2025 08:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oa4+seCr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0319149C57;
	Sat,  1 Feb 2025 08:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738397742; cv=none; b=phayTH0DrYOukG8Kq1YT6RglmhK83pMvGFw/yS2uNA+iVqEGNUuZW2lJs/TwRxcb5kndSS3op9oIxDJKbGStNKUHKpAgG2MfBQ7z+tnbUriGM4P3Lq4kI0fC9WFu+hsxewe37LBX3t6Nmq3RTQENgNFO3t7LBAe8dc+goYDv8/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738397742; c=relaxed/simple;
	bh=i/UKZutn6swLO6T+7m1NRVbB5zgHsaR9/yUAoStwAqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H0Jlnn9pKdosPL3HmMjUoINVO4d66I2wFCr1v5NqWs7jLIpQim1ylj/nJjkfLM3rxpVrHszd/Kfw2TxV2lb9XAF7lGJ7/gwdjhlL4EEO6k8iIhTROdfKg6xjzTpzP/IXT38OcFUxX0UZWMIWb2lNWkjwgxHxNIEnFS5baPBhGcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oa4+seCr; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-436326dcb1cso18767885e9.0;
        Sat, 01 Feb 2025 00:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738397739; x=1739002539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzuvjtPlxSypKZH+46lcLYIj34ts/vuBf9VjJ6yn76U=;
        b=Oa4+seCrlSNWV+WqnJTpoy3h8AXlLMiWxE7u8YEj4jj+w/xkI5OJWLpAPpdihQyBFd
         KdvHHXP7lVdqnGO7wYMJOcq29+sWNQDBZTQ0FtGAdCw8dH7if9xXgVxPQYH5BHD2TwPP
         ybNSEFkXfPGtxfypyl06ptLMrj4iXK6bOl9HFpdLETPG0hEh2ZvAj3WH3ez0MSer+8gg
         MrN/qfZ5V0bmv5mnv+MZcD6sxyv29F1fvTlXK4BF8kF503KuMpnSC6frb/U2rQq/Ae2l
         jbBXtsg2+F5v6N7yHx6H8WTxGjvgaZtxmNCBs991X8hf/xhmsPss1U5IColG3Kkult6b
         VOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738397739; x=1739002539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzuvjtPlxSypKZH+46lcLYIj34ts/vuBf9VjJ6yn76U=;
        b=H1wnzxczWbqWTPii+kzTrkTHcMB+w95RlONeXNqe3aFRXhONfBKdR5fNYvsRFIrN6q
         eFL6G3TL+1D5LoVt54N1Rm57/l6tuMNUe35GsEaoFtCgWIFgG0oROquBpmDxW51VwDbY
         ti5cz0FAXxtcbaK8i15LNCgg4+LfKrYFQgMUgzXCWR+h54DbZT/JL8wYNJn/Z9dC5Bf7
         sKvHYxkObIRXLCWVujahSp3Od1gmq+GCucaz9dX3UH/paVqYmr1ZHRcRP5XKBTYOoseg
         9OpKPHkwLxYkAPXG6Gu4ZiBoKcGgnX9xZA473WYeBU9D5sVtLy/RXkQOskjFkW4VTdsz
         bxOg==
X-Forwarded-Encrypted: i=1; AJvYcCVsFCuN6AZ5bQGONptkzhjpqaeGg2VW+rxbws+A55byqF3nmoFyyBgEwanWqAw1LAh/ZEosCi7J@vger.kernel.org, AJvYcCXwuA9l2MTQQoCTEirXk5tqLmqXQRx4+GuZhs1TdD+DgjoNNqhbDWysKpOLH+VHK6N/Y7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSAAdD0fWzRHMcHXlgSiYbPzoMhzYxShzkUciuJTz7pUhb2SXa
	QFHBfg3XXgokKQbMYn26iCBukweC//5DH51/IDhL/cvd3ABjm7fuSGaN90oPYWo6aC86Ew6I5lS
	VLdlRJ9HEb9n7/3rC5Ziwk8P7ZXA=
X-Gm-Gg: ASbGncurU6r5b0goxh8kDex0L4yQCRFvLKQZB5pBWwSfzcAXPPZqMvVx2R8zVq7UxrZ
	c1GcBtU5v5cvTTE/HnBR/Bg+HkSlZyxpDv7/J/RJl3SYHUixz9iqbPtriYg2VlpB6BGax1Ca8
X-Google-Smtp-Source: AGHT+IHxJWivt5tYeDP2eRhpRjdpgi4YdrK1c7lbEdBBxitp8p2LLkLcoMY10L6/v+sKzBDf48X/Ev7G3/CzBnSv3cM=
X-Received: by 2002:a05:600c:3d19:b0:431:6083:cd38 with SMTP id
 5b1f17b1804b1-438dc3a81ccmr120258605e9.6.1738397738822; Sat, 01 Feb 2025
 00:15:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250201030142.62703-1-kuniyu@amazon.com> <Z53Xv-okoj3PDT50@krava>
In-Reply-To: <Z53Xv-okoj3PDT50@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 1 Feb 2025 09:15:28 +0100
X-Gm-Features: AWEUYZkPw6SAzu_srVQX6PuTuYFTFRwvWbTLqJ_w_BetC0FHClHI2RbQApjy41Q
Message-ID: <CAADnVQJodt1fBaR5d0wTR2pwipJVVdKSd+7_ou_vE-gRMzbT6w@mail.gmail.com>
Subject: Re: [PATCH v2 bpf] net: Add rx_skb of kfree_skb to raw_tp_null_args[].
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Yan Zhai <yan@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 1, 2025 at 9:13=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> > v2:
> >   * Add kfree_skb to raw_tp_null_args[] instead of annotating
> >     rx_skb with __nullable
>
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Jiri, Kumar,
how come that we missed it earlier?
Is this a new change in the tracepoint?

