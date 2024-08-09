Return-Path: <bpf+bounces-36787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 755BF94D663
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 20:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FC221F22A6F
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 18:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A8D15ECD2;
	Fri,  9 Aug 2024 18:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TglGlYOm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238E314F9F9
	for <bpf@vger.kernel.org>; Fri,  9 Aug 2024 18:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723228705; cv=none; b=W2fqIlRM6qQpy0qgjzjc983hSNyAQzPIz07i0xulT/+MT1IPk0F0tXkPRKAXC2RGlaHs5V6fo1qoWVXzZmQVeViXcm6q7SCYTTup3ba6Z3mKqS8vhLmZ10Z9yU/qAlMWihtuvyhcB4UybYeWwRl4e4F7gWYLc78DaNMX5ox7w4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723228705; c=relaxed/simple;
	bh=BJ0YOMsMpxyE4iJnlH4bya3MrKDlSWYeIODTCSNP0M8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u6/Im7GGmfjseTjpVAVj98j3QUmrIJapZP0kpiW6S2TAp8CewifGtBKlpoUVFcgCbWxUM4/3d0eQBYxU+e6lvokQF0/tRldh1TUVwkAW4TVWvAfXAXEUI5FS3vqLzT5ZhmnB6Lk9pG6tM52D5MB5RylbnOGrfDA38pSHaKKmkFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TglGlYOm; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7a18ba4143bso1895252a12.2
        for <bpf@vger.kernel.org>; Fri, 09 Aug 2024 11:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723228703; x=1723833503; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BJ0YOMsMpxyE4iJnlH4bya3MrKDlSWYeIODTCSNP0M8=;
        b=TglGlYOmmn9iDPol9lJF/rcdkD/ZrA7sIQ0JoPC2cNaTPE7PzRaGNCaiaj+nCP+fPO
         burZ1tyWHukgvQyZ9uJLtiFbPnDd/AxP/GEyz2dx1PSTC6F0lTD3TatnXFx/hqxbU713
         Uj/JqHMwSicelQIvvTTa8Zic8I91wX08CbNP9UZJ5BZ7FyM4KfTLP3TYfm3i+oAOJyPd
         /4PQZ7gTeoW8TPhZ3YbpUgfYzyY2Sa1N7F8e45r6orSTR+nu94HuOeaJgtFAXMqF8nvM
         +UJc/5h+ibOahts+rZzIDOygYDuydDzWbKjP3sNbjGOiXSfS2W4lwP06ooDPVsoOBK6N
         VaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723228703; x=1723833503;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BJ0YOMsMpxyE4iJnlH4bya3MrKDlSWYeIODTCSNP0M8=;
        b=AfVROeYCy0llOWYqaPgiLf4JOhBn/t741TPu67UVpDNkAVQ0+A5jK0IyL4rZeMT1xR
         4+r5Bu7z2WXgFQVeiLEpLfb7pmrla0rkLeDssLJFjG5gH2emmnOr9zOrBm9uXogSZG0k
         ZiJIlsMibTB3Y6sVKwoFrcG/HHNT7q+Qp8clsKEuQVE9LbFBAvqMK6xKSMkb5CbcGQ1q
         5i+atSTYNvzYTltOsLnSpOYuUTTlZxlXS8ztZe1vkcs01iFxfmqnnsmFLV+IJR3nqEJA
         uc/4gXYQOSnYnDUOT1w4dyFVwq9BHeD14E2djtGiiblGX8mBBRkyXF/P72p3TONG+qV5
         iQoA==
X-Forwarded-Encrypted: i=1; AJvYcCWj9DVMCMlwqRo/jQzrg+rNewt2gZcO68xCgfJRaSBPSoFGxB8dWRRWTH69kLX1TCRABdEV4Zm9zU0P+o1Go1i6jGge
X-Gm-Message-State: AOJu0YzPUGj43o8NVJ37ah34CS0p860bhxr5RbSJnX8rqW9q8qN39Ugp
	7kKN4hhwd8ryuk3+Q/LI05aN4wvzcPJa8Ghid6QZZrNxU8fAhQ61Ej8KcS6nTLo=
X-Google-Smtp-Source: AGHT+IHsYIokv5n2IUqjq6l/D4QGCXkHs3zA9mX8xJZrdfW/7dzep4Fv3jJh69w5VoyC38WXcS0p/g==
X-Received: by 2002:a17:90b:503:b0:2c9:9eb3:8477 with SMTP id 98e67ed59e1d1-2d1e7fbf078mr2547343a91.16.1723228703165;
        Fri, 09 Aug 2024 11:38:23 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1fce2ad36sm108478a91.10.2024.08.09.11.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 11:38:22 -0700 (PDT)
Message-ID: <8c3c2f27c23bf10927889ae3a09a483c65815024.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: extract iterator argument type and
 name validation logic
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: tj@kernel.org, void@manifault.com
Date: Fri, 09 Aug 2024 11:38:17 -0700
In-Reply-To: <20240808232230.2848712-2-andrii@kernel.org>
References: <20240808232230.2848712-1-andrii@kernel.org>
	 <20240808232230.2848712-2-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-08 at 16:22 -0700, Andrii Nakryiko wrote:
> Verifier enforces that all iterator structs are named `bpf_iter_<name>`
> and that whenever iterator is passed to a kfunc it's passed as a valid PT=
R ->
> STRUCT chain (with potentially const modifiers in between).
>=20
> We'll need this check for upcoming changes, so instead of duplicating
> the logic, extract it into a helper function.
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>


