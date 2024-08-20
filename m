Return-Path: <bpf+bounces-37649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA978958EB8
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 21:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D78BC1C21C07
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 19:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B0015855B;
	Tue, 20 Aug 2024 19:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hmwbq4ql"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2B918E344
	for <bpf@vger.kernel.org>; Tue, 20 Aug 2024 19:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724182991; cv=none; b=O6NJNeG5UvC52FvSbkSUS6UbRsMWvLkzV0Rt+3bIOMAz/EYfpO15kkcN4R8AHREEJv5WcrncOdb/DOtka3jGxOhW6B5RXc4yzcJjdCZgPmbb0jPn3+ZpyZfvgL/l/zUPWc1vOt7K4+a4mvycmxNYxsRA+pfi7hBdjkf9VlBGwKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724182991; c=relaxed/simple;
	bh=O5aPst4VcK7pgUDR4sGPOrOglNwBfG0XHnTf01VtDls=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tPcg+D72Z2NWkW5m++Pz9EvUjQh6/6tDtOmk9z+mSqO97wXrhj+aYJA0V+myapAajNiNjTK4H2trj7hSYGMRyY855zNGY4xLl8LZ2e6cAzppnZG0rSf/jfBts+4z/DE1bNaemLAWSc/oq59zmffB+wqpva9nH1GqQb7r/P1ZvIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hmwbq4ql; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6c07765b-952f-4132-aa99-b31010eea598@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724182980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O5aPst4VcK7pgUDR4sGPOrOglNwBfG0XHnTf01VtDls=;
	b=Hmwbq4ql8DxWJXNOgGTLo8kGFPVpio7f8eBMRTas32ubpHYiwcFC2P02ao6oQr/qi6+9up
	ndKNsKuH1NwNBEQFJH86x0qNK7xp2wZfx6i0OoIAVXSkUNJjkgag42vD2hlZHeXzFcRzqk
	XYk7SqNyKC9IQCytZ7DpOM4GSvvf1as=
Date: Tue, 20 Aug 2024 12:42:53 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] Correct recent GCC incompatible changes.
Content-Language: en-GB
To: Cupertino Miranda <cupertino.miranda@oracle.com>, bpf@vger.kernel.org
References: <20240819151129.1366484-1-cupertino.miranda@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240819151129.1366484-1-cupertino.miranda@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/19/24 8:11 AM, Cupertino Miranda wrote:
> Hi everyone,
>
> Apologies for the previous patches which did not include a cover letter.
> My wish was to send 3 indepepdent patches but after the initial mistake lets keep
> this as a series although they are all independent from themselves.
>
> The changes in this patch series is related to recovering GCC support to
> build the selftests.
> A few tests and a makefile change have broken the support for GCC in the
> last few months.

Cupertino, it would be great if we can speed up to add CI test with gcc-bpf, even
just for compilation only.


