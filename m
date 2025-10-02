Return-Path: <bpf+bounces-70259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 266A9BB595D
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 01:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA88119E48B3
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 23:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD6625F780;
	Thu,  2 Oct 2025 23:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEPrIO3u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E113E34BA4E
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 23:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759446636; cv=none; b=GK14IqLKzoEKm7Zm9TWGCdW6QqJZ2DneoNivyoZ2A9eG777L2n+XJdNz4h3+WMsTjfwj54oRsve0m51JCW/W/pDxwgGpCCF0qYVMmJiKZvpNEIfVsZ8FGIOtGzJDCaQnzmFvYnOHiA07cslPyllo0MlGLZno/W76YXMEPzVWmLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759446636; c=relaxed/simple;
	bh=ZOyUtXpkvdqd+7y7ofpl2jt4Tdyj/K15/7PRjjcfZCs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJ5XjHRMFSAvknSdsyWMO5tYB4hjDeUWYY3zTwhs8xVIUVdnz4jvA7H89yRDHVCORqSgMNGQpU36Ue2Mi16PQM/eQvcn0TNUVhMqrj6l9WM5YqgWJPIWEAeoKef162yBq3S+sUBzfkpbYN+5s8mRB5rdK6WkFjZndUYGRSGX9cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEPrIO3u; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-781001e3846so1588422b3a.2
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 16:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759446634; x=1760051434; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UiuGoEO5rngufHIcam8V0ybcdP/ma64d2r8qYd8lwVo=;
        b=fEPrIO3uL1RyOoGA0jSYNubc/deOOHICin8MMFxpyMWwCyOUC63kMGCmFcaVYAA2dF
         L3RNXs1txnNPdy6aXswbSQmPEX7qf5kkBN6hOxGIEdVaVZIJo+ksJbx+5pwix05ZtztP
         d1v41wkRF4PLjI4araSq0uuIBx2OQulhpfvNZa8HxjetBcoSPP6OaltBC3XgCM6Bl4NL
         DsLbOsQPLfe2QjxR1niMqDDeBEpJEh0sK6rCWMbjIBhp/DtB/HhJgJ0OQFTFopoCk7ap
         Ls7HsAOvNB/W1FF0Pc+9Xw2+PyU3hPJaoGq8CBtTKgF+kTNJmfYJjvul0eoKsxnTWXn2
         TH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759446634; x=1760051434;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UiuGoEO5rngufHIcam8V0ybcdP/ma64d2r8qYd8lwVo=;
        b=vG6L4svpEiL6sgg/2raU8rrGCRsZseoX59HxoDaHjEmwSJ+d1Zf0XkZVpfSOOYwS4u
         eUwlKYcESgFbuSDDXLg+BPwUDrEv6V130Y5Mt9ZQEgZcKlhvNqn6GxrAZ/xb0063lfmX
         MYv41KibeTKdEsmLamxZQBlBeUN8y2+UxEgk+qchJq4Lz8NhLyKCZUPN0BNwNP2LpiWH
         n4EfQhc+DMozzwH0Ypr+iu0IDKohPhK551scRsX7/VxoW4OVuQbnZK2+igjW0sCer25/
         E6o65G3wQ9NJPqsRStqoF4j8/n/nLLfmbyYZDszGW2CPYRL0sCONuz9cerLaPsmpyoLU
         OJdg==
X-Gm-Message-State: AOJu0YyYSBtK415nPT9rkX10WR1mDBfQikHUHYkMDyFsIUrSsZSSip42
	sob3BfMGQkVMZ9f60NWgx5SqGOJbogZPXqR0ZPMEcZwYqk1SoG+ATEWe
