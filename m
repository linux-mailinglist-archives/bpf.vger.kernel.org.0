Return-Path: <bpf+bounces-33849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA421926EAB
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 07:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 734BE1F240C1
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 05:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6B41A00FF;
	Thu,  4 Jul 2024 05:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTPvg3IV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD771A00E6;
	Thu,  4 Jul 2024 05:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720069396; cv=none; b=SOoq+m57FXD0nwIVEytejsYYlasOn3wJYpVKEjSOXqKEq8IAg2jlxz332Pialo2BHGvbjdbP1P/X5vWOZUOHOKh+59Ytc/pqHFVHyHNYe78NcFR5JTOCxfSeT9jBGp2818k3cyPORgUHLqQR/kOC6tqC7/SL+MJDkguHMjOlo6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720069396; c=relaxed/simple;
	bh=6WSDXjJlXcgARzrUVKKDLLCw8TApN5zUoiKdJsIpYs4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a27D57YVH3QoOHZQAxA9RjYcqQkxLD6QmJz7aqZB/7CwwTjjIUthaqQfkNIDGXkS88N4Pbey+mk3fTyyuWg+SDuN336fQ8UZe/yy0f7UuLAnCTcCj/IH0OLcmJFhpos0X3E7aOEtvsgBxJhIxWRQN5vj+JSKpXDXhkGN7jf8d+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTPvg3IV; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7611b6a617cso37234a12.3;
        Wed, 03 Jul 2024 22:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720069394; x=1720674194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4AJCTiXNvt0a2e4v6aRqgl8hGwN0aG4btdU6GfMmuWM=;
        b=bTPvg3IV1SBDbDt7IxQkkUDCGUwMm443wWA9ihTchWiUYLVQhPDRocdTBK08WXh/jT
         DTL1/8HTyEjXDhcogQkKGCipzpYGISZ07Vmbx/2B0tCAjUYVkZvAqkzmX5SPO6oEg0+W
         dgvDagond63tHa1Cd6Ed6J8y7f09WU1DemSnJqRFSR/uLNX2uqCH6pjY7quqGHoowpQY
         eKyUenRQVAJJsOPPsX3G+55lIuCmrctvib500oHUKpLS5ur9bYg6WN+GURLqe+EqXpMt
         4vWZTTUAOO8eosv6XJruMq3G51NmnXymt+2Mo6O3oIlYKoUH8rZC7VXhoWWxa+cVjEAw
         z2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720069394; x=1720674194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4AJCTiXNvt0a2e4v6aRqgl8hGwN0aG4btdU6GfMmuWM=;
        b=r/nfzfvP9tG9mKoeavvSQ6zJjnxBg5ft9pJEYfbOlmveiGutAajMwO7dmfH1cZ+Quh
         bVX+VJE4m1Sd9y0Hk5PbqwH0vyCKC4NYNcUmm/rKeA6XLvUDmj3r0mCo8WkqaFOsTLiy
         2LwLeOFa8hTXo1Bn/G/1b4c+Wm+61ieCddBxin2LpViOgSNx14+XPlGiupCwBbZ7vtIX
         vUwPUiQupLEDceUw0hiP7lrGCm/YXbbx4j+LdOT+TnLfFsK3tKjxUKHpUHBxbigeioDw
         aiATbibYMix5RxbQcjUvML0VQDV8NiLzI8T2F1PE0y6EVeY7EtU2qImIXWjMy9H0cbh3
         jPnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNHoFxe5lKaeYk7f1ExPSB6ujC5cJmW8HSS4+LFfghP5vPGTAzXgDRxL+GMV4aMyIBw0VsxIlTTG9xb1O9v/xa3ynI9F2N
X-Gm-Message-State: AOJu0YwKr089JpEUY4ukYFcZnO6LUA4pLcddW48CUVQa1g7f9XkvlGQz
	tDHHXhT7QxGKmafj14NYRyQ9drk3wSs4cNZGOs62/BCwV3V7QOpg
X-Google-Smtp-Source: AGHT+IF+flS8GFJ9mi5AR9tNKLT0MaP3wKh0v3x6/jsHgZxQ8PGkUx9hZtXHUWXfEc+8V1dBFwxbGg==
X-Received: by 2002:a05:6a20:431e:b0:1be:c559:5e82 with SMTP id adf61e73a8af0-1c0cc8d7de4mr535298637.58.1720069393890;
        Wed, 03 Jul 2024 22:03:13 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1538e49sm112776095ad.145.2024.07.03.22.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 22:03:13 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Wed, 3 Jul 2024 22:03:11 -0700
To: Jakub Sitnicki <jakub@cloudflare.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: test_sockmap, use section names
 understood by libbpf
Message-ID: <ZoYtD0ZS/T9CbYht@kodidev-ubuntu>
References: <20240522080936.2475833-1-jakub@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522080936.2475833-1-jakub@cloudflare.com>

Hi Jakub, Daniel,

On Wed, May 22, 2024 at 10:09:36AM +0200, Jakub Sitnicki wrote:
> libbpf can deduce program type and attach type from the ELF section name.
> We don't need to pass it out-of-band if we switch to libbpf convention [1].
> 
> [1] https://docs.kernel.org/bpf/libbpf/program_types.html
> 
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---
>  .../selftests/bpf/progs/test_sockmap_kern.h   | 17 +++++-----
>  tools/testing/selftests/bpf/test_sockmap.c    | 31 -------------------
>  2 files changed, 9 insertions(+), 39 deletions(-)
> 
[ snip ]

I recently hit some CI errors on kernel-patches/bpf related to veristat
and the test_sockmap BPF object files:

https://github.com/kernel-patches/bpf/actions/runs/9775040227/job/26985293772?pr=7279

I hadn't seen your submission, and after some investigation my own fix
ended up reproducing your patch: <sigh...>

https://github.com/kernel-patches/bpf/pull/7279/commits/9e5bc23d4a3643e6a4733aac431ee425310e03d6

Given it fixes a CI issue for bpf/master, could we backport/apply your
patch there? 

Thanks,
Tony

