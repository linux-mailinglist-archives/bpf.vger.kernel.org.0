Return-Path: <bpf+bounces-74097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1F7C48F14
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 20:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D32B4EF60F
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 19:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267C132B9A4;
	Mon, 10 Nov 2025 19:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPXeMdqw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FA532ABFF
	for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 19:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762802097; cv=none; b=VvvHLZCTW/PFwnW7vwZG5ULdj7t/Qz/1qae7fes6sBt+ICsoc6VkOaqhWbPrH59ZqEwv9Lzm8cWfk/u+QfHn6zOOFm2GHQ3bO6EmADyZ5m1CTAf4m0vUmiNNodot7PErA17Nhaf63w/Tv5wuIgw9TGZwRm6lEkjYx1Tt93lLYn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762802097; c=relaxed/simple;
	bh=6MRB32bfLN+YaSXYsFuW2dfnJyymOLIGnix+NM/beQE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HyKu0wynRsdgAl8doVrw1Iel1eF+jZ/ErlEfm+GQ1Rx2/SueOi1yhiZs6A/tvz6zVEkoVPvvrIbYtET4I44MSPFxJKTpzYAW76FvWalIWkqwT+X3iF9feVdq7Bl4LMF872lsp+7Sx4K58SU36OO2m110xuukcSxWV/WDdcv3DcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPXeMdqw; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3436a328bbbso3279080a91.2
        for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 11:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762802095; x=1763406895; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pMrPN2TGvQVB1EJnZmUXXnaHzNAMI1LyJb9hbFVK3sE=;
        b=WPXeMdqwWUh8XaWeSgEncrm1ujDD1+zM7qvO+SfjowMjETiscRFKCkruCiEgxm6W1B
         5IZcl0341SfVEAXG1Mr+IKu3FOXBn3DSt0jAriCmPo136Xgl2OD0g2u2OVcgytNG74zE
         sRSXO7xAw/xb8oM/NAIRH/upK3sXC3yVD4puuJifv317LtVe1IHjMQm2AE02OdpGN3Ke
         ToJgWQHIhf/fn1E/dbPVfYmN0NPqTGQc9x4RoXhgmFOgOcSTqzCKRGirDClkRB4MxaaX
         dYMyxcWtgh9iUzAo5gcGxWzf0EJPJ7lmrtyNVasVFXFCeYc2KcPMHhkpPQfaYlBi+wAk
         5lAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762802095; x=1763406895;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pMrPN2TGvQVB1EJnZmUXXnaHzNAMI1LyJb9hbFVK3sE=;
        b=JxpRfVn8adGpQvvyMVFGJO4vOUK96ZHaE3GtV1sN8X5X2jpOsmSH7rccWgUFVNc4ma
         WVj1blQd7HsFh8yglPicdV8FIOq8ddaUdk55jk7S53obJVT/OkXMnSpxYbX3VI46g62e
         WdCcugtC8AXpwyX+b2+VLqoaWmmRNwoUhuOl6Qf8ykdchVph+tNLMKpjeSM5pL6F8HCU
         CBHRE4wf6T65lvEwI4219N4v3EiLDZrvITuhqWBdjWlUdpvu8KiVT7rtByA13Tuq0KVM
         S3/27URIGD09b68IWLg7Z/YQ8E5efTSrpjkaMPsn8sjgP2HgG/lO5XLZbxkHMo/uCfXJ
         3MAQ==
X-Gm-Message-State: AOJu0YzFos73p/rm//49TPA+lIv1icWVQ7l20K3k6SVW0E07RQ+5misT
	zgGgJYn7TBEz6dK58e4VarUCJNdlOkOS8/kitHQ0wTv8dp3SVXG2qj1T
X-Gm-Gg: ASbGncuGeehvt8U9vUonYyCtfRdAj70DdV3TjxqU8NiTgoO/Po0Qr+ZjzweAgAGfPP0
	vwf010fRRz0mW4Deq+EY7SElp4IqlBqCCLYgjNbVJIFmlJ8YGM7z1rObpOmiTrUxtQM1AsJJXBi
	SzRTVKTrkam06bZSI2PFUWkssJwm6umEgUKh+8e/rjdRkG550fwSaGq7tJ+b0hwe+aTn/0H3XRh
	Ev5V03ph0ZNTtwCrP0oKd6jUSJTGnkTkfDAikG6S4ZPTKPBb+VeFYok6Q2CLpk2se9j+t2MuI3l
	/SJLoRl4PA1sTEdhe/xn1yLi5QEk2452qSNfNgJ+zOP1o4LREi8tUW+MwxpNOe21SR2oaGv74Az
	DA8Udyv7FvqD+Skyp5X15wXTu0jTeB+ixp1XI5Lv1cg8sVYIFIKLFLtx4xZII7BwbXYBFQVr5bZ
	l+ce0T1+KcOvuYnVv5Syd1zYAu8BkLmaR51fzoru4GqIJ1wQ==
