Return-Path: <bpf+bounces-11378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA907B81BF
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 16:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id E01631C20444
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 14:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6E315EB8;
	Wed,  4 Oct 2023 14:05:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E068715E91
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 14:05:26 +0000 (UTC)
X-Greylist: delayed 115 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 Oct 2023 07:05:25 PDT
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [IPv6:2001:bc8:228b:9000::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE3DA1
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 07:05:24 -0700 (PDT)
Received: from [IPV6:2a02:8109:aa40:4e0:b5c6:9671:3477:8fde]
	by sdfg.com.ar (chasquid) with ESMTPSA
	tls TLS_AES_128_GCM_SHA256
	(over submission+TLS, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
	; Wed, 04 Oct 2023 14:03:25 +0000
Message-ID: <14c52402-ebc8-4425-9871-1663a87182ef@sdfg.com.ar>
Date: Wed, 4 Oct 2023 16:03:24 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] seccomp: Split set filter into two steps
To: Hengqi Chen <hengqi.chen@gmail.com>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Cc: keescook@chromium.org, luto@amacapital.net, wad@chromium.org,
 alexyonghe@tencent.com, Alban Crequy <albancrequy@linux.microsoft.com>
References: <20231003083836.100706-1-hengqi.chen@gmail.com>
Content-Language: en-US
From: Rodrigo Campos <rodrigo@sdfg.com.ar>
In-Reply-To: <20231003083836.100706-1-hengqi.chen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/3/23 10:38, Hengqi Chen wrote:
> This patchset introduces two new operations which essentially
> splits the SECCOMP_SET_MODE_FILTER process into two steps:
> SECCOMP_LOAD_FILTER and SECCOMP_ATTACH_FILTER.
> 
> The SECCOMP_LOAD_FILTER loads the filter and returns a fd
> which can be pinned to bpffs. This extends the lifetime of the
> filter and thus can be reused by different processes.

A quick question to see if handling something else too is 
possible/reasonable to do here too.

Let me explain our use case first.

For us (Alban in cc) it would be great if we can extend the lifetime of 
the fd returned, so the process managing a seccomp notification in 
userspace can easly crash or be updated. Today, if the agent that got 
the fd crashes, all the "notify-syscalls" return ENOSYS in the target 
process.

Our use case is we created a seccomp agent to use in Kubernetes 
(github.com/kinvolk/seccompagent) and we need to handle either the agent 
crashing or upgrading it. We were thinking tricks to have another 
container that just stores fds and make sure that never crashes, but it 
is not ideal (we checked tricks to use systemd to store our fds, but it 
is not simpler either to use from containers).

If the agent crashes today, all the syscalls return ENOSYS. It will be 
great if we can make the process doing the syscall just wait until a new 
process to handle the notifications is up and the syscalls done in the 
meantime are just queued. A mode of saying "if the agent crashes, just 
queue notifications, one agent to pick them up will come back soon" (we 
can of course limit reasonably the notification queue).

It seems the split here would not just work for that use case. I think 
we would need to pin the attachment.

Do you think handling that is something reasonable to do in this series too?

I'll be afk until end next week. I'll catch up as soon as I'm back with 
internet :)



Best,
Rodrigo

