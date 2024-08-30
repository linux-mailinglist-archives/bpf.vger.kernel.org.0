Return-Path: <bpf+bounces-38506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA639654C5
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 03:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CB21283BAE
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 01:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8737B450F2;
	Fri, 30 Aug 2024 01:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCGQpAQO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE9425569;
	Fri, 30 Aug 2024 01:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724982067; cv=none; b=qyjhSTwd0ld+Y2+X3tFW/4FMGTZgGWKg9Rv3delg+SMceqFoM1CDDnIDV19xz21I5XSLjqo5sUbbM0JPt29RGzF8ukDo7RGUWoin8oyxKsCCuEJDFY1CCa8DnyIG74UoJqGkNjZQWrVPiS0gJZ7kmXY5cnXQNu69Q0R2nvYScvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724982067; c=relaxed/simple;
	bh=KNosCZMQEMMqWsjsLO5rNUkOrafw5QqastRI3Ymr7HA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WPOmlS3t7zyzckMyrSdersYxZ9qbb85tebDkWHivf+O+wxLXjCfEVF4HbOzhrNw/Q8agrd6lXIBrCAdjrk1Z8u/hTscVws5TO/mr57kjlCsOJNyHsHKLPMwE4iI3js4SIVtrY08pwbEzsqxBZVA74bw/zQHIu6CmMsfLYcMY7UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCGQpAQO; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-39d2256ee95so6074095ab.2;
        Thu, 29 Aug 2024 18:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724982065; x=1725586865; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Yq8KW2GXBMgzUL0xsLtFvhg+oNmYWzZMZRpO2CZr0hQ=;
        b=OCGQpAQOnUsTicx4Qy0hAjyMLWijM2EkPaKPt9s96tuTpOrWTZ+T2JaAFeqFf34T7+
         gqBYa1Fg4Qx2llEQMv+P2BYquwIYZjMQbgGISRdFvbzXV6gS8Vf9iDi3+1JIgZCvRXHV
         C4sOpw7N9xk0thZBVVDe2JSiKJo7+pjwvcGKTnMrJ6gok+N9GHYktgXNxrAMMfI97fb3
         P7Npe6md0Cm3iGgvUnea+jnoBPkYubsIMj+IBNEzBbNmbeXRWOIfUfbemlaKbVhnR3wW
         t81vQ47UzGGoWRY4ow7LHqmS8GxJOxWegFuIc79uBG4NW5/wFaXTD1Wd6GIwHKdjl2xw
         0ppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724982065; x=1725586865;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yq8KW2GXBMgzUL0xsLtFvhg+oNmYWzZMZRpO2CZr0hQ=;
        b=aYTTlSOfRGZmaL4Ye12erfG4eHPuzVF5WxAadvTEdkoQorCeieN+92a71nhJxb2w86
         np7Wc7pSMxZ6Jz8fVxfZB9MX/sV8zc2VxQ5Osk/BYctXPQoPPCN6baBnkgdyp9muAvGJ
         9FLxvj9PecRNFjypzdVxdXBPBYOorA6Dg3GPJzs5ISY6wUF0p+s9B2FCDtR7KqYB/n6+
         9uVhWCkSPPhAjAYIFgUj2mRQM0yxIZmXc3N4fjj77ii2JIm4pYN7tKoRHZUFCr5y8/1g
         I9+2iwIERT0gL/HmB8mtVG0fTtZIfYLEjS134LLhjyD338NVGVZ1vh2EH1b3V2CtcWJ+
         8jLg==
X-Forwarded-Encrypted: i=1; AJvYcCVSyaINeLKS9LICCddJaXEL/YFTUAOkdo4Bw6hCqLnhsSuWK41JGnT4s+FyBSRLEspUs4o=@vger.kernel.org, AJvYcCXKsrtLIoVfzpr/FPGY2w8A7bxooKRK1AQmCWfsJcRHapbWHY+pu6mUXKAzq1ocLU2P275Q4FuXSg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5+bgsM2RC9oWcqECKMtNmkEu9SleVsgmxbJ3GJHDw0JS4XhNj
	6qjsKfAA//YNDLFC/sAas2IATqkJ+8sUtk3I02NfM2OejniiptGN
X-Google-Smtp-Source: AGHT+IGxWaTgK1suyiJYtITCfftHQ7hm4TPWdrYF2G8DgNrty6PRZ7Y7iG9Tmh2Sr0AQNbWlKr5ObA==
X-Received: by 2002:a05:6e02:2163:b0:39d:1157:74a9 with SMTP id e9e14a558f8ab-39f37804633mr63546525ab.15.1724982064615;
        Thu, 29 Aug 2024 18:41:04 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9daac4sm1603500a12.92.2024.08.29.18.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 18:41:04 -0700 (PDT)
Message-ID: <e524ae6265bb34ebd2f68fc5c246b9c43235c15b.camel@gmail.com>
Subject: Re: FYI: CI regression on big-endian arch (s390) after recent
 pahole changes
From: Eduard Zingerman <eddyz87@gmail.com>
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, alan.maguire@oracle.com, 
	dwarves@vger.kernel.org, bpf@vger.kernel.org, andrii@kernel.org, 
	martin.lau@linux.dev, songliubraving@meta.com
Date: Thu, 29 Aug 2024 18:40:59 -0700
In-Reply-To: <ZtEgG6XJGIGn0z35@kodidev-ubuntu>
References: <6358db36c5f68b07873a0a5be2d062b1af5ea5f8.camel@gmail.com>
	 <ZtEgG6XJGIGn0z35@kodidev-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-29 at 18:27 -0700, Tony Ambardar wrote:


> Thanks for looking at this. I ran into the CI failure while using s390x
> to test a series adding libbpf bi-endian support. Since I'm deep into
> endianness issues right now, I thought to try the fix you suggested just
> to make some progress but noticed the CI failure has disappeared.[0]

Hi Tony,

There is no fix yet, sorry :)
I think that something like below should do the trick:

--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -5394,6 +5394,7 @@ int btf__distill_base(const struct btf *src_btf, stru=
ct btf **new_base_btf,
        new_base =3D btf__new_empty();
        if (!new_base)
                return libbpf_err(-ENOMEM);
+       btf__set_endianness(new_base, btf__endianness(src_btf));
        dist.id_map =3D calloc(n, sizeof(*dist.id_map));
        if (!dist.id_map) {
                err =3D -ENOMEM;

as far as I understand btf__raw_data() should do all conversions after this=
.
But I have not tested it yet and would be AFK for a few hours.

> Did something get fixed already? I can't seem to find the change.

pahole version w/o support for distilled base was pinned on CI:
https://github.com/kernel-patches/vmtest/pull/285/commits/d3eff26fc978ca8fb=
3bce3f93421f7425aef0f55


Thanks,
Eduard

