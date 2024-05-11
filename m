Return-Path: <bpf+bounces-29593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA92D8C305D
	for <lists+bpf@lfdr.de>; Sat, 11 May 2024 11:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AB3D1F219C6
	for <lists+bpf@lfdr.de>; Sat, 11 May 2024 09:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2CE535D2;
	Sat, 11 May 2024 09:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gphCAjTh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935C81078B
	for <bpf@vger.kernel.org>; Sat, 11 May 2024 09:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715419689; cv=none; b=N8nTmdsTWKthtrPxbpGvCu6FMt7FLN584fO/0P8uvfRiN+VoPTEJR+Pl/PiuPNcZKM3WncXFF6YN6rtdsntqb7zXGs4MQpI0So/xie5/N8Ll6Px9djXaW/NiJbL9a6QqIlNEjU8zfiFKOZWHwTGQ8ikYc/IwNbd00QpskMkBFJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715419689; c=relaxed/simple;
	bh=AZFBuY8Tn7nY1oiJZrEA2XZzxNybnC4YVO/u5UgqH/c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RpUYJa3npFyooN6xPs+BAcX/zHVfXtmVqetp0d1fC6MpTJ65BpB4G628edwkF419vY4cj43oYB2ZFGvkN4U/xRvO2jZ7OuUm+fStt6kLuMxPJplgmie4yTCKy08HIWMlf8VMmTSl4Pe7AaLsPl0ihV14Wa88rnnf40nt/mx70Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gphCAjTh; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so1860264a12.0
        for <bpf@vger.kernel.org>; Sat, 11 May 2024 02:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715419688; x=1716024488; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qorfAGSZE1NsT5HZ4V7uAETi4BD8q/3A08FDMc3IkGQ=;
        b=gphCAjTh/NcKhrGPy69R+e9U5HJzGs4FqT3lSHD4y/eiF22vZ3wNME9BVOIFoNHqmo
         rn2TJTe7NXrKK9h+uCvSzN5rsM13EFnH3wYywQ3J/uCffY2m1rE4F1LOKpFHSRrqQiKw
         WA1RHP8m65yJ0wKsHucTxyvQSO58mSbUZIfPrVGTFWAmzN0+9HtEwQ/wuLBy3AxLxcqG
         wtEIFE+tMWeGBqKHoHG5MYliOBSjos0TgK/mOin+RnRb8LYcAiXrfnQKGUPTYqtk0f0t
         mmUq11lepTGGGJGbodgc8lwzRG0T/6RWsAeQpGXWdcgQfaPoQ2F++PAO75MaSUi4sQpv
         /pdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715419688; x=1716024488;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qorfAGSZE1NsT5HZ4V7uAETi4BD8q/3A08FDMc3IkGQ=;
        b=mgdUSx6iwZFYDJd5oA0xH/bT7Eq9mntHCkjxjnF8nh+LKI+U7wXHJz5d+zz8hgLM2e
         l55w9tXmOLZdiyezX8aVcZQUGxGBtuHMl8jP1tlZdQ0IZWv9AhleTU/Cm896XFqTArPs
         0ecJQos6O8KlnNYBfVs06AkGiFgTDlIEN/Wi7q2LsiH3xMIeG3W6I1eo6D8xXG3nGVCt
         aRIaGNCqVVThj/n/qPJg1R15yz2/XwI1HzU4D1GvFu7jxBkkgiL9slHllxLt6mcx9B0r
         mvOQkLmBwypm1ucMMkfhUuZvt83HRp9DeTwRJf+joNe6QhP3Lva9VcpkrJTAsbvWvh4Q
         vXGw==
X-Forwarded-Encrypted: i=1; AJvYcCWXnbTRI15817bJm+MKII9AkgdiTLMRiHACB9k5VByVNwVmWBSNH1dQ91qXIYnv3fyb/+yn7eqGISvyS959Gwxda16S
X-Gm-Message-State: AOJu0YygKNH47dw6tQSKC3SS1edeS/Ke8dQ7NB1M/9ib1F3146G9IVjw
	RiCxG6Ev0t5AEYrLTvwsftfhRLUrJE4/HMz7F4VozbMq7JBmQB2F
X-Google-Smtp-Source: AGHT+IHV3yOwYVRxojdammuZv/2uYS5Wmzn+h7sUPiB/28HfwhBCj+Ytr2VHdpH1Z++Syp1uApoaOg==
X-Received: by 2002:a05:6a20:a10e:b0:1af:d3d1:3cd2 with SMTP id adf61e73a8af0-1afde0af4b7mr6259930637.1.1715419687836;
        Sat, 11 May 2024 02:28:07 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d1865sm45263395ad.53.2024.05.11.02.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 02:28:07 -0700 (PDT)
Message-ID: <8f42cfab776d84225fbf542591a0b58844421fa3.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 00/11] bpf: support resilient split BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org,
 jolsa@kernel.org,  acme@redhat.com, quentin@isovalent.com
Cc: mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev,  song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com,  kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, houtao1@huawei.com,  bpf@vger.kernel.org,
 masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Date: Sat, 11 May 2024 02:28:06 -0700
In-Reply-To: <20240510103052.850012-1-alan.maguire@oracle.com>
References: <20240510103052.850012-1-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-10 at 11:30 +0100, Alan Maguire wrote:
> Split BPF Type Format (BTF) provides huge advantages in that kernel
> modules only have to provide type information for types that they do not
> share with the core kernel; for core kernel types, split BTF refers to
> core kernel BTF type ids.  So for a STRUCT sk_buff, a module that
> uses that structure (or a pointer to it) simply needs to refer to the
> core kernel type id, saving the need to define the structure and its many
> dependents.  This cuts down on duplication and makes BTF as compact
> as possible.

[...]

Tested-by: Eduard Zingerman <eddyz87@gmail.com>

I tried this patch-set with modified pahole:
- test_{verifier,progs,maps} are passing;
- .BTF.base section is added in bpf_testmod.ko;
- bpftool could be used to view BTF both with and w/o -R option.


