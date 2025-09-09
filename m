Return-Path: <bpf+bounces-67944-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A14DEB507A5
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 23:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7517E4E03DE
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 21:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E558624677C;
	Tue,  9 Sep 2025 21:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QV/diaky"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35BD156230;
	Tue,  9 Sep 2025 21:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757451936; cv=none; b=dBpgSxj1FPlHkTHwWnpCEjLNh6QGpx5YrWXOU8ZPlj3Tf6MtifXRGG0yEnFhDC/2gLWXh/k3fe2CdFM4BNA612yZVHj/f0FmllMX89xsb4FVElr40D3khq+R9S9mi7UZ6v4r6wpsxBWAK/lDrOaHaMBXD9IDyW3WWXp55sT0qao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757451936; c=relaxed/simple;
	bh=MH+43WV8SVKBIWo22n1YRgQdAA3qP2BgAPkel/9dZQY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G+C1nCb4JSW8uMmOoW4RwML0OEd9TRyufKCOOfAgBJzrvMsuJVbc3x7aaD/QPwaQynx8FHcxk21MPZ03fkX9TM4tcEaMRxci4m3njRYePNZ7AGpllHOl/6vZRaXzgH3Oe+LjpWundqGiQ48z5EA5wirM2TR3IK6LSUtdStluftQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QV/diaky; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-323266d6f57so6828861a91.0;
        Tue, 09 Sep 2025 14:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757451934; x=1758056734; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jeUN2xiRTGHvef0MnViLopKxUVNLy1UHnhgsvbmCvl4=;
        b=QV/diaky7OflZuns/xAzSmal6J5+YiEZv0LSwaoIYRAqJuxlWcHLPGftlR5OFO+JQ/
         PL/9wibmanPARSq9xrnUnSQ1CaSIgFFIHgm9HzaUrUEkdbxxxeQBT+KOoILWbE0T8ZrH
         eKcy8SNBpab0ZJXu0DsWevyIROORWmaToM7+IW/6l//4b2nH76UYL2sTVJP7s6xdvDin
         XVG29i/s5nMPTHvDKc9AYZIcWLU3PHAOGTHOTs4EDbsgEo7qoNc6DpPqeuMNVjctTA68
         PFiFJXrYXlE15dGworKujWaOdQD5WESmegimyh7ESOrrIul9t1j+ClLZDsrpSxkLRvaa
         ea2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757451934; x=1758056734;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jeUN2xiRTGHvef0MnViLopKxUVNLy1UHnhgsvbmCvl4=;
        b=UnrknLeNhguR8MKprRLMssbacNhwvDf38YRZIAeXypNstJFwLZ7SpbbGDV3CDfi49h
         rHKluWgQRgj/oAbknWTAm/+zVIMt74XjVImypIBSrO8W12ycXXrkVlZkSf4IdoktCaXu
         MLHf/bptVsfUhWAnqjxczzmEgcNRLDYJFVoynjxaGria+tJ6MtcMWlU+x/sMv+fgaJLl
         56g2CPP0I38lC8q4vt8yYzZXiQbJ1CJHNM2Pw7TT9aUNAXK6ComHA6FdvkBcJQazmdpN
         Hmua1jkWUZHSdXAudlDT3CchOU10DJ66VMMlmB7lFGuLRzwkDAdnZG77pP2IWFIIOZmp
         R5Xg==
X-Forwarded-Encrypted: i=1; AJvYcCWJ81ILduyFdGR+BDp7lA0z1BGSUnXJ3Bn5Jw01KwE2UOZ891YPVfHdrTDkPnzpW8ebcY0=@vger.kernel.org, AJvYcCWWcC7ia4sDvpDO+lcFgzIlFcvgiCd84rtHmWTh1PhrCc6KZ31Roaty9zci2PQVg5jvnjgzD5CwnTS+n3aV@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj89M7Oig3hnkYM239/DYIrxOOo3CTSRihJnQrORh6xOBb5U2e
	oAIkovtMY5/FamHIyxEUyYYbvgoDAsEBYPkAQHvJI1GErwiVzekCzY0s
