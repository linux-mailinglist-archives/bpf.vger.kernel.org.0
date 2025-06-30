Return-Path: <bpf+bounces-61854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB8DAEE248
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 17:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9634189A7BD
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 15:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BEE28DF00;
	Mon, 30 Jun 2025 15:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbwcMsN7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69411284679;
	Mon, 30 Jun 2025 15:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751297029; cv=none; b=K3Mnj3FJgd/jFflkAQGrR7rSLc1vUuS+1n94V7D29ZIp6/BUFF/I41G0smOlDwtfEeikW56Lcl0+zwKkVwgKoI/T/ABPO7SyvRvilGa2QOVQoPWrYMAF/LbIANI+sUWKPPA56t92NzLH4CumS2k+ADXZPa9un3Qa/OhTuMmCdkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751297029; c=relaxed/simple;
	bh=WridHKWMSH3/3DHi6VOoVFI5yEywRU4M1EeYGx6uplc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqbFmmn16EMoyb+n93a/QPvTGXDaeq2mX7RayaAGngjrKZCqW2QWPsb4OniOPUi7ziGQchVilDUqd6JSISj6PfEmhNyytI0qSZWdAhk8M5qj2GcrMpvtwoUB7+w0EjXMgygFPbuySX1sb7AYIRS4gav1pf2ceeBd5ddpgxihb8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbwcMsN7; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3122368d7cfso2919153a91.1;
        Mon, 30 Jun 2025 08:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751297027; x=1751901827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kSp9mfEjlX0kZ4Q6UH6CG7ddVH5ZdVCTMUB3Iwz+3MU=;
        b=XbwcMsN7kDNmbTAptJe3bV0pV0nSp9bp0nuEdoOcftl4RwQ82kfuj5T6k4NSdo+wF5
         zFy3iV3monxUw9dM32VCW+mD98PVkKIRNmT1jt+sygMjdx5w4+xVjsDClyre1tQcFIwu
         sNp55LyUM/wC1MfnHCtCgSEz/ZBHaFEtUuvx1VOJdkyEGNG+M+mjxpuQZQZTyNHJYcvz
         UMmDcbAaMN1zd+lpIUwdZW1eUQvVJhUm5oW3e3EohhSc0P07aFMihers90QhzQ7chPcX
         bSbLZaunxTaJqj79brKsJLRUMyUffu7VrmJiL6fWtRTNgQZROWbE1CbNxeBWBJ6BElku
         18KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751297027; x=1751901827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSp9mfEjlX0kZ4Q6UH6CG7ddVH5ZdVCTMUB3Iwz+3MU=;
        b=uhRAmPDPJBcjdFdY5Wbl5VE8boDWtJQdA3r1YaUZlnLojLo6rCFb4hkyyC6/lex9Ev
         zxUqdBMeSvkPs8UKbZjEqeHNS2QdQ6YD9rGWNU/d86d81H9xS8kNGAw7YftF7TPLcE4j
         3fsuxhN1FF9tvjwlc2XAR5O3nNGSrqqxICOrZptpS8xkTBsGqRp8XBku+CUeWrdGyT4a
         GM9k9AGVvgK7NfuK/SSbrFZ6lTEYnynGRDFRGMbHV8CVgH/Zy4dIvfOHvqropkqT3zpC
         wyyyyiIBmOP/U9WPzKujNWwcNWFBzUyhd3jSxdhak/kT6YZFo5jWcfLK9WyRAcf/nrKn
         0q+g==
X-Forwarded-Encrypted: i=1; AJvYcCWk6b8JBnfWs2LgF9ilVWeAc5MkpVtdq3na/y+GuyKkyws3Jjvg1KqVqJw47mTfWPKMko2FYIxa@vger.kernel.org, AJvYcCX+cGbc4wl5yomdm3Tc5LqJGQgYCyOQg0NUC4qWlZIvOmihSIlbJNn7KGUyToWncsD+bSs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx03z/BJcaZyHYZ5o1QU2tIfUHE2T/4WhSOtnYnY92w1xJt82tw
	5Gk3QIMMYeRGGaynZAtzomVadzJb6K+5UTqR3hzMZx+KuuvC/5Nb4gs=
