Return-Path: <bpf+bounces-18920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1218236DD
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 21:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B44DFB2234C
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 20:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BB51D55C;
	Wed,  3 Jan 2024 20:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsXaRvZN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B781D553
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 20:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a2335d81693so156693566b.0
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 12:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704315470; x=1704920270; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k0WmMDEIOLBeUAb0NZnbCe84008ofdNpuwPxqCq3oHY=;
        b=SsXaRvZNeYGfXIy/b0lCrTaBUpYBSTtIH28PJmN0ARZqFAH5jdgSgW7cdtpLsrrVJC
         xUs1weAoZ3jwnIhDTPxl6r+Lrxwbhdl5Sie6r5HcseTfUG1T/VDWYa7r9pExnw0XJ8mC
         3QV7YHDscXR41AYHgQgyJZO3f5BwYmbC+mTFmNydtp0yC7HckOfx0vAF0Ds+Jd7c1c4z
         sIwIW3u9bylh2n8zMHaIzqUBHRKRM3uG2C6yU8c7kht2Ys23L50ktbrHB1oaZ2lE1Uww
         t74r8Lgn+c3zbaFJhKPM7y5m9evw4NvbEXiCkvzzWLkM6d1GxPfqlhSuS2ahUqOr8T4D
         XmWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704315470; x=1704920270;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k0WmMDEIOLBeUAb0NZnbCe84008ofdNpuwPxqCq3oHY=;
        b=Es3KdM2W4FbldASkuYOAldnVU3b/4IVglCxroK6T89t5PoaHemwxUKnwEMxyfHamwe
         iLpzZxoZfocDLiz4NjUq/xwJaHHH++FttOMDIAz33QKQrV0BAVHcSln0sRs888n2aHY2
         jBfPyY0KyAAAkMk8ZfKeh9UZ0cfjoAUF1ToRFttayZjQ2fi9z/QxoXoOPGpK+tzdWULW
         GFUU85WCyNXFhfNTpdF/DA6nD8h1d7hQH+MSt9RbC+jW2+uXueltklwJamORgabrWIni
         xNKZeDGdcsb0hmd2f88PlJ+EMxHSgf3U0pyKEo/wM2vUJ3FzLmJzD78xJyLuUKepGZdB
         KZZQ==
X-Gm-Message-State: AOJu0YxSF2fIW28xoZDa5s5aupUypzcifNJbTw3SmFu7S9gLuDIWRYX6
	ijWwaCRAOF6SrbxbX6lXlvE=
X-Google-Smtp-Source: AGHT+IHv1uAF4QtCFEPEEpWj8n0KehVvr3m5SKCZ14yg/6bvf42Xa6cZv0aSqHWWN7aOdUhfDqRC2g==
X-Received: by 2002:a17:906:88b:b0:a27:fdc1:59c6 with SMTP id n11-20020a170906088b00b00a27fdc159c6mr1401074eje.26.1704315470128;
        Wed, 03 Jan 2024 12:57:50 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id wl1-20020a170907310100b00a233515c39esm12943690ejb.67.2024.01.03.12.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 12:57:49 -0800 (PST)
Message-ID: <2e7306da990a9b7af22d2af271dacb9723b067fc.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 9/9] selftests/bpf: add arg:ctx cases to
 test_global_funcs tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com, Jiri Olsa <jolsa@kernel.org>
Date: Wed, 03 Jan 2024 22:57:48 +0200
In-Reply-To: <20240102190055.1602698-10-andrii@kernel.org>
References: <20240102190055.1602698-1-andrii@kernel.org>
	 <20240102190055.1602698-10-andrii@kernel.org>
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

On Tue, 2024-01-02 at 11:00 -0800, Andrii Nakryiko wrote:
> Add a few extra cases of global funcs with context arguments. This time
> rely on "arg:ctx" decl_tag (__arg_ctx macro), but put it next to
> "classic" cases where context argument has to be of an exact type that
> BPF verifier expects (e.g., bpf_user_pt_regs_t for kprobe/uprobe).
>=20
> Colocating all these cases separately from other global func args that
> rely on arg:xxx decl tags (in verifier_global_subprogs.c) allows for
> simpler backwards compatibility testing on old kernels. All the cases in
> test_global_func_ctx_args.c are supposed to work on older kernels, which
> was manually validated during development.
>=20
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

At first I thought that we would need to add a new CI job that would
run these tests for some older kernel version.

However, the transformation of the sub-program parameters happens
unconditionally. So it should be possible to read BTF for some of the
programs after they are loaded and check if transformation is applied
as expected. Thus allowing to check __arg_ctx handling on libbpf side
w/o the need to run on old kernel.
I think it's worth it to add such test, wdyt?