X-Google-Smtp-Source: AGHT+IGO2rUmx9K1FUOntJWFeAOqLiJZIpLOkTyzscKV6GdHeU3F3hCaHr9qkXkN2XkIe0T2JTn6eQ==
X-Received: by 2002:a17:90b:3788:b0:343:7714:4cad with SMTP id 98e67ed59e1d1-34377144dcamr7219295a91.5.1762802095541;
        Mon, 10 Nov 2025 11:14:55 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:5ff:e0da:7503:b2a7? ([2620:10d:c090:500::7:ecb1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cd05d593sm12530992b3a.73.2025.11.10.11.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 11:14:55 -0800 (PST)
Message-ID: <67738d278b9845c4d37bffba6a36feec1e2722f8.camel@gmail.com>
Subject: Re: [PATCH] libbpf: fix BTF dedup to support recursive typedef
 definitions
From: Eduard Zingerman <eddyz87@gmail.com>
To: paulhoussel2@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, 	john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, 	jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Houssel	
 <paul.houssel@orange.com>, Martin Horth <martin.horth@telecom-sudparis.eu>,
  Ouail Derghal <ouail.derghal@imt-atlantique.fr>, Guilhem Jazeron
 <guilhem.jazeron@inria.fr>, Ludovic Paillat	 <ludovic.paillat@inria.fr>,
 Robin Theveniaut <robin.theveniaut@irit.fr>,  Tristan d'Audibert
 <tristan.daudibert@gmail.com>
Date: Mon, 10 Nov 2025 11:14:52 -0800
In-Reply-To: <20251107153408.159342-1-paulhoussel2@gmail.com>
References: <20251107153408.159342-1-paulhoussel2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-11-07 at 16:34 +0100, paulhoussel2@gmail.com wrote:

[...]

> @@ -4936,10 +4963,77 @@ static int btf_dedup_struct_types(struct btf_dedu=
p *d)
>  	return 0;
>  }
>
> +/*
> + * Deduplicate typedef types.
> + *
> + * Similar as for struct/union types, for each typedef type its type
> + * signature hash is calculated, taking into account type's name
> + * and its size, but ignoring type ID's referenced from fields,
> + * because they might not be deduped completely until after
> + * reference types deduplication phase.
> + */
> +static int btf_dedup_typedef_type(struct btf_dedup *d, __u32 type_id)
> +{

This function is effectively identical to btf_dedup_struct_type(),
the only things that differ are calls to hash and equal funcs:

	 	t =3D btf_type_by_id(d->btf, type_id);
	 	kind =3D btf_kind(t);

	-	if (kind !=3D BTF_KIND_STRUCT && kind !=3D BTF_KIND_UNION)
	+	if (kind !=3D BTF_KIND_TYPEDEF)
	 		return 0;
	-
	-	h =3D btf_hash_struct(t);
	+	h =3D btf_hash_typedef(t);
	 	for_each_dedup_cand(d, hash_entry, h) {
	 		__u32 cand_id =3D hash_entry->value;
	 		int eq;

	 		cand_type =3D btf_type_by_id(d->btf, cand_id);
	-		if (!btf_shallow_equal_struct(t, cand_type))
	+		if (!btf_equal_typedef(t, cand_type))
	 			continue;

	 		btf_dedup_clear_hypot_map(d);

I don't like coping the logic related to hypot map maintenance and
d->hypot_adjust_canon flat processing.

Instead of copy-pasting, could you please modify btf_dedup_struct_type()?
- extend the type check to allow BTF_KIND_TYPEDEF;
- replace calls to btf_hash_struct() and btf_shallow_equal_struct()
  with calls to functions that select btf_hash_struct() /
  btf_hash_typedef() etc basing on the type?

Also, could you please add tests?
See tools/testing/selftests/bpf/prog_tests/btf.c.

> +	struct btf_type *cand_type, *t;
> +	struct hashmap_entry *hash_entry;
> +	/* if we don't find equivalent type, then we are canonical */
> +	__u32 new_id =3D type_id;
> +	__u16 kind;
> +	long h;
> +
> +	if (d->map[type_id] <=3D BTF_MAX_NR_TYPES)
> +		return 0;
> +
> +	t =3D btf_type_by_id(d->btf, type_id);
> +	kind =3D btf_kind(t);
> +
> +	if (kind !=3D BTF_KIND_TYPEDEF)
> +		return 0;
> +	h =3D btf_hash_typedef(t);
> +	for_each_dedup_cand(d, hash_entry, h) {
> +		__u32 cand_id =3D hash_entry->value;
> +		int eq;
> +
> +		cand_type =3D btf_type_by_id(d->btf, cand_id);
> +		if (!btf_equal_typedef(t, cand_type))
> +			continue;
> +
> +		btf_dedup_clear_hypot_map(d);
> +		eq =3D btf_dedup_is_equiv(d, type_id, cand_id);
> +		if (eq < 0)
> +			return eq;
> +		if (!eq)
> +			continue;
> +		btf_dedup_merge_hypot_map(d);
> +		if (d->hypot_adjust_canon) /* not really equivalent */
> +			continue;
> +		new_id =3D cand_id;
> +		break;
> +	}
> +
> +	d->map[type_id] =3D new_id;
> +	if (type_id =3D=3D new_id && btf_dedup_table_add(d, h, type_id))
> +		return -ENOMEM;
> +
> +	return 0;
> +}

[...]

