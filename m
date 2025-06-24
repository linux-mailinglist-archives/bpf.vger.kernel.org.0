Return-Path: <bpf+bounces-61448-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A48AE71F2
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 00:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B40E11BC34A3
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 22:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400AC25B315;
	Tue, 24 Jun 2025 21:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYuerSa0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1193925B309;
	Tue, 24 Jun 2025 21:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750802385; cv=none; b=M7CRnEfQrxIeLpv7oKrdL7YSEd7L8i4K9k167iTLbp9uWCYXGHX2ttxW18NUzGcgVwchvYcaC2LdHRntU+O+8d31Ix+krGt5U+cBTIs9oQ0jL0Jm3uqktjuMgNDCzKvWHfKJyLi7iGxjPm3Qto/wPbIyX7WgF3lhYYybT5zfTfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750802385; c=relaxed/simple;
	bh=xQqzpTIDZ+9bBUiOMwcKW1NeUJfD6BfeoVDwwp+XN2A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BTK9L5M0K3CkGxLCgZkDNxj6f5EqpWS59DrZ277PiQmAH1cTEfXuyytIt0N3Y/PKzZZF78g6yJJ1gEG9g9q/YFnht6gUr9uZSUmnU97OjzLDTJgSQWEKBi38CLXOO9lshD8ESNTw7VLcYcmn35J7ej4gX97nMVLrw2kpUfxIUVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYuerSa0; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2353a2bc210so52833095ad.2;
        Tue, 24 Jun 2025 14:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750802383; x=1751407183; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xQqzpTIDZ+9bBUiOMwcKW1NeUJfD6BfeoVDwwp+XN2A=;
        b=YYuerSa0/pm+f1yz2lIY48U0Ie0L3JCuU8BAsrhPKl5Nn92plgc2qhNAHgE21sXmcj
         PHUm0wdnvABJ7jj59A04nEC6KagZAzfa04F3P0WIUtP1bIeMrzSAHtKrOJdM4y6QIrFa
         VVUjS/s+6N/jKOC1vtc/sTuM4oSY/eKxImRV2Kt3yxTT7ZqOSHENyXam/UqLaFpqAGzr
         7g4zt/OFBETVutE4KkpWHJAjkLIicSilOCIyopjWs258TbIZHPiTUE3zQOHyMMpJdufJ
         ehlvHFh1Bp7W0JcXTJ/jtXMJwI27zfoq9NHlrrHSR6MCDfWhLeG3BUig+IIanc+xvO6A
         ogXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750802383; x=1751407183;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xQqzpTIDZ+9bBUiOMwcKW1NeUJfD6BfeoVDwwp+XN2A=;
        b=iFz2fnU5qiqMmmyTz7s4R5sReYHLSd/VNb3jtWc1B66ztjxYMfq+P08JKAAAzmtVWc
         W4r65AFcVj0gn4YcnxFcz4lXGnYBFLk9oYtTlOz30fI+cxHq7X7zJFiVKJW1fFMQn8Kc
         xWWkngrK7lWrbyyu4nS7CJV23rwoBcRfidmESYPgSNRS6JvtgxSD9eKbpK92ekmKdB34
         UiwSjgjZ6SHcOY1ZRWq/z/w3Smv8AHOTxkwCJ2iqBNGnEU+xJ4FraletJpMmSMbi2wkd
         gJru7Vr75qSCrspvJ9BIxAPrFkmqxvlsfQzLUUgi0cNEfYpDD05dyUHIrWbiMZKqI923
         LAKA==
X-Forwarded-Encrypted: i=1; AJvYcCW9Ui/L+v/NWLEYh5ZMLkBq7XaWWlWaa6w9wH3soq6cvwiODLZs8wCqPLOgu2hD3EoIlDo=@vger.kernel.org, AJvYcCWBP7M18hq4uxosp1cbWV4KJLmbET6psy/a3ml7QunYoPwCFRkf9qlVtkA5mG2x8Mv0+qnrGkyIKula8eKx@vger.kernel.org
X-Gm-Message-State: AOJu0YxxV19U6ezdTwwELvHew0J0jkAF5FU+KrO8Q4BDmDoJ6sLF5RTc
	KISY04+DG/Yq3OzJqEr+MyecwZP2MQ6Ay+oupt+ZXG8HU68D9YX2AiFibZnSiteYhLo=
