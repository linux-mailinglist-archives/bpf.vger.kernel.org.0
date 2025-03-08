Return-Path: <bpf+bounces-53660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D90A57FE7
	for <lists+bpf@lfdr.de>; Sun,  9 Mar 2025 00:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A9CB16D5C5
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 23:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D641B395F;
	Sat,  8 Mar 2025 23:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AITkdfDj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245B979CF;
	Sat,  8 Mar 2025 23:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741477896; cv=none; b=P/zpTIMWJuIzbGkbRjdU7YVo5TDU0HN8V42tpOo0+N3GKeW5pfsKgFYMlkM/QxhOEwamXhh9OLQY9vi2gJIxtpd3gSIA4NZRpneqqeQmdO6DH/TAz0ws17riX14WY1pJNmGGydJgr3bTqln2UlMKlwiyBtoVIrNQXkPwPLMyEUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741477896; c=relaxed/simple;
	bh=oJzD/CVt70r7vbQdEJhl8+SDwNJPtI51R4hP6ab/J+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2VkF4fnXQNMxAEJisVp/KcpMVxdKOdkuLBFlwJ/bDDr7EeIEKPHPeDknpzYi6PP/weNUtvTiw3Mrh+5bPNWUgAURTuGbsklmfSh8p5gz17lGCL1gR0lu+r17yQICgCzYBFYldXuu+fs9CcbgFZTU2pjok4R9r3j4tBWCucEPss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AITkdfDj; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2255003f4c6so7357785ad.0;
        Sat, 08 Mar 2025 15:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741477894; x=1742082694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RU4HFggHdxCjjKBvqWYGJtejBLBEs3Cfy1qYlc+YjiY=;
        b=AITkdfDjoSVV5zwag0OLDr33fMBE/6tjo5M32vdcO/eH+oZZMPNj9+LQk09ZJ9JgnS
         nj8/FYqYQsa9AWOSOqdqmHuV4dtkNL5EJrIVGeQ89XWdCHYNAbRW8JXL6WfsADbxKsnv
         MLIWR8q+mLxGoNsz6Ryos1fM8VRD6W3K538W9wPRDAm3lj4x0X5CMEc6lJilAPp7wd9o
         pIHwqOlnZ+ikY81BXCoalPl2SnIckSL88QfaYubboDwSBlT4w9r5JgxIqKyJpyYkSaqU
         GjAw6EueeyeMc8OSKHq1FYkEE6vPYcH0Wxpd2n2SHfbjNY1IKMQXmm1wb0CH8Cvtrdqf
         M48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741477894; x=1742082694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RU4HFggHdxCjjKBvqWYGJtejBLBEs3Cfy1qYlc+YjiY=;
        b=hsd+i69hT1BYR3YD9/H6h3Wo8ioFNP3wXW+0aZFrMYi+zliFLKmmeIBt4IeH1PJwIT
         i24tYPCFrxTSyBtGkVRw0AU3A6VtmTsNHup9xfHcO+zD2+sKpInF3V+qmAP8DeSAUpfu
         i6eihW5Uu/UrtOf4b9wF8fFGQRkmEP33FUQKnZBOSIYKWkYuTuoTzcja35qJ4FAsCVVS
         tgnXeuEl/mO/x380fKMr6uKnghYNI+XqhyFIvfvylYxcJ/2J5q5wLb8T9Q+icWEtX/be
         KwP2Rp4OzFXqCEwUZVi4JmyJuBIbI5/uUabOyIGi0T1gIsNdjjuecB+CceBltGvjq0WC
         0znQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTFE0HfN1wCqTeFKIIvv5dtdQKieTDSdcSwMEdG51QYkDc7cR1F7qsJv1hOeKmWjYgXJrl3YhZ@vger.kernel.org, AJvYcCVmAFw1p9cqp2F9i3o1Z/nIMOTLN3xPPsaFnPwSu4iTVMRQMyamF9qTBw3hAio/6ybjConZKeoPMOR6eri1@vger.kernel.org, AJvYcCVoAggc1Vs3M6oE7xfFVokpFzSMOY2YTXHmLKSwtHg9F7b6UliYtkRKBEveh4tpmz9ySQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqHgKEwnLLoG5csLcxLdhqsN1EdkryFRg3+LmSTJ0iTVoSCcs2
	zSCp6kWJs6SE4W/SsPomECz2uKiObljBtg4FbB6tjIZELk9/ZBc=
