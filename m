Return-Path: <bpf+bounces-19001-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2462823AAF
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 03:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3FE61C24A5E
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 02:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712FC1FBB;
	Thu,  4 Jan 2024 02:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lE801adh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8948E5221
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 02:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-554fe147ddeso76664a12.3
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 18:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704335614; x=1704940414; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=taR9Vi2ZH09olsD+0eMzlrmVENUYDbaguE909eNjFHg=;
        b=lE801adhOd99qBSM5IIE+rEUwh2wQaT+LpiJTIAvUL/e/2lWhNLf5CzX/sred1IWXB
         uYZujyPysnDtS/EyGUew2yLqu6c6VIQKA7iQIMPXcDNuOHvxZ4N3UuIyTmmYi9DUHdN8
         Kagx2VJQSFy7r5PRE987Saj5lrz6PhTcbERh8W8rVsWQKV4M6VSsHXAaw/WSknhZXDZB
         rbcCGkU/uasmuvLs9gA+M67sTPb6zviXn0nH8UFYwQnN8Gg7rULT+ysIpCh1Kispk0Kx
         AGQU1l+DTvctOnXJ9fKATh8Zu3yFj6fFh0g2WDA7yfPYLy4/4geSfB5cxsrx557F5YgD
         CTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704335614; x=1704940414;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=taR9Vi2ZH09olsD+0eMzlrmVENUYDbaguE909eNjFHg=;
        b=gP49hdrp26TetS3UI2Av9iLfo0els0hEb62Lwy0ZDoX4ejvUjj+dDFijIKXcC4OiT9
         ACSVMHMlUG0j32JhsCl6POV/JKySuuTffT0Hlq68B+m4jE5Q3NhSSTTCRS7b9nBs8XGr
         K/NTKKA2jJf2c8rP4YBPq4T75K//9EtdocfbPbifTA+kdxZ8Kxc5TRJRvkx9NsXZGacF
         lpleqR0PaZTijzRFgdGgnbW98UWolP2uxuwprq5VnUDNAqisWmP/a+2gzXMgK4dEmnVp
         UbOnGBf6eKpOewHuyP+rjnGmHB6D9A2kxxdAbDv0oWj047qlC3uVtyLnL5Jm0UBocsIF
         V8uQ==
X-Gm-Message-State: AOJu0Yz2UJgyX6phBTh4igFfpZ4MV+Au2QpjxI+ScHOjhx8JPjNAlXNl
	O9PxhIn3DasQIPeY5K3mfnU=
X-Google-Smtp-Source: AGHT+IFYFw3RQvIUjyFDfY3B0YfSOmbbHMyH3TrE67RhoG4voc3ziFAbm+ik+yz4KYX4Ch2uUnP8Rg==
X-Received: by 2002:aa7:dad2:0:b0:556:b93f:c843 with SMTP id x18-20020aa7dad2000000b00556b93fc843mr875578eds.39.1704335613656;
        Wed, 03 Jan 2024 18:33:33 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ds4-20020a0564021cc400b005542987b6cdsm17768053edb.89.2024.01.03.18.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 18:33:33 -0800 (PST)
Message-ID: <9ab7a6d993ce28a65b3204515f7b370b41f2fa0e.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 0/9] Libbpf-side __arg_ctx fallback support
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Thu, 04 Jan 2024 04:33:32 +0200
In-Reply-To: <20240104013847.3875810-1-andrii@kernel.org>
References: <20240104013847.3875810-1-andrii@kernel.org>
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

On Wed, 2024-01-03 at 17:38 -0800, Andrii Nakryiko wrote:
> Support __arg_ctx global function argument tag semantics even on older ke=
rnels
> that don't natively support it through btf_decl_tag("arg:ctx").
>=20
> Patches #2-#6 are preparatory work to allow to postpone BTF loading into =
the
> kernel until after all the BPF program relocations (including global func
> appending to main programs) are done. Patch #4 is perhaps the most import=
ant
> and establishes pre-created stable placeholder FDs, so that relocations c=
an
> embed valid map FDs into ldimm64 instructions.
>=20
> Once BTF is done after relocation, what's left is to adjust BTF informati=
on to
> have each main program's copy of each used global subprog to point to its=
 own
> adjusted FUNC -> FUNC_PROTO type chain (if they use __arg_ctx) in such a =
way
> as to satisfy type expectations of BPF verifier regarding the PTR_TO_CTX
> argument definition. See patch #8 for details.
>=20
> Patch #8 adds few more __arg_ctx use cases (edge cases like multiple argu=
ments
> having __arg_ctx, etc) to test_global_func_ctx_args.c, to make it simple =
to
> validate that this logic indeed works on old kernels. It does. But just t=
o be
> 100% sure patch #9 adds a test validating that libbpf uploads func_info w=
ith
> properly modified BTF data.
>=20
> v2->v3:
>   - drop renaming patch (Alexei, Eduard);
>   - use memfd_create() instead of /dev/null for placeholder FD (Eduard);
>   - add one more test for validating BTF rewrite logic (Eduard);
>   - fixed wrong -errno usage, reshuffled some BTF rewrite bits (Eduard);
> v1->v2:
>   - do internal functions renaming in patch #1 (Alexei);
>   - extract cloning of FUNC -> FUNC_PROTO information into separate funct=
ion
>     (Alexei);

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Thank you for adding the test in patch #9.

