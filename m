Return-Path: <bpf+bounces-7993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DA377FAC2
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 17:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92DC91C21450
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 15:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEA0154BC;
	Thu, 17 Aug 2023 15:30:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE6F1548B
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 15:30:32 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED7C19AE
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 08:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=x0JJD8UpM7JN9iTpDE8DCwzkBpenthLiChD/Wxh5j3E=; b=cC6xHIsufBySwR/uQY3IPDAyhW
	s6qFSR3157+py4wkbXq1U/v9b6ij27UQ5fpk62401nN2kfrLSmQLMagKwM9iVFn6lG5stvOry52K9
	c96NFTcnD3n4Mniq4mnhexL6KFBsZnVHnAXsW0UGB2kYe49N3FhIfD4q2yWRcYTbwJ4yvLQrHENVu
	oTy+7IUyNcKOwhaKOnYl8xmx/JPuXcYriDLoc8LVWzdBdaT7rIOjwCYjQBA/PmFAqXTZzmHHbVu7I
	Sz9bnIHZf1ZHBRuiOBRJ7E2XsCUNylQt0QIhHOAplUcRFryqozQawz3ZJR+bR/KevWIRgjmJN6doa
	Ygkst7yA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qWex3-0001gp-GN; Thu, 17 Aug 2023 17:30:21 +0200
