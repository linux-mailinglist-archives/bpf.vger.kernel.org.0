Return-Path: <bpf+bounces-38343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0341A963841
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 04:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36FC31C21A0F
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 02:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF74738F9C;
	Thu, 29 Aug 2024 02:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5YB9x24"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29FE45C14;
	Thu, 29 Aug 2024 02:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724899020; cv=none; b=QkqKCCFfhfXsp6OFSFM7NDNf8NqNBHfXKnvao7XfS53qhKDNmHZIILSpvWio7Ovlv2KIqNGwXf5pQOnqYDJ2J2BOoeEWP7VGfB+23i6Vf8HzTJSQhqLrthQrKjkWotgkvvC+W1mVWG49822OA5L45JhVjlb2o4uxLy0/FRMK094=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724899020; c=relaxed/simple;
	bh=zNhbhhtSlW71mQBXYmZRTgqiTPzM0YjHM/2Ghygurbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IuXpVBbUoxNz8wXxl4ayMwQjKavjAefX3LCmmbD9x+y3fHkwbmNS9SlV/YXHW9hv5kYDPkIVxPAHE9+WK0Dg4n/oF89Wi+IvM75mWUbPxu6C/7KjdqXRPQILwGQmZpPuB/N4QY4Ru9dw3KBkzXI4Veol18Tbw+v5k9qA4wgJ2eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5YB9x24; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-428243f928fso1672235e9.0;
        Wed, 28 Aug 2024 19:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724899016; x=1725503816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydxlbftRlYhGdyIyUrGWY0/kw5NQzjaWZN4vvnPbzJE=;
        b=h5YB9x24kRUx00U/ow9Lq593GDBfD/q38P+qR/splsmTYaQltia57cgRIp7eV74hkE
         eTP720lre22v9F0pQCFtkfwVoACgvYQYZ+zA4a2kGPQTsFtcCaveQl4gVHkzYq17H6Dc
         EIepDzRMvBEOSq5H3++QmbqwmSJxaNwCKq3cBh9QAty8LA29AWYouAfLkbnV1B8pBCza
         G0cq2WsUyUjZHZ3PJhbdQdBNos2GCZwFU58xhMlJuQX3qNVC/DRhezNGUnW6thc94dU/
         cYLiq8SbTUrOT58fLgEDUUu9IDY13w8QQrN6XEkHQ9oxsHoAUQORVaKgHVR+PZgC4Xus
         c/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724899016; x=1725503816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydxlbftRlYhGdyIyUrGWY0/kw5NQzjaWZN4vvnPbzJE=;
        b=BnoAF3s33cW07ydWaFBfNksWD6sBOSlI2UnZ9E0XlUBeIYZg8+gKsZwmCRIyDp1NDe
         VlRMIPVVSIt3+tbFfRMdpFTajo5Q0oDB3nOKrEnT9y0oSWs1eyiQRK0LyJFC4kfj/GVh
         qlKBlvC77y88GTkS5VMk6o2Anxqew/50uk9mkw7fNmlyaIcrwvYiwPiA8hIog+GCcDQu
         dvvQMQ0zTeToNU4wcE3RB5vUUeLEwaIMR33raA6nI4LguTNMY8NHM3E92E5sRAo9xauG
         8PbjfJBp01B45yotgbPFBAgHdU8hqEYcxeujxNtpOPizVw1ZXm0U0Fzugrejn9GCVsSO
         mQ4g==
X-Forwarded-Encrypted: i=1; AJvYcCXfehEilVkMPsmXcCX1XQEDOT86x7r3KfQbUikDgwbDmmiEO2t+RxNCQOAQPnaOJ/J2LZnoxn4K4LgPde3g@vger.kernel.org, AJvYcCXvfl3d4do7C0l/w26Bw67jlLYNiEmZvWTPPUcamKD1AUCqkkmeNFtUGlu5L3xo5pqzPg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmmPf6QDGjdeWdllzdlyimec/C9s0aN8h5+4mxs2gF5JoQAm/L
	+Rft4rDFJmd7H1lbUjmXBDDkjFaKVdHE03pw7yfQ4JBRqqs+UqxOm1j+nQrvlvhBc5Z/o7E6g7Z
	pelhP8D2fJYlbW4d/oRPvv8Q8kFo=
X-Google-Smtp-Source: AGHT+IEKmNFgPadm+GD5ADp/r7IIPFhI0bXF0vcczhLXSEUXYeisipuzrzrOLou8rrTnVboGoFXMWf92djkqqvT/ljo=
X-Received: by 2002:a05:600c:3b8e:b0:428:d31:ef25 with SMTP id
 5b1f17b1804b1-42bb01b91dbmr12580435e9.12.1724899015917; Wed, 28 Aug 2024
 19:36:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823104310.4076479-1-aha310510@gmail.com>
In-Reply-To: <20240823104310.4076479-1-aha310510@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 28 Aug 2024 19:36:44 -0700
Message-ID: <CAADnVQKsZ9zboc4k0mnrwcUv6ioSQ6aBXXC+t+-233n17Vdw-A@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: add check for invalid name in btf_name_valid_section()
To: Jeongjun Park <aha310510@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 3:43=E2=80=AFAM Jeongjun Park <aha310510@gmail.com>=
 wrote:
>
> If the length of the name string is 1 and the value of name[0] is NULL
> byte, an OOB vulnerability occurs in btf_name_valid_section() and the
> return value is true, so the invalid name passes the check.
>
> To solve this, you need to check if the first position is NULL byte.
>
> Fixes: bd70a8fb7ca4 ("bpf: Allow all printable characters in BTF DATASEC =
names")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
>  kernel/bpf/btf.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 520f49f422fe..5c24ea1a65a4 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -823,6 +823,9 @@ static bool btf_name_valid_section(const struct btf *=
btf, u32 offset)
>         const char *src =3D btf_str_by_offset(btf, offset);
>         const char *src_limit;
>
> +       if (!*src)
> +               return false;
> +

We've talked about it. Quote:
"Pls add a selftest that demonstrates the issue
and produce a patch to fix just that."

length =3D=3D 1 and name[0] =3D 0 is a hypothesis.
Demonstrate that such a scenario is possible then this patch will be
worth applying.

pw-bot: cr

