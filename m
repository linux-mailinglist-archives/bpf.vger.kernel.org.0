Return-Path: <bpf+bounces-55693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0005A84E5D
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 22:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF5B54E0955
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 20:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F98290BCF;
	Thu, 10 Apr 2025 20:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="KO5Ss/md"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532732900AF
	for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 20:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744317860; cv=none; b=Vc5602DjdfRdf/dtr8C9P7m09S3vN7fVBEnFu78Qqk4MywTThzTbFkYnt0ZS59mNr4I1ggO96mfEho0xewfFWJD/QIzxYjSppdISC7r43/obKqplvNJdMHsBm45EI+FCHMrrykeaPkO9QaWTTHwp5hY8am8b3s20vz//4i/lqhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744317860; c=relaxed/simple;
	bh=eHC1faK3iTUl+b2A5WGBl1DRRBfjpZOZbUAJBEWKYE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XewV8r5FFflUzlczftUDif4ez38dRFWoKGML2ccJ4b9tCCdmTqkkImwVD/eVkbmW6etxJz65VxYKuqWrc25yAY2iCU+KD+4rT46diuYaZ++JcHiuk2KnPrYc2UJ5qfKJxUTvHmgJBfqWUO5PXt1aeqd9WXNg4qQLvc49wkn/dx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=KO5Ss/md; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e8f43676b7so1065206d6.1
        for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 13:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1744317858; x=1744922658; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eHC1faK3iTUl+b2A5WGBl1DRRBfjpZOZbUAJBEWKYE8=;
        b=KO5Ss/mdvQFQ13WijcVvU2rWqmzFlTVFmaYSyG6+SwIhziWGrvllvcIIFzOJMPvhac
         wfOCI4a7tI0XI6p6SGBdXzwOztPHGgmVlIhqQ9C5qI7bidJmPMaEo6fACCztb0zyTsbE
         s+uwqweveHd3btyluAvsZEx/XXL4HBbaF2SDE2v14nwkD9ULwsK2J0mil9CIFaN0PSaN
         QhKKnVV0N2pVWFjiBqJwiEYxki8PXjsxlCfqoXj8xyAkFi2RRFNASRIKi98O/YqTK0n3
         VO+hZTay+T9rUwAxqc1OGlkhiKnKYWAewHwg/dS40pEXxbocZZCHPiCDI65bvukVHi9P
         WeNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744317858; x=1744922658;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eHC1faK3iTUl+b2A5WGBl1DRRBfjpZOZbUAJBEWKYE8=;
        b=ePzlIC8bvykzs6ofJWGlZRBA03Gqsbd0KXfbzaKF8g1P4uwaNzmbgEYjO1HAwbWcWg
         IndRHSlcbEMoCwYNxcUEQjd9/P4E1LeYmNytRcEAr4cecfdc84Zq5Lm1GfEIkb8Mjueh
         kN8bQTHCe69FAYBEE3g+wErKGGavz1YGSZUBSr5nboGlsfm0Y50zkPCnl+rt1QDD3zis
         s39t/3n1UEbzf0Beu+JyHr5yD68PNbVOpCLEpodVH7OBftZe3H2qYPTdjrM+atvos+Ku
         XKS2FUun9qp6H6ux+ovVJJ12sjLVZuceOaUtPfuxiyTSceO7U54H6T8TcheMNlcwzw8A
         XTEA==
X-Forwarded-Encrypted: i=1; AJvYcCWMRPSlQvKc8VJjHTBIjQJ5mgg9jYTUNO/sptoUFsOJkmrh2fH2MrEfth3PYk3grJy3QK0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4kwcqfCx8rR4Vskyp/u5rfIFUe77oAMJZQrmES04bNiuWy+VB
	SSuAFoy1/1pKBgtGCmU6HJPrw0PSK2PUVhYuDu7cmfiM+NI3519ffauMSHexWnkb/c+xoMeYSIB
	b500Q1HOotU97yLQKdgIbNJwi3nQJUUANpeAzemPOCJLf7U6yQGk=
X-Gm-Gg: ASbGnctZzEW9wb5zIJVFi6R9S+Hj16VueM4mt1HIGlcTaJEum21KL5FMjOMHB6X9/N8
	VKxz/cZODWRUH/3M+23btDVU6E6CS1EwJe2kDX+v/w1A5XY5qybUDnmui+DiS4pV0OypLtb3N4d
	4cYWwSV9TtNbHnJtXTKxvzSQT4d23XXNx55V19LfbX6TSTlFrM6Gr1PXwBHRhkDgxCDA==
X-Google-Smtp-Source: AGHT+IFT4D9Lld34BEDFxmLdtNq1CHAu40ARUKhcOLKQAoF4EDsymse58Avjrn831AVyK4m+U2iFlJMN8Oshu7UviJs=
X-Received: by 2002:a05:6214:212f:b0:6d8:99b2:63c7 with SMTP id
 6a1803df08f44-6f23f1679e4mr1613206d6.9.1744317858243; Thu, 10 Apr 2025
 13:44:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409182237.441532-4-jordan@jrife.io> <20250410202718.7676-1-kuniyu@amazon.com>
In-Reply-To: <20250410202718.7676-1-kuniyu@amazon.com>
From: Jordan Rife <jordan@jrife.io>
Date: Thu, 10 Apr 2025 13:44:07 -0700
X-Gm-Features: ATxdqUFNiqUBXgVBqQ2y3QLdJIa8_JNiNyA_2ihZ5IBO64_T2Fm80tjuTC8LWrg
Message-ID: <CABi4-oiM=4an0Lvrb6uQYp+D7zwon2Viz7uezNQ-q8g7WQv3bw@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 3/5] bpf: udp: Propagate ENOMEM up from bpf_iter_udp_batch
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: aditi.ghag@isovalent.com, bpf@vger.kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"

> I felt this patch is patch 2 but have no strong preference.

Funnily enough, I originally had this as patch 2 but moved it after
much indecision :). I will reorder this in v2.

-Jordan

