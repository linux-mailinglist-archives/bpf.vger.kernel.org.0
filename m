Return-Path: <bpf+bounces-45351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 226B69D4B18
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 11:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF16F1F21D3C
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 10:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819181CD1EB;
	Thu, 21 Nov 2024 10:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RByR2EL3"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709E71BBBDC
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 10:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732186446; cv=none; b=Q6RK6KdD1C0UoqDc167UUwUTJsRHRHdGvxeiAdWj2OP3Dx3Sk2agfwBptPlWZ1sx+TBZEPgKzYghbpsb3L25TXZS9jIgeEZWrI4ecIyzJSc+dgHabqdL617GVIUerBffJzAbbbo6Q3o9dSItzgz1QZXFUy0PKqR8LObgTsTK/vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732186446; c=relaxed/simple;
	bh=CXJjCEAofxnuw69fKZzogqB0tQRF4jRALiX6Vd8zQao=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qh7oD88GJIp1JtXrY4el+qseNpe3UIUG4QWD6hOmipYxli4rs/T+zmpFMAGNCcPxkNjKn8+5zPC6i8oT5+guXRowjYy3gzrxQ9nDFhaEz50myQ5egSdNIs///0ol06Ksrk9SAyZvi2zRl68EERuGorxz2ozZcFCK65y6twkhiys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RByR2EL3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732186443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lBillzcY7aVBTc2djkNnBcq61fcwpRG4m6q5p1j5LAg=;
	b=RByR2EL3wo5J5PLJqgZclA7hiaT726FjB7CWls/YUQjjjF9795G7tryeqI8OddPlEtpsov
	uJAqv0UpNvTWYx7MAf5yzFGS0S0EWgXAWX0J7BliIiXmVMnl9ycCm0Fl5ji0bK44Nyo4uN
	zD45sRYzxZp9q5a1675uepzsYagblOI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-5DhEVSf6O7e2zuUhWrX7mg-1; Thu, 21 Nov 2024 05:54:01 -0500
X-MC-Unique: 5DhEVSf6O7e2zuUhWrX7mg-1
X-Mimecast-MFC-AGG-ID: 5DhEVSf6O7e2zuUhWrX7mg
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a9ad6d781acso58679766b.2
        for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 02:54:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732186440; x=1732791240;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lBillzcY7aVBTc2djkNnBcq61fcwpRG4m6q5p1j5LAg=;
        b=bErV5S5h+c1quNJbneCckzjHvviJPAz2KAUSIBGRi/wv5+8l4vkJFZ/dvZUz9ygJ8u
         SawgWTcgzRpU07NMhSgFd+1oTE+XI5vSulk9u0XTSUhzVNQvjIuu4BZ38d1YQ16gqC2I
         YAK/PJXcZmAvXw437U4TjYfUEHDpnsbiQAsx14yPX9yoFBMTbCC6F2WgeGBl8O22XQQ6
         bYkfdjY6rM3FhFZqkPyxraDfz69znSVnujO+KYpS6pYsEY3Uo3UsEvDT7VPL7z2oqb0u
         AgNjznhz+N3zoGlkVYvldYZuP267kAaIF8oAl1d23JrAKepQ85rELaBjBTz9OmQSBJA4
         9aeA==
X-Forwarded-Encrypted: i=1; AJvYcCVucEBmFLeyzixE2gz3sAeciOMYPsOtMk4sPfThcXum9SSn5JBUackMPnPM7cY41iaz2Ak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgn0pCK86IveEwfomUg5qU5wnQ5urw8rNGoiMOWwQC4WZKeFHc
	MRVpSeJKp6zss4v0QsKRLJSrWfechpGP4c0SF+WmKKsi3Q2rmQ9TNfXZ6Ol6ODmYt+FXLalciqU
	USmfUuttjY/I0zn3/6v5MENANfm+omZtXQjyvnU7qSJLSufmIKA==
X-Gm-Gg: ASbGncuBuTjrHKcNvzhGW6SyxLpKs2AsaP4U9SEL+RwMFeWp0TOrocdeA6b9pJgBxtI
	MpQd+zP9aiTxldBtxxHvGgT7EVXbJeOwnz3+izJh8aSDspqkcIHbL9J/jeTiWlryPieyNvky4wk
	Lk8aO0/Vk9bUBcSsAvYB5eCn0WHYvVuC95CEkcnJDkPJFAXBkR4jRR7p1c0gIXfqbbXBPswgUPT
	XW8MZsDzKKYaFgLO8kyMxt0Mtu2LBZGexTEgHuBj1tfFVg=
X-Received: by 2002:a17:906:4793:b0:a99:f8e2:edec with SMTP id a640c23a62f3a-aa4dd5522a7mr526027266b.21.1732186440339;
        Thu, 21 Nov 2024 02:54:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFX9W0FZgcOpBEer5QQyQckE2C7KWsjUiwg9uBjltC1ChvYzniuoeONi6YH6A4T+zE/Y8qZHQ==
X-Received: by 2002:a17:906:4793:b0:a99:f8e2:edec with SMTP id a640c23a62f3a-aa4dd5522a7mr526025066b.21.1732186440029;
        Thu, 21 Nov 2024 02:54:00 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa4f43821bbsm65958066b.201.2024.11.21.02.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 02:53:59 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 66A80164D8E0; Thu, 21 Nov 2024 11:53:58 +0100 (CET)
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
Subject: Re: [PATCH bpf-next 04/10] bpf: Handle in-place update for full LPM
 trie correctly
In-Reply-To: <20241118010808.2243555-5-houtao@huaweicloud.com>
References: <20241118010808.2243555-1-houtao@huaweicloud.com>
 <20241118010808.2243555-5-houtao@huaweicloud.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 21 Nov 2024 11:53:58 +0100
Message-ID: <878qtcj1rt.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hou Tao <houtao@huaweicloud.com> writes:

> From: Hou Tao <houtao1@huawei.com>
>
> When a LPM trie is full, in-place updates of existing elements
> incorrectly return -ENOSPC.
>
> Fix this by deferring the check of trie->n_entries. For new insertions,
> n_entries must not exceed max_entries. However, in-place updates are
> allowed even when the trie is full.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  kernel/bpf/lpm_trie.c | 46 +++++++++++++++++++++----------------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
>
> diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
> index 4300bd51ec6e..ff57e35357ae 100644
> --- a/kernel/bpf/lpm_trie.c
> +++ b/kernel/bpf/lpm_trie.c
> @@ -310,6 +310,15 @@ static struct lpm_trie_node *lpm_trie_node_alloc(const struct lpm_trie *trie,
>  	return node;
>  }
>  
> +static int trie_check_noreplace_update(const struct lpm_trie *trie, u64 flags)

I think this function name is hard to parse (took me a few tries). How
about trie_check_add_entry() instead?

> +{
> +	if (flags == BPF_EXIST)
> +		return -ENOENT;
> +	if (trie->n_entries == trie->map.max_entries)
> +		return -ENOSPC;

The calls to this function are always paired with a trie->n_entries++; -
so how about moving that into the function after the checks? You'll have
to then add a decrement if the im_node allocation fails, but I think
that is still clearer than having the n_entries++ statements scattered
around the function.

-Toke


