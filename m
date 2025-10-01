Return-Path: <bpf+bounces-70157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B0BBB1DCE
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 23:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B0C42A17EE
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 21:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B84A30DD2E;
	Wed,  1 Oct 2025 21:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYlGvKld"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A575E30C63D
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 21:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759354643; cv=none; b=sET+U0bAAfYzN6REc1xOQTcad+Gi8nVyFZbhxQWOpuaZ7jloSe+LO3gOCFvPuv+oraL9MSs7e1jkHJSVvyXPq0RPlQXzqTWs4Usel4Qb7O0fRN6dXgdRohS0/EAP/d2P7tvwpM+bI5ozURXHl3WptW5VHq1Jr/KAVbiizbh5ddA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759354643; c=relaxed/simple;
	bh=TmOMtmziJojzaW4kw6DsUCZxq9vy/m+LhXYWKJFyZg8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CHScmzcf8tUqABOmF/2ksUBq7OLxdrDOuJ99k7L2PpgZyA2t38zVXeZMBBiWDefKHZAXxXnYONzdptgqJ7LswMxJfkCTSm8oEQcrPvwPW4ge8aaHMba5vO6Jt/CBf2hexT9rEFMgAWC0NE//hNepQ8JVxKjy1XE3oVjgKYtkk4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYlGvKld; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-32ee4817c43so248092a91.0
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 14:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759354641; x=1759959441; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8mxzB7wUwWKyl2/49VFKwppTuQWjopbmE4GYK3WqQOg=;
        b=OYlGvKldLnXSN7ovvHiKWqfRrWCIRLezDMPE97blwyJgZhFRHiHguLTzsO74dD04a1
         Hua96PURLn1jgXcRUh8UTMmFLVYJKwxjycO1i+suoeLHSM4+ADBNoata5rlqXoIl5CS0
         R0kG7L7SsXti5gcK6+S9R5Zhx+sBmpH9zPsD4ZKn6O/3+rBzAbUTzlkn+vWLlpS9Xlmg
         4vroPpc4kB6iSdwBvV9QL1cSqgoAT7VI0wc86HWh6aKP1L+LGzYsF7JvzYPjZXUlgHht
         yGD3vLeZbNE5fnjT4EJ4GJbfTNATgt8/vQzMae9wO2fQZN2XD6FRhFwmoUIZbre3Y8D2
         vnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759354641; x=1759959441;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8mxzB7wUwWKyl2/49VFKwppTuQWjopbmE4GYK3WqQOg=;
        b=VMVbBTO+3rB1fEI8Vgzj8Ed53VuKajrz16wTKGAQJFDg9wlYU5j27QGub/BowrWPvM
         7K5z6kLYWQHRZ2DvixWBDV3E09smwrOifcqXSpWBQ389URJwTZvM4QiD4T+sW/letG3W
         Nk/orspjQ+AqUTchTplmOt54n7WuLxzkDNUcx3WhpyMHh5umAUys3slyWp9uoAcUlUsO
         uBWU69ZC3Y3JwDKKQtdSpiIMal9F00k6nbubK8FF2+WsiyuQq4aU+vV9P3zGZCq8zRGH
         iJRc2+lV1Mnd3Gy+BhHOh5MUUI7rrpka7gqAilboFvzkn9LyZnOnGqJh1m2lvSqDZFG2
         NRcA==
X-Forwarded-Encrypted: i=1; AJvYcCW1OoruDwwGFSx1bfZNZ3dnX4YuKsHnG5/LIhpr+aEPEVuwc3EhIfOHakXQb3+/XwRbmbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXALqqqp0/RB77H4Vpupk7wIc5Tm6w79gfumft7rRgRT/wICrj
	+MHGZAoZf0fM9IijsMBAifXEmj6xjaXuWh9qy+IHQ7NqmW3AKA9PFILH
X-Gm-Gg: ASbGnctWk2s/J2Bm96oj/tddVLRD1w8WVfFKv6CfBkV6opr66vhNRBOQSv752uvAoA5
	+J1cUoLWnmcZvyB3/omJxDuEtigLhoqPGxzgWVL3V9waDAnDbNIQv4qeahIpdIMcMLrrgGzK7l1
	OrkHGDm03Lsohn9ZuoOUy1/VJwlvqMn52x9nhl5yno2cCeIc6HtwmJ7jvV+MqAIeQsSGhPWNOUD
	U2jC0Xxx+lq6Nbhp4Tvw8rdolTtBfm/i69xGM1ay9uiIDnacmJ2yOGYxE5rwAL9hmSxHAPnFX9j
	V+gbjwtDvIZ7QQhNGWv4qMgNisKBW+YjtMn9Fbz6wgKp8s+PQHY55VhHvWLlXM9YbcL81qD5g4w
	DFMp8yYPEk5dgftJ4xsvFmPG2cMGuHTxnQobVOhm5628buUUUw2Tjup+xAO5oBzWzI+Cfm/I=
X-Google-Smtp-Source: AGHT+IEILyH5kNCOuXUWNkXZ/1PlDlhn/DU6pOsC8268/1nkKPvYHyKY8D0ltBhImA7rPqVszq65cQ==
X-Received: by 2002:a17:90b:33c1:b0:32e:8ff9:d124 with SMTP id 98e67ed59e1d1-339b50c7e5emr1137171a91.15.1759354640914;
        Wed, 01 Oct 2025 14:37:20 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1ed4:e17:bedc:abbb? ([2620:10d:c090:500::6:420a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099af2deesm468706a12.12.2025.10.01.14.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 14:37:20 -0700 (PDT)
Message-ID: <890ebdd23095002af30df4b4626e093cf23d2d9d.camel@gmail.com>
Subject: Re: [PATCH v2 bpf 0/5] libbpf: fix libbp_sha256() for Github
 compatibility
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org, 	daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Wed, 01 Oct 2025 14:37:19 -0700
In-Reply-To: <20251001171326.3883055-1-andrii@kernel.org>
References: <20251001171326.3883055-1-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-01 at 10:13 -0700, Andrii Nakryiko wrote:
> Recent reimplementation of libbpf_sha256() introduced issues for libbpf's
> Github mirror due to reliance on linux/unaligned.h header. This patch set
> fixes those issues to make libbpf source code compatible with Github mirr=
or
> setup.
>=20
> This patch set starts with a bit of organization: we introduce libbpf_uti=
ls.c
> as a place for generic internal helpers like libbpf_errstr() and
> libbpf_sha256(), and move a few existing helpers there. We also clean up
> libbpf_strerror_r(), which seems to be a leftover of some previous
> refactorings.
>=20
> And finally, we move libbpf_sha256() from huge libbpf.c into libbpf_utils=
.c,
> following up with fix ups to make its code more Github-friendly.
>=20
> v1->v2:
> - add missed cpu_to_be32() and be32_to_cpu() conversions inside
>   {get/put}_unaligned_be32() macros;
> - target bpf tree (Alexei);
> - applied Eric's libbpf_sha256 selftest locally and verified it works;
>=20
> v1:
> https://lore.kernel.org/bpf/20250930212619.1645410-1-andrii@kernel.org/
>=20
> Andrii Nakryiko (5):
>   libbpf: make libbpf_errno.c into more generic libbpf_utils.c
>   libbpf: remove unused libbpf_strerror_r and STRERR_BUFSIZE
>   libbpf: move libbpf_errstr() into libbpf_utils.c
>   libbpf: move libbpf_sha256() implementation into libbpf_utils.c
>   libbpf: remove linux/unaligned.h dependency for libbpf_sha256()

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

