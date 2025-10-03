Return-Path: <bpf+bounces-70321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6191EBB7CD1
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 19:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1BDA34EE6A9
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 17:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BFB29E117;
	Fri,  3 Oct 2025 17:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+auxx15"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5F13594F
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 17:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759513616; cv=none; b=ey9TNCn8XWmZ/aBA26WRpJLVQPxawFxmEVVepvHYLBd4xRAUcyppvmbOgkf+IvXPYFmnwYTFhrs8raW27aGG+S1z4oQo80XV2mEUTINSR3CckHnZTCy28FuEfgPqdXSXUD1eH3Zw+6cPIxBP19pCKo1GqON/HZOAFK0gw0MuzzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759513616; c=relaxed/simple;
	bh=DZGeE+1FXYx60PCCvE+c9NIt2hR75yBBwFUcnxJTLn8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BeyC+RerSQbVGdmP6VZyu0wtSzdrwLQGvMd/b0dzTEpS3l1WVfdQkayKHmwGQKE4WB4pj/SIUbzXe/Nnj+Eu3gOxRjNFTqLhX62RYgoY8KXGqF4BFNOx5ENxccxIzI5YwOIsUYJuD8sJBlqIjiUulo169Z+m2UgIVYuuT8/bCS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+auxx15; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3306b83ebdaso2639489a91.3
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 10:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759513613; x=1760118413; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DZGeE+1FXYx60PCCvE+c9NIt2hR75yBBwFUcnxJTLn8=;
        b=C+auxx15UeK2O3BaAEK/9tejDUSldLnw/gAk29sfUiT+E9hJQRHfWMsrDx9JdRMc3n
         92qCOUJfcIO4BGpHKPILD/xppC011YM9cpJMRC6lUWEl6CYZotjKlb50CwFNFLbSovpI
         +HA90rgERAAf1RWI+V054UbH2NahIJEScjnqdQoSAnLFUJOKDFOTG6/Tayd4o9FwnKWc
         88C77JecVowV+Q6gTnKbNjq04EPA9jvbR4EG0HrfmbtwUHoF2c0zUyIcsjO8RtCP/MGT
         vc0f3AQqcse8oGU3Zgec2qOLHfbHeHNtaa7NlZU1bipI1qk0OVI0IAknsH589o8Ac7/+
         R1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759513613; x=1760118413;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DZGeE+1FXYx60PCCvE+c9NIt2hR75yBBwFUcnxJTLn8=;
        b=owqvRtWGGZko22iWQRxRwnNaKYF31Y6E6uTNXhF272j3G8IgVE6TlfKiUGpwmzcbZp
         Vz3Y6YJeeyXCp8Xk5oZOL5t4CbqlKNlhrXLhI1j+SoBrTPpfvH8aLtH3xp+hpWupXkr6
         nNHSPeUYh2JJrLbGmqsBmXwtv9JerNF45xWP9J3/Oye1VbYyPLPnuJHI/EvCqWb1+A2m
         OwuevrUpyNXQxbzhBDwcy6VG1hCVm8bN73aykI6QqJV3vJ01WXfxz6zIWI2BtmNWyMZ1
         ZrJPJPhupnCAI/gIK7tOe0op2zqnmBJMwlLAhXBct2mxQkPnnFleGFKi2jX+ci7j5rSb
         Prmg==
X-Forwarded-Encrypted: i=1; AJvYcCVJbc7mTdA1k+jPnenvsxSBLHAKR+t4o8PmFRuQIYqlzkvPrM4H663jEjPPtzPhTY+2MS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQic9uPsFevhR4a/EKPgYCUipGFej3XhiffD1At6+yQUso3SKX
	NeEydQfC9HwWvqdG6WgpWldKHX212V02EchFwy0UC0mpuFTRH19uPWFl
X-Gm-Gg: ASbGncviC6YQ1+m+a30S9x/DjgivCchneioLu5wScxyOI98iXtKkKjaLR5MQreRPtX7
	23bM84qGFzwx6q/S22CHXmPxX+mbnKOk5vPdyFen+w31Fdh+GWt+sA9D1+whK5cldql4vkzSIJr
	rCzdepSHrqnazGacnhXGlu4hlh0BSNi6uP2L5TCZ5yrsIEBp0CSMGui8A1GhoYhYQHZx16VhWrz
	Lb7e0m1IHJI0qfiGIWM2tGKuISaX0ccXgLJbqD3ugBpyHyiApni1pgfSiFKfJgjQ1MvzfiEVn8S
	8myVzgkB499+qKtoJwTWEgmhU66KG1x5sgxKAQ58pOJlUxk2+niDYCX79pZF7i0lWP0qEgEQeb2
	lANklNAFQaXQUt4jAEA4KuK8g8KHc1DBpuE0RbZ+3EEyZnLirmIS3LNKj4U5xsZca4UJFpeysY0
	9oO5Yfb6c=
X-Google-Smtp-Source: AGHT+IGrevGpywlXmk7P/ETr63/ezKZr4EirRqkP/9RASMCd0PrX1SwE2gE8NSbOX4gcnvuN2AUOlA==
X-Received: by 2002:a17:90b:1b0d:b0:332:afb1:d050 with SMTP id 98e67ed59e1d1-339c278238fmr4573866a91.14.1759513613336;
        Fri, 03 Oct 2025 10:46:53 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2a3b:74c8:31da:d808? ([2620:10d:c090:500::4:e149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3399ce52317sm4703104a91.11.2025.10.03.10.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 10:46:53 -0700 (PDT)
Message-ID: <46a62c903816f9fdd4102d6ccfd3199e322441cf.camel@gmail.com>
Subject: Re: [RFC PATCH v1 01/10] selftests/bpf: remove unnecessary kfunc
 prototypes
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Fri, 03 Oct 2025 10:46:51 -0700
In-Reply-To: <20251003160416.585080-2-mykyta.yatsenko5@gmail.com>
References: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com>
	 <20251003160416.585080-2-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-03 at 17:04 +0100, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> Remove unnecessary kfunc prototypes from test programs, these are
> provided by vmlinux.h
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

