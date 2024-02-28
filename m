Return-Path: <bpf+bounces-22894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B9586B638
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 18:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FD501F285AD
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 17:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7DE15CD7C;
	Wed, 28 Feb 2024 17:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="De7XEk8l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4944D15B98E
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 17:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709142039; cv=none; b=OOcMlDNHhTZZnhIY2ntbAQsNObj+bPc1sM7m6T1KxJjcE6D5bQmXaL+xFkpDjX/n04dafPWJ79hucPd9L5+dctThXvHL8KAe+Y3LwWjWOuZ7/yb0wmK6VCnZ104L1/1c638iTbT9XbFHVTgH8U/ukdxCRDYxVUy6EUdTADH5HYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709142039; c=relaxed/simple;
	bh=Yj3UOHbCRv8PxTEnJrvCL+TjQxwvVIH8WafRn6Pa5Ck=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=upxiYMHiHAuqJawHfKBoG2abRKyOx9Yd8WYriTsNZwSZLhRPPcdHTmZ1I86PfkPxg4s0441Uv8YCAwk+wf/SnKQ+SaIYsixjqt19IjKFu6RLzH55tgz3+G9CfpeNI/GJi8Q8WC1kuFNEBojyJayh3kw5buSOwx3DEoQQDJpr31g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=De7XEk8l; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-513181719easo1143074e87.3
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 09:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709142035; x=1709746835; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x6epOn9/CMhySpH6e19VCNDkSpruxEII/j3wO0EESjk=;
        b=De7XEk8lbn1cT6RrhU3dez3mW9qDz/MFqqiu0kk9jyyMiyWX72pIiJQWAdmI1LxwQP
         v9C8RtVs0Gcr/J50ahws8tAVXANn0QrPkfoUYUqszoVQVVG97pBWkzo1fxO930cMVGZJ
         q97A2RLp9d1jzulDE89Yb++AHidrt2+jq+CfQKaSH3qba3/K0zYv/yY+YEh2FOKvMpB8
         GUJw5H2Sv1hYhk7dxUHFzP9YyY/7G/vPhuwWHEp5HjUJfc88S1gS3tF0NjW3XjIAdrNJ
         feCZNwjRL5nYDciqWzJPf/SvHSmi2oQ628fpTEw3qk0fj5zEcVPh1qa41Ugsaf2gMbdt
         HS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709142035; x=1709746835;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x6epOn9/CMhySpH6e19VCNDkSpruxEII/j3wO0EESjk=;
        b=RUHTQIIgBpjRFY9KdrJCRS4obaTsgXdw2EvRH+wfT+zPPbWN7bOUdzdLBWBbhG4rDO
         c2Ejf2vls7C4oHe6nlDpsbiBQmh1z4n9vjK2kk7omvySpsjAgj8F+aDtx2giPFv2EhCE
         M+goriUJvwRVslDijytFvWrJuCuz7Kyl0EAalkVbm9mFfKVMLI90uiGp+gRNSE6UK4LD
         PRrudttteAdNvsgt6YR+yT5muftaRPs3KOu3vHupvJ1A1ycWhTKWD2We5QS1GABth9hw
         s7PuvSzZYGKIRjRMWlkY1dlNfSjdUHXM2O2s6cGpetInJbGdHkISFHvgzAx647p3RxmD
         zCpw==
X-Gm-Message-State: AOJu0Yzh+NFH4WZkrDwkWzVmLAiuAOSlx/9UpHFOMDdI/oM6qbcJl1y4
	l6gwK/dhBq8N7bvlBxBgKwONnaxnQeeJnvvC9h+u7/JvAzI9doGM
X-Google-Smtp-Source: AGHT+IHxSTxISdk2bqvGURakWKu9BWZYrJ4hqFoAzI5SKDgN9oLOGyWYiNbAe1t+IY1TFowxq/SF6Q==
X-Received: by 2002:a05:6512:ba7:b0:512:bdd3:153c with SMTP id b39-20020a0565120ba700b00512bdd3153cmr328815lfv.18.1709142035357;
        Wed, 28 Feb 2024 09:40:35 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id w19-20020a19c513000000b00512ed78a845sm1597313lfe.129.2024.02.28.09.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 09:40:34 -0800 (PST)
Message-ID: <024a6e047b4c593db26b7d3d59a82cc723db5829.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/8] libbpf: tie struct_ops programs to
 kernel BTF ids, not to local ids
From: Eduard Zingerman <eddyz87@gmail.com>
To: David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev
Date: Wed, 28 Feb 2024 19:40:33 +0200
In-Reply-To: <20240228172313.GB148327@maniforge>
References: <20240227204556.17524-1-eddyz87@gmail.com>
	 <20240227204556.17524-3-eddyz87@gmail.com>
	 <20240228172313.GB148327@maniforge>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-28 at 11:23 -0600, David Vernet wrote:
> On Tue, Feb 27, 2024 at 10:45:50PM +0200, Eduard Zingerman wrote:
> > Enforce the following existing limitation on struct_ops programs based
> > on kernel BTF id instead of program-local BTF id:
> >=20
> >     struct_ops BPF prog can be re-used between multiple .struct_ops &
> >     .struct_ops.link as long as it's the same struct_ops struct
> >     definition and the same function pointer field
>=20
> Am I correct in understanding the code that the prog also has to be at th=
e same
> offset in the new type?

Yes, but after this patch it would be offset in current kernel BTF type,
not local BTF type.

> So if we have for example:
>=20
> SEC("struct_ops/test")
> int BPF_PROG(foo) { ... }
>=20
> struct some_ops___v1 {
> 	int (*test)(void);
> };
>=20
> struct some_ops___v2 {
> 	int (*init)(void);
> 	int (*test)(void);
> };

From pov of kernel BTF there is only one 'struct some_ops'.
=20
> Then this wouldn't work? If so, would it be possible for libbpf to do som=
ething
> like invisibly duplicate the prog and create a separate one for each stru=
ct_ops
> map where it's encountered? It feels like a rather awkward restriction to
> impose given that the idea behind the feature is to enable loading one of
> multiple possible definitions of a struct_ops type.=20

In combination with the next patch, the idea is to not assign offset
in struct_ops maps which have autocreate =3D=3D false.

If object corresponding to program above would be opened and
autocreate would be disabled either for some_ops___v1 or some_ops___v2
before load, the program 'test' would get it's offset entry only from
one map. Thus no program duplication would be necessary.

For example, see test case in patch #6:

    struct bpf_testmod_ops___v1 {
    	int (*test_1)(void);
    };

    struct bpf_testmod_ops___v2 {
    	int (*test_1)(void);
    	int (*does_not_exist)(void);
    };

    SEC(".struct_ops.link")
    struct bpf_testmod_ops___v1 testmod_1 =3D {
    	.test_1 =3D (void *)test_1
    };

    SEC(".struct_ops.link")
    struct bpf_testmod_ops___v2 testmod_2 =3D {
    	.test_1 =3D (void *)test_1,
    	.does_not_exist =3D (void *)test_2
    };


static void can_load_partial_object(void)
{
	...
	skel =3D struct_ops_autocreate__open_opts(&opts);
	bpf_program__set_autoload(skel->progs.test_2, false);
	bpf_map__set_autocreate(skel->maps.testmod_2, false);
	struct_ops_autocreate__load(skel);
        ...
}

This should handle your example as well.
Do you find this sufficient or would you still like to have implicit
program duplication logic?

