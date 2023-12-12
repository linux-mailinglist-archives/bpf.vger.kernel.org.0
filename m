Return-Path: <bpf+bounces-17555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 275D780F3EB
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 18:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A33FD1F216C3
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 17:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C287B3C2;
	Tue, 12 Dec 2023 17:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPKJNBHU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E559599;
	Tue, 12 Dec 2023 09:02:20 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-333536432e0so5476996f8f.3;
        Tue, 12 Dec 2023 09:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702400539; x=1703005339; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fLwDZxq0b8I+zmZeUBO2n0BALERT5UHyciRjG8Wc1G4=;
        b=MPKJNBHUhORZVs9VtsJZYWjfk9JQAHQNntf0KcWFo35llIeoAN5PkouI6JqvNE5ooY
         9eQ+Xo9HKHWW617+XdMo2sqr2m4Av2W+gwCwwPZBFpYwt9ojWkvTcmH1ygaOfytj0Zjj
         S9qKaMAppzYIjyGDoF0+jyWHHt9wNeh9YzFQ7++XSFNzAKLyHwx92qVP1CC1u7khO8Np
         H1j23qtdjMBXphbOoyYhYld8KhyQqsM2QYXSTy++WGUtBS1/+/ZvqttBYiJQmWgagvRH
         09jG1cgJN6XiLS8A+xKLdWUFP2q14JPlK/Pcq0mN9PBP2WGRUqFjsNuV6ruzkX/STmLM
         FSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702400539; x=1703005339;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fLwDZxq0b8I+zmZeUBO2n0BALERT5UHyciRjG8Wc1G4=;
        b=QWlZdzNiD7Pa80x2OxzRKEHqG1aLaEkXQOEz987zJ6JlXxJ0SbHaacG02wIPUOeSUg
         KKbras/I4AOfz0yjNOgfxtesIZACcGBrBygSuCS2HFnekptmc3bzUIgcLJugdRRkpoja
         B8XLFm1tg6CTl7PI1e7I8/OqMFzpEZmq5XHmQticTmYwrn+O3puQuXtcxdkTKc8hPMSs
         EpYowAij8SidXzBV+KcEiud8SYr5+548hOifNZNJnPGJFV5dKWDJH4vufCvJDxVT4TJ5
         P2cVTTgvRZP7yjWiCuoHuaBRcKlG9+I9bMnucCrjx3LKpL1MbFjzSPr2u1Dun6xLnH2h
         iojg==
X-Gm-Message-State: AOJu0YyLNrLT4R8M2AxMG+OmkC9c4S4EMJhxBDVZHZTcHidnJxNJlPWh
	XN+vshDrEU7DdVi8rbYjBeI=
X-Google-Smtp-Source: AGHT+IF8g49RZYC1R9EkmOTpw+UgB0GKNMPuPgMa2aCGz1foTtKtOI31Rt229eeqIpcoodz/8LKq3w==
X-Received: by 2002:a05:600c:2a41:b0:40c:236f:612 with SMTP id x1-20020a05600c2a4100b0040c236f0612mr3369839wme.124.1702400539077;
        Tue, 12 Dec 2023 09:02:19 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600c450d00b00405c7591b09sm17238125wmo.35.2023.12.12.09.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 09:02:18 -0800 (PST)
Message-ID: <478ebb094a7f306f49db334bcece2e0d87524f77.camel@gmail.com>
Subject: Re: [PATCH -next] bpf: remove unused function
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yang Li <yang.lee@linux.alibaba.com>, ast@kernel.org,
 daniel@iogearbox.net,  john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev
Cc: kpsingh@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Abaci Robot <abaci@linux.alibaba.com>
Date: Tue, 12 Dec 2023 19:02:17 +0200
In-Reply-To: <20231212005436.103829-1-yang.lee@linux.alibaba.com>
References: <20231212005436.103829-1-yang.lee@linux.alibaba.com>
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

On Tue, 2023-12-12 at 08:54 +0800, Yang Li wrote:
> The function are defined in the verifier.c file, but not called
> elsewhere, so delete the unused function.
>=20
> kernel/bpf/verifier.c:3448:20: warning: unused function 'bt_set_slot'
> kernel/bpf/verifier.c:3453:20: warning: unused function 'bt_clear_slot'
> kernel/bpf/verifier.c:3488:20: warning: unused function 'bt_is_slot_set'
>=20
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D7714
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

These are unused indeed.
Looks like calls to these functions were removed in commit:
41f6f64e6999 ("bpf: support non-r10 register spill/fill to/from stack in pr=
ecision tracking")

Acked-by: Eduard Zingerman <eddyz87@gmail.com>


