Return-Path: <bpf+bounces-56006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFE6A8A83F
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 21:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E06841889920
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 19:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1DA22B8CC;
	Tue, 15 Apr 2025 19:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dVxh9p9a"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FC5250C07
	for <bpf@vger.kernel.org>; Tue, 15 Apr 2025 19:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744745976; cv=none; b=IfjEb96PHLq35IHYE2snq3MV0C+SDJfgeJxPPMLIVv9NCw5wzjuRraGb8cNDzU40o9acomgC/FQvB4ixNX/Zbz/3LV0NAYBDSy2JUwqW+Qcw5aQWbrO+SXO3zjz9UsQ+KDeZxXvHJOEUcDdoojqTC/VyZKQyeTbD28rtW9Efc8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744745976; c=relaxed/simple;
	bh=WlwHRNawR2GhxlctpnfWjf5x8EdXYVWsw0nnmBQUVF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=l2eNO5DDK61WtUaAdIDnJi+nxITJMOjoygqUwRncGBq64vnhwGzhvNARBjISliLxoqtbI68bMgimBW0vrtWlGM60Jql1beVD5Z2YEtx8wm9x9dQe7eoUoQDOtVV+++FDtsysAAiUQ7U9vgS8K+ZyaRQgmiKElfY6WVB2BVDP0Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dVxh9p9a; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b3132934-0f98-4d5e-8aee-d3299fc99504@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744745970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A0MMYrKGs0PlfN5VW+6M5DZAz7nLxa+VT7vPljYutMI=;
	b=dVxh9p9abwqU2Sn/NxR2TzDtnNIHbI6Aj635JdxIGrxBrSOSwJMJbirylhrfPk08LjAzq7
	ux4Rv8UiVRIWIaug9lIwqEmKfk+IeSrWkuMA/W/nHJSnG6uzozpWHZX9q8N+Ko1yhRYHA2
	8v/sDpAqegLX/tXjqg107sxhqaS529o=
Date: Tue, 15 Apr 2025 12:39:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RESEND] bpf: fix possible endless loop in BPF map
 iteration
To: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
References: <Z_aSOFIJkhq5wcye@bkammerd-mobl>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <Z_aSOFIJkhq5wcye@bkammerd-mobl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/9/25 8:28 AM, Brandon Kammerdiener wrote:
> This patch fixes an endless loop condition that can occur in
> bpf_for_each_hash_elem, causing the core to softlock. My understanding is
> that a combination of RCU list deletion and insertion introduces the new
> element after the iteration cursor and that there is a chance that an RCU
> reader may in fact use this new element in iteration. The patch uses a
> _safe variant of the macro which gets the next element to iterate before
> executing the loop body for the current element. The following simple BPF
> program can be used to reproduce the issue:
> 
>      #include "vmlinux.h"
>      #include <bpf/bpf_helpers.h>
>      #include <bpf/bpf_tracing.h>
> 
>      #define N (64)
> 
>      struct {
>          __uint(type,        BPF_MAP_TYPE_HASH);
>          __uint(max_entries, N);
>          __type(key,         __u64);
>          __type(value,       __u64);
>      } map SEC(".maps");
> 
>      static int cb(struct bpf_map *map, __u64 *key, __u64 *value, void *arg) {
>          bpf_map_delete_elem(map, key);
>          bpf_map_update_elem(map, key, value, 0);
>          return 0;
>      }
> 
>      SEC("uprobe//proc/self/exe:test")
>      int BPF_PROG(test) {
>          __u64 i;
> 
>          bpf_for(i, 0, N) {
>              bpf_map_update_elem(&map, &i, &i, 0);
>          }
> 
>          bpf_for_each_map_elem(&map, cb, NULL, 0);
> 
>          return 0;
>      }
> 
>      char LICENSE[] SEC("license") = "GPL";

Please put this reproducer into a bpf selftests.

Take a look at tools/testing/selftests/bpf/prog_tests/for_each.c. Adding a 
subtest under it should do.

