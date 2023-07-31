Return-Path: <bpf+bounces-6443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB759769771
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 15:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07AD41C20C18
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 13:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2F3182D9;
	Mon, 31 Jul 2023 13:24:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0C04429
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 13:24:03 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354C21708;
	Mon, 31 Jul 2023 06:24:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9B7002228E;
	Mon, 31 Jul 2023 13:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1690809839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c7nCp6bUMUXzsX8AVFR76D+rWXz0yIMDTk4KEgqwhiY=;
	b=dnbGBmjd55Fr7v6XcCJyJfWWM8SfkaBrmopZf+bHJxc5Q+5pqMHMV5kR+2cjYoanViwARE
	/2Pi6VMrxNjoEiXQCV22+wcjwioVo4JEhLAPb8NsxFbGNUODKsBO1myhC7Bha34tySKXxy
	XNnWZsu1dNZ6WA3UHy7h+jAVkQz9c/s=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7C06F133F7;
	Mon, 31 Jul 2023 13:23:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id mv5KG++1x2TsNgAAMHmgww
	(envelope-from <mhocko@suse.com>); Mon, 31 Jul 2023 13:23:59 +0000
Date: Mon, 31 Jul 2023 15:23:58 +0200
From: Michal Hocko <mhocko@suse.com>
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: hannes@cmpxchg.org, roman.gushchin@linux.dev, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, wuyun.abel@bytedance.com,
	robin.lu@bytedance.com, muchun.song@linux.dev,
	zhengqi.arch@bytedance.com
Subject: Re: [RFC PATCH 0/5] mm: Select victim memcg using BPF_OOM_POLICY
Message-ID: <ZMe17kOoHr/eYnVT@dhcp22.suse.cz>
References: <20230727073632.44983-1-zhouchuyi@bytedance.com>
 <ZMInlGaW90Uw1hSo@dhcp22.suse.cz>
 <7347aad5-f25c-6b76-9db5-9f1be3a9f303@bytedance.com>
 <ZMKoAfGRgkl4rmtj@dhcp22.suse.cz>
 <eb764131-6d2f-c088-5481-99d605a67349@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb764131-6d2f-c088-5481-99d605a67349@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon 31-07-23 14:00:22, Chuyi Zhou wrote:
> Hello, Michal
> 
> 在 2023/7/28 01:23, Michal Hocko 写道:
[...]
> > This sounds like a very specific oom policy and that is fine. But the
> > interface shouldn't be bound to any concepts like priorities let alone
> > be bound to memcg based selection. Ideally the BPF program should get
> > the oom_control as an input and either get a hook to kill process or if
> > that is not possible then return an entity to kill (either process or
> > set of processes).
> 
> Here are two interfaces I can think of. I was wondering if you could give me
> some feedback.
> 
> 1. Add a new hook in select_bad_process(), we can attach it and return a set
> of pids or cgroup_ids which are pre-selected by user-defined policy,
> suggested by Roman. Then we could use oom_evaluate_task to find a final
> victim among them. It's user-friendly and we can offload the OOM policy to
> userspace.
> 
> 2. Add a new hook in oom_evaluate_task() and return a point to override the
> default oom_badness return-value. The simplest way to use this is to protect
> certain processes by setting the minimum score.
> 
> Of course if you have a better idea, please let me know.

Hooking into oom_evaluate_task seems the least disruptive to the
existing oom killer implementation. I would start by planing with that
and see whether useful oom policies could be defined this way. I am not
sure what is the best way to communicate user input so that a BPF prgram
can consume it though. The interface should be generic enough that it
doesn't really pre-define any specific class of policies. Maybe we can
add something completely opaque to each memcg/task? Does BPF
infrastructure allow anything like that already?

-- 
Michal Hocko
SUSE Labs

