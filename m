Return-Path: <bpf+bounces-18784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF50382213B
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 19:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C03E282ED4
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 18:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF1015ACF;
	Tue,  2 Jan 2024 18:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKxG9jEP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2132415AC3
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 18:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a235eb41251so1087488666b.3
        for <bpf@vger.kernel.org>; Tue, 02 Jan 2024 10:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704220917; x=1704825717; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IDlo3e01UfJzc/OgV+7yfmsbQsJLiO7IOV7UvfVvAyo=;
        b=KKxG9jEPoy+mcH26BQApI179xRQURf+Conh0qWpX4MGpIgDWj8WAQDLxSak06ibxi0
         /cwJWYB2Uq0eSzfIW1/W1hRJwtThiFZDogMHvMDftpHppN/O9jRSjfOk0e9AuPDFI9MC
         LveheO0aKFWXWd8cbCIAsPMURYypQstO3J2mShFGIe/GVCLhaxevk4z8W7IM0qTxJvwg
         PAq4gYeOXEdp0y4Z2ZHsRL2Or+1JLNGdNzenBZw6Y6/5LjCtBY7dFxlXhwjPGoCHpBkr
         A7jXKLQGiIzPGKpljUCy9fwnLY6Txs7sH2yQVUeQNDApIpSdGEY5fnu/aXs/Aml1zDG8
         YSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704220917; x=1704825717;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IDlo3e01UfJzc/OgV+7yfmsbQsJLiO7IOV7UvfVvAyo=;
        b=wS53AAiW7S1q8OB96mqOpyw27NgjX7qg+eBIUMt2+bwWMtamuIB4QkmtFzurkfgpXH
         sDeiAchp2xbwcRnfQG2NNeVyhonLLZneLtzJrCj5KiJvX4AOE9VQIwVuwtLdrqEr+l6b
         1feXYtOEo+Jny8fngT5tAc/mz5UtbkiVj+zkPbvs4GbaDNXeZftRkxayzkB3kfGswdHk
         QVeucFf4bNnlsmJIr50kies/ZfoSJnyaDp2Uk8NwRkXNfQhQTaE+H0C1FSyMOaPXFPLv
         V82SyOwlGFreKwvnwxjNUYbca2tk6VVFYPDhSWeQO2KdR3F02PzMOtU4pP5EUtQOVtKX
         IL7g==
X-Gm-Message-State: AOJu0Yw0kw80Qb/kUbSK0Ik7CUEpv/X4zbK0tJXrUWpGGI5ntJvgsVdd
	9pf296WwAmq6hr1Cy+7Va7o=
X-Google-Smtp-Source: AGHT+IHm8Vj1rRWFlA8fGJd8fqEIsel+7/lohx+qaXA26MfR+aUA5tSb0wfZ+a+3Oz1ZT54VTzB1Lg==
X-Received: by 2002:a17:907:908a:b0:a26:9b27:f8b9 with SMTP id ge10-20020a170907908a00b00a269b27f8b9mr4353523ejb.50.1704220917327;
        Tue, 02 Jan 2024 10:41:57 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id bz8-20020a1709070aa800b00a234b686f93sm12026615ejc.187.2024.01.02.10.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 10:41:56 -0800 (PST)
Message-ID: <f1196d941601108141bb60f382b7503a50ba600c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: Test the inlining of
 bpf_kptr_xchg()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Song
 Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, Yonghong Song
 <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Jiri Olsa
 <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
 houtao1@huawei.com
Date: Tue, 02 Jan 2024 20:41:54 +0200
In-Reply-To: <20231223104042.1432300-4-houtao@huaweicloud.com>
References: <20231223104042.1432300-1-houtao@huaweicloud.com>
	 <20231223104042.1432300-4-houtao@huaweicloud.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2023-12-23 at 18:40 +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
>=20
> The test uses bpf_prog_get_info_by_fd() to obtain the xlated
> instructions of the program first. Since these instructions have
> already been rewritten by the verifier, the tests then checks whether
> the rewritten instructions are as expected.
>=20
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Thank you for adding this test, one nitpick below.

[...]

> +#define private(name) SEC(".bss." #name) __hidden __attribute__((aligned=
(8)))
> +private(kptr) struct bin_data __kptr * ptr;
> +
> +SEC("tc")
> +int kptr_xchg_inline(void *ctx)
> +{
> +	void *old;
> +
> +	old =3D bpf_kptr_xchg(&ptr, NULL);
> +	if (old)
> +		bpf_obj_drop(old);
> +
> +	return 0;
> +}

This is highly unlikely, but in theory nothing guarantees that LLVM
would generate code exactly as expected by pattern in test_kptr_xchg_inline=
().
It would be more fail-proof to use inline assembly and a naked
function instead of C code, e.g.:

SEC("tc")
__naked int kptr_xchg_inline(void)
{
	asm volatile (
		"r1 =3D %[ptr] ll;"
		"r2 =3D 0;"
		"call %[bpf_kptr_xchg];"
		"if r0 =3D=3D 0 goto 1f;"
		"r1 =3D r0;"
		"r2 =3D 0;"
		"call %[bpf_obj_drop_impl];"
"1:"
		"r0 =3D 0;"
		"exit;"
		:
		: __imm_addr(ptr),
		  __imm(bpf_kptr_xchg),
		  __imm(bpf_obj_drop_impl)
		: __clobber_all
	);
}

/* BTF FUNC records are not generated for kfuncs referenced
 * from inline assembly. These records are necessary for
 * libbpf to link the program. The function below is a hack
 * to ensure that BTF FUNC records are generated.
 */
void __btf_root(void)
{
	bpf_obj_drop(NULL);
}

wdyt?

