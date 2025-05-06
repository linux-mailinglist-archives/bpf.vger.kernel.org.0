Return-Path: <bpf+bounces-57481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 326D6AAB951
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 08:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 637A05081CB
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 06:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF372BDC3D;
	Tue,  6 May 2025 04:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XqH1zksp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279B330574B
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 02:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746498580; cv=none; b=OmAczJVu+4JwCA/hw/Jx41mzvzc2To3E5qRqPMXDneZ38zbl3o2I8U41J+9+LC14hyBExolhVWiplFetJZhEhup7SL9RKZs2cjpNL1ER0AmBgDpt6X3Bto16uJSgchqjs0vNPJ+LuiMaQBWki9UA9xQ4Uo18Vz9VXctkVBjTWQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746498580; c=relaxed/simple;
	bh=PsnQASBAnD7+WYr+/pn0BHaFARb70S31g7EPNqlgdMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERFoFh1WpNoRd8NaQNLoAO+sLHJrKQUbP1U8RQCb01NGXouh4tE/8gEWWLdSqX/vEvZJssMamk6s38hdywjG3rDrrwuWqtCGee+WEaADzvKSymMN/ShqcDcKg8vL8k/Ilfp7xUi+Wdc6tbK/VFWZWuYKbqIYlvGPtW4f7eqaTpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XqH1zksp; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22c336fcdaaso60956905ad.3
        for <bpf@vger.kernel.org>; Mon, 05 May 2025 19:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1746498577; x=1747103377; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WTS19iX60vkQyuATtUyaY3DQwn/cOZ8fHQvq9hje1YY=;
        b=XqH1zkspEAz9I1NMauuiOEshBtKtCQyAN2VElhBTFybYEZQZSMmc9V3uReoPIUG/RK
         P6TexyRWDcHAd2wKGvpf83SYLU+0RyarwZr3R8fe6PleIfmgtKHVjLUHGPjAPfsQUtUp
         uFCXIREmK3H9tSZcygHzrmdSxcXzEnGNPtAkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746498577; x=1747103377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTS19iX60vkQyuATtUyaY3DQwn/cOZ8fHQvq9hje1YY=;
        b=rorEGQacq1b4s1gxht2rLSqNmtFVl4J6MjKklW3TCGP8Bj85GKf77ttZVFmIA37J2E
         i0MPB4qDW2IUGgnaDPlqRIUQk9InXpHBWs/6kVBR0aWXdRW2gBdocgVldzbhEHwvwPhM
         vrh9+H04FFOVhsxyv3hOnvsA3peHJVcH4SUFGaNkQQ/N/h2gLDx6/1KwHk1pH51bd8vX
         pFYCB3XR3/hhrw5E5YsaRCAlM/ztv92a0rl57PUmeV4SKRLG6bzmLvBGIlCU6BizV3Xs
         6+KHTkNoY5ijQNPQZAQuw2ZxaeLHdlAGMgSpmSRZZdWbE/ERi9NC5AssAmvD8r/yPUuy
         mtog==
X-Forwarded-Encrypted: i=1; AJvYcCWc4A0lNy2KjYZ0a8HBG0tZMo/2nzkU6Tt7IoseGJEE4coAPuNE+C6nfP4EGDgrfPwuLII=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlv4k/J3DMTnZdqD+5VDlTow5HIIP5KP7Q27wrjsrXEIL9+Pnd
	BB3QdCZC0yDWl1NvB9T88AR9FIZOGD3DvGdK94d17Rgo0GdXjH7zCaOeg7hYoQ==
X-Gm-Gg: ASbGncsxanhvert8ud/fObqgUoUvztQiUCa6aQIS1r2nLZLVH4Xyb5HBAH2A9aJwaxx
	GLr98KQ8jEBjLfU2sdREhixbyrEY+wTeaWTOQyYGzt9CRXCQ8bDvlRiODDGubo5WMX5sSaILs4X
	A/tTNI3DIFk+GNj8G225y9WGvwayijG/0M/2Rz5DSc/TQPo2rqc3z8aYUp1eix7HRrMgxUetScS
	8h7+2ceMn5j6k38330JmuccLOcJtATmXyQfcSoPb10n/njys3ZwzPEgK87GFPVot0o34jrjfaMZ
	yLV1EZSsYA7E8CKVN9TlmWWsvSHP3WCmggFHrv21uqlE
X-Google-Smtp-Source: AGHT+IHwF3eCuzC4949H469KnTADrIIoIwm5PQiSNQSIhwK/ekUJv67Hft+qCKTnlcKaEFbr6/FzeQ==
X-Received: by 2002:a17:903:d5:b0:22e:4203:9f33 with SMTP id d9443c01a7336-22e42041dd8mr4891825ad.33.1746498577504;
        Mon, 05 May 2025 19:29:37 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:4dd5:88f9:86cd:18ef])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15229137sm62596985ad.203.2025.05.05.19.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 19:29:37 -0700 (PDT)
Date: Tue, 6 May 2025 11:29:32 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: add bpf_msleep_interruptible()
Message-ID: <nvaiideqcaqjvhdshhrcazg6g7horprlwa5f3fkk3x33f24wdq@zvqe4p6s3bpb>
References: <20250505063918.3320164-1-senozhatsky@chromium.org>
 <CAEf4BzZkVg39JqGeuAjypf=WXsOG8JVDS8SSkVLDjHUuHzxoow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZkVg39JqGeuAjypf=WXsOG8JVDS8SSkVLDjHUuHzxoow@mail.gmail.com>

On (25/05/05 12:55), Andrii Nakryiko wrote:
[..]
> I understand the appeal, don't get me wrong, but we have no way to
> enforce "is expected to be used for testing only". It's also all too
> easy to sleep for a really long time, and there isn't really any
> reasonable limit that would mitigate this, IMO.

Sure, I understand your concerns.

> If I had to do this for my own testing/fuzzing needs, I'd probably try
> to go with a custom kfunc provided by my small and trivial kernel
> module (modules can extend BPF with custom kfuncs). And see if it's
> useful.

A downstream kernel module?  I guess I can give it a try.

> One other alternative to enforce the "for testing only" aspect might
> be a custom kernel config, that would be expected to not make it into
> production. Though I'd start with the kernel module approach first,
> probably.

Something like `Depends on: DEBUG_KERNEL` maybe?

