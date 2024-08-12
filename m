Return-Path: <bpf+bounces-36902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC14394F365
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 18:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDF9F1C20DA6
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 16:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A77F186E47;
	Mon, 12 Aug 2024 16:17:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8FF178CE4
	for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 16:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723479428; cv=none; b=W+sZKHSKieiCiDLldfPlPCUF3RWsXfmKX6+KFkrzZyhQfplUBiwYfAOWFRL3jPFUvAMsQb9rgFmNRvF97RjKrZ3Tv/S23dMPbWvyvuSug5bWjqx3d6G3Abc+P8flhMkFBiz8Mr5obr8cQqHqHH6M5/YbFhjh3zO9O3n9lPyykb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723479428; c=relaxed/simple;
	bh=xg5OADt3JIw1nWtaRDSISc4D7PFEK67GBojVpnkvar0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ki5El5jkwhb5U3Rn3cZKzyyORS3Ce/LvT1HJFvj8CgOAdO7gc7As/X1LRS09EWU6byyPx2aP/UfAHeFgMy+AkFppTewaNm/oolgj6BjxOS3Z30z+dd1UwqkS6+B3yZOPJXn4U9StctwrpdH4r0WHT8XIUdUf3fxny+kpUYlr/4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fd66cddd07so30206155ad.2
        for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 09:17:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723479426; x=1724084226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZS19l8mSEULU+BdhpZoRbbmerqTadQ7FnbbNfPFGxkI=;
        b=DCDLtw1WUz4OShzR9rNfJ8xNLpR9V9NPyRgnN1A0YwkLO105pK8VVQ+xtB40npiEz4
         usNtbkzhg2IjaJd6Tc/4FQzYXcZYJeQQl8BlGIzDmfVWNEjteUJWK9vHOyTMAmkTtVKs
         ZEqc8vuf6kM+UArB4NL7MWt6T/G7rAH77f9l/zkEU2ADKcV3fSOTDBUZ0ILrSk3fAJsC
         4FBLt6zG/d6rjC6gntSc/3bAwbK7V2Bz1MSWcrT4bX0xkNIWyrOO+aYjo4MiZjKV3L/3
         Ma6JXYjoNLJx5to1DNeeGRoFXrkeE1PN4udQOusXgKpzHYBGG5OgWQSnruzv/bMC+sR8
         bqpw==
X-Gm-Message-State: AOJu0Yx81srUqa5uzmbAZPnM6p5Wo/knbwzaUeuyb0c2gCEL2cJxg/BN
	PoXI292Ni2yZOUfVBLzpfHG7yjFFrYLLipLi5fLx/c9nFIcXUBT2OOzHIFE=
X-Google-Smtp-Source: AGHT+IFWPkXt1T0v92pBolc8CT/YIJ3s12wtjnWbx2/uCiDFxlgxT/tc4CCajJw2eKYjs4eAtLHwmQ==
X-Received: by 2002:a17:902:d503:b0:1fb:29e8:5400 with SMTP id d9443c01a7336-201ca1c5715mr8684725ad.56.1723479426432;
        Mon, 12 Aug 2024 09:17:06 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bbb3a84esm39672845ad.245.2024.08.12.09.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 09:17:06 -0700 (PDT)
Date: Mon, 12 Aug 2024 09:17:05 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
	song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
	geliang@kernel.org, sinquersw@gmail.com, kuifeng@meta.com
Subject: Re: [PATCH bpf-next v7 3/6] selftests/bpf: netns_new() and
 netns_free() helpers.
Message-ID: <Zro1gdicFt9Nnev7@mini-arch>
References: <20240810023534.2458227-1-thinker.li@gmail.com>
 <20240810023534.2458227-4-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240810023534.2458227-4-thinker.li@gmail.com>

On 08/09, Kui-Feng Lee wrote:
> netns_new()/netns_free() create/delete network namespaces. They support the
> option '-m' of test_progs to start/stop traffic monitor for the network
> namespace being created for matched tests.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  tools/testing/selftests/bpf/network_helpers.c | 52 +++++++++++
>  tools/testing/selftests/bpf/network_helpers.h |  2 +
>  tools/testing/selftests/bpf/test_progs.c      | 88 +++++++++++++++++++
>  tools/testing/selftests/bpf/test_progs.h      |  4 +
>  4 files changed, 146 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> index 47fc37aa13a5..c896ae365fe3 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -446,6 +446,58 @@ char *ping_command(int family)
>  	return "ping";
>  }
>  
> +int remove_netns(const char *name);

Nit: if you end up with another respin, might just move remove_netns
implementation here instead of a forward decl.

