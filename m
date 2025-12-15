Return-Path: <bpf+bounces-76629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 399EECBFB94
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 21:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39EF3302C21C
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 20:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D119230F807;
	Mon, 15 Dec 2025 20:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKXXzYKS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8277C30DD09
	for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 20:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765829950; cv=none; b=FjYvXddQRUG2q5jY8sUuy+yz1fiT6pd/HWZ9l+8myWnwRvuZWTyuYcDfIA2tM8EfIOLtNU4PGZfMwdjRxZNpRnaQJ3ABN7DrKc206c0CQE6GuCJWngxLQVC+qbkMmdJ2ubZYNQeZUeLsdEfczCyYy/dBknEjEyzAwvvXz+26j7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765829950; c=relaxed/simple;
	bh=1oK+wGi+mPSmfcdVKQ2VUtm7SRiwKeQAAjR0rMtS8oo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iCy/SfZMKpsiXa5uJh+ECcQWoSqXCyzZWuvJw/oj1dQqd/ljq1Og9deJD2tsLlLouZLWRo3CsGc+M90N5r+ClZdyqNfvL/zFldiEF2i3DH1DV0CZFLbqqC7nFIqPwgmUf+zOk39lMSCbfU01QHm4h2YwG9+z216PTHj67zDyuAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKXXzYKS; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29f102b013fso46656135ad.2
        for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 12:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765829944; x=1766434744; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1oK+wGi+mPSmfcdVKQ2VUtm7SRiwKeQAAjR0rMtS8oo=;
        b=NKXXzYKSwGJKEkCJJ4wA3J6BCm5Ch9GJlx68KCnXqrJ/a5707jYA4ZHkQf98ksjmmj
         65c95izE2fztvvzdcEWeNa59tJj5GQMz8dFw9qXqGgJk31UVdkg0zJ05Lv8Af4Pu8e2D
         RmHEaIP5EFfEvyyRy2tidlP6StehVFFjFRpo5QiWHbIPfYdVetW71NIFaXGhmzQCa/RD
         jngEQBk4lIAdB17V4mm9gxHBPMk1CCEXUuyrXHeHKqFWsjcZw1ACX/fgslwyGkdPjkMu
         cS9AZw9tLffA5DYeTRk7zf9DL8yt9q35OKmpqcHsxhV1uKcTdTiD3npfqcVyUzPCMsH2
         jI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765829944; x=1766434744;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1oK+wGi+mPSmfcdVKQ2VUtm7SRiwKeQAAjR0rMtS8oo=;
        b=kUc4DYozA5pdwH2RPfzPGoLc2nXWXVLjR8dg8kTo2uVssEetAwYKBm3oB+5xZ/0g4f
         65P9SoqdLKK+M7/Txs1vR2ofYWBoTichbGZhgEzcMWS4fRJZ7xHhY17SHTAZx6DTDXRH
         grnfUSQobr1oX6KCuYeQ4+5LIefWY3N+VmR2bB9EDzMf7mSP469zzLkTFaK6sb1FAqB7
         cUiAfWfZRu/lzMX8xTYj6KQtZpf7NLl8sJn4uQNB7lCIssD62VPb7Wvsx0adIjQWUW+Y
         dedFhFZruvisS6xlpqUHXgjzylmNg5G1JPewpdLRXS+JtgwNquWnnCEqr+lyn0tfAqQg
         efdw==
X-Forwarded-Encrypted: i=1; AJvYcCUXy795WZNC1Q0EuKNqsZ5Aek9IvmLILn7dACzPsvtOEU2Qtxvy6plomXE7ITJLTaZNF+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/E0UrDq+sEBGSN5YLG3pMHwoII6RLlYHg7Kv14do71aEJu0oH
	Lf3gmHcF99ONX+a50vjk50OTkY2AzZgWu4opHE+DTW6Gt1WFQhi3NNB5