X-Gm-Gg: ASbGncs1ZH+DWO5qFyc5m2n8kFjYqk59lPoIf2Mp7MJht8n3qQjT3oH5FVbdunSm8kI
	eFRyAX4ZEOGfCUPqjtAG544P4toJnoUQH+++ccpWjyGc4yxSPUMO49gsIvX0l5c27OQkha114aj
	/x8M6/07tLtc8fI7jxWffzePEUhbUtMUWwflVWNr2Tm5v9HflRXUfdNtcmR3h4iVqeiNVIp6vZw
	ShoGVIhSwmKFyiOlQ+yIOS1uEfJMH8XOKypY7fOq8q0qMQXNFRKmPUqKIDYroRons1dehomuo28
	pUNiYRKFJ8bMv+mr1NSAB8qnUK7b6p3ygTW2i4xVVlWTHRi4XtHe6G7wIdaAvyTZjIY7KNUYz9r
	uqbJY1vMQHw==
X-Google-Smtp-Source: AGHT+IHjY/Iux+4KouD9WP5ZcRNbBBR4Q544UgeRq8nbRzCDV3SgxPt97JYaUiiQbhFW9KBhqDwJLg==
X-Received: by 2002:a17:902:f712:b0:234:a139:1203 with SMTP id d9443c01a7336-2382402e59fmr16396385ad.32.1750802383078;
        Tue, 24 Jun 2025 14:59:43 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:9b77:d425:d62:b7ce? ([2620:10d:c090:500::6:f262])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d866488csm115963795ad.158.2025.06.24.14.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 14:59:42 -0700 (PDT)
Message-ID: <11d71d3c2ac47438e4f366ec555e1695880f454e.camel@gmail.com>
Subject: Re: [PATCH v3 1/2] bpf, verifier: Improve precision for BPF_ADD and
 BPF_SUB
From: Eduard Zingerman <eddyz87@gmail.com>
To: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, 
	ast@kernel.org
Cc: m.shachnai@rutgers.edu, srinivas.narayana@rutgers.edu, 
	santosh.nagarakatte@rutgers.edu, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau	 <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song	 <yonghong.song@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev	 <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 	bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 24 Jun 2025 14:59:40 -0700
In-Reply-To: <20250623040359.343235-2-harishankar.vishwanathan@gmail.com>
References: <20250623040359.343235-1-harishankar.vishwanathan@gmail.com>
	 <20250623040359.343235-2-harishankar.vishwanathan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-06-23 at 00:03 -0400, Harishankar Vishwanathan wrote:
> This patch improves the precison of the scalar(32)_min_max_add and
> scalar(32)_min_max_sub functions, which update the u(32)min/u(32)_max
> ranges for the BPF_ADD and BPF_SUB instructions. We discovered this more
> precise operator using a technique we are developing for automatically
> synthesizing functions for updating tnums and ranges.
>=20
> According to the BPF ISA [1], "Underflow and overflow are allowed during
> arithmetic operations, meaning the 64-bit or 32-bit value will wrap".
> Our patch leverages the wrap-around semantics of unsigned overflow and
> underflow to improve precision.
>=20
> Below is an example of our patch for scalar_min_max_add; the idea is
> analogous for all four functions.
>=20
> There are three cases to consider when adding two u64 ranges [dst_umin,
> dst_umax] and [src_umin, src_umax]. Consider a value x in the range
> [dst_umin, dst_umax] and another value y in the range [src_umin,
> src_umax].
>=20
> (a) No overflow: No addition x + y overflows. This occurs when even the
> largest possible sum, i.e., dst_umax + src_umax <=3D U64_MAX.
>=20
> (b) Partial overflow: Some additions x + y overflow. This occurs when
> the largest possible sum overflows (dst_umax + src_umax > U64_MAX), but
> the smallest possible sum does not overflow (dst_umin + src_umin <=3D
> U64_MAX).
>=20
> (c) Full overflow: All additions x + y overflow. This occurs when both
> the smallest possible sum and the largest possible sum overflow, i.e.,
> both (dst_umin + src_umin) and (dst_umax + src_umax) are > U64_MAX.
>=20

[...]

> Co-developed-by: Matan Shachnai <m.shachnai@rutgers.edu>
> Signed-off-by: Matan Shachnai <m.shachnai@rutgers.edu>
> Co-developed-by: Srinivas Narayana <srinivas.narayana@rutgers.edu>
> Signed-off-by: Srinivas Narayana <srinivas.narayana@rutgers.edu>
> Co-developed-by: Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
> Signed-off-by: Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
> Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.c=
om>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

(Please don't drop acks).

