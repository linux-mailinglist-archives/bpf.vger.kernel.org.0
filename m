Return-Path: <bpf+bounces-54616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3C7A6E2A6
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 19:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BC273B13B8
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 18:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C00266EFA;
	Mon, 24 Mar 2025 18:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eTq4d4+5"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEC025E44D
	for <bpf@vger.kernel.org>; Mon, 24 Mar 2025 18:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742842081; cv=none; b=ieWE+ccRTiY6X4ogYyWwk/KhSJw3OHXPvT/hg5T9tHrlzWtp6fJD/hYjcfoME77zVXd1BSE+FMJclKcWOllU0kR25O1uVX8oi9VFHWanpOqDkx2C8BbiBVU4fccZ03Yu79iZsO7lE3se9CUONnfSqnvGTAqIxyFPWXQJPd7Zsuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742842081; c=relaxed/simple;
	bh=SJR+jY4oXGaRh4qM9Zwe40KmeI20ooU5rPE0ZBXsI1Y=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=i2gtO23OaA3qGXIv4zp7tLiS4ox5sy0iVFcZsC2LsJHZXYOV+4h7GEbqT1ODjhzFtY8knpQexZFK/+JAabEf9nGJ7wkuk5Lj6LbbfKN9t2ohwQn44ZPi3s5txAnF+3pqAPOtcKV4+jyYTmnmzX6c4SS3iEjbYc3n2800MMuetn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eTq4d4+5; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742842076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c0SLEtZ5tGWErz0kViqrAyAqDn0UgtQaUTej9FZCJKg=;
	b=eTq4d4+5T7ocB3mf1CSF7n8eOBf46+6cPjcn/6arZq9CoVTNKEcLJ8LOzqAoET8I2LqDu9
	SgorcLXaWkUyNMIcPv/AZZJo13d+NLbl84FFaDdizXfu3gS9xg6XTYP2nKAnPda6bfHJ/G
	PxhCcify2aE4qtlPvTNkRInb2piYL00=
Date: Mon, 24 Mar 2025 18:47:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <458b2ae24972021b99e99c2bad19b524672b0ac0@linux.dev>
TLS-Required: No
Subject: Re: [PATCH dwarves v4 0/6] btf_encoder: emit type tags for bpf_arena
 pointers
To: "Alan Maguire" <alan.maguire@oracle.com>, dwarves@vger.kernel.org,
 bpf@vger.kernel.org
Cc: acme@kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
 mykolal@fb.com, kernel-team@meta.com
In-Reply-To: <68a594e38c00ff3dd30d0a13fb1e1de71f19954c@linux.dev>
References: <20250228194654.1022535-1-ihor.solodrai@linux.dev>
 <9c3d6c77c79bfa2175a727886ce235152054f605@linux.dev>
 <27f725da-eeda-4921-b0f1-c84b95337e17@oracle.com>
 <b1a23727-098e-473b-8282-8fb0cbf97603@oracle.com>
 <68a594e38c00ff3dd30d0a13fb1e1de71f19954c@linux.dev>
X-Migadu-Flow: FLOW_OUT

On 3/24/25 11:07 AM, Ihor Solodrai wrote:
> On 3/23/25 4:11 AM, Alan Maguire wrote:
>> [...]
>>
>> hi Ihor, I took a look at the series and merged it with latest next
>> branch; results are in
>>
>> https://web.git.kernel.org/pub/scm/devel/pahole/pahole.git/log/?h=3Dne=
xt.attributes-v4
>>
>> ...if you want to take a look.
>>
>> There are a few small things I think that it would be good to resolve
>> before landing this.
>>
>> First, when testing this with -DLIBBPF_EMBEDDED=3DOFF and a packaged
>> libbpf 1.5 - which means we wouldn't have the latest attributes-relate=
d
>> libbpf function; I saw:
>>
>>   BTF     .tmp_vmlinux1.btf.o
>> btf__add_type_attr is not available, is libbpf < 1.6?
>> error: failed to encode function 'bbr_cwnd_event': invalid proto
>> Failed to encode BTF
>>   NM      .tmp_vmlinux1.syms
>
> Hi Alan. Thanks for testing. This is my mistake, I should've checked
> for attributes feature here:
>
> @@ -731,6 +812,10 @@ static int32_t btf_encoder__add_func_proto(struct =
btf_encoder *encoder, struct f
>=20=20
>=20 	assert(ftype !=3D NULL || state !=3D NULL);
>=20=20
>=20+	if (is_kfunc_state(state) && encoder->tag_kfuncs)
> +		if (btf__add_bpf_arena_type_tags(encoder->btf, state) < 0)
> +			return -1;

Actually, I added this check in a different patch so the failure must
have happened in a different place.

In any case, the point remains that it's better to check for feature
availability (hence for API availability) in one place. Your
suggestion to add a feature check makes sense to me. Thank you.

> [...]

