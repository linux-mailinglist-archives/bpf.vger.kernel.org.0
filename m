Return-Path: <bpf+bounces-19172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1106826659
	for <lists+bpf@lfdr.de>; Sun,  7 Jan 2024 23:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BB14281875
	for <lists+bpf@lfdr.de>; Sun,  7 Jan 2024 22:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7BD11C92;
	Sun,  7 Jan 2024 22:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QINHawAm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA2411C80
	for <bpf@vger.kernel.org>; Sun,  7 Jan 2024 22:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e43e489e4so8693355e9.1
        for <bpf@vger.kernel.org>; Sun, 07 Jan 2024 14:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704666131; x=1705270931; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=drVsujrmosqtm21hR8QpvEipewlm+fMzmeXjs+fCfxg=;
        b=QINHawAmMJtKwxf4TAUi5jlpMlwAh1geyjYnIhtP6KkaKB3a2+nvjjj4Z/AJrNgguk
         GG0XTYHEIjIWd15l7vrMQzADnKC5VWjOPVhiv92RCetMptrPFrF+EUoRwQTAUdIl06km
         LK9Ms7mWC1i2pcWtAwj0woVC+DMmSJF5Lc5AXkrI54LgLdfYdWkWun179NjhPJVyjHxX
         sv7Dw4NFpLyNSeaeTXQ42CbsBaYXPQlL6NGxOPR19DahHYDRzKWe/SwOkDSZ1uI/pCcZ
         wY/Kzax0OGYuFZYayaXH6T4Y9a83S67Ly/a64ZhWXmmY7f7zVnxgShUXlocyocu85khE
         ZG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704666131; x=1705270931;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=drVsujrmosqtm21hR8QpvEipewlm+fMzmeXjs+fCfxg=;
        b=XnFFRvJthpfs6jQ438Va0mxPzKWrgc9Fi0rMJv53ezzE+1CErxTAlag90Pjq2+KaTw
         P/1Wvawk1ZzGbos6NllMl8OBHpm0at1u1wsurasJ/LGX3spmy6mLUdfdGgZBexoh8RLC
         mBSnPMNpUKHPJVAmsvZXdej8XXCTFUoab8ge5EYbF95ohzTsAWI1iEmTtdGPqwTD60MN
         Jr8xIGChNo79N3BCfjgdZxEiXm2+L2fQEZQiZ73Z0F3PhB7R0bEjMSY7SlnQz6mYog62
         rDNv7s1F7IPkdWY480A1rBiRz+5TuNngVPRV7+nF8bKt5ys+a4ukO+ZqaH1UadCa5gf2
         tkeA==
X-Gm-Message-State: AOJu0YwwD8nB1ca4Y6XIzcES6UXyaIaaN4APzD9cT6bpXJ35kL8zHYNG
	Eul2aUb7/WJ2QRfsGxaDBGI=
X-Google-Smtp-Source: AGHT+IHSf04sfW1KdQUDkwfOTF2VACccPpHndwhwrcUQWi0Db7NfjQs5lcQD5Wbi5FniYN6Dq9U8kw==
X-Received: by 2002:a7b:c011:0:b0:40d:9369:697f with SMTP id c17-20020a7bc011000000b0040d9369697fmr1563254wmb.144.1704666131441;
        Sun, 07 Jan 2024 14:22:11 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id v8-20020a05600c444800b0040d934f48d3sm8852483wmn.32.2024.01.07.14.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jan 2024 14:22:10 -0800 (PST)
Message-ID: <cb2d2a2e5f05e9aad0dfef1109fca9022b351e11.camel@gmail.com>
Subject: Re: [PATCH bpf-next 0/8] PTR_TO_BTF_ID arguments in global subprogs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com, Dave Marchevsky <davemarchevsky@meta.com>
Date: Mon, 08 Jan 2024 00:22:04 +0200
In-Reply-To: <20240105000909.2818934-1-andrii@kernel.org>
References: <20240105000909.2818934-1-andrii@kernel.org>
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

On Thu, 2024-01-04 at 16:09 -0800, Andrii Nakryiko wrote:
> This patch set follows recent changes that added btf_decl_tag-based argum=
ent
> annotation support for global subprogs. This time we add ability to pass
> PTR_TO_BTF_ID (BTF-aware kernel pointers) arguments into global subprogra=
ms.
> We support explicitly trusted and untrusted arguments. Legacy semi-truste=
d
> variant is not supported.
>=20
> Patches #2 through #4 do preparatory refactorings to add support for mult=
iple
> tags per argument. This is important for being able to use modifiers like
> __arg_nonnull together with trusted/untrusted arguments.
>=20
> Patch #5 is adding the actual __arg_trusted and __arg_untrusted support.
>=20
> It also raises a question about default nullable vs non-nullable semantic=
s for
> PTR_TO_BTF_ID arguments. It feels like having both __arg_nonnull and
> __arg_nullable would provide the best kind of experience and flexibility,=
 but
> for now we implement nullable by default semantics, as a more conservativ=
e
> behavior.
>=20
> Patch #7 adds bpf_core_cast() helper macro which is a wrapper around
> bpf_rdonly_cast() kfunc, but hides BTF ID manipulations behind more
> user-friendly type argument instead. We utilize this macro in selftests a=
dded
> in patch #8.
>=20
> Patch #8 adds a bunch of positive and negative tests to validate expected
> semantics for various trusted/untrusted + nullable/non-null variants. We =
also
> make sure that global subprog cannot destroy PTR_TO_BTF_ID, as that would
> wreak havoc in caller program that is not aware of this possibility.
>=20
> There were proposals to do kernel-side type enforcement for __arg_ctx, le=
t's
> decide whether we should do that and for which program types, and I can
> accommodate the logic in future revisions.
>=20
> Cc: Dave Marchevsky <davemarchevsky@meta.com>

Full patch-set looks good to me.
Acked-by: Eduard Zingerman <eddyz87@gmail.com>



