Return-Path: <bpf+bounces-46498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F179EAE18
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 11:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91FCD16534A
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 10:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D54118A6B2;
	Tue, 10 Dec 2024 10:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKY2mXmH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3D219DF61
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 10:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733826952; cv=none; b=u6Gn4/aZoEEGT+mpOiHoY/rDDzNH+zOk0txwkoNB+utv4M4tr4vn78Lm70w4SzlCXvKAPKar+LpPx9c91mOowIDUU9nFd1UonYjbzTQ3/bMdxi6VJAHGeJxGJmxVKHTqnoEgcPjVMxzZ0+1XeGw03UmCb0cBPEeMpGnsIrLGtMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733826952; c=relaxed/simple;
	bh=17ap1QfZUpdnzCgJ5mnaoV9ja9I2Gz5CSMfiEXTLzc4=;
	h=From:Content-Type:Mime-Version:Subject:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=DSXKGR34NaD5I9NCK3KPIFITZ0bnWQI+yO4uhzkNPXewkEtgAZR220e43yE6K6RZDnM/Z1fAGQkyWqhmNwh4avKhS2eCrniOD5APdvXNtl/SAMFr8I/IqPsnEQ9T5nlXB4a0GykwLLUifFhjoiPMs652xZXLkcvbFXaAaIgdMZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKY2mXmH; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385d7f19f20so2447567f8f.1
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 02:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733826948; x=1734431748; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:subject:mime-version:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QTYL2wv4R8ZDI2rUAXoGUfUvnxaGnytpuwRUNsusbg=;
        b=GKY2mXmHfCMMUWD+5N2qA0Dp1D7IMmXBEbjr9VeH/Y0jEVz6rJ9HtKxtYcjFW5M122
         9yUFit4JXOGg8v0nc3hhh7vAQl0jktgy+bUs7j2z/5Ony6gJxbONKTiik8cAWJA+AD43
         gnIotBe8GM4c9oXd15ruWZz1he9RlUidjg2zcbSjNXBemxiXbC7KG1oeRdAYvjjDfGCL
         3LSHQomSTr1dkCLDAev97yEgt7VJFpOfOBqKKTXEsC5aD/oT4jGOWv87s59+pbfhrj1b
         kopT4KdZEd4QBJrfZpCK/P1zxhTI0NnbSJo9RjsOwVJF6xP95+GiT9AOn0Zx8lrv1nag
         BMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733826948; x=1734431748;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:subject:mime-version:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7QTYL2wv4R8ZDI2rUAXoGUfUvnxaGnytpuwRUNsusbg=;
        b=tDNPDDv7VbovwwmWiBEt/jXR6kW9hjwZqsvaw9KAmGnYPLzQGrLbIeWss4/jBiS5In
         BYmJzRTC+ifYdgLZaxc5Bjfb6lEhiExZ3kGHkcDtIQvp9a3hOaZ2XN29Sm87Ing7BV1t
         PU0J6ICI8ApqNw1RAmiEN0/6qkTdbNOAxIML94kWarrJjO6FT7e6pxW/4Wwp4XGjWCqB
         PJLt1eFlAWgG4SCx4ctGGYMl1OYB2lL9E6G3QKyQ+vxyAPh9UOHby6psEnYIrTyvI2kv
         YOSf6o9VeW2Xnk9ubDuAwgES+VIHYOjx/NwXP4JpY5vIUU1oM1V69vds7vLM8Tpk4ydS
         lsiw==
X-Gm-Message-State: AOJu0Ywwp5NmxXk8UNjTnZvZd3TeWZiGgzFRSaGyDaTFBuMXMmeLZgu/
	DuJZLWGH7WmGRWcVi1WCdB5RwoPzMzuQyZXh6TfzE9Jg8+UYBq6p
X-Gm-Gg: ASbGnctxIXQoGNF21W+pFgF9rr6oOoOeX2ERFlzOi59Nvyf8KXiU7+Z/WtuLsnP9CYF
	0zIJFn1L1dBczStDfy3PRSXGzi00PrLxedYbUYbP8VPox+BRpBC6d5sl2F+XhfHWUKl6eP6bThd
	wlnh9SIkUND9oE4OxDMe9VgoXKKjIkZSi34DkFosmgLZAHEMhOPBq1PURtBYvZqDJeHeRTBHeJ+
	we/0RYHlrCsVvcuTt/GXT3xbXX7iAnpNnhmPIhmqcbpwpOkM8zySYpcunWkpyhbE/o=
