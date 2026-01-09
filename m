Return-Path: <bpf+bounces-78341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 45ADFD0B3AC
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 17:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F05A1300A3F0
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 16:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECF03563CB;
	Fri,  9 Jan 2026 16:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xl5CB3H6"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FC7311949
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 16:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767976095; cv=none; b=r3KdMKPvPU15amhuY6+EoHrPJ0b4UiBTwzoqVC4VPHXGdarigMLZaXfZqHZ8+9Ctr3+P1FIo1TxKJ4LZgOg+DXadV1w0xiv8yUB7AlTt06xknIjQbArlBmyY2nyb0fU8dKC2ugI2LERJMnQDIdM6iZbtZR9Xttqm+n+HR9nykLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767976095; c=relaxed/simple;
	bh=c5S1G2zIov/Ly/wkIIZ2n009TVdfihrMaoI5ie9mbYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PetvwViUz+cpZP2su1T6D+rI4cgc/Cf/0xU9pJle8oA23UDHzzv1LCg8uFg7UZu+fNCaCDKc1MzvrWDC2jBiKAWhk0kep/ryF2r36ZrBleCAXvA4ezdT2qRdfroFsLUO8t56BuXBkb+z0/Ege2N9xO3xb5calqV2sUVVzB65XOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xl5CB3H6; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5eccbe20-7439-4c2d-a60d-bc0c11995207@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767976091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b87z8LEQCb8p8YWfoMgp7Zig4K98yYge2osDyP+9PZ0=;
	b=Xl5CB3H6c8crJA6OThrB2Lqxc+JeoDPCCNn0QwotO7JsbOBmewqS0smhHwpJ/audmHN458
	7F63wZnjSmN/aNfuguTlCAicgYesZD8bbAJsiCHA4SMeFXUH5PfSWPFS9b/MZcXEb/ICHD
	UnPMECNIabZYyFefGC4rZORxwU1X/aU=
Date: Fri, 9 Jan 2026 08:28:04 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] libbpf: BTF dedup should ignore modifiers in type
 equivalence checks
Content-Language: en-GB
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org
Cc: ast@kernel.org, jolsa@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, nilay@linux.ibm.com, bvanassche@acm.org,
 bpf@vger.kernel.org
References: <20260109101325.47721-1-alan.maguire@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260109101325.47721-1-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 1/9/26 2:13 AM, Alan Maguire wrote:
> We see identical type problems in [1] as a result of an occasionally
> applied volatile modifier to kernel data structures. Such things can
> result from different header include patterns, explicit Makefile
> rules etc.  As a result consider types with modifiers const, volatile
> and restrict as equivalent for dedup equivalence testing purposes.
>
> Type tag is excluded from modifier equivalence as it would be possible
> we would end up with the type without the type tag annotations in the
> final BTF, which could potentially lead to information loss.
>
> [1] https://lore.kernel.org/bpf/42a1b4b0-83d0-4dda-b1df-15a1b7c7638d@linux.ibm.com/
>
> Reported-by: Nilay Shroff <nilay@linux.ibm.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Tested with llvm22 and gcc15 for config including CONFIG_DEBUG_INFO_BTF
and CONFIG_KCSAN. Both work properly.

Tested-by: Yonghong Song <yonghong.song@linux.dev>


