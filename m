Return-Path: <bpf+bounces-39298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA81971325
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 11:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3FFF1F24FE5
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 09:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E441B3725;
	Mon,  9 Sep 2024 09:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBSqrw4/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9790C1B2ED8;
	Mon,  9 Sep 2024 09:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725873474; cv=none; b=YSLekTqOX8r8HsBOu8okL3mdsAdkvqKGdA8etcLa6k3U2ozCbXh7S/XA6Mh/tnFnTzMla40bTJBGITnxw9MmmFBg3l+0Hiaj3jXgxK6bqCRYLeVxu+Lqd0pA2dhFQFivlMVMBA6xw7VJZ9XaF5MZHYBZy6FB8sAbfXGdwDeqneQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725873474; c=relaxed/simple;
	bh=ehrj6/zILCe2VFbgx75mcaB5/hqaA9rzJieiqddh2ok=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=og+e945e218rvVTBN2ltqOPv6/+6S59mWLCMcA8K/NHwBcnfXVHfLYpMuepM84VNVLuZRC1LdjBdFqgohCqSUbaXa3An7XcMu9iglcBJOSI9UoMyfbLvbIbrvfnjcQAH2mMqTy2/6Zfkrv84B9gh3/izKoP1/4/HlAWHajoRShs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBSqrw4/; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42bb7298bdeso47595895e9.1;
        Mon, 09 Sep 2024 02:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725873471; x=1726478271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HKXxK01BvPn3tPSYq0qYq1pxCR24sh+Mj4fZq1TzNLI=;
        b=eBSqrw4/tgyF+oF2um8JLEIFO5fZcmQxMmLBElV89dVHwnBQTXbL269rGQhyXisSXl
         TifRKKG59+N5Uf42BSEWXocYsM9ffh0w8SIWPTaCLNKf78wg2ysrcVZLvy0luSXV+edk
         wBfTnqmZXPzB56JY0cqFT0iMb4GIOLrYZdf6hl5BE4EUSHiaC+nAeM00fSnS2UUa9T/2
         UR7NXy3wB4GV1T1rgCQWIEaXF20zht6QnpbHsKFX7VdvP6JdkJGU6e7+ypjn7LHRTaGG
         NNrJZqa8QtDZ6EXAkOXG2c1KnZxK0JNBCzcSsIc2LD+jggTcnP63q47pII+3WGGB7i0h
         wnOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725873471; x=1726478271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKXxK01BvPn3tPSYq0qYq1pxCR24sh+Mj4fZq1TzNLI=;
        b=EFznStmwdh12y5DxYKraKLk0BUwPt8j+OFHjV0ifcIDDRs/rLhR3mlpiL+QviAfJd0
         M8EvAWNjFQhZ9+3xgRaKOAKSMTXTX4ph/TUlkOz0lEhAgp91R0Bj8Ivw70xdaiN7TuiX
         khGjlVBfFcGpd3ZUO0I//Zc7r+kyJ8hztqx9oU58BUpfoej31ClvjvcvsnYnQKNNH0Tk
         RyrRwpWyMrg3zlllRlrHXZrVNm9TaScbP4hvae7PgF4+jigVc6gi/u3piMridnS2QdSW
         9q0vV2qEaESaIKQ+KOtuHhNnhtT25j+P2nCmxMshVvSs39HoEv/JllizIcFhFOVETvjy
         TZxg==
X-Forwarded-Encrypted: i=1; AJvYcCXL0ZNe5f/EmZwlbEk4hB7/nX4RV/TCWjKy8ezD8wmW1E2MLjzIfZmRA/ZzSOhJNSk3lVs=@vger.kernel.org, AJvYcCXTItiFnwqwLDat9783J2leSw9LddwhkcfK0yh5e+zh6/BGwGBXIeihOKMGuNL3rD5BCLj/TM9Q8jWKX99m@vger.kernel.org
X-Gm-Message-State: AOJu0YzN6LMTtBBdqV64BeLoloxD7mBq0Eti4RJWyLBkrLj1jVSVZjfZ
	gA4Z7OD72ecOwD+iWqxIeBdQohDHxWRoEanbLrF558VEmNYjRn8I
X-Google-Smtp-Source: AGHT+IFB2RG9lizAutfv6eDf132uOfQfkLQjPZI3jBzSEws56H95lG6uitH0gpxpoVuK9XGNJBriaQ==
X-Received: by 2002:a05:600c:1d0e:b0:42c:bae0:f05f with SMTP id 5b1f17b1804b1-42cbae0f237mr6068655e9.13.1725873470507;
        Mon, 09 Sep 2024 02:17:50 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb21a7esm70580955e9.4.2024.09.09.02.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 02:17:50 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 9 Sep 2024 11:17:48 +0200
To: Tao Chen <chen.dylane@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Hou Tao <houtao1@huawei.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH bpf-next 0/2] bpf: Add percpu map value size check
Message-ID: <Zt69PODgEkg3F1x9@krava>
References: <20240909071346.1300093-1-chen.dylane@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909071346.1300093-1-chen.dylane@gmail.com>

On Mon, Sep 09, 2024 at 03:13:44PM +0800, Tao Chen wrote:
> Check percpu map value size first and add the test case in selftest.
> 
> Change list:
> - v1 -> v2:
>     - round up map value size with 8 bytes in patch 1
>     - add selftest case in patch 2
> 
> Tao Chen (2):
>   bpf: Check percpu map value size first
>   bpf/selftests: Check errno when percpu map value size exceeds

lgtm

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
>  kernel/bpf/arraymap.c                         |  3 ++
>  kernel/bpf/hashtab.c                          |  3 ++
>  .../selftests/bpf/prog_tests/map_init.c       | 32 +++++++++++++++++++
>  .../selftests/bpf/progs/test_map_init.c       |  6 ++++
>  4 files changed, 44 insertions(+)
> 
> -- 
> 2.25.1
> 
> 

