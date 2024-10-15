Return-Path: <bpf+bounces-41936-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E60CB99DBC9
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 03:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2509283504
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 01:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99DC158D8F;
	Tue, 15 Oct 2024 01:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8qNy/PK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ED656446;
	Tue, 15 Oct 2024 01:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728956304; cv=none; b=GjpnyrgL6UZ5D6tbtI9CJjNStNJjqezXKZGY/gy51kfQhVma8eLsUQbO08CW/VbaGbnFgG0VF5JSiz7yoJNHShaZGTie+pHdKVaF9zionlKGaF32qISOb0DSCr4ticB4B02gAhDu3Cy27Y00rI5vEfpu66UIBDkWOsOF7R+hoFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728956304; c=relaxed/simple;
	bh=elzzfq05eZoU+VjSm6qK2+/BqoQnyj7YvFdaQYnqve8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=WO7//lUomb6MBCg8d4pRIfIUzQCBXAAlSTw4MHaHJ9WvaEyUUqIes9Zt15Ys+rUE7r7lXJ5k6iyjbCXQtVLh+jJTQvVZIbNW9k7M/hIwEKFIZN1LdMKssMZyPIX4MJuI5TRKDn/DrtKp0WXrQIvseGikaFLxeDu8j7MbrkIDsR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8qNy/PK; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6cc03b649f2so17576406d6.3;
        Mon, 14 Oct 2024 18:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728956302; x=1729561102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLZ7kYDbIAq8sDgweKkp3RxAhHnPY86zXzy8wRMOcOA=;
        b=C8qNy/PKixY7gBH6lrZBojQWC6G/mRG4Hr5zLd7cpVg7n2rC6zdhX1NWBFQ5LLYHO6
         Q61s0BNG/cQXryiGe5ZuEHV3KL/3fdjjGSXuvjI+2vNRdkktgmag44iTYZWV0S4uQPxJ
         R02q9Tck8miQG8vWACBuFHSyEescP8nWjVjtzKLFbod/JhwUUyxIRTie4WcXPHeqPSqx
         reLQN9HZTgNSaGiQvlE82psqodq2aoor9TZdCQkaaBuAc2XuAonZK5u38OKwRdLiQBGc
         ppKSP9/csuWmS9yNc3mbeBH5HAgqDuVWuedUOqEruRcJK76mJo3n9qj7yCVe+ZjUNLq+
         wIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728956302; x=1729561102;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bLZ7kYDbIAq8sDgweKkp3RxAhHnPY86zXzy8wRMOcOA=;
        b=FN7X4mRhpxgp8Wyw+2W2GliG8BUNoBZ/PUUVI/bob8l9uee9OZQGfTra4i1mNg+/WC
         VZbnm0G117hfaYxOn5bL1Rr0DLFrvnHxpJJHXeOXD1Ua4C/DHO3r6w1igN8HFI6+YqxL
         caMSonBxiJWeSsvgY8TGw/A1AlorigdvuHUix7EZiaCrv9Djc6uiAAuzO7gaOVJGgt7K
         nesfHhFZD6PLvJ3XM7iI7rKZ4UoxGlUJ3KcSf82GGrkqOCeX61zrCUh2yzH5YyKKA4yq
         7M52/OBlYlgr2vZjl+jCklvdspDw+XySez9pcM8vuPn1Nl+MpaadcuzK/NCj/0sGX5gT
         NU/g==
X-Forwarded-Encrypted: i=1; AJvYcCU8Pan+decilJHjp+gOFmuAk9cyk7mu3IimMQ5wLz9eYst2GMeJ8TpqZKN1ja3+AZkxMvUr4Zg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXbxg43Iz28bBMeaWpBDYoGI0lu8U0Oago3D+4RlsZUe44CvSI
	e83QgwXQUEZYdUjLz4hCRVlBlkHp3mfeV1RbPxIZ2nlRMxg9rM1oCbFIDA==
X-Google-Smtp-Source: AGHT+IGL+3Z7eIPobvaba/N9GH93LVTqkVay2knUiuAO34M8hk66F391Qbo/6b3LYI5Qb2aTndtvXw==
X-Received: by 2002:a05:6214:4686:b0:6cb:c0cb:c07d with SMTP id 6a1803df08f44-6cbeff9f094mr213836616d6.12.1728956301778;
        Mon, 14 Oct 2024 18:38:21 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc2290f98esm1471616d6.9.2024.10.14.18.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 18:38:21 -0700 (PDT)
Date: Mon, 14 Oct 2024 21:38:20 -0400
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
Message-ID: <670dc78cf28c1_2e17422947f@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241012040651.95616-10-kerneljasonxing@gmail.com>
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <20241012040651.95616-10-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v2 09/12] net-timestamp: add tx OPT_ID_TCP
 support for bpf case
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
> We can set OPT_ID|OPT_ID_TCP before we initialize the last skb
> from each sendmsg. We only set the socket once like how we use
> setsockopt() with OPT_ID|OPT_ID_TCP flags.
> 
> Note: we will check if non-bpf _and_ bpf sk_tsflags have OPT_ID
> flag. If either of them has been set before, we will not initialize
> the key any more, 

Where and how is this achieved?

Also be aware of the subtle distinction between passing OPT_ID_TCP
along with OPT_ID or not.



