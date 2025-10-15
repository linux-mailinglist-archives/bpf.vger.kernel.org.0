Return-Path: <bpf+bounces-71014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9C9BDF681
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 17:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73F5D1A61CBC
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 15:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A5D303CBB;
	Wed, 15 Oct 2025 15:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ggR2uwoB"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C64C304BDD
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760542363; cv=none; b=cjq0aqd41yUGKLB4q6yt4lsjCfR1AWWK8P5fk6jZnKjclXMc7SbOdjg8sLxgbRXJXwm4zNY5Q5mjnkElfNadN6RjhcV1G3CdqE3X6+Z/bWEUYvOsRiWjc3U/2ymJFY7DCkthf9/A2jT/RIyOxWbjJvCKiPK0Lu2YjwRCzbCbU+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760542363; c=relaxed/simple;
	bh=/ZjHxso9M04afjNHZcYfVpG71gB8O+fLlELffXcXTjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ufXEVmb+zs/A5tLx9lSDaK94k7lMYGMr8jIGDh/qSmZ9gHFdeD7UhXg8D43PGspoqcx3KLHCtS540Lp7Hp+XednMPrElh7aM1MBIfZA3jbV9qjrACByNMu314ItN7xovXd4mKwnovSvHGxHHlDjRdNjy71EW92zykm53oWOJw+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ggR2uwoB; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4a536cda-0ba5-437f-82ae-60468a75a62c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760542359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7co2+GVkunDlGbA/lLYZB50l9c9o08xR3WHNq6fJk1w=;
	b=ggR2uwoB7sqMWPSonQlcS60VeStSN53twip0URACczYQ4A7yuLYH5hwqcx7T9WoL9HD+Kl
	o3t13XKL04rRr5gmsKX7HOfjrrpQO1SJSTf86djq925stiCzElqABSp9Run6jVAkbRvSyk
	Xa8xrJz+t171QsqMWTE9jVzB9GQrvwM=
Date: Wed, 15 Oct 2025 08:32:32 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 bpf-next 13/15] libbpf: support llvm-generated indirect
 jumps
Content-Language: en-GB
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Anton Protopopov <aspsk@isovalent.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Quentin Monnet <qmo@kernel.org>
References: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
 <20250930125111.1269861-14-a.s.protopopov@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250930125111.1269861-14-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 9/30/25 5:51 AM, Anton Protopopov wrote:
> For v5 instruction set LLVM is allowed to generate indirect jumps for

FYI. The llvm jump table support is still cpu v4.

> switch statements and for 'goto *rX' assembly. Every such a jump will
> be accompanied by necessary metadata, e.g. (`llvm-objdump -Sr ...`):
>
>         0:       r2 = 0x0 ll
>                  0000000000000030:  R_BPF_64_64  BPF.JT.0.0
>
> Here BPF.JT.1.0 is a symbol residing in the .jumptables section:
>
>      Symbol table:
>         4: 0000000000000000   240 OBJECT  GLOBAL DEFAULT     4 BPF.JT.0.0
>
> The -bpf-min-jump-table-entries llvm option may be used to control the
> minimal size of a switch which will be converted to an indirect jumps.
>
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>

[...]


