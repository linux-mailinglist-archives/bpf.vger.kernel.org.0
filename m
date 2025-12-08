Return-Path: <bpf+bounces-76285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 042F1CAD83B
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 16:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C27003092428
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 14:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF9A329396;
	Mon,  8 Dec 2025 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PSqDxbNa";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ka5YX4f5"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F80532938F
	for <bpf@vger.kernel.org>; Mon,  8 Dec 2025 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765203607; cv=none; b=nW7WG5DPOtG520Bxb73sR6rgYgssdp/aWZW3A0EXtfLLawWUUWHi7le9l2rfM3qxtTdpEaSiPrnjrmTHmm/1Z82XO0HkeeHmMO6LnoAmQmbl2ZMocOgnRw71mZPWxyivrwLfnWsudBJtCbbeRUa+4pfD9Uz1kyel2B3S5RBsdHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765203607; c=relaxed/simple;
	bh=PljNOTo0RHMKF0uIJ0F72Ecs4jdxizKa+DxYB7R6n6g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mV9A8DWFcJR1g6md3HXiZdgC7vr+su3WJP10c5Mp/DB2lnHr1dvMDIpN1dlKtIPvhDItIk9lyOZH8+uVO/OiwDPdXVSqzyi0YFeABcqQKi0itYdS8I50m0h6jUbikcn9XE9qmzb3fRBwpECtd6jYgBTlVFaLcEmACuwegZ+SzQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PSqDxbNa; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ka5YX4f5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765203604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OqFvwLojx2/mzRD8U0g4XVY3xgE3qb7B+paToqsc4uA=;
	b=PSqDxbNapcYEyQwY6EA9+khBDzFRQ8Xh3CbQ9NmSP4EYocBCewxgCLmvbKdlxJPqRY0bSQ
	/pmdvbENPJ4Z4QTitpmI9UQOHz54M2aIjdY59d0PKphJvyPQOvxjKo9DoBRHl8J6R2QShT
	/c0NqzwFWUzy6OZ7wMs0sOOGLUwRYGY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-FpstCicKNHyLvZJn0ckiLg-1; Mon, 08 Dec 2025 09:19:58 -0500
X-MC-Unique: FpstCicKNHyLvZJn0ckiLg-1
X-Mimecast-MFC-AGG-ID: FpstCicKNHyLvZJn0ckiLg_1765203598
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-640b8d02165so4167008a12.2
        for <bpf@vger.kernel.org>; Mon, 08 Dec 2025 06:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765203597; x=1765808397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OqFvwLojx2/mzRD8U0g4XVY3xgE3qb7B+paToqsc4uA=;
        b=Ka5YX4f5jfrNDRzG2rT3gy2GzK7QDEveOuGHagrZ6jMxKwTBQC8+esc6+hk18f9E12
         fs/etNazPU2/ptkw2NyGTbH5mYH64CiVYbUMkbEH7qJTdjGSECv+hNHLqlTfGFKzxuiP
         wZ5gvzNtYPZ5F+Gtc2hce0LVpWg4jQZ1PM2erjx5UQkqN38ZJm5z20cUkUbbZY/SyCFQ
         KZS4jTZgK0dwymK47zTrTH8DcxLhKcJulOaofR+bNaC2b7HxioUXHDGpq7oJRVQPFS4m
         Kveb5ri7HTiJ7zZueRQwM7skdCLxW9p4jpcImfClRMWUhjFngiH44gdy399eRE1Ph61w
         5Bvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765203597; x=1765808397;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OqFvwLojx2/mzRD8U0g4XVY3xgE3qb7B+paToqsc4uA=;
        b=dlRGCTLkfPlsKaQ6J14DV2Cu+CXjpUykPLwWuGZ+nAMrJzyrm2rK5CVEe9iA1P2ML8
         JABc3PcWib3r0xcXAG/ably4Y3xxIEURm2kzia7EJR+n0v/ph6/baEVw8NS5UsEoG+uV
         0qqc15LVhyuOtRA9XrXV7W9pLknyI4saMqGt+0Hn+O7aIr4+6QPrWXF7mnysF+scKMqY
         8xeD/+FOM3oHmlyS0JKRkaxi2bjj0kaBH4BDVE/5rS1WyHp2qOiAwZzAD7t/CAKkQmd6
         e1vyKgMIZ4Ao22uWQM2XAxA/mTLCuCwvLPsIm23U2GeAS/l055NYa8surhmHHTQ3EfY2
         WR4g==
