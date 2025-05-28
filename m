Return-Path: <bpf+bounces-59125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AAFAC61B5
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 08:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84A824A4F0B
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 06:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD907210F5B;
	Wed, 28 May 2025 06:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iA0nf0mi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49881917F0
	for <bpf@vger.kernel.org>; Wed, 28 May 2025 06:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748412790; cv=none; b=DnQZv6w0nKJkKHR7jU5XfrGymPlxWe7y31x7NfsUmr29I2VRusd1dL6PJ4vEsdlunFLn6ffLGhGw1NDreCgcgOD6gBXPFujyYUMgskRLNIJrWad1ob0qIBcSPKubFaA+30cDulYza6sMeyvxwQY//zfhY+qcahaMpXYOdArnehg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748412790; c=relaxed/simple;
	bh=9gTxS/dEfVh9qOIemQcrj3iOZLB+CGhYuNQW/hANwZg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G5TLBwbmtt/Hlm/yj9qEQuAbyRefFBgePfFpDwcNHaPEDWxkdENOVI/MkTZRb+CrrP65MJmfjSHjIh0dAkiSyPZDlCIZC96si183BpXXTAzzDTEIlhbh4huAJEwxuMMhwDvl+iwDFxcbu+Y6FPwQ2/Dfogg6sVZYwPaaZ03yDYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iA0nf0mi; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2c2c754af3cso3126689fac.3
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 23:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748412788; x=1749017588; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9gTxS/dEfVh9qOIemQcrj3iOZLB+CGhYuNQW/hANwZg=;
        b=iA0nf0mi5KoPoUTzM4KewfckXYRq/kyH70AKL2dCD8kzDSklIupazLG0+kPT7KOHHn
         KczTM/ia1UTb59Ea3aTnNkduEMF/vOeB/1BQSgYlBWhNXVZujwghgEBmY6NY6Yr7CNFh
         F8GS49qN+sG0hdrAtp6B0+gmURxKc4dzTsjR05fvs3KBCV3hY8Eo4hl/P2C9/757gkR9
         e1hsXeHldxBrKnNxTJe1u6wHSqMzE+jH84k3jOE7qnGbq20Lb0rg9ExhGtVAhtsJjMKV
         +FBBrTQItCWzcPrXQyBizrHLA0rGvcWUcXsGcXP06sfw2Dls797gDcvtlX/4BPCofTgp
         3g3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748412788; x=1749017588;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gTxS/dEfVh9qOIemQcrj3iOZLB+CGhYuNQW/hANwZg=;
        b=kN5Mo8Y9bl4cHL1KvvoRhWEEiwfEzXbsDVnRjz72f2fPJpBUEnue4AQM6DwqXX0Evw
         aQzkFEqoYhNWTr4bkhxyJsJQP38ue9IhOn/g7jJXXmWpSqTVeTWFiFMqvw013yUjVvjN
         hH42FR+9A3CxuLXcdc8EaFTULRFeRNIrkgH4ZbOFPyckVMsg3iMp3GjbOOILaxXxWYNU
         twleCf1UkhXCfjPqjQd5uxyvhPT3mWtbbth9MG7agf8a5hWZrHz/g8dWkUwrMe3ifJJp
         cZ3icl2jW0sqdbv8qUKNOXfbIQq4YWDOaFNhbU7NEjT239pzjToAevm5jlbzLa6va+1E
         A/zQ==
X-Gm-Message-State: AOJu0Yy79VYx/NGcIBBS3Lt09jDVM1i2x/344maM3EyYfKTVuDcxAq4C
	1N3g+qPC8rlLozK2ygSZnJvv2jMnzmHqBOa44g18qTOSMFBVsl/jf4S6Ub9SnZy4pHw=
X-Gm-Gg: ASbGncs0xFLVlhpQntk/arW6XjPkwaPQf2iyxjIbu3mmvW7p0yAc2vsiquAJgvw0TVA
	xxYvjDY1Ta/4VZvHA89wcbKXvqvO1hiA8HU1ZXQ/g/B1/ZqBgaSGes0eWjQxKYu7j+tKNuJ3q6i
	Qi3eFmwmp5OxGyMRVRs4vqooInmGpBWTEC5uHt0X+nNtHiFBS8DiUIIzYtDUEtszHW1I/ytami5
	4OwjCodrDB/bHvk54eLr8q+GB9yjU/i/bdsVVtg6X3RZldmDfoIVVdCApV21DLmSop4FADNFs4B
	JxwzqdoX1oXxwQ7N1v/wqhZtSBnBStbZw5GdKdWnZkZvu5q76E3rHlfYPg==
X-Google-Smtp-Source: AGHT+IG3eT0fOvjXT9F4LSLoI1XaiN0xf7SDvUd099h8vRqmu9Zvp9SSK76CeL9IbIAaJUAJfH646g==
X-Received: by 2002:a17:902:e881:b0:231:b407:db41 with SMTP id d9443c01a7336-23414f96432mr220152515ad.27.1748412777608;
        Tue, 27 May 2025 23:12:57 -0700 (PDT)
Received: from ezingerman-mba ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d2fd24d3sm4535945ad.23.2025.05.27.23.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 23:12:57 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  Martin KaFai Lau <martin.lau@kernel.org>,  Emil Tsalapatis
 <emil@etsalapatis.com>,  Barret Rhoden <brho@google.com>,  Matt Bobrowski
 <mattbobrowski@google.com>,  kkd@meta.com,  kernel-team@meta.com
Subject: Re: [PATCH bpf-next v2 08/11] libbpf: Add bpf_stream_printk() macro
In-Reply-To: <20250524011849.681425-9-memxor@gmail.com> (Kumar Kartikeya
	Dwivedi's message of "Fri, 23 May 2025 18:18:46 -0700")
References: <20250524011849.681425-1-memxor@gmail.com>
	<20250524011849.681425-9-memxor@gmail.com>
Date: Tue, 27 May 2025 23:12:55 -0700
Message-ID: <m2ecw92rh4.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> Add a convenience macro to print data to the BPF streams. BPF_STDOUT and
> BPF_STDERR stream IDs in the vmlinux.h can be passed to the macro to
> print to the respective streams.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

(Sorry if I'm being repetative, could you please extend
 one of the tests so that output of the bpf_stream_printk
 is compared with some reference values).

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

