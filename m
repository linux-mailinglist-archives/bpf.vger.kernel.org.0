Return-Path: <bpf+bounces-20372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA04883D34E
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 05:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D9EEB22C3D
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 04:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80C8AD59;
	Fri, 26 Jan 2024 04:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IB3viLUO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E814C8F54
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 04:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706241832; cv=none; b=RmNHsUu8OxerTuxImlSC/YsQa1nxrczMLlZEKL6HX6CX0T01PXdiLuYdVk1fSYybw6h5IYKF67xPcKv18HO0vBTtCs8CNKdRqzIrME8hrHzYBWZnSfii3ScWtIcywf2NcdA3Wgd2YJMyla0Gdp1NbRW+eDfCoF/erlK+99p6xK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706241832; c=relaxed/simple;
	bh=DYU0ar/n4GpjLkI5DONt87uXTe/7UjbTX+Fx7Drhe1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ULAnsu23re8lqo/QTvGHzLdoCeTozJE5trdMS5wSA9dKrcRSugxrHSRh5v5T3Ac2zAK3QZFWARFX533p8Db5FBa2UrR2gxeT1KgEUxA54s2h+cx2yyh7Q7lG++ZnqYts7kUq9p5nqzkUQ8s3Xfte/NKR6g/pZrV888dDcmnrBEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IB3viLUO; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-338aca547d9so5692827f8f.0
        for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 20:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706241829; x=1706846629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3Op+RPGDnW3T63qrQ4+vkb6cBPX7HA/ko4nO6RWuuE=;
        b=IB3viLUOYVwRJ44bpXShWcI/qHFFbuZk7F1QmnddCtW9Hw4Y5TZ60woksyHtMqg5zM
         8MRec82U+CBARbE4LB+yWYG1ecLHOfG5TaheqgAOHPcT83Qw5U/8R6ql3hHDBn5HUrPa
         NXtmRb+7YwLrj/8/dVhztdjKIfF23ec08VudjeFweWZ6YK7VsVcyMWlu3wQGdopPBcRt
         5QJe551Wli8Mej4RU0gR/+kZl39YtgicL3aJQatZ7ve2H1sgZvOtIbRWGO2ozvOep81I
         8wB5xaGCr2Y29S12a1EOA79wpq/AfOPSXCX7evasEztK4OUiwcowUdfnQXjrbOh0EljL
         icZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706241829; x=1706846629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3Op+RPGDnW3T63qrQ4+vkb6cBPX7HA/ko4nO6RWuuE=;
        b=Yc7spHRwOEm2YZZd0Dw0YMOAVs4kW+JcqeYUudcMGE7huvAUhsA0lQT/fbIpG3YRzf
         VIWkLFNtZb2Zt/zca0ulHcL7hLcWWRk+Ja+QkYx/ZWCBg1i5rQ6vujJdRBfeX95Rq8jT
         UHu2bWq4AGt1lugKFzZ8/sCVl8XjrDTS6wzpx+UhP7zE6ex1wJeBP/moy1ItJ4eLwS/W
         uNdbSUGWsxYgYal2s0CiuAKB0GbiOGwR6yJtRAqPkqGDtZTS4ygkWkdKrnvNP17RWv6I
         ccAfm+I6XoZEgHHmc9ISg3kzEG9r+Ur+VNHZFpUvbAulxOn0xLIGYZQtAvFoeX9TsdEu
         83tA==
X-Gm-Message-State: AOJu0Yyk1jb2UJ4obI/Audkwf+3gv3nrHlqJqg6UEddhWlgC6BSrXbBc
	A89GMg14iz8U5fJ/NPq2Hz7HNVYofdajTP9iQhjQaksFUxsMleWzxzeTOqdpooVoTjt80Y8WfRH
	mgetbVWpsSMA8cPnCEPV2880wD0o=
X-Google-Smtp-Source: AGHT+IGvKj0gose9Ucrsjg5CRTlNS2vTWJ/cLZ7lleQ3ODbV0E5r0cSLY2yi903ap02iE4ZQzEwLyoxD5i68iemvqD4=
X-Received: by 2002:a5d:4308:0:b0:337:c73f:db13 with SMTP id
 h8-20020a5d4308000000b00337c73fdb13mr254577wrq.194.1706241828876; Thu, 25 Jan
 2024 20:03:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126032554.9697-1-eddyz87@gmail.com>
In-Reply-To: <20240126032554.9697-1-eddyz87@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 25 Jan 2024 20:03:37 -0800
Message-ID: <CAADnVQKxOeXAQDjtwNJuSPXnXqFZzx6vaEfdM_u317X-V3n08A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: One more maintainer for libbpf and BPF selftests
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 7:26=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> I've been working on BPF verifier, BPF selftests and, to some extent,
> libbpf, for some time. As suggested by Andrii and Alexei,
> I humbly ask to add me to maintainers list:
> - As reviewer   for BPF [GENERAL]
> - As maintainer for BPF [LIBRARY]
> - As maintainer for BPF [SELFTESTS]
>
> This patch adds dedicated entries to MAINTAINERS.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Yes! Welcome to the club. Well deserved.

