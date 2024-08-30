Return-Path: <bpf+bounces-38535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80157965C7B
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 11:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B28311C2361E
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 09:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B112E16F297;
	Fri, 30 Aug 2024 09:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVQQsP9b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C0313A261;
	Fri, 30 Aug 2024 09:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725009210; cv=none; b=Y+GTaxiwd6N0Ov8TIPkfSrqxZzh2+f/D1fk8rmFqcer/B6dN2xlKvJLWcbgm03lkzUZqNje0bcMRv/dxQsZw/vkCxX5VJlZoR2MYu2YdYIySA3rkd+sA6k69rP8Z+FoSTUAi7ZzJKzqXS8QjiAPR1VnEvOupMA178Gj+ZWTDGlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725009210; c=relaxed/simple;
	bh=nd5onKL+32OnVu9/NOPKTtnrF7l+JlmBprzkYgVHn5Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OxpbKztStsQ4punTt28PgyxdkLTJSogESC3JMMf0BfHvsKL+RreqNROe7t+8/RvYmZfujHfWfzl4dpxL5/DAjjzKFl5v9olpenyoK68oOcFZqQLb1+vdcsiqURzWIbeekeS4ogHCEJ7ppg2CCIMyvo63ZGlpG50cZUQoTZueNZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVQQsP9b; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7142e002aceso1342172b3a.2;
        Fri, 30 Aug 2024 02:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725009208; x=1725614008; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nd5onKL+32OnVu9/NOPKTtnrF7l+JlmBprzkYgVHn5Q=;
        b=lVQQsP9bxp22npQB865WLxD9CUPPn0BIvd/tqSnrOve2PwdUaLPeg++HvEtMBaWQNz
         q1ZA7Hk82ddRu3wMENEgP+Zink4FyIePjk9K8zZTy112jILPGLXoqOiP+93CA1cZuE2C
         DnhV/xbmxIvoLysRtARkZny9nlVzf80haYyMgoI4pMi5VVJGbfma9GTfL0PamoGgrBnu
         8LO5XjnxJdNUbF0P7Lo5USW2qrZ+dk/EYDk9DRA8xBJ1l3KOQqeU6bFE4Hs9+vkho8Kx
         ZmDAhDy8gji9ENQIUSSQToIaE4ZkhBOvmdE6oH0ZIeZ058zwK+WOfxtErN8Ia9aR64Fq
         ovvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725009208; x=1725614008;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nd5onKL+32OnVu9/NOPKTtnrF7l+JlmBprzkYgVHn5Q=;
        b=Rr62ckUvro2H3nYloKmST2AP4yW2kbjY8seyiGoopMjMDUhCQ5yIHFJx4xNQqTt/Pt
         L/+2BC/128VhB1xEfgOUy4IWAMeRT7MHz6qyTZE+VCOri0gEsrrEByB6aOyS4HdmKA4M
         Hx9CBWpOQi0bSpc3qVFoNrD2HKBcvuwpboYorOYoXL4knAGpTkz9jxSY60fXWpWYxgYB
         GVBzjRKtlNF3MDdNNCEc03EYanl7ichc4Bp+YMmNgLbxAnc1fFXXIm0N9tSZWGUY2VSO
         nRg72gDkmM0399e19c26lrwnNKzdaw3sluDIfmOfXW2yeweaavqyxtmOXM9N0Sz1lERX
         duaw==
X-Forwarded-Encrypted: i=1; AJvYcCVnM0m69L090FeOni/vYXFptTXyeydOKScnHHGKpmztIbCp+o0zNRRLfUb+bJrQTgdVzWz8vg2+aw==@vger.kernel.org, AJvYcCWe/1PoaeLaimG7K4O4ccPseXAR2JkZyBSywW8v9BDY7krRorWuIGwkf2uIOtOvesvz/6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAoh8Bqiq09vii5BleypyQSZ4AwHm1RHqS3xW/4uk+r6lKJnyb
	EwDx8ouMNMckk/sg4BgOzVIvYqKabz93ceVMQYii4tvHBUlb4fb6
X-Google-Smtp-Source: AGHT+IF/LIP8ND7kv/7bEJ6ZpQV79oNT0a5Wcej0fO+LmyeDvEG1feSYUJT1TWCFZGeNP8Hs7ab1Rw==
X-Received: by 2002:a05:6a21:9185:b0:1ca:dbf7:f740 with SMTP id adf61e73a8af0-1cce0fed444mr5565234637.3.1725009208066;
        Fri, 30 Aug 2024 02:13:28 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d85b39cebesm3221850a91.45.2024.08.30.02.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 02:13:27 -0700 (PDT)
Message-ID: <5be4f797c3d5092b34d243361ebd0609f3301452.camel@gmail.com>
Subject: Re: FYI: CI regression on big-endian arch (s390) after recent
 pahole changes
From: Eduard Zingerman <eddyz87@gmail.com>
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, alan.maguire@oracle.com, 
	dwarves@vger.kernel.org, bpf@vger.kernel.org, andrii@kernel.org, 
	martin.lau@linux.dev, songliubraving@meta.com
Date: Fri, 30 Aug 2024 02:13:23 -0700
In-Reply-To: <ZtFtQRzg/LQOm7+r@kodidev-ubuntu>
References: <6358db36c5f68b07873a0a5be2d062b1af5ea5f8.camel@gmail.com>
	 <ZtEgG6XJGIGn0z35@kodidev-ubuntu>
	 <e524ae6265bb34ebd2f68fc5c246b9c43235c15b.camel@gmail.com>
	 <ZtFtQRzg/LQOm7+r@kodidev-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-29 at 23:57 -0700, Tony Ambardar wrote:

[...]

> Please try with the patch below, or I can just send a proper one to the
> list with some added "Co-developed-by:" if easier?

Hi Tony,

Thank you for working on this. Sure, please send a proper patch, don't
bother with co-developed-by :) I'll send you a selftest shortly.

Thanks,
Eduard


