Return-Path: <bpf+bounces-75858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC2BC9A1B5
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 06:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 990A14E24A6
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 05:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689062F5A3D;
	Tue,  2 Dec 2025 05:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HtyFigWA"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E78322759C
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 05:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764654037; cv=none; b=hTSIII0/xxqeX9MbEZQ2qKQr05jShFumCX5w+MLHhStwsHwBqAwl3UhyUAZFhSs+UT4LjLF0QNlym9jtWStgaKiEGxHfSfokZmbMuqZGl88nMha3iZ2ppdoWZ2OPb/UbgD2DqKMFmExSYpbn/l7YqSK5zdVKSvHEB8PmEDC8Fmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764654037; c=relaxed/simple;
	bh=x1AyNqwF0Scmm4HD5gKrKnK4oH1e8ARnl5xl1S+rxL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NQJzlNQub41AdZyIRMwe9lScgqXUBK2HlkePxONivEXAlYBzgxwMGGEHQQnIJU5b+Lfx9Z02u+caTfiS4IVmPElkG2ogYWKbxstAZPL/LKpdN8iwQi2Kk6csH2yXhppxh+6FwHRrvwzZTrv5DyGjh2Ze1naZJRuSdv4wDR/1GRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HtyFigWA; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <569b74e5-1430-4fe3-b63d-996bb95ebc75@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764654024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F1woJTFzkZ70N/WazvT3+n48ONB7THtc6jrI96bOFmg=;
	b=HtyFigWAEJOWabmTrSQtbVZy0lDY4sBwBhf3G+y292RylfBjK6j7kCRfMPvt+EhwZCUnvj
	s/YqZ/xiJlHokCGBWXlEX2yCd1a/DapYCmeyFq8l34IF0UuIhIfSv1w6wqJgo+HmC0atvH
	ADrarKRhMUwynkgGdiynNiAEcLr16Fc=
Date: Mon, 1 Dec 2025 21:40:19 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 2/6] bpf: Support associating BPF program with
 struct_ops
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 tj@kernel.org, martin.lau@kernel.org, kernel-team@meta.com
References: <20251121231352.4032020-1-ameryhung@gmail.com>
 <20251121231352.4032020-3-ameryhung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20251121231352.4032020-3-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/21/25 3:13 PM, Amery Hung wrote:
> Add a new BPF command BPF_PROG_ASSOC_STRUCT_OPS to allow associating
> a BPF program with a struct_ops map. This command takes a file
> descriptor of a struct_ops map and a BPF program and set
> prog->aux->st_ops_assoc to the kdata of the struct_ops map.
> 
> The command does not accept a struct_ops program nor a non-struct_ops
> map. Programs of a struct_ops map is automatically associated with the
> map during map update. If a program is shared between two struct_ops
> maps, prog->aux->st_ops_assoc will be poisoned to indicate that the
> associated struct_ops is ambiguous. The pointer, once poisoned, cannot
> be reset since we have lost track of associated struct_ops. For other
> program types, the associated struct_ops map, once set, cannot be
> changed later. This restriction may be lifted in the future if there is
> a use case.
> 
> A kernel helper bpf_prog_get_assoc_struct_ops() can be used to retrieve
> the associated struct_ops pointer. The returned pointer, if not NULL, is
> guaranteed to be valid and point to a fully updated struct_ops struct.
> For struct_ops program reused in multiple struct_ops map, the return
> will be NULL.
> 
> prog->aux->st_ops_assoc is protected by bumping the refcount for
> non-struct_ops programs and RCU for struct_ops programs. Since it would
> be inefficient to track programs associated with a struct_ops map, every
> non-struct_ops program will bump the refcount of the map to make sure
> st_ops_assoc stays valid. For a struct_ops program, it is protected by
> RCU as map_free will wait for an RCU grace period before disassociating
> the program with the map. The helper must be called in BPF program
> context or RCU read-side critical section.
> 
> struct_ops implementers should note that the struct_ops returned may not
> be initialized nor attached yet. The struct_ops implementer will be
> responsible for tracking and checking the state of the associated
> struct_ops map if the use case expects an initialized or attached
> struct_ops.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>


