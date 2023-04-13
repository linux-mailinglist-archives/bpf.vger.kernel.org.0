Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622F56E12D4
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 18:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjDMQyn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Apr 2023 12:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjDMQyl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Apr 2023 12:54:41 -0400
Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8068E10D5
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 09:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681404879; bh=uL4i+mvJ8owpLtkmkFLMdfh6p9NUnl0DLCqy7qlzvFk=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=fW795Y//9SZQrbN7lE2vvJunT8BgsdXN3hSl8MygRIc4R4xDJm7U0LXIsLwtC632Hw3Lf5LZz4HNTgEny+Hzq1+BJvNf97v0mSvkdd8P/sFTs6Sjul57EptheTiTX8UYNdysqBNq/SwJ/2HSLRgJsBNH+eminR3zcMNS+ftmlp+11qDWaJhnMmYnXiEHEKnP2ntemxW18Njq4bZSF45L2C08IT8xrQnu3o9FM7QLMlQVkwn1M2ILcT+HnOqdwiPo3OG2/kIjISQT+lwYdFRsxEJIoKLF6gV7BARz0oMGv2CIIys7Ym/L8Lpz7RHSk6lIixR5wk631sCrIELCI+F3YQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681404879; bh=NlUfsLgp7qEE/yMjtMXrWk/C9EzB3SgUbOQH8bTUy5o=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=oGlsMAFjeXYyJfrkJTqQvC9xGAnj1eTMYqA/rrNWH9QNsSuB1s0GBkkD+SAIQd70eICjWYnA8dijYGnAzw2YuufZd3BczMIr9ogMNTJEOFsKU9HFCxi7F9nkqDhO/cb32bKB5yS39CvDr0FcDAAYT+f3rZUvukaMqc0jhpFjI+99BO7sZpX87x+7IUENsNskW0BNPrR3HN9swxTAysF7oSkAkK86tWs+aGxDk5zr19YUWZxj3iuGganWXsqgSHL3rL2ar+nPEIii/D/Nulxt0VAVuxswyISrmNsVatGI7sDDFzbSiWWDnOuVd4vrNNnDE788diWI+nr5tJKtWUH38A==
X-YMail-OSG: OxF3WDAVM1nSjb0lRWOA5yfvJ1Z99xXAlEvUxl89Md1mj4KIPHa0_9EtVjKo0rP
 zZmJff6uGvqeoNpMiGzaFixgd0bLFhdA2yvHsahbOf04l6cYGlUtG0ARl19lrHOQNLZ5nJiUrB3j
 GRn_96CIiZ04JlnKNc_Z40WLaLvJ4Un968ILdXcMJrxyB7.m.pW0VKSohKRRZVoTxlO1WaCP6_KX
 HJN.f7QkBH7PBC1wbaoUMxHGGcTsMqUDGeugL1rQctYuOSmNqTlQCzOunXfIg2e4nUkONmJmqYes
 8gKPQ0gP6CLh2akaS6Dl6NmC4f2xgEZWg6vSGs3NrZAiUYQcJAX48XtDyN9FUsh3g0jDYiXsIwzk
 owJ2wyOtZWKWJbLEpo45hKL9yuYUe_XyO5NKPMhQCQLDRhER0snNokbYSj8n14prk7nQ2DXuJkEL
 B5gsdU6BHXG1uzimWauTbc7n2S.P9TFjhi7iBKvwqV698SKc3sE3X0ZNKoqMbV98oM4XaqxM2KkX
 gyCVESt32wOlEpXpe4fAVhLnAwFj76EpYLdeACpry7OfbUkAnsM.DIs9lwDcehk5O8Tf91j.QG_f
 iApBEsc3Da6Nh6n_oShDOb7ayylF15qXcwtYGGgrOpabAgCreeWmlaMJwFyb8eR9rKHtUetYMGyK
 vPwsnaIFNsvx_cIAEmW89WS4XPPlEOBFBwvsVDhb6KaRKKasKaPjcpDZkJNlgp8QX9fc0PbZi0mv
 7yFhScp_T8r4VK83m1e328CW6jODQEJQ0ddutttMJxvEjylvLKXJQnikpZEQsd5hGwk8tEwkhjjR
 hm3U9DFfhz929uVBXQy6.WY5V4mAyB8j_b5dB7RG0yWjkjoCoT2RNHdhpgi0u5r4to.9RTBbloHC
 6z7DCV1bAyJeRsIPm7.Q_7v2VluLqyQaSGtTjK4NWRbN_YberIadr5hHW0DV8J4lIJUtBSYfKdKO
 l_Z2N7g9.ogMbMXpYxWSZ0E.YNCEXtewRVrNNP6Q7j41XxU3toZLFJ9T8WS0W2bhQ08MSZmZNW9L
 E8lw2Ehzej9RYumvcjZ46gp.qwhcQUR5NHf_4mVmyP5IsskyTdoVHJ32XQsUkSdbCoOCvW0n43dR
 Q8s5uxehehzDyTRp8YEFS72AXGcFtIIewzOK4fR2xQSi5nhT6zki_GSYmSon5ft_L5YnXQTjri2C
 hrIeOHfwCsPvScGAZxJUDbe2VtJ0x_kr9Ogc8kH2OUdz.m8HMnVeqg5I2A0jLwdS5LmhyW13iklP
 06A7pjdzv2CD1kESZOzQW8uySKM6pWe2PoI0MevI8HpCCwico57CunjDoILjhuCMrf2o5JdvJ8.U
 MBi_pQA2hQ20rX90tH7T4BW3qb.cwS1mYzZ3VHuDj5A2J4Zc9P7j.ulkbW7G0su2OW_lzztx1ibn
 TVVzaOUwoYCD9Nx9pZAZC7tIyw1ZEOi30SRb2rqbiIu3dSRSIqkf7Uz.NTwMZUBVEkXCMdmWsBtc
 ke0petiyQFHSASUUB7NLYFuG8vjRfcwAd183uG9hqp8h.oBln5ZA.52ZuS_82mIS09fRGXP6oOdj
 45zQKOqUHMcVwsbPVk2xdV_4xYWyJlUlalRI4kpg93DFr9Tq6mkpQbs2LdURNUEEDXhlelV2jEFV
 aKwDVUNr5Bq7RZaKNuPvOYkm9G.jcXVtMYdbw.tOVn18L30p5hYAGZbb323YoxZrAcI211.vod1_
 Ro8Ivch3jysW8sg8v_Vj5.1yeNS.wVnA5mjoYp_J83wwOjfTyIbje9HJ687YSnyur9nFVPFAhDPb
 PfLaexSKRKVDidaDAe_EUJlSmcNO4vLeGPbicWurSmNSahAZnAcvjJmKGZuCWmSSxQdAnwf6N37z
 E25iUA9P8T.AgbVK5ZHSLLpCWPqIIcjaGcb4UCbPjfwOa3sXD_vhh2D4mSNu4wwvFiYhO2XaGxG9
 OQK7CLTuGA_BPxhmBXgFo0rgcQuc7UnSFajBtArnvAnt6XrS5lBkph3MnOs9ew2NOFLQNop5ebmV
 k72PX.w_JZ69N1kgTmYVI6O2HUDUmuv6XXUJ.fR_ifJEs18DpaktO3eA1ubjCCeqUukTgcBO3VJ9
 yO3t03gtD_eNNY._8HXddz5PU2dDlzh9h5CH43hcfTSrBSS_bVjqP.gWQuCyJ3mX_ksxD5j4nflU
 O_BYAXJ6nyyTiM9ECVzA_LKvHozZSpyFJQFYDDlGqc7uLfXfHSfxQecP.HjC3O0axwVy6T4O.Swh
 7h3Pt_vW1ZqfZokNem4hH87x5hu7ZXT7alSxMHwF6tBjX4_cDtgEipxjVue7EyA.769j12t.VvYo
 C_T4zfSh6KLWHF7H2dw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: afb3c4d6-e6ec-4c7f-a87e-30ded034c10f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Thu, 13 Apr 2023 16:54:39 +0000
