Return-Path: <bpf+bounces-58681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFE2ABFE90
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 22:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F4C4173A79
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 20:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3646529B20A;
	Wed, 21 May 2025 20:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OaNJt22U"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4D01A5B86
	for <bpf@vger.kernel.org>; Wed, 21 May 2025 20:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747861105; cv=none; b=r3hWFwpy9bqSODEmF/FUAPVKpG6YfzKVY1YlUO6Q+x2hb+XjdbSNNNAWIbUBq7O1OH4mk3/itGQWhcLx0r+QesC7ox63oVBClKJGt04Cl3teXFkK7ihv3BuNsFeNFDuWOnHH66LdT0fQ3ONaBGKrBCRSVvKOm8KEdC67JcjPeoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747861105; c=relaxed/simple;
	bh=Kg/1WuXJ2k9eUfUf1W7gNoHW3XbfKIIKDhATt8mo+Gw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jF4J3KPVSY/IgdOiIik8wLoXoLQXC3e05BZ1sibv+QjuxJOtMiBFQC4foqZXX9WgdqEbOCKR5JOtwLYapWCqi0IfMcBrPy80JJjs1SG2+5Ml8uxUaapXXQMpT6P/SelLQm/BGe9x4brm/O3oN+HRJoeH6r6beMCbZ/jsG9PI3PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OaNJt22U; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso7119864b3a.2
        for <bpf@vger.kernel.org>; Wed, 21 May 2025 13:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747861102; x=1748465902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kg/1WuXJ2k9eUfUf1W7gNoHW3XbfKIIKDhATt8mo+Gw=;
        b=OaNJt22UXDUBTga0S/lTdvxzb4C6JNk0IUc4CPWOXGABvT4irPEX/9YdIp4kLG5T/I
         ZVB5GPcoKbBJ8BqnT5jOmchC2B3fyEiTfqAitKwhvzYvB8ButkrM5vPN6Np42kduM+2t
         zwwdv2ZJy4Of6KSofVSVdHfpeeAEuYRrtA3VaOwYtoZ93o9sSQIczgH7MQ1A7mjsITRZ
         lk9Ir5CHxFGQ6bfA/yUu9J65/5myF2YeW3VlWAE85di2w8NnJcnBi5c1euBqH7TNwPR+
         /czL3RMBBghbnJ2dBLJRsOvs5/5ZHFn48LhCf/7RAGpvlkt7c7oto8oV0+gX3CkCPlgg
         T0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747861102; x=1748465902;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kg/1WuXJ2k9eUfUf1W7gNoHW3XbfKIIKDhATt8mo+Gw=;
        b=O1pUbAC/Xwo8d+ao4utGB/RzV9FvsfzkIYM2pqZXT7HeOK6rJf3z/q1p/HOaPGGwUT
         8dZUf7U6ICjYw4C0P8rZbBb1jcyBuVWSkIgknOazTXPw1do8lXwAECPaQrCVYL9xQXeZ
         8NXTaH4N8yV37DfPu2xGMdu9qc6+IGs+0hNJxfdZfE4caO/kTzMWwqHJuL+Vd2LjWn+T
         vvY1s+tkFLLU0FhlCIhZuE4aDVIXeSZENgeOAY96k3PpQudT1R+4dCSYY858n+IMWwzx
         Fa2qrd2BLRJNcJ/vAB/N5cdNN5bCvHIfYN638uDqeXQXOCS6Vog7WvUrzZGWIcvKoCWh
         ltog==
X-Gm-Message-State: AOJu0Yzo+M2C0+kgX+TsTO8JEnNrSxf0DEc49Z69B0AQHSyzGhjQgr/d
	qMtQwV/wB6vViUhbPu8m/j8i33mP7p7WVuaiI3hD9gqaUlnpwLd+ygVZ
X-Gm-Gg: ASbGncsMUbAuB8dYb4SAELgQgxV9kqhKKqoMC0P3aYQRRa8EQdv3twc6uYIGrsQEOu+
	U1SD45+uwir3I/uWo17GtMZ+9MO4/FdQfbbeBEwPqALJD0kD8WWVIbeRqsdUH2cUTFnW6seDAB9
	m0nimTKHwJWN0ICwbXPLIT/opQZMnHcntVJAAv2uXrqAYwGVVljeQJ23VbqAjMW+LtKM3f13rLi
	SpacUY5y6yIKjNM5kzdEHPhOWsDKhO1VosDvNrJktCBsWs2N2/VJOteBKi/oNGFJfGYFf/gJaDk
	QWJhRfNNErX2fcKqhFIDxAuWNlsoav918UH9b2b+7F7KrweOSP9ubNE=
X-Google-Smtp-Source: AGHT+IF+sHpgF1QLN62rocyZlhJhUmbD7UeoaR8COLEFd0VLG6SGeAVSqY7RbnBJPyaJPG+d5TztDg==
X-Received: by 2002:a05:6a00:3921:b0:736:34ca:dee2 with SMTP id d2e1a72fcca58-742a97740damr30563344b3a.4.1747861102519;
        Wed, 21 May 2025 13:58:22 -0700 (PDT)
Received: from ezingerman-mba ([2620:10d:c090:500::6:8d1a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a97395basm10069592b3a.76.2025.05.21.13.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 13:58:22 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  kernel-team@fb.com,  Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Do not include stack ptr register
 in precision backtracking bookkeeping
In-Reply-To: <2c0fa9ee-f9dd-4cde-b4fb-6f28ebefc619@linux.dev> (Yonghong Song's
	message of "Wed, 21 May 2025 13:34:50 -0700")
References: <20250521170409.2772304-1-yonghong.song@linux.dev>
	<45e399c6-74ad-4e58-bfda-06b392d1d28d@gmail.com>
	<2c0fa9ee-f9dd-4cde-b4fb-6f28ebefc619@linux.dev>
Date: Wed, 21 May 2025 13:58:20 -0700
Message-ID: <m2ikltd6kz.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yonghong Song <yonghong.song@linux.dev> writes:

[...]

>>> @@ -16397,6 +16423,29 @@ static void sync_linked_regs(struct
>>> bpf_verifier_state *vstate, struct bpf_reg_s
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 }
>>> =C2=A0 +static int push_cond_jmp_history(struct bpf_verifier_env *env,
>>> struct bpf_verifier_state *state,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct bpf_reg_state *dst_reg, struct
>>> bpf_reg_state *src_reg,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 linked_regs)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 bool dreg_stack_ptr, sreg_stack_ptr;
>>> +=C2=A0=C2=A0=C2=A0 int insn_flags;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!src_reg) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (linked_regs)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn push_insn_history(env, state, 0, linked_regs);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> +=C2=A0=C2=A0=C2=A0 }
>>
>> Nit: this 'if' is not needed, src_reg is always set (it might point
>> to a fake register,
>> =C2=A0=C2=A0=C2=A0=C2=A0 but in that case it is a scalar without id).
>>
> Here, there is a bug here. Thanks for pointing this out. I need to check
> BPF_SRC(insn->code) !=3D BPF_X instead of "!src_reg". Basically passing o=
ne
> more parameter (e.g., faked_sreg) to decide whether src_reg is faked or n=
ot.

I don't think any checks are needed.
Fake register is always scalar and it cannot be collected as a linked regis=
ter.
So it won't end up in the instruction history flags.

[...]

