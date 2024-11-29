Return-Path: <bpf+bounces-45867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9459DC314
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 12:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60EA4163ABF
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 11:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001D5158A09;
	Fri, 29 Nov 2024 11:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hT7YvaYD"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA69819A28D
	for <bpf@vger.kernel.org>; Fri, 29 Nov 2024 11:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732880720; cv=none; b=f5khViiqN1o6S8thH3n8xrcp8ssTlk9DvckhN6crO5mIfGUR2PVF3WklJS9deg8m0SmC0uVH5kwicsGy6vwp3rUzHFUDfCXolKKgGyZ/7LWVaSqkOL0dHj+4GG9KRGEtR8pp8jmwW4a4ug00uiyvD0uc98k2HSh9IVHhy+JsEf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732880720; c=relaxed/simple;
	bh=ABYjhwN7BHJUWZ4KqQa58izg2zdT8EnMgwYZwgL7M4c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XXg6KDpg7fIlIlN2uQgLSDuvrPtEilnmO9zPcSJ9MsNrNa6i1ELuyhSJ6PZHFyBpODv/FH7aMWlfX+24NFJumWCxcWrSeJR1OR5YB5SAoVHE2eqXPIlneH4Mycw85A99Y9lXfzctJ3HIDH4CJ4Bn8pJp/9wOKPsiPB0iiH7CB6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hT7YvaYD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732880715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ABYjhwN7BHJUWZ4KqQa58izg2zdT8EnMgwYZwgL7M4c=;
	b=hT7YvaYDTIpf0Gx7Kcws69wF1iDv7uN0JqHnmodMdh8YqbngtJ3QMCqMUQ7t4SgHdD0gQ8
	G+9PzV2rNsG8+lcpWyC+lslkUBg1Fj/LdP3sRxlyqsUpEdJk2oJqFfMRKgif9derkDAASy
	IXyRhbVGsfIekfYoFgEv8T6YCAVwbkg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-tw6-HNmePUOf9ybbweg78w-1; Fri, 29 Nov 2024 06:45:14 -0500
X-MC-Unique: tw6-HNmePUOf9ybbweg78w-1
X-Mimecast-MFC-AGG-ID: tw6-HNmePUOf9ybbweg78w
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5cfc26d02e6so2805605a12.0
        for <bpf@vger.kernel.org>; Fri, 29 Nov 2024 03:45:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732880713; x=1733485513;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ABYjhwN7BHJUWZ4KqQa58izg2zdT8EnMgwYZwgL7M4c=;
        b=sD5gbJ57ApzSnp8fmcY7oJh8tJJ0Rbru4Cft1CqRUrUTTGWWOqp9WzoqQmpk15D0dU
         8hcIpp2YReLHoxtMtIm1HWPsn4p+P1RGvQeu5fw0axVToMedMsjvgE/ihOUZRfYrXjMI
         1ZPKCKz988M0RlkSmg2LezHmsBLPVVJWgx0zg6Ou990tQbHW9DArnofL0k/k2YhlKOXi
         kijFfv7bl6jjHtR9ASsA6Rtx6gr2gwGdMi6kDkFyeN1u/hPmhJP9CwyKckquQR6Vcy5p
         KXDqDXueyXvnbISorhFJlYHyU5kHDWeLlNYYA2adt08NDVhlyf2uV9sknEe17mn2LpzS
         irJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXa8Zyw1XFCXEncCh2T2fKpSj2xWETrCiFr4SGHCGQahr7gmKLj077BNrs3WVH78NJ6W5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrdYYp+2fgtwSEbzNkpRdYzkINDBXNHECsffxlYFHlWvEd07SQ
	knxyYE/wa+HwclVvGc29zslqsRFNu/zJ1YX51pbvtlRNCneF2EKMNW4JNMvTA1oT9zaBIeIpIRd
	Yp9oy/EQaCCfl+jiCYCVxzpyb/EKZIfkpPg+N+hJXxXWG2qtceA==
X-Gm-Gg: ASbGncvWt19S42PetOKPfxofbE6Pd+5s3yhMXkquARsP5x1UPo7jqxLRi06aYsXl8Wn
	YVdbRl7GpYnrnctx2attL2NA0VOPqu/Z44XeFByoTU27Fa2NiLX1kWNCynt9LSVWt0vL7qVh8Cs
	3Fg74CyEQGEDCVtJbXpw+U5382QbgUDn2Oez1qdvAY/qX9JJQ6629ym+3TrNCNcJdhCN2uBgFe8
	wxhaam3faf5ggbMVsgvJohkIAdZAmYSZLh7QH52GbVhOvg=
X-Received: by 2002:a17:906:794c:b0:a9e:c440:2c9f with SMTP id a640c23a62f3a-aa594709494mr777786066b.19.1732880713163;
        Fri, 29 Nov 2024 03:45:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHafFtIh6h6bcrCQemnJaslLKz5bYS/l4CpLUAmC8TStXur9m29l9cRn7Y6i6rYYEQhWBPgYQ==
X-Received: by 2002:a17:906:794c:b0:a9e:c440:2c9f with SMTP id a640c23a62f3a-aa594709494mr777783766b.19.1732880712800;
        Fri, 29 Nov 2024 03:45:12 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996c2471sm165294166b.13.2024.11.29.03.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 03:45:12 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4E5CB164E385; Fri, 29 Nov 2024 12:45:11 +0100 (CET)
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
Subject: Re: [PATCH bpf v2 4/9] bpf: Handle in-place update for full LPM
 trie correctly
In-Reply-To: <20241127004641.1118269-5-houtao@huaweicloud.com>
References: <20241127004641.1118269-1-houtao@huaweicloud.com>
 <20241127004641.1118269-5-houtao@huaweicloud.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 29 Nov 2024 12:45:11 +0100
Message-ID: <87ldx2i7qw.fsf@toke.dk>
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
> When a LPM trie is full, in-place updates of existing elements
> incorrectly return -ENOSPC.
>
> Fix this by deferring the check of trie->n_entries. For new insertions,
> n_entries must not exceed max_entries. However, in-place updates are
> allowed even when the trie is full.
>
> Fixes: b95a5c4db09b ("bpf: add a longest prefix match trie map implementa=
tion")
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


