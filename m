Return-Path: <bpf+bounces-45361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A229D4C1C
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 12:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AF8FB20521
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 11:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06261D0E11;
	Thu, 21 Nov 2024 11:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z0/VSEsE"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E101CD1EB
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 11:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732189155; cv=none; b=hvGJYvMOaIlUs+sRaUft1D98WGNw2PZWGgi8AwSKM/4j7SeY60KesNQL5klVPR+gozmEQRhAE99AJJAZdZJO+7czIGJrx5FGEdhwm0Ezqp94GqTLytCKJsnDEmyFbuZnVq8C5JiJ0/X+HMEJCkGWoFbTFg2y0GF8WTnIaKDdg7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732189155; c=relaxed/simple;
	bh=jeERqH8suxB4XZ6DQ3NnK4owYG251tRlO+1BFJ9E8wk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QxZXc7YFkQstfuSDZQbagl04ED42Iccg3f90nZ8V9MgNER8TSHtriLwkAxuLjeo479l3RfK3cdCDVEgOdwVKAZaRpKDfSnpHN9Hz2bjgwmrarrA5UZ0sNMsMthfh7Rq8LyKuV4PhR8xYwpcmceMdoZyrQCY1trdWf97EQL/BgVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z0/VSEsE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732189152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZRfE+tbksIEnTCAHVyJ8jrIxE0mrpQDhQYCVg8pQJEs=;
	b=Z0/VSEsEFM0NRDiPRqjQeGr2c/nkIaBoKbt+Dtj0iyZwNVNC17wOHsZkyQBnBQfAxbIG4u
	wExzFzTHSnKyBHc7i3SRUJyE2KwXfQpwUV6lbiclo+k9Fgkd9bMy+dBKgfN/tUBjgyvvp+
	tvHUrAwSWx/bALbL4LcPIP0Nfo5L5F0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-sZ_ZBDFAMnyH4e5eVp2cOA-1; Thu, 21 Nov 2024 06:39:11 -0500
X-MC-Unique: sZ_ZBDFAMnyH4e5eVp2cOA-1
X-Mimecast-MFC-AGG-ID: sZ_ZBDFAMnyH4e5eVp2cOA
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5cfdcbd3a03so602038a12.2
        for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 03:39:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732189150; x=1732793950;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRfE+tbksIEnTCAHVyJ8jrIxE0mrpQDhQYCVg8pQJEs=;
        b=NcgIr4HPFacYBx3SrWP8tre+TA5CyGVWQG9676wCg1tXgI8+ruRL1CuEKoB+6gIP8E
         yYvrkEy9S+WxjHS/QNxtel0KsgpRJA2iX/amPHibKcHg3GIuHopE/Q5556pchqOjZgvx
         ANS7d+JJgG/qtcMhTyYJEvQGHwF6zwNusobOKZk6BE0lyWqjaiAZ0G5e7inYaGC1zWcU
         U+df3mq0VegNGHTSI+V+ggsjUvvOfnUw+XEUWUHxG/9UqwEdIrhb2FYbMhD3hvzG/t0P
         xo0YgXMSomdtwZ87AabZ497/YmOuDDVh3mSEwlUtMfEOEgfx/wvZdtXd3QsaI4b0rzHj
         UIxw==
X-Forwarded-Encrypted: i=1; AJvYcCWaCu13xPgk4m0V+SiIHgQt4GPNtQzP2PD1hsNPJIuUg16zoeyfmZZYmeNtWZqMslM/uug=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpF8IKGEwb2qeLWBXVKiUcAA5Nlja6wuoJUyaABseoDcRbPaTU
	RHiQ3WdujQ6PXL3fhcWztRjB910eb6JrthO8xfqZiUyh2zwTP31aQEvJtzM/HrhYrm6lvQ9BSCX
	n08R6EKm6MF1Xxe8wOU/eBY2dFh5Tqblu6YlUUSlUIovJ6jXvNg==
X-Received: by 2002:a05:6402:13ca:b0:5cf:b860:349f with SMTP id 4fb4d7f45d1cf-5cff4afd8ffmr3724292a12.1.1732189150048;
        Thu, 21 Nov 2024 03:39:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGELobO5gJWrf9ch7ap0PULcsYzQ9MmSgpCeN/Eb6IoeA9NSAhokGrND0jsffbvNgLBBoNErQ==
X-Received: by 2002:a05:6402:13ca:b0:5cf:b860:349f with SMTP id 4fb4d7f45d1cf-5cff4afd8ffmr3724272a12.1.1732189149633;
        Thu, 21 Nov 2024 03:39:09 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cff4500b09sm1778355a12.42.2024.11.21.03.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 03:39:09 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 20D07164D8F8; Thu, 21 Nov 2024 12:39:08 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Hao Luo
 <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, Daniel
 Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Thomas
 =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, houtao1@huawei.com,
 xukuohai@huawei.com
Subject: Re: [PATCH bpf-next 07/10] bpf: Switch to bpf mem allocator for LPM
 trie
In-Reply-To: <20241118010808.2243555-8-houtao@huaweicloud.com>
References: <20241118010808.2243555-1-houtao@huaweicloud.com>
 <20241118010808.2243555-8-houtao@huaweicloud.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 21 Nov 2024 12:39:08 +0100
Message-ID: <8734jkizoj.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hou Tao <houtao@huaweicloud.com> writes:

> Fix these warnings by replacing kmalloc()/kfree()/kfree_rcu() with
> equivalent bpf memory allocator APIs. Since intermediate node and leaf
> node have fixed sizes, fixed-size allocation APIs are used.
>
> Two aspects of this change require explanation:
>
> 1. A new flag LPM_TREE_NODE_FLAG_ALLOC_LEAF is added to track the
>    original allocator. This is necessary because during deletion, a leaf
>    node may be used as an intermediate node. These nodes must be freed
>    through the leaf allocator.
> 2. The intermediate node allocator and leaf node allocator may be merged
>    because value_size for LPM trie is usually small. The merging reduces
>    the memory overhead of bpf memory allocator.

This seems like an awfully complicated way to fix this. Couldn't we just
move the node allocations in trie_update_elem() out so they happen
before the trie lock is taken instead?

-Toke


