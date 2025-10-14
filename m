Return-Path: <bpf+bounces-70955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D20BDBD8E
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 01:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DB5A19A39DE
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 23:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32372EDD76;
	Tue, 14 Oct 2025 23:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrlP+Eu6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5178427E056;
	Tue, 14 Oct 2025 23:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760486205; cv=none; b=pzoCyZoBVfJ0in36SskNMgEuf/6FVoYtGhpYjSOWmdZwS2mBgiNtemO2zr0OMTOogw9fpP5BiRjgfWT2j6LISKUGatZ0SM9i34XCpn8iu0Wb3YGFc4TEXD+Lu8poUI4iaZ66OGqDJvRWDhlmApcLEp47D/4Afhdjzjj8aEmWRUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760486205; c=relaxed/simple;
	bh=VRx2aw2zM7OKLvT1+4Nmf2vysG0y9faUtuRX2ydOGQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxYxE05xHETNYoO22Nacdm3RUAboqv+b5L5zK4181WMO0iRNwe5TJulYAF3JHI5Z4FMQlpIgWZOinqci8AItjKpjuWMk/91V0miUi6gYsNIiuGJdMM/QgL4VNdmIA64US3q4Iye1AvsXsV3ecOrYmWMy4/lcmibue1awXo7jPg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrlP+Eu6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC586C4CEE7;
	Tue, 14 Oct 2025 23:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760486204;
	bh=VRx2aw2zM7OKLvT1+4Nmf2vysG0y9faUtuRX2ydOGQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nrlP+Eu6w6mc0re5WVocRicbDQXvJOb6dAF0bdsKuF/UHDK/pNRDJJPF4ZoiS83Oh
	 zvoUldv916VMPzyUePhCrE4e2rWjTv6mYjtScGAbB1d3wtsTAdzQxdZcH/I/EyI7Hl
	 evj8MI63ZzeFh3ZFTtAvMIEdu0TPMV1yeTWprOhsrxbgr1zsm9N9X4lSFzpK8tQA0M
	 Vt/s7tG5q/Smn/RGdJfx3GX+OT5MK+KDqwloGqKSWaTbGxHzw6G6ScGu1qHOjdL+eU
	 EaxQS0sRhphQBaz9JByk9JR0S20SgBxymSHWpamb6AkNnSlOfVJehWBn/0lnqMnoJA
	 f9E2Uz/WqhTMg==
Date: Tue, 14 Oct 2025 16:56:44 -0700
From: Kees Cook <kees@kernel.org>
To: bot+bpf-ci@kernel.org
Cc: kernel-ci@meta.com, andrii@kernel.org, daniel@iogearbox.net,
	martin.lau@linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 00/10] net: Introduce struct sockaddr_unspec
Message-ID: <202510141649.D0DDA6A57@keescook>
References: <20251014223349.it.173-kees@kernel.org>
 <2095031a79fdd5a7765b9e7a0a052fb2b48895c8794a170e567273d2614da9fd@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2095031a79fdd5a7765b9e7a0a052fb2b48895c8794a170e567273d2614da9fd@mail.kernel.org>

On Tue, Oct 14, 2025 at 11:06:58PM +0000, bot+bpf-ci@kernel.org wrote:
> Dear patch submitter,
> 
> CI has tested the following submission:
> Status:     FAILURE
> Name:       [v2,00/10] net: Introduce struct sockaddr_unspec
> Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=1011557&state=*
> Matrix:     https://github.com/kernel-patches/bpf/actions/runs/18512305054

Hrm, there's something in here that wasn't caught with my "allmodconfig"
tests. I'll take a closer look...

Ah, yes. I missed these:

tools/testing/selftests/bpf/prog_tests/sock_addr.c:static int kernel_bind(int fd, struct sockaddr *addr, socklen_t addrlen)
tools/testing/selftests/bpf/prog_tests/sock_addr.c:     if (kernel_bind(0, (struct sockaddr *)&addr, addrlen) < 0)
tools/testing/selftests/bpf/test_kmods/bpf_testmod.c:   err = kernel_bind(sock, (struct sockaddr *)&args->addr, args->addrlen);
etc...

I will get those fixed.

-- 
Kees Cook

