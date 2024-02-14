Return-Path: <bpf+bounces-22017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEC1855096
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 18:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6701728F6E1
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 17:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F178614B;
	Wed, 14 Feb 2024 17:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JjMzW1wl"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C0385658
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 17:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707932571; cv=none; b=aJl7ADN3GjwEelFmcuMxsiLqSxPAVlERMP2MD6JUaU+HanVGNelMb2K4cwPu25L/enwbNzmsMb5y1bVDeQGJJkYz72JdyYrUG/Fzw49mCbi40VrnrFq/scaIh/VazKaK9l/kkQiOaWbyE0Smxsbusj4nY7/7Q5QXm6RwVd91b9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707932571; c=relaxed/simple;
	bh=GCAZxajm3QE7mMiSIwpGS4Lr8yXMVGVOt5GSnXQLyyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FprNzeSHGIr1PxHmJC13G5rma/oC3y30py0knSVwL7FryhgO5taQ+N4zhv2Dgc16bO7duAoAJf/E2lWSvL5K3cQRrOyY76lPJ6r207boP9AeO+RQCEqlsFZTN6xprcrxv61ooLPXXTyzi2Kql4V/3xget6OYzfQ2ZQWCJNiLirs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JjMzW1wl; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1fbcd9f1-6c83-4430-b797-a92285d1d151@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707932567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ux8mYfFejewypdj06gS1i/9B9jjDrtUcnMFpYYb5bI=;
	b=JjMzW1wl2us6M7A0nRD0bUm1LRBD706AHbejArXPuuRA0MSJEH4cIEhNH1lf04BinlHr2a
	z0jtBmke65erGiRTDrU/IRz1ge6mBSYT4qG/5ogMOnjWbhem5HOlFxX9mx8imlEwm5XA8g
	lzuPqcAvIemcWriQ4uXfbeTz+nm6GTQ=
Date: Wed, 14 Feb 2024 09:42:39 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/3] bpf: check bpf_func_state->callback_depth
 when pruning states
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, kuniyu@amazon.com
References: <20240212143832.28838-1-eddyz87@gmail.com>
 <20240212143832.28838-3-eddyz87@gmail.com>
 <fdf38873-a1e2-4a16-974b-ea2f265e08e1@linux.dev>
 <925915504557d991bf9b576a362e0ef4a8953795.camel@gmail.com>
 <0e5b990eeaa63590e067c8ac10642b6bc6d0e9a8.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <0e5b990eeaa63590e067c8ac10642b6bc6d0e9a8.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2/13/24 10:14 AM, Eduard Zingerman wrote:
> Updated diagram with a few fixes, line numbers would be removed in the
> final version.
>
> --- 8< ---------------------------------
>
>   .------------------------------------- Checkpoint / State name
>   |    .-------------------------------- Code point number
>   |    |   .---------------------------- Stack state {ctx.a,ctx.b,ctx.c}
>   |    |   |        .------------------- Callback depth in frame #0
>   v    v   v        v
> 1  - (0) {7P,7P,7},depth=0
> 2    - (3) {7P,7P,7},depth=1
> 3      - (0) {7P,7P,42},depth=1
> (a)      - (3) {7P,7,42},depth=2
> 4          - (0) {7P,7,42},depth=2      loop terminates because of depth limit
> 5            - (4) {7P,7,42},depth=0    predicted false, ctx.a marked precise
> 6            - (6) exit
> 7        - (2) {7P,7,42},depth=2
> 8          - (0) {7P,42,42},depth=2     loop terminates because of depth limit
> 9            - (4) {7P,42,42},depth=0   predicted false, ctx.a marked precise
> 10           - (6) exit
> (b)      - (1) {7P,7P,42},depth=2
> 11         - (0) {42P,7P,42},depth=2    loop terminates because of depth limit
> 12           - (4) {42P,7P,42},depth=0  predicted false, ctx.{a,b} marked precise
> 13           - (6) exit
> 14   - (2) {7P,7,7},depth=1
> 15     - (0) {7P,42,7},depth=1          considered safe, pruned using checkpoint (a)
> (c)  - (1) {7P,7P,7},depth=1            considered safe, pruned using checkpoint (b)

For the above line
    (c)  - (1) {7P,7P,7},depth=1            considered safe, pruned using checkpoint (b)
I would change to
    (c)  - (1) {7P,7P,7},depth=1
           - (0) {42P, 7P, 7},depth = 1     considered safe, pruned using checkpoint (11)

For
14   - (2) {7P,7,7},depth=1
15     - (0) {7P,42,7},depth=1          considered safe, pruned using checkpoint (a)
I suspect for line 15, the pruning uses checking point at line (8).

Other than the above, the diagram LGTM.

>
> Here checkpoint (b) has callback_depth of 2, meaning that it would
> never reach state {42,42,7}.
> While checkpoint (c) has callback_depth of 1, and thus
> could yet explore the state {42,42,7} if not pruned prematurely.
> This commit makes forbids such premature pruning,
> allowing verifier to explore states sub-tree starting at (c):
>
> (c)  - (1) {7,7,7P},depth=1
> 16     - (0) {42P,7,7P},depth=1
>           ...
> 17       - (2) {42,7,7},depth=2
> 18         - (0) {42,42,7},depth=2      loop terminates because of depth limit
> 19           - (4) {42,42,7},depth=0    predicted true, ctx.{a,b,c} marked precise
> 20             - (5) division by zero
>
> --------------------------------- >8 ---