X-Google-Smtp-Source: AGHT+IGGc8Goztc69EkJK3/uD88tWJDNQPiZAPayXOrxrp4TOFhARsB5MjXHyTilADYS6eWTSN/w7g==
X-Received: by 2002:a5d:5f54:0:b0:386:39ae:e803 with SMTP id ffacd0b85a97d-38639aeeac2mr6241481f8f.54.1733826948382;
        Tue, 10 Dec 2024 02:35:48 -0800 (PST)
Received: from smtpclient.apple ([209.38.224.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f3d89b75sm87058725e9.15.2024.12.10.02.35.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2024 02:35:47 -0800 (PST)
From: Nick Zavaritsky <mejedi@gmail.com>
X-Google-Original-From: Nick Zavaritsky <MeJedi@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH bpf v2 7/8] bpf: consider that tail calls invalidate
 packet pointers
In-Reply-To: <20241210041100.1898468-8-eddyz87@gmail.com>
Date: Tue, 10 Dec 2024 11:35:35 +0100
Cc: bpf@vger.kernel.org,
 ast@kernel.org,
 andrii@kernel.org,
 daniel@iogearbox.net,
 martin.lau@linux.dev,
 kernel-team@fb.com,
 yonghong.song@linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <EC7AA65F-13D1-4CA2-A575-44DA02332A4E@gmail.com>
References: <20241210041100.1898468-1-eddyz87@gmail.com>
 <20241210041100.1898468-8-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
X-Mailer: Apple Mail (2.3826.200.121)


> Tail-called programs could execute any of the helpers that invalidate
> packet pointers. Hence, conservatively assume that each tail call
> invalidates packet pointers.

Tail calls look like a clear limitation of "auto-infer packet
invalidation effect" approach. Correct solution requires propagating
effects in the dynamic callee-caller graph, unlikely to ever happen.

I'm curious if assuming that every call to a global sub program
invalidates packet pointers might be an option. Does it break too many
programs in the wild?

=46rom an end-user perspective, the presented solution makes debugging
verifier errors harder. An error message doesn't tell which call
invalidated pointers. Whether verifier considers a particular sub
program as pointer-invalidating is not revealed. I foresee exciting
debugging sessions.

It probably doesn't matter, but I don't like bpf_xdp_adjust_meta(xdp, 0)
hack to mark a program as pointer-invalidating either.

I would've preferred a simple static rule "calls to global sub programs
invalidate packet pointers" with an optional decl tag to mark a sub
program as non-invalidating, in line with "arg:nonnull".

> Making the change in bpf_helper_changes_pkt_data() automatically makes
> use of check_cfg() logic that computes 'changes_pkt_data' effect for
> global sub-programs, such that the following program could be
> rejected:
>=20
>    int tail_call(struct __sk_buff *sk)
>    {
>     bpf_tail_call_static(sk, &jmp_table, 0);
>     return 0;
>    }
>=20
>    SEC("tc")
>    int not_safe(struct __sk_buff *sk)
>    {
>     int *p =3D (void *)(long)sk->data;
>     ... make p valid ...
>     tail_call(sk);
>     *p =3D 42; /* this is unsafe */
>     ...
>    }
>=20
> The tc_bpf2bpf.c:subprog_tc() needs change: mark it as a function that
> can invalidate packet pointers. Otherwise, it can't be freplaced with
> tailcall_freplace.c:entry_freplace() that does a tail call.
>=20
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
> net/core/filter.c                              | 2 ++
> tools/testing/selftests/bpf/progs/tc_bpf2bpf.c | 2 ++
> 2 files changed, 4 insertions(+)
>=20
> diff --git a/net/core/filter.c b/net/core/filter.c
> index efb75eed2e35..21131ec25f24 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -7924,6 +7924,8 @@ bool bpf_helper_changes_pkt_data(enum =
bpf_func_id func_id)
> case BPF_FUNC_xdp_adjust_head:
> case BPF_FUNC_xdp_adjust_meta:
> case BPF_FUNC_xdp_adjust_tail:
> + /* tail-called program could call any of the above */
> + case BPF_FUNC_tail_call:
> return true;
> default:
> return false;
> diff --git a/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c =
b/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
> index d1a57f7d09bd..fe6249d99b31 100644
> --- a/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
> +++ b/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
> @@ -11,6 +11,8 @@ int subprog_tc(struct __sk_buff *skb)
>=20
> __sink(skb);
> __sink(ret);
> + /* let verifier know that 'subprog_tc' can change pointers to =
skb->data */
> + bpf_skb_change_proto(skb, 0, 0);
> return ret;
> }
>=20
> --=20
> 2.47.0
>=20


