Return-Path: <bpf+bounces-39429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CCD973462
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 12:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73FCE1C24F8F
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 10:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2D21917E4;
	Tue, 10 Sep 2024 10:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lo6KqNoh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34D21917C2;
	Tue, 10 Sep 2024 10:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725964631; cv=none; b=An99Mun1pWu7Ue1Jsbcc/h27aQFSpl8cdO7DO1QVBAFVcYTQBKBprqO+uj7DdRDAzZ4UYpv6dNXh1YJOb+R4Wd0Fv7msQk5ORi70BqKT87CIH3j9r0AT4d8GohaptXjMuCD0m6Wmw22baoSDpxVNeHi2lMklgMAjAZZ62NjIrs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725964631; c=relaxed/simple;
	bh=/5y2J5n+r5mgeGrIde6ZYT6sCQYYNRnC8UhTFG6YJGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sp3MNCKKEsto+NFKxdSwv5QJLeFoztnU94dHJCys9oQ8SQRbnjJdnUlpskSLJLNY4psLhyfXHet3DBtGZ5FATVjMI4nJVgVqg/duroxqTFNvt8OW+g8SNPAwyq6Ma4K+0cId8gZcwwEbUO4Gi9wAK5+MZQm15Bldaq9EAA8W3HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lo6KqNoh; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cacabd2e0so5319685e9.3;
        Tue, 10 Sep 2024 03:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725964628; x=1726569428; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xu1lNcJUo/xU0OnY1NyGxCMOv270XnBlVpGeaBK8klg=;
        b=Lo6KqNoh4/u3Ox30oYYbiSHI0KBxaJfbadJpTexYbhuii/Y/QochdmkFQs1IAjky0i
         QShDUSGxKKO78YBroFyBONU34YyNmHltExhMuO4TVF2T4tPSsDrrbI5FfgMqthVvcJZ/
         UZ93850xms+qY9p1L2m9ARzvlZx7HMX7mvC/F79pg+1DJkxLLdVfqHcjEiFiY0Zs22Ew
         VuGr5uDEcDOgAWhugUrRgLtaZLu1Ngh/JmghhLMyR2a8d7unSodSvtUWhOiMf7IpjmPQ
         OWWTfJOBx4sQKEYL7xHuYvd/lEY+WsNLGjq0wHSP70Gm9Sz8wfZK9Vby6WbAcMorjK+i
         77lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725964628; x=1726569428;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xu1lNcJUo/xU0OnY1NyGxCMOv270XnBlVpGeaBK8klg=;
        b=KgakJMSiagvs+i1w7GKL+q+ewXQM1n1JoZgfacgyoKlxHesscc4TWcX18cdaf+Qy8b
         ht9WLGM1w/Ay6Imx/WAhVZJk67itw12Z4Yag8IpTb78URi3tbLnfWQLVu1kZwXW6XOHv
         tngbwM7/G8x0q+wYWBU/3NcqQzQTmJ59pBl8YBB3JeFO/AG+jPUJCgx3Mqz7RZMAKCwC
         j8HgfgTeuP4O1fSrsNZpjgQ//ba3xfCN/hrW4WxNNZP13Aockxzuni5rjL1gNaIvnwWS
         yWyPMXBOuDds5fdp+a24QEWUuPUbGV4Z8sDkKmaoZkArFLawYCru/1AiOoKT/Cp2eQbL
         b+vA==
X-Forwarded-Encrypted: i=1; AJvYcCU/sABatN/5moUmdYTLmgbh02fAcxnnTc522O6tG+QDhUxe5tdhUFlTg4KXC9y1SHN/iXs=@vger.kernel.org, AJvYcCWpGtLwMgSeqyCC2R6kH1O9jq8Bz/qtbm0WHOBiyqOAYfABdZCvwmycIDJBig0jtD3fxJI3Lze4MTrjCHFxFOrfZ+s=@vger.kernel.org, AJvYcCXqtZSIyEiPHaxQ3VXwX8NgVx24mttpq5qxzixAcjlAFXYCogydLODhtT+XBmu8bycZQRzAaTJ506Os0vJo@vger.kernel.org
X-Gm-Message-State: AOJu0YxOXLYZaLqhzKofBoN0zm8QeDvN6obOgad75fHu3wsXN80sxcNh
	yOOx3wRWzllL8xTgomyDCnoCQ6JpDBbslgr7jq4eJrfpecDLxv/r
X-Google-Smtp-Source: AGHT+IEnF6/WGdCMUXV4UAmj4y+0SdZAu0kY2k92ECXrXgN6LclTZ1rXp5B5G2q/7u7PSCRcIHAh4Q==
X-Received: by 2002:a05:600c:3c88:b0:42b:a2fd:3e52 with SMTP id 5b1f17b1804b1-42c9f9d6e65mr105129875e9.22.1725964627370;
        Tue, 10 Sep 2024 03:37:07 -0700 (PDT)
Received: from gmail.com (1F2EF544.nat.pool.telekom.hu. [31.46.245.68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb3098dbdsm86638525e9.33.2024.09.10.03.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 03:37:06 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 10 Sep 2024 12:37:04 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
	linux-tip-commits@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>, bpf <bpf@vger.kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Subject: Re: [tip: perf/core] uprobes: switch to RCU Tasks Trace flavor for
 better performance
Message-ID: <ZuAhUHqAA-ejpN3X@gmail.com>
References: <20240903174603.3554182-9-andrii@kernel.org>
 <172554860322.2215.10385397228202759078.tip-bot2@tip-bot2>
 <CAEf4BzbytuSpro9wT7cZY2Qf98zpDz+V0hTwwKP3ZDa866s1tA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbytuSpro9wT7cZY2Qf98zpDz+V0hTwwKP3ZDa866s1tA@mail.gmail.com>


* Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Thu, Sep 5, 2024 at 8:03 AM tip-bot2 for Andrii Nakryiko
> <tip-bot2@linutronix.de> wrote:
> >
> > The following commit has been merged into the perf/core branch of tip:
> >
> > Commit-ID:     c4d4569c41f9cda745cfd1d8089ea3d3526bafe5
> > Gitweb:        https://git.kernel.org/tip/c4d4569c41f9cda745cfd1d8089ea3d3526bafe5
> > Author:        Andrii Nakryiko <andrii@kernel.org>
> > AuthorDate:    Tue, 03 Sep 2024 10:46:03 -07:00
> > Committer:     Peter Zijlstra <peterz@infradead.org>
> > CommitterDate: Thu, 05 Sep 2024 16:56:15 +02:00
> >
> 
> Hm... This commit landed in perf/core, but is gone now (the rest of
> patches is still there). Any idea what happened?

Yeah, I'm getting this build failure:

     kernel/events/uprobes.c:1158:9: error: implicit declaration of function ‘synchronize_rcu_tasks_trace’; did you mean ‘synchronize_rcu_tasks’? [-Werror=implicit-function-declaration]

on x86-64 defconfig, when applied to today's perf/core.

Thanks,

	Ingo

