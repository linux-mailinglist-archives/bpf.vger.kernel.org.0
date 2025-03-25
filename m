Return-Path: <bpf+bounces-54634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7F1A6FAB8
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 13:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E9EB18910DB
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 12:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2A1253F2F;
	Tue, 25 Mar 2025 12:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMSi9rHJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C540EF9E6;
	Tue, 25 Mar 2025 12:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742904268; cv=none; b=mc4/Vys5aTr6lL7Q+C9zKrQDYlJsz6Z6lRzY5qdA7yB4l8W4QH7lXbO5YcyZqomoMhcTcy91Ol14+9HmUOyqq0cRuScy6fzlGovI3Dq+or6C0Zh/D2eS2Kk/6+7IRRHPlm3o0s0Q0EYRhHaOQBiuJwnlJQ3jyNPzgRyy5VFsv1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742904268; c=relaxed/simple;
	bh=Lgn+GjPuLLv587AjfxPK4UTvCKPwHlaM+UJ3rYCoRzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=thxann04ogw6k9YSIAxUbxgHON9BUrO7h9VoP2e/lA7W74xw6X+I8PFQn5DyNCfpUc5gpyCzQXtiIoddZ+8kD5KQx1W99RallcggIw64RiDVouE6dfU8Ox0/pCacDrYut74y4KLwhC+e1O98ZelgTQqVCEU4L5kXltvpofkvO5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMSi9rHJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E74FC4CEE4;
	Tue, 25 Mar 2025 12:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742904268;
	bh=Lgn+GjPuLLv587AjfxPK4UTvCKPwHlaM+UJ3rYCoRzY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LMSi9rHJGjJXGdNd/dIHCcGyuASfC3D6gHLXw6U5bfhA2YP24OMJAO+wrDIG5gew4
	 sEZio9lQpI7z8bb89Ge3UshE+gkbRCrtyFM3f7B7apBf7L9OMwjQ9TfSEdGnLfnBYL
	 OAHaOR3AoaiFCD98Xo6niQRRVAIovLyiU5NMaogC+V1x3XqO780BSJAFwzFzKaO6Cy
	 BVsDv9WvNSFzZbur5DauCssWseQYStvLOjP/rMyRMjHbSDJtJI3QA/3j2Ozhg2A55j
	 0TZmi1rTkX7txMyOfv6wmTdIQKz3MG3ZVLZD9gpdvjkdPvRrxX96kvLLgXxKuuQ95X
	 dp/Q4QJtUtNtw==
Message-ID: <15370998-6a91-464d-b680-931074889bc1@kernel.org>
Date: Tue, 25 Mar 2025 12:04:23 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next-20250324]/tool/bpf/bpftool fails to complie on
 linux-next-20250324
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 jkacur@redhat.com, lgoncalv@redhat.com, gmonaco@redhat.com,
 williams@redhat.com, tglozar@redhat.com, rostedt@goodmis.org
References: <5df6968a-2e5f-468e-b457-fc201535dd4c@linux.ibm.com>
 <8b0b2a41-203d-41f8-888d-2273afb877d0@qmon.net>
 <Z+KXN0KjyHlQPLUj@linux.ibm.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <Z+KXN0KjyHlQPLUj@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-03-25 17:14 UTC+0530 ~ Saket Kumar Bhaskar <skb99@linux.ibm.com>
> On Tue, Mar 25, 2025 at 11:09:24AM +0000, Quentin Monnet wrote:
>> 2025-03-25 16:02 UTC+0530 ~ Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>>> Greetings!!!
>>>
>>>
>>> bpftool fails to complie on linux-next-20250324 repo.
>>>
>>>
>>> Error:
>>>
>>> make: *** No rule to make target 'bpftool', needed by '/home/linux/
>>> tools/testing/selftests/bpf/tools/include/vmlinux.h'. Stop.
>>> make: *** Waiting for unfinished jobs.....
>>
>>
>> Thanks! Would be great to have a bit more context on the error (and on
>> how to reproduce) for next time. Bpftool itself seems to compile fine,
>> the error shows that it's building it from the context of the selftests
>> that seems broken.
>>
>>
> Yes, selftest build for BPF fails.
> ## pwd
> /linux/tools/testing/selftests/bpf
> 
> # make -j 33
> 
> make: *** No rule to make target 'bpftool', needed by '/home/upstreamci/linux/tools/testing/selftests/bpf/tools/include/vmlinux.h'.  Stop.
> make: *** Waiting for unfinished jobs....
> 
>>> Git bisect points to commit: 8a635c3856ddb74ed3fe7c856b271cdfeb65f293 as
>>> first bad commit.
>>
>> Thank you Venkat for the bisect!
>>
>> On a quick look, that commit introduced a definition for BPFTOOL in
>> tools/scripts/Makefile.include:
>>
>> 	diff --git a/tools/scripts/Makefile.include .../Makefile.include
>> 	index 0aa4005017c7..71bbe52721b3 100644
>> 	--- a/tools/scripts/Makefile.include
>> 	+++ b/tools/scripts/Makefile.include
>> 	@@ -91,6 +91,9 @@ LLVM_CONFIG	?= llvm-config
>> 	 LLVM_OBJCOPY	?= llvm-objcopy
>> 	 LLVM_STRIP	?= llvm-strip
>> 	
>> 	+# Some tools require bpftool
>> 	+BPFTOOL		?= bpftool
>> 	+
>> 	 ifeq ($(CC_NO_CLANG), 1)
>> 	 EXTRA_WARNINGS += -Wstrict-aliasing=3
>>
>> But several utilities or selftests under tools/ include
>> tools/scripts/Makefile.include _and_ use their own version of the
>> $(BPFTOOL) variable, often assigning only if unset, for example in
>> tools/testing/selftests/bpf/Makefile:
>>
>> 	BPFTOOL ?= $(DEFAULT_BPFTOOL)
>>
>> My guess is that the new definition from Makefile.include overrides this
>> with simply "bpftool" as a value, and the Makefile fails to build it as
>> a result.
>>
>> If I guessed correctly, one workaround would be to rename the variable
>> in Makefile.include (and in whatever Makefile now relies on it) into
>> something that is not used in the other Makefiles, for example
>> BPFTOOL_BINARY.
>>
>> Please copy the BPF mailing list on changes impacting BPF tooling (or
>> for BPF-related patchsets in general).
>>
>> Thanks,
>> Quentin
> Yes you are right that the new definition from Makefile.include overrides this
> with simply "bpftool" as a value, and the Makefile in bpf selftest fails to 
> build it as a result.
> 
> But the main cause is that it is not able to locate the bpftool binary.

I'm not sure I follow. What component is not able to locate the binary?

If you talk about the BPF selftests, I believe they only fail to locate
it because of the collision on the $(BPFTOOL) variable. Selftests'
Makefile was able to find the binary before that commit, so there should
be no need to change the path to the binary.

If you talk about tools/tracing/rtla/Makefile failing to locate bpftool,
it's another matter. As far as I understand, the RTLA Makefile assumes
that bpftool is available from $PATH, this is why the commit introduced
a probe in tools/build/feature: to ensure that bpftool is installed and
available. So here again, I don't see the motivation for changing the
path to the binary (And how do you know it's /usr/sbin/bpftool anyway?
Some users have it under /usr/local/sbin/, for example). If the intent
were to compile a bootstrap bpftool to make sure that it's available
instead then it should replicate what other BPF utilities or selftests
do, and get rid of the probe. But the commit description for
8a635c3856dd indicates that RTLA folks prefer not to compile bpftool and
rely on it being installed.

Quentin