X-Gm-Gg: ASbGncu/1QRi9bEQmw9kL534bMTPMVATmTDA+Xa72Q/k0+sbPoSGKqEUlalAnEnzLog
	3LZR8WtqlaVcVWblupP3JZZKtCsBnmUYaOUpf91fVuLf8aQWsYQ9HsVY8002AComJaE+P7TXD4E
	IpWmTJXgAcOLTR9DV98sEGrvZ26BXqvGgFKf6FgUKVrwr/1AwY+HB5lNB35Xt02idJNCNu7w0Z3
	jy/cgRTu98Bq89SgY9lLEfEEq0jV4lvk2Y1Hd1tm+x35aRs5NpVsHTahypyda/mlGtEY3gUe+u9
	iw3VT4fEu2pCGUDh71zZLxVDvMb/p19wYabUbiNp9w7b
X-Google-Smtp-Source: AGHT+IELZ7GfTGgMnXTYkX/onmHHCa+6xW2Od4/EvUAPlNORR5UP3ytlSbAE/wTEtsPfNFed7zDDxA==
X-Received: by 2002:a17:902:e810:b0:223:402b:cce2 with SMTP id d9443c01a7336-22428bdb74bmr139448195ad.33.1741477894362;
        Sat, 08 Mar 2025 15:51:34 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22410aa4e94sm52054405ad.221.2025.03.08.15.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 15:51:33 -0800 (PST)
Date: Sat, 8 Mar 2025 15:51:33 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kohei Enju <enjuk@amazon.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Kohei Enju <kohei.enju@gmail.com>
Subject: Re: [PATCH net-next v1] dev: remove netdev_lock() and
 netdev_lock_ops() in register_netdevice().
Message-ID: <Z8zYBUwQlQdDeLLC@mini-arch>
References: <20250308203835.60633-2-enjuk@amazon.com>
 <20250308131813.4f8c8f0d@kernel.org>
 <20250308144142.4f68c0be@kernel.org>
 <Z8zLwzMl1wU6va7d@mini-arch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8zLwzMl1wU6va7d@mini-arch>

On 03/08, Stanislav Fomichev wrote:
> On 03/08, Jakub Kicinski wrote:
> > On Sat, 8 Mar 2025 13:18:13 -0800 Jakub Kicinski wrote:
> > > On Sun, 9 Mar 2025 05:37:18 +0900 Kohei Enju wrote:
> > > > Both netdev_lock() and netdev_lock_ops() are called before
> > > > list_netdevice() in register_netdevice().
> > > > No other context can access the struct net_device, so we don't need these
> > > > locks in this context.  
> > > 
> > > Doesn't sysfs get registered earlier?
> > > I'm afraid not being able to take the lock from the registration
> > > path ties our hands too much. Maybe we need to make a more serious
> > > attempt at letting the caller take the lock?
> > 
> > Looking closer at the report - we are violating the contract that only
> > drivers which opted in get their ops called under the instance lock.
> > iavf had a similar problem but it had to opt in. WiFi doesn't.
> > 
> > Maybe we can bring the address semaphore back?
> > We just need to take it before the ops lock in do_setlink.
> > A bit ugly but would work?
> 
> I remember I was having another lockdep circular report with the addr
> sema, but maybe moving it before the ops lock fill fix it not sure.
> 
> But coming back to "No other context can access the struct net_device,
> so we don't need these locks in this context.". What if we move
> netdev_set_addr_lockdep_class() call down a bit? Right before list_netdevice
> happens. Will it help with the lockdep?

Hmm, netdev_set_addr_lockdep_class is not touching instance lock :-(
But basically do lockdep_set_novalidate_class early and undo it
before list_netdevice...

