Return-Path: <bpf+bounces-42771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 966E39A9F4D
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 11:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C01451C25275
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 09:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A960119A281;
	Tue, 22 Oct 2024 09:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BwT0qqj4"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0C3178388
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 09:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729590939; cv=none; b=acOsoYW1DjDwPBRjIN4GcraT6sY5OXAKWdxz3w1biQG34XQAM6Fjw8Jwk6yPcsA5tkAQN25Qa3duVAvx/5buCGUSgLXNwPnyZHK8eZ4d2QAp5s5SsxoA0KOM0pZGrUVYjVI22e+HC/jMX7PKLnDz2bhMuw70UxOWL6pWbxfa/IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729590939; c=relaxed/simple;
	bh=ib0DWrahXU+UyLhjJUyjqhEX8gbxfkcMrsQFOh4hUoo=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TJWoPauA+O3nhXW0ymEv/FXghPD1NpN1kEn8IDTkvM1CUxD48dm7B7QlEIHwh7jBQtRLqFCRLleBH7iasqHhUK8OgmlfOy75JKsLeH8KIWfQimLuDqniWyaWQOWyYWypKvN2CJD9OGEuwoAjS7tVqRVs7bF+Uimvmza2JljLkkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BwT0qqj4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729590937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ib0DWrahXU+UyLhjJUyjqhEX8gbxfkcMrsQFOh4hUoo=;
	b=BwT0qqj4h3ayzKMT9Hlc1VeMUPeYxYD6d3MszdsbJCdGYOszDyySNuTCAaiNSMsvM3lb0n
	Epm6CXVzI17eqRh+M/5Qgb01/JTBTl17JDpo58THaaKyqSjhp4j5/+ESiHEYdFBskFpR/I
	4txmhssaD8uM8ypERdJgk1B/KLxq/rE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-71t5SjOtMjSIxrxEGocfDA-1; Tue, 22 Oct 2024 05:55:34 -0400
X-MC-Unique: 71t5SjOtMjSIxrxEGocfDA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4315b7b0c16so39723375e9.1
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 02:55:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729590933; x=1730195733;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:to:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ib0DWrahXU+UyLhjJUyjqhEX8gbxfkcMrsQFOh4hUoo=;
        b=vET+vgcL9DnAt/yyxHsJ25Kw2OUZi+zMOSGI7ZtoZqZVTwJ2dy4/+u4SU5qptbvp60
         OVoy7TWb57VnBPGcjVfbbYEfMbocISLlVb6aUSvsySpGYObb0hAbp7THppePRCCLC36v
         LwsVHqm/42WFqmLPK3TgjP44oYmMp/5NdwtFKb7PpFvt6OvpX86oekl3vuhl1kzrUTlG
         CVJfnnO47bhk2Nf+KsBRh2Xd55nakQQyu2pBft196Q4Bchya9JgHomLZKOlSPAYpcaWD
         z1+HBdFhtwn0jAjQjrGwJjiCD2Wouas/8f2pk12Cd4xyJPI27nrIW409RZU4SCMQ3Dya
         +rxw==
X-Forwarded-Encrypted: i=1; AJvYcCWmKTftEqMXZ4eJ0xoSg4vGYKfRx8jaPkhYC5+dz3qYwagfwNbnM7UZTNQUHrAgpdb9hbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGcGRo6JVLCtzTEjNuGsMaQxCeBU+mFrImz7in5VaRXMhvpjtl
	9OYZ2SJ7HsB5xef0YtGHqqNoDJ9L7iyCHWR9ytSJhko2pkPsDjwstwjp0vfxI/tNHyqUt/2RSBV
	GMM/ufF8UZ3n8b9/+OTOwTaKsvsnzqm53opxU/QMNnH5zRbJdWw==
X-Received: by 2002:a05:600c:5124:b0:431:40ca:ce44 with SMTP id 5b1f17b1804b1-43161691682mr122114305e9.30.1729590933376;
        Tue, 22 Oct 2024 02:55:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgyq6n+8jcts2tjTo5SADW9rqMjfT6xN3E7y9DOoeJqaiyEJ0e6Yke+AVbsNQve6hNbgctXw==
X-Received: by 2002:a05:600c:5124:b0:431:40ca:ce44 with SMTP id 5b1f17b1804b1-43161691682mr122113835e9.30.1729590932884;
        Tue, 22 Oct 2024 02:55:32 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b93ea6sm6296161f8f.84.2024.10.22.02.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 02:55:32 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id DAE67160B2D3; Tue, 22 Oct 2024 11:55:31 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Puranjay Mohan <puranjay@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexei Starovoitov <ast@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, "David S.
 Miller" <davem@davemloft.net>, Eduard Zingerman <eddyz87@gmail.com>, Eric
 Dumazet <edumazet@google.com>, Hao Luo <haoluo@google.com>, Helge Deller
 <deller@gmx.de>, Jakub Kicinski <kuba@kernel.org>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-riscv@lists.infradead.org, Martin KaFai Lau <martin.lau@linux.dev>,
 Mykola Lysenko <mykolal@fb.com>, netdev@vger.kernel.org, Palmer Dabbelt
 <palmer@dabbelt.com>, Paolo Abeni <pabeni@redhat.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Puranjay Mohan <puranjay12@gmail.com>,
 Puranjay Mohan <puranjay@kernel.org>, Shuah Khan <shuah@kernel.org>, Song
 Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Yonghong Song
 <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 3/5] selftests/bpf: don't mask result of
 bpf_csum_diff() in test_verifier
In-Reply-To: <20241021122112.101513-4-puranjay@kernel.org>
References: <20241021122112.101513-1-puranjay@kernel.org>
 <20241021122112.101513-4-puranjay@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 22 Oct 2024 11:55:31 +0200
Message-ID: <871q08ihrg.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Puranjay Mohan <puranjay@kernel.org> writes:

> The bpf_csum_diff() helper has been fixed to return a 16-bit value for
> all archs, so now we don't need to mask the result.
>
> This commit is basically reverting the below:
>
> commit 6185266c5a85 ("selftests/bpf: Mask bpf_csum_diff() return value
> to 16 bits in test_verifier")
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


