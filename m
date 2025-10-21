Return-Path: <bpf+bounces-71559-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A5FBF6763
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 14:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6F2C18A7C9E
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 12:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DA432E133;
	Tue, 21 Oct 2025 12:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Mb4+R3MP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B902F2619
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 12:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761049931; cv=none; b=O6fWfq6Xa5vhrdryUubqaq5DEMD45Kua07M7+h9+zIi5AWc8VmvNBQ0m5hUpeqCNz5bMrU8c8mJM2ECCRoO154pffKU/p3T0OnjUzjE7B9IiJTbiTdCR6mUSH0BcCpQtjr5+MagYHTheqVqMPOsLxgLrs8OIv26Pw4ug30dyIaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761049931; c=relaxed/simple;
	bh=OqZpGvkjwOfQHHFVzAVmqW+ATJ5sQiJth0QiaygY6Qo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d2GRmeB7MWGwOYvkMxiP75B7a6yHs/z8VRI3a0PMGZQJTEmscYrbibD0LgbMV3ig/VDT+yKAVlI0/vVSe1G/G6QVJBuRDdimAimrmIm4yUBuqUdccA3ghmGKBxU5oms4nObfLYgE4VLjBR3D9ftvf89nsn4OgVJWeIyr1FylVJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Mb4+R3MP; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b50206773adso1140799966b.0
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 05:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1761049928; x=1761654728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xFwGw6ZE8EhObsv2lodIrTXfK6bSfV60ydBz80z3y+Q=;
        b=Mb4+R3MPF8xwB8vIBpLkcHzBVkaChdW0n6z1jeoWMqU574pg/JYr4togg6CTAC6l05
         wq3Veb8yqwB6SAaTZTsg7qlINys5NQtWBMpN2+erh2UuRv245wlXl4abiVmptHmKhkDh
         Uhvxyoi447ZnM6/HMN52VFlQDza+nUcZ9Iv/TL+7B4PYwyRKatiId6JxsvZANepGkhlY
         IyyLmwD/4KzME0l0Dazd6S8fLvgkTj+WMoFaN/1zZLRS+YW7EbRGwcRPk5dLgKSD0wKK
         Vn1UUvPYhtU0WX+5GkIisunr/69KgU2baTjoZctQ+7nThrf5xhqaNdduruB3GxWpRalL
         46nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761049928; x=1761654728;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFwGw6ZE8EhObsv2lodIrTXfK6bSfV60ydBz80z3y+Q=;
        b=o578Zp0xFCKJIq5mGsIM67khSW0Mkqk3T2OwGM/UPG1eAKuJhoboAtoHrK6mH1oLrw
         vqvK/2W9eCEt0YoVK4Ec4K4DUE7Z0Tl2n5QatSLBMf54XX3udaIVgLgFz+orro4zqXnj
         tkaSK/+hmR7pO4q+AkatIKJ80UUHed/QgWACQLFROxk4FsC0iDhYiyn5B7Te5JymiWbB
         FajAEv6Nsnz2EA7Zj86t/rtSLJRKUb0K4Cxiu9tV2m/KikSAIlmeuADTzvVKfdYF/pgC
         AC1TFdTFFqRuYm43vAmAtYsRNMGxzzkq0MNX9BwdghygPVVTAZF4StKOuzNjIc80rN8y
         e9gw==
X-Forwarded-Encrypted: i=1; AJvYcCV5G48CNQgT6OCvnO9MfMjUgABRGtZ7d3/c8Oj0O4aLFEIDN47U/XSv4VUH7wLn4DLbQns=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ1SDe2jAZZ2a4TT/7CmCoVdyZoDBbHHCPsxcNZHNyErcZuymg
	zbileULy+/JZXuOQZJS3CAN7TaC3th18aM1qxoG1VtRSLpifq+ytfvuD0hgQ/l7mQFo=