X-Gm-Gg: AY/fxX4ziQ1Ty1d5AG7WZHMPQ5Iqhl4rgzbDht5aHHMmpVUEO6pheSmjr5ZoyhDcrRd
	ZCpFNkACkDXPErizihLqCkbSWYSaxkuKJ4I3i7wctW3kKz0nIMEqKKQ4JOj1eTBcZf+HnA9vp5u
	BlCKjeRYZjV4v/VtmQ7++DzCY3Hhz3ORqL2Nw4pHfaAW96ysYE1wb3E81IKjv+XNFPBb7RJ5qN7
	Oj8DHhX0CadkY3CVmuTiiO+/+bqW1wbANLCIcDd22LfG7ofKpYl8d9M2wGr/kzDnl1Oxxjlv+xD
	BXYFN5byRFfpkeEZvqv/eyGMF8pSt5s0xXwvnPuNm5o5ib8gEDZcl1ADN6p0K8XG9uG4KiERdc9
	H6p1/pD6fF7gAL7iU5cABW2ghx/ibBYU2Kt80XxCL9Mnv/TF5tVTMQ+PPceDXIqePx4jNlsGk7+
	mrwfuRQBBw
X-Google-Smtp-Source: AGHT+IGE3NCnsFGfx0A4x4rvhzzgCg59ydtecyVvMlZBLhaoxPJXtWgATwHv5n5dMNJpLFvnjy6iFA==
X-Received: by 2002:a17:903:fa6:b0:29f:13d2:1c5e with SMTP id d9443c01a7336-29f23e4696fmr133705235ad.21.1765829943561;
        Mon, 15 Dec 2025 12:19:03 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34cce7e0b82sm9835a91.3.2025.12.15.12.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 12:19:03 -0800 (PST)
Message-ID: <0720a98e6a73ee6298d73b2c64a08f47a4337007.camel@gmail.com>
Subject: Re: [PATCH v3 2/5] bpf/verifier: do not limit maximum direct offset
 into arena map
From: Eduard Zingerman <eddyz87@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, memxor@gmail.com, yonghong.song@linux.dev
Date: Mon, 15 Dec 2025 12:19:00 -0800
In-Reply-To: <20251215161313.10120-3-emil@etsalapatis.com>
References: <20251215161313.10120-1-emil@etsalapatis.com>
	 <20251215161313.10120-3-emil@etsalapatis.com>
Content-Type: multipart/mixed; boundary="=-HguNc40IfKMAaSAJmUiu"
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-HguNc40IfKMAaSAJmUiu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-12-15 at 11:13 -0500, Emil Tsalapatis wrote:
> The verifier currently limits direct offsets into a map to 512MiB
> to avoid overflow during pointer arithmetic. However, this prevents
> arena maps from using direct addressing instructions to access data
> at the end of > 512MiB arena maps. This is necessary when moving
> arena globals to the end of the arena instead of the front.
>=20
> Refactor the verifier code to remove the offset calculation during
> direct value access calculations. This is possible because the only
> two map types that implement .map_direct_value_addr() are arrays and
> arenas, and they both do their own internal checks to ensure the
> offset is within bounds.

Nit: instruction array map also implements it (bpf_insn_array.c).

>=20
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---

I double checked implementations for all 3 map types and confirm that
the above is correct. Also, I commented out the range checks in kernel
implementations (as in the attached patch), and no tests seem to fail.
Do we need to extend selftests?

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

