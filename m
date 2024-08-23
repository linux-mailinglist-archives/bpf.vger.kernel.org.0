Return-Path: <bpf+bounces-37986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BB495D63C
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 21:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC2961C2138A
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 19:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4EA1925BC;
	Fri, 23 Aug 2024 19:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeoEya8a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E941917F2
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 19:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724442604; cv=none; b=V6GgPOsCBgHsDcDyn4yNISfgyMEDNsKazq8U5g4sMPhNAkIrMxqpN6ZVIMfMxgCT3jvDScUU77PyqAZydnS4LMEtthEUBRkoyUCiHUe2K5b4pWiMKhtKcGyPAK884VPQJhUTkYniaSQX7nnrwryceDpdSS5i2avIO0RukpomvD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724442604; c=relaxed/simple;
	bh=/IcgCtLAi1Sl2Q0kP795U+7BsiHo7thGWW4hHc4vsuo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J0boh2QObb7en7cdesESlDcN3nTvi8aqgPe0DXx49QZ7WpkUl5BoXPaIsGtmDl2z7lsqnWXUTfxsaR6XJYnFZCeP6F2jvAEq02SpBdDGidS201OeXjvGvtl2imDjAy5s/CneVWAUarGORvynQjlxqDPUJwkW3xuwSx1ZgSwmjaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeoEya8a; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-70949118d26so2137399a34.0
        for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 12:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724442602; x=1725047402; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/IcgCtLAi1Sl2Q0kP795U+7BsiHo7thGWW4hHc4vsuo=;
        b=DeoEya8abJmKCcmRRhwidylIkAgwSkuFydayL//Pk/vVuehM9i8LGIfX9KX1yO5/JQ
         pjA8fK1zdgiglSNqKa1SuYAham2veSTQD/jr0C1a4UtrNREBiOmvKdhdoYXkimnqR+22
         b5Awlkscv/ViJxdZiTZuAwtmXzUI97Oqn89/gPruqQwnx72/KoulRy3wKVL2XemwQfH3
         0KwQ6Hy7ptGAZvZ3naSJXVVDg9bUPMX363WlvkCo1tVgroMmKYB8jdFoYJZl2aW0aAUf
         /qRuL8i710L1Y7rdN66IZlEG2YQEARU3jd1OmXBcNISKo2K+NoTmhVMgCIikG1kJrY3Z
         SlnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724442602; x=1725047402;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/IcgCtLAi1Sl2Q0kP795U+7BsiHo7thGWW4hHc4vsuo=;
        b=BJbmaeofoUhHtM4L9e+cP1z64FOVwp1AllXgLGUpvvg41yWRhCDfXEQ3Kk7LryEpxN
         +CikjOBgOktEToP7EbDQHXuj+lyTnPv6md0K6yEofD+F8Kv/hr4wOmRrx6Qo0R8hdTWE
         ed5h1Vf784wvM86quwKoLT8+dDvlCB6qLGXqDUdtF+trz5k9n7/3Kevywdg5YuG613ol
         1KvOzyVTyLWORSHBgBke0n6puMODpAAjZJTgQnQX1iUdKJrE2MzGLv6scmjYSTD56lYl
         7jxGsQ1CIQc8+t0Ji0gXtpr+zutbO1HHiEtqDL+a8flAno3G0ok10UHvs3RIUeTRvZzS
         v0IQ==
X-Gm-Message-State: AOJu0YwC+Wjxi+GYDiqhhlmrd4S+Dwv9goIj+s8WAHMXM75Inyar/rLn
	p96tUU1u1AzrIA6qXgE46Rdl/QSUSzJ/Cqh+RQnPiEmXoVVowInFcvYNyjs8
X-Google-Smtp-Source: AGHT+IHlaiYN41iGfK+UrqQ8V3PmPBETFS/cZRPapsxa8yc8uFhdOl31YRSLFtlk/CNSdKY8/fsC3A==
X-Received: by 2002:a05:6808:2f05:b0:3dd:31d7:c16 with SMTP id 5614622812f47-3de2a845502mr3873804b6e.3.1724442602290;
        Fri, 23 Aug 2024 12:50:02 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ad6e2ccsm3124967a12.79.2024.08.23.12.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 12:50:01 -0700 (PDT)
Message-ID: <ca9ffdd75b8e5457264b6ddd567296a0f17dcf31.camel@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: use simply-expanded variables
 for libpcap flags
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev
Date: Fri, 23 Aug 2024 12:49:57 -0700
In-Reply-To: <20240823194409.774815-1-eddyz87@gmail.com>
References: <20240823194409.774815-1-eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-08-23 at 12:44 -0700, Eduard Zingerman wrote:
> Save pkg-config output for libpcap as simply-expanded variables.
> For an obscure reason 'shell' call in LDLIBS/CFLAGS recursively
> expanded variables makes *.test.o files compilation non-parallel
> when make is executed with -j option.

If someone on the mailing list understands why having
`CFLAGS +=3D $(shell ...)` makes make -j non-parallel,
please let me know.

[...]


