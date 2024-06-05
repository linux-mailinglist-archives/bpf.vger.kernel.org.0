Return-Path: <bpf+bounces-31459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9CF8FD670
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 21:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0CD6B20D72
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 19:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C164E14EC52;
	Wed,  5 Jun 2024 19:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpHP+43d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DDF14E2CB;
	Wed,  5 Jun 2024 19:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717615704; cv=none; b=aEa3xSQgyT7oLcA7JkP+0CUVd+1WkGYcJssgAO8kLn3veuy4PTXZ5TkYHqzR3IuW1CoDME0a525vK6HcQAYJJvz3CyrwgQNSb3VPaPoBOEFxjd2tOeZo9smT/jiJvXbDAN+YaD9XQ5j8Vt1/KhlmaMgsHMOGQ/a9jnMlhvpCkPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717615704; c=relaxed/simple;
	bh=IengBx8H4auaGZa9UWMGNRUSIeADt2jwVMqn4nivRwE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=eKQu83yMTRK3kEpSe8n67BScck4apq7+xih512CVEHftl4xk1cZ6cYprjPDMg/HSbQtriaSTgh6nSsrtx7rztlICMwxbqDp90RIc9dLHcxl8yJKaMlLR1sQxaUy07f9dNg4uk+MTE60tLsArSwo3OKCvVevciSbLmY6lLakNlsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpHP+43d; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3d205098e8cso59164b6e.3;
        Wed, 05 Jun 2024 12:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717615702; x=1718220502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5XVHmy+c2QVXQfKT/RClVqS/q+BGSViVaGos8YC5wY=;
        b=lpHP+43d2AIcMOmNwj0RX6vpXMmIGiuDB3wIFidVB2mUR4evq7VMePfSQMznx0fqw3
         /My+NmeaPLEpidqG0MS3WG6sTsYMwmoIcVBMJMnluYfh43SDxM9jSrKiiZqutdkKmPUM
         JRX0bN7rGhgh9urKeeiZjDGghfXtE2aQIARkHGmihS3mD/GPKIj3eHE/OVZH+SkAXd8v
         qJGkIdKNjiiNmi1E7RF0teqBFo5EV+SdpQBcr/B9ej4ZwdaxVhh6cPcAZuLfN3het6Vt
         7tyDPV9Q8na2IaVRZ/Grcu4ZFdtnIcY1LSBtF8EEwis6W8r5VCNAfmI732r5kmXn8Y5x
         tujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717615702; x=1718220502;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p5XVHmy+c2QVXQfKT/RClVqS/q+BGSViVaGos8YC5wY=;
        b=gFy3924GQn7HgpVk01wwgt7gNlirMakvNRXacBCkKUgFw7XBnI94XSwCR2yMlgNerm
         wcKPcbTyAXr5esk//H9dXDSSd/9UHUPhzSyYj7GZf4sibgnqZy5wf3/htHeJyoLeftKj
         AY+3TJeEo6KsapacIehJsirEU1bLwF5Q2ONwwjDOJqHJvY1Ymr08ld+0736cFhiRP4u/
         nqcOBSAXTncBvb8ne19d49uVNIWVsVp/Wi7bbFm1ht6EPSyUPuFLEODYQa8pipbl+rkm
         yVasbqiI2QEm4G7MHk1qsQfO6pJVw/7hY10QuFu9VCeYf35RhkyQevUp3iE48KM1/E8j
         auFA==
X-Forwarded-Encrypted: i=1; AJvYcCUpH/v0g3p9B61Sq1qza1S0brZ7fGKPiuEipAoKpqLh3uhKr8iaNnwxUr6CrxyezyE56kiyLX2RLUVhvkbE2cEFcUX01KZx7J72DDtwXIXS1m3J+NdL5xh9ldZZ
X-Gm-Message-State: AOJu0Yw+k06z4zfbq54BLZNb932ljx8l82UuaF+LZcjx07jaVHVPR3WF
	dFQIH8lmdvu9JgJ4I8GpXv0pLjNCIt7+Xj8reb4Qg5Ck3TrZGslF
X-Google-Smtp-Source: AGHT+IEyNqx6mNdumFHW7YPXbJIHMOfWcsQHcDuBSM6aHtexkIsBXbIgQu8Kfe1O9BU4ISDFO43JEA==
X-Received: by 2002:a05:6808:60c:b0:3c8:302f:1b8 with SMTP id 5614622812f47-3d2043d120fmr3454284b6e.25.1717615701848;
        Wed, 05 Jun 2024 12:28:21 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6afba632e2bsm32326536d6.117.2024.06.05.12.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 12:28:20 -0700 (PDT)
Date: Wed, 05 Jun 2024 15:28:20 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: magnus.karlsson@intel.com, 
 bjorn@kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 netdev@vger.kernel.org, 
 maciej.fijalkowski@intel.com, 
 bpf@vger.kernel.org, 
 YuvalE@radware.com
Message-ID: <6660bc547b59b_35916d294d1@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAJ8uoz0Zfv3rsLCuza2MW7Km-eU2sH1CDB1V_WHJ2vMAft_EmQ@mail.gmail.com>
References: <20240604122927.29080-1-magnus.karlsson@gmail.com>
 <665f9d3ba5a1a_2c0e4d29423@willemb.c.googlers.com.notmuch>
 <CAJ8uoz0Zfv3rsLCuza2MW7Km-eU2sH1CDB1V_WHJ2vMAft_EmQ@mail.gmail.com>
Subject: Re: [PATCH bpf 0/2] Revert "xsk: support redirect to any socket bound
 to the same umem"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Magnus Karlsson wrote:
> On Wed, 5 Jun 2024 at 01:03, Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Magnus Karlsson wrote:
> > > Revert "xsk: support redirect to any socket bound to the same umem"
> > >
> > > This patch introduced a potential kernel crash when multiple napi
> > > instances redirect to the same AF_XDP socket. By removing the
> > > queue_index check, it is possible for multiple napi instances to
> > > access the Rx ring at the same time, which will result in a corrupted
> > > ring state which can lead to a crash when flushing the rings in
> > > __xsk_flush(). This can happen when the linked list of sockets to
> > > flush gets corrupted by concurrent accesses. A quick and small fix is
> > > unfortunately not possible, so let us revert this for now.
> >
> > This is a very useful feature, to be able to use AF_XDP sockets with
> > a standard RSS nic configuration.
> 
> I completely agree.
> 
> > Not all AF_XDP use cases require the absolute highest packet rate.
> >
> > Can this be addressed with an optional spinlock on the RxQ, only for
> > this case?
> 
> Yes, or with a MPSC ring implementation.
> 
> > If there is no simple enough fix in the short term, do you plan to
> > reintroduce this in another form later?
> 
> Yuval and I are looking into a solution based around an optional
> spinlock since it is easier to pull off than an MPSC ring. The
> discussion is on-going on the xdp-newbies list [0], but as soon as we
> have a first patch, we will post it here for review and debate.
> 
> [0] https://lore.kernel.org/xdp-newbies/8100DBDC-0B7C-49DB-9995-6027F6E63147@radware.com/

Glad to hear that it's intended to be supported, and even being worked
on, thanks! I'll follow the conversation there.

