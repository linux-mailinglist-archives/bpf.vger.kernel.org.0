Return-Path: <bpf+bounces-45353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 161EB9D4B2D
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 12:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94DD9B23AE2
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 11:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBE31CFEC1;
	Thu, 21 Nov 2024 11:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SjNujz3v"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B1A1CB9E1
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 11:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732186883; cv=none; b=Sryaw4wJti44CrOJtLl0uolQud2etoXwDrnyOskv9k/B61l91ldo4I75nW9rsjIyPY0UnZrpevyBPApaeuSxjzR8OF1SQaxNZYMb4gGgycXDAzFs6gt35YGAZcDYKmVbMumVhgJegc+b/ash/1eYmcOwtq1c0S/HdIA5nn5nWEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732186883; c=relaxed/simple;
	bh=TpBMdOCqS6E18li01B/IIOpancHzY8awuCTC2fEgbYE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xiu6XjCSGdov/hk50ffM8ofqGs4F9dS+3fqKcYSjv+i+n31JSbzojZ4jtpMW9ofzL9g7Bevj16gJ1nNr4S6a9PFP68LYZws0f8SDPsQbsc41GF7UYNrAZ7zb0sxq8Efe4YA0coocbWf0t1jGLhZsv8QB4O26IWjdvIo8oABsuXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SjNujz3v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732186880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TpBMdOCqS6E18li01B/IIOpancHzY8awuCTC2fEgbYE=;
	b=SjNujz3vtigImQYU4kx0FcgP2RmQFd+39OZvLs6Dw3uy4Ry+bInk1Op+qI44DIEZFxG6DL
	WsFNZRc6FnMN8dqTeuM98HmPXVJkdUiNGVQ1PhNfDFz/rpH9lv5iF8Y5j5Oww7FBndYDS2
	swnBgOd1SqvbMAF9WL45eNwoSnUcttA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-WNFwShTDOUyG3wvFoQFgeg-1; Thu, 21 Nov 2024 06:01:18 -0500
X-MC-Unique: WNFwShTDOUyG3wvFoQFgeg-1
X-Mimecast-MFC-AGG-ID: WNFwShTDOUyG3wvFoQFgeg
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a99fd71e777so57559866b.2
        for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 03:01:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732186877; x=1732791677;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TpBMdOCqS6E18li01B/IIOpancHzY8awuCTC2fEgbYE=;
        b=XaOVDmlVScH3V0/dnvV5Km+7pnY6Kj9yErMWwlEE9FvID9A1rT3V7bMb99EkxTSNaP
         ufPO6Z1kA/lRzL/2ljZzHotaXAC9FYvXUysoMEXscI5nmgv4UyRAxLd0VSpmCNqIUVDU
         03xcLXIgNjR7VE4b7L68weTGqRhfM+ZPM47TwiN6lx1Ee86O5nhW4fUzd1ntv7K+fZFm
         wLLRnJWpRtdO/6MYKz2uaGYFc/DsTXvxJMjVZtKAn8tiCtgIHu/YmnVPpE2usvSVmnKi
         tq2yaoQuHXiq7hriEBezQN4YQja8zHxPGOGt6Z0XqeyK9GlvyCbiThoYLjDU0w6Uafx8
         rb8g==
X-Forwarded-Encrypted: i=1; AJvYcCV2zKN4lkGR/RW93IDKM6bQoTzDiBfAngZe5JLkfIT5W1KxDL2hshSIF8I1VTAH4bfa4yY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+HbxSQUjOO/wC6AXGER8OcC4a59SsfKFYGiugQAudvozzrJKL
	+raQhYw+aSkBDXzOIC+RkCAhoabwGoaBmx+rhegOUhdKdhPQLVZaPvn4vYWm8CeJhYRrOGgQTfp
	Gd6b6YnDSmHL7lQwwm1UL+TkeGVk7aVNQirKRwyWC3zpkXV75AA==
X-Received: by 2002:a17:906:ee86:b0:a9a:10c9:f4b8 with SMTP id a640c23a62f3a-aa4dd76f714mr555244466b.61.1732186877573;
        Thu, 21 Nov 2024 03:01:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFk0OsHD8hO/4gqJKAzzDF4FEwVABeFe+UM16p98J032CbHRptzT5dFkKcz//dg9SmqYy2h7w==
X-Received: by 2002:a17:906:ee86:b0:a9a:10c9:f4b8 with SMTP id a640c23a62f3a-aa4dd76f714mr555240666b.61.1732186877156;
        Thu, 21 Nov 2024 03:01:17 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa4f41818d0sm67494866b.80.2024.11.21.03.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 03:01:16 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C3F0D164D8E5; Thu, 21 Nov 2024 12:01:15 +0100 (CET)
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
Subject: Re: [PATCH bpf-next 05/10] bpf: Fix exact match conditions in
 trie_get_next_key()
In-Reply-To: <20241118010808.2243555-6-houtao@huaweicloud.com>
References: <20241118010808.2243555-1-houtao@huaweicloud.com>
 <20241118010808.2243555-6-houtao@huaweicloud.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 21 Nov 2024 12:01:15 +0100
Message-ID: <875xogj1fo.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hou Tao <houtao@huaweicloud.com> writes:

> From: Hou Tao <houtao1@huawei.com>
>
> trie_get_next_key() uses node->prefixlen =3D=3D key->prefixlen to identify
> an exact match, However, it is incorrect because when the target key
> doesn't fully match the found node (e.g., node->prefixlen !=3D matchlen),
> these two nodes may also have the same prefixlen. It will return
> expected result when the passed key exist in the trie. However when a
> recently-deleted key or nonexistent key is passed to
> trie_get_next_key(), it may skip keys and return incorrect result.
>
> Fix it by using node->prefixlen =3D=3D matchlen to identify exact matches.
> When the condition is true after the search, it also implies
> node->prefixlen equals key->prefixlen, otherwise, the search would
> return NULL instead.
>
> Fixes: b471f2f1de8b ("bpf: implement MAP_GET_NEXT_KEY command for LPM_TRI=
E map")
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


