Return-Path: <bpf+bounces-62077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A39AF0CD0
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 09:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 997414E267D
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 07:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415AB231A3F;
	Wed,  2 Jul 2025 07:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsS8ssdx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766601DF977
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 07:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751442132; cv=none; b=gNGei/moo38awKPmXMXWrhywASS/bAnsOLMbPaLYi0DGwvsuOwDN24r1SaYeSBwCp2m5kYHif3/sCVf1WJC+vNPnT6Dn5WLQTILw6+s9pVcN3WxvaCsMfheyTjBj82Bu2iFMzLt8JFW0bs+61RNELf1agA2cK6WTk5k68LKzvmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751442132; c=relaxed/simple;
	bh=cy3fMel4n6N+U1v88nrzZjmZfIQxhOoZBzibRFz9KjQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dB/N3knUhZyKV4ushkAz4w2Rh27ItOwIC2rJ1VMdStDpGFeCbQlckrOQdSGsND7aZ4HSsdIgtiEi2vSVwkOoN5tqjj9fFZ4aDw5StRnTkoARaRpMX0neiMpRklYzRZ1L+9C5KkKf71O14w+MLTtyZUopg18al8LgtCyYqqehAjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XsS8ssdx; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-235ea292956so38421765ad.1
        for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 00:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751442130; x=1752046930; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cy3fMel4n6N+U1v88nrzZjmZfIQxhOoZBzibRFz9KjQ=;
        b=XsS8ssdxQAzFGfO5DU7WLx+V1tStYn/W1nTEBqXa4vqZiEp12cHSmonDoGkiREqRze
         rVqrXpti65Uq75148UgFM59ZZ6Gsim2yvBTWPZ7gM8Y2UNlxwEKFZHXmxsgu+1DW6BtQ
         lVfacAhNTEnKWjpXYoytLIKceOWU0SYQoM2k9KV7t3qNSNkUc6cuOSoGf4O+tnVVGeNM
         4Zn18P9DyaGatuhns7NR9E23yH0JAZxGA6rhu/Mj48Z8wU9Gwrb4R23gc0RF/cJIGZ6H
         ahy+BWW+1rkmaJlyNuyDB4pYBGyveRjfyop65t76Sa42ze3iPjm+kW51WYU1pXihZRrf
         NZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751442130; x=1752046930;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cy3fMel4n6N+U1v88nrzZjmZfIQxhOoZBzibRFz9KjQ=;
        b=qIhFC6kVfwkZSWT5dr/bAcwDay2OmyICufULUF2fVN7CB0Quzo5vZxh5cLqlOYkZur
         I3KnNkapxDkLEvUIMG/EnBEvc+onJDXxb1UEBSljOMP8eIRmRRt5VAs2P9opOvT9epzd
         syaKcwoysWjZ986IFDBRyQBqIYGqvZl+KJee1/fidsw3NF7BbesLDwngksGjJW6ttza/
         7vogRrLjR4Yeik+wXFCKGMFWGJDqZu1BBpA1cpY4z4W821OMeA8sEoP2GDAB1EU9ia5z
         dwm18yXiYkRhcacGXMXtWi4aJwajujXcUnQ8aZ790aGGqE+UZEldAHf4JclR6RVw16L0
         b7Sw==
X-Forwarded-Encrypted: i=1; AJvYcCWlO6ApGddih/qzK4szmWzzBxeea205U4OGzvAA+z5wOYEKNeoczYbcy/v9NGmDr2CzpPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRQhVV8ICsezv7YCPBOWwK5FTJo5q24z5ijG9dcsvcBfAebX6e
	zXxPJTwpUuUjBpOvX5VwnqHGU//CM4qudGOHnSoePWoHqS3QJzCjPfCe
X-Gm-Gg: ASbGncuatObv68zfeoZ+tDoOTXii7Kukn6gB2c3R054p5ULuQ4TXFAWGlqNUKTh07bm
	Mv/MXyyWelah4msKOmp95rGnB3WhNw9T8EL/74gjFFX7bgTwC1fMtrNsfLYATXvA1DXTrMEh48e
	sPlLdYNSigAa5BFLtpSh+gGeFhjbjq8a0z9J+hgRYNHb2bFFU+TFcgbA8d2jXJ/wCFYWXQ3nsl/
	IRfXUYwP4Z0aJWaEQP4UD9d3El9z+uPtL4T8sDeN+PwT1Ls5U8CpB62g1R7d+754Z897LiX5CVb
	eeW47MZVOdWexUVwyqr/vTdxa9++gg+VdhfcsAQAS8BAQUV2S+2vMO9qZA==
X-Google-Smtp-Source: AGHT+IHMQAB9CekMalZlMPT8/qHfg1gy4qG497YVxuE6skLusYcLljouTEsgnNlJMhngHdAcoH7kbA==
X-Received: by 2002:a17:902:e78b:b0:235:f298:cbb3 with SMTP id d9443c01a7336-23c6e4ac731mr21961165ad.18.1751442129722;
        Wed, 02 Jul 2025 00:42:09 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2e2493sm130886415ad.48.2025.07.02.00.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 00:42:09 -0700 (PDT)
Message-ID: <45fa8528ac315388469aa448d9c5081783924b18.camel@gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: Re-add kfunc declarations to qdisc
 tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Viktor Malik
	 <vmalik@redhat.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf
 <bpf@vger.kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Mykola Lysenko
 <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh	 <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo	 <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,  Amery Hung
 <ameryhung@gmail.com>, Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?=
 <toke@redhat.com>,  Feng Yang <yangfeng@kylinos.cn>
Date: Wed, 02 Jul 2025 00:42:07 -0700
In-Reply-To: <CAEf4BzZZ2f1cP8zDDsqME5wcOYUECh6UKwxtTWbDfSjmdJD60Q@mail.gmail.com>
References: <20250630133524.364236-1-vmalik@redhat.com>
	 <CAADnVQJF8-8zHV75Cf7v8XWGVrJwU5JaQjBm0B-Q3JUUMqNmcQ@mail.gmail.com>
	 <49fcc6c3-8075-4134-bdbd-fbd8a40f4202@redhat.com>
	 <CAADnVQKQTLDP1W1ao-mCPfLDbZWykW1TdcouJPSVapNWu=bCBw@mail.gmail.com>
	 <CAEf4BzaM9_RbUfi2Gk-=_2D3OC8GiDS-vT5-9CHOd07r=+wyeg@mail.gmail.com>
	 <36400b83-1a6f-4da0-9561-073bd268c58e@redhat.com>
	 <CAEf4BzZZ2f1cP8zDDsqME5wcOYUECh6UKwxtTWbDfSjmdJD60Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-01 at 14:07 -0700, Andrii Nakryiko wrote:

[...]

> we should be getting rid of all those __ksym __weak kfunc
> redefinitions because they now should come from vmlinux.h, not add
> more of that, IMO.

Tbh, I'm not sure this matters much. Kfunc signatures don't change
often (don't remember it ever happen), so having prototypes here and
there in selftests shouldn't be a maintenance burden.