X-Forwarded-Encrypted: i=1; AJvYcCXWH0Bcp4yB1jyK7TxJKy5fEan5ZCA2+6oHH1RfZlS1tOLphNeNF1Qb1A7N/Wms2cvN2TQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDJaqOYCFNb3xspoe7WdVJROvDge9jTTdmJ8aaRsppd4r6f0ID
	M3H0SeCMJV02zP8EmEQq5vEo0wgc16NHvi36I129rI5UerDCHxdFS9uzCBFgY3tQ+edh7LtPrY9
	pjZ9vavEHy7zcbgp8JTLTlAQmTqWt62rdwbmQlcmD/3fQSYtPoJ+SsQ==
X-Gm-Gg: ASbGncta4NzNio9HasjNUfYWWv6mvzy/W4t7k9t+qY4o4PRH+UM0g6d7VQOmjxWIkaA
	NpChLNYzx7/LMVmcSwi4ha0oQFms1ROkwCRLxvtotbK3oyxN4v6OwMzWvLgGMKfYGjWdFHTdW3O
	Srdl0z6G520KZDQC6L5OHdVRa8UqwsJyZIQF3uHZnazm/Y8JNNVw7RynKKsTbb75cvAeTDfEc6I
	rMsrT2AsXPf1rP1kR3LUn9a4qOd4feHQaKcUq2hp1iewY4TNnSxduEhbVMrO8wNVvXgS9TMjRCb
	z5algCuo1ku4yqNutqmlzwwYW6W4SgqBRo90sDjrLKJGk9sTqc+iNz+JthYjh8U8y+ys3+r+u7Z
	rtJZ/wbe5NZAX7RmZR52XUxP/dsH4btzFPbXc
X-Received: by 2002:a05:6402:2552:b0:640:aae4:b84e with SMTP id 4fb4d7f45d1cf-64919c200afmr7274289a12.13.1765203597600;
        Mon, 08 Dec 2025 06:19:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlwGmklZz9ErsAvsYahFym+NTtrfrXS3XeSEv/0e+lK+B3wopu8o0DAiRcNsRnntzTB46a4Q==
X-Received: by 2002:a05:6402:2552:b0:640:aae4:b84e with SMTP id 4fb4d7f45d1cf-64919c200afmr7274253a12.13.1765203597191;
        Mon, 08 Dec 2025 06:19:57 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647b368de06sm11276090a12.22.2025.12.08.06.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 06:19:56 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C3E5A3B25D7; Mon, 08 Dec 2025 15:19:55 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Kohei Enju <enjuk@amazon.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, kohei.enju@gmail.com,
 Kohei Enju <enjuk@amazon.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: cpumap: propagate underlying error
 in cpu_map_update_elem()
In-Reply-To: <20251208131449.73036-2-enjuk@amazon.com>
References: <20251208131449.73036-1-enjuk@amazon.com>
 <20251208131449.73036-2-enjuk@amazon.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 08 Dec 2025 15:19:55 +0100
Message-ID: <87o6o96ook.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kohei Enju <enjuk@amazon.com> writes:

> After commit 9216477449f3 ("bpf: cpumap: Add the possibility to attach
> an eBPF program to cpumap"), __cpu_map_entry_alloc() may fail with
> errors other than -ENOMEM, such as -EBADF or -EINVAL.
>
> However, __cpu_map_entry_alloc() returns NULL on all failures, and
> cpu_map_update_elem() unconditionally converts this NULL into -ENOMEM.
> As a result, user space always receives -ENOMEM regardless of the actual
> underlying error.
>
> Examples of unexpected behavior:
>   - Nonexistent fd  : -ENOMEM (should be -EBADF)
>   - Non-BPF fd      : -ENOMEM (should be -EINVAL)
>   - Bad attach type : -ENOMEM (should be -EINVAL)
>
> Change __cpu_map_entry_alloc() to return ERR_PTR(err) instead of NULL
> and have cpu_map_update_elem() propagate this error.
>
> Signed-off-by: Kohei Enju <enjuk@amazon.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


