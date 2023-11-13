Return-Path: <bpf+bounces-15012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0B67EA571
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 22:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB059280F2B
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 21:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281712D612;
	Mon, 13 Nov 2023 21:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="DAB7J6Fh"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E2025115
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 21:24:05 +0000 (UTC)
Received: from sonic315-27.consmr.mail.ne1.yahoo.com (sonic315-27.consmr.mail.ne1.yahoo.com [66.163.190.153])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFCDB8
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 13:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699910643; bh=Q+acr/be70t1qaqJl98sZAgblqxBJgZGNWufCtP0+54=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=DAB7J6Fh4T6a065J+Qt6rU6lpcVtqeaiYz/5Qaes4MXfm/ymM4AbtFUa/WxGVMl46jDt2X6lJlsbfszKCCuEqayuf3Mmpx009vDmUnMGY7E+NmRn/YjTeuKNiyb/c7Cgb15s7vUDYemTPUt0UtDHqPJ46GrL9GgKmW7Ck2k437B9UrZ18futhMhtBWLk5CaACpIwYxuDKd9rPyWxBp7Rm1IpUKg+oWg0U4RxW03iApNiRA5PEdvWuy38CLR1jGZq+O2RdPMvNY+4G9fZ+Avo3yF2itlfAXOW183jP7q80JuoFhfyBJIbgvTPN4m0ZUeB+9WXTt+hXn/mIhdZVU9C6w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1699910643; bh=lx6aW4wJ3MYFenIX2EelGXCn52W6fOSVGiJ6lkZ4Q9d=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=mzHoZXhbjRBqC1+F+UvMCfjWcs60WERfNONfwzMy2nlzsqeIZUwdDnkHnhp3ZSFskCkSO9u30j7XVbTaRUeiWnSUP1oBdQCHyT2dn+/Ohd2bBUPJmW3ECUWmmvvpZ06pK7np4WI3ImMZVoRxbD0ryPEhEujxU67thme8CSr2dKLBpYDnVzeYxHYm3tNeRPJ0RsZCUYAWg1+BkdzsC8I6RkPyolPsyeT4GBBkNxasBZXDI4Kbvz3tzOQf3SW8k+PuM3vQMZEwGRp7PYH5BiyOCNn4IEcaMPXm96uo3kfhwWmAlrTsZiE69BEK5bK6NgdhuYSgU55jlo6GFktE/UyJ3w==
X-YMail-OSG: pXRkN8AVM1kSWfabgwrN8ScX7L6rK20C4w46QI4ah1W9ktBubQwALWKwBzvAOhG
 ZvmJzjrHrcn.JxyLjiICO7m.QloiotK9LAcVm1izKei1qx3Vr5fbJAxOt2RHEgOCqykND2NjAU5n
 mPUW.SyHi9Kpw5.Qx6pHn5cj0VrcDpLFbV0hnYYrRJqtskTbpE_0gKAJTK5B0RQNqWqQSIaEEeL2
 KDawA26rFtTDb5k3G0LLxHnHMH9mgKsPfHu7OwzSwwYT8SBNbbjZ_dqlNRWcsnWyH7sFZMBrRFQy
 AHcN1O3KUbzQbKETHFaYKg8QhORSdkSMthyW2Y.Pyu5mgSSnySUdlHroUW_LtD6ZxEXI6Uuctpii
 hsIS.PXOAbLWP2OiQyjgQPAko1tJBsqr1cr9ZE3SLWAxue_zbIX0X0l6rRsYba_Go4jf9kr8gW0b
 OU462eXwfSjf..vj4Wwh_g7NcTsfrYGnfaiv7BFG4wAjKDVEC9jKJOddtBdDj_CPMLSZ3BgSgr9D
 BPmg812odWF4HF6yLs62ZOEb0jpivsyEOHwB3tnEYI6tBCRR8nyO20Qpa.WgeWvc4WOop0yDk.Rs
 3RnE5VCW0wsWJWiUHS.QFEkYl6oAeyt4ZlQWdVFntF9H9qmhZobhdNH07hO1jygw0cvwPg0a5kxW
 ZouLOlhHScZ4kXS3OeBauIiIpninaYNeZn4eqnyZwvTwUxO4ZQGnOjp465njJa5Ln3KF1IvECnqn
 QQRHALdlO8Q6YuSPqKnOHZ3jXVX07dwOyehFVSzVyeyzEQ4MezMp7XXgvmYgOt8vxkIru7oRCu9R
 crqbZkGduB2pNRZAI_FUOX5js1_JJOFxHbGCIlLz5dPzbzR9ZQ7hF9QE1T4yDhHmCdMjFmUkZrHA
 w_hwMDHZWQBLF805DWOR2ugB2n6nNFs5eKVXYc6CrmtyOqHbWbpNOVqvC.e5lalTK3N4ld049s0l
 XY7lu03laj237Y5.wOnIf1Au23eEEXhbP_KVhfKU1ehkJDDNi5d8FjLt6R.qPWUDesIjeR5W1g9X
 V4iShA1h5WjNLY9QjQa9A3u7aqyE4g80qSmSw3BVN711YyBxXL8hS3BrV3ZfxjH0dIuCN0Gc43or
 UGFE1g1hUXSd65dm4ul7I2BRPsCdjM0hXIGgllN8eQaYCT3.5roHsRRolYVx_0TO_qG9rG.2sOmh
 .bfw.7HvXaDNCd.94eQ7RGcB5tOhWPqx.8ymuSU9Cm_etSSo97kmBDRAIJyAEj8DB5SIQAWSuFiM
 EZfEPR4E6TmoCSxXNBCWAIAQbhc3AA9sLO6_5yCAapSsnfn70Fz2Pc0ngnY4EucS6qycVzMPArgc
 NU64_Bjd8B3n0RbTn5tyRavB53oT5F2vs_c6KaxaAgPky9__Ip5kW4q6.tILomfroo7I_bYhKH35
 PIrqq6pgtfapa1eR.UdXfnWdnvdT1pUZw3KgebsmVz7FICQ7tUf_wU2Z5r.Hx0Z.EpBrzYekeBzV
 SBiVFTQXGMAVAQ7m6sU7YzbHVywLrI7U4diEjKSip2UEuoWLLE8FgXRguoaANywtWYbr8K1GUjul
 mFLi.vNGwEQQ1ro6tkfeM2zsN3cM862iWI640wfuUIwdPyPrwdC5ZgpQv_mBdf3PHTy9yW5CtzmG
 8qJGdnRj4hU2FaJjQNcX5z7dzvp7Vxh09PqQ3aFoL8lqy9oiZxMUNbqyYmeKLFgUOEl7LlAUTTGz
 A53qCM.uTdEEaj9S6Bq.5X1iDqgfcJxRr1asy84U7oJkMBgdsQU9EKHVCeWZMKBwoQLjgh5_Zd99
 Dnz7P0Y37xIENocn1E_Nv1wnqQro3ByFL9BrqrHvPWex_UjfkjHZ1xg7Z9Pe4qjTenOywxxiJKga
 3gtW9kHZ4VbPIaKx9Tg11jCHXewx5c1oRgXrC0LjUjnXiP8jkkx9MfntEf0jdB.hteLWtWlUNarv
 j2Kqe5x4WWylMgLIeZ052ryaxoXyEPAOjWST9KFHB0zR4uPv.yRgUTi_nv8k2dKHHGMg7cwfMz_Y
 sCapLN6DxPXImF7vUNQIkDpMf6NL4yrvmML8tTt.f8ROgtipZOE1jQJQWnToFlBViRWisCN_v7rC
 Rfw_Xhp4oz19HJkpK5k5KeBcIJBZK8w_vKXgGurhsT0idOPKd4jGS3Y6sOVFR2Q0bBrvrT6j93f0
 1mO30K76oMC1gXX..gSoDz0h1_Xd0XBwqXjFlotkuprgUQtvKOOEfnpE6NKOZ8YGLDRhSPFkLY1z
 tTHYP1ZVMZ5XYNWliqQc7iLGyUeNrU6Dup2ul2TEoVDExNJkFdMbMq0B9ydUcUh1CHpSAdv5Bk9Y
 0CSG4dbxQ7g--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 11c2019e-6fcc-4a2e-8d0b-00606d5bd6c7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Mon, 13 Nov 2023 21:24:03 +0000
