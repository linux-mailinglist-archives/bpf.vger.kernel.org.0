Return-Path: <bpf+bounces-52461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B396A43091
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 00:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25396178821
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 23:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEA920B7F3;
	Mon, 24 Feb 2025 23:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QixCApuo"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF6820B213
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 23:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740438908; cv=none; b=YZQxcnTJzhZpmBhBQ+zbaK/KPY7qdv0Kt1tBKRhxhfNfRKfRqSSMOJknkMKPlOWDgJQYMLkG6PTwD8Z6jiohs9ENN5m7S7mOBaG7RF9S9TLqmnDThASMVVREzrVy8anQbOeK5+tiM0QrfH5gylQD6X4BYepgqTDs/FqBzVu4CmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740438908; c=relaxed/simple;
	bh=x1SohZBA+4utECR8aa2vgoCApeguo23p7+Wi0Yt5ROE=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=RKz90PSH7j1hlGwoJMAicfKVzLNSXAr3CVML9790KyQqKY7o3oyYpH7ZJH0KKCdOYHLLz+v/Gv0ju8jQ81ryo1fJg32jpXQUWjb2K6LHA4x8E9M5eeWmPPVFH1kGzeE+bxtt7ProsdvvOmG97ouzpjUZTRG5zXigYtiHXYuraOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QixCApuo; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740438901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ur1HpkVpU2PbjBk8KdzsZMEtl9vGUFPr2rUB19yy690=;
	b=QixCApuo85leYl21MoBbEgxp82WV2K3JbV6MSz21AHdABFKMoVcWznfn6OsrH4ga+oSJx+
	D3eQ3Gt008Gnlc0si0sTn1xEwRoAJCetv1a31o/MLXT4oeJN6yl3HnVjcdE+FCA4gHplr5
	Pv3sJFE1MRylE3izbVJitLQ1FD5MJ6w=
Date: Mon, 24 Feb 2025 23:14:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <6b35b7490955800b5cc3833508c88914d59d0d85@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next 1/2] libbpf: implement bpf_usdt_arg_size BPF
 function
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com,
 kernel-team@meta.com
In-Reply-To: <CAEf4Bzb4T3DcySAyyCXWBK-ShyW9iuE-OM9f7EHXmBJg5Qm0eg@mail.gmail.com>
References: <20250220215904.3362709-1-ihor.solodrai@linux.dev>
 <CAEf4Bzb4T3DcySAyyCXWBK-ShyW9iuE-OM9f7EHXmBJg5Qm0eg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On 2/24/25 2:05 PM, Andrii Nakryiko wrote:

> [...]
>
> arg_bitshift is stored as char (which could be signed), so that's why
> you were getting signed division, just cast to unsigned and keep
> division:
>
> return (64 - (unsigned)arg_spec->arg_bitshift) / 8;

As it turns out, this doesn't work either. Presumably because
(64 - (u8)x) is still a signed int.

This works, however:

    return (unsigned char)(64 - arg_spec->arg_bitshift) / 8;

>
>> [...]

