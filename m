Return-Path: <bpf+bounces-51834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCD3A39EAF
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 15:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB30E3AB322
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 14:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5628726A0B9;
	Tue, 18 Feb 2025 14:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0fxMXaD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75782269D1C;
	Tue, 18 Feb 2025 14:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739888623; cv=none; b=T/iwdh0nCO2Y2YDFlIz7pXhy1nOo5glcJpit/EhNXTGZ5lozUU1aAjBJoDB9L6Zd1Vr0f2B/uCD5JP5Dkw/WYfZmaQy3v3o3Kv5M1uxcJPlykGVUfcsRIg36SNLQhCBICVnGN6pjk0/AbnEFvcXiqRIWZcgnpnIhInWsH5N286A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739888623; c=relaxed/simple;
	bh=22iqV8a3Sgjlou3PsevQZHpfy6TnDsCwo2wBLJaMWxQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=mIQYRTP+wKH/U254bA87ZPk/J/+mnnf1gudQtiKOkWIWxfNJlpIRDU8pWKYGL6PTd9eTw0UUGk+ndid2+ygJBD4oFl7lI2Wkfhd2xszs4Id50kqXl3bqtbHFCbPZA1/1pbJbgZ0rrhg2x0F+M9sgjzfXwhaUX6vjr3xTqSqoQC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0fxMXaD; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e65baef2edso42331716d6.2;
        Tue, 18 Feb 2025 06:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739888621; x=1740493421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IyMEOBPlZMw8XtrrAydwQbyCKT36rllR02UssE/iUUA=;
        b=X0fxMXaDsXsbtdhkeyzQ/ZP5VSD/8anWyY2W9N1jHBSENmIAZUHprZ5lYu7v98K741
         Fz39zU8CCWc4DCbUBRGxu67tR/UQhjGSpoF/FD79xEwtzAT+g7jV6PMwcHunSd0HYgli
         gMJfXXdtjInJlIw4zplg98RYlln0NF7g4OfvqMip2+2AYfqBwsZ6W9dTRwhS7CZI+Rin
         1pvQnuGHt0pzHBm4heccs9aII5HIFGjmLg+KcO1LWLlhhEvAZ1OcLCLZzIsVr4DgEk56
         BJGqW4XnLTEduWOISsZyV8zAZbQxJqflrVpnttIgLJKg1zG7SxvvjIm+9wx+aIgsMNLl
         yiyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739888621; x=1740493421;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IyMEOBPlZMw8XtrrAydwQbyCKT36rllR02UssE/iUUA=;
        b=hDZkVe+DjyswD1dylmGDx08vt42X/kcJMMEyGBcnXsztMBXfZbz0/KnysWu4bczAcH
         7viuO84X/1caNr3vJFgoZBlFrsQpaGf4VTZE2JbIWtzTdDZkmjbplJ5nz/9+CtNpDRC3
         a5ZIOr+hQltAyahMyAZbktiK/RrxubrTeLl57sR43d7fRsRiC+5o19GrZNi2qMfE2N72
         LCrULt9B9t6JOglDNEL2bb8XaB9/4a5GJDwRBxM4SaKZxFM5C7vpywV2I2Ceqe+C5EEk
         yZKxbUBCpMeEVFdA2jIcueDHjZQN8b8HZ5YfGdrCAOvZWqUnPwg1SU7XsO/eMezJVBT2
         ZunQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6xJdvtdvhmbQkCTBJIBu+j69s4vlNpQHcr+ebuP9Q9I07gUBouqMHAN5DVO1HQeHQKB6rTjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxezizAyxCimb9tTFY6HNa+j9HVN+afep5+a4lQreQLgCUvsnDz
	JsaWx4WBmSEoIfZ1L4aIm4W3/5SU4PtF2GDyl2HDcwoM6E+028SH
X-Gm-Gg: ASbGncs5MB5g9yfu06j51Kj/vVezmTqANEH2PN1QTjmLbavLYsQUs9w6BFLj8MBcO2v
	Jw5SRS+jvj7uXd5/JDVGqgpWE7MI+gh5y3ZEeYYmoPjxkuonSAgsEra8AxlBP2XCjszDrwoGB0E
	qqDc1G/8QZqkTFluaOoUtxOMUlUe+VfkR02luobBXfcPeGjK/yy5ymhfQSmPhcTkVtalcPu+wtg
	nwJQ8pWV5MB05dKtJicIbyN1LftQYjEenWh5IlrKc1ZiMfN4JW/P+en+DN5dTbuNFqLyEEBRv3t
	lqlFQ5sZDqo5q9GzFJj3hcbpWKwrwKb/OaColG7SX4/GUmFdNino9V7HfxCQW+4=
X-Google-Smtp-Source: AGHT+IGwLyOVvCwL+8O3FFNwTakJ3vlDbleayghe8TJdQP6qxOHLZl82GJGrkTWhZ8pBNcn8Zc8r1w==
X-Received: by 2002:a05:6214:27e2:b0:6e2:481b:7cd9 with SMTP id 6a1803df08f44-6e66cce4446mr196589926d6.25.1739888621289;
        Tue, 18 Feb 2025 06:23:41 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7a427esm64233576d6.63.2025.02.18.06.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 06:23:40 -0800 (PST)
Date: Tue, 18 Feb 2025 09:23:40 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 shuah@kernel.org, 
 ykolal@fb.com
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kerneljasonxing@gmail.com>
Message-ID: <67b497ec45c3e_10d6a329438@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250218050125.73676-8-kerneljasonxing@gmail.com>
References: <20250218050125.73676-1-kerneljasonxing@gmail.com>
 <20250218050125.73676-8-kerneljasonxing@gmail.com>
Subject: Re: [PATCH bpf-next v12 07/12] bpf: add BPF_SOCK_OPS_TS_SW_OPT_CB
 callback
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Xing wrote:
> Support sw SCM_TSTAMP_SND case for bpf timestamping.
> 
> Add a new sock_ops callback, BPF_SOCK_OPS_TS_SW_OPT_CB. This
> callback will occur at the same timestamping point as the user
> space's software SCM_TSTAMP_SND. The BPF program can use it to
> get the same SCM_TSTAMP_SND timestamp without modifying the
> user-space application.
> 
> Based on this patch, BPF program will get the software
> timestamp when the driver is ready to send the skb. In the
> sebsequent patch, the hardware timestamp will be supported.
> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