X-Gm-Gg: ASbGnctaE7F1aulwyABws0OTHBjS2Xy58JV0A+RvXBdqXr+7LMXSEbapODPg5uyCTzT
	JKWOQmp2BgewNtQkCG2BajHHvk9jTs5FrC16veFKg6cqPHz4rMtyy/d4E2QmnGrDjp0qlfI3Oug
	+jW5HKBSAwVailuNZa8oz5yPnCJxt/eYR+duKn0l5TeMu4GEMylElI23NyFfHE5MtOnkkXxklov
	pHwgxAAG+hhoGvYDDdcZBESEt8Gao5dTXk43aesCDCcRjwUBnLpuT01HMgruEeRVkUMhF7yU03D
	lwjwPpiUM07N62vgiV2h7G/4G5KpdU0W+p7LA7z8aLdDTsJzGYhWmlkWQEVoXLIHldUv/UsGRpG
	3khJVLGW+Ux84D4uKpCrziRNJqEqckZ1XsD1KlBDsxJtuFzXgSf4uG0MorOI=
X-Google-Smtp-Source: AGHT+IEmqZ8B/Ln3XDeqT0UuM3Ja/E20VsQT4ceZErbZidbjh2T8U6f7OwmnkBUvaFKsJNrqaUVasw==
X-Received: by 2002:a17:90b:3f4c:b0:32b:c9c0:2a11 with SMTP id 98e67ed59e1d1-32d43ef6f36mr16963732a91.4.1757451933988;
        Tue, 09 Sep 2025 14:05:33 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:446d:dd9f:d1ba:be9f? ([2620:10d:c090:500::7:b68e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dbb314bcesm95501a91.12.2025.09.09.14.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 14:05:33 -0700 (PDT)
Message-ID: <9669e2334e7292d2522b4367703c25a6338b3280.camel@gmail.com>
Subject: Re: [PATCH bpf v3 1/1] bpf: Allow fall back to interpreter for
 programs with stack size <= 512
From: Eduard Zingerman <eddyz87@gmail.com>
To: KaFai Wan <kafai.wan@linux.dev>, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, 	yonghong.song@linux.dev, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, 	jolsa@kernel.org, mrpre@163.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>
Date: Tue, 09 Sep 2025 14:05:31 -0700
In-Reply-To: <20250909144614.2991253-1-kafai.wan@linux.dev>
References: <20250909144614.2991253-1-kafai.wan@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-09 at 22:46 +0800, KaFai Wan wrote:
> OpenWRT users reported regression on ARMv6 devices after updating to late=
st
> HEAD, where tcpdump filter:
>=20
> tcpdump "not ether host 3c37121a2b3c and not ether host 184ecbca2a3a \
> and not ether host 14130b4d3f47 and not ether host f0f61cf440b7 \
> and not ether host a84b4dedf471 and not ether host d022be17e1d7 \
> and not ether host 5c497967208b and not ether host 706655784d5b"
>=20
> fails with warning: "Kernel filter failed: No error information"
> when using config:
>  # CONFIG_BPF_JIT_ALWAYS_ON is not set
>  CONFIG_BPF_JIT_DEFAULT_ON=3Dy
>=20
> The issue arises because commits:
> 1. "bpf: Fix array bounds error with may_goto" changed default runtime to
>    __bpf_prog_ret0_warn when jit_requested =3D 1
> 2. "bpf: Avoid __bpf_prog_ret0_warn when jit fails" returns error when
>    jit_requested =3D 1 but jit fails
>=20
> This change restores interpreter fallback capability for BPF programs wit=
h
> stack size <=3D 512 bytes when jit fails.
>=20
> Reported-by: Felix Fietkau <nbd@nbd.name>
> Closes: https://lore.kernel.org/bpf/2e267b4b-0540-45d8-9310-e127bf95fc63@=
nbd.name/
> Fixes: 6ebc5030e0c5 ("bpf: Fix array bounds error with may_goto")
> Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
> ---
> changes:
> v3:
> - Remove the selftest (Puranjay and Eduard)
>=20
> v2:
> - Addressed comments from Alexei
> - Add selftest
>  https://lore.kernel.org/all/20250813152958.3107403-1-kafai.wan@linux.dev=
/
>=20
> v1:
>  https://lore.kernel.org/all/20250805115513.4018532-1-kafai.wan@linux.dev=
/
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

