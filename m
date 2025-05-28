Return-Path: <bpf+bounces-59218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10493AC74AD
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 01:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DA867AAC44
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 23:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9976267B6D;
	Wed, 28 May 2025 23:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzvf8Lng"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED84E21E0AC;
	Wed, 28 May 2025 23:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748476283; cv=none; b=nWhMMO29k1m6dSoNxCokc9ZxksfspsLA+OgYpUTmZ4AVQjhe4V19l5pPnvhSezfJONxgRo/D+dIOmQAkfEMp6hSVzJIkruSgWIGzpxS1BIm4/I7+q6r9WB757waRpwUNiEkL9MilFCTcZhNdqBIzzIJIwdEajcErweWGRrzMFVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748476283; c=relaxed/simple;
	bh=uMQ6fSF1oxDLrJnEw3xXZbNYhZgKb76cfBxtrw5q1rI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tAJ25TIufFD4GzZhNJrS/nSYIk061zXoK4gz0p8CqO2X2xAlgx4XnjcDVo3QShYiiBUlUU49VM9fboyTsohL8FnXp7dNRIt/fBT8UJ3FzUPt4VZWq94Gr/+wSvTSH5zBMdcCUZYDD0pOPTS/e+7jAjAnF/ziD3o5ka0/fxR4ebA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzvf8Lng; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-74019695377so149964b3a.3;
        Wed, 28 May 2025 16:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748476281; x=1749081081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9kp8rnqdzmo9tFUrCjwXVQ8L8S02QtFjtYNGO/AmLO4=;
        b=dzvf8LngrwkSVpAKw9y1bWC7YquJ6LOQbwgnKUDI/ZRzAE+YPob0lysqzgXpseaeDi
         E6gL5wrex013vECoehlZ8SC1fdnuLGt+43worSLzwLvwKHFR8UJmMcLMDYfL8sL3MxB2
         JBnAycdoiKZEHe2SSQDXy2R39WS6V1LThdEBOkpx3ixPJUCzekG2i8Dfk91CrqWdM2bg
         nrpbEPd/hS7a8Vunoh7CfVnCo1JHz6MZ/5vVB/qmdn49X6uZHRS5DYEXdtUC+iH26ZL8
         smwh82/nEie6ShvfviNP/AAEOHLt1wu98OOibgqZ2xUFKe05hojX3VE1zdieNT3ekKAD
         jpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748476281; x=1749081081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kp8rnqdzmo9tFUrCjwXVQ8L8S02QtFjtYNGO/AmLO4=;
        b=kYDTZoNiM+O7Hs0CBXP/shxfeHn42hbDqLEOQKFTpxUQpDb4J4wcdLelo02qFTA4ll
         moDEdFMnBriVFvCaU3DfGaH8QDQo54pE276hWuICjJOe5+zmAjKodlhGizHCdeq2Bn8s
         a9M3PSJC0OoFI4j29wbN9deWbGPgH2XRx3Mgj5/rKdxp6CdQHLN98gGLvrTI/pkzQR1q
         Jh58F9HjagQC9p0iRrS+8VXr64+dWXE0cG4VI4tuUpJZmJxPhQwtHbDiOmmlS1rjvYyL
         FcjoofbCrEff6St9oHBVG8cBFxiX/gmEaY81jJiAn3gMZwQJIJggyc7r7nl5k41did5P
         n0qg==
X-Forwarded-Encrypted: i=1; AJvYcCVRW/x2HF/SHcW0rV3oTFm6Qf6NdgYSN1tl8Xgp1DlcmtvRwLcLA2knHMvvF/GgnfIiALM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLIsuTz0s2JuFUQ0YlI/v8r4uewRMfN9iqtASUMh12IjLoXfjQ
	YBUmYlMAjYJrirrdaFabIqYEaNWVXDFGMyGGt2beK3Y04nVW4lK/nHfB
X-Gm-Gg: ASbGncv/MXRGnz9dhbhthGhhWofRNVFAOe/Vp71u0t90FvE9kIUl/Emw8ay/WMdTgA0
	XyPOginKJ2CBsnJdsyCAKfRqCwZjZ1D9HDNlqEKxNy7HPIBfmIVuJdsCuE7hL7lfozm14bjOIE0
	RxcPL0uOH57b10lAGHkYdwO3zCympJEOmAZpMjZaIuKy7Z9reIzcEgFf3Lbub2A9y1NCwxa5pQU
	GIyj4hsDd2FKlhxvNA5eeiU/mZhO7/UDKL2kE5FSkS1i/o/sBxngFSs0qoOnpRUiApSSRcM6ZNL
	7636+DntiLmAs98Urcx++pKmutNiBbJcpwbT4adNavTMdrwaseOU
X-Google-Smtp-Source: AGHT+IFPoctYBQMc+efLcRkyqdp8gvVGoTrcIZA3bjcllRr116uGvK7sOICicgj/+FbtRkSRys9DBw==
X-Received: by 2002:a05:6a00:892:b0:736:ab49:d56 with SMTP id d2e1a72fcca58-745fdf77aacmr25061761b3a.1.1748476280998;
        Wed, 28 May 2025 16:51:20 -0700 (PDT)
Received: from gmail.com ([98.97.34.246])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afff7371sm156328b3a.167.2025.05.28.16.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 16:51:20 -0700 (PDT)
Date: Wed, 28 May 2025 16:51:07 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, zhoufeng.zf@bytedance.com,
	jakub@cloudflare.com, zijianzhang@bytedance.com,
	Cong Wang <cong.wang@bytedance.com>
Subject: Re: [Patch bpf-next v3 1/4] skmsg: rename sk_msg_alloc() to
 sk_msg_expand()
Message-ID: <20250528235107.ezfyzcacnk2xc34g@gmail.com>
References: <20250519203628.203596-1-xiyou.wangcong@gmail.com>
 <20250519203628.203596-2-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519203628.203596-2-xiyou.wangcong@gmail.com>

On 2025-05-19 13:36:25, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
> 
> The name sk_msg_alloc is misleading, that function does not allocate
> sk_msg at all, it simply refills sock page frags. Rename it to
> sk_msg_expand() to better reflect what it actually does.
> 
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

