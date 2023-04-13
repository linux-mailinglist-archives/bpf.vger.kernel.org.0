Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD376E123E
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 18:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjDMQ1Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Apr 2023 12:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjDMQ1V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Apr 2023 12:27:21 -0400
Received: from sonic305-27.consmr.mail.ne1.yahoo.com (sonic305-27.consmr.mail.ne1.yahoo.com [66.163.185.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734E6A5C4
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 09:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681403233; bh=CdU1Ksxg5NcYtASldD9uQ9vn3rEMn6kMjP0tgp1ljDw=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=iZt8i6E3ULJtratK0wT9ozl95Nzi4KwlaLOdNeua0KCLI22w3nk0/oPBBcnP937bRmHb49biqazlVVJhutFd7WJgNgvBBh/wMerICvu/mAqjI9mlORRKzlWXakQq0XRo60PT3g7Rf8rwNoEHdTjlkfPMzQt+ZXkEgHNdhVDsKZ0vMxYdeydBIGpHcsn0/oUa/Kf2JV/QasUw5yDDGWBABdjCSv2K554a6Y7Li3Wm3rT7p1WSbPN+9NP/9nZ6UlfYgM8xPCKuUvPjVzS7H/rAEzGMp0G1gwp/o+NamcZLwm1907WlKR0KiUnBtEaoJHzrK7JZh5SBMdbQ6xDfR30Rbw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681403233; bh=1TTMi3S4V3wgHgPcG7zwiEE1Mk5Jlz1lbCVx2Uukj5B=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=gPbEzn+7Ya23zXqJ6zipd+C8i6pCyd+RqKq12zDiPY8Y53kKh31+Yx9mIdEVuCEIepC3DJzgdzJF4ELS+35OZAfCO1G+ayhUc9dNbR6aX7I4XEwO8u46ZPqA7OJzSaZkHJ/khJLZcXOWIshTD3jY4T3bl0dd7z6dKWSB9SKgvaDMakU4lU16ctrg1cbFcphrcU1WdrWvv1E/reoPivBVrrNHux289QQtT+3sJI49bbjAX3LhAywRKtJzsjUD51cyJXOU/5o43hNUhNesAJ89H4ZnL0VIpvHX/u2xVdYyIBxvEwt+FBkqAVUdRitCW+40eFqsrOwEk5lLDw/9IToPsw==
X-YMail-OSG: cdrmD1YVM1mONg0WXP8VPUcCF382cCLipZ90KrAWOnnDeVGj4vwJcS9y.gI3zI3
 Rgi99K1q9ZgpVzxIlXtHInlx3pelvPliIQGmqxv9ylD2A6K2ML6EtNWF6eYA48ex4WKDIUQ_ceo3
 5vOIgK9ZGtrRiJK6D6RwbxhEJtwp6arLE4nwO3baS1q783S4Un1lUsi.hMFzOMJTdFaD4UrA3am5
 GSNb1XVRIFt.YlES8RQC_dUcZjBexEcR20Z_GJoIH_WjTEzLZqEe9SjPQgDzTstyCz65a80SFrd1
 uFKq6MQsWfUAZd4SMTDI226WpZChFSi9RKTcKJnNmZiE9eW3PFV.AhDIsLOrVdNRI1w4tLbAv6gm
 N2wbPFTn4.HtF3G3M5XAMLHTdnKYJdpPO1joHr4oCoMMS1P_8LsZ6c_24l7fQxEIumkjE6YARcJ_
 RvH7DJQQUnDc1wY.7CLZRPKgaGapux7Z4S.VpSRx50qHALmtqj3lQDZm6UoEoPVrSdTHx3qmz0Ls
 wFGgF0c23DFBvWLSYOA3LNcv9eeVhbVnFQ65NXefYr5mSPtNVeeL4.JBoqBf3lww8Sk9fa7f1yPT
 Ncueo9hKcT0obrnerF0QwwWRHFxyNYl5zBMGRcmrQHZXyV1ADgW1LkAvi97Fmwi67crz3kj57kRp
 ojvKMZNJ1kqzKKUmxJaIDN3dRXbIiDBdTFkXHxbOyLZxTyePU1dbbyp8Dxbxefv4ZBqj4svBtq7Y
 1qTeglwqx9mGCrAvYkmEj6fIrPgDKjKHZ8kl2TtdLbLOKB01rC.NuAI126wzBAYWr5cGaCAjysh7
 .Xp1__wS6.u7.Mvgka9yAIJGEfPT_BzFWtHcodI4FVdTugxA48LO0m_Zu4ut06sDA9Ir4JTJJSQF
 Yb1qmepTNiPGpX8W87wxgAUpq25MjZpyUd_RXuUllxU5d..7rzzsrfpxDgWlu3DZc2h2xakUxyf7
 sQ_OkKJVMQGMtt0y79rei.F6lKr4WjOs60rT1T3LfcbvBc3xGlVSr1FDRR8835V3uxuZf0fskwsh
 kIt5xIMWLuIE2vYyqArXCZdIVNKqVz0EFX_v4qkT.Qe.qPgwF.Yu_wd5ClAlbQLd.MtVhqPQ7BLz
 oI5wlIClX9jgDsD78ja3.73c3pNX2OmzANzdglCX3jHKQjeG_9NilQHu72pwzXyxe_cPTVZOsiaL
 8eCCMtPuTj8RUPjCsix4BZDFm.9Qz50TEriR1v2AGiBtoiU7yLYkMy_5EODWJ_LR7AEXtTqRSDRE
 ZOGDKT7jd19kD6ZeIBPIpOHHQznUaBinw5IlW5tPJF.wDCVt9WNmkEA574XNVeDoMT3L1VnJrRsk
 wO7R7VDfDMHfQgpNytq2OBMsfEXFL4jXmZXmnEh3ap9L2tUHACgTT4gVevHPqO40iq6wyg.hRvc0
 7RVaNlAnPgxmP8EjjyM7DnzCealKLvcs9nYzRYKrFlf9GVKHP1FpkRyLCNlx2HdmXfOXbdvAUmfw
 cVjtQ0dhQRfTsiCNxeLc.18gGOYFPFzCe4LOdUQ.58qByhJXQ9OXUW5.ezvRvDmvcY1AYrGm4uy3
 Hkeop1rf6SJ3XNay9FZwVrantuGn4jvZWKeBhPUVFXoA13cMO1cz.H3nTVNkbVNPF4s58WfXaxG5
 YnFeSWiVsO81Bx3qfieR.rvwVRY8bdmHidMQbOK2cekJyaq8.JO1dLmrL5RsNtXeHwyJfLK0Zl5C
 oAqSTnV8KcH.8Q0Q3P3aUAy5LKEv2zsy2j13eBf_kPKhLGTENqiEB3LQpbIru86yKEBEfXem7b90
 p6rXNeamrauIl9oZr9f2xwAWmhhCQi9sK40aGomZ.53l.9wVoPz2hyPtZxYMk5dAMjyYvxghC7rv
 vDVkIPn3F9UW6HmioAgDafa_hi5O9n9oQfHlDqPa89C.Ok0KXn5H.rWTId0ymXTolO.kI7Gm9BYS
 11xw1ZHTdQoNC6SOzBraieDgleLxdJauRU3tc8PAWKXa5oRGgVCo0by_hZKBUowmfB0lEnnw6778
 5CLhbb2r7WVYnJPPjwiUQ5bhSmtxXBKSAp_tNMM79mExuMDV.AOfDU0jHouOHV1KgZccA3PX1ahD
 dg2JhIp678sstJgSpY0u45FuwA__E3Hao6TeYh3W4kdRwmqomyFJOfoMhZh0C05zJ28o6qu5L0sr
 5xhmR0YefWiXGHuGJ6fXoLidHdv8KTPzo_omMRULw7RKCmZBjgEfxWiSPsY9CCCxUuaWptw.q6FA
 ZyWgos9QgxfoHw.4s0PDK_nARHy0hn2pWOSgeKMrThWlXM5v7KRcboFQS6fo4Fw1KW.73UTKu5W5
 lBBpJDvQE2tJ5aJwCQlJf
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: fac2b4e3-efd6-4499-9325-9f03ca846f35
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Thu, 13 Apr 2023 16:27:13 +0000
Received: by hermes--production-bf1-5f9df5c5c4-8dccp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6b73db0fc8977652a8f02cdda1c40c96;
          Thu, 13 Apr 2023 16:27:11 +0000 (UTC)
Message-ID: <afd17142-9243-8b72-d16a-41165e8deda1@schaufler-ca.com>
Date:   Thu, 13 Apr 2023 09:27:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH bpf-next 0/8] New BPF map and BTF security LSM hooks
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20230412043300.360803-1-andrii@kernel.org>
 <CAHC9VhQHmdZYnR=+rX-3FcRh127mhJt=jAnototfTiuSoOTptg@mail.gmail.com>
 <6436eea2.170a0220.97ead.52a8@mx.google.com>
 <CAHC9VhR6ebsxtjSG8-fm7e=HU+srmziVuO6MU+pMpeSBv4vN+A@mail.gmail.com>
 <6436f837.a70a0220.ada87.d446@mx.google.com>
 <CAHC9VhTF0JX3_zZ1ZRnoOw0ToYj6AsvK6OCiKqQgPvHepH9W3Q@mail.gmail.com>
 <CAEf4BzY9GPr9c2fTUS6ijHURtdNDL4xM6+JAEggEqLuz9sk4Dg@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAEf4BzY9GPr9c2fTUS6ijHURtdNDL4xM6+JAEggEqLuz9sk4Dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21365 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/12/2023 6:43 PM, Andrii Nakryiko wrote:
> On Wed, Apr 12, 2023 at 12:07 PM Paul Moore <paul@paul-moore.com> wrote:
>> On Wed, Apr 12, 2023 at 2:28 PM Kees Cook <keescook@chromium.org> wrote:
>>> On Wed, Apr 12, 2023 at 02:06:23PM -0400, Paul Moore wrote:
>>>> On Wed, Apr 12, 2023 at 1:47 PM Kees Cook <keescook@chromium.org> wrote:
>>>>> On Wed, Apr 12, 2023 at 12:49:06PM -0400, Paul Moore wrote:
>>>>>> On Wed, Apr 12, 2023 at 12:33 AM Andrii Nakryiko <andrii@kernel.org> wrote:
>>>>>>> Add new LSM hooks, bpf_map_create_security and bpf_btf_load_security, which
>>>>>>> are meant to allow highly-granular LSM-based control over the usage of BPF
>>>>>>> subsytem. Specifically, to control the creation of BPF maps and BTF data
>>>>>>> objects, which are fundamental building blocks of any modern BPF application.
>>>>>>>
>>>>>>> These new hooks are able to override default kernel-side CAP_BPF-based (and
>>>>>>> sometimes CAP_NET_ADMIN-based) permission checks. It is now possible to
>>>>>>> implement LSM policies that could granularly enforce more restrictions on
>>>>>>> a per-BPF map basis (beyond checking coarse CAP_BPF/CAP_NET_ADMIN
>>>>>>> capabilities), but also, importantly, allow to *bypass kernel-side
>>>>>>> enforcement* of CAP_BPF/CAP_NET_ADMIN checks for trusted applications and use
>>>>>>> cases.
>>>>>> One of the hallmarks of the LSM has always been that it is
>>>>>> non-authoritative: it cannot unilaterally grant access, it can only
>>>>>> restrict what would have been otherwise permitted on a traditional
>>>>>> Linux system.  Put another way, a LSM should not undermine the Linux
>>>>>> discretionary access controls, e.g. capabilities.
>>>>>>
>>>>>> If there is a problem with the eBPF capability-based access controls,
>>>>>> that problem needs to be addressed in how the core eBPF code
>>>>>> implements its capability checks, not by modifying the LSM mechanism
>>>>>> to bypass these checks.
>>>>> I think semantics matter here. I wouldn't view this as _bypassing_
>>>>> capability enforcement: it's just more fine-grained access control.
> Exactly. One of the motivations for this work was the need to move
> some production use cases that are only needing extra privileges so
> that they can use BPF into a more restrictive environment. Granting
> CAP_BPF+CAP_PERFMON+CAP_NET_ADMIN to all such use cases that need them
> for BPF usage is too coarse grained. These caps would allow those
> applications way more than just BPF usage. So the idea here is more
> finer-grained control of BPF-specific operations, granting *effective*
> CAP_BPF+CAP_PERFMON+CAP_NET_ADMIN caps dynamically based on custom
> production logic that would validate the use case.

That's an authoritative model which is in direct conflict with the
design and implementation of both capabilities and LSM.

>
> This *is* an attempt to achieve a more secure production approach.
>
>>>>> For example, in many places we have things like:
>>>>>
>>>>>         if (!some_check(...) && !capable(...))
>>>>>                 return -EPERM;
>>>>>
>>>>> I would expect this is a similar logic. An operation can succeed if the
>>>>> access control requirement is met. The mismatch we have through-out the
>>>>> kernel is that capability checks aren't strictly done by LSM hooks. And
>>>>> this series conceptually, I think, doesn't violate that -- it's changing
>>>>> the logic of the capability checks, not the LSM (i.e. there no LSM hooks
>>>>> yet here).
>>>> Patch 04/08 creates a new LSM hook, security_bpf_map_create(), which
>>>> when it returns a positive value "bypasses kernel checks".  The patch
>>>> isn't based on either Linus' tree or the LSM tree, I'm guessing it is
>>>> based on a eBPF tree, so I can't say with 100% certainty that it is
>>>> bypassing a capability check, but the description claims that to be
>>>> the case.
>>>>
>>>> Regardless of how you want to spin this, I'm not supportive of a LSM
>>>> hook which allows a LSM to bypass a capability check.  A LSM hook can
>>>> be used to provide additional access control restrictions beyond a
>>>> capability check, but a LSM hook should never be allowed to overrule
>>>> an access denial due to a capability check.
>>>>
>>>>> The reason CAP_BPF was created was because there was nothing else that
>>>>> would be fine-grained enough at the time.
>>>> The LSM layer predates CAP_BPF, and one could make a very solid
>>>> argument that one of the reasons LSMs exist is to provide
>>>> supplementary controls due to capability-based access controls being a
>>>> poor fit for many modern use cases.
>>> I generally agree with what you say, but we DO have this code pattern:
>>>
>>>          if (!some_check(...) && !capable(...))
>>>                  return -EPERM;
>> I think we need to make this more concrete; we don't have a pattern in
>> the upstream kernel where 'some_check(...)' is a LSM hook, right?
>> Simply because there is another kernel access control mechanism which
>> allows a capability check to be skipped doesn't mean I want to allow a
>> LSM hook to be used to skip a capability check.
> This work is an attempt to tighten the security of production systems
> by allowing to drop too coarse-grained and permissive capabilities
> (like CAP_BPF, CAP_PERFMON, CAP_NET_ADMIN, which inevitable allow more
> than production use cases are meant to be able to do)

The BPF developers are in complete control of what CAP_BPF controls.
You can easily address the granularity issue by adding addition restrictions
on processes that have CAP_BPF. That is the intended use of LSM.
The whole point of having multiple capabilities is so that you can
grant just those that are required by the system security policy, and
do so safely. That leads to differences of opinion regarding the definition
of the system security policy. BPF chose to set itself up as an element
of security policy (you need CAP_BPF) rather than define elements such that
existing capabilities (CAP_FOWNER, CAP_KILL, CAP_MAC_OVERRIDE, ...) would
control. 

>  and then grant
> specific BPF operations on specific BPF programs/maps based on custom
> LSM security policy,

This is backwards. The correct implementation is to require CAP_BPF and
further restrict BPF operations based on a custom LSM security policy.
That's how LSM is designed.

>  which validates application trustworthiness using
> custom production-specific logic.
>
> Isn't this goal in line with LSMs mission to enhance system security?

We're not arguing the goal, we're discussing the implementation.

>>> It looks to me like this series can be refactored to do the same. I
>>> wouldn't consider that to be a "bypass", but I would agree the current
>>> series looks too much like "bypass", and makes reasoning about the
>>> effect of the LSM hooks too "special". :)
> Sorry, I didn't realize that the current code layout is making things
> more confusing. I'll address feedback to make the intent a bit
> clearer.
>
>> --
>> paul-moore.com
