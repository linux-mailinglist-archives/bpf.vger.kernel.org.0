Return-Path: <bpf+bounces-48508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B741FA084B1
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 02:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADE137A195C
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 01:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1462874BE1;
	Fri, 10 Jan 2025 01:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuM+x2TU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA0B2C9D;
	Fri, 10 Jan 2025 01:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736472018; cv=none; b=JhkHqxZ0vvbIwl4N7gp7q8KjykqltdBqy5hroAf4NaKmdZx1nYy1V8e75yOVVYWS/7xxQ2DBFLofZTERg8F18sH2OpImMzv5qK9WP/2LNuUlVZTWbk+GGHvbp6Max4mirqlfMdpqy+bIHxW6npOsuI2JsCa5jLvn0rqyFGGvByY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736472018; c=relaxed/simple;
	bh=bC07N4f6/bqSQvoJKRFF5Uq1G6jDIE7mrjMYAGGWFas=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VlUcVgSInoC5r9HaWfeCVwsXBKGuOTxuctsUIDVS9g/CX0AS7+kK7NkP1+h4ApyIpEoaatCV6JCULw5hgZ09mZKdpPKlRtNGw3eIXJZe0gsfWKAvu6oDS4xZYXazVlnE0nxKHt4vBfLL2aS+4wXT3pBFDQ1H/E1wnqc8ZUELKbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuM+x2TU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70070C4CED2;
	Fri, 10 Jan 2025 01:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736472018;
	bh=bC07N4f6/bqSQvoJKRFF5Uq1G6jDIE7mrjMYAGGWFas=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HuM+x2TUGW5r2DhK0aLGLeR+XYmcPrgCfdTWpnTiib4Bgos3O09Vw23IuUXaDuPgu
	 wkxSoOVSy8gZ8S0WksJfOhCb/DHjeap0D/yLBnCx7xGkxHM+zZ2aE2kHrXbr1qTP8w
	 Zut11s1HyDBjP0ip6WG1w739EM+J1fuo6ClBuf6gS4gi4PRhdI6ETKPiYnkMto9XNn
	 dMD4imcizV5+Nl3ycbjmBlQ/sGH6/lHMkTqoj3sO6PNHjDBNxCp6+IE4ZijABlp3NM
	 eBI1fjGUq9pWr7U+ZX9zjc1HtCEFb+yO/f0CqYfiKjS9z9iu1A+b1KKa/E3orHGIYK
	 6J58gaBTGJZQQ==
Date: Thu, 9 Jan 2025 17:20:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, alexei.starovoitov@gmail.com, martin.lau@kernel.org,
 sinquersw@gmail.com, toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us,
 stfomichev@gmail.com, ekarani.silvestre@ccc.ufcg.edu.br,
 yangpeihao@sjtu.edu.cn, xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com,
 amery.hung@bytedance.com
Subject: Re: [PATCH bpf-next v2 05/14] bpf: net_sched: Support
 implementation of Qdisc_ops in bpf
Message-ID: <20250109172016.1751083a@kernel.org>
In-Reply-To: <20241220195619.2022866-6-amery.hung@gmail.com>
References: <20241220195619.2022866-1-amery.hung@gmail.com>
	<20241220195619.2022866-6-amery.hung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Dec 2024 11:55:31 -0800 Amery Hung wrote:
> From: Amery Hung <amery.hung@bytedance.com>
> 
> Enable users to implement a classless qdisc using bpf. The last few
> patches in this series has prepared struct_ops to support core operators
> in Qdisc_ops. The recent advancement in bpf such as allocated
> objects, bpf list and bpf rbtree has also provided powerful and flexible
> building blocks to realize sophisticated scheduling algorithms. Therefore,
> in this patch, we start allowing qdisc to be implemented using bpf
> struct_ops. Users can implement Qdisc_ops.{enqueue, dequeue, init, reset,
> and .destroy in Qdisc_ops in bpf and register the qdisc dynamically into
> the kernel.

Are you making sure the BPF Qdisc can only be attached as TC_H_ROOT, 
and has no cl_ops? Sorry IDK much about the bpf ops glue.

It'd certainly be good if Jamal or Eric had a look since they handle
all the qdisc security bugs. The qdisc abstraction is an order of
magnitude more leaky than TCP CC ops :(