Received: by hermes--production-bf1-5b945b6d47-ksq7q (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0973dd5b3d849ec6c74308b376602aaf;
          Mon, 13 Nov 2023 21:23:57 +0000 (UTC)
Message-ID: <88021458-2620-4e18-b5f3-11c6e380b38c@schaufler-ca.com>
Date: Mon, 13 Nov 2023 13:23:53 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH -mm 0/4] mm, security, bpf: Fine-grained control over
 memory policy adjustments with lsm bpf
Content-Language: en-US
To: Ondrej Mosnacek <omosnace@redhat.com>, Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, linux-mm@kvack.org, linux-security-module@vger.kernel.org,
 bpf@vger.kernel.org, ligang.bdlg@bytedance.com, mhocko@suse.com,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20231112073424.4216-1-laoar.shao@gmail.com>
 <188dc90e-864f-4681-88a5-87401c655878@schaufler-ca.com>
 <CALOAHbD+_0tHcm72Q6TM=EXDoZFrVWAsi4AC8_xGqK3wGkEy3g@mail.gmail.com>
 <CAFqZXNsd5QCPQmOprf_iCCDNj8JKLjZWu3yA2=HtCYE+78F75A@mail.gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAFqZXNsd5QCPQmOprf_iCCDNj8JKLjZWu3yA2=HtCYE+78F75A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/13/2023 12:50 AM, Ondrej Mosnacek wrote:
