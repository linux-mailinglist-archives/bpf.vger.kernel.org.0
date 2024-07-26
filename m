Return-Path: <bpf+bounces-35755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1470C93D8FA
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 21:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BC35B2280D
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 19:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBF313A40B;
	Fri, 26 Jul 2024 19:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sFlb2Hi1"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C735524C4
	for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 19:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022015; cv=none; b=H6RqT+iPU4/xqC0KQONK5xfQ8ITeUX6OPYluczCKIDsv75CAM/e5MSKRgK+QaNGL8J9QEgvXGEJFAMf/HxrM/ej/6Cz1pKlFUjXGFpvykXowx1ajnqrg8oLNAGoH/v1UmeGhe3qLojyNQCWYq1N0c81yNbO6B/j3O+7UZyQtA/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022015; c=relaxed/simple;
	bh=95AybEX7j/yfSHbNOF1h/HjAng9kE53/wZtf8ql61ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QmQgSNCxByTaJuFXbpEUAWopyhVJKDJS3NmRtIhpyMvdo6AoecStvVPEOkmty1dS/lKqUtIGuFLuOPpVnq8KZHEEQXxaWWx0YaCb6zprYPeKORCX0hg8pY64tqLWwG4smbxJ0r9C1ImMwluTAovyrsnPA+cCyznh7AXLF6FyD24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sFlb2Hi1; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <50c15a40-3307-4039-b3d8-7b35ea28314f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722022010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X+tm+H3/yAr08ZzUeipd5HPOSnaTx1LNRLYNxzXpJfo=;
	b=sFlb2Hi11m+GQFSf+EUhlaOSTVey94MfZaZxgcZXPlON5zdeI+/YoYe2hIFXKAmvNGGvk/
	mbeIlOxDMOnS2hLSrg/Bq6lxSKyUb+GTKC/5iec2kphDKyMZ6P7H49UbItoybAcHc2xawL
	iMjKH4UGj9vww9ojBYIBYkLSfzMG+gU=
Date: Fri, 26 Jul 2024 12:26:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Fix updating attached freplace prog
 to prog_array map
Content-Language: en-GB
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, toke@redhat.com,
 martin.lau@kernel.org, eddyz87@gmail.com, wutengda@huaweicloud.com,
 kernel-patches-bot@fb.com
References: <20240726153952.76914-1-leon.hwang@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240726153952.76914-1-leon.hwang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 7/26/24 8:39 AM, Leon Hwang wrote:
> The commit f7866c3587337731 ("bpf: Fix null pointer dereference in
> resolve_prog_type() for BPF_PROG_TYPE_EXT") fixed a NULL pointer

Typically 12 alphanums are used for a commit. So please use
   f7866c358733 ("bpf: Fix null pointer dereference in resolve_prog_type() for BPF_PROG_TYPE_EXT")
Please have the commit subject ("bpf: Fix ...") in the same line for easy search purpose.

> dereference panic, but didn't fix the issue that fails to update attached
> freplace prog to prog_array map.
>
> This patch fixes the issue.
>
> v1 -> v2:
>   * Address comments from Yonghong:
>     * Check then return prog->aux->saved_dst_prog_type.
>     * Remove ASSERT_GE() that checks prog_fd and map_fd.
>     * Remove #include "bpf_legacy.h".
>     * Fix some code style issues.
>
> RFC PATCH -> v1:
>   * Respin the PATCH with updated message.
>
> Links:
> [0] https://lore.kernel.org/bpf/20240602122421.50892-1-hffilwlqm@gmail.com/
>
> Leon Hwang (2):
>    bpf: Fix updating attached freplace prog to prog_array map
>    selftests/bpf: Add testcase for updating attached freplace prog to
>      prog_array map
>
>   include/linux/bpf_verifier.h                  |  4 +-
>   .../selftests/bpf/prog_tests/tailcalls.c      | 65 ++++++++++++++++++-
>   .../selftests/bpf/progs/tailcall_freplace.c   | 25 +++++++
>   .../testing/selftests/bpf/progs/tc_bpf2bpf.c  | 21 ++++++
>   4 files changed, 112 insertions(+), 3 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/progs/tailcall_freplace.c
>   create mode 100644 tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
>

