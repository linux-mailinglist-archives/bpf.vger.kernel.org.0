Return-Path: <bpf+bounces-71354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 347E6BEF6F0
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 08:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DD6C3A6426
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 06:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB782D47F4;
	Mon, 20 Oct 2025 06:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5f/6tzS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103181F5821
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 06:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760940797; cv=none; b=gAwEieUnm7s4H/QPxJ/fPCW3Q78REqpjaxVFLzSaKD2C2OB/L2u5Onu8LDdBRkY4X1g81lq04+ezXBgxbqT+bdw+D3SWTE3+PQTtkqzblaI4oricUVb7/2MgftWt+TjbqbGf9rCYCppSeXNgv4Akp4Jcg4BLZMlVXQFPDZw8zoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760940797; c=relaxed/simple;
	bh=F4iOUC0s4wVCK3QnRwNJNDquVt79I6hyvcqETtbjUq8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=phts4quhhremrAyQV1mI9aWMxDFWqAGiDkgrtrQbiBOdfPXN9/YZWGkS0X3yAIshxnsZMVzQ876HwftrNXSiaHRf5d/lYV434iPWbtBllbQK1x04v33sqNctrlfgdAnmEatZVTIJ0GFsYiBn+o4ZwyqwYwC9DPQiqzd132baPq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5f/6tzS; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7a213c3c3f5so5199210b3a.3
        for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 23:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760940794; x=1761545594; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F4iOUC0s4wVCK3QnRwNJNDquVt79I6hyvcqETtbjUq8=;
        b=N5f/6tzSIbyg6E60Xzwt0pdeTGKxdc5LVljrJ3zRtOgPslrr0ccdiLS/EnCttKAssP
         WaKgqXhqhDUoKqpVW9CKDbRzkm6wSMafVHmgnL/BOaVyKBabI7dsEFJbDvqV1gCcRw13
         iOaY4rMJOa4unz2STXjmdHwl+F9R7Pp+8IR7w9/0UYGeOBG13/ncxhfJKa+9KxG0Gjzk
         EnfCur4OmqW2xgDL41CAE83m78omTBx3DFUONVu3VnN4g4w3ZU+41cJwqzAUZBUlDV6U
         xY3mAIE/olMHHRkJ3iICFHOdMcttzK1q009nWR0scMUswc7q2rA33NYg9JKM63YJsM8Q
         y+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760940794; x=1761545594;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F4iOUC0s4wVCK3QnRwNJNDquVt79I6hyvcqETtbjUq8=;
        b=OgnvGBLwLlIhYwAsbeNB4zqFQ3V4cKvvmEkhHwTRQ8bMXzNt2cl2xNFl+RmX27kXih
         7Dgnv2R4+yGVf4s/sYQSfa0ZTJYEsvR9gW9j6vg2KwWthY3OQCzzIWjuknOXKOjc4Bsv
         E1REyE+sfGtGQcyeV6tgI4ZeIlQdjumoP32shGG/nj8mSE2HsDXb/kAdkH9RXurGSVLL
         +Q319LXDP0KPliZyox4T9IwfHRqiAfIkaR2tWeQ74TzbmwWVRs9sHAF179V/cyiHjz7r
         qw0k+IO5es6E2JzJ1HZbmMau0rg0U8I5t01SQLqkrkwYWTNCmaqVkR6BKzNDTmz1Hv6x
         Vo3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVcDmOu34/C97W3n0+YAxPcw0lWPI+YfIC55SdxJPVBqDbxyvnepskJqNIYzEFnqgkCtkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ/4FAFiM7LRU3Por6IC1GOOAvKgZXAUyE1TGPxsP8Olgh8ea6
	4hf5Wr2FdPsaGRsnkCiCmGS5eC5U5IWBKtKyDEryqm6OluJU3EjmzNA+
X-Gm-Gg: ASbGncsscv0HlULhQYii0CYxIcHO7RedjyTa2UVe2T333aWdFBAz4tqlilrTn6cz/dy
	6XljVtM1HXs0v/8wvYO3DcSGsQ0JwXQpg4nG5bVxW9kitgVzPJROvZQxV4+w8N3JtBrMANFUhO7
	rZhg4mW/e9ZYrGRf5q2S8bQAr/HjLDujIsLxo+DbYLVVcicZtJ4oZKehnd/MIYrXHPgyPxzgChd
	jS2hYOdh9YIR9vdr3n/b465Fes9BjP0xj5tJz6rHGa4+yLDFyQeP1PPXa46BVkKAS8cqUsrB6V2
	gULIfMqnFDLKaVVlboeIzyPX7wf6WJM399E120oFu0Whzsk++kD1jjbLbF5Jt+/b/04Py9lu46t
	FjrQJ3GTMFIrF1uTyJDlCtxTuzUAl/j+00ipyPiiHqr/6mXCKn9dLPVSIu/qJASDY5ACOHPJZKU
	s5ge3Olg==
X-Google-Smtp-Source: AGHT+IEVt0uPupSaUZz6KCq86JlbvGn8ZichEvFdkGuM5SiBJbGyCGKkO/2pPlvVbwplEmeRswBETQ==
X-Received: by 2002:a05:6a00:194b:b0:77f:50df:df36 with SMTP id d2e1a72fcca58-7a220d232femr16694859b3a.18.1760940793834;
        Sun, 19 Oct 2025 23:13:13 -0700 (PDT)
Received: from [192.168.1.12] ([223.185.41.141])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a230121ed6sm7216442b3a.73.2025.10.19.23.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 23:13:12 -0700 (PDT)
Message-ID: <a4fd6596e4a646d7c3a19b4a8f398b970f27e8db.camel@gmail.com>
Subject: Re: [PATCH bpf 1/1] bpf: liveness: Handle ERR_PTR from
 get_outer_instance() in propagate_to_outer_instance()
From: Shardul Bankar <shardulsb08@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Date: Mon, 20 Oct 2025 11:43:08 +0530
In-Reply-To: <69d2c22ed0cac19a2fc13d422597d781281e4625.camel@gmail.com>
References: <20251016101343.325924-1-shardulsb08@gmail.com>
	 <20251016101343.325924-2-shardulsb08@gmail.com>
	 <69d2c22ed0cac19a2fc13d422597d781281e4625.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-16 at 10:43 -0700, Eduard Zingerman wrote:
> We can land this change to avoid confusion, but the fixes tag is
> unnecessary.
>=20
> [1]
> https://lore.kernel.org/bpf/8430f47f73d8d55a698e85341ece81955355c1fd.came=
l@gmail.com/
>=20
Thanks, Eduard, for the clarification and reference.

That makes sense =E2=80=94 since update_instance() guarantees the outer
instance=E2=80=99s existence, this case wouldn=E2=80=99t be hit in normal e=
xecution.

I agree, the Fixes: tag can be dropped. The check mainly serves to make
the intent explicit and avoid future confusion.

I=E2=80=99ve resent the patch without the Fixes: tag.
Link:
https://lore.kernel.org/all/20251020060712.4155702-1-shardulsb08@gmail.com/

Thanks again,
Shardul

