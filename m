Return-Path: <bpf+bounces-37260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 675B0952D32
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 13:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18F6A2827A6
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 11:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E851AC8AE;
	Thu, 15 Aug 2024 11:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q99CkcxJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E371AC88A;
	Thu, 15 Aug 2024 11:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723720021; cv=none; b=ihMiUm/owvEQlQpj1X8a99n//LBGmYIuO2CKgOIn2gxpxYhkRaAISItZsbS+y7eDa5wYjDSdTTPds0OyKAVhUC2mJCp+aXgccarsuVgYGBn8cgITHOllBXzyDWAZGO3W2bpkd+M2XTkkT9mR7kavlYECwrLEktdJh35cMOpMxRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723720021; c=relaxed/simple;
	bh=r6PB6I38xeWW8hCOA19KppGramBrnQ3/g/0ihZ2cNbo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfP2SZyNT2NTCLIZ5ycQyrAwUG+Z/k9guDSRRVRlyF1PzVfwwR3a2LGcs7ZTv3BoBLV1CVGUARKuB02Oft+YLJSOyAqlOyRiMVBCv0o8v7ktSr5UAHzw5DXFoJzfg2s50mSk0GCbouNDVdfBjOTp2SUtcQg0Ez7Ptn2vCSLDPwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q99CkcxJ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7aa212c1c9so106206266b.2;
        Thu, 15 Aug 2024 04:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723720018; x=1724324818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HHlp/18Y3b/YapSL10tamc6Em3A7d2FKqPF4wvOXYOE=;
        b=Q99CkcxJHUW6MdbjgSJMN6qtzkaHA670pGVBLWUPbjkmz1ifdu6Nzdrf+xh8bK11kM
         Myb7BPv/4rPQEiq7A7ez29gPQKEVPbVRacSd1HxKfEj0+W+rmrznZOmANmxK6aw4/tyQ
         HFN2gm0MD+L4fOyy9oQdVSLfcq3+tJUs2S1rvtMRdJrELC6jGaBS+RlVxIgdEr0M4/X+
         QRUgBNkZOvqwOcO1qBmj4pU6m/QDR85QxZgy/YLwJPBD1ronV9UfcAZZNn+6VhDoeYti
         6dceBSVH578cOBVrguUflycdk+hxcT07j5/LQ4cgHlp71YF8R5Mrg5raSBIu/8XSuHn0
         4RLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723720018; x=1724324818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHlp/18Y3b/YapSL10tamc6Em3A7d2FKqPF4wvOXYOE=;
        b=vwv4AyPSo/gy2aL+Nxlx2EcpKzl5Ka5mi4H+opXnZNjUDKyMZdyQFjFTM3Xy/K+kGp
         EzQGecSpvH4fubkxa3Lb6NFcgs35GcdwJksJl4FhSagoX6pe6YAaNOQ54hCjxdfrgsH7
         W+DJV9xH8S6zrYQw0elq/iXsLDDIrMSAPa0JIK/Ll9rBOV54A69A6YIaF959CFbeywgJ
         aRtSaXGg8mYSZKGPI1GNzJbklQ9IL+Gqzy02s7oc4/IEk3GaibW3FXwb8ElscBr/q1Xl
         wfggmjPb/MQ60egq9EoFBuzLp71HPMOxmW6i48Lqd6UZr00FwZI091uzJPjZmfkdM+Qq
         VECA==
X-Forwarded-Encrypted: i=1; AJvYcCV779gm7gc67d1i3Nv9dP2Vv1xFCgfm9cgY8jVCdmwqffamPHYwsD7MmHiORWXTEzV9leg=@vger.kernel.org, AJvYcCXNsvB/8qr3UZ3dNphCWT4DPIWoR/If6Nlyy44umUAHe9hk+oSyn+0lWJvixnJCNK3/gKxrFSEy5fyJBRXX@vger.kernel.org, AJvYcCXUgNRaJW0QAhS/PvZCJhNH/qbJocKRZED9A14vOIZJR/hfFCOx4/xRzPHwyp4anz4+z3XCDQjpeVRSbAeM@vger.kernel.org, AJvYcCXiw5WWG5Av+BvCK6aZzMO10DOy62WAvtU6O5HDQgsZxoZq0a9yscPbOrrGGt0ZbCXwmVIKX5oSi55VwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwB6ZuR7CuSJUViDJ6JWiOALifcY9E0Ie7YsyMWpQMBxgBw2kzq
	DswAZTdX0gwYjUT2GC8dgEBucOM7GuK5bnIoyeiHWV02pkS5vTm1
X-Google-Smtp-Source: AGHT+IHOG0gNdStkLsQq+UBGK8V2OMDdI8MHvWloqQADjVOGn+qiAw5yzUkXqSEVhu3WG6sMKfD6iA==
X-Received: by 2002:a17:907:3f0e:b0:a77:cdaa:88a7 with SMTP id a640c23a62f3a-a836705975bmr424955166b.48.1723720017977;
        Thu, 15 Aug 2024 04:06:57 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cfa18sm85334566b.73.2024.08.15.04.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 04:06:57 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 15 Aug 2024 13:06:55 +0200
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Brian Norris <briannorris@chromium.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2] tools build: Provide consistent build options for
 fixdep
Message-ID: <Zr3hTzZqsISEqSeh@krava>
References: <20240815072046.1002837-1-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815072046.1002837-1-agordeev@linux.ibm.com>

On Thu, Aug 15, 2024 at 09:20:46AM +0200, Alexander Gordeev wrote:
> The fixdep binary is being compiled and linked in one step. While
> the host linker flags are passed to the compiler the host compiler
> flags are missed.
> 
> That leads to build errors at least on x86_64, arm64 and s390 as
> result of the compiler vs linker flags inconsistency. For example,
> during RPM package build redhat-hardened-ld script is provided to
> gcc, while redhat-hardened-cc1 script is missed.
> 
> Provide both KBUILD_HOSTCFLAGS and KBUILD_HOSTLDFLAGS to avoid that.
> 
> Closes: https://lore.kernel.org/lkml/99ae0d34-ed76-4ca0-a9fd-c337da33c9f9@leemhuis.info/
> Fixes: ea974028a049 ("tools build: Avoid circular .fixdep-in.o.cmd issues")
> Tested-by: Thorsten Leemhuis <linux@leemhuis.info>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
> 
> This patch is against kernel-next next-20240815 tag
> 
> v2:
> - missing tags added
> - commit message adjusted
> 
> ---
>  tools/build/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/build/Makefile b/tools/build/Makefile
> index fea3cf647f5b..18ad131f6ea7 100644
> --- a/tools/build/Makefile
> +++ b/tools/build/Makefile
> @@ -44,4 +44,4 @@ ifneq ($(wildcard $(TMP_O)),)
>  endif
>  
>  $(OUTPUT)fixdep: $(srctree)/tools/build/fixdep.c
> -	$(QUIET_CC)$(HOSTCC) $(KBUILD_HOSTLDFLAGS) -o $@ $<
> +	$(QUIET_CC)$(HOSTCC) $(KBUILD_HOSTCFLAGS) $(KBUILD_HOSTLDFLAGS) -o $@ $<
> -- 
> 2.43.0
> 
> 

