Return-Path: <bpf+bounces-42104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2494A99FA9F
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 23:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56F5D1C23B54
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 21:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E815E21E3C5;
	Tue, 15 Oct 2024 21:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUHkbGEP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1018E21E3B4;
	Tue, 15 Oct 2024 21:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729029363; cv=none; b=m2A4R3i73Uu4jsS4teFqOiwSsO+GGUCrqoi9NQakYXlIkfrKXIV/Bwthl3I8hhcKOvYci/cdchOUtQfsRQQq3OIGzPhMyBySRms/hepW6lsRs4t9EFXnQWQo6sVfcOw+/veVbOxyCRS0yQQMbabHiwX2hcW/p5x6jHnDkEQ7K60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729029363; c=relaxed/simple;
	bh=SDDMiSwvUKtjVdXtci4v2XOT6lK4S4zHaRyrw0LDgqU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=iZl+siTXTnch65FpNJioYkMN86m0wC+QFhwBwjz6j2Ai/dv+9mKDEcmYJXYPQHFBrvOtmRUyYSyeX9HmxPsqZwoStNFXOdCbLbLlO2b90VfdJh84uKMDrxw2TpXTeeimKEN80NyGMScXV7qBtopmd+nyq3TBjxVhhl5NKLymDgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUHkbGEP; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-46040dadedfso60906331cf.1;
        Tue, 15 Oct 2024 14:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729029361; x=1729634161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALbA0OtkGhEuyk66SZ8LvdH5SaUs+SRp6a+9/W836nw=;
        b=IUHkbGEPP34UTppC5URkyXJgsUDJerq28dcfNgydxa4/8jkAK919UvRDcr2o0P54e6
         DjsL25YJfk+sZPQjl4+ecn3P3sR8XC7IDYgnGD5uAZ/AziDGaA+z31cWXncOcrdHgr6O
         sdEDe05TU9o/DdhEg3tCtWW71BHECmfbLGx0Xm/nfHlcmzoDC9rV22K5urMSon3uK2ro
         ja9VvG4n5seNmaxAh2gibSL/RbRQ6OaYlrQeUNfGpGX/3O7JEjVVuqk9Pb9pfu4r2YSF
         TiRthkV5TkF/sfkovMbVmNgtw21PyZ6SroMpsMdn9zuiQ8sdjOaGv59/4WPRYUHXMu9T
         ezpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729029361; x=1729634161;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ALbA0OtkGhEuyk66SZ8LvdH5SaUs+SRp6a+9/W836nw=;
        b=lO7hcunf0EtrEQvSxgvHGoV4TCK1xzP1ZgItpcNKIJZHKsJnpwEY1G4oO+7lyc2cNZ
         q7LwnU+Vqz6Qx2a8J/3zAxmrT0ZhHLdxEQCMTv/O5E0hyhwRb50n2y+yeOxWbc3djgOv
         DOPQRxw5zm8HtkgOQaWDKFFtQOoHTSNiS0zhr1TE6+nNF4F7Q79jbu2i8oUqaPaufcC6
         9I3YTJjquNAhYALjKOltAUKvUmEA/U8sfvDu4RZbsihdDmZhNo4jxBJ7LipACd6s0mx6
         lo6fNcQg13rDvqMLPoDN7eRYCNuSv/3r6m6jrbms0nEX5wJXqmoMdzhoKDse8/YqnFcZ
         Vddg==
X-Forwarded-Encrypted: i=1; AJvYcCUM4APIAARD6BaevHc5rt8TiHz0YCPvW0wjQ8TmaI5JuzuPbAuHNd5HLaKyVqZitHWVtyc=@vger.kernel.org, AJvYcCWsCLemGNmjLjSD9Cix0Pnk8VTAnZuC73bsLCK6fmQ6djV0qEJR9wXvDApFABd9kZ0kl/TgLXC0@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt8bGgZ6iiZak7IZy5+bQEjmWfPMO5G/0DSO4WAtfBN5qdKR5d
	b/81+4iBmNbJHKCw3vA+9qBpE8Cu9WwZ7dsmixPUzEaKyzAA+anzST8Z3w==
X-Google-Smtp-Source: AGHT+IF/biGK7BKGx6ds9lQaGsIFu5VWXdLYdNp1Cqk82qtu/FHJCZLwXG3dkyzDgKCeWnsOYMa4LQ==
X-Received: by 2002:a05:622a:250b:b0:458:29fe:d254 with SMTP id d75a77b69052e-4608a52b41amr24565931cf.59.1729029360926;
        Tue, 15 Oct 2024 14:56:00 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4607b0fa227sm10800231cf.32.2024.10.15.14.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 14:56:00 -0700 (PDT)
Date: Tue, 15 Oct 2024 17:55:59 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, 
 Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <670ee4efea023_322ac329445@willemb.c.googlers.com.notmuch>
In-Reply-To: <cb96b56a-0c00-4f57-b4b5-8a7e00065cdc@linux.dev>
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <20241012040651.95616-3-kerneljasonxing@gmail.com>
 <cb96b56a-0c00-4f57-b4b5-8a7e00065cdc@linux.dev>
Subject: Re: [PATCH net-next v2 02/12] net-timestamp: open gate for
 bpf_setsockopt
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Martin KaFai Lau wrote:
> On 10/11/24 9:06 PM, Jason Xing wrote:
> >   static int sol_socket_sockopt(struct sock *sk, int optname,
> >   			      char *optval, int *optlen,
> >   			      bool getopt)
> >   {
> > +	struct so_timestamping ts;
> > +	int ret = 0;
> > +
> >   	switch (optname) {
> >   	case SO_REUSEADDR:
> >   	case SO_SNDBUF:
> > @@ -5225,6 +5245,13 @@ static int sol_socket_sockopt(struct sock *sk, int optname,
> >   		break;
> >   	case SO_BINDTODEVICE:
> >   		break;
> > +	case SO_TIMESTAMPING_NEW:
> > +	case SO_TIMESTAMPING_OLD:
> 
> How about remove the "_OLD" support ?

+1 I forgot to mention that yesterday.



