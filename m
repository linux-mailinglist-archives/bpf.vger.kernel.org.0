Return-Path: <bpf+bounces-28578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 180EB8BBD49
	for <lists+bpf@lfdr.de>; Sat,  4 May 2024 18:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A1FE1C20CC1
	for <lists+bpf@lfdr.de>; Sat,  4 May 2024 16:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C205A4C0;
	Sat,  4 May 2024 16:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbHRti+2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46CC5A0FD;
	Sat,  4 May 2024 16:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714841313; cv=none; b=cqTyVOHXKD0L7Ejm9i/Gjdfx0NJyT72krw/YksKsR1OElUyHqnqzo7HmUDqhTZ4ZY4kibie+Tketua12S8SpDzWW1UsQ0sC2hsCqSky8kOjoa9nWdaD9o2sJYwunMFVnAV0Il3jAHExFRBRh419JzgoqdeDUqjEJEAPR6zsg4qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714841313; c=relaxed/simple;
	bh=SiM2PFCHYZcAR+wGXwxQ3NDyXl4odjt3gp6tA6ql4TI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=dfQmWQeennc0mhV7X/d781LeUEh6/W36+2hMl2tPyT+/OaraMJFlVn31ggtixjag6MBH0dWQ47evZQowaxGCh2XvQAjWIxsEth8uYjVRYmSWbzWrAyagF56bR253vIVe3LP00Yxy2jPCI3NctYjXZyySQ+vCMaGoPJgTH7q6Vcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbHRti+2; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e3c3aa8938so3885075ad.1;
        Sat, 04 May 2024 09:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714841311; x=1715446111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQ+PC0Om20Vuh0Z+zyUooVE2lc7hIlPVobM+LpZOkAc=;
        b=NbHRti+2D8QZSmsPvei42dbW47m2cti3MTOLl3oUvul73ZYH3Rax9euYERVe+nhG1z
         /Ot9lQQ6/bTwOejeMrXHmWnEpQdN8onc8wMpnQwT38kA2KDrwFirocQjGQvPPnopa/t6
         hNFOsmL+c5Mujlcd9Csx724NaCEeIKHEXax2KviypN3bcyzxJNLCpmRGt7mspkerzq8R
         4tpM8/aLQGJAg3G3KyPpxlzqnZGXw6oAI7XFmgfsCvCQU92b27LrL9e2XfnKxtxQDV4c
         LQWw9LOQsyIq8xYGfju//NStctYbmFNq/ejZcz5tW1ikG4pUTkTfwmaesMTHuyZ6L+SX
         +Tiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714841311; x=1715446111;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uQ+PC0Om20Vuh0Z+zyUooVE2lc7hIlPVobM+LpZOkAc=;
        b=STihqsRncsUg3u1I7FID8OrPhhsjNZoqVdTH7to4fuWeaKKxMpVosEjN/OSQN8dZa0
         CNwvsiu2M5IG8xFYxSH6zTya3YOWidLeeIC4DJqH0L86dFRhumL+GqsfHELupSbYMgC2
         E8ncT7h8fLefdvHOSbwher6FzgTEaF1KMXY3nAxKzJXX9MEqtD0l5ANLi1345o67KyZZ
         +jjPjrp+VqFRljXEfO1py9dsbPSsyg/P3/skEoJa09FMuncSCHNJLd1OswwMeotxvlq+
         eQmZuI5vSqoxJApPHT/Wk7CHWr9iuD45bJEB42pDx4liyN7Ww0e5vrgjUK/rtDHKvNWC
         wzAg==
X-Forwarded-Encrypted: i=1; AJvYcCVRqnhj656yJBOEEfFJFQ5p1fcdvoGFSVCZbqZOma1JAEV4XJ2Qwl7QSC102rjn5MxDQYNFl1wQZlDHsdcZNpOIOW4L
X-Gm-Message-State: AOJu0YzN0Wm8UW2CXS3mFij08FsNvG6cU8sXcSFIsl/gjUUUhg2OQ4YO
	pMWeLtrqom3HGbpKQLytSgGwzV4nGCyzkQ2Z4kiTKuZaroiIGf2J
X-Google-Smtp-Source: AGHT+IEJkQQUJHn2wHcFek+dTm/1qExu4k3X5BpXy8Z1A/9yquVw4aAN5n2CzsmB8YgTYct83mYXhw==
X-Received: by 2002:a17:902:f552:b0:1e2:6198:9e53 with SMTP id h18-20020a170902f55200b001e261989e53mr8870096plf.0.1714841311168;
        Sat, 04 May 2024 09:48:31 -0700 (PDT)
Received: from localhost ([98.97.34.246])
        by smtp.gmail.com with ESMTPSA id f15-20020a170902ce8f00b001eab1ea2165sm5249887plg.201.2024.05.04.09.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 09:48:30 -0700 (PDT)
Date: Sat, 04 May 2024 09:48:29 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: stable@vger.kernel.org, 
 bpf@vger.kernel.org, 
 daniel@iogearbox.net, 
 dhowells@redhat.com
Message-ID: <663666dddffe7_22c6b20824@john.notmuch>
In-Reply-To: <2024050458-deduce-ascend-f524@gregkh>
References: <20240503164805.59970-1-john.fastabend@gmail.com>
 <2024050458-deduce-ascend-f524@gregkh>
Subject: Re: [PATCH stable, 6.1] net: sockmap, fix missing MSG_MORE causing
 TCP disruptions
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Greg KH wrote:
> On Fri, May 03, 2024 at 09:48:05AM -0700, John Fastabend wrote:
> > [ Upstream commit ebf2e8860eea66e2c4764316b80c6a5ee5f336ee]
> > [ Upstream commit f8dd95b29d7ef08c19ec9720564acf72243ddcf6]
> 
> Why are you mushing 2 patches together?  Why can't we just take the two
> as-is instead?  That makes tracking everything much simpler and
> possible.

OK the thought was to get the minimal diff needed. But that
is problematic. We can take the first one as-is and
then the second one will have a couple chunks that don't
apply but we don't need those chunks because the infiniband
part it touches doesn't have the same issue in 6.1.

> 
> > In the first patch,

[...]

> > For the backport we isolated the fix to the two lines in the above
> > patches that fixed the code. With this patch we deployed the workloads
> > again and error rates and stalls went away and 6.1 stable kernels
> > perform similar to 6.5 stable kernels. Similarly the compliance tests
> > also passed.
> 
> Can we just take the two original patches instead?

Yes minus the couple chunks that don't apply on the second one. I'll
do some testing and resend thanks.

> 
> thanks,
> 
> greg k-h

