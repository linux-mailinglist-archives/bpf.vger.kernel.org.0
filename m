Return-Path: <bpf+bounces-19863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF2C8322BD
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 01:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B098C1C2268E
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 00:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E690D81E;
	Fri, 19 Jan 2024 00:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpjirHne"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC2717C9
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 00:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705625205; cv=none; b=Gr8mM7pgiRYliBbPsGJxO3FrZYAMuNKsE1xnCvYibyo4Ms6bsNP+ZeDJ+CY4tEUnRmCRahoQWQjozglIxj8sM8nRg5ns4/s6FcBHRA/PJLTgNDYIaXZv43jTjEcrmTRJFyQF+IQy4pQU+mOcSlAwOqjyxePBNhLrBkb/JOxKqAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705625205; c=relaxed/simple;
	bh=PCenqpN2ZyWWyODzpvxnOXNBQL8XKDSeaB2tEqXiBzI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DvKx5gbupysk2yQ4FzMF4l0HUIk1nYBmBCFlUFGM6nEyG/6JL3umkgpuQ2Gpp3abQRwKOh5rdONv7PyaVpmtZAexvlXHrlXz7S+fPJCgva0ez8T82Q+x4ZepdmrP65+9KNiLSNPUEty5cT6xHR7dVDZsRBRg1nHARyf4IcdOGmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpjirHne; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e60e137aaso2712895e9.0
        for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 16:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705625202; x=1706230002; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=90x6wo5Llald8frT9AQnLRmsYFuZC093bkRIgp5TokY=;
        b=GpjirHnecQ+J8//6GTvCB1+dbshGviNaq9jRX7hvzi3Ko3Bgicorm+Ib5xdFnxLDFE
         UNMg3EZCSWlZ96stkH8neeiHQPHxUVmR64xmeeBBL2PYGVH9YHMOCrpo7C0aCKGdqK0B
         B7+6osdILknQuun01aHcuHemxinpGbrOQ+zqRpqX4nlPMLEDDOhsoJ3k4qGwTMvaVXfy
         jDSMq2YHKvR8sMY6X29uDgNaSKz1kqqNBBSzQccr2dNmRqEJKVVMnvP/RlRp2xj3wDmD
         lycHYcvcaAeolue6QVbotE+X8tcp2J1P40PcwRYfpakLqfxQ5LCm+h/ccrHCw0efSPK2
         mQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705625202; x=1706230002;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=90x6wo5Llald8frT9AQnLRmsYFuZC093bkRIgp5TokY=;
        b=p8y9GItj1SKBB/Qx3uopGQWx7uVTG+9hnlZmRVcxYOsJV5k+1nKcRrqFmA3gmVwL6k
         yHKbhv4DuAuoLjZGebvEM+2vvD9IXu914/HMnql27IpQd0D+DYSNbUewab62XSMC+vB4
         Q8ZTzxAEWBMHthAnUKYk4cNWo/55/PJ9BtxN8p5taZzlLsrozo1uo0eM7I4+2M8Fw1fI
         qkaFRz69tkmMGDnlv9GPWg46WsAZ8sJoaZlPjVa6Y8hGYMdxJ/y2z/sFzcz5HWZiBBul
         KO6oKIvYQyJ712Plq993w/sYR5TYJPS6arX2yVy/SMzi/Hvb61zVYArJ6+vsWA6WrV41
         R1/w==
X-Gm-Message-State: AOJu0YwVgeXBBp93nsG0FS7Hjmha1zZOY8MnV2h1K65tQ8fDw0RfeDBs
	aUDTdTndL7IcZYZ15fZGypkkg9Xy7ofpQWWeOHsfzOWKTAg3iKfl5Gk8s/GO
X-Google-Smtp-Source: AGHT+IHd9m7pdpONTjhm8GrZB5TQj6pPJxkaAhXyC8ucYLZiBli+2EaboRy/4yu9WJJtmKsK5w2kLw==
X-Received: by 2002:a05:600c:4213:b0:40d:30fe:a7d with SMTP id x19-20020a05600c421300b0040d30fe0a7dmr1039491wmh.109.1705625201926;
        Thu, 18 Jan 2024 16:46:41 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id az4-20020a05600c600400b0040e9d281230sm468614wmb.30.2024.01.18.16.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 16:46:41 -0800 (PST)
Message-ID: <b126398170c949ebdfd36d3db675ea5115f3412d.camel@gmail.com>
Subject: Re: [PATCH v2 bpf 1/5] libbpf: feature-detect arg:ctx tag support
 in kernel
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org,
 kernel-team@meta.com
Date: Fri, 19 Jan 2024 02:46:40 +0200
In-Reply-To: <CAEf4BzZ27fqvetYMQC4Y27pD40D4Fvu0mEPMf+4QJePChNHR4g@mail.gmail.com>
References: <20240117223340.1733595-1-andrii@kernel.org>
	 <20240117223340.1733595-2-andrii@kernel.org>
	 <3cb503acbd2d65dc08172d620fe5dfff5f51be0d.camel@gmail.com>
	 <CAEf4BzZ27fqvetYMQC4Y27pD40D4Fvu0mEPMf+4QJePChNHR4g@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-01-18 at 16:43 -0800, Andrii Nakryiko wrote:
> On Thu, Jan 18, 2024 at 11:50=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
[...]
> > Question:
> >   suppose this is an old kernel and decl tags are not supported,
> >   should negative result be cached as 0 in such case?
>=20
> yep, it should, and it will be eventually when
> probe_kern_arg_ctx_tag() will be plugged back into kernel_supports()
> framework. For now this small inefficiency seems fine, given it's
> temporary.

Understood, thank you.

