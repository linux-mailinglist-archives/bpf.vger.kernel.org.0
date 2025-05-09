Return-Path: <bpf+bounces-57908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6A2AB1C59
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 20:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE2AF505328
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 18:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8A1239E65;
	Fri,  9 May 2025 18:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="doROmMtg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F62101E6
	for <bpf@vger.kernel.org>; Fri,  9 May 2025 18:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746815499; cv=none; b=c4P+/48m1W3vTLnwjlALB2bCqyrVP+jdo6reJXP98NrG6Jc//dx3JPHXVlDRDARBoXrqKk75tEcEpSIZ7HRSpv/wHCj9Z5XTZhcAVrUmgEyy934IARdVddh+RF6ivF2S+3ZpFL1zSHo7khTBHeUr08UBEI4TcB1ltlfllAZHjnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746815499; c=relaxed/simple;
	bh=5s7Epm7VgF/MW5MlDwbecVs7iT7R57Mz3xmlQP/T2fQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cnl5q0DeyrNW5+gUpp+fn5PPp4+Lkjyg3+vTssTVAbRQZPoNw4fTDY18AhzJCOOTg38XO/CRg5HuS8gKfwQfUC7dQW5Bq6WrhX+sBtM0IydNebWWu3OnXfnheQjW/Dy1PitBJYKhol16emDoBV95zFMXJVTmigG9zgGNLogXb3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=doROmMtg; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3081f72c271so2479081a91.0
        for <bpf@vger.kernel.org>; Fri, 09 May 2025 11:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746815497; x=1747420297; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rZHVH+sp9gnxwJ/Skg3fNH+0CnpQxAkq0kPBfDOZbSA=;
        b=doROmMtgk0/r4qIWYQ5rqoxdEfHqhCbBdM3d/N6/HOdGtuVIvEU4aYuAE3Cou+DzP3
         6QYNud67WF6jOMLcFQnHUkoRa7Mi5N1x8KCTNAstJmAJ1yBuB+N1EHQggnrEKyuxoJlp
         c52hgt3m4vgOd2sqXpV1Q7L/tWKsassJ63FE+qBDJxXjHa3U4cXpRASUXWB31q8LH5qe
         R+zVlEAute24LszNuGieRcp6RMGF4DNieEQbUZHAUWvqF6PqeUgHo9XOtUl7BBUda+gc
         KA6qYROesIKnIf8PHpqaX3c6sU7By/bFmIvThFM02lCflVLSi2QEc5/Akad55mvJYBwL
         JFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746815497; x=1747420297;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rZHVH+sp9gnxwJ/Skg3fNH+0CnpQxAkq0kPBfDOZbSA=;
        b=QuXMwntPckymQOInwcyMRgcaxmUfQOs4ZHVZ0mu0b9qsn5gHoTQunhq73ZCvvi+g+x
         7s7G6CNSlWyCHpU9NDVQfLxU1GhHna88NtIw8BEbqwHe8uKOmlqdDf4ycKh6p+uyTwf/
         JnKgboD3V9mtNRyLBbe8u+iZyEp5l5VqLshCasUjqBTrAY03Nbf92d15OrFHFCIeFvc3
         cDC6TUaq0QmtU9Vdrgn91O4CchXRyal3W9OEOnQH59VaBaA0r3aK45+YtIQAZccKV5/i
         uS9h3MRq1z/JsQg+XJKJ0THn6G5cVezKAA3AfbozOQQfCyWLBBklhi47bOTNa/Icy9xB
         5Xjw==
X-Forwarded-Encrypted: i=1; AJvYcCWj4xPNW32erTmoX6MgK72FXVEjnLdCnQ+gGwpHgkSJksobFPFYEeakjndWif01wPrHqhg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7iRv4RpV32pP2NH969x8FF+pkW9o/TpO/xBrm/xMhtyB+jILR
	m2/S6oLeP45ro2OAxiQ/ASq7hMOfh//yvkUFFYwQG8XPn05ACDX1
X-Gm-Gg: ASbGnctm8+uMB6CAwUulnY7qL46Ykrawn7XIOisBIRIPXAVidqbUbgswqAprVB2cHbh
	v1Jf3rlKG+NHOmJiyv+g7kfsl8bwejHIrO0XGLZsJYLE3h4nS0U6eyACQh+2TslM+rNRVf6RrqZ
	qiz4wODuO+oz3DTVPUdTKRhcOadKVJMag+/t0yT+zpeU5DWndp4TBfE0tjLPxyE/ylf/JDdOrlm
	8VM3IjpxqqAXTB37zaL1Eb47Y0mJpZY4LFrvOm5C5nH6fhLwWP5VSj7KTW303FR9wOpfevlc4b0
	1lhmvZfjk0hXXrEIrQe4BzRO4AxyIPhNpi61PiefpoE2ZUg=
X-Google-Smtp-Source: AGHT+IFLWxpBkabCjntIOaUExfQL16CxKRQ1ZHhaG1T5mabb5yqbKbxetyJKWR2qrlqHrasWPkCasw==
X-Received: by 2002:a17:90b:3d48:b0:2fa:1a23:c01d with SMTP id 98e67ed59e1d1-30c3d3e26dcmr6628659a91.21.1746815496825;
        Fri, 09 May 2025 11:31:36 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30ad483f438sm4375566a91.10.2025.05.09.11.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 11:31:36 -0700 (PDT)
Message-ID: <9f417b403ef541af5bc8497897e4fbf88bd4023f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 10/11] bpftool: Add support for dumping
 streams
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
 Quentin Monnet	 <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko	 <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>, Emil
 Tsalapatis <emil@etsalapatis.com>, Barret Rhoden	 <brho@google.com>, Matt
 Bobrowski <mattbobrowski@google.com>, kkd@meta.com,  Kernel Team
 <kernel-team@meta.com>
Date: Fri, 09 May 2025 11:31:34 -0700
In-Reply-To: <CAADnVQKN2S=yb_7NUO8bsu+7CxnaGyTML6gKcPS61EnCZtvG5g@mail.gmail.com>
References: <20250507171720.1958296-1-memxor@gmail.com>
	 <20250507171720.1958296-11-memxor@gmail.com>
	 <04332abfa1e08376c10c2830373638d545fba180.camel@gmail.com>
	 <CAADnVQKN2S=yb_7NUO8bsu+7CxnaGyTML6gKcPS61EnCZtvG5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-05-09 at 10:31 -0700, Alexei Starovoitov wrote:

[...]

> How about we extend BPF_OBJ_GET_INFO_BY_FD to return stream data?
> Or add a new command ?

You mean like this:

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.=
h
index 71d5ac83cf5d..25ac28d11af5 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6610,6 +6610,10 @@ struct bpf_prog_info {
        __u32 verified_insns;
        __u32 attach_btf_obj_id;
        __u32 attach_btf_id;
+       __u32 stdout_len; /* length of the buffer passed in 'stdout' */
+       __u32 stderr_len; /* length of the buffer passed in 'stderr' */
+       __aligned_u64 stdout;
+       __aligned_u64 stderr;
 } __attribute__((aligned(8)));

And return -EAGAIN if there is more data to read?
Imo, having this in syscall is more convenient for the end users.

Alternatively, are files in bpffs considered to be stable API?
E.g. having something like /sys/fs/bpf/<prog-id>/std{err,out} .

[...]


