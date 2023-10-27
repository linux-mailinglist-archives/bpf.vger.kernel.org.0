Return-Path: <bpf+bounces-13415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D39E7D94BD
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 12:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DCFAB2106A
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 10:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629481775B;
	Fri, 27 Oct 2023 10:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="ECsiud9L"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49C517995
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 10:08:26 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046E0191;
	Fri, 27 Oct 2023 03:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1698401301;
	bh=jtuCWNKuE/h7zD2BeBm3DoEXh/mgySFqwyRN11JrCB0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ECsiud9L4hpYSVBuhqqg+PWooHWULZGIoQRUwr5//eEDwnO6Pncwp3gV8iHlXu99w
	 mpchcTlkkrMeiX+UXhquvTZKzHiW7QVJxkfjjebQ28rP464hoyEKw0BltCSj8elq6m
	 6RhJvnOFv7CE3hBqwsfL+tLMCQ3FDh6NKCwgStvh/mYXizaaFlq60b+x9iLVCiImsb
	 17YbMcNbby9awVq4fk6+cnfErbuZTiMamUzuOkNkbqDoq+MHSNxctHjGWTTqgLh6ij
	 aDLNJVZnrtP3MJIKPhZ8u0Dj38PQPuq0Du7TS2mVYn3HW8Qqgtt06Jn/HbHjVoDSTE
	 0XEcrTS/I8QBA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SGyzS6kLTz4xWn;
	Fri, 27 Oct 2023 21:08:20 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: martin.lau@linux.dev, yonghong.song@linux.dev, john.fastabend@gmail.com, Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Cc: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231013053118.11221-1-m.muzzammilashraf@gmail.com>
References: <20231013053118.11221-1-m.muzzammilashraf@gmail.com>
Subject: Re: [PATCH] arch: powerpc: net: bpf_jit_comp32.c: Fixed 'instead' typo
Message-Id: <169840079668.2701453.302685477788337592.b4-ty@ellerman.id.au>
Date: Fri, 27 Oct 2023 20:59:56 +1100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, 13 Oct 2023 10:31:18 +0500, Muhammad Muzammil wrote:
> Fixed 'instead' typo
> 
> 

Applied to powerpc/next.

[1/1] arch: powerpc: net: bpf_jit_comp32.c: Fixed 'instead' typo
      https://git.kernel.org/powerpc/c/4b47b0fa4b15e0de916e7dd93cd787fdab208ff2

cheers

