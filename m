Return-Path: <bpf+bounces-65223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D08B1DC79
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 19:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41402188E37A
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 17:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE9726E6F1;
	Thu,  7 Aug 2025 17:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekY67mOB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA63199FB0
	for <bpf@vger.kernel.org>; Thu,  7 Aug 2025 17:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754587895; cv=none; b=VVAwJqN1DUhzHbw+iaQC07xW2+S3CKVoCBhrL9gufcvgAYlrM47yPLqwioO74FT7IJdsUfRlLLboJDlscwF5tQQRV4zuYLPie+mWh8Y/lTxnXO0NCWPtii9rio/5FdocEoEeB1wuz3vgiDZMeCLawkoLtuZr9VPzA0NRFIWRu1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754587895; c=relaxed/simple;
	bh=iyXOy/KFx4dKYun1TN3tHMr7My6+9TOIct5IZRUrvXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XFPtZZCW4OWJ714WeAl81iaUBq2rJsWKnXyXmHSSkV48bGxJbYMUMmLC27AUC3/ty+6Gg2D/bYbwDNhfXeKX5cez/wGLBvvuJ+7o0HKuRgqYCe+ibe5ZXf+Sw1gmeWJIPx53PQd2wAOXbsNsmO/ThvLV48j9vRLaFdS+dXMWLqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekY67mOB; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-af98b77d2f0so231629766b.3
        for <bpf@vger.kernel.org>; Thu, 07 Aug 2025 10:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754587892; x=1755192692; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+JBt9efwXbZs0ifyvaHcT0Nec8a6FwCtuR6qIKYivi4=;
        b=ekY67mOBz3DKgcfj12eaRcTNm6eM4sspsg7+6NAiPyPKX0cKTYPosHvrFCgAJ9tncz
         1H9HFoZQXDeUrsQcKgiR9/kaTexWQ3a2uiwbeWti6PSgBwivaaHSORXpZkizC840X9II
         reDQ4l7Q7maXAsEIaOt2jblB8mTpr72g46jT8EfSqWGVG6OK936xc0dIAA1N3470O29+
         2as/qu6jVL1FoeR7GfGF/31Bzg3NSb3zDrFA0VZoQaTxOWQCP/399FF2pOHooVzscrGr
         hWATb1XJBjn1+cNHM5mMEHG9QGSXNR2WUWmYJKZ47HN5xioPwneb+/C6Z3Wu8NMW4POi
         E9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754587892; x=1755192692;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+JBt9efwXbZs0ifyvaHcT0Nec8a6FwCtuR6qIKYivi4=;
        b=vaJJJvb11V653zxDZpU2GyDE1PhKOESmQoOuuslj2hgSS/IrXtL2VKuCV7vshMtu1p
         hMZZMfxbPOKrP0hAwgu/T7NT9T4EUPlcKVQIFvMQjgADmGP6mLRyrPWOVK+oNjAKLCC2
         zDmXFVutj/b0FAp0Ks3qEEO3IaXluC/dnu00jygcyoAFIjBlTWE9yRdHIsWHMwVLLBmb
         NM0wZUhuZfq2gdT7/M7RvXoHqIOla7mp8ZRx49qYBSIBiwECbrixrjs94n9h5rtHkE25
         xmtAHbtsOWx5JTz74IaNBvEXWAzzRs1uhU50IyhQxMhEKzF3CihW7SuvztvvRqzoBuQ6
         7rQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKZZrhCFUQUjLGas3X6d9s1qAKDDkI2IrBB/6SkXF+4OSBa+YBK+oE1akkk6NwENIgPbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRecc84c1ZkL8/QBUB/iwS65hF5cWJ4PWnfQVjcIqdhtsHx5V8
	MYiL5te9RiUCQEK9FKNFIHyEANdhGjvrkmz6aymC9RaKIKiD2pJFjOLjhEQLnv+IFXnEEUWzjxB
	rHseJ0uA+BhFnVtWVNyP+s36MPytV6Bk=
X-Gm-Gg: ASbGncsdpSLrh1CWtSH/wlunS8zRGgXpiEy3JJ5wg49wjl7qzNdWEudxgVW/f3UKsxu
	58q2R4ivtVBXBxyZB5EwoosoOyrcw+zMIEoYwhauNs0jnT4YSCdwqaItomQJl3RYfLS6K3NWwRG
	K4Ijpl7iWF1/lQOuvXNiNBG72DmV7zZADfCWkaY6wnXzMGU5VCQzoI3y8/fqAbTSl6rbj1dZWo+
	Mxd9g6WvsJAyuqu5qKA4hR4FsR7/bNNDZjDBcMvXy9BNi4Cr0A=
X-Google-Smtp-Source: AGHT+IHxYr1XP7NBq9Z+WNSDd+St5IZ8hYUQZBb6N4oCVrI3OvTd3oAXKtzteUbHPEFBNahiDbmHiTJjVBV9Gqlg9jY=
X-Received: by 2002:a17:907:3dac:b0:ad8:8719:f6f3 with SMTP id
 a640c23a62f3a-af992aac46bmr635560166b.22.1754587891751; Thu, 07 Aug 2025
 10:31:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807123433.7868-1-dmantipov@yandex.ru>
In-Reply-To: <20250807123433.7868-1-dmantipov@yandex.ru>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 7 Aug 2025 19:30:55 +0200
X-Gm-Features: Ac12FXwA_PvyjXK28SNIL-zTBbYtn6zXqWAnTVPf5u7Aab9q_H4IXMMDiXAJnoQ
Message-ID: <CAP01T76neOZGxdGZpown00PqOix9SZiXFTYDrSVPjMgh8-OPxg@mail.gmail.com>
Subject: Re: [PATCH] bpf: fix memory leak in SCC management
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Aug 2025 at 14:35, Dmitry Antipov <dmantipov@yandex.ru> wrote:
>
> Running with CONFIG_DEBUG_KMEMLEAK enabled, I've noticed a few memory
> leaks reported as follows:
>
> unreferenced object 0xffff8881ce3bd080 (size 64):
>   comm "systemd", pid 3524, jiffies 4294789711
>   hex dump (first 32 bytes):
>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc 8c5ed7af):
>     __kmalloc_node_track_caller_noprof+0x25e/0x4e0
>     krealloc_noprof+0xe8/0x2f0
>     kvrealloc_noprof+0x65/0xe0
>     do_check+0x3ef1/0xcd10
>     do_check_common+0x1631/0x2110
>     bpf_check+0x3686/0x1e430
>     bpf_prog_load+0xda2/0x13f0
>     __sys_bpf+0x374/0x5b0
>     __x64_sys_bpf+0x7c/0x90
>     do_syscall_64+0x8a/0x220
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Wnen an array of SCC slots is allocated in 'compute_scc()', 'scc_cnt' of
> the corresponding environment should be adjusted to match the size of this
> array. Otherwise an array members (re)assigned in 'scc_visit_alloc()' will
> be unreachable from the freeing loop in 'free_states()'.
>
> Fixes: c9e31900b54c ("bpf: propagate read/precision marks over state graph backedges")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---

Already fixed and applied here:
https://lore.kernel.org/bpf/20250801232330.1800436-1-eddyz87@gmail.com

>

