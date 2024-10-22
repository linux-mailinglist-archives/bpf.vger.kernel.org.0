Return-Path: <bpf+bounces-42769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 426729A9F2D
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 11:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FC2C1C24869
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 09:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3C619ABC4;
	Tue, 22 Oct 2024 09:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c0ccslYX"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED78D199229
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 09:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729590597; cv=none; b=o8qQ71h+ItkKfiXrDNYLbyWE03+Fczcy9D/T19HjnFosql28Vz9blHMLtucODSVNxsuzaXSvGPecgJA9GfjPuUfgmQO1dRWRTlempToBAAhqADcpJUp1dEOyexK+FUwANxYrd8cNJeqDd0QrcyrU5T0CbBceoBIivSt0J7xwdo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729590597; c=relaxed/simple;
	bh=FHDMCQSj4bOSnFGm64uWhd8NfaqRwIffME40ECj3VBk=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C2YjWjLixHIe4aXQhH+m5au1RZwvoAHdlQDafhmMxoJ/qqOXt4XTtlLQx58F9Cy9uCuk4uOkGUeJrvm6+2roHwftQwABIMC/jDulLgpsqxXIrYIgA5KLZUNf/vR4dqHfiZJvdgtDBRlCk6ufDveiAchb7eOf36nzEDYNTgMJAko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c0ccslYX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729590594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FHDMCQSj4bOSnFGm64uWhd8NfaqRwIffME40ECj3VBk=;
	b=c0ccslYXT1Jvr5bfvIpZnLGgoYJXQt8jyPMqYh/lOVn9mdHEp9iAR0diAnVPYqR+TNq+Nf
	XyAhSrHk5BMwI9Mbkt0NMHTZyo/dX5j4AFfFM+L8igqIm2LwM3BR+iL9weRObJ4/05/Xi1
	a5MwUBsH6c0QpY1qHdlhnYY4tPy+4Js=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-wIgBj869O12zip5HvlGYdQ-1; Tue, 22 Oct 2024 05:49:53 -0400
X-MC-Unique: wIgBj869O12zip5HvlGYdQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d49887a2cso3010376f8f.0
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 02:49:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729590592; x=1730195392;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:to:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FHDMCQSj4bOSnFGm64uWhd8NfaqRwIffME40ECj3VBk=;
        b=TzceNCeH6CYSLHBaivK1LmYHxLMBYosfyPsbY1fcOrrM1ISoeqrSun8AHs0XXgkzb/
         djXRxFvGPfl5ohJ5x/r46UzLlBpsrWaR52aLHy1JwRYg1Uhdba3Hlw/4GkTFk4xGIjVU
         jpLPO+C/rUtyvLgllkiwpeVNDWjnyPqR+KUuNSNeThQL3kxzSot/N15NVKUpkS9+Dn0N
         DFr7yZo8Uwz6lxOu3M+d2iIdfnJDDhEl5jOWUBvvBHDcESUgGz4otWghrm1e9rQYhLj5
         BkdQnuDkgTvCAttsw7O0VdfTZaq0MPsb/0573R4BxEZHKyEglPq2mcv5TsFWqePbWe/M
         iIQA==
X-Forwarded-Encrypted: i=1; AJvYcCVyfPgdT0joI8FqzoNFisGulbfZQnTUYKcwQCy1dJTYnWrWMT9mZ0BaPykc/ParC4ev9eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqZ6YlWBqJT+AVqBGhDGEZeyPFrhC4RhlIYQXOXrPcroYifeYP
	3EhCVE+ZwepSWL4kfNigkcx+xPYGuC7uDuMnVftLAcB0vQkE9Mgpkp6o7OLNGHxBwi8zm1TrAcL
	bMMjLQUHUx29u5hNCBE1MYnPCoHt+0fmGZBc8QSaDNk32hcoteQ==
X-Received: by 2002:adf:b186:0:b0:376:dbb5:10c2 with SMTP id ffacd0b85a97d-37ef13cd752mr1751558f8f.29.1729590592129;
        Tue, 22 Oct 2024 02:49:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIEHKao3U/XFI7bzq9Kj6t6RyZxy0cnLw5nrYDT+Cbr6tQg8AZS6TySYFQBcdNzKRVWndUxQ==
X-Received: by 2002:adf:b186:0:b0:376:dbb5:10c2 with SMTP id ffacd0b85a97d-37ef13cd752mr1751544f8f.29.1729590591777;
        Tue, 22 Oct 2024 02:49:51 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9bcc8sm6205364f8f.107.2024.10.22.02.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 02:49:51 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 84B08160B2CF; Tue, 22 Oct 2024 11:49:50 +0200 (CEST)
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
Subject: Re: [PATCH bpf-next 1/5] net: checksum: move from32to16() to
 generic header
In-Reply-To: <20241021122112.101513-2-puranjay@kernel.org>
References: <20241021122112.101513-1-puranjay@kernel.org>
 <20241021122112.101513-2-puranjay@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 22 Oct 2024 11:49:50 +0200
Message-ID: <877ca0ii0x.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Puranjay Mohan <puranjay@kernel.org> writes:

> from32to16() is used by lib/checksum.c and also by
> arch/parisc/lib/checksum.c. The next patch will use it in the
> bpf_csum_diff helper.
>
> Move from32to16() to the include/net/checksum.h as csum_from32to16() and
> remove other implementations.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


