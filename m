Return-Path: <bpf+bounces-35949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4875594001E
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 23:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8AFA282CC6
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 21:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F69818D4D6;
	Mon, 29 Jul 2024 21:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tkQTxLF1"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF4B18A950
	for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 21:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722287236; cv=none; b=uTIxF7BN3SrOl87/PWhj74Yl82xfOnjBrXJNlLcbmTwP1ctkBIdG9AN0wbpSRiiZRZjvCRcsVJ/2y4MWHpESIs0RCEzkknl1tR53UOIJlsos8PAewy/g3lWJYduJqbjqzsYxvN1vzZ6z6lX2qUYCX0z1N3jLv3UIInkls3m7Ips=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722287236; c=relaxed/simple;
	bh=wvTMchW6lUdOtWq5+x+dsWApaJw7J/nBPlzlQOCcq9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZKbhY7DFC6mMYuWp+2xIzAMS0BHOTKEKtwEMZetg7Q0AWWRxSqyuZiIs9pbUGqTHlnG0PS4F1abo5H7qw5CJn9TxUfOfu8P1Q72WNWb3k7KWw+J4D1kiAdoiav0bimNcAkrx/LI5ocYC2KbQ1/VaDXEc7M/YylLw2HCDL1NqvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tkQTxLF1; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d08f9080-3818-4869-8b5f-9292d772963f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722287231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IxQ4lKmozir9SxJDsazhdqBOQOklsv/q34GP+Mn+O0Y=;
	b=tkQTxLF1NNfd/87JbgyIl6qL1rKHEQIKTO0p3Mmgw44Wo9rHui16Gz74MgZswxDXVKq6tQ
	+DeMoFjIe2SVOucHfp9+ugQe6gss79hzzo8dusRcZn3+MSKJ6fppO5HwSacKaeCRbYXEtV
	WpmItXnH4pwsA2r/+CGij8C40ozVrQU=
Date: Mon, 29 Jul 2024 14:07:04 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH V2 bpf-next] bpf: export btf_find_by_name_kind and
 bpf_base_func_proto
To: Ming Lei <ming.lei@redhat.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org, andrii@kernel.org,
 drosen@google.com, kuifeng@meta.com, sinquersw@gmail.com,
 thinker.li@gmail.com, Yonghong Song <yonghong.song@linux.dev>,
 Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>
References: <20240726125958.2853508-1-ming.lei@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240726125958.2853508-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/26/24 5:59 AM, Ming Lei wrote:
> Almost all existed struct_ops users(hid, sched_ext, ...) need the two APIs.
> 
> In-tree hid-bpf code(drivers/hid/bpf/hid_bpf_struct_ops.c) can't be built
> as module because the two APIs aren't exported.

The patch looks fine. I don't see "config HID_BPF" can be built as a module now 
though that could expose this issue. Did I miss something?

> 
> Export btf_find_by_name_kind and bpf_base_func_proto, so that any kernel
> module can use them given bpf community is supporting to register
> struct_ops in module, see the patchset "Registrating struct_ops types from
> modules"[1], which is merged to v6.9.


