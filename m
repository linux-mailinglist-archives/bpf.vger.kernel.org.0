Return-Path: <bpf+bounces-41273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB25995611
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 19:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67ACD1F2356B
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 17:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738E720CCD7;
	Tue,  8 Oct 2024 17:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HGIbKZQT"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815B420CCCB
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 17:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728410121; cv=none; b=DPvSvXFg4dg4OQp+lQm/0QMrGlW+Qm2OuLZsa754XlKBXYj2AhXnTLk2h4RgupwqCFOKI64CnWRwEr5RKuMOPw6fgxOxYwbKjvhRmFHd+MTZtp+YI6L+A4uvYAWRNHb8NH28ATTFIcE7qP/RcDMWbYmAUPIX5+D4qisgdGTWqWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728410121; c=relaxed/simple;
	bh=2Kdiiov3SlSQX5rM/dYCWp/iUsWesT4L/qcM9kd8+S4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ukkj7mdvLqNecBdy/cpgLlY8w+2+3YwxDrQzp+c9J/1c2MyDlM93dnYP2TrWR/UWShbqt8kpTRmPAQmC9GmJB4o5NCi5aVNTRcePCozAeN+ck2q5LcfFy2PLD+TVqUExe1gdg+0Ze7Erfav+dCFvBJZvX66WfdRxzgJU3GBKLac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HGIbKZQT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728410117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Kdiiov3SlSQX5rM/dYCWp/iUsWesT4L/qcM9kd8+S4=;
	b=HGIbKZQTTxl1aAZjRJHhWylP3ZowQw5KOGmHb+2zvavZylnjz92f72azUuasBcUmnd8oq9
	0MtFZVkfDg721eWVdLa5gzUbbV43Q3PKCQgCIscDEwxTY4XjEZEEIQck7bd8IP/jleB64/
	lp5gtXPUYDEunj84CjOXr1hA7BV9R78=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-6nLGsvUvOXeCkuRmLTif3g-1; Tue, 08 Oct 2024 13:55:16 -0400
X-MC-Unique: 6nLGsvUvOXeCkuRmLTif3g-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5c915526395so329850a12.0
        for <bpf@vger.kernel.org>; Tue, 08 Oct 2024 10:55:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728410115; x=1729014915;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Kdiiov3SlSQX5rM/dYCWp/iUsWesT4L/qcM9kd8+S4=;
        b=mmIj+6RQToLqmy2DgMJMU4q6KAUH1ca1qkZsY/BepYqM9IHHHFNB922S2gFKf1Cc64
         5qyu7YmLK94rZ4av2gjr6XU/3phJwrCylSPrzypu3C6uqcSuzjB/cM4c6TAuNS6bz7Mk
         om2z95LaN7zAbx5AkBBtNf5flOIp4gmcrK0T3TRWoDSdVkfL5ZDdk0M8yQrDWWMJMyIv
         lCduadrDVt2agMsP3uuINBXoVsWPOLo4sRKx70BWLRvHR4c22EYZFuzxEbrgS47zNN/c
         wuLzVbUywnedwFAz8lBBbUcbfrZaTQUMKNy2JMARYuMT6L0/L93yQFzPFRlkDZT+ssN6
         DSvw==
X-Forwarded-Encrypted: i=1; AJvYcCWfqru0ValxmUPMqOERWO9eCo4oG6sV0H7N5hqrFKfPPQhqEsOc0wCz0/Xgmxd4Euc4rto=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUYbotU7vOBqzmEW9B61UNjYNaW2PAGkPuWlc6WTzI2TVmMsPD
	5HQu6CB8PMBFmACtYLqhOKDopE/OWp/ZIY0/2kbhynldITnl51E8ZNEn8tGtP62sb+9G6G7XLHS
	1U+of+qnTSJh/FBIQ2h9xrbSHfecyf7l/CDWL8z7y9cc+P6tWwQ==
X-Received: by 2002:a17:907:26c1:b0:a86:8ff8:1dd8 with SMTP id a640c23a62f3a-a991c02863dmr1850926866b.46.1728410114839;
        Tue, 08 Oct 2024 10:55:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8exjWPNPM+wo7ZbSPNcUlEw1hHxXLcWxRxDWAnJAZ87z1FAn9OJl5bXYqcNHgCWTFfwf9Mw==
X-Received: by 2002:a17:907:26c1:b0:a86:8ff8:1dd8 with SMTP id a640c23a62f3a-a991c02863dmr1850924866b.46.1728410114477;
        Tue, 08 Oct 2024 10:55:14 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9944d35ae0sm422152166b.179.2024.10.08.10.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 10:55:13 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 31E5B15F3BC4; Tue, 08 Oct 2024 19:55:13 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, Simon Sundberg <simon.sundberg@kau.se>,
 bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf 2/4] selftests/bpf: Consolidate kernel modules into
 common directory
In-Reply-To: <ZwVv_ZOvh2mTGAlK@krava>
References: <20241008-fix-kfunc-btf-caching-for-modules-v1-0-dfefd9aa4318@redhat.com>
 <20241008-fix-kfunc-btf-caching-for-modules-v1-2-dfefd9aa4318@redhat.com>
 <ZwVv_ZOvh2mTGAlK@krava>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 08 Oct 2024 19:55:13 +0200
Message-ID: <87ploascn2.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jiri Olsa <olsajiri@gmail.com> writes:

> On Tue, Oct 08, 2024 at 12:35:17PM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>
> SNIP
>
>> diff --git a/tools/testing/selftests/bpf/bpf_testmod/.gitignore b/tools/=
testing/selftests/bpf/test_kmods/.gitignore
>> similarity index 100%
>> rename from tools/testing/selftests/bpf/bpf_testmod/.gitignore
>> rename to tools/testing/selftests/bpf/test_kmods/.gitignore
>> diff --git a/tools/testing/selftests/bpf/test_kmods/Makefile b/tools/tes=
ting/selftests/bpf/test_kmods/Makefile
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..393f407f35baf7e2b657b5d7=
910a6ffdecb35910
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/test_kmods/Makefile
>> @@ -0,0 +1,25 @@
>> +TEST_KMOD_DIR :=3D $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIS=
T)))))
>> +KDIR ?=3D $(abspath $(TEST_KMOD_DIR)/../../../../..)
>> +
>> +ifeq ($(V),1)
>> +Q =3D
>> +else
>> +Q =3D @
>> +endif
>> +
>> +MODULES =3D bpf_testmod.ko bpf_test_no_cfi.ko
>> +
>> +$(foreach m,$(MODULES),$(eval obj-m +=3D $(m:.ko=3D.o)))
>> +
>> +CFLAGS_bpf_testmod.o =3D -I$(src)
>> +
>> +all: modules.built
>> +
>> +modules.built: *.[ch]
>
> curious, the top Makefile already checks for test_kmods/*.[ch], do we
> need *.[ch] ?

Not really for building from the top-level Makefile, that is for running
'make' inside the subdir, in case anyone tries that. Don't feel strongly
about it, so can remove it if you prefer?

-Toke


