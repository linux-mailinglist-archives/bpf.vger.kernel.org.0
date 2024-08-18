Return-Path: <bpf+bounces-37440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 993D2955A9E
	for <lists+bpf@lfdr.de>; Sun, 18 Aug 2024 04:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 532CF281F1C
	for <lists+bpf@lfdr.de>; Sun, 18 Aug 2024 02:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3A8747F;
	Sun, 18 Aug 2024 02:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEEKLb8B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C551610D
	for <bpf@vger.kernel.org>; Sun, 18 Aug 2024 02:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723949458; cv=none; b=YWmNtvhautGoUfGddDFfdMn+27qFNbaOPyWMFLGwFWGVwsaSO0aAjHguU0jW7ERxe/dUmuHr34W5jLuHdM3xM+0Ay23VE3HmGIEZhzbkFdsFjYfrOAJ0N3HENTuIf8+fEdPsTJxa11bcDI0VqbWV6eB76Nuy1oKJ48GSHliN2+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723949458; c=relaxed/simple;
	bh=PruKMWplCDU0/BtRmK6SNIHKLCfRBU1Sopys8hpz448=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M9gN/35meF2ywF05JDAMrEFQ/040/ytPVzSxyBfieUaxeWF4rZBQOyY39qhWIr1K7UUK7+BoRw06YW8zmf0OzUKiGErrrFY2LToX1VVXDEip2+KeZGnsq2VQ54GJzhh7ZfyZcfBac8mPSWML1pXqmNz3E+WxPJ19Sn63mbcV5sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEEKLb8B; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3db145c8010so2140259b6e.3
        for <bpf@vger.kernel.org>; Sat, 17 Aug 2024 19:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723949456; x=1724554256; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QIic2+KKM+9RtdzGAQ9AwJF09w5aYhOH1xvxCtztzbg=;
        b=YEEKLb8BF5hRzcZ5TJ5Th0g0N+IDUuCF8jUx9RHNQeWXj+X7FrSroH7P6eDV3RQFwj
         StyFYZXqk3DnmES/kfaxPaYZH7OtnQm4UazHuCAMr1jmilAZUeI7x+2Fy4Ffb141mVJI
         IBx8EYtBHTgSTV4rCRiEdE27NCNO+cTaEALM3kXP7ymuY5WPYbI1eX26jVbtAEtgzmDe
         PAjFGLCSq3obv/cTxOY+/EmQWM26NvQxQsVH4bS0tSGLFidYWF0XQywjWH10KRf1r+Iu
         nasJsKCWd7YfTFN4aCnNA4dwcjG/WUsGVkc3doPOJNNwvuaqiz3Goeq7ERrwkpM+VHqF
         MAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723949456; x=1724554256;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QIic2+KKM+9RtdzGAQ9AwJF09w5aYhOH1xvxCtztzbg=;
        b=aGp/wmTSxoY+ZMTlkjpOAx/v/Mmz0dF7wT56IGoQ/G9QkEhPwi56/C3Y+vBGtFkNBe
         VVCoP573+k9QYrQTJxVo9SEIyZlGaso5Cu1hG6VYrPHZS8A7VXtg+qwQWoPINwpH6W3f
         7PjKqTcm+hpFwple7CcrQI5X6hft2QNaGdrUUUQayiZrLEgeF8eodCVvQJSJAnKHi21M
         inNb5I1536MMvJuaXUahvhBBq9oLByQhZCPtgl1KNddkQ4GsuqVeu92OI2vCUQH9kf54
         TNFlgVFNrCLihIldAQrODlFp/0H2/zxrylae9IuNQO0bYZ6fuaZ+wsR+U2tT6C93q66k
         VUxA==
X-Gm-Message-State: AOJu0YzFBLpQ4nj8LU35Ugo1SokBOxJ+YtEvQoh6TSjWD4NnY6NCgldV
	CZAaIzrMEdz/CuiOzfKqZ4tUZBG2uMkxDHOFs6lIpEgGyPQOjVewBdweM9X13VU=
X-Google-Smtp-Source: AGHT+IFHK9QEK0DrdzdcrFlWDoE3iPgdZuauRFD4RT/ojdbUyAZvKo6Ok/2gBWkwvyExQrL72hUNJA==
X-Received: by 2002:a05:6808:2195:b0:3d9:e1d1:157e with SMTP id 5614622812f47-3dd3ade9f88mr8522315b6e.35.1723949456296;
        Sat, 17 Aug 2024 19:50:56 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f02fab02sm44730715ad.48.2024.08.17.19.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 19:50:55 -0700 (PDT)
Message-ID: <b79b8935e9157d878740d22301606f4b38eae0f8.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 3/5] bpf: support bpf_fastcall patterns for
 kfuncs
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org, ast@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, kernel-team@fb.com, yonghong.song@linux.dev, 
	jose.marchesi@oracle.com
Date: Sat, 17 Aug 2024 19:50:50 -0700
In-Reply-To: <202408180356.YZnBVEv3-lkp@intel.com>
References: <20240817015140.1039351-4-eddyz87@gmail.com>
	 <202408180356.YZnBVEv3-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-08-18 at 04:09 +0800, kernel test robot wrote:
> Hi Eduard,
>=20
> kernel test robot noticed the following build warnings:
>=20
> [auto build test WARNING on bpf-next/master]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Eduard-Zingerman/b=
pf-rename-nocsr-bpf_fastcall-in-verifier/20240817-095340
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git =
master
> patch link:    https://lore.kernel.org/r/20240817015140.1039351-4-eddyz87=
%40gmail.com
> patch subject: [PATCH bpf-next v2 3/5] bpf: support bpf_fastcall patterns=
 for kfuncs
> config: arc-randconfig-002-20240817 (https://download.01.org/0day-ci/arch=
ive/20240818/202408180356.YZnBVEv3-lkp@intel.com/config)
> compiler: arceb-elf-gcc (GCC) 13.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20240818/202408180356.YZnBVEv3-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202408180356.YZnBVEv3-lkp=
@intel.com/
>=20
> All warnings (new ones prefixed by >>):
>=20
>    kernel/bpf/verifier.c: In function 'kfunc_fastcall_clobber_mask':
> > > kernel/bpf/verifier.c:16146:33: warning: variable 'params' set but no=
t used [-Wunused-but-set-variable]
>    16146 |         const struct btf_param *params;
>          |                                 ^~~~~~
>=20

Missed this warning.
The params variable is not needed indeed.
Will wait for comments before resubmitting.

[...]

