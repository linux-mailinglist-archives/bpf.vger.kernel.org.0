Return-Path: <bpf+bounces-30149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC918CB383
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 20:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F8541F22829
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 18:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFC1148302;
	Tue, 21 May 2024 18:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhPrjCik"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F501130A54
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 18:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716316300; cv=none; b=prdxDhNLqcAAD0RxM9f8f0Z326a/70zHn0Wp0xIcsm3dkpcHUxGqadZt7UR8FmLKt1mzUbPTHlj6ItUnpXUozq4SjhAPaO5qOFBTz7aliTga09BQDxJla7z4wwKPpmOAM7v5xrSgEm2RO8t7cD+Ut64MM5uRa5pYIEVOFm5/rjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716316300; c=relaxed/simple;
	bh=T3DD+bxAa1xn/peTOGhzaofKaF+ggLB22XHpHZINgY8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZBhoguHBSLGCzcZAOLuDWnTMYEE2P/MK4/ZH2Nsxj6ES58LSM4jUO6NIyxjoExEK+V5GDlpW8uQBVgfcsy8I72jxjHgKmcNYnKf66O0oLDA7hi8VbwwTJ/XAOCIJJ4N2bCiCiF59QF3Xm2nDPa9Vml1Gq4V8Nvquq1biQ+RoK2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhPrjCik; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f44dd41a5cso723633b3a.0
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 11:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716316298; x=1716921098; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T3DD+bxAa1xn/peTOGhzaofKaF+ggLB22XHpHZINgY8=;
        b=QhPrjCikmU2gjpe5UyW9DrcYTpct2A8uctaC1hg/ANpbQE1EuNI2BTTSOUhK9+G3lA
         j4K9rbLB0Ovdx2CJd72H593mDyKCJYkUG8ElMoZaRSKQjPMqmjIQ28NIsZXyefcDFzpb
         FMi/ESn0o9qs+kAav2BZDYvRaKvUHZuWMjEtoWjL2bV/sdILP+7gLg7yIvE1rZTOcBX1
         5x7PRdy9u/YGDTXRCHAic1aIbJ2QvVrPDFPnShQVeHLVtBJxwmgfM6T5HAiPrAr7Y2nk
         7kFfGuvqch/nc9lcFycLf6D86jgAT4OrVifgVJ5GPFUz1IVbHVVEpykD24TMYglseNh0
         fLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716316298; x=1716921098;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T3DD+bxAa1xn/peTOGhzaofKaF+ggLB22XHpHZINgY8=;
        b=O8YZqZ7FkxbyDbVqieXvFIJ5SNTOA3M6tdwRj2AIxCKdhbVa3tln37geITwL0uaEJs
         UkClf0fLtFc+dOJBKlKgY74nL5/U55F6/cAEkDlgo4+KzuOcShAWemTvJztVp7csa1jb
         DsWb0zBCZeMZf59VJc/paiLLrI+3XUN6Pb2xJJgA2MZvVDCqsdLcoBLUNScBbiOiyAlX
         4BP7/GxteKPfmhLcHxW1/EcdjMmi7yKwTzY4ADQultVOOriaoOWXB2ZINwkPbvCv8A9i
         /BceV/V2jQxfuAfsrOe7Ts0divl9RZPNbuQpv72mrq3vIab5PVBB7KMbLlfHgI5ylydH
         JAZw==
X-Forwarded-Encrypted: i=1; AJvYcCW0CIlcrziuVr+V3+uf+tvlQGcTMHA4NiqX/MSqg5c9Qw2UzmkAJG1wOnrZjBAY+gAOKsBDG13R0DVOQIPDXWwDimf/
X-Gm-Message-State: AOJu0YwhaK0EXbRau6Qmr41MQx7gLcBh2DFSwRyT4aNgfvk0WqDusAVj
	OBggNEEG7Wxi9harh3LhzgzYHmycl+oV53Bie85aqZ4jj94VuDX75DzMe4ML
X-Google-Smtp-Source: AGHT+IE4uqfSqR341rWaPOuvjKWuqYcj4OeLoHLBFmO/L9q1NP5tBDEczI/3qjCvXiXkUEQ+ZVvMbw==
X-Received: by 2002:a05:6a21:398e:b0:1af:fa18:76f0 with SMTP id adf61e73a8af0-1affa1878afmr31462998637.55.1716316298542;
        Tue, 21 May 2024 11:31:38 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340d04c645sm21432190a12.56.2024.05.21.11.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 11:31:38 -0700 (PDT)
Message-ID: <ee0d3fba4c68d0b5a897d54c131c4d4e51d18271.camel@gmail.com>
Subject: Re: [PATCH bpf-next v6 9/9] selftests/bpf: Test global
 bpf_list_head arrays.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org,  martin.lau@linux.dev, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
Cc: sinquersw@gmail.com, kuifeng@meta.com
Date: Tue, 21 May 2024 11:31:37 -0700
In-Reply-To: <20240520204018.884515-10-thinker.li@gmail.com>
References: <20240520204018.884515-1-thinker.li@gmail.com>
	 <20240520204018.884515-10-thinker.li@gmail.com>
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
> Make sure global arrays of bpf_list_heads and fields of bpf_list_heads in
> nested struct types work correctly.
>=20
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

