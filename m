Return-Path: <bpf+bounces-11981-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0398F7C61F0
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 02:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A40D1C21023
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 00:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B8B657;
	Thu, 12 Oct 2023 00:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eSO6G4Mk"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9247463D
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 00:41:27 +0000 (UTC)
Received: from out-205.mta0.migadu.com (out-205.mta0.migadu.com [IPv6:2001:41d0:1004:224b::cd])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CB29E
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 17:41:24 -0700 (PDT)
Message-ID: <c5c662c3-61db-404c-c60f-8b23c23a5a79@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1697071283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=52AAa2YAsEgWyHhiF9wA11RnCsDVD8E2VS7xdPivlPQ=;
	b=eSO6G4MknxQN/j7i9+D+SerZwu4wa++3DjqR681s+z3MOynbrY8XBG/LSN2lBqBhckNL7/
	us7pe3x23Ci6Yky38LEi0LaHayluhQfS9AtuVGYBWackxelwUup63jOQ8fOh00mckdL196
	FWi2bjbLZf9ekJH+Unlx/RfvBupShdc=
Date: Wed, 11 Oct 2023 17:41:14 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v11 0/9] Add cgroup sockaddr hooks for unix
 sockets
Content-Language: en-US
To: Daan De Meyer <daan.j.demeyer@gmail.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: kernel-team@meta.com, netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20231011185113.140426-1-daan.j.demeyer@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231011185113.140426-1-daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/11/23 11:51 AM, Daan De Meyer wrote:
> Changes since v10:
> 
> * Removed extra check from bpf_sock_addr_set_sun_path() again in favor of
>    calling unix_validate_addr() everywhere in af_unix.c before calling the hooks.
> 
> Changes since v9:
> 
> * Renamed bpf_sock_addr_set_unix_addr() to bpf_sock_addr_set_sun_path() and
>    rennamed arguments to match the new name.
> * Added an extra check to bpf_sock_addr_set_sun_path() to disallow changing the
>    address of an unnamed unix socket.
> * Removed unnecessary NULL check on uaddrlen in
>    __cgroup_bpf_run_filter_sock_addr().
> 

[ ... ]

> This patch series extends the cgroup sockaddr hooks to include support for unix
> sockets. To add support for unix sockets, struct bpf_sock_addr_kern is extended
> to expose the socket address length to the bpf program. Along with that, a new
> kfunc bpf_sock_addr_set_unix_addr() is added to safely allow modifying an
> AF_UNIX sockaddr from bpf programs.
> 
> I intend to use these new hooks in systemd to reimplement the LogNamespace=
> feature, which allows running multiple instances of systemd-journald to
> process the logs of different services. systemd-journald also processes
> syslog messages, so currently, using log namespaces means all services running
> in the same log namespace have to live in the same private mount namespace
> so that systemd can mount the journal namespace's associated syslog socket
> over /dev/log to properly direct syslog messages from all services running
> in that log namespace to the correct systemd-journald instance. We want to
> relax this requirement so that processes running in disjoint mount namespaces
> can still run in the same log namespace. To achieve this, we can use these
> new hooks to rewrite the socket address of any connect(), sendto(), ...
> syscalls to /dev/log to the socket address of the journal namespace's syslog
> socket instead, which will transparently do the redirection without requiring
> use of a mount namespace and mounting over /dev/log.
> 
> Aside from the above usecase, these hooks can more generally be used to
> transparently redirect unix sockets to different addresses as required by
> services.

I have changed to use the "uaddr" test in patch 2 per the discussion in v10.
Patch 4 in v11 was changed based on the discussion in v10 (call bpf after 
unix_validate_addr), so I carried Kuniyuki's reviewed-by tag from v9.

Applied. Thanks.

