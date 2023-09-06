Return-Path: <bpf+bounces-9318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D454479377C
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 10:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9426428125E
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 08:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE391103;
	Wed,  6 Sep 2023 08:52:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D146EC2
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 08:52:43 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D0BE9
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 01:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=UKf05mvw6oY9cTFjqq69Eejd2KGvUw3q7ZZ9CI6ZhS8=; b=nOWVzMm2y+DAnWoGH6n/nQz3Ne
	q7Q/zI6MqN1T1yF2mmYOM9Pgqy1659J3zqIcKo8PjDtT9iLfv2fLfTB8Jy6lM9is2cI3UoBt7i38V
	fEBVyG+o4amuzR8hX2dz/G22URqp7PDJNGz//Ot4PH1DK2eGBHgIt4uG90oqEfrRYcFvz7sz3ng9H
	nET2KWwXPzGCPmgEBhKlKpnxoHAQZZ6zQ7WWZSvD/ybhQ6pUl8H/DCuJ8Xp7HZpUO0F+1GX0N+ZZx
	O1g8b3x6AepXBbo0GYuUSCEaU0gEyh2Bmo/s9F4UmhfV0AqNWUg3gRlTgSMU5Mggi6kTbm0ALc9KM
	0BH+ZUog==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qdoH7-000Ftr-9M; Wed, 06 Sep 2023 10:52:37 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qdoH7-000XnK-2u; Wed, 06 Sep 2023 10:52:37 +0200
Subject: Re: [PATCH 2/2] bpf: Assign bpf_tramp_run_ctx::saved_run_ctx before
 recursion check.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Kui-Feng Lee <kuifeng@fb.com>, Thomas Gleixner <tglx@linutronix.de>
References: <20230830080405.251926-1-bigeasy@linutronix.de>
 <20230830080405.251926-3-bigeasy@linutronix.de> <ZPHxAbQDzZVNyXBL@krava>
 <20230901141908.vMoXrBK6@linutronix.de>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <e51947bb-c01b-8bbd-603b-19c11a71ceff@iogearbox.net>
Date: Wed, 6 Sep 2023 10:52:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230901141908.vMoXrBK6@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27023/Wed Sep  6 09:38:27 2023)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/1/23 4:19 PM, Sebastian Andrzej Siewior wrote:
> On 2023-09-01 16:13:04 [+0200], Jiri Olsa wrote:
>> On Wed, Aug 30, 2023 at 10:04:05AM +0200, Sebastian Andrzej Siewior wrote:
>>> __bpf_prog_enter() assigns bpf_tramp_run_ctx::saved_run_ctx before
>>
>> I guess you meant __bpf_prog_enter_recur right?
>>
>>> performing the recursion check which means in case of a recursion
>>> __bpf_prog_exit() uses the previously set
>>> bpf_tramp_run_ctx::saved_run_ctx value.
>>>
>>> __bpf_prog_enter_sleepable() assigns bpf_tramp_run_ctx::saved_run_ctx
>>
>> __bpf_prog_enter_sleepable_recur ?
>>
>>> after the recursion check which means in case of a recursion
>>> __bpf_prog_exit_sleepable() uses an uninitialized value.
>>> This does not look right. If I read the entry trampoline code right,
>>> then bpf_tramp_run_ctx isn't initialized upfront.
>>>
>>> Align __bpf_prog_enter_sleepable() with __bpf_prog_enter() and set
>>
>> ditto
> 
> Yes, in both cases. The ones I mentioned have no conditionals. Sorry.

Sebastian, I fixed this up and also the __bpf_prog_exit*() presumably should
have been the _recur flavor.

https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?id=6764e767f4af1e35f87f3497e1182d945de37f93

Thanks,
Daniel

