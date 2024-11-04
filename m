Return-Path: <bpf+bounces-43888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A62B89BB704
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 15:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B47A2847E8
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 14:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C6B3BBD8;
	Mon,  4 Nov 2024 14:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JUNybWjU"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EDC79FD
	for <bpf@vger.kernel.org>; Mon,  4 Nov 2024 14:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730729018; cv=none; b=WlUYlTOK/TJhwcQ8IOn4i7sO6L828CiyI/AcCjpuZQy89DkpuMIYccWs1jDq7bQhafDGRgudjARFduTe/SYWOBMvdhOlKQmrQyC/eQcYLlSfPjNzR3qJt7mRULgH9KO50ap7m3j+ZDvNEZBJqkxQbQvPeDWhoqGVy+/YcSkiJ7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730729018; c=relaxed/simple;
	bh=Ks5J7cFIz2cMLMUfxa8tcYfUV+3L66EBjoWe/OsTFuU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TmoLeVeODKBBMddcjoGlTMhSFQz0dWuJGNoQ/WrXm+GC7A0tbWag/47cdxm1L0jwW0IXDrVgE+xKxzZVPrL3mwnlu4V+9P3QUy1gIDxrv9anzkGrjQTKJTFuUbpYdm6o1bHVOn+9gog2hcrVJWW7frIEkZy1PSmkvcCrxBFtnPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JUNybWjU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730729015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=12+ga6wRawOd+6+IWg0SS3StwWYwyR7C2V6nx8pvkP0=;
	b=JUNybWjUnf7SsnfFyN+yFUDJNaMOvHQxABp9gc41yZRgOeSceeE00F3j7g82/nY19Ypcw0
	x2u6+m9sTkITaYO8C8L6WDdXSIhvNfQSnyKCbZjzKy4kYx6mu16bWSJNlRvlY3ozEkjp9m
	u1tSzftjKkTOvn1Q78h8uYANYA0CtkM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-1shlKOWFMwmW2pYKZwHf-g-1; Mon, 04 Nov 2024 09:03:34 -0500
X-MC-Unique: 1shlKOWFMwmW2pYKZwHf-g-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d5116f0a6so2109768f8f.0
        for <bpf@vger.kernel.org>; Mon, 04 Nov 2024 06:03:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730729013; x=1731333813;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12+ga6wRawOd+6+IWg0SS3StwWYwyR7C2V6nx8pvkP0=;
        b=umqrnYEAr1S41eI6kCWa9iMRz5+wQdJR9WWli/b59zIEi0RucYKShf4G0QHqFSeRyr
         voj7eMlzKEZxaz5xaOhjtYqLOaS4hliPzqYWRm6ZEffiwJPS6BGySf+tG27MJeoPS7GF
         +aZZTU8sTw95qB0GF9MPG0YsHJxpojwKsxB66o610DthO7LlohqB4gz/IJ6M0/OC61N3
         ZvVRBmuaTpnr1aZkv6utOz1MYIZZCdgzERYCXK+l5x7wchYI25Zj9/JR9Z1Gl5vbfhio
         3Q1qh6q1BHnQ/QwGoMpYYBTv2rctck8vLWBQAfVWHTVYVyxVSjw1abgs8DeY0DslzQkE
         IVRg==
X-Forwarded-Encrypted: i=1; AJvYcCU9pz2NrF9W5+Ni2inH2XPSAIe5ktN8+9htx21AbvQItEIet1J7V8WN2j3SWAVp5tClOc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV8XV2NaE0J8EyuKePsSfDTXhDxAw61c87VwFC8q9yh9WsFqUi
	ngMDH4iJB6hLlVyViPKJDBfwV/LTnh1FwLC41ovvgfZ2GCft0K9xVuwRfaCfxaFB+J6cSPdUX8k
	9QzxbNeO43FX4n45bs/+PQu18NY4Fh4YmHCZFYVYeSwqkHk1WQA==
X-Received: by 2002:a05:6000:2c5:b0:374:b9d7:5120 with SMTP id ffacd0b85a97d-381c7a5e4e3mr10266798f8f.23.1730729012716;
        Mon, 04 Nov 2024 06:03:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFb0/alfcRcfiPFgOYkftEx9l5iJbC0C5W4aFGDDz4mxctDNEsUa44VFQ0h2S3YnAgOQ8WQ+g==
X-Received: by 2002:a05:6000:2c5:b0:374:b9d7:5120 with SMTP id ffacd0b85a97d-381c7a5e4e3mr10266730f8f.23.1730729011869;
        Mon, 04 Nov 2024 06:03:31 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e068sm13216213f8f.71.2024.11.04.06.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 06:03:30 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id A79AD164C03B; Mon, 04 Nov 2024 15:03:29 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH bpf-next v3 1/3] selftests/bpf: Allow building with
 extra flags
In-Reply-To: <6cb7d34d0ff257deaf5bb818ac4bce3c95994d29.1730449390.git.vmalik@redhat.com>
References: <cover.1730449390.git.vmalik@redhat.com>
 <6cb7d34d0ff257deaf5bb818ac4bce3c95994d29.1730449390.git.vmalik@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 04 Nov 2024 15:03:29 +0100
Message-ID: <877c9j9jv2.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Viktor Malik <vmalik@redhat.com> writes:

> In order to specify extra compilation or linking flags to BPF selftests,
> it is possible to set EXTRA_CFLAGS and EXTRA_LDFLAGS from the command
> line. The problem is that they are not propagated to sub-make calls
> (runqslower, bpftool, libbpf) and in the better case are not applied, in
> the worse case cause the entire build fail.
>
> Propagate EXTRA_CFLAGS and EXTRA_LDFLAGS to the sub-makes.
>
> This, for instance, allows to build selftests as PIE with
>
>     $ make EXTRA_CFLAGS=3D'-fPIE' EXTRA_LDFLAGS=3D'-pie'
>
> Without this change, the command would fail because libbpf.a would not
> be built with -fPIE and other PIE binaries would not link against it.
>
> The only problem is that we have to explicitly provide empty
> EXTRA_CFLAGS=3D'' and EXTRA_LDFLAGS=3D'' to the builds of kernel modules =
as
> we don't want to build modules with flags used for userspace (the above
> example would fail as kernel doesn't support PIE).
>
> Signed-off-by: Viktor Malik <vmalik@redhat.com>

That last bit is a bit ugly, but I couldn't think of a better way of
doing it, so with that:

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