--=-HguNc40IfKMAaSAJmUiu
Content-Disposition: attachment; filename="disable-range-checks.patch"
Content-Type: text/x-patch; name="disable-range-checks.patch"; charset="UTF-8"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2tlcm5lbC9icGYvYXJlbmEuYyBiL2tlcm5lbC9icGYvYXJlbmEuYwppbmRl
eCAxMDc0YWM0NDU5ZjIuLmNmMzgzODhiYjA5NCAxMDA2NDQKLS0tIGEva2VybmVsL2JwZi9hcmVu
YS5jCisrKyBiL2tlcm5lbC9icGYvYXJlbmEuYwpAQCAtMzg4LDggKzM4OCwxMCBAQCBzdGF0aWMg
aW50IGFyZW5hX21hcF9kaXJlY3RfdmFsdWVfYWRkcihjb25zdCBzdHJ1Y3QgYnBmX21hcCAqbWFw
LCB1NjQgKmltbSwgdTMyCiB7CiAJc3RydWN0IGJwZl9hcmVuYSAqYXJlbmEgPSBjb250YWluZXJf
b2YobWFwLCBzdHJ1Y3QgYnBmX2FyZW5hLCBtYXApOwogCi0JaWYgKCh1NjQpb2ZmID4gYXJlbmEt
PnVzZXJfdm1fZW5kIC0gYXJlbmEtPnVzZXJfdm1fc3RhcnQpCi0JCXJldHVybiAtRVJBTkdFOwor
CS8qCisJICogaWYgKCh1NjQpb2ZmID4gYXJlbmEtPnVzZXJfdm1fZW5kIC0gYXJlbmEtPnVzZXJf
dm1fc3RhcnQpCisJICogCXJldHVybiAtRVJBTkdFOworCSAqLwogCSppbW0gPSAodW5zaWduZWQg
bG9uZylhcmVuYS0+dXNlcl92bV9zdGFydDsKIAlyZXR1cm4gMDsKIH0KZGlmZiAtLWdpdCBhL2tl
cm5lbC9icGYvYXJyYXltYXAuYyBiL2tlcm5lbC9icGYvYXJyYXltYXAuYwppbmRleCAxZWViMzFj
NWIzMTcuLmUxM2M1OGYyZTNiOCAxMDA2NDQKLS0tIGEva2VybmVsL2JwZi9hcnJheW1hcC5jCisr
KyBiL2tlcm5lbC9icGYvYXJyYXltYXAuYwpAQCAtMTkzLDggKzE5MywxMCBAQCBzdGF0aWMgaW50
IGFycmF5X21hcF9kaXJlY3RfdmFsdWVfYWRkcihjb25zdCBzdHJ1Y3QgYnBmX21hcCAqbWFwLCB1
NjQgKmltbSwKIAogCWlmIChtYXAtPm1heF9lbnRyaWVzICE9IDEpCiAJCXJldHVybiAtRU5PVFNV
UFA7Ci0JaWYgKG9mZiA+PSBtYXAtPnZhbHVlX3NpemUpCi0JCXJldHVybiAtRUlOVkFMOworCS8q
CisJICogaWYgKG9mZiA+PSBtYXAtPnZhbHVlX3NpemUpCisJICogCXJldHVybiAtRUlOVkFMOwor
CSAqLwogCiAJKmltbSA9ICh1bnNpZ25lZCBsb25nKWFycmF5LT52YWx1ZTsKIAlyZXR1cm4gMDsK
ZGlmZiAtLWdpdCBhL2tlcm5lbC9icGYvYnBmX2luc25fYXJyYXkuYyBiL2tlcm5lbC9icGYvYnBm
X2luc25fYXJyYXkuYwppbmRleCBjOTY2MzBjYjc1YmYuLmFhNGI3MTM2NTU0MSAxMDA2NDQKLS0t
IGEva2VybmVsL2JwZi9icGZfaW5zbl9hcnJheS5jCisrKyBiL2tlcm5lbC9icGYvYnBmX2luc25f
YXJyYXkuYwpAQCAtMTIxLDkgKzEyMSwxMSBAQCBzdGF0aWMgaW50IGluc25fYXJyYXlfbWFwX2Rp
cmVjdF92YWx1ZV9hZGRyKGNvbnN0IHN0cnVjdCBicGZfbWFwICptYXAsIHU2NCAqaW1tLAogewog
CXN0cnVjdCBicGZfaW5zbl9hcnJheSAqaW5zbl9hcnJheSA9IGNhc3RfaW5zbl9hcnJheShtYXAp
OwogCi0JaWYgKChvZmYgJSBzaXplb2YobG9uZykpICE9IDAgfHwKLQkgICAgKG9mZiAvIHNpemVv
Zihsb25nKSkgPj0gbWFwLT5tYXhfZW50cmllcykKLQkJcmV0dXJuIC1FSU5WQUw7CisJLyoKKwkg
KiBpZiAoKG9mZiAlIHNpemVvZihsb25nKSkgIT0gMCB8fAorCSAqICAgICAob2ZmIC8gc2l6ZW9m
KGxvbmcpKSA+PSBtYXAtPm1heF9lbnRyaWVzKQorCSAqIAlyZXR1cm4gLUVJTlZBTDsKKwkgKi8K
IAogCS8qIGZyb20gQlBGJ3MgcG9pbnQgb2YgdmlldywgdGhpcyBtYXAgaXMgYSBqdW1wIHRhYmxl
ICovCiAJKmltbSA9ICh1bnNpZ25lZCBsb25nKWluc25fYXJyYXktPmlwcyArIG9mZjsK


--=-HguNc40IfKMAaSAJmUiu--

