Return-Path: <bpf+bounces-15534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FEC7F3286
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 16:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA3911C21AB9
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 15:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A740158121;
	Tue, 21 Nov 2023 15:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C0C99;
	Tue, 21 Nov 2023 07:41:22 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1r5SsI-0003vD-Qs; Tue, 21 Nov 2023 16:41:18 +0100
Message-ID: <0a594a11-d345-48c3-a651-08ea80ab76a1@leemhuis.info>
Date: Tue, 21 Nov 2023 16:41:17 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: inet6_sock_destruct->inet_sock_destruct trigger Call Trace
Content-Language: en-US, de-DE
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Linux Networking <netdev@vger.kernel.org>, Linux BPF
 <bpf@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>
References: <8bfaee54-3117-65d3-d723-6408edf93961@gmail.com>
 <c3a5d08e-9c7c-4888-916a-ba4bd22a3319@collabora.com>
From: "Linux regression tracking #update (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <c3a5d08e-9c7c-4888-916a-ba4bd22a3319@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1700581283;bc6798bc;
X-HE-SMSGID: 1r5SsI-0003vD-Qs

On 29.08.23 15:07, Muhammad Usama Anjum wrote:
> On 6/16/23 5:43 PM, Bagas Sanjaya wrote:
>> I notice a regression report on Bugzilla [1]. Quoting from it:
> [...]
>>> When the IPv6 address or NIC configuration changes, the following kernel warnings may be triggered:
> [...]
>>> Thu Jun 15 09:02:31 2023 daemon.info : 09[KNL] interface utun deleted
> [...]
>> #regzbot introduced: v6.1.27..v6.1.32 https://bugzilla.kernel.org/show_bug.cgi?id=217555
>> #regzbot title: kernel warning (oops) at inet_sock_destruct
> The same warning has been seen on 4.14, 5.15, 6.1 and latest mainline.
>
> This WARN_ON is present from 2008.

Hmmm, the commit that according to syzkaller's bisection caused this is
not in those series. So I assume the bisection went sideways.

And the reporter of the bugzilla ticket never bisected this either.
Wondering if it started to show up there due to small unrelated timing
changes.

Not totally sure, but it seems like this in the end is not a real
regression or one we can't do anything about. Thus removing this from
the tracking; if anyone disagrees, please holler.

#regzbot inconclusive: likely an older problem
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.


