Return-Path: <bpf+bounces-56211-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3CFA92E7C
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 01:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5AF77B4AF8
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 23:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E36C2236F2;
	Thu, 17 Apr 2025 23:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="iIuShzUt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE00722154B
	for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 23:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744934236; cv=none; b=rETh7QzAM+s1zy+9JpGXc1yRFN69uJOYT1vClY8HoxjFTGZUo90rpGZrlNVCUo4jBPNKAABfMrMNNbnyMfC8M4PMm3BfiuMURQpV9bibUhiFfOzXy0nBbh2Kf0a0Ni5p/5nyGgMeqCRkpvOdO0phqabd6Xuvbl/HNBgkzpGGkNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744934236; c=relaxed/simple;
	bh=06wqFlIt2yf7O6pvffCzLE6iuLFghozPfXIqq5cM2qM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnUtHJVa3EBi3UJPXrAiE5fpIbAeljdPVoqVNBlzhLkz1lq6Tykvgg4WQF6qvYIQ2W5rwwr2dFJLYRxNm4F/vFvoWGVZIkSHXFipSyTp2iJAJoje8bN/3rm0r+p19PeKCijSfhRAIKiNjxu2MNb+YBOvmliPZ4Ottbsm7RECWj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=iIuShzUt; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2240b4de10eso2802445ad.1
        for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 16:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1744934234; x=1745539034; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B0dCIx+23zeXhuIp/i1MBELdaqZWYnVSQg2h+CzEaos=;
        b=iIuShzUtOwa9kcwzV+ZFiXGuQu+qSV6VJ3dYUB5BE1/LdkcWASX5USnEgSzqF8/U/z
         85yr1twZToWmEAMsGRY0rIgEE88YECNLN0+nTWjav0OB7tsQmqkn7RLG7XmCYeODBChy
         3Z9Xlbwzick7T7UFf+5Ff++vSjfSfX5qP2rIr/EAar/9yE8nrP4mJb7j4n4grjGRPq9d
         EHpHodKsszoL3Nf1jQ8YjbPmokuJf1QaDA6JwdFNokUq1XKrOs1eKzO47VtMsSDPBFWq
         KizAH1VByJisNuDqB/i4IVsyIBeXlpLt01Q38Y49wruqYAwpajFbwrgMw5BlM8g7nLm3
         sprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744934234; x=1745539034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0dCIx+23zeXhuIp/i1MBELdaqZWYnVSQg2h+CzEaos=;
        b=SCif3ar0LM7NzRmvW3QzjV/oPbBb9TfcH7i7OCxePYeRx1AE6jQ9tGNi9E+Swqy4Wr
         SBtp0KQARsnrPBbebLt/WfaEv9xeDurFNqubB17PTf8S0j2qxEWCbpnj1dxIg/5xp9Fr
         uIH4/sbxLVruusVH2fBDO9wX76nrlgzyKrwvX5wBgk5FAxz6AWgHI7GABmXHRhbybZGM
         6vhQVcUF+b9InGa0+JUHVBgud6FsyniRhd8rm4/JHn8sUphWmM10qDpjWR3uxDw2vSn6
         E0uhLMf0Hkt1Q1H/ocMCI21YUWt+/0oeD8WlmdqILkb8G5ayiV30pGnEApqaNDa2ry/8
         UjKA==
X-Forwarded-Encrypted: i=1; AJvYcCW4fh6//XKoa/OC3KdyTFCU69eFBs/JE+WoRTh+Klr6nbUIicxzxKuJ6utDTzq1+EmSfLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqO4xwtvJ9auip/XxYW2xsiXS/lwKnhVtK5M40oAuMCbt+SS++
	oGLoyIpD44HlFWdr2AmBQURKygCECH/doxmdNxT4QGtj0KPmeeo4nyHakhgNhMSrGCZ9fG+0stq
	/6Ko=
X-Gm-Gg: ASbGnctrxczS3tmCrpRAzAU/0GqNBEfR8H4j9jH2rnusZNyMfykJDyvnw/pFUy77/RO
	4A/amYr1FNMtsj4txCL8kmvohuZmiS3kRaDDPRwXx3S0UWQ//qUg9slXSVcsdI0++4Q9/EZv8r1
	py9jq+SgBBMnhZGCxxTSqN18gmCvhyiW+fi6VEcRGAOp5/6/U8JyDlL3fwxrDkstUgP5GGG/Xef
	vQZncj4xUbjE2XmCbCyv8RLKQ3JPpuL5eO7/R/PzJQhBSSR7EePGmByNRvUsY8UMtkC3Sv7JdP6
	lqzPLaUJ87DykfI04gq5ZHCqN3vDQVIiXZ8ABg==
X-Google-Smtp-Source: AGHT+IEyeges0Q+A9GU9VfCdbdKZyaQgXlpFAM/VkFT6WA17RmTMNBRBhdobteISV8UeA/fq85tbdQ==
X-Received: by 2002:a17:902:fc8f:b0:215:2bfb:3cd7 with SMTP id d9443c01a7336-22c5360a8edmr4221325ad.10.1744934234065;
        Thu, 17 Apr 2025 16:57:14 -0700 (PDT)
Received: from t14 ([2001:5a8:4528:b100:2a7b:648e:57e0:a738])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bf55fcsm6107075ad.80.2025.04.17.16.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 16:57:13 -0700 (PDT)
Date: Thu, 17 Apr 2025 16:57:11 -0700
From: Jordan Rife <jordan@jrife.io>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: aditi.ghag@isovalent.com, bpf@vger.kernel.org, daniel@iogearbox.net,
	martin.lau@linux.dev, netdev@vger.kernel.org,
	willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH v3 bpf-next 2/6] bpf: udp: Make sure iter->batch always
 contains a full bucket snapshot
Message-ID: <aAGVV0JtJDMR1O0Z@t14>
References: <20250416233622.1212256-3-jordan@jrife.io>
 <20250417234511.39315-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417234511.39315-1-kuniyu@amazon.com>

> > @@ -3454,15 +3460,26 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
> >  				batch_sks++;
> >  			}
> >  		}
> > -		spin_unlock_bh(&hslot2->lock);
> >  
> >  		if (iter->end_sk)
> >  			break;
> > +next_bucket:
> > +		/* Somehow the bucket was emptied or all matching sockets were
> > +		 * removed while we held onto its lock. This should not happen.
> > +		 */
> > +		if (WARN_ON_ONCE(!resizes))
> > +			/* Best effort; reset the resize budget and move on. */
> > +			resizes = MAX_REALLOC_ATTEMPTS;
> > +		if (lock)
> > +			spin_unlock_bh(lock);
> > +		lock = NULL;
> >  	}
> >  
> >  	/* All done: no batch made. */
> >  	if (!iter->end_sk)
> > -		return NULL;
> > +		goto done;
> 
> If we jump here when no UDP socket exists, uninitialised sk is returned.
> Maybe move this condition down below the sk initialisation.

In this case, we'd want to return NULL just like it did before, since
there's no socket in the batch. Do you want me to make this more
explicit by setting sk = NULL here?

-Jordan

