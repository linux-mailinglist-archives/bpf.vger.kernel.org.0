Return-Path: <bpf+bounces-72947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDE1C1DE41
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 01:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29E8D1892E64
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 00:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40DC1D63D8;
	Thu, 30 Oct 2025 00:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9zEJuxp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191DD126BF1
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 00:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761783664; cv=none; b=e3K4cGyfYMOOgvzi9V3dDH0bAO8eFT8fGSKa0gJ+zLgOvAj/GUy0Ul9RMgHnzeypUoyjwdjbqm4vMEgTY4Q4LTSpseMa6XXi2g3nNw6nCNF9cSAlh+GyLRhuYiK6EvgkbLmFYzrlgcokQs6oRh3bKiZB+8uk36ZQuHNcJ3gSq0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761783664; c=relaxed/simple;
	bh=fXq1wlz6pIk9r9oKVy7r7uG/dnzODmNy6Bfl7A3g6vI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ty8M1bC4p5rx8lC49k5aYb/9XXJhBf+u//AaseqAjyNMipqcn7fxKWs7AdcK1Eb7dtV9jBI49I9P42TnpOUJZ/xgNJaojf8wWVhuFo7NfVYi51LPXPE4nwpZHgGWLV0Ns/hUy9aQcUMI/Y9u+0g8NUgoBVZROx2fOKgKHRRlkqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9zEJuxp; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b6cfffbb1e3so286729a12.3
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 17:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761783662; x=1762388462; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fKXzXiaAamhr5nXJE+8a2ZqDB/UZsDlNVkjUwPPbtVQ=;
        b=b9zEJuxpETq7P5MZTGrBBHbdhh5ViLCV0w/ilWDxbbiE/NSmA9HEQ/tG2ARVQTnDuR
         HJlfJfb7eLY3VhXBfe+C3B2ie3iJXBhDP7KL9+r0Db55PJrCcdmAxAqgbRkYWlR2hH1z
         9I4pD7kJWlFlkLAoayR3HjBQOvnpaYiA72ShiqQ/2j8ZeNItcCQRNaoLtTOrjAb1F1T9
         alQ9RDswG3LWzgCMBssLVnpXg8d1o2ZpkyMdaBvaeJ8fZ//zcNTg+7hnMLW4z8Yj2up6
         bD1kDULoXUxvYHIqq5aoWOiZYQ1FuBHHqdabNssSRM7KPc9eBEBvugQpPamsgARuj+nH
         CuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761783662; x=1762388462;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fKXzXiaAamhr5nXJE+8a2ZqDB/UZsDlNVkjUwPPbtVQ=;
        b=SCHZe4vxB44dq0AjetSWc/oFcz65+pndmsT7WwO/3AHGLOYHzJhoot4E+wCY4rblrz
         5dsjm2ZJ+q1N5QsUeKT26+JG3BG5BdBxOoSCGSGZzq9R+uaP/yZD4uOeatE2x90Ed6mT
         aWZ2BjysGtV2hpOkTNVCCX6GYuuBoDUyDhtxDvkYpY5N8M1hjZ0hZ/J4d0CFKqC7eH3C
         PhS21ns6zGTr5rauoLmcdot/1O3DLccSKqknV6Wua0ojYCrrYoEHGL+G5qKHDFnreJpi
         sSkUlX0Vwxn2zQkYv60uFO4ES4ekuNKPTn13jrxxJZXaGxKuaKIUDfQtMGXZLAy6SkTy
         nKEw==
X-Forwarded-Encrypted: i=1; AJvYcCVtoyPz1UIQdLP+J1AONMSjNyYrF59HhXHhLruwp/o/xczQ409TAg3psvJxZOY5a9BpoZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx3elbHox3/gjLTlEEr8kW8kF6Lf/1iOiZDQIA3zpJygQUtOn8
	BBGdMrBnFbvwT4u2RZNxBpkJfz93zCTc6p6hUFcW+kX+IizxGIlbcqGn
X-Gm-Gg: ASbGnctCeYN+G8mng9JPFs0ZR3WRImdNsLHW9d9MZjs5XpB+YgIITg337/dlADbsVAZ
	2V3CRrf7mo5mSI40CoKMfw7PfwLpB8XHgqXsKrFCctkp4GstyWYL79owYdtcuYdF5pLy7d3xeOg
	awpGW6WJZG4pL+tRx2zMXkteMgOSkuUw9TSob0smR1duGZszoaskr1fVAdCrHkhdMjHTA/Evw2k
	4U5RdPNJDCn1taKfu9hjKmBiy+7OORHU1euJZ32Yewn4pF6DPYxcQ6NNhNDTdeS8xzPu4EZRGn3
	7IhbhxmHj7s8JptynHcANxp14m/Y9AXRjPf1N24PnJGolWZHWyiqRuyD5+FgMZm161gUxHqpV1M
	S1lYDiOcMMS4OE18juQ4MYx1o501N7W3kPQ//sW92b/8dLepX6iypg+I9obJMKXRbiM1usJ9MOm
	bdzt8Yus5De3IJX/Cn2zR05j1cog==
X-Google-Smtp-Source: AGHT+IGJWCAUz/GAtlgVcJqfEUB+6xqRi8igUEujNUglygSem3Yjnk1g4sTJmdPENLWCPikT9IiCuA==
X-Received: by 2002:a17:903:22c3:b0:294:a827:851 with SMTP id d9443c01a7336-294dedf645amr54419185ad.17.1761783661959;
        Wed, 29 Oct 2025 17:21:01 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:3086:7e8a:8b32:fa24? ([2620:10d:c090:500::5:6b34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d40166sm162913895ad.67.2025.10.29.17.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 17:21:01 -0700 (PDT)
Message-ID: <6da8d1b1c0255df498c99edac6c8e8a56d3f5527.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 6/8] bpf,docs: Document KF_MAGIC_ARGS flag
 and __magic annotation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, 
	andrii@kernel.org, ast@kernel.org
Cc: dwarves@vger.kernel.org, alan.maguire@oracle.com, acme@kernel.org, 
	tj@kernel.org, kernel-team@meta.com
Date: Wed, 29 Oct 2025 17:21:00 -0700
In-Reply-To: <20251029190113.3323406-7-ihor.solodrai@linux.dev>
References: <20251029190113.3323406-1-ihor.solodrai@linux.dev>
	 <20251029190113.3323406-7-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-29 at 12:01 -0700, Ihor Solodrai wrote:
> Add sections explaining KF_MAGIC_ARGS kfunc flag and __magic argument
> annotation. Mark __prog annotation as deprecated.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  Documentation/bpf/kfuncs.rst | 49 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 48 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index e38941370b90..1a261f84e157 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
> @@ -160,7 +160,7 @@ Or::
>                  ...
>          }
> =20
> -2.2.6 __prog Annotation
> +2.2.6 __prog Annotation (deprecated, use __magic instead)
>  ---------------------------

I don't see any kfuncs that use __prog parameter suffix after your
changes, this section can be dropped altogether.

>  This annotation is used to indicate that the argument needs to be fixed =
up to
>  the bpf_prog_aux of the caller BPF program. Any value passed into this a=
rgument

[...]

