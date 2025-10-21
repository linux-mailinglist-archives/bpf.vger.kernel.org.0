Return-Path: <bpf+bounces-71607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 063DFBF7EE7
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 19:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AD713BCB94
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 17:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E6932E6B4;
	Tue, 21 Oct 2025 17:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="UZme/AUR"
X-Original-To: bpf@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8E134B672
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 17:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761068391; cv=none; b=GZpW3miemFwjlJpFZfgkSXGZxrPUVOpBeMislhOenk8UgOmo1w6ZhQawTLHTssYiYv8RhwZAuTmCFvuTDvd8w6OvrNRyXTDynryXnHQDjdGJR+Bt3bHfWmkzn83+TIP5IsagP9C8oOkZ9XDIIUW21lzOqlDnCgT5O5fQ+H6t938=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761068391; c=relaxed/simple;
	bh=aDZFA/XJVv1lEwaX7z09NSQIhGALV+zbSDqdbk5QFJI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=m05TK++b0K503AbW6U9LEu+zWm5W9/+80L0omyFL4CyB1tsDXXaxqFdjRxNKE+su99WUfMkO6KXSaUSLgcEMeQQH/wklGkaQ9bOVqBsXPIvktpS3SJAhO/LdkC8nsjkuxomxv/gJ7S7oXIHfRfCCfccVRCiJDC+wjf0uuiuzs0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=UZme/AUR; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1761068389;
	bh=aDZFA/XJVv1lEwaX7z09NSQIhGALV+zbSDqdbk5QFJI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=UZme/AURG2pN7pSL1oqj8EraHAbXUV5AcfMPcFnLkFzteSogBvYKTHcVSBJA2GlW+
	 OalcSgo1zPnagzTGzuYbbpfZsTuNvfQEpbp3MzxBLPiidga4g2cwoYh9jn2yyIqifX
	 lb0vwEoITqXq25Fqp/RH9+AOHILE3VLRcN+XwOG0=
Received: by gentwo.org (Postfix, from userid 1003)
	id 713CD4028E; Tue, 21 Oct 2025 10:39:49 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 7042D4015D;
	Tue, 21 Oct 2025 10:39:49 -0700 (PDT)
Date: Tue, 21 Oct 2025 10:39:49 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
cc: bpf@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com, 
    will@kernel.org, peterz@infradead.org, akpm@linux-foundation.org, 
    mark.rutland@arm.com, harisokn@amazon.com, ast@kernel.org, 
    rafael@kernel.org, daniel.lezcano@linaro.org, memxor@gmail.com, 
    zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com, 
    joao.m.martins@oracle.com, boris.ostrovsky@oracle.com, 
    konrad.wilk@oracle.com
Subject: Re: [PATCH v7 5/7] atomic: Add atomic_cond_read_*_timeout()
In-Reply-To: <20251017061606.455701-6-ankur.a.arora@oracle.com>
Message-ID: <231a44a0-5d42-2449-f31c-417b151cc774@gentwo.org>
References: <20251017061606.455701-1-ankur.a.arora@oracle.com> <20251017061606.455701-6-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


Reviewed-by: Christoph Lameter (Ampere) <cl@gentwo.org>



