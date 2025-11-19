Return-Path: <bpf+bounces-75016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F73C6C210
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 01:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6680B362C69
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 00:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752EA1F4CBC;
	Wed, 19 Nov 2025 00:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezNCD/gU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6BA1EF092
	for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 00:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763512122; cv=none; b=qvVpbswHBdy3PWJw4KRyGKIsC5z26fuRjse7UKJoTZiqi79Fpk7FnUvtz419IHG5gi6zZ2yd8aPTr1vTbkGd55nyRsbwlZ259zk9LGdwptJZkCO/ZMDy5lLjkVU+GC1omJPpb11cYLB7d6t4b0+5GvmOvfrlt1ZUPwRr4oi5PJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763512122; c=relaxed/simple;
	bh=NJnfUWnY5NDX6X9yU9/E+VI1sDN/7wt8IydZzwtVu3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CS9o6UQWKrF2BABgPA88Kz+I6wOqRa4OkIg/XzAQNfuJ3l0r37TnoP2WOShHENZmB6uzsUz6NKAEvBlL5aM0Kg89XYVFL1EqwushAY8qiBBqsFxLKnXuvGXXD8e28o3nhlFT9TMdOcphP4cW9SnH8GOu0W1TaqYLb6LOkjT+fGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezNCD/gU; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42b3108f41fso3755822f8f.3
        for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 16:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763512119; x=1764116919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJnfUWnY5NDX6X9yU9/E+VI1sDN/7wt8IydZzwtVu3s=;
        b=ezNCD/gUC2spltJ57Bc+E9bSwOTkhcaA6tTueGWUJqSFK+VJMDUW2dWZSrKN/YlNZ5
         tUfKAzKaSXtMnP+KZseO06tPJoPXS/YlrTEmpmLIdCTgmOVoju19bopeQOWP+xbutnlp
         zWrCLeMEJvRbLDALN7oJhkLyv4HdEo+gCAPX7WZgxO00hypRU+lSV+TYbD1FAlOr2goN
         JLV2+kjEz/SysFfK0cID+NKMjB9mpboJ3WYX/2XLY1Hz9XHjq9M5drU4VuDmBM341N7z
         yWCkCDRFIJMRxG2vw3NZjK71LiU4zSdLPAxJ1pg51adWSc/5L+eGewChWFQwX5lxXOOx
         bIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763512119; x=1764116919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NJnfUWnY5NDX6X9yU9/E+VI1sDN/7wt8IydZzwtVu3s=;
        b=JGtF/ybUZofC3oSaVt7yeboMyvhrSk/R8/2fqHkz+93WS/704SXGexvWmc+ZqmZuPG
         Fn7sykIb+idkU9PIUYEoOjBe50X3UE4HX37sbjdw77mV3jN44uHZRYuxEYVlBS4arpjS
         dy4QTiCWat+DoyeTupOt99kF5AywNp3h+K+uEWYcbMQLhHSMtJy/YI85PQhtyi9UVxBF
         4FVz2YuiCNsckX++n5ywELcGPOkdbzgGmZef/g6gj4zf5P8PptcIHs6Xs1Wiy2wcNz7D
         qfzWYHKo3sP4RQ+4dAM8me5dvL7kH0ZCWmPa0X4heXv7rmqw2DJCpuRfK69/dPHSRa52
         rEcA==
X-Forwarded-Encrypted: i=1; AJvYcCVx40pz7OjrjY9Ti11r1ys33cxF6i6Cr3i1ERN8VwAl23LN4gNeeXaX2bAYDy0ibMuwMFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbMx0Yp4eipULxfOm+nmQm57hl6r9n1NsNXYfeLlZMYsB3KiwD
	UxiWnW/tEruSg1gHiuY2lmxnqDV+xg1E1noIwCwpFiTiWzH296QMAEMwKFgE404JB6sTnPIsy48
	/y4x0XM+5A7YGzY8fmp06intz42rYtfE=
X-Gm-Gg: ASbGnctDXLuRJs2o3ej50zPu4mM2ZKOzcyrEnNd947PainJSREZ/epZlEGQL77gDxWR
	sDzSZrZXs9rjOUstHwzmHy1gI2/BWn7Awa5PgiN55RFECUB5DL7cZC+eVDxR8Y1oMDo4kfhNHAZ
	HsqhKoG7lvdGQdAsk7qwLW5x0Xxtgx5ZjlcDTICeI5ac0WPCajdSWEpJ0SmIGqttnZiGXeRAy4x
	aVlTMiHUpb0NmEF+tQwgU2dWweXNkQ3jLDpTO+EOsj/yx3d6trbYV7W6BVO/VEqrYwl7Y4JaIOM
	sX0xrxWQUx0=
X-Google-Smtp-Source: AGHT+IE+7v5U5qPSQsuyK0qJPxKYCeoXmJh73/zJxk9L1skLVtv/ZQhS7MGenNDtVvfmUkOeAtq6OoIFg1ghzGih+UY=
X-Received: by 2002:a05:6000:1846:b0:42b:41dc:1b5f with SMTP id
 ffacd0b85a97d-42b593742b1mr15717740f8f.32.1763512118638; Tue, 18 Nov 2025
 16:28:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118123639.688444-1-dongml2@chinatelecom.cn>
In-Reply-To: <20251118123639.688444-1-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 18 Nov 2025 16:28:27 -0800
X-Gm-Features: AWmQ_blZW4T58g1lw-VuDswVQ34aw1FRr8D1Zp23NABA3RPJtCBLTMXkxs5M2qY
Message-ID: <CAADnVQJF5qkT8J=VJW00pPX7=hVdwn2545BzZPEi=mPwFouThw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/6] bpf trampoline support "jmp" mode
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, jiang.biao@linux.dev, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 4:36=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> As we can see above, the performance of fexit increase from 80.544M/s to
> 136.540M/s, and the "fmodret" increase from 78.301M/s to 159.248M/s.

Nice! Now we're talking.

I think arm64 CPUs have a similar RSB-like return address predictor.
Do we need to do something similar there?
The question is not targeted to you, Menglong,
just wondering.

