Return-Path: <bpf+bounces-65680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7491EB26E9B
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 20:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BEF81894384
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 18:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D16C31986B;
	Thu, 14 Aug 2025 18:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKmJFNul"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F3A31985C;
	Thu, 14 Aug 2025 18:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755194935; cv=none; b=uPCDQrGyBNeBmZEA0SQJjVp4mI9qP9tCStH3bcayaaKNjn3aJDhHzsqcT0HUGSOsfzmcaQVRxLUr9gAQG/YOoLg+bk3U23aMjvmJT+B+g8ph1WSRQyFx+U5bX1kYqJzyWjG+XOL/+bIV/E3rYut+9bjk6wgW5nbUfp/IzQTTEHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755194935; c=relaxed/simple;
	bh=dQNWgCyeJ+BW1dYvMxNF0Kin8KoABLbjl4TIXbGMrfo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mkvmUTgz/oZoFpyCTkALGgusrAPDvFUuAxBYLiciU/PlXhQATRvKD8JeAzqPpKvirKhIAajaivK55R1ObS1ZeaQcUyPkKVYvMnNROz4E/7Gr2LW1BxhNWsFyA8wQi6uKt3jUOmbwzOHO2B1fQSIIzLc+vlGuIqf9DGLvy6R3ktM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKmJFNul; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32326e06496so1785549a91.2;
        Thu, 14 Aug 2025 11:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755194934; x=1755799734; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dQNWgCyeJ+BW1dYvMxNF0Kin8KoABLbjl4TIXbGMrfo=;
        b=VKmJFNulj5D1Mi+L7IxxLronxXhG2V6gs+0cnlRAFBy+7C4xL8Zk1uYYgvID7hA2CE
         uxLtvv9RNEt1LAVDTRMeDFxf6Z2X3b4DWXMrBA9rTmWfBG8AG3yONn+fSMZ9JiSERqDP
         Qg05sVmZ32uM6e3LN4+loAATcKFL4519xfzxTg0RWjfg29KwAd1uVChNUadJr0VcZEA+
         P8lwkyU62EIspnSZDUNw1K3MpiN2FN0Oer2cwszBQqYaG07qepjesOSym5PHUlKhjUOd
         snXkNDMXioXzIbVVRzFShUli96XW5ugC/jWXBLLXgHwMjBYbx+McSKWctMO1kUzyZvoS
         GsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755194934; x=1755799734;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dQNWgCyeJ+BW1dYvMxNF0Kin8KoABLbjl4TIXbGMrfo=;
        b=f1ZXtC4iIPlQeiDXhtaDMr5w+n8Q75XMayZbbPrYycXPhP8oMKlWs4Lvu37aBog0Kn
         CKNV/gmXMlp4Fej9Y6fTSZIoMSe8IAG9SmVyEXk/J/eFGdzbwBRQh3l3XeM8NuJPedRn
         LbMxby20g7i4MRHKmctCtggQjdA82xmk9RnZUI3MlEpALhBy+xCN8KI+yCeVDrwIdhxg
         HbB6jQMoP9pjbp4j/4OFmU6zAnnpip6ycYRukWM/KIo3wU914pv8IHlQX1p3dc1IfasK
         6UFvQMcZxsK8+A++ymcZu1iZiT/QTnux7TGEg75KKhS2r/R27F660Rtic50JlsKcixO3
         psMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLHPC8pgUIlfhojC/aQxKMl3m4pHhLHODOnsBVER/Ttd7TXyIiCMdK6ywx3HWBHaDDrhOQBHUtGFivvhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBIbchzC0lIFwGoH1gaJ97Xp8nVYjY8DRV5Y+CcoTBJdzOpgUh
	ewXFjwpwHAJ4N8Yr5hAVRX54TNhasM7CY/XsOqzNOZNDKVXKwby+aElWojZjyABS
X-Gm-Gg: ASbGncszUuQ1aytEM2gZCJWldf94z/j/cTwnqybYmGlX9J54BdV2bIWukiscVq2pRwt
	6CSOaYkHKhShxivgatX/721iZ9PXzpTLH8YnMXNPUsrPOPpMbhrdNQNhQruHwkVfmTvs/QfaOlX
	XWBIfcuHIYxmH/XvhnkeSJPuwJ7GPX0CuWwkKPejbhiwnpMpNOLXuPhu0n7h5wzf0yiFl4iaOZN
	2gHKOAe3EIqC3BcWLpo0zUvcH3dkfVwykoIInwO/UBiWaKa7BW3Zd4HDvN5j5iZnFkVCVjysQl1
	bwkAXfEIZ7H+8UTjALqPtSt7esUoBi6L5U6IQYaaTh5cVgC8mge3ydq36PxyuFml4oqJgD02Pp0
	sfHzpMVd0nJGfpYSXIvA=
X-Google-Smtp-Source: AGHT+IG66g1j9rZnCLFplcHZLA00jx8Fq0bLiwgv73ySHJMeH70ApTDeDMzWlUF1hPhQFjkA/1zl4w==
X-Received: by 2002:a17:90b:5206:b0:31f:20a:b549 with SMTP id 98e67ed59e1d1-32327991b6emr5744628a91.7.1755194933505;
        Thu, 14 Aug 2025 11:08:53 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32331127c96sm2469610a91.19.2025.08.14.11.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 11:08:53 -0700 (PDT)
Message-ID: <1aaff6868286a8926bd6942407c3af00d94f72c4.camel@gmail.com>
Subject: Re: [PATCH v3 2/2] selftests/bpf: add test for DEVMAP reuse
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yureka Lilian <yuka@yuka.dev>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend	
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 14 Aug 2025 11:08:49 -0700
In-Reply-To: <20250814180113.1245565-4-yuka@yuka.dev>
References: <20250814180113.1245565-2-yuka@yuka.dev>
	 <20250814180113.1245565-4-yuka@yuka.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-08-14 at 20:01 +0200, Yureka Lilian wrote:
> The test covers basic re-use of a pinned DEVMAP map,
> with both matching and mismatching parameters.
>=20
> Signed-off-by: Yureka Lilian <yuka@yuka.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

