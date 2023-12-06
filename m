Return-Path: <bpf+bounces-16837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAE5806369
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 01:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B836B211FF
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 00:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008C4365;
	Wed,  6 Dec 2023 00:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0QEihTJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9260A1A2
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 16:27:27 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50be58a751cso4795388e87.2
        for <bpf@vger.kernel.org>; Tue, 05 Dec 2023 16:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701822446; x=1702427246; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Ex8rxsNFaRkd8xRRqYWP01Bp3Dpli+xYSo3egyr1Gc=;
        b=V0QEihTJVSDO2c8tedHcwEUTnpaq2OXOZiYEL9vZpqCgUJbmoXr/vC2A9xPaySg4kW
         xJ39X84+FDIc5lQ+ER2YH+vsWPgZREnOy2IXLv3AIOAymhrZ+/07Kl2w8Hd4hErypGSX
         FE2ZdX1HyVK6qy1NqdAbFP6BIzfXpUaVWKYentN8gjIsO3G9dCsCwb5XssjTr6oAeks8
         d0kPqljK37k8wFXQn2eL3aWqZykpYGzcPqs2jyJp4fuCrSX+iJZDMEEsW8kY8Qws4kPH
         e3E1B/JBEx+P6uVJczhQoEw+2RZex8KOBlY2yse5MDQG/A5TBoShKCup59F3yMJS6eod
         x5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701822446; x=1702427246;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Ex8rxsNFaRkd8xRRqYWP01Bp3Dpli+xYSo3egyr1Gc=;
        b=W3Qvp5Abr6gkzjKprz/qg0t5eyzpEH+gWC/K40oA6kCPNpA8Ox6jsnOjw9wV7rxEbQ
         PGL3SvdKf8Sxakhg+tjmmKabNXf3cpVp7Wj3t3MwuSUvXiOxYiUw4ybZDKytIxFdCin4
         p6oZS3hN3qcLEeWafO64tPkcyxcw9ZunNmbQyA29RAsKFRv6PYkgIuIcipLIo0pJ6xez
         WlYg1g7QhksVScGVh/uYQWuQiDE52AIBsmnqpyS91Oi6zZ4RRucK+/AxrIl81T0Ki4MT
         hegEeevyB1T2WWXxd04LEckNEHE1u9ArDRpfTp0nZ39IXLl5+ozh7nQUbe2S2QvrlP6a
         aLVQ==
X-Gm-Message-State: AOJu0Ywzd9u1DR/nv/qcD+sGNh6KrYp8qXJnqHLP/XgUgRQn8pwXwA58
	5jzcCG34k8C90X41fVXS8wrDWeqQ83I=
X-Google-Smtp-Source: AGHT+IFrq6mW/cT/gYbLTiY/JGdTovJ47GNvoWwdgBInmzpRaxj7OnsCzRpVlIM7bA8pcithHJy9Wg==
X-Received: by 2002:a05:6512:23a5:b0:50b:f86e:ee7f with SMTP id c37-20020a05651223a500b0050bf86eee7fmr75838lfv.53.1701822445625;
        Tue, 05 Dec 2023 16:27:25 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id d21-20020a193855000000b0050bc1ccbee5sm847223lfj.270.2023.12.05.16.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 16:27:25 -0800 (PST)
Message-ID: <827fe415707d215f8f0f2363c8692b2ce7898c1e.camel@gmail.com>
Subject: Re: [PATCH bpf v3 1/2] bpf: fix verification of indirect var-off
 stack access
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrei Matei <andreimatei1@gmail.com>, bpf@vger.kernel.org, 
	andrii.nakryiko@gmail.com, sunhao.th@gmail.com
Date: Wed, 06 Dec 2023 02:27:24 +0200
In-Reply-To: <20231205193250.260862-2-andreimatei1@gmail.com>
References: <20231205193250.260862-1-andreimatei1@gmail.com>
	 <20231205193250.260862-2-andreimatei1@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-12-05 at 14:32 -0500, Andrei Matei wrote:
> This patch fixes a bug around the verification of possibly-zero-sized
> stack accesses. When the access was done through a var-offset stack
> pointer, check_stack_access_within_bounds was incorrectly computing the
> maximum-offset of a zero-sized read to be the same as the register's min
> offset. Instead, we have to take in account the register's maximum
> possible value.
>=20
> The bug was allowing accesses to erroneously pass the
> check_stack_access_within_bounds() checks, only to later crash in
> check_stack_range_initialized() when all the possibly-affected stack
> slots are iterated (this time with a correct max offset).
> check_stack_range_initialized() is relying on
> check_stack_access_within_bounds() for its accesses to the
> stack-tracking vector to be within bounds; in the case of zero-sized
> accesses, we were essentially only verifying that the lowest possible
> slot was within bounds. We would crash when the max-offset of the stack
> pointer was >=3D 0 (which shouldn't pass verification, and hopefully is
> not something anyone's code attempts to do in practice).
>=20
> Thanks Hao for reporting!
>=20
> Reported-by: Hao Sun <sunhao.th@gmail.com>
> Fixes: 01f810ace9ed3 ("bpf: Allow variable-offset stack access")
> Closes: https://lore.kernel.org/bpf/CACkBjsZGEUaRCHsmaX=3Dh-efVogsRfK1FPx=
mkgb0Os_frnHiNdw@mail.gmail.com/
> Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
> ---

Seems good, thank you for fixing this.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

