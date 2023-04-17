Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6E56E5571
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 01:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjDQXxP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 19:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDQXxO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 19:53:14 -0400
Received: from sonic305-28.consmr.mail.ne1.yahoo.com (sonic305-28.consmr.mail.ne1.yahoo.com [66.163.185.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDB2358C
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 16:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681775592; bh=VhOKfFjIFUiUWGgrWrUxQ7LW3LNjFDTNltjxpeviTWI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=GN+XoX+CWbIr1x7VDeNjB1YGxmpb1zh6eZGuOmlxmWEIaiEZmoBt9IPYzYXvDgcWaeEy3XTs/Aew2sJ/PE23it1xvxftkwV+CCybR+wK0fjGWAvb4M9G8ECPMLzKmcUS+p6N9yQ0lN9PJdVCgYZ9LW1x+b8xT/wlLlcutzeqPCHptUoG6AakCw9Kg+RiDwPyHwF8rvGJrifOb3nBlnlnGJTpOvJVppzqfA21mMnHUqgzeMMuPCoMvlIjWnjt3PtkENuKu+WnEt7qcvoQBy096Qu164Rwy28LfHka7QTmq5Kfv8fHK45kOP1uGVtM9dwmiAaDIM//Vh+zl1fVHWotKw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681775592; bh=Ve9yuf4vJefMV/EwEY3yHcV+d6dcestZ5TG0CbvUgdm=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=uhr/HfegyWcENOAIsLHraJOCVDGdYGhsvhe+AuWqM3vHuenttxHO4pvshmIvbiHnRD2v4XdG+RyQsNMqlToO2TfP6ZQIf/neOYHLtfJYxUo4qjK/aIVduOzjeiUJ4OWyHJOtPd5qoCI9ZTBF1ePGyuFV0q1JtN5C/ekvYgGUf5numAd1ViGKNhFm8YTVu2562YexD0YVQqMkcrYgYeA223IZyQlnmJ8smeXaqAqCXDPd+bh+K+z78s90gxWjXLcjj/IW2qi2R/pWjbwKUiRsQL5SeekENZc+u2cs3sucUKEB0JDOpjb311VQgwOOSHTl03nzq5z7f42S2lOF2eJl7A==
X-YMail-OSG: hrFoY_4VM1nWraEsebtEaRqYI0yO_nI7Y.SewrSo0AsYxTMH2BeS4E2BRt7FPWM
 35bnqNUd_oXwmWtsvP1JxCqwbwC_vBVDh3cqomeNtKdMIrzQXjwdxMqiSGeGo_UYdk2CMVrcdsk8
 zAjw01mwYqxNnUe5gxOm6dv6Py6RGNrMK0Qm1NuGfKqVaXQ4dc6.SnkQr.7K96XeZzhLGbTne8Lh
 91IhoMK.iRmTUvFaHEWw5G_YpEVyBUPwHPbBs6krShce_lI53R1rlJBcqEZxbkdt9M1OT9bMABUe
 BHPIiKeCT2zkfzIK1UoGgF6YN9igJsE4p_YYlAu82e1rpdwz54F2KvVEEyDLP1hkVbR4taFHbgJ5
 Unm2OKNedLWXg_nH9C80b8BRqDFnod7POWzxEhRVkao70.dRXkVheU40N90N2idfVWu3qqJvCXz0
 vY_o40YAjS8zp_Nk5hUOP4O2MEvchBeloGYq9la_55ToHR2c3giRgEMzoDZm2rADAaeKu.9fo1p8
 4GaQplVgpAJyMNBzF8FdMehrO4.c3gsH7KAvbHr19p6f.0eqINWA.0GPWrysB2nELysJa0M50Ldi
 4frRFrWFF2Wn5DORiJ9CJjoeE6GHaHZfW_jNLhBNx7Xywln3Z6z4KJ4bKkeFmkoMJVOXFjWHLonN
 uETO1vODkFMV2MRzzqWTeccRVfF8K0Wo3KEeXSzY85G4.0V.rdtzAagy4vWAOy4h.5FfrUs_ZP4I
 Am9_dlswCqa_t9G3XTZo1CZUzf2BzQ6tXavBzujSNGaFgIMeb3QvwhjG9vCN6UqyDhD5yBUo71Sm
 7gqUtKbeyOCKym9E5OKRYRxQLgiPJwXCJKw_wbitixn1WrpBmgcxIzAGUZ.GU2M3XxmoPFm53wYw
 S6u9MtQVkqLYrDWKINE.y0rYJeCyxELrOLziDPwFjpjwE.U4khOYevYrRCIAVTTAXqXDlWCPW9zK
 N1PmaGQZwbVuKLxWPSwoHBu7hBWOfoobLm5aftsTGobCqHKAaEpRqeYRfUbM7Kdtll4xCQ4QdmII
 izCtiRbKFzmv8bW._j38wy6vDoiKDR8jhxm8vzkWJW9oyqjd7LInIBMr1OuX5b3gum2Pt38RgNRZ
 O86K.nEeGCeKJdGDpf42PdaOreMp0xfmp.TcS7_ehfwm_E.DDGoOqIKZ8VZWqWKlawJGd9kSAyCQ
 E6T3FuJS8gzLk3CAbdE3A1BVpzoeVojSIN7gpkGYbD0ZAUHcdXUoTgl0NFMtRTxE0ABa_jhjqlGy
 w98lRPo5br89sHBVEJX_6ni43dBY1IiGZIP_mgjk9GqcJB2vwUBc8yNT4qWVM_sMum7B5YGzralA
 SIKlT0Lsf9olTWoKR6q1kuZTV.Gsfz947QYpL631HwobcT6Cfu16ghyQeLqpxU2VOq1skTXN1r_a
 .IcWJb4xhnL3tOkWdiV3nSTUM17WuPwjsksTOqM5.PxBBeY3N0r4a2sUZs4dsivclWH0oPYzAgz9
 mQBroSpHl3SuvwSSfbzEuv1c7E190C0FlNW0vs_VSDV_UPLWdgmCpEoZHy3jtW9BJNJLqgB_D7xF
 q1t6IyT.gOSKPcEfFvi4hJSecA1VJzMNd0UzGFGOGlwuAlns3GVHLLQRrlxLTB23rT2wi2kR_oCk
 JdoVVy3Sn4YrZyCQ2NbhpvRYcQxlImAy8uglwqEG7hVakHDEcm9IZheUN.7cntMRJKhPgm8tAVuJ
 VhjlWMRBFe8EW4BRFdCYQMcAvbvLSf_hX4XzeR_qNPtI3feyBB4AMs3XAHmNu9mFPBDN7H34kbKr
 7BwK59VeWcYYJVXphIpngNOCFH1ukLNDMhoJQKHYH.3YGErgje_DWmheIVxbi8scOBu1e1BX1GyB
 tpGlWcipNk1zMJobffXguNUCKjyaG__g0UFGmVMZvPVQRWAP9SXkDMO336Xn7enxMowyAJJanc3s
 u_1Aa19yZk2q.SDSP_tyzZbGJukSFzTrkxH9PRD5Vbcsgq8gOy2jUlb_aOGEFVPcnHfce1JG_J43
 BFHMcruyTpfuxaaaaqlbnMyjf8p7LBK2t1sG3l485x3JiEk1EYrbR9n4OigC7pui0yGkDeTlBRNQ
 4SigDP7ZZaI3b58TL62Nqp6uwrtT9KbEsmFfHMCi9IkIKJb29AUh21_FBsgHh3WnvurX0aYGxP.C
 uRAqYl6smQM2yPMu3EAs0C8aoTHZOkda2L6oEvSRxtmJHbaeU0FCXajH1kuXNGpkATsf3JrluNF9
 S1kt.VOxN6d9ABzoir_oJ6UDSSMWX7DR8gcLJSGecxVeg7Yogr5F5kW0DWpaKXbEfTPEmYUW1LEv
 GmdLnTAn2OQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: de84e055-03be-431b-83c4-85d4c94c4832
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Mon, 17 Apr 2023 23:53:12 +0000
Received: by hermes--production-bf1-5f9df5c5c4-n84wh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 64994e488c619041bb0dccef12bb5b0d;
          Mon, 17 Apr 2023 23:53:07 +0000 (UTC)
Message-ID: <eb0a2955-0ca0-8b95-526f-3eb3dc720c26@schaufler-ca.com>
Date:   Mon, 17 Apr 2023 16:53:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH bpf-next 0/8] New BPF map and BTF security LSM hooks
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Kees Cook <keescook@chromium.org>,
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
 <afd17142-9243-8b72-d16a-41165e8deda1@schaufler-ca.com>
 <CAEf4BzaaFruReHByj_ngz+BiQmKQGeK+1DsAzg1YmVnZxfADug@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAEf4BzaaFruReHByj_ngz+BiQmKQGeK+1DsAzg1YmVnZxfADug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21365 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/17/2023 4:31 PM, Andrii Nakryiko wrote:
> On Thu, Apr 13, 2023 at 9:27 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 4/12/2023 6:43 PM, Andrii Nakryiko wrote:
>>> On Wed, Apr 12, 2023 at 12:07 PM Paul Moore <paul@paul-moore.com> wrote:
>>>> On Wed, Apr 12, 2023 at 2:28 PM Kees Cook <keescook@chromium.org> wrote:
>>>>> On Wed, Apr 12, 2023 at 02:06:23PM -0400, Paul Moore wrote:
>>>>>> On Wed, Apr 12, 2023 at 1:47 PM Kees Cook <keescook@chromium.org> wrote:
>>>>>>> On Wed, Apr 12, 2023 at 12:49:06PM -0400, Paul Moore wrote:
>>>>>>>> On Wed, Apr 12, 2023 at 12:33 AM Andrii Nakryiko <andrii@kernel.org> wrote:
>>>>>>>>> Add new LSM hooks, bpf_map_create_security and bpf_btf_load_security, which
>>>>>>>>> are meant to allow highly-granular LSM-based control over the usage of BPF
>>>>>>>>> subsytem. Specifically, to control the creation of BPF maps and BTF data
>>>>>>>>> objects, which are fundamental building blocks of any modern BPF application.
>>>>>>>>>
>>>>>>>>> These new hooks are able to override default kernel-side CAP_BPF-based (and
>>>>>>>>> sometimes CAP_NET_ADMIN-based) permission checks. It is now possible to
>>>>>>>>> implement LSM policies that could granularly enforce more restrictions on
>>>>>>>>> a per-BPF map basis (beyond checking coarse CAP_BPF/CAP_NET_ADMIN
>>>>>>>>> capabilities), but also, importantly, allow to *bypass kernel-side
>>>>>>>>> enforcement* of CAP_BPF/CAP_NET_ADMIN checks for trusted applications and use
>>>>>>>>> cases.
>>>>>>>> One of the hallmarks of the LSM has always been that it is
>>>>>>>> non-authoritative: it cannot unilaterally grant access, it can only
>>>>>>>> restrict what would have been otherwise permitted on a traditional
>>>>>>>> Linux system.  Put another way, a LSM should not undermine the Linux
>>>>>>>> discretionary access controls, e.g. capabilities.
>>>>>>>>
>>>>>>>> If there is a problem with the eBPF capability-based access controls,
>>>>>>>> that problem needs to be addressed in how the core eBPF code
>>>>>>>> implements its capability checks, not by modifying the LSM mechanism
>>>>>>>> to bypass these checks.
>>>>>>> I think semantics matter here. I wouldn't view this as _bypassing_
>>>>>>> capability enforcement: it's just more fine-grained access control.
>>> Exactly. One of the motivations for this work was the need to move
>>> some production use cases that are only needing extra privileges so
>>> that they can use BPF into a more restrictive environment. Granting
>>> CAP_BPF+CAP_PERFMON+CAP_NET_ADMIN to all such use cases that need them
>>> for BPF usage is too coarse grained. These caps would allow those
>>> applications way more than just BPF usage. So the idea here is more
>>> finer-grained control of BPF-specific operations, granting *effective*
>>> CAP_BPF+CAP_PERFMON+CAP_NET_ADMIN caps dynamically based on custom
>>> production logic that would validate the use case.
>> That's an authoritative model which is in direct conflict with the
>> design and implementation of both capabilities and LSM.
>>
>>> This *is* an attempt to achieve a more secure production approach.
>>>
>>>>>>> For example, in many places we have things like:
>>>>>>>
>>>>>>>         if (!some_check(...) && !capable(...))
>>>>>>>                 return -EPERM;
>>>>>>>
>>>>>>> I would expect this is a similar logic. An operation can succeed if the
>>>>>>> access control requirement is met. The mismatch we have through-out the
>>>>>>> kernel is that capability checks aren't strictly done by LSM hooks. And
>>>>>>> this series conceptually, I think, doesn't violate that -- it's changing
>>>>>>> the logic of the capability checks, not the LSM (i.e. there no LSM hooks
>>>>>>> yet here).
>>>>>> Patch 04/08 creates a new LSM hook, security_bpf_map_create(), which
>>>>>> when it returns a positive value "bypasses kernel checks".  The patch
>>>>>> isn't based on either Linus' tree or the LSM tree, I'm guessing it is
>>>>>> based on a eBPF tree, so I can't say with 100% certainty that it is
>>>>>> bypassing a capability check, but the description claims that to be
>>>>>> the case.
>>>>>>
>>>>>> Regardless of how you want to spin this, I'm not supportive of a LSM
>>>>>> hook which allows a LSM to bypass a capability check.  A LSM hook can
>>>>>> be used to provide additional access control restrictions beyond a
>>>>>> capability check, but a LSM hook should never be allowed to overrule
>>>>>> an access denial due to a capability check.
>>>>>>
>>>>>>> The reason CAP_BPF was created was because there was nothing else that
>>>>>>> would be fine-grained enough at the time.
>>>>>> The LSM layer predates CAP_BPF, and one could make a very solid
>>>>>> argument that one of the reasons LSMs exist is to provide
>>>>>> supplementary controls due to capability-based access controls being a
>>>>>> poor fit for many modern use cases.
>>>>> I generally agree with what you say, but we DO have this code pattern:
>>>>>
>>>>>          if (!some_check(...) && !capable(...))
>>>>>                  return -EPERM;
>>>> I think we need to make this more concrete; we don't have a pattern in
>>>> the upstream kernel where 'some_check(...)' is a LSM hook, right?
>>>> Simply because there is another kernel access control mechanism which
>>>> allows a capability check to be skipped doesn't mean I want to allow a
>>>> LSM hook to be used to skip a capability check.
>>> This work is an attempt to tighten the security of production systems
>>> by allowing to drop too coarse-grained and permissive capabilities
>>> (like CAP_BPF, CAP_PERFMON, CAP_NET_ADMIN, which inevitable allow more
>>> than production use cases are meant to be able to do)
>> The BPF developers are in complete control of what CAP_BPF controls.
>> You can easily address the granularity issue by adding addition restrictions
>> on processes that have CAP_BPF. That is the intended use of LSM.
>> The whole point of having multiple capabilities is so that you can
>> grant just those that are required by the system security policy, and
>> do so safely. That leads to differences of opinion regarding the definition
>> of the system security policy. BPF chose to set itself up as an element
>> of security policy (you need CAP_BPF) rather than define elements such that
>> existing capabilities (CAP_FOWNER, CAP_KILL, CAP_MAC_OVERRIDE, ...) would
>> control.
> Please see my reply to Paul, where I explain CAP_BPF's system-wide
> nature and problem with user namespaces. I don't think the problem is
> in the granularity of CAP_BPF, it's more of a "non-namespaceable"
> nature of the BPF subsystem in general.

Paul is approaching this from a different angle. Your response to Paul
does not address the issue I have raised.

>>>  and then grant
>>> specific BPF operations on specific BPF programs/maps based on custom
>>> LSM security policy,
>> This is backwards. The correct implementation is to require CAP_BPF and
>> further restrict BPF operations based on a custom LSM security policy.
>> That's how LSM is designed.
> Please see my reply to Paul, we can't grant real CAP_BPF for
> applications in user namespace (unless there is some trick that I
> don't know, so please do point it out). Let's converge the discussion
> in that email thread branch to not discuss the same topic multiple
> times.

I saw your reply to Paul. Paul's points are not my points. If they where,
I wouldn't have taken my or your time to present them.

>>>  which validates application trustworthiness using
>>> custom production-specific logic.
>>>
>>> Isn't this goal in line with LSMs mission to enhance system security?
>> We're not arguing the goal, we're discussing the implementation.
>>
>>>>> It looks to me like this series can be refactored to do the same. I
>>>>> wouldn't consider that to be a "bypass", but I would agree the current
>>>>> series looks too much like "bypass", and makes reasoning about the
>>>>> effect of the LSM hooks too "special". :)
>>> Sorry, I didn't realize that the current code layout is making things
>>> more confusing. I'll address feedback to make the intent a bit
>>> clearer.
>>>
>>>> --
>>>> paul-moore.com
