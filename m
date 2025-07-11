Return-Path: <bpf+bounces-63071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8674B022B8
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 19:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 814463B5F2C
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 17:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEEF2F0E56;
	Fri, 11 Jul 2025 17:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSXfTlRF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAD11B4242;
	Fri, 11 Jul 2025 17:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752255562; cv=none; b=dr2DQ2RHI3QbwRjLC/CfEw1sQJhZr3DFWTmPRYPwuAL583lziVnvwRHy69X3rLrmSAUYXIPgO2GgL7r5Slrs9XyCHzufw1imFwcX5BkT5T0B5rsdVgdD8RKNUA42/tWFKqmQ1zUH4p0NPCAezQrvUTe3QkFiGQVyUB2NPV04eeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752255562; c=relaxed/simple;
	bh=hSXzoVQGKnv5+kgfpGlpLa60FkDkYWed3Qp6JcI7gGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvavXrnR/SAnuZkenTcQ2VBFvwmkpeYE5FTlYtj+raMCghl1Sz4IMPYAbfHipvn5huKb9FUKzIAYb3a+vAvfqogjMHtUlx8FjTNOq10Z28T7GsDkqnz6es9Ex/17KFcYkR36JSQJucvAM0sZkUrOlCcwapBvCorinU3uXz5pC0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cSXfTlRF; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-234b440afa7so24489795ad.0;
        Fri, 11 Jul 2025 10:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752255561; x=1752860361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gKbZoh+n8pOI30d3vMTZD/iTv8QjqhVgS/suI+ncwvo=;
        b=cSXfTlRFHBQrMoMfe9f5HoAE5ncrOpY3GuT1pVQz5p7vmXRT1MhqmA6VaIQ6RAhL5P
         vHqOKr3VYpH3jfU3cnlxwmSfa2osD9BVk3ed5ag/sIBc3SaFT8RHfTkck7fhxpI+chds
         RQwMgNuEnzsA78dkx0ru+wxP0kNoaRZH8Ec+VCQWk5GyH4Y8PMeYkKlKU6nbz0N6EvVl
         NGyGIiyF+EkJPcRLsgT5XxNdYAgf8o/cgDEfw16IehIJ3NrdB95uP/SRSYnbJBhhaXW4
         pMx6qOW+L/axkcy0a9v6RU2CSAAUaO5YAr/lXcHTJUI3baNKlYnYj+bqz+6sqwML6mnL
         Etmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752255561; x=1752860361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKbZoh+n8pOI30d3vMTZD/iTv8QjqhVgS/suI+ncwvo=;
        b=Z2Z/RlayeCnma6mP304UjsVHhAfX/eovHA7TzRaCQo4r2N6zIRbYVOnHLBdAYX3JCD
         pPRpwFkhrE8X4z3QOmAdbAam9r0nhOwRDzkndAvshiAXO0UuQESMFvTHYYsgdjsGcUlC
         6tPCJoGh8iWkS2MOhOmNiPl5WcwqyhBAE9Z43eeueMWWPOyIraewVLOUVbwBc7ApJWWP
         zUsFV/fsv+olh6KbPGMA+4S6lz4TtMr2OzYLT3vACmO2xFbB4kFuuetD0pcfft1JCcBy
         IFCt1ccVlnGe4S1sDDRNvlZSfhv+7iQ4qHIEyWLaILvJHg/eB0mze3tub1dAKBpfNPIn
         IE5Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+04+Xnoj2qT5rn5ma5PjUXG/PtCVEntqydsNScydJEhDFnC059GCKZ6fZ3NJrFHm3t/BqlW3zDaUPaD/fIO+3OlCf@vger.kernel.org, AJvYcCUQwoz5ZebJaLFNMOGFuRUabBDh0EqSD8SrIbe3Ut1AQKSvfgMsiqnpSMqqgMpi21XFxeGJAp0UaOL5fgT2uHmv@vger.kernel.org, AJvYcCUgAw/fSaKgkj2h80MT3Lv1/xVqwVTw9jpzWvQ7jPeos1v2c83Fwb4IHLq24RwMG/BW3eo=@vger.kernel.org, AJvYcCVctCyGcuOxAF5sze8Y9M59VqrhFCXVL4YrP5Tw4vXqh0yil0izuEtlZH9Mm55iYAuxxFHcmnIX@vger.kernel.org, AJvYcCW+EhXrzhbk3ZXcUN9cHlbAgQRS6LL865kOO8L3pYREVoO/byPhTQe7ob3H8XEfl4DtFzik+YLB4CfAPxIJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh8J7ftjwIeFst7fsehf0ohQ1tqS9nZu0aus4IBKUoEPi0yt0J
	CymQeu5MS7eHTKzJ/eICzAMgPaoODd7zRg37AitRAbErshlKIYwJXrL4
X-Gm-Gg: ASbGncu+sUZsRvvpfQU6lKnVBDFUJcVAQf7Nd+w6b0XH71X4KpUlrz0z911VevHpnsT
	4XN+4qC5tckhf+wYfk44oFv8pUuFT07WD8BGyzurRV0g/WlklmwFPEZL3b3UJgPADY4Mtuwyxxe
	eoQkzRrvvBfSTd8sXDt6FdXch2+L/JypF/vLZunyYfGIVa5Z7S8qGHXlPJ4Kav/039bSzWnGZWu
	WlpKfCZgWobHP3+I5tz9omAsqDEagItYa/sJh3yVKwO1y4HoeCokYcbsc+kK++dkJisBjBWsYLd
	49W0wzUvWtWKWzykfzFfWklj8uIMnZ9rt7eNWG+LfumwVVahdg1Yzhyea3CtHGp3N6N1hrhNXKU
	kPkgdmFj9MWu0oDsTVrNs0e4=
X-Google-Smtp-Source: AGHT+IFJO4kqx1/b7IDGsHwIQ1bGY+SC6uqOcklMdL3pIuimogKhh9rBa5uGE9OGWvA9HF3qswMM4Q==
X-Received: by 2002:a17:903:3ad0:b0:234:d7b2:2ab2 with SMTP id d9443c01a7336-23dede2d1c7mr52896435ad.8.1752255560411;
        Fri, 11 Jul 2025 10:39:20 -0700 (PDT)
Received: from gmail.com ([98.97.39.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de435b7e3sm49800675ad.224.2025.07.11.10.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 10:39:20 -0700 (PDT)
Date: Fri, 11 Jul 2025 10:39:15 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Tao Chen <chen.dylane@linux.dev>
Cc: daniel@iogearbox.net, razor@blackwall.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ast@kernel.org, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, mattbobrowski@google.com,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, horms@kernel.org,
	willemb@google.com, jakub@cloudflare.com, pablo@netfilter.org,
	kadlec@netfilter.org, hawk@kernel.org, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: Re: [PATCH bpf-next v4 3/7] bpf: Remove attach_type in sockmap_link
Message-ID: <20250711173915.xcq4vnb7esqg7gtz@gmail.com>
References: <20250710032038.888700-1-chen.dylane@linux.dev>
 <20250710032038.888700-4-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710032038.888700-4-chen.dylane@linux.dev>

On 2025-07-10 11:20:34, Tao Chen wrote:
> Use attach_type in bpf_link, and remove it in sockmap_link.
> 
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---

Acked-by: John Fastabend <john.fastabend@gmail.com.