Received: by hermes--production-bf1-5f9df5c5c4-n84wh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5998b5f08e35352e94dff041949f9773;
          Thu, 13 Apr 2023 16:54:33 +0000 (UTC)
Message-ID: <5eba6259-f214-becf-ac8f-0981d9fe7bda@schaufler-ca.com>
Date:   Thu, 13 Apr 2023 09:54:30 -0700
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
 <CAHC9VhT8RXG6zEwUdQZH4HE_HkF6B8XebWnUDc-k6AeH2NVe0w@mail.gmail.com>
 <CAEf4BzaRkAtyigmu9fybW0_+TZJJX2i93BXjiNUfazt2dFDFbQ@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAEf4BzaRkAtyigmu9fybW0_+TZJJX2i93BXjiNUfazt2dFDFbQ@mail.gmail.com>
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

On 4/12/2023 10:16 PM, Andrii Nakryiko wrote:
> On Wed, Apr 12, 2023 at 7:56 PM Paul Moore <paul@paul-moore.com> wrote:
>> On Wed, Apr 12, 2023 at 9:43 PM Andrii Nakryiko
>> <andrii.nakryiko@gmail.com> wrote:
>>> On Wed, Apr 12, 2023 at 12:07 PM Paul Moore <paul@paul-moore.com> wrote:
>>>> On Wed, Apr 12, 2023 at 2:28 PM Kees Cook <keescook@chromium.org> wrote:
>>>>> On Wed, Apr 12, 2023 at 02:06:23PM -0400, Paul Moore wrote:
>>>>>> On Wed, Apr 12, 2023 at 1:47 PM Kees Cook <keescook@chromium.org> wrote:
>>>>>>> On Wed, Apr 12, 2023 at 12:49:06PM -0400, Paul Moore wrote:
>>>>>>>> On Wed, Apr 12, 2023 at 12:33 AM Andrii Nakryiko <andrii@kernel.org> wrote:
>> ...
>>
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
>>> than production use cases are meant to be able to do) and then grant
>>> specific BPF operations on specific BPF programs/maps based on custom
>>> LSM security policy, which validates application trustworthiness using
>>> custom production-specific logic.
>> There are ways to leverage the LSMs to apply finer grained access
>> control on top of the relatively coarse capabilities that do not
>> require circumventing those capability controls.  One grants the
>> capabilities, just as one would do today, and then leverages the
>> security functionality of a LSM to further restrict specific users,
>> applications, etc. with a level of granularity beyond that offered by
>> the capability controls.
> Please help me understand something. What you and Casey are proposing,
> when taken to the logical extreme, is to grant to all processes root
> permissions and then use LSM to restrict specific actions, do I
> understand correctly?

