Return-Path: <bpf+bounces-56618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8454A9B299
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 17:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCC123B2AC7
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 15:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D0327EC67;
	Thu, 24 Apr 2025 15:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="JOCCm0no"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1693422156E
	for <bpf@vger.kernel.org>; Thu, 24 Apr 2025 15:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509166; cv=none; b=E3ZQkWcd8ikn10rfYn8GKOsmaemtjUTKvfzs2cWVCtsiSnEK+vN/aI8aiXxLWGwXiPQ7EdWo4zP+2g4NjBuKXFJaaVpIxa0gm9T0lzD1qxIkOzwVoepJPMhnPIv2vu6p1GSucVb13wrYbFraCmu0IAxYUkXNPsVMB/9poM9VoJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509166; c=relaxed/simple;
	bh=6Syfv68ya2kxhhOlKYpJGON8W4kq7aWIngNghhx0etM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgnQk6XpVElBCRu3h5YfOzghJCqYlsnBlBBWu6tNSYTLzjjrRpWMbaGv41YbYILKjKpwETg0YVDxmWnJ7LSrQiwMgjqOvX/FE/7bzgORyb8fjRmF7s6T2RjXml91ZtZerzeRlZyqsDlr20J2Y4kG5Pt21TWM526SvLD09MX3f/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=JOCCm0no; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22409402574so2350435ad.1
        for <bpf@vger.kernel.org>; Thu, 24 Apr 2025 08:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1745509164; x=1746113964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Syfv68ya2kxhhOlKYpJGON8W4kq7aWIngNghhx0etM=;
        b=JOCCm0no35J0/hVKUoJ6AZze/D9CAEb5oGpbB9bMc8DnYsX0Qa7Dk3+axtSeIO40xw
         FGyeT+6INTX/wvNINKxdT7I34y0d5coTzAxQffroiW73DbiJzKJi9cgcv50hiIWGD4Oe
         ob5oqR+xu2iu/YIsNrjnKxBKFwC2ZC+oP2J0UQKkcyb/JcJ1I9T8d7Cb2pnT2ZJCWa8x
         saEhxI+cboCzAXmsc+L9Ue4A4Xzckpkk70qUMtE82Mmm5G9Tg8kFM73mwh1nnsg013TB
         tq6WVFFCQq0TupqY3fCCXf3e605ufCTrA1jHGzcffeSDBEPwmt3YHaFIWBzc+SnbwJoZ
         rthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745509164; x=1746113964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Syfv68ya2kxhhOlKYpJGON8W4kq7aWIngNghhx0etM=;
        b=binwSlHJMNz+gEUrA2bKlHkYhWlVSjdpVPsvkGWGg41NLTUg7mxynVJ6DVySq7fxwv
         5f6N31V7bAX0RD9Ij0fHzzxuOuaqOeF1ThwHvh5FXiK+I9kq+ma0YX3X+/jGswE7B/A0
         o5co1zGnapVytKrGR4m+a6SAx79oR1+tgSOdYf06HEEzHsR8oZo/R36e1NJkKgOnFsPT
         1OorVFMDtIJi9yq2SDi/WBkopD5xvzMuj07Ic4V4ctMvVIlq1+xOS1iMpfHrXzHXf5Q2
         c5on5sNcBtu/TJRmWiyZ+ta96862ydxJ4pxDzjKRobZH+B2/sWeYe70YgHqY79+rmse+
         erUw==
X-Forwarded-Encrypted: i=1; AJvYcCXf0IXBOKJGB04s3X05GtX7Zl3K0d4aIKc8DzQ+6b65fS/wa/f1qTz9B+Fu8ZUDV0LWmHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya/2oSSOYwXZgw5V+wVlAvy19XVmCf+O85j+P7AcH9zH0OEGiy
	fqtGX34VHczX1PTD2uPHL8IBYaUbj11eUPLZNUy4oGbdS3j8nkIHkKgOMqNPi7fEPjus4gZ08FH
	tutY=
X-Gm-Gg: ASbGncu9CsfBN0WR58creu1zUe/xPcxnlGGOQDKUTdLGJFr+iiw3oPwbtU8ZtDlf9dO
	nQwjYnQfXVC1dd3jNoywJ65VHCFqagcL9jmM8t8hPNdaLIS5TxYgUICiN9xvmLO+aLr9UzzMTpx
	gr9GvBLS/qNNuS/hXwbOxerEED7molTeg6fHtoRCFxwQE/5rYWNsKFTrOHaqCyOrBNnk3No7X8d
	mDNmy9QkGSkOcRP4jFf/+2zKaRcvdHsBbsHmssAXLfjLXqtVWofnv75uMSsiVQdWLQHdAyD6K7G
	6Xk3I8rLGoMH1n80Pj/KkP2KRXI=
X-Google-Smtp-Source: AGHT+IEl/I2tNTHCTuDgjtLrO3THCbXJ8y1SjnxJHINYfNLGwjnowhM0VX+Irll3a++T9633lTd+oQ==
X-Received: by 2002:a17:903:90e:b0:220:e98e:4f17 with SMTP id d9443c01a7336-22db3bb70f7mr15215245ad.2.1745509164237;
        Thu, 24 Apr 2025 08:39:24 -0700 (PDT)
Received: from t14 ([2001:5a8:4528:b100:f4b1:8a64:c239:dca3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db50e7636sm14977335ad.117.2025.04.24.08.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 08:39:23 -0700 (PDT)
Date: Thu, 24 Apr 2025 08:39:21 -0700
From: Jordan Rife <jordan@jrife.io>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Network Development <netdev@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Aditi Ghag <aditi.ghag@isovalent.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH v5 bpf-next 2/6] bpf: udp: Make sure iter->batch always
 contains a full bucket snapshot
Message-ID: <kjcasjtjil6br6qton7uz52ql25udddmzbraaw6qmjadbqj5xm@3o5c2rgdt5bt>
References: <20250423235115.1885611-1-jordan@jrife.io>
 <20250423235115.1885611-3-jordan@jrife.io>
 <CAADnVQLTJt5zxuuuF9WZBd9Ui8r0ixvo37ohySX8X9U4kk9XbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLTJt5zxuuuF9WZBd9Ui8r0ixvo37ohySX8X9U4kk9XbA@mail.gmail.com>

> It looks like overdesign.
> I think it would be much simpler to do GFP_USER once,

Martin expressed a preference for retrying GFP_USER, so I'll let him
chime in here, but I'm fine the simpler approach. There were some
concerns about maximizing the chances that allocation succeeds, but
this situation should be be rare anyway, so yeah retries are probably
overkill.

> grab the lock and follow with GFP_NOWAIT|__GFP_NOWARN.
> GFP_ATOMIC will deplete memory reserves.
> bpf iterator is certainly not a critical operation, so use GFP_NOWAIT.

Yeah, GFP_NOWAIT makes sense. Will do.

Jordan

