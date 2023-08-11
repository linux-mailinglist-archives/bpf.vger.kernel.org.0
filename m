Return-Path: <bpf+bounces-7603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B97977974E
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 20:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D20E1C21780
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 18:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6463219FC;
	Fri, 11 Aug 2023 18:50:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC2B219F0
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 18:50:33 +0000 (UTC)
Received: from out-81.mta0.migadu.com (out-81.mta0.migadu.com [IPv6:2001:41d0:1004:224b::51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245DF30EE
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 11:50:31 -0700 (PDT)
Message-ID: <49f5a594-3db7-fb99-1083-7df1155d3357@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691779829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aTSMPU3IVVneEIppNm0unuUG3WBb/CMepnvLmC2MOQE=;
	b=Jjy3Hxr8xfaB7kvP0hFkE6FNlEU+fNmjgZdvMgik8IBihqs5T7HAdH4Pqlni9gMLbuGSgd
	9CiidqEcANKn2qFZX4vW2BjIZ3OLRw6Vy8Pu+rZ3DVayA0ATTCwYn/iXpIQxP3ousL0wg1
	fbT4Op0fk3nfff5/hhL2b+/ut+BnoI0=
Date: Fri, 11 Aug 2023 11:50:17 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v11 2/5] selftests/bpf: Use random netns name for
 mptcp
Content-Language: en-US
To: Geliang Tang <geliang.tang@suse.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Florent Revest <revest@chromium.org>,
 Brendan Jackman <jackmanb@chromium.org>,
 Matthieu Baerts <matthieu.baerts@tessares.net>,
 Mat Martineau <martineau@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 John Johansen <john.johansen@canonical.com>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Eric Paris <eparis@parisplace.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <cover.1691125344.git.geliang.tang@suse.com>
 <15d7646940fcbb8477b1be1aa11a5d5485d10b48.1691125344.git.geliang.tang@suse.com>
 <8b706f66-2afa-b3d0-a13a-11f1ffb452fe@linux.dev>
 <20230807064044.GA11180@localhost.localdomain>
 <9a84e026-402d-b6d9-b6d1-57d91455da47@linux.dev>
 <20230809081944.GA29707@bogon>
 <ffd1bb86-ed32-3301-346a-e369219841de@linux.dev>
 <20230811092915.GA8364@bogon>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230811092915.GA8364@bogon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/11/23 2:29 AM, Geliang Tang wrote:
> On Thu, Aug 10, 2023 at 10:53:38PM -0700, Martin KaFai Lau wrote:
>> On 8/9/23 1:19 AM, Geliang Tang wrote:
>>> On Tue, Aug 08, 2023 at 11:03:30PM -0700, Martin KaFai Lau wrote:
>>>> On 8/6/23 11:40 PM, Geliang Tang wrote:
>>>>> On Fri, Aug 04, 2023 at 05:23:32PM -0700, Martin KaFai Lau wrote:
>>>>>> On 8/3/23 10:07 PM, Geliang Tang wrote:
>>>>>>> Use rand() to generate a random netns name instead of using the fixed
>>>>>>> name "mptcp_ns" for every test.
>>>>>>>
>>>>>>> By doing that, we can re-launch the test even if there was an issue
>>>>>>> removing the previous netns or if by accident, a netns with this generic
>>>>>>> name already existed on the system.
>>>>>>>
>>>>>>> Note that using a different name each will also help adding more
>>>>>>> subtests in future commits.
>>>>>
>>>>> Hi Martin,
>>>>>
>>>>> I tried to run mptcp tests simultaneously, and got "Cannot create
>>>>> namespace file "/var/run/netns/mptcp_ns": File exists" errors sometimes.
>>>>> So I add this patch to fix it.
>>>>>
>>>>> It's easy to reproduce, just run this commands in multiple terminals:
>>>>>     > for i in `seq 1 100`; do sudo ./test_progs -t mptcp; done
>>>>
>>>> Not only the "-t mptcp" test. Other tests in test_progs also don't support
>>>> running parallel in multiple terminals. Does it really help to test the bpf
>>>> part of the prog_tests/mptcp.c test by running like this? If it wants to
>>>> exercise the other mptcp networking specific code like this, a separate
>>>> mptcp test is needed outside of test_progs and it won't be run in the bpf
>>>> CI.
>>>>
>>>> If you agree, can you please avoid introducing unnecessary randomness to the
>>>> test_progs where bpf CI and most users don't run in this way?
>>>
>>> Thanks Martin. Sure, I agree. Let's drop this patch.
>>
>> Thanks you.
>>
>>>> I have a high level question. In LPC 2022
>>>> (https://lpc.events/event/16/contributions/1354/), I recall there was idea
>>>> in using bpf to make other mptcp decision/policy. Any thought and progress
>>>> on this? This set which only uses bpf to change the protocol feels like an
>>>> incomplete solution.
>>>
>>> We are implementing MPTCP packet scheduler using BPF. Patches aren't
>>> sent to BPF mail list yet, only temporarily on our mptcp repo[1].
>>>
>>> Here are the patches:
>>>
>>>    selftests/bpf: Add bpf_burst test
>>>    selftests/bpf: Add bpf_burst scheduler
>>>    bpf: Export more bpf_burst related functions
>>>    selftests/bpf: Add bpf_red test
>>>    selftests/bpf: Add bpf_red scheduler
>>>    selftests/bpf: Add bpf_rr test
>>>    selftests/bpf: Add bpf_rr scheduler
>>>    selftests/bpf: Add bpf_bkup test
>>>    selftests/bpf: Add bpf_bkup scheduler
>>>    selftests/bpf: Add bpf_first test
>>>    selftests/bpf: Add bpf_first scheduler
>>>    selftests/bpf: Add bpf scheduler test
>>>    selftests/bpf: add two mptcp netns helpers
>>>    selftests/bpf: use random netns name for mptcp
>>>    selftests/bpf: Add mptcp sched structs
>>>    bpf: Add bpf_mptcp_sched_kfunc_set
>>>    bpf: Add bpf_mptcp_sched_ops
>>>
>>> If you could take a look at these patches in advance, I would greatly
>>> appreciate it. Any feedback is welcome.
>>>
>>> [1]
>>> https://github.com/multipath-tcp/mptcp_net-next.git
>>
>> Thanks for sharing. I did not go into the details. iiuc, the scheduler is
>> specific to a namespace. Do you see if it is useful to have more finer
>> control like depending on what IP address it is connected to? BPF policy is
>> usually found more useful to have finer policy control than global or
>> per-netns.
>>
>> The same question goes for the fmod_ret here in this patch. The
>> progs/mptcpify.c selftest is as good as upgrading all TCP connections. Is it
>> your only use case and no need for finer selection?
> 
> This per-netns control is just the first step. We do need finer selection. The
> most ideal mode is to select one app to upgrade it's TCP connections only. So
> per-cgroup control is much better than per-netns. But we haven't found a good
> per-cgroup solution yet.

Selecting an app or cgroup can sort of be done by getting the current task or 
current cgroup (there is helper to do that). I am imagining eventually it will 
want to decide the protocol upgrade and/or the mptcp-scheduler when the 
destination IP is decided. This fmod_ret upgrade for all acts like a global knob 
(sysctl) and feels like a hack or at least incomplete. However, I also don't see 
a clean way to do that for now in the current shape.

Please respin another revision to address the earlier selftest comment on the 
netns name. Thanks.