X-Gm-Gg: ASbGncu8tZI1ripXh3rOmP00/Cj/XtE9zKd/30WmqaOORfdRWWctKXRFdVvU+j8+pDZ
	cgzwrBlGL4Gvh+6tp77bdrzXvIW2TTL8WsWIR3WEayDdKYAuH56Uy1zlcI6vA8ec8JZnJRXKDEe
	46zUUj35ddQEEwIRlnTe8Hs2COltmxZoOpNar2OCQhRMxZyQWhKmJ74gx4pCVrFO8BK2vvJigK0
	I+qYT1UJNFpaTa+bgU2IH2Qe++PowI5l4plZ8/rfu2E1/g4LGVzl/O7gPgEQA3z3kVHYs2LZ5rc
	Cjysnm+r3i5MeGqodNhkbyRuDPUjSthCvzjeYQpJ37PMZfNUirzNlCxT6gjBaQ2tjqzGXcWncbf
	NptrO+gsm94UlarMF+6Ng0RtfM+t4g3Nr1N7vS/kvjn72/wvR57cizJ/cLx1sRJ5lA3CaeWAXV6
	PhhqkGrLBjMsiy
X-Google-Smtp-Source: AGHT+IGqHefxUIssWtI1bcYTCiw1oWKkWG6Kx95D/Geh4pdtAlw4FLT8IXtR9vTWGowWByq4fT5rnA==
X-Received: by 2002:a05:6a20:e211:b0:2cc:acef:95ea with SMTP id adf61e73a8af0-32b61dfbb10mr1239773637.11.1759446634144;
        Thu, 02 Oct 2025 16:10:34 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01fb1902sm3131953b3a.31.2025.10.02.16.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 16:10:33 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Thu, 2 Oct 2025 16:10:31 -0700
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH bpf v1] libbpf: Fix GCC #pragma usage in libbpf_utils.c
Message-ID: <aN8GZ5NnHadLE+MH@kodidev-ubuntu>
References: <20251002203150.1825678-1-tony.ambardar@gmail.com>
 <269a9dd857907f3eb3cf02e27eace41e8a898744.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <269a9dd857907f3eb3cf02e27eace41e8a898744.camel@gmail.com>

On Thu, Oct 02, 2025 at 01:47:44PM -0700, Eduard Zingerman wrote:
> On Thu, 2025-10-02 at 13:31 -0700, Tony Ambardar wrote:
> > The recent sha256 patch uses a GCC pragma to suppress compile errors for
> > a packed struct, but omits a needed pragma (see related link) and thus
> > still raises errors: (e.g. on GCC 12.3 armhf)
> > 
> > libbpf_utils.c:153:29: error: packed attribute causes inefficient alignment for ‘__val’ [-Werror=attributes]
> >   153 | struct __packed_u32 { __u32 __val; } __attribute__((packed));
> >       |                             ^~~~~
> > 
> > Resolve by adding the GCC diagnostic pragma to ignore "-Wattributes".
> 
> Hm, I compiled this locally using GCC 15.1.1 on x86 and didn't see
> this warning. Is this an arm specific warning?
> 

I also tried building with x86_64 gcc 12.3 and didn't encounter the error,
so may well be a GCC/arm thing. And when I followed the thread linked below
I found only expired links for the original 'perf' test artifacts, without
any arch info I could find...

> > Link: https://lore.kernel.org/bpf/CAP-5=fXURWoZu2j6Y8xQy23i7=DfgThq3WC1RkGFBx-4moQKYQ@mail.gmail.com/
> > 
> > Fixes: 4a1c9e544b8d ("libbpf: remove linux/unaligned.h dependency for libbpf_sha256()")
> > Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> > ---
> >  tools/lib/bpf/libbpf_utils.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/tools/lib/bpf/libbpf_utils.c b/tools/lib/bpf/libbpf_utils.c
> > index 2bae8cafc077..5d66bc6ff098 100644
> > --- a/tools/lib/bpf/libbpf_utils.c
> > +++ b/tools/lib/bpf/libbpf_utils.c
> > @@ -150,6 +150,7 @@ const char *libbpf_errstr(int err)
> >  
> >  #pragma GCC diagnostic push
> >  #pragma GCC diagnostic ignored "-Wpacked"
> > +#pragma GCC diagnostic ignored "-Wattributes"
> >  struct __packed_u32 { __u32 __val; } __attribute__((packed));
> >  #pragma GCC diagnostic pop
> >  

