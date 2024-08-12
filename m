Return-Path: <bpf+bounces-36935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 232FD94F76D
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 21:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9CF7281571
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 19:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE92218F2CB;
	Mon, 12 Aug 2024 19:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CG+QSHwq"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27494189B8E
	for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 19:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723490401; cv=none; b=k9pYIh8tsV1FcCvCuh5HadfqlgECtoz/ACG9Q+hCvVuEkOB2AKgBWakfqyGDC/1fRvVivD6FEsqPFBKr15iayv844Hfe0TF2wQmBklgFV8O91a9VBTUD7Ay0c+hOtzWWAcH1tatVbs5Ml/u9sckpVe7K4MzYFS5ss4KioDaWJUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723490401; c=relaxed/simple;
	bh=QRG8VHfUw2AYXYQRVYzRtjbOadLynI/9YCB0mhfwaD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WdW5BE/w42SkbZkwI/JC2a/ZX7O+NXut07pRxrqK1pC1LrRKmezV5riV5gp+c7eSnAUVi2ksLR2puBICIsYOcD67b5HgaLAoQLbncntPLTFjy3UvEA7eh+X0Mzx2GHrfnegP+z9psS25aEcRrP9R1IMVQE8BGRD5711btlN6OVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CG+QSHwq; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ea579882-d0ca-4117-afab-18815bfe9c94@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723490397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QRG8VHfUw2AYXYQRVYzRtjbOadLynI/9YCB0mhfwaD4=;
	b=CG+QSHwq86Fx+TJB2IHg6P1Mh4lTYQwHJfJxn8h1Z94oaDXlNsNItnsZUOX+Y7kCYVTWO+
	jl5uleu2sqmXOJoXFeHg0EkjMxmJuU4+xOR7sf7ut9x7mQhkHOHeIfOIub81gqVNl4yZa1
	0W+GnBq208H+8Lah+Dbq+epUC8UlUlU=
Date: Mon, 12 Aug 2024 12:19:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] libbpf: fix license for btf_relocate.c
Content-Language: en-GB
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 bpf@vger.kernel.org, Neill Kapron <nkapron@google.com>
References: <20240810093504.2111134-1-alan.maguire@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240810093504.2111134-1-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/10/24 2:35 AM, Alan Maguire wrote:
> License should be
>
> // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
>
> ...as with other libbpf files.
>
> Fixes: 19e00c897d50 ("libbpf: Split BTF relocation")
> Reported-by: Neill Kapron <nkapron@google.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