> On Mon, Nov 13, 2023 at 4:17 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>> On Mon, Nov 13, 2023 at 12:45 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> On 11/11/2023 11:34 PM, Yafang Shao wrote:
>>>> Background
>>>> ==========
>>>>
>>>> In our containerized environment, we've identified unexpected OOM events
>>>> where the OOM-killer terminates tasks despite having ample free memory.
>>>> This anomaly is traced back to tasks within a container using mbind(2) to
>>>> bind memory to a specific NUMA node. When the allocated memory on this node
>>>> is exhausted, the OOM-killer, prioritizing tasks based on oom_score,
>>>> indiscriminately kills tasks. This becomes more critical with guaranteed
>>>> tasks (oom_score_adj: -998) aggravating the issue.
>>> Is there some reason why you can't fix the callers of mbind(2)?
>>> This looks like an user space configuration error rather than a
>>> system security issue.
>> It appears my initial description may have caused confusion. In this
>> scenario, the caller is an unprivileged user lacking any capabilities.
>> While a privileged user, such as root, experiencing this issue might
>> indicate a user space configuration error, the concerning aspect is
>> the potential for an unprivileged user to disrupt the system easily.
>> If this is perceived as a misconfiguration, the question arises: What
>> is the correct configuration to prevent an unprivileged user from
>> utilizing mbind(2)?"
>>
>>>> The selected victim might not have allocated memory on the same NUMA node,
>>>> rendering the killing ineffective. This patch aims to address this by
>>>> disabling MPOL_BIND in container environments.
>>>>
>>>> In the container environment, our aim is to consolidate memory resource
>>>> control under the management of kubelet. If users express a preference for
>>>> binding their memory to a specific NUMA node, we encourage the adoption of
>>>> a standardized approach. Specifically, we recommend configuring this memory
>>>> policy through kubelet using cpuset.mems in the cpuset controller, rather
>>>> than individual users setting it autonomously. This centralized approach
>>>> ensures that NUMA nodes are globally managed through kubelet, promoting
>>>> consistency and facilitating streamlined administration of memory resources
>>>> across the entire containerized environment.
>>> Changing system behavior for a single use case doesn't seem prudent.
>>> You're introducing a bunch of kernel code to avoid fixing a broken
>>> user space configuration.
>> Currently, there is no mechanism in place to proactively prevent an
>> unprivileged user from utilizing mbind(2). The approach adopted is to
>> monitor mbind(2) through a BPF program and trigger an alert if its
>> usage is detected. However, beyond this monitoring, the only recourse
>> is to verbally communicate with the user, advising against the use of
>> mbind(2). As a result, users will question why mbind(2) isn't outright
>> prohibited in the first place.
> Is there a reason why you can't use syscall filtering via seccomp(2)?
> AFAIK, all the mainstream container tooling already has support for
> specifying seccomp filters for containers.

That looks like a practical solution from here.


