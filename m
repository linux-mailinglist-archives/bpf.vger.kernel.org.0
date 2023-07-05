Return-Path: <bpf+bounces-4024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED23747E18
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 09:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DEF91C20A75
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 07:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66271875;
	Wed,  5 Jul 2023 07:20:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04D8137F
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 07:20:39 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1A31A4;
	Wed,  5 Jul 2023 00:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=0Vgvxl37f1OQyLQheOShmtshBXHyCZZUDnHks6HVtYA=; b=P5m2+D6uF1gZdqNrX1tlzKAThb
	2gBVrJGIZ6HVovkJxciDKftbxKfZD41GSueMGuu/CpX8iG+B5o8U0sMrVNc9vSdArmsQWjaiI6xSd
	onO+A4xEa+fCCfi59QRBhCK3nrzArI36ZvF729lnW5Nx8VTjg2y1gmfVGZPrF2lYfDH9bTnEWMEMS
	B99Z62GQbf+RF8vrwQaDOhTatKIybgivdYx2RtqMtvm6Tkj1NqlntHYeN9sQkSq7TXPyFULIAFWvx
	AvlWKNQj3UeW1gqQPW/RRWQ5G3a4nBT6Z1E0ofvHPx39T83wJ8N8ENu/dTrjjjMUgB4n0apJGGFvZ
	mW8EP85w==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qGwoP-0001Gc-JI; Wed, 05 Jul 2023 09:20:29 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qGwoP-000A3L-4j; Wed, 05 Jul 2023 09:20:29 +0200
Subject: Re: [PATCH RESEND v3 bpf-next 01/14] bpf: introduce BPF token object
To: =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
 Christian Brauner <brauner@kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
 keescook@chromium.org, lennart@poettering.net, cyphar@cyphar.com,
 luto@kernel.org, kernel-team@meta.com, sargun@sargun.me
References: <20230629051832.897119-1-andrii@kernel.org>
 <20230629051832.897119-2-andrii@kernel.org>
 <20230704-hochverdient-lehne-eeb9eeef785e@brauner> <87sfa3b6j5.fsf@toke.dk>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <3555c0bd-7aee-35b0-655d-710437b4876c@iogearbox.net>
Date: Wed, 5 Jul 2023 09:20:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87sfa3b6j5.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26959/Tue Jul  4 09:29:23 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/5/23 1:28 AM, Toke Høiland-Jørgensen wrote:
> Christian Brauner <brauner@kernel.org> writes:
>> On Wed, Jun 28, 2023 at 10:18:19PM -0700, Andrii Nakryiko wrote:
>>> Add new kind of BPF kernel object, BPF token. BPF token is meant to to
>>> allow delegating privileged BPF functionality, like loading a BPF
>>> program or creating a BPF map, from privileged process to a *trusted*
>>> unprivileged process, all while have a good amount of control over which
>>> privileged operations could be performed using provided BPF token.
>>>
>>> This patch adds new BPF_TOKEN_CREATE command to bpf() syscall, which
>>> allows to create a new BPF token object along with a set of allowed
>>> commands that such BPF token allows to unprivileged applications.
>>> Currently only BPF_TOKEN_CREATE command itself can be
>>> delegated, but other patches gradually add ability to delegate
>>> BPF_MAP_CREATE, BPF_BTF_LOAD, and BPF_PROG_LOAD commands.
>>>
>>> The above means that new BPF tokens can be created using existing BPF
>>> token, if original privileged creator allowed BPF_TOKEN_CREATE command.
>>> New derived BPF token cannot be more powerful than the original BPF
>>> token.
>>>
>>> Importantly, BPF token is automatically pinned at the specified location
>>> inside an instance of BPF FS and cannot be repinned using BPF_OBJ_PIN
>>> command, unlike BPF prog/map/btf/link. This provides more control over
>>> unintended sharing of BPF tokens through pinning it in another BPF FS
>>> instances.
>>>
>>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>>> ---
>>
>> The main issue I have with the token approach is that it is a completely
>> separate delegation vector on top of user namespaces. We mentioned this
>> duringthe conf and this was brought up on the thread here again as well.
>> Imho, that's a problem both security-wise and complexity-wise.
>>
>> It's not great if each subsystem gets its own custom delegation
>> mechanism. This imposes such a taxing complexity on both kernel- and
>> userspace that it will quickly become a huge liability. So I would
>> really strongly encourage you to explore another direction.
> 
> I share this concern as well, but I'm not quite sure I follow your
> proposal here. IIUC, you're saying that instead of creating the token
> using a BPF_TOKEN_CREATE command, the policy daemon should create a
> bpffs instance and attach the token value directly to that, right? But
> then what? Are you proposing that the calling process inside the
> container open a filesystem reference (how? using fspick()?) and pass
> that to the bpf syscall? Or is there some way to find the right
> filesystem instance to extract this from at the time that the bpf()
> syscall is issued inside the container?

Given there can be multiple bpffs instances, it would have to be similar
as to what Andrii did in that you need to pass the fd to the bpf(2) for
prog/map creation in order to retrieve the opts->abilities from the super
block.

