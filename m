Return-Path: <bpf+bounces-13928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 379667DEEAC
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 10:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 656911C20EC0
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 09:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709C1111BE;
	Thu,  2 Nov 2023 09:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6552F53
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 09:13:37 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F7812C;
	Thu,  2 Nov 2023 02:13:35 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1qyTlZ-0006Jq-Mr; Thu, 02 Nov 2023 10:13:29 +0100
Message-ID: <7ade1b4d-71ad-4f32-9b19-9d8eac8e595b@leemhuis.info>
Date: Thu, 2 Nov 2023 10:13:28 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mainline build failure due to 9c66dc94b62a ("bpf: Introduce
 css_task open-coded iterator kfuncs")
Content-Language: en-US, de-DE
To: Chuyi Zhou <zhouchuyi@bytedance.com>,
 "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, regressions@lists.linux.dev,
 Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <ZUNiwMLBsL52X9wa@debian>
 <79260ece-5819-4292-bfac-dc21a3701813@bytedance.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <79260ece-5819-4292-bfac-dc21a3701813@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1698916415;34be3a63;
X-HE-SMSGID: 1qyTlZ-0006Jq-Mr

On 02.11.23 09:53, Chuyi Zhou wrote:
> 在 2023/11/2 16:50, Sudip Mukherjee (Codethink) 写道:

>> The latest mainline kernel branch fails to build mips
>> decstation_64_defconfig,
>> decstation_defconfig and decstation_r4k_defconfig with the error:
>>
>> kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_new':
>> kernel/bpf/task_iter.c:917:14: error: 'CSS_TASK_ITER_PROCS' undeclared
>> (first use in this function)
>>    917 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
>>        |              ^~~~~~~~~~~~~~~~~~~
> [...]
>> git bisect pointed to 9c66dc94b62a ("bpf: Introduce css_task
>> open-coded iterator kfuncs")
> 
> Thanks for the report! This issue has been solved by Jiri.[1]
> 
> [1]:https://lore.kernel.org/all/169890482505.9002.10852784674164703819.git-patchwork-notify@kernel.org/

Thx, I was just about to reply something similar. :-D

Sudip, maybe you know about this already, but in case you don't, here is
a quick tip that might be useful for you: in cases like this it's often
wise to search for earlier reports on lore using an even more
abbreviated commit-id followed by a wildcard (e.g. "9c66dc94*"). That at
least was how I found the fix quickly.

Ciao, Thorsten

#regzbot fix: bpf: fix compilation error without CGROUPS

