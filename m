Return-Path: <bpf+bounces-29946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B918C8778
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 15:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C33B284A95
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 13:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B079F5576D;
	Fri, 17 May 2024 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FR67lSmG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA56E548EF;
	Fri, 17 May 2024 13:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715953913; cv=none; b=DmxfZ+hJic1ej/+Em9KiVWMfgq4W2ybnTzj0qkD3RyVFEBeRPadrXuYsQkMg83tH2ASUWkSo6j20VsnI+l/dXD3o7AW/9ji/ohanDtU9bD8/WO6o23WDG9EbZOEirTf6klsfSD1ouZ9iqzJTCr0inHFRSdX5JMH+VWIMmfgefFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715953913; c=relaxed/simple;
	bh=Ii5G2Pfx0/sTxZXz0bscWvjch8KM33tjPhOPx464tx8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LJbnfYypt9fjl/kQfPvkOg/7LMPojuD+rF54H2dqZ342uAZRTFbmn+1G4mswhcYPI0epJo7trVU0ltrmIvhGUa+D4TRCfRtNd4fnAef+6dOCESx9CkENSLt2IdhDAyuDMX0+PCGKs4vjScH1r0EFIY0ypt+ZooPi8Uii8iW/9bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FR67lSmG reason="signature verification failed"; arc=none smtp.client-ip=209.85.219.46; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-1eca195a7c8so9380765ad.2;
        Fri, 17 May 2024 06:51:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715953911; x=1716558711;
        h=content-transfer-encoding:mime-version:list-unsubscribe
         :list-subscribe:list-id:precedence:dkim-signature:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L5iJ2IBlt2gMp832vHsk9p8Pn87cMbPhUJ2Jwd45XuI=;
        b=NElMT0iBzrWIrqkkLJeGVrFCtE8eVsWNlkUR2nN9Z6557j2FpZMI87aXzEev4VQMLA
         xMpBu2kJq9Usqy7+2XGeR5gv3xQq4GXC6NznvKyslXpgsacibY1RmiyesNVDCYPFQvlB
         L+QNd/F7AtRsNj7IxB9PKMEbJMewiw9JWis1fR7ZoxeNZZY8VcXhb1C1xGPEAT29VNEn
         VhV+0eskp1tUwh4hDIf+Ggp6OxL+rtcBdf7oW6B1RyeY29aNZs+JaiE6qMxXOoiE9vMl
         tCuECoCxxPDhd+PfMA5xLB2tCiP3M4yCzcuCoA0aE7tcGrj1cVnWDEDvALpKl7QLahBO
         RKGA==
X-Forwarded-Encrypted: i=1; AJvYcCXTiykeVOCiBcu3kpCUKdmTAFtzX7ycJLZxA1rnS4u5IETuOuairll7g6mJrekrJTBHw8GemlC91J2pfTNcFPBRmWikmTiBBp5plGVTIc+bsFlvPxxbb4TdBe1cQ8gdlPFlPbSojkh99NW1rX2xn3etNLAOrvh4eVTC
X-Gm-Message-State: AOJu0YzA1mpDqSlvqlVtLMm9RtMuQzX3GHfri8sKOTgcX6jUqslw4Jc8
	Zo59Gys8evKMGMzXcB2Xa3b68jGLf5QC4xIP4rSDisklNBj9aIjG
X-Google-Smtp-Source: AGHT+IGkyb4KKtETu+dEmWgPg5AJ2lUMk6jEPohRDFYv/REpVeufpc+1yhaXaco+xMErVMu7jENFLA==
X-Received: by 2002:a05:6a20:c909:b0:1ad:999b:de47 with SMTP id adf61e73a8af0-1afde1d7b38mr23355862637.51.1715953911081;
        Fri, 17 May 2024 06:51:51 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a00:26be:370:d9bb:b9a0:16e:48c8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b300d9sm14724130b3a.215.2024.05.17.06.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 06:51:50 -0700 (PDT)
From: Fred Li <dracodingfly@gmail.com>
To: dracoding@126.com,
	dracoding <dracodingfly@gmail.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kafai@fb.com,
	songliubraving@fb.com,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] net: Fix the gso BUG_ON that treat the skb which head_frag is true as non head_frag
Date: Fri, 17 May 2024 21:51:40 +0800
Message-Id: <66464991ac8ea_54e932947a@willemb.c.googlers.com.notmuch>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20240515144313.61680-1-dracodingfly@gmail.com>
References: <20240515144313.61680-1-dracodingfly@gmail.com>
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46]) (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits)) (No client certificate requested) by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B5B145A06; Thu, 16 May 2024 17:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6a3652a74f9so3484026d6.2; Thu, 16 May 2024 10:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20230601; t=1715882386; x=1716487186; darn=vger.kernel.org; h=content-transfer-encoding:mime-version:subject:references :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date :message-id:reply-to; bh=c2+WnzvsrG3q05AgFPxDjhS97HlYQRIW0WgMF8TeUeo=; b=FR67lSmG+viUYDkDT6xwHR5ayK1pQRZdqwHJSGA1mbsI4DXrTSYKOD7mo7I8zY8Yxj CEEP8IPKSj9ZpVy3Os1nqjSeMJAy1B+FIGhYT2gmpDlUrqDCOfdSsTWQdh3xMMlj7NMw prFXeiU57uAjcN/osBgLfS32XXZ0ZG8kui/fcD5rsSYANXA64uH/x3rDYNYDeQsvG9de G8MMtpIr1uiST4ACbansycEzu4Xv0PLnRXl1bCRZ7tMEUeyXW98Sb6JR04bMAu+XYAoV /gy/Ph2VyMA5VMSdZmGhY/b2NbLl+0bmiOyZgDfO5mXvi3QnLJ2bJkA1z+GzdbKiZ0Z7 pBkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtkhtjcGgA2shL+FGFbrPX8lAbsRYK6do47tumH6KpqM9/QcWOffw7PpajU4QEUBUcs8oSFJdflvOagMyh1kzl7hXKtQvjg5NmTKYEaJziWYiDJMXzz5cdn4c/XVrKrVJY
X-Received: by 2002:a05:6214:5a08:b0:6a0:b594:177e with SMTP id 6a1803df08f44-6a16825a4b1mr207278616d6.57.1715882386314; Thu, 16 May 2024 10:59:46 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112]) by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f187c47sm77551616d6.48.2024.05.16.10.59.45 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256); Thu, 16 May 2024 10:59:45 -0700 (PDT)
Precedence: bulk
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>

> dracoding wrote:
> > From: Fred Li <dracodingfly@gmail.com>
> > 
> > The crashed kernel version is 5.16.20, and I have not test this patch
> > because I dont find a way to reproduce it, and the mailine may be
> > has the same problem.
> 
> That is a pretty old kernel.
> 
> There has been work in this space in the meantime. Such as commit
> 3dcbdb134f32 ("net: gso: Fix skb_segment splat when splitting gso_size
> mangled skb having linear-headed frag_list") or commit 9e4b7a99a03a
> ("net: gso: fix panic on frag_list with mixed head alloc types").

The mainline kernel is using the commit 9e4b7a99a03a("net: gso: fix panic
on frag_list with mixed head alloc types") version, but it not work for me.
It disable NETIF_F_SG only if it has non head_frag skb.I will send a test
case which will cause the system crash, also in the kernel 6.6.8.
 

