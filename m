Return-Path: <bpf+bounces-68242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D44B554F3
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 18:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C55CDAC2D39
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 16:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C40F3203B7;
	Fri, 12 Sep 2025 16:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+BEUsxD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0F5321433
	for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 16:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757695690; cv=none; b=OUTf4s+zcCQDLPLFXPZss7nLb9NOFUdq5OtBfp9Fgtpi/pNs46t6nXr5WaVTr5r/9b0/xuRyoY6UWTAYYXPoHAdKgH64o088G47pQM6v82uTT9GcDLPR8PmybC78hzDqLMxVXV/AT/ZteH6n5jJaeqpoAfJF/qdaCy9u3ulLUxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757695690; c=relaxed/simple;
	bh=RvDEpeloizCGVbZM9h2TCHBDf+mfeFWHfJJ88MjWEOs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZIHsQdGwYojz0mkpNcUXQuXbjdXTs7ALsIgGGEiVhIBCtrgKD6d+RZ5t5Y2RBUMoXvDWgce0BMt3jZ9xS0vYSfHDesY2s93nSd4bWBorpiF9WQQC3tua9Q67z0JBzwjhQAAFdPmVpJnUBIfrheI2s6a1pquYzfKo/MMWTQwEwN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+BEUsxD; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24c8ef94e5dso17385395ad.1
        for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 09:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757695688; x=1758300488; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JojO/2M959zsBWVjUEkcgukb++2NDZNktHYDQOvCs0w=;
        b=k+BEUsxDBU9twnRWuhzyxmO/Cu+JebyxZZdSB2HjFGZobkoCTTvvLL5QgVQma3jT/x
         a2mJr6l4Q74+QTYX1yi0mPKOsvp7SC/lGKxdphtyd5Q8l/2ChV7E13D24rkEqbma73Az
         yZT1ozDuPTOm0pk42iZkLqzT+ur8CSi7RP57tnxsXZ2kIp50lg6AmTc5rhLUsbWU85wU
         lTVfqfvJim8JosTESSk/k6/Rf0r71AKK8BxLJJpq78jPQiLQ19Sdwy9qVvlcdSN9roaA
         MWUxFEtTqnWL4jGHdAiW4u37vGQukXrv8GqhKeusX7O/atZJIP7P/D544NvvzP50fjA3
         nUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757695688; x=1758300488;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JojO/2M959zsBWVjUEkcgukb++2NDZNktHYDQOvCs0w=;
        b=E7YbrGeHCjtLr9vD6GsBpyITy71VNUMoloSb1+bUyCmk08UmHSZprMrghxKwurbmr+
         JTJnTGJTUWAZAkktQrN9oSvj5n7VlQM1fWuJN8Byx8/DZukRkio+FvOKBjKjnxY8lqXM
         xXKJcufKOTTU0CFHHd+xTvhuzYPWOWNjIsEH0thLu00lGcg6gODwnyHdL97C0f9yGwG4
         tXZNp0bEKIuU92M2tDPF6Ff/M3n9lWoEWe6VktlJn2mmZ4iFzBE4yqKVe4PPZcXQR9K3
         uy1WzOeomZk8tWg7Bs3TmLZpoDl1YOpV1Dzl1eTGUHj6V7WPgm05LZ/jOitII3TKFhR3
         3e5g==
X-Forwarded-Encrypted: i=1; AJvYcCVA7l4XzlteZt2UWAEiuEWa6olbgBY5RdruAwoiysE8+QdOai8VeaRNAUqlHMGY6R4MeAM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1z6BsYIvDsUL2LHPi46AQjY5CphMQiae+KMPm2kuGoRVjp40n
	M2svEV6wta1mF+YV8zYsR4hRgpwWsVKVBHH/TTcMiIg0VDxGmq5vwJGT
X-Gm-Gg: ASbGnct4QgSy5knKK4hf5lYH6t4r49g43Yy45DlcAYNVK7O2gdjp43+Wd6xDoe+1Za6
	a2JNy0lT5asztYJKTGs4SQXvXBlSD3zTXQJa7Mh/tn7frG3JdIFaXpD26rmP6v8YiHgftpZ5IA/
	WI37jtUVWcBJknQNo2McpNJK5347aRZp1nj7SmqOSKSeLNv48JvPqTzcbIwHCL9E21xaV9J/S0F
	FlHGSodxyqnXpcXU92Y4dR4tocpFCLsj02PoaiApB3VEtOpFWAqaSpVO7ap1PItvjjbLWfgM0EX
	cWhxp7LNUvFoA5+CKDo4KK9enuUSVKeMJ5lkArW42gcgv8n9JBoqFX4CF5sz1TrYX7kJJovKqLw
	cHpNNxG3jGIhef9AYAzGUWsjH1gR561ttXvMosY3/rhEH05TqjBo973uVLqQ=
X-Google-Smtp-Source: AGHT+IFbLPULombToQlgoB3lZt9f0p06h3JKUzxWJplHYpXNn/n7w1mHGDTg8MpZyVqCQim7jQ46fg==
X-Received: by 2002:a17:902:e750:b0:24d:34:b9e7 with SMTP id d9443c01a7336-25bae8f39c5mr81665195ad.29.1757695688481;
        Fri, 12 Sep 2025 09:48:08 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:c48c:3b10:7546:af9b? ([2620:10d:c090:500::4:ca20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a35b7e31sm5111359a12.11.2025.09.12.09.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 09:48:08 -0700 (PDT)
Message-ID: <b620881ec86c8074731c1ff414dbb7aa8bade3a5.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 09/10] bpf: disable and remove registers
 chain based liveness
From: Eduard Zingerman <eddyz87@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, oe-kbuild@lists.linux.dev, 
	bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, daniel@iogearbox.net, 
	martin.lau@linux.dev, kernel-team@fb.com, yonghong.song@linux.dev
Date: Fri, 12 Sep 2025 09:48:06 -0700
In-Reply-To: <202509120205.YfzyI2gp-lkp@intel.com>
References: <202509120205.YfzyI2gp-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-09-12 at 11:17 +0300, Dan Carpenter wrote:
> Hi Eduard,
>=20
> kernel test robot noticed the following build warnings:
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Eduard-Zingerman/b=
pf-bpf_verifier_state-cleaned-flag-instead-of-REG_LIVE_DONE/20250911-090604
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git =
master
> patch link:    https://lore.kernel.org/r/20250911010437.2779173-10-eddyz8=
7%40gmail.com
> patch subject: [PATCH bpf-next v1 09/10] bpf: disable and remove register=
s chain based liveness
> config: arm-randconfig-r071-20250911 (https://download.01.org/0day-ci/arc=
hive/20250912/202509120205.YfzyI2gp-lkp@intel.com/config)
> compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 2=
1857ae337e0892a5522b6e7337899caa61de2a6)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/r/202509120205.YfzyI2gp-lkp@intel.com/
>=20
> smatch warnings:
> kernel/bpf/verifier.c:19305 is_state_visited() error: uninitialized symbo=
l 'err'.

Hi Dan,

Thank you for the report, kernel test robot already notified me here:
https://lore.kernel.org/bpf/20250911010437.2779173-1-eddyz87@gmail.com/T/#m=
103a269f4c096b34043bef16fa5f1d629b794968

Thanks,
Eduard

[...]