Received: from [85.1.206.226] (helo=pc-102.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qWex2-000UfF-IG; Thu, 17 Aug 2023 17:30:20 +0200
Subject: Re: [RFC PATCH bpf-next 1/2] bpf: Add bpf_current_capable kfunc
To: Yafang Shao <laoar.shao@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf <bpf@vger.kernel.org>
References: <20230814143341.3767-1-laoar.shao@gmail.com>
 <20230814143341.3767-2-laoar.shao@gmail.com>
 <56dc2449-f01c-f0a7-e31b-cfe6cd157aaa@linux.dev>
 <CALOAHbC9cka4Ma7KWOjGtFkjshU214z9NMaYXHiOTfc7dc7=tQ@mail.gmail.com>
 <CAADnVQJ1ddz9H4GQmegb4QMHk0cq_hXvK_r+MaLLssV7XtNY2g@mail.gmail.com>
 <CALOAHbDO-mdehzkojC_ZHnfoty=RrEr2ehYT7-qj1mzSpw-6aA@mail.gmail.com>
 <CAADnVQ+Nmspr7Si+pxWn8zkE7hX-7s93ugwC+94aXSy4uQ9vBg@mail.gmail.com>
 <CALOAHbDF=h9Piyx3BERNjK7Y_n6+qPefDvs+pFyZb5H2SmCkhQ@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <91d1017f-0c08-6db7-8696-63bd95c2b8a0@iogearbox.net>
Date: Thu, 17 Aug 2023 17:30:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALOAHbDF=h9Piyx3BERNjK7Y_n6+qPefDvs+pFyZb5H2SmCkhQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27003/Thu Aug 17 09:42:42 2023)
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/17/23 9:09 AM, Yafang Shao wrote:
> On Thu, Aug 17, 2023 at 11:31 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>> On Wed, Aug 16, 2023 at 7:31 PM Yafang Shao <laoar.shao@gmail.com> wrote:
>>> On Thu, Aug 17, 2023 at 9:54 AM Alexei Starovoitov
>>> <alexei.starovoitov@gmail.com> wrote:
>>>> On Mon, Aug 14, 2023 at 7:46 PM Yafang Shao <laoar.shao@gmail.com> wrote:
>>>>> On Tue, Aug 15, 2023 at 8:28 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>>>>> On 8/14/23 7:33 AM, Yafang Shao wrote:
>>>>>>> Add a new bpf_current_capable kfunc to check whether the current task
>>>>>>> has a specific capability. In our use case, we will use it in a lsm bpf
>>>>>>> program to help identify if the user operation is permitted.
>>>>>>>
>>>>>>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>>>>>>> ---
>>>>>>>    kernel/bpf/helpers.c | 6 ++++++
>>>>>>>    1 file changed, 6 insertions(+)
>>>>>>>
>>>>>>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>>>>>>> index eb91cae..bbee7ea 100644
>>>>>>> --- a/kernel/bpf/helpers.c
>>>>>>> +++ b/kernel/bpf/helpers.c
>>>>>>> @@ -2429,6 +2429,11 @@ __bpf_kfunc void bpf_rcu_read_unlock(void)
>>>>>>>        rcu_read_unlock();
>>>>>>>    }
>>>>>>>
>>>>>>> +__bpf_kfunc bool bpf_current_capable(int cap)
>>>>>>> +{
>>>>>>> +     return has_capability(current, cap);
>>>>>>> +}
>>>>>>
>>>>>> Since you are testing against 'current' capabilities, I assume
>>>>>> that the context should be process. Otherwise, you are testing
>>>>>> against random task which does not make much sense.
>>>>>
>>>>> It is in the process context.
>>>>>
>>>>>> Since you are testing against 'current' cap, and if the capability
>>>>>> for that task is stable, you do not need this kfunc.
>>>>>> You can test cap in user space and pass it into the bpf program.
>>>>>>
>>>>>> But if the cap for your process may change in the middle of
>>>>>> run, then you indeed need bpf prog to test capability in real time.
>>>>>> Is this your use case and could you describe in in more detail?
>>>>>
>>>>> After we convert the capability of our networking bpf program from
>>>>> CAP_SYS_ADMIN to CAP_BPF+CAP_NET_ADMIN to enhance the security, we
>>>>> encountered the "pointer comparison prohibited" error, because
>>>>> allow_ptr_leaks is enabled only when CAP_PERFMON is set. However, if
>>>>> we enable the CAP_PERFMON for the networking bpf program, it can run
>>>>> tracing bpf prog, perf_event bpf prog and etc, that is not expected by
>>>>> us.
>>>>>
>>>>> Hence we are planning to use a lsm bpf program to disallow it from
>>>>> running other bpf programs. In our lsm bpf program we will check the
>>>>> capability of processes, if the process has cap_net_admin, cap_bpf and
>>>>> cap_perfmon but don't have cap_sys_admin we will refuse it to run
>>>>> tracing and perf_event bpf program. While if a process has  cap_bpf
>>>>> and cap_perfmon but doesn't have cap_net_admin, that said it is a bpf
>>>>> program which wants to run trace bpf, we will allow it.
>>>>>
>>>>> We can't use lsm_cgroup because it is supported on cgroup2 only, while
>>>>> we're still using cgroup1.
>>>>>
>>>>> Another possible solution is enable allow_ptr_leaks for cap_net_admin
>>>>> as well, but after I checked the commit which introduces the cap_bpf
>>>>> and cap_perfmon [1], I think we wouldn't like to do it.
>>>>
>>>> Sorry. None of these options are acceptable.
>>>>
>>>> The idea of introducing a bpf_current_capable() kfunc just to work
>>>> around a deficiency in the verifier is not sound.
>>>
>>> So what should we do then?
>>> Just enabling the cap_perfmon for it? That does not sound as well ...
>>
>> Yonghong already pointed out upthread that
>> comparison of two packet pointers is not a pointer leak.
>> See this code:
>>          } else if (!try_match_pkt_pointers(insn, dst_reg, &regs[insn->src_reg],
>>                                             this_branch, other_branch) &&
>>                     is_pointer_value(env, insn->dst_reg)) {
>>                  verbose(env, "R%d pointer comparison prohibited\n",
>>                          insn->dst_reg);
>>                  return -EACCES;
>>          }
>>
>> It's not clear why it doesn't address your case.
> 
> It can address the issue.
> It seems we should do the code change below.

I presume in your actual program you also access the IP header (otherwise it
would be quite useless), and as you mentioned above, you would like this to be
accessible for just CAP_BPF + CAP_NET_ADMIN. The CAP_PERFMON restriction is
there for a reason, that is, to be on same cap level as tracing programs as you
could craft Spectre v1 style access. It's not a deficiency.

Thanks,
Daniel

