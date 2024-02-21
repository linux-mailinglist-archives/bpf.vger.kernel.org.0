Return-Path: <bpf+bounces-22435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D499785E382
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 17:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 126D31C21540
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 16:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7277182D6B;
	Wed, 21 Feb 2024 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ni/GQJhO"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E777FBD2
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 16:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708533628; cv=none; b=QGjLHoAkQXdq3Zz55lNZwc64W/GAQPgmzDnT0gN8XzS/yHZzbw0G1VEXVR3xwj8guE/STa8+n51/xDVWO+y0PwKJymJW+4ZwFgZWQnXtmirhCJ6b7I9L8Yo+lNHih2e0tsX4F+uAJvVJzq3jcJkerISMM6Q3Gqho3HVZe3cQYD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708533628; c=relaxed/simple;
	bh=B0QVccvhP5DSJ7jRYCUOThk+g1DbqlNo23fvmmawcsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=in1wMifdE47mkKwxshQUiR3HTEolgJWEygnhdiew4ZNIe44aMNqlNLEk/Rd6mVQEQ+vJZn53unlbI5u3AAoUGd8Ry4LcZOtJrt9Km/y5c7GsUX54IHIAConMRYwtiE1kRdP9nRW/1sqLDfQzWFg1coeOpANRPwrmKSMkPGJkstI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ni/GQJhO; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9d44ba5b-19c8-4bb4-8f9a-0187d190274a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708533624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ISfsKUpDfaG9BkgG/vcBYKBNCmixJoSAY6YNl9RbRQ=;
	b=Ni/GQJhOGcMZwAR51HfeCinHpCOjk59TlQEI/HZKW18VlouMDnkGMbdALFT1YKMVDeecs4
	M3SS2Y2jEr90VlYeRst6iTqhsQXejopvJEne8700DJvn9Li6Vp4c9kwaCdFi7wRAF3M9ws
	gFQWU9ZZUbKzKjqXGRV++6mAKwHowsQ=
Date: Wed, 21 Feb 2024 08:40:19 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Shrink size of struct bpf_map/bpf_array.
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
 kernel-team@fb.com
References: <20240220235001.57411-1-alexei.starovoitov@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240220235001.57411-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2/20/24 3:50 PM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>
> Back in 2018 the commit be95a845cc44 ("bpf: avoid false sharing of map refcount with max_entries")
> added ____cacheline_aligned to "struct bpf_map" to make sure that fields like
> refcnt don't share a cache line with max_entries that is used to bounds check
> map access. That was done to make spectre style attacks harder. The main
> mitigation is done via code similar to array_index_nospec(), of course.
> This was an additional precaution.
> It increased the size of "struct bpf_map" a little, but it's affect
> on all other maps (like array) is significant, since "struct bpf_map" is
> typically the first member in other map types.
>
> Undo this ____cacheline_aligned tag. Instead move freeze_mutex field around,
> so that refcnt and max_entries are still in different cache lines.
>
> The main effect is seen in sizeof(struct bpf_array) that reduces from 320 to 248 bytes.
>
> BEFORE:
>
> struct bpf_map {
> 	const struct bpf_map_ops  * ops;                 /*     0     8 */
> 	...
> 	char                       name[16];             /*    96    16 */
>
> 	/* XXX 16 bytes hole, try to pack */
>
> 	/* --- cacheline 2 boundary (128 bytes) --- */
> 	atomic64_t refcnt __attribute__((__aligned__(64))); /*   128     8 */
> 	...
> 	/* size: 256, cachelines: 4, members: 30 */
> 	/* sum members: 232, holes: 1, sum holes: 16 */
> 	/* padding: 8 */
> 	/* paddings: 1, sum paddings: 2 */
> } __attribute__((__aligned__(64)));
>
> struct bpf_array {
> 	struct bpf_map             map;                  /*     0   256 */
> 	...
> 	/* size: 320, cachelines: 5, members: 5 */
> 	/* padding: 48 */
> 	/* paddings: 1, sum paddings: 8 */
> } __attribute__((__aligned__(64)));
>
> AFTER:
>
> struct bpf_map {
> 	/* size: 232, cachelines: 4, members: 30 */
> 	/* paddings: 1, sum paddings: 2 */
> 	/* last cacheline: 40 bytes */
> };
> struct bpf_array {
> 	/* size: 248, cachelines: 4, members: 5 */
> 	/* last cacheline: 56 bytes */
> };
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