No. You grant a process the capabilities it needs (CAP_BPF, CAP_WHATEVER)
and only those capabilities. If you want additional restrictions you include
an LSM that implements those restrictions. If you want finer control over
the operations controlled by CAP_BPF you include an LSM that implements
those controls.

>  This strikes me as a less secure and more
> error-prone way of doing things. If there is some problem with
> installing LSM policy,

LSMs are not required to have loadable or dynamic policies. That's
up to the developer.

>  it could go unnoticed for a really long time,
> while the system would be way more vulnerable.

There is no way Paul or I are going to solve the mis-configured system
problem.

>  Why do you prefer such
> an approach instead of going with no extra permissions by default, but
> allowing custom LSM policy to grant few exceptions for known and
> trusted use cases?

Because that's not how capabilities work. Capabilities are independent
of other controls. If you want to propose a change to how capabilities
work, you need to propose that to the capability maintainer.

Because that's not how LSMs work. LSMs implement additional restrictions
to the existing policy. The restrictive vs. authoritative debate was closed
long ago. It's a fundamental property of how LSMs work.

> By the way, even the above proposal of yours doesn't work for
> production use cases when user namespaces are involved, as far as I
> understand. We cannot grant CAP_BPF+CAP_PERFMON+CAP_NET_ADMIN for
> containers running inside user namespaces, as CAP_BPF in non-init
> namespace is not enough for bpf() syscall to allow loading BPF maps or
> BPF program (bpf() doesn't do ns_capable(), it's only using
> capable()). What solution would you suggest for such production
> setups?

If user namespaces don't work the way you'd like, you should take that
up with the namespace maintainers. Or, since this appears to be an issue
with BPF not being namespace aware, fix BPF's use of capable() and ns_capable().

> Also, in previous email you said:
>
>> Simply because there is another kernel access control mechanism which
>> allows a capability check to be skipped doesn't mean I want to allow a
>> LSM hook to be used to skip a capability check.
> I understand your stated position, but can you please help me
> understand the reasoning behind it? What would be wrong with some LSM
> hooks granting effective capabilities?

You keep asking the question and ignoring the answer. See above.

>  How would that change anything
> about LSM design? As far as I can see, I'm not doing anything crazy
> with my LSM hook implementation.

You keep asking the question and ignoring the answer. See above.


>  It's reusing the standard
> call_int_hook() mechanism very straightforwardly with a default result
> of 0. And then just interprets 0, <0, and >0 results accordingly. Is
> that abusing the LSM mechanism itself somehow?
>
> Does the above also mean that you'd be fine if we just don't plug into
> the LSM subsystem at all and instead come up with some ad-hoc solution
> to allow effectively the same policies?

No, because you would be breaking the capability system in that case.

There is an example of a feature that does just what you're suggesting.
POSIX ACLs aren't an LSM because they don't just add restrictions, they
change the semantics of the file mode bits. Look at that implementation
before you seriously consider going that route.

>  This sounds detrimental both
> to LSM and BPF subsystems, so I hope we can talk this through before
> finalizing decisions.
>
> Lastly, you mentioned before:
>
>>>> I think we need to make this more concrete; we don't have a pattern in
>>>> the upstream kernel where 'some_check(...)' is a LSM hook, right?
> Unfortunately I don't have enough familiarity with all LSM hooks, so I
> can't confirm or disprove the above statement. But earlier someone
> brought to my attention the case of security_vm_enough_memory_mm(),
> which seems to be granting effectively CAP_SYS_ADMIN for the purposes
> of memory accounting. Am I missing something subtle there or does it
> grant effective caps indeed?
>
>
>
>
>> --
>> paul-moore.com
