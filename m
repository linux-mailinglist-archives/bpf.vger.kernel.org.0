Return-Path: <bpf+bounces-30139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AA88CB2F1
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 19:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A965282763
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 17:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F771147C95;
	Tue, 21 May 2024 17:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0w4Nmr8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381C27F48D
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 17:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716312904; cv=none; b=cZOy5XWOhnkdmhRVuC09bV236q5Y3qJ6z0dZe6V12pQ/S89NKJeHqpV2VScxxrKLXspfg7uhkrNyv+fp9CDzcchau46HhLXDblo/QfxVi6vu4acmUDDRljiiPwfaNmvquhBgj7Wd/HlVmX1i6qTtDoMCPrBU+R6kAO0HdEzjets=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716312904; c=relaxed/simple;
	bh=HiK6UvCjBYhPkhWOK3QrFfz6Mrjyj+XVGsmAXHLkSYM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YBs9GVIlnm5G5ONZH0Giyn1wM7JVRnYHqtKbNpWLNrPD5Ka6mqAQZJ8LUxohtfr2WFn283l6T8VJzWWEBvyZU8TPNWFLqvh1BzYM6NhK4iky37/aWrSstLnOVMhNSUYbWrf3SuV6ewCnXoWiCfgIFrdSNbp7VWPa0WDPOot+2Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0w4Nmr8; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f44881ad9eso567214b3a.3
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 10:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716312902; x=1716917702; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gFkGmMKwcDbDqm5Xg/Xc8RtOzUqT81LzkoGj3IaiEMk=;
        b=l0w4Nmr8tEQrTSQFOhjyxIDovxViByAvvKw0Fbhjh24Zfu4YfioZX3P3VrULv9+z9I
         9nWmE1eIjyuvf/i6wSoLafoCb2pRXjN+LjzCOH72Uf5jmFKf+E0f+SDJNrJHaeZtFRT9
         FIKECTw+YWdUkbV9oT1C8nTfzqL6WYY03u7KlUMNEnijBsAS2lqyaeQAOyVTlPcdNppf
         fVOBQPn3+9yMiabIW1ggf1d/UGP80mZJGY7bDGRRHU0r0mS0QA5B6yHEHXkPrxGHx+PX
         7OVtTE08W2GBwUvmfp6ygZKCRlW/ATNSbi1QvZRtrKbSlLDYqWAIarZYko1SoqU0kHQy
         bEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716312902; x=1716917702;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gFkGmMKwcDbDqm5Xg/Xc8RtOzUqT81LzkoGj3IaiEMk=;
        b=E5ESkbtVDregkgs2LKpXQro00EwmOXNF4pWNLrvK4Vm0d1SRSoO0Pk/NPUaQLwCccQ
         YLeK+uYZkJYp7JmbgoVNY6X3sYnMxDjaBed8tC7WxT6qLVQ7Mv7ooyEkm+g+8V+Y/yl4
         CdgU6/0+Owbt1Gzfnj738D0DmqSqc1Jeo2ZmhYfoT64U0Y7TptQN58222CKRaZDfQQb/
         lUAMi82H8OO97i2JO0zrnO7rKVivVu70ROTQLt6rOU0aMzomazD/IFOqPIAiOvfsiRF0
         oikxc7oZOGibH0bPw+6FmSkuJuNXfImQgMQratSJov8MtGVb8aCsoGsgU5lWpPQxLLSS
         7ahw==
X-Forwarded-Encrypted: i=1; AJvYcCXncP62qSF74CD+IYZtafb2MrEhnf0nz2EE6KrIxiMDuIhJfam0O2wSPGvZpGix1xHBSmzRfulessVpGtD78efDgwiR
X-Gm-Message-State: AOJu0Yz2NTAfzhjrdIHfFDf2OS1p/m/XO+xRGIiA6t2OlFxAgFGr+KNT
	mUOTQkfd7y+fyP2+6fRSHjFdC4JCQaDB2jjPjR4pvn+eqsVQH6hc
X-Google-Smtp-Source: AGHT+IF9uSbON9u8SMkBbUVjugsomJOjzB2kt25IldIqZaB9t7iaSkH+rQJABofc5FF8UOvPkHCvmQ==
X-Received: by 2002:a05:6a20:9498:b0:1a7:a3cb:7901 with SMTP id adf61e73a8af0-1afde1df659mr29364246637.61.1716312902377;
        Tue, 21 May 2024 10:35:02 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6341180dc5csm18352095a12.93.2024.05.21.10.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 10:35:01 -0700 (PDT)
Message-ID: <ef290f5f2b577ab0d232fdcaa08fe514ae26c694.camel@gmail.com>
Subject: Re: [PATCH bpf-next v6 7/9] selftests/bpf: Test kptr arrays and
 kptrs in nested struct fields.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org,  martin.lau@linux.dev, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
Cc: sinquersw@gmail.com, kuifeng@meta.com
Date: Tue, 21 May 2024 10:35:00 -0700
In-Reply-To: <20240520204018.884515-8-thinker.li@gmail.com>
References: <20240520204018.884515-1-thinker.li@gmail.com>
	 <20240520204018.884515-8-thinker.li@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-05-20 at 13:40 -0700, Kui-Feng Lee wrote:
> Make sure that BPF programs can declare global kptr arrays and kptr field=
s
> in struct types that is the type of a global variable or the type of a
> nested descendant field in a global variable.
>=20
> An array with only one element is special case, that it treats the elemen=
t
> like a non-array kptr field. Nested arrays are also tested to ensure they
> are handled properly.
>=20
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> +/* Ensure that the field->offset has been correctly advanced from one
> + * nested struct or array sub-tree to another. In the case of
> + * kptr_nested_deep, it comprises two sub-trees: ktpr_1 and kptr_2.  By
> + * calling bpf_kptr_xchg() on every single kptr in both nested sub-trees=
,
> + * the verifier should reject the program if the field->offset of any kp=
tr
> + * is incorrect.
> + *
> + * For instance, if we have 10 kptrs in a nested struct and a program th=
at
> + * accesses each kptr individually with bpf_kptr_xchg(), the compiler
> + * should emit instructions to access 10 different offsets if it works
> + * correctly. If the field->offset values of any pair of them are
> + * incorrectly the same, the number of unique offsets in btf_record for
> + * this nested struct should be less than 10. The verifier should fail t=
o
> + * discover some of the offsets emitted by the compiler.
> + *
> + * Even if the field->offset values of kptrs are not duplicated, the
> + * verifier should fail to find a btf_field for the instruction accessin=
g a
> + * kptr if the corresponding field->offset is pointing to a random
> + * incorrect offset.
> + */
> +SEC("tp_btf/task_newtask")
> +int BPF_PROG(test_global_mask_nested_deep_rcu, struct task_struct *task,=
 u64 clone_flags)

Thank you for adding this test.

[...]

