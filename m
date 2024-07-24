Return-Path: <bpf+bounces-35507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C20D93B1BA
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 15:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 479642817B2
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 13:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30888158D9C;
	Wed, 24 Jul 2024 13:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvjm51Xa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E191586D5;
	Wed, 24 Jul 2024 13:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721828242; cv=none; b=mJ1SkUL/hcUzyfeMDvFc0JiGX7+FV4ekhE7N3S9Cybo2AvejN5BI/vPSOt+tHwM+9PRpA5Tx5UlodPmnqcYp5KcvqessULm4R9hjQZpdlX44dhhYJyXBvsUxpPap2gfB81fXAcC9WBj70wpEyPzmWsGm3tG8P/rhcqam2EeUfFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721828242; c=relaxed/simple;
	bh=ta2/8Z37mh5TxPJfz6mZycKBtVDsPV8CcXDS7O6GkZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HHEA+9n2MkAsVQLOXFBvYgeFByZUOBL3jZ5rAgsBvUZamTIPrh6ytGxdDkmt9iHeNvASwnwJsAePh4Ywk/5yCLxDnOHxfOfsuGwP5Tbxdllv/MxRFIyUz+621B9YnmI3V6sB7JRdYGbxIGvPmSCvrjgmZmMfBmm+QblB800b9f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvjm51Xa; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-1fc6a017abdso7580745ad.0;
        Wed, 24 Jul 2024 06:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721828241; x=1722433041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmLOEPjtPW/NoAcNCjzI38rHsdFVG1KX6McVe0oeQa0=;
        b=lvjm51XauwdSJsDu5zO13MgkTJd2H2c+ZFel1sA6n+JysqJ4bWavkVAOq8o37KzaEP
         6jzFVVKygb2c8UA1YScTp0UJrlWK9sFWBOvBSBPIOkN3H2mSe217FdVkGt/ETKXzty5A
         5UYiOE5C7x3yPbwVxeL5czKNwA1jHApn/8tzAfLlaKWt1HzVECmKP0aNXjD+kKAvmEiu
         fENKhNvBXzgpwCg/BJNmSrtWT7MO1XRab9x0VO+ARJq0gGzuGJrFKWR3CePzYYabYkYH
         GQ+2LWHB2sJhGPv9c5wsPUwZKbw/yo+UTtvjhg3fGV8CovT3isQuBWDF0owQfIJa0Pf3
         d05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721828241; x=1722433041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmLOEPjtPW/NoAcNCjzI38rHsdFVG1KX6McVe0oeQa0=;
        b=BC0MnpSL+ZwaUy5WBahINYmR4qnDKWcCIIt0B43MGeln+5Dj0vAEI4H/FJHVIRdfD8
         +6XNizp7GaTf4feYFycA7XS5NLHV8cZvF+0QF2i/G9Py8UFi5Lg7IAmJMkaBcZSNIndC
         KqVSJi999iAgLwFbhlqHkcZp120ORDQoMKOQUohngwJTQcOTEVrc2A7scA4UwUY90/4p
         BUx7tt0uG6W7inWJdmCKlfO5AbPzkA30HtIl3MS30Klw/hA4vagMvERiT5LPOT2CVyev
         TfDcYmHI68pGBQQ+ka1aauA94Pdjd9bmcnetEbT0m8ucf35JN3Y9kBMsxo9gdnwmI3SH
         peAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNgoROKM/1JmCcKj7CMp8h2nsgMx578K0TwvZtRCiPUwfNA3uKxLU63ac+kg0hJZ51fHWde2wqpl3ZD4/LBoa0gDwGrmQtuxYkGbiUUpPJ2ZeS7Yf2dEc81LxmgZmT3qmPKK9n
X-Gm-Message-State: AOJu0Yx+tMLM7Y37oibTOm+vLwRmR8oo/7Z7xTuveG8cf3a/KKyIFezU
	YBHZ0Sh+RHUfi7SoonRcKSsyaw2qlObsRtOzRJ0sbAt8EtljKOO/7yrVA7gt6DA=
X-Google-Smtp-Source: AGHT+IEOt69E513PtiaVIIvBm8JbI6kOl4Aa5PFbXoAAIJvgnylR87hDVuBteEHxoaUIS37EtqmZ/Q==
X-Received: by 2002:a17:902:bb88:b0:1fd:664b:225 with SMTP id d9443c01a7336-1fd74596fa0mr90868125ad.16.1721828240543;
        Wed, 24 Jul 2024 06:37:20 -0700 (PDT)
Received: from localhost.localdomain ([240e:604:203:6020:64ed:1e9d:db67:b575])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f31bd90sm94497425ad.173.2024.07.24.06.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 06:37:19 -0700 (PDT)
From: Fred Li <dracodingfly@gmail.com>
To: willemdebruijn.kernel@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH bpf v5] bpf: Fixed segment issue when downgrade gso_size
Date: Wed, 24 Jul 2024 21:37:12 +0800
Message-Id: <20240724133712.7263-1-dracodingfly@gmail.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <CAF=yD-+Hx9Tg-Fj+7hutPJ7inL_GpgiY4WAXXdhN-tzj5Q1caQ@mail.gmail.com>
References: <CAF=yD-+Hx9Tg-Fj+7hutPJ7inL_GpgiY4WAXXdhN-tzj5Q1caQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> >
> > Linearize skb when downgrad gso_size to prevent triggering
> > the BUG_ON during segment skb as described in [1].
> >
> > v5 changes:
> >  - add bpf subject prefix.
> >  - adjust message to imperative mood.
> >
> > v4 changes:
> >  - add fixed tag.
> >
> > v3 changes:
> >  - linearize skb if having frag_list as Willem de Bruijn suggested [2].
> >
> > [1] https://lore.kernel.org/all/20240626065555.35460-2-dracodingfly@gmail.com/
> > [2] https://lore.kernel.org/all/668d5cf1ec330_1c18c32947@willemb.c.googlers.com.notmuch/
> >
> > Fixes: 2be7e212d541 ("bpf: add bpf_skb_adjust_room helper")
> > Signed-off-by: Fred Li <dracodingfly@gmail.com>
> 
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> 
> My comments were informational, for a next patch if any, really. v4
> was fine. v5 is too.

Thanks for your advise.

Fred Li


