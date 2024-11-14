Return-Path: <bpf+bounces-44844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A87519C8D68
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 15:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E247282179
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 14:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E563133987;
	Thu, 14 Nov 2024 14:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVSIF4JE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5A6770FE;
	Thu, 14 Nov 2024 14:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731596177; cv=none; b=dw4va7IRXUDYPhQSq5sIa5ZNw4VQW5gV1fiN3Y0rnUXilJYSIxjA44KlQpvr6oQVB16BaCB4qioH5/a/K5MTegAX95wEzmET+7NC/dJYR1O27aGk0nF7332bPLJUIqxWJULBrQ5uKXhbnlFP4TNWt5R2u+4jFRTslmjRq1z0ufs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731596177; c=relaxed/simple;
	bh=5sOe9ripCxbSEVyi9HSWTx+dlYBbi2HF+KFmFLJmqIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ct3l1RsafEQWMATyzmHSwVDR+AgmbqvmJFroqV3JZDZr2rjUOh4DTY96M5i/6PJ1pnjBiXg1qgbt0HhcyO/+HuwL4gvT+DmX1GXmmvtP/hD5zFl9n2tEu8ybFi2TqFJnjfeqmAXQeUR4fbXgaY11bApltDrP6mJZ8dR6JZGYe7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVSIF4JE; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43193678216so6957125e9.0;
        Thu, 14 Nov 2024 06:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731596174; x=1732200974; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ypIe2x5wqkPNzyRl0qrW7xKxln38d/rreWFO8HGI778=;
        b=kVSIF4JE4UKJyHl8ZYMzhKxkofQ8bWgd8BrIxqftmFDiqB2F6JLkovGrcjywbXcC+M
         kDmf4QRD7t7DjvjTBMg6WAmjW1TyhdYlYA2fHE/BHAtb6dj5p7L3tZ/YESygT/+XSc1Y
         YGH1Tl/KIus7JNxhzW5rtH5/vuwfp+nrRb6OuT6caZ1bI3ycwmFiUTgU1dcPdynoZiEx
         29yrtxuANeLnYRs7XTJra7Tr4jIGHZkzuVtjWz6YK/ixclt7zvJIDRh74wi5z02LAhYM
         grGJELPxs9803D6y5MyKNm2U7OkaNsVdCrcCdQd0SLw7I4uaj6Gnlj4xM6Fv4f0ttR8c
         ghHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731596174; x=1732200974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypIe2x5wqkPNzyRl0qrW7xKxln38d/rreWFO8HGI778=;
        b=fCf2uch7E/Y6E1uatyYnO7UDeCScQJ9OPd4KubjjSXRLsqHIWU89gI3/93tHnX7bK9
         vVrcngt7jjIEBckQ2cZ+4sD1SKn4RYQsovnwFYGeY6vYPLX77Rx21n3wkNcYNaq677Zr
         u20Ri9dwILMMqkCu1zFKt4xDR9BsigunJUIQ5gZvgwcB50whmGJseWRCg1+/a5dbRsWc
         Q7zFYBKa1IHJlZkK/hux5jUvnnmtOggTjcFWN5x1C0EDx+10f1WAMTO0uUGRleK/nwJi
         DZlFfY1Jsfz8NkBOp6mdfV3ERaYTDFV2h0SPgxCs2zJhvt6Ux0D9VpTD6cRYXjJTVHkL
         ZYfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkYnS7a2PhFOVwnUoYcabSZp+ta9Em2vXZRTfz8dCjvHi9OKDA1sZluHo0WXUctndjqlSqLTbTWRecCP1P@vger.kernel.org, AJvYcCXzQcdIsRcrUzBmWNntu7qtF9QP49fOnnwUve3Ip+SscVrmY2Vpq+fkati/JZcENrIqSBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSXCpO8kMO9XWAyTvc/xBTPc9AtuRwIXQaZi40z1iTwZ0c9dqU
	zRy25KBPDxkSaMZGXQ0uG4VFlnqyxcIQBeUfrQeQSmjbx+pfPCCt
X-Google-Smtp-Source: AGHT+IGfT3/q3KJg0BmJv0M3JSpyylmNbOkhP3+kI1SDAPayxBKjFLi0azP6rHT0HtymqiHBO+xoLg==
X-Received: by 2002:a05:6000:1787:b0:37d:5026:f787 with SMTP id ffacd0b85a97d-381f1885612mr21224023f8f.38.1731596173714;
        Thu, 14 Nov 2024 06:56:13 -0800 (PST)
Received: from andrea ([149.62.244.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ada3e7bsm1730816f8f.7.2024.11.14.06.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 06:56:12 -0800 (PST)
Date: Thu, 14 Nov 2024 16:56:01 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, puranjay@kernel.org,
	bpf@vger.kernel.org, lkmm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: Some observations (results) on BPF acquire and release
Message-ID: <ZzYPgd8rJDG9p6WQ@andrea>
References: <Zxk2wNs4sxEIg-4d@andrea>
 <13f60db0-b334-4638-a768-d828ecf7c8d0@paulmck-laptop>
 <Zxor8xosL-XSxnwr@andrea>
 <ZxujgUwRWLCp6kxF@andrea>
 <ZzT9NR7mlSZQHzpD@andrea>
 <CANk7y0gdNGM36Er9vq42-YouoGVVQ4gp0yvgVHarm0-NFC2i1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk7y0gdNGM36Er9vq42-YouoGVVQ4gp0yvgVHarm0-NFC2i1w@mail.gmail.com>

> I have applied your patches and modified them to add the new tests to
> kinds.txt and shelf.py
> now these tests will run with all other tests using 'make cata-bpf-test'
> 
> All 175 tests, including new tests added by you, pass :D
> 
> make cata-bpf-test
> 
> _build/default/internal/herd_catalogue_regression_test.exe \
>         -j 32 \
>         -herd-timeout 16.0 \
>         -herd-path _build/install/default/bin/herd7 \
>         -libdir-path ./herd/libdir \
>         -kinds-path catalogue/bpf/tests/kinds.txt \
>         -shelf-path catalogue/bpf/shelf.py \
>         test
> herd7 catalogue bpf tests: OK
> 
> 
> I have pushed it and sent a PR so we can get all this merged to master.
> https://github.com/herd/herdtools7/pull/1050

Cool!  Thank you for the follow-up.

  Andrea