X-Gm-Gg: ASbGncvE0LdQmee8rUIqvdbTFqqoZDWN6IvlkoOdHX9r3Ggq+h/2OlDvyiRTlIQMYGO
	I0izcrei9l7rIN6uf+VlnWue09FBiwFD5DTsUwIqJenHLo8Kb1dD9R4wwYLcSCxOe8O8eL9UbWT
	9TSvuHkb5gfevHm8jcclw1rt7nRZnbeViWU1YdEIBfgyVxygSYBJvXY0l9E6C49jiFWbTgaW76f
	i4qRXGLKcXPpsjYqTEinXTqU/Qe42iqxxdD1yAFXaJ82VCSle1opZewv86hRtahCHXs0rKSHigX
	NCeUIilQFC+d4imi4CzifqL6L+ACv80rE7UKom+/D8I2PYfagrDeMkTUWiH+hDO2aJ8b6rXPo38
	vjHHlrUuttSNljleGOVa3AcI=
X-Google-Smtp-Source: AGHT+IG8o0IEqGbychOj+zwyXb6twai8wIxcXDDb7EfuCDwZ9cbrEXbCyLhSOapzoM/vaWEnw1KvbA==
X-Received: by 2002:a17:90b:3890:b0:315:6f2b:ce53 with SMTP id 98e67ed59e1d1-318c92e317amr19245157a91.25.1751297026512;
        Mon, 30 Jun 2025 08:23:46 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-315f5426bf0sm14150838a91.23.2025.06.30.08.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 08:23:46 -0700 (PDT)
Date: Mon, 30 Jun 2025 08:23:45 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	bjorn@kernel.org, magnus.karlsson@intel.com,
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	joe@dama.to, willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v4 1/2] net: xsk: update tx queue consumer
 immediately after transmission
Message-ID: <aGKsASYLRO0P5npe@mini-arch>
References: <20250627085745.53173-1-kerneljasonxing@gmail.com>
 <20250627085745.53173-2-kerneljasonxing@gmail.com>
 <aGJ5t2hvN9wX+vxh@boxer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aGJ5t2hvN9wX+vxh@boxer>

On 06/30, Maciej Fijalkowski wrote:
> On Fri, Jun 27, 2025 at 04:57:44PM +0800, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> > 
> > For afxdp, the return value of sendto() syscall doesn't reflect how many
> > descs handled in the kernel. One of use cases is that when user-space
> > application tries to know the number of transmitted skbs and then decides
> > if it continues to send, say, is it stopped due to max tx budget?
> > 
> > The following formular can be used after sending to learn how many
> > skbs/descs the kernel takes care of:
> > 
> >   tx_queue.consumers_before - tx_queue.consumers_after
> > 
> > Prior to the current patch, in non-zc mode, the consumer of tx queue is
> > not immediately updated at the end of each sendto syscall when error
> > occurs, which leads to the consumer value out-of-dated from the perspective
> > of user space. So this patch requires store operation to pass the cached
> > value to the shared value to handle the problem.
> > 
> > More than those explicit errors appearing in the while() loop in
> > __xsk_generic_xmit(), there are a few possible error cases that might
> > be neglected in the following call trace:
> > __xsk_generic_xmit()
> >     xskq_cons_peek_desc()
> >         xskq_cons_read_desc()
> > 	    xskq_cons_is_valid_desc()
> > It will also cause the premature exit in the while() loop even if not
> > all the descs are consumed.
> > 
> > Based on the above analysis, using @sent_frame could cover all the possible
> > cases where it might lead to out-of-dated global state of consumer after
> > finishing __xsk_generic_xmit().
> > 
> > The patch also adds a common helper __xsk_tx_release() to keep align
> > with the zc mode usage in xsk_tx_release().
> > 
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> 
> Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

