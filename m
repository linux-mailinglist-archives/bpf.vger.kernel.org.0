Return-Path: <bpf+bounces-17629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D905881066C
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 01:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8936A2823D8
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 00:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46386656;
	Wed, 13 Dec 2023 00:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vZkqjdBB"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [IPv6:2001:41d0:203:375::b3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D428ABC
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 16:20:07 -0800 (PST)
Message-ID: <ba9770b8-90d8-4a91-a53d-511b1d3035e6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702426805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dXei4R5WhISTa8V9Cx/vyEpxANH13se4SepHxIgRHBo=;
	b=vZkqjdBBylMFRKqHP6M9Y/K4LWrBgIlKzU8u/8C4po8SIBmHxmDMNYBa9vTS2uNFJegBNW
	Fw/RwHym0rlRRSn66mABk3urk11RGOhpWGYbT97dIhP4l94XhhQnRIyWgutaxrALoQOrgy
	uYsuKOTonysRzU/w2WWLauzbeXTbuMo=
Date: Tue, 12 Dec 2023 16:19:58 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: fix compiler warnings in
 RELEASE=1 mode
Content-Language: en-GB
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
References: <20231212225343.1723081-1-andrii@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231212225343.1723081-1-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 12/12/23 2:53 PM, Andrii Nakryiko wrote:
> When compiling BPF selftests with RELEASE=1, we get two new
> warnings, which are treated as errors. Fix them.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


