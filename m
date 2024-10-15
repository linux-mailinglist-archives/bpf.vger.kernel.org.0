Return-Path: <bpf+bounces-41935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6053A99DBC5
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 03:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 254942876B1
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 01:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFE2156243;
	Tue, 15 Oct 2024 01:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbPWQnmq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0242E5FEED;
	Tue, 15 Oct 2024 01:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728956179; cv=none; b=lWVTGhjRGKkwBGDnHUPPBcKif3b7+pB+UraewlGfutRrf9peu7dPlEGE+hG/c+RS8KTYnTvyhdWxm2x8y7zjCsYq8AB0LDqEVjKqYNvu9VG88l6g2wX2ZOtuJdhO6mhMpaugOKhrRI5gOiyN0qrP21B8UuQS6NAlsADkT21Ui4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728956179; c=relaxed/simple;
	bh=wzVGORgAO2PR16ZnmSGoe+55EjogxRbHmdR+iNhpQXI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ujneYUEVBrkuRxyO9XA+tmITml0T1gb+dxs9nOmR54KpM5cKMAoPfZs7N1lZaqvq0mvbbWd1WQ3jIlD4JXVnAACCmiPNeDIycA5yliWQDWhIhpieaaIR9BVvx7sOdj1spa/Rbp3N+9ZVQcuzrbRJR1QCFlgwcMDz0U3rSQGS7V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbPWQnmq; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6c5acb785f2so25481036d6.0;
        Mon, 14 Oct 2024 18:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728956177; x=1729560977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyHspsS4/mwJSm6jZ1ZmTqfPiPp4r6rB8ZK6Vs15ibs=;
        b=LbPWQnmq5yXJH3lddkew4+c9rX1J134OKbD1m7ABLIsPfbAbFfBv7j7Zg2wesOm9o2
         rAv5Vxkk6YRMFxFcRi7RQxNGg6Z11Wp6O44/IWOUyZD4+GxSsVACrpy6m9F2OCTSfu+D
         rBSQsbLTRNdoDqLqdlIHRJOpZ28jaYD1J3xrciTVd4ifrTs7CGFC32yOm87UnAaUNatR
         mLgUFAl2FBjqvgivl0CGttZg4Ch+mJsSq9gPOeYo0gVj+3wSI0EMz6aeByfik+IlMjdP
         hAFe/gmTx2t1lq+M4+/bHJ70xyqVEr9xeXH7Lg3XSq0jEE7e/SE3BjY8o2Lmw/Y8HvFl
         Xreg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728956177; x=1729560977;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XyHspsS4/mwJSm6jZ1ZmTqfPiPp4r6rB8ZK6Vs15ibs=;
        b=inrwzjpqzA+Dc757rCm3M93BAiQQDr702ku70RK1r+pjyu/IsPLXRFsXTMYCP7AyDl
         WiikVURNnysrOaSMqKq2tcsKLvOeS8r5aF11HLjsYiH++LhS1qgBTsAHdD8r/1EV+33X
         u+oWtOlcAHYpJ16dUKecUD/9FCo9vmnZMQcVHRdAz0GWk+voqcgzXG1k1YcVoAD7Q1Pk
         6GSCgHa1aYAB3DK85aElflU0r5RDAsibPDgNbwsDjA1BpWoYr5X7LZZz2dbwUwq2Kr2O
         HUvOp9bUiPGojgb50m5o7viSuo5stfL/3haPTpnmMWX9rXAwHf4lapDfb4rFXLSHSugp
         0Atw==
X-Forwarded-Encrypted: i=1; AJvYcCWOrg8FqzlCrFcqb8RsGA2TujMH5D82qrC1I1qW+q8hBKJm5nO9osJCX9hnX1n5uJ8Z+T82NJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhBT4eSPQzBRbAFgUFK4b5PaOKzRIR69EYK22R5ow10wGuAs4I
	Ht7kRBflMTP0vPypEDVDcQNe3DS9sgF7sEuZ1DSCzrnVq6R84l48Jnud7Q==
X-Google-Smtp-Source: AGHT+IFwy+UXvnaIPUp8nB/+L5j5kJqjh6YMnzM/tKMAI3ct1+8wKeKoPPv0bcuRqTBFPhnxFgwYIg==
X-Received: by 2002:a05:6214:2f0b:b0:6cb:ebfa:c478 with SMTP id 6a1803df08f44-6cbf0032130mr245426686d6.28.1728956176846;
        Mon, 14 Oct 2024 18:36:16 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc22959b25sm1391556d6.79.2024.10.14.18.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 18:36:16 -0700 (PDT)
Date: Mon, 14 Oct 2024 21:36:15 -0400
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
 jolsa@kernel.org
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <670dc70fe946f_2e1742294e4@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241012040651.95616-5-kerneljasonxing@gmail.com>
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <20241012040651.95616-5-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v2 04/12] net-timestamp: add static key to
 control the whole bpf extension
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
> From: Jason Xing <kernelxing@tencent.com>
> 
> Willem suggested that we use a static key to control. The advantage
> is that we will not affect the existing applications at all if we
> don't load BPF program.
> 
> In this patch, except the static key, I also add one logic that is
> used to test if the socket has enabled its tsflags in order to
> support bpf logic to allow both cases to happen at the same time.

These two features are unrelated, should probably be separate patches.

> Or else, the skb carring related timestamp flag doesn't know which
> way of printing is desirable.
> 
> One thing important is this patch allows print from both applications
> and bpf program at the same time. Now we have three kinds of print:
> 1) only BPF program prints
> 2) only application program prints
> 3) both can print without side effect
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>