X-Gm-Gg: ASbGncuDKD6EjQFF+I8mkHpmxRE2E+TLyByEsh79quEu3Twix/0UuhNHScWHHPby8US
	mbvCLRrEEPXcbQO/tpRLAEjfSh5pYhyvtYQI3cg2axwru3Ag+EOirBpbO1kozwfyc+jKjlLXs1d
	LBss77GwjBmFXTSvtzBZ1zKHpTz4kMXc93MNfHbwMUJKd7+J9zEY07tRx7yt/x+lE+F/AffVf2z
	Xkm0ndk0IldjAECFDGghYekrjpALQ/IzzAFO/GHw/tELIgUQdN671M6OKlF8rYYsgWVutG03iat
	eTv6sxIFFM9WS25r06M/a8xSEGrGp4Gmc8oFsxrL2sAKD+I1nKPcztZ949ktyyo4+gAo/aFG1Sp
	mtBbsQDKmOQapiJ5As7ffvkxxGGbLTlNeYjvkudhIuKzRngN53IJN1hVSd5G7vjMUIekKnapVQx
	1efuY=
X-Google-Smtp-Source: AGHT+IHWIb+Co+vuJf1iem9c6iig+KbqAhYRE4O2xwNvbAOF2/NUXOJ6de1WKz1tjfueBppgc6L9eA==
X-Received: by 2002:a17:907:9718:b0:b3c:eb78:e085 with SMTP id a640c23a62f3a-b645f0f9992mr2097988866b.27.1761049927573;
        Tue, 21 Oct 2025 05:32:07 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:d0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e8391547sm1069622466b.22.2025.10.21.05.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 05:32:06 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alan Maguire <alan.maguire@oracle.com>,  Arnaldo Carvalho de Melo
 <arnaldo.melo@gmail.com>,  dwarves@vger.kernel.org,  Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>,
  bpf@vger.kernel.org,  Daniel Borkmann <daniel@iogearbox.net>,
  kernel-team@fb.com, Matt Fleming <mfleming@cloudflare.com>,
 kernel-team@cloudflare.com
Subject: Re: [PATCH dwarves] pahole: Avoid generating artificial inlined
 functions for BTF
In-Reply-To: <20251003173620.2892942-1-yonghong.song@linux.dev> (Yonghong
	Song's message of "Fri, 3 Oct 2025 10:36:20 -0700")
References: <20251003173620.2892942-1-yonghong.song@linux.dev>
Date: Tue, 21 Oct 2025 14:32:05 +0200
Message-ID: <874irswi4a.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 03, 2025 at 10:36 AM -07, Yonghong Song wrote:
> But actually, one of function 'foo' is marked as DW_INL_inlined which mea=
ns
> we should not treat it as an elf funciton. The patch fixed this issue
> by filtering subprograms if the corresponding function__inlined() is true.

I have a semi-related question: are there any plans for BTF to indicate
when a function has been inlined? Not necessarily where it has been
inlined, just that it has, somewhere, at least once.

When tracing with bpftrace or perf without a vmlinux available, it's
easy to assume you're tracing all calls to a function, when in fact some
calls may be inlined within the same compilation unit.

A good example is tracing the rtnl_lock - there are multiple inlined
copies, but neither bpftrace nor perf can warn you about it when debug
info is absent.

$ sudo perf probe -a rtnl_lock
Added new event:
  probe:rtnl_lock      (on rtnl_lock)
=20
You can now use it in all perf tools, such as:
=20
        perf record -e probe:rtnl_lock -aR sleep 1
=20
$ sudo apt install linux-image-`uname -r`-dbg
Installing:
  linux-image-6.12.53-cloudflare-2025.10.4-dbg
[=E2=80=A6]
$ sudo perf probe -d rtnl_lock
Removed event: probe:rtnl_lock
$ sudo perf probe -a rtnl_lock
Added new events:
  probe:rtnl_lock      (on rtnl_lock)
  probe:rtnl_lock      (on rtnl_lock)
  probe:rtnl_lock      (on rtnl_lock)
  probe:rtnl_lock      (on rtnl_lock)
  probe:rtnl_lock      (on rtnl_lock)
  probe:rtnl_lock      (on rtnl_lock)
  probe:rtnl_lock      (on rtnl_lock)
  probe:rtnl_lock      (on rtnl_lock)
  probe:rtnl_lock      (on rtnl_lock)
  probe:rtnl_lock      (on rtnl_lock)
  probe:rtnl_lock      (on rtnl_lock)
=20
You can now use it in all perf tools, such as:
=20
        perf record -e probe:rtnl_lock -aR sleep 1
=20
$

Thanks,
-jkbs

