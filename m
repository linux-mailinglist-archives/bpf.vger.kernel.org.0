Return-Path: <bpf+bounces-19689-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2BC82FD34
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 23:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C68C294A90
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 22:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2196A1DA41;
	Tue, 16 Jan 2024 22:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ifCR5QY1"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4329C20327
	for <bpf@vger.kernel.org>; Tue, 16 Jan 2024 22:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705444491; cv=none; b=o8DSSVbq24nh8mmK/6yrJq+TiF8uOoyF5OEft1WR66WnXB+m0BkvfZIevnA2EPuELFsiBEz2f2p2OJ/kDyPalp9l2MIdqvk0yNO7y3PUdLMBqFxnyZh22XDM53Vxl2m2z93OQv+w0uNauGoNl/Rje25CgaRqtoNWzv2Q+As2Jl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705444491; c=relaxed/simple;
	bh=jBsJkIQDH/oFzw+YE2QgJiPh2Dsgdk/G/1RyuPccdnA=;
	h=Message-ID:DKIM-Signature:Date:MIME-Version:Subject:
	 Content-Language:To:References:X-Report-Abuse:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Migadu-Flow; b=ZXUjuqtpZzXgigSmQEhrabqGJ8MdNK8YaIT8bRurmVrflt6CJf2OLsb8uAncAC7k5s6fQy8UzjsXDhp5C1uyMX2kjM9ZYsdDQrP0v7omc/fSrdSkeg2G1BUqxOETF46Ew2UFhS6NT/0CmxQFR1/mWQGubdvwufgCBFfmDCa1Ios=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ifCR5QY1; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <829aa552-b04e-4f08-9874-b3f929741852@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705444487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tD7mYbb36coY16gdm3pTDas+pwkT1RfWonfbtkgowcE=;
	b=ifCR5QY1nc65IDFVJ+MtyctFO5P+rpD/2lOGmvMiX+aXzWurlAsZm4zoADOmQ8C9mfT/uv
	2b7YLjt4N9MVosj6F+QW8QwzrJtLmMJhYitioFnYwU4v0U58XpiZdptuPI9A/54p+gG2ZZ
	ygtmHM6fM1Pc5Ry32ohxkxKeyniZY70=
Date: Tue, 16 Jan 2024 14:34:41 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Sign extension ISA question
Content-Language: en-GB
To: dthaler1968@googlemail.com, bpf@ietf.org, bpf@vger.kernel.org
References: <085f01da48bb$fe0c3cb0$fa24b610$@gmail.com>
 <08ab01da48be$603541a0$209fc4e0$@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <08ab01da48be$603541a0$209fc4e0$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/16/24 12:55 PM, dthaler1968@googlemail.com wrote:
> (Resending since a spam filter seems to have blocked the first attempt.)
>
> Is there any semantic difference between the following two instructions?
>
> {.opcode = BPF_ALU64 | BPF_MOV | BPF_K, .offset = 0, .imm = -1}

This is supported. Sign extension of -1 will be put into ALU64 reg.

>
> {.opcode = BPF_ALU64 | BPF_MOVSX | BPF_K, .offset = 32, .imm = -1}

This is not supported. BPF_MOVSX only supports register extension.
We should make it clear in the doc.

>
>  From my reading both of them treat imm as a signed 32-bit number and
> sign-extend it to 64 bits.
>
> Dave
>
>

