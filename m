Return-Path: <bpf+bounces-36776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8346F94D24F
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 16:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5A431C215F9
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 14:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81B31922F2;
	Fri,  9 Aug 2024 14:38:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F987174EE4;
	Fri,  9 Aug 2024 14:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723214320; cv=none; b=ejiPDowmgLQSHUJ/yPkmlLQt6fe4SVQBk4zqjMesNJ+TAseXYWbSzaJ1nJWD1eUq17h/iaFpZP3z4DGqZ7SnEIwdfWZhpOZawrNjVsmCX1jNZ2xHHiZor+Q5HBlNFgxsxmk+jzEw7vUoOZy8OfiP/6o2p6zp/Loatt/REA2lCWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723214320; c=relaxed/simple;
	bh=mDATvSkRsXbgAhxacIlfhhmdhJATPWwkckScaSsEUzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpY52om5DyP1fYQoZ49DLRPNXUA2eOXOtTngPHJelt87w18B5Ern8iR5MZLxrR5DW9W2Q1Rrobb2CnltrhORTmD4YdT5JRaH7bOIzgl+xQdSMd150nFTBSJp/4mFbuPKFgKklUVoCdERUAEUkbxJ4sRqPvzRhyo6ZkS0UC+Zslw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fd6ed7688cso22041335ad.3;
        Fri, 09 Aug 2024 07:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723214317; x=1723819117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qo3fv4BxOyXeAzF6cs39PLejyyZBfrHLSuD8oQr5eIM=;
        b=MpWTwFK3iXJgQLlf/MeH4PU1tQEcMcJvcITWpp01uhQfaZB6hLIrxLHNkpWsL/bIQl
         7QEXZ9zu0pD+Kd1zdbi/eigddIRrhwleSc5UuZbO90wwngdDUzXjYKOUhEL8iXo7toJt
         cO2lHDg31f0gDppjhkIBgMwunwLXvrP1ATk26HdkjP3lGAfkwMtJBOnAoYpvxbHwqDLm
         jWuAR+m0Sd3c29Lgx4HgG6QpVMh6cn3cQRxerEiUExdh7QtW/KoHzQC5YBH/yvz1b7I5
         vnLEfA4qqQRKTL+Mawo9qeNlt+BwQm+p2ohF4FFvDionW9rfUZiv7TuSIwmUuI8Cv3SB
         Xufw==
X-Forwarded-Encrypted: i=1; AJvYcCXP4m/bQZicM4KEP06lMIgVFZ7WEfnQ6sDnFAy9v8UZe71xQJHnT66ek39jdboZmhItbP9RBjigLNTBZMm/u8z0PI4vJrBdjywTWWB6HeKMY8QRjK6MXK9xsT+xCw==
X-Gm-Message-State: AOJu0Yzhe0qGLtvEODfhd1+qGVf11a0KbOR1/d2ToqUI5wPsK9rWUqRo
	cMwUpPxiGI/BkrLzOhe9f82qx+e7vKBbBgaEYF4JbXR8vbWkOfSmQgmH8us=
X-Google-Smtp-Source: AGHT+IFkJPt6sr/F+3RRWmW5AvyckH95Q3MwPCzTmXcr5UFJhzo2H+pqMgp1VmNTBGegNwyUjdlEKg==
X-Received: by 2002:a17:903:2288:b0:1fb:67e0:2e0a with SMTP id d9443c01a7336-200ae5d7771mr19025975ad.48.1723214317474;
        Fri, 09 Aug 2024 07:38:37 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59293a90sm143146595ad.235.2024.08.09.07.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 07:38:37 -0700 (PDT)
Date: Fri, 9 Aug 2024 07:38:36 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Xin Liu <liuxin350@huawei.com>
Cc: alan.maguire@oracle.com, andrii@kernel.org, arnaldo.melo@gmail.com,
	ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
	dwarves@vger.kernel.org, kernel-team@fb.com,
	ndesaulniers@google.com, yonghong.song@linux.dev, yanan@huawei.com,
	wuchangye@huawei.com, xiesongyang@huawei.com,
	kongweibin2@huawei.com, zhangmingyi5@huawei.com,
	liwei883@huawei.com, tianmuyang@huawei.com
Subject: Re: Is there any current plan for ipvlan to support AF_XDP?
Message-ID: <ZrYp7CHx44-6hPN7@mini-arch>
References: <20240809024627.2193378-1-liuxin350@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240809024627.2193378-1-liuxin350@huawei.com>

On 08/09, Xin Liu wrote:
> Hi, all:
> we want to use the AF_XDP capability in ipvlan driver. However, the current
> mainline does not support use AF_XDP in ipvlan. Has the community discussed
> the use of AF_XDP in ipvlan? 
> 
> I can't seem to find any discussion on the mailing list.
> 
> Thanks!

I don't think it has been discussed. Probably because there is no
straightforward way to make zerocopy work. Copy mode should probably
work already?

