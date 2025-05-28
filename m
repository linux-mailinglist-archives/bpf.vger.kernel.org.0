Return-Path: <bpf+bounces-59044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA194AC5E6B
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 02:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D1EC1BA5571
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 00:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1993D544;
	Wed, 28 May 2025 00:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqZMgnyb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FE74A1D
	for <bpf@vger.kernel.org>; Wed, 28 May 2025 00:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748393120; cv=none; b=W7jUfM+rgvE2LcgmFJ+4qU2tXSvxZ3eOkFghmevjtTEbqIcbdvSwJdLufahygcOQUGv7ztJy6V8FTrIbvShIfEX76+Cp0wxq05u3MQrCwMmS3yFWe97G9N5M1hZ9Z5uk3r6W0mwm15Y6S/wc2pyPmHID862JNyYkwkKY15u7NRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748393120; c=relaxed/simple;
	bh=UB9bdwFxzyDcjJXrJ+qZoeEs+ZHrrob5cGHRbp7MTv4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gXmj3EZJjwdcLVe1mUBjtcreDHqL2DwSEz0bn+jhzTFSwxCQ/KPxFpseADYb9n6z1kFKM5UlP3MbJ6ljYw5PD0Grrp2+UKVCK//z4VMwvk9Q6v1tKlTU5iHzL5IHKbwNguqPsIBuxhTH3yAhtI+sUwOsyLpvlSc0LUXJb9rWgZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqZMgnyb; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2349282084bso17213865ad.1
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 17:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748393118; x=1748997918; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x+It3REz6RNPycZeipbbZFB64JV+uCVLufuvh7tb5y4=;
        b=KqZMgnybrBqb3/Mrks+CRIyNgrCkbySECgDp7KJd+7XpVxiVXWYYg0hs0GgmZ+sB7j
         BNnl58zfHkv5cCi2iPXtg0Y4YenIoIEaY3Rr8iwqnG5cVpY4f4iEwuXvJnXI8FOmpb1/
         hZhdjjlVidUGSpGx50Q7/pYZQFRIz7a5/bNghZh+fT75ZBMoBNW5XaAzuikBTxImyFl3
         vxcNfi9AWoAU606FAUvn+8T7COofox/l08R1q/Fa8Ry1EWI0dGN8qBU1jq+SfVpuM9+E
         jdwZcHz49fGaS2g8jTIsfMElJP/6ylHMIxLQNs01reLuLtDhCY4v5qG/BdVXgUfmdnkQ
         pZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748393118; x=1748997918;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+It3REz6RNPycZeipbbZFB64JV+uCVLufuvh7tb5y4=;
        b=HzSgmp5kb4wTEZLURb2P/c6l7M6CTg3j20W8abUGGiXAhwJzrrvxaa2EERzitTCuQt
         fD6Rv7QeXDSnMUs/DGnktdCRb2am+ui+l5O09mylzehU+fxSALrct+sSRarY2Df0f7Fh
         lJaWP9f3DmFFzTcmXWjt55yOMblgkK8L2DbYFnUXT4V83kNJFcqYcr5uXNsTZQTs4nX0
         +oKg+Own0Uw+T5fMRpZKT6P4ZmDNj1GTDolPhTp90KPFvW4Kfj74q24HbR7p/7tflst7
         QZWAaKuxzEcZWVjdQ/NcO/vz0PNZh73jTrvEwIZWZn86NZMqmmZX9wkvKdRDtD0qZLL6
         DxpQ==
X-Gm-Message-State: AOJu0YyXzNRjS9qJq906HEInn3xzlq00l2YeHNFLG5MzlvISJj9LaWga
	5A2sJd+0g132r+48pT2GWC5zn2gDeowL6xZzoATX/d3P6rMn6+FgGD3C
X-Gm-Gg: ASbGncvutrKvtMVKiPUzk5omDJzFURhpogJCRxBkx8b5a8L6+dQPQ8yi74ngydR7Mdo
	go5786hXjqlLoI+kNakOwUw4I7Oh6ATjKW8wi78HIKrxALXnyTYIl2Y85CiPhwCG/eCM7eApNsr
	CnueuM72lpO4bvAjaLepOHgDtgrJP78gh/bo3iCLNrgsRle0xmNlZ5gbdEgAq1LwkzBl/SwbZ+2
	BIEAXoCEOaql2i8jebCrL516UNugzJnqRSROZ2gnpl8ltq4BRt8bpr1WWImWxXn6Bucgk12UQww
	P3OR+wfPcjE/iFxR8vHUfZdQRZpEP8mVW16TK4S5njqOvTfO+5Zn/Pw=
X-Google-Smtp-Source: AGHT+IGcY2UO6GqKSfZZrcyuM77qGPML9tB1aKF/nn84Zk2PpPPxU9oFBmABztI6+0JySkWkrL3cQA==
X-Received: by 2002:a17:902:eccb:b0:223:f408:c3dc with SMTP id d9443c01a7336-23414f618efmr214593725ad.9.1748393118208;
        Tue, 27 May 2025 17:45:18 -0700 (PDT)
Received: from ezingerman-mba ([2620:10d:c090:500::7:461c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d35ad08csm211435ad.199.2025.05.27.17.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 17:45:17 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  Martin KaFai Lau <martin.lau@kernel.org>,  Emil Tsalapatis
 <emil@etsalapatis.com>,  Barret Rhoden <brho@google.com>,  Matt Bobrowski
 <mattbobrowski@google.com>,  kkd@meta.com,  kernel-team@meta.com
Subject: Re: [PATCH bpf-next v2 05/11] bpf: Add dump_stack() analogue to
 print to BPF stderr
In-Reply-To: <20250524011849.681425-6-memxor@gmail.com> (Kumar Kartikeya
	Dwivedi's message of "Fri, 23 May 2025 18:18:43 -0700")
References: <20250524011849.681425-1-memxor@gmail.com>
	<20250524011849.681425-6-memxor@gmail.com>
Date: Tue, 27 May 2025 17:45:15 -0700
Message-ID: <m2tt5536n8.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

Could you please modify one of the selftests to check lines reported by
dump stack?

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 6985e793e927..aab5ea17a329 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3613,8 +3613,10 @@ __printf(2, 3)
>  int bpf_stream_stage_printk(struct bpf_stream_stage *ss, const char *fmt, ...);
>  int bpf_stream_stage_commit(struct bpf_stream_stage *ss, struct bpf_prog *prog,
>  			    enum bpf_stream_id stream_id);
> +int bpf_stream_stage_dump_stack(struct bpf_stream_stage *ss);
>  
>  #define bpf_stream_printk(...) bpf_stream_stage_printk(&__ss, __VA_ARGS__)
> +#define bpf_stream_dump_stack() bpf_stream_stage_dump_stack(&__ss)

I don't think we should add macro with hard-coded variable names (`__ss`)
in common headers.

[...]

