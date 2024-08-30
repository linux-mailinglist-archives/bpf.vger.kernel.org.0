Return-Path: <bpf+bounces-38503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C1D9654B0
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 03:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 315AAB20A4D
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 01:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EDA4436E;
	Fri, 30 Aug 2024 01:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNbgsvVX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACD8290F;
	Fri, 30 Aug 2024 01:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724981280; cv=none; b=QjdyFjB9yPUgD15G9ZKvLEoRVTXnCE2DGeYHSHZrvOfana7ayP6HBpVDDOnH1Jy7lVQk/tsZBueSIZ0Z+sVqdLbVDi6AQ7pHQOqzuoD1+MGKUYqeaaqcK4n1JEwOim0BaPtc0dgxBgx159t0mWUQpu0FCCywH+jg0Z50L3Gla38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724981280; c=relaxed/simple;
	bh=tkxizzu+Qr6DYjmqOjEDI9ZEFYL2EjTSNdBrF7enUnI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6O1AbFDnFJsJVUHVVfcdSR4m/lpNOjLhBb6aUNydDXoLIJv4bwfyUWJJkL1Wz0RK+C28v/ns4abEdhRm36oQ2NZ6AhoNi+lNoyaS7ITljqOQdK9j8QZhMawRI7xvnEwYDdTxXAY84ZV1DiBQVarl7ZZ1FADmxoTFrYPWxciC7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNbgsvVX; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5dcd8403656so890448eaf.1;
        Thu, 29 Aug 2024 18:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724981278; x=1725586078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2m5HCa4/RJDxDQiRDnhAfj/vgIx0abd4SlvqW52bMj4=;
        b=FNbgsvVXF9N8i5DwBbTWMDLuwOqBMF0FR3APGpyUiYG2H3dWGIrreqrZR464e9ZV3s
         NVXqLOsmzzCe7oP/4Zh/e+VSby5sJfYOcROjLARrghj6ucppm5uFBvQ93ZpJu40Gca4U
         7Vpn6Dbk2xKTlJUXo2K5lKb/VJtvONpV4Om29tG94plouEt+UrTG828aELmHy+wKYYXp
         VeYRKT8cI6aV9/lZaHR28IWp68iLFymf8AuCgQzLyDk778zA9GTq7sSnbjkzxVB5ZG7+
         CVkVPk7LY3yvj76OyiFR01hEEsnDD8WGptkpql9j8H4XzuJ6gucsgi+OlosBYFGtJZsP
         JoaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724981278; x=1725586078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2m5HCa4/RJDxDQiRDnhAfj/vgIx0abd4SlvqW52bMj4=;
        b=CMfTBiMGgQ73IeDRScGTqiTQGjKRiWDT3qr9fKpBfoyhkUKED8t4hl/9h5GCUIrf7y
         9ApaMHo0OPuIgriq+RSVS6kTTas1y3sJjyXjPh9VJQ9lRhi+pHgQ5aDa8id83Hrms9zS
         ixw3sS/uIi+DL9UHKW2MXkbj23GIJsCjkUPn/FdSl1YnB5jy09wUY3fCl+WxvMzGCNS9
         kYhYUvRyUhAsanTV4mC30wKtOLPjMnpYiXAtDFg94gyVjS1zJvGTKAHi4BxWZqZrXAiQ
         QOr7ZOMo/TZCMxBTQY4AIjcXsxi0mvfPg80DAvE8NBDClSYhPKob3VJLWO0ffIpXDAMd
         96nA==
X-Forwarded-Encrypted: i=1; AJvYcCWij5CU/mrDwg4NGP1vUg93OYh+RL9JaxaHqB9xg/x5k+HnvhCg3gVGTiNu8O1sjpQMAvYefvZ5zQ==@vger.kernel.org, AJvYcCX74RTonMG6Sckj2dDXJEa7qn27eK1kS9oVZmyp/6uaVg5OrweOZ3QkrZxFwrK6lNqu8nU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdCKZ0eaN+Cl2CLtR+q1I2Rqun78B1om/UrXdhCA6w7VK7fR3a
	v9rPQEXwIlFI/jRsYxv/6giGwXov72cUtpsC5y8COiVnubgCjQAr
X-Google-Smtp-Source: AGHT+IFqvl1/V3gSGMTqvpExWUqjy4mfg/LC9uFc4ljYJoqQw81zdEjYn+KvHzmXaT9jOrDozkPrHg==
X-Received: by 2002:a05:6358:5289:b0:1af:1bcd:a37a with SMTP id e5c5f4694b2df-1b603cb88a7mr618873755d.22.1724981277548;
        Thu, 29 Aug 2024 18:27:57 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9be18esm1883333a12.73.2024.08.29.18.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 18:27:57 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Thu, 29 Aug 2024 18:27:55 -0700
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, alan.maguire@oracle.com,
	dwarves@vger.kernel.org, bpf@vger.kernel.org, andrii@kernel.org,
	martin.lau@linux.dev, songliubraving@meta.com
Subject: Re: FYI: CI regression on big-endian arch (s390) after recent pahole
 changes
Message-ID: <ZtEgG6XJGIGn0z35@kodidev-ubuntu>
References: <6358db36c5f68b07873a0a5be2d062b1af5ea5f8.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6358db36c5f68b07873a0a5be2d062b1af5ea5f8.camel@gmail.com>

On Thu, Aug 29, 2024 at 05:05:20PM -0700, Eduard Zingerman wrote:
> Hi Arnaldo, Alan,
> 
> After recent pahole changes [1] BPF CI fails for s390 [2].
> Song Liu identified that there is a mismatch between endianness of BTF
> in .BTF and .BTF.base sections.
> 
> I think that the correct fix should be on libbpf side,
> where btf__distill_base() should inherit endianness from source BTF.
> If there are any plans for new pahole release,
> could you please postpone it until current issue is resolved?
> (I should have a fix for this thing by tomorrow).

Hi Eduard,

Thanks for looking at this. I ran into the CI failure while using s390x
to test a series adding libbpf bi-endian support. Since I'm deep into
endianness issues right now, I thought to try the fix you suggested just
to make some progress but noticed the CI failure has disappeared.[0]

Did something get fixed already? I can't seem to find the change.

Many thanks,
Tony

[0] https://github.com/kernel-patches/bpf/pull/7520
> 
> Best regards,
> Eduard
> 
> [1] c7b1f6a29ba1 ("btf_encoder: Add "distilled_base" BTF feature to split BTF generation")
> [2] https://github.com/kernel-patches/bpf/actions/runs/10622763027/job/29447973415
> 

