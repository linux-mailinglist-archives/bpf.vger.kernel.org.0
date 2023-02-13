Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694AC694F60
	for <lists+bpf@lfdr.de>; Mon, 13 Feb 2023 19:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjBMSaN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Feb 2023 13:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjBMSaI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Feb 2023 13:30:08 -0500
Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B080AD02
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 10:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1676312951; bh=kDBXYlsFu4+RlWBTZxfxcgS32waSMhNsfRAKzly4Aas=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=bDEIbEzmWwOCz5684e1EX+h7B27sP/rtpFLSjpdlmTEp9f61pD4iONQO6A+EtDr9Y3aiUuQ6obfuXouJeINIpRyIAMhWDb91rMvzo/9Tb+ANa/Vu70TBjChYgZJ2190skidf5uOYlJeK7R6suhTVog3WdaiuytmMvgqwCPFf9DAnqWnTCjKfWnqGVzSy/V7D9jegL1at1MdH0obPAKVnf6mnUZ8gdmk/fHcps0c2zkP1DCG6jCJJFyo514ZNoQbAf6TnZbXto7zb4uv8Xv7Q7PLmGB7uaZWQjLW7pCVS4g7Oy9UK1mUhx/VkFHc//C5R3nncueugVHXERYTyBYCzoA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1676312951; bh=fQsx59JOPN4X7LWIKKL+56dSqwwjsAAjg+IQkVi7Mdf=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=XgfvnKpbCAorSKk0gCy0rEmSua3gFJXbIv2FBjQEExp15Fg94tKgshxKmch3OSilC3/pVMd8DHEflS9T2Reli9sjWlJGCruFBWmZlG6Kie/N0nflrXdTnSfVj6s3sB1hR4QczlB8wpVPs8q1y4zEXLv98cwgdkLoPexIE0qgezGPc0Yzu1G7ZrQ6qZuj78j8xU02xCathm0NETV3V4SYhzJmkYqcZjYYHK8gtBb4UCMzBARyUjbLx/aDvfpsnsv9KJZws1jUg/bgSn+Cp3LPP9hUKgYkfZ5Ve3qaPh4AZghE5Bxl0hIpYbUSgOtFGr0cchopP+YlBofI/snpvV4a6g==
X-YMail-OSG: DW35OWIVM1nmWSmPHDC477Qsa1qPdymFe_jef6uPbRBuJ3X_2Bdh7jbsHA3ESBs
 .DeIJry3_UXsRfRWlbYVoUtRMDL1u4lc7CXUzRTgGOPjYYEIvx8BZ_cFLFVQIC9CPUg7ThhfwvZ5
 aECg6NgPNBx1vccr3jDC3zLbmMPHtYBPXg7JQRAATe0p4ng5xVk1ik.5TTJXH0Q64TvcLlk5dKLG
 _S035f9ESnp3qF5aa0.RcW5HknYNllqEPUFbLiO7PyegV_FwePMWzMwJS6_L5jPxMS97H8Ge.__U
 5d5Tfbd8YEPJ7TOOPW3R3wG_iBaScY4o7xJD7X5mWXKHiwXZtkp2FwrDCCUq9OtQcevDB3pM6DhN
 QSP5FayiKLf4WQ0IMMMytsy3ks8avoFj5fFj1jjMtTybw1mJns1PsH36rIMNK3TrkkR5sVgyX1.D
 hDDGKF1FucKSqnCEN.KVOj5NfIcqUycVUqLnUhYxG57.7UR1huSC_.TDezIlEUutIJfnEAT7mcZ4
 QCyYwu_NcrwSvjxhyGXkDU.f2FH9mjuDHcFmxePa4fBq7hGPT0enjhis_2nsXocz4b2gpzRQwp4Y
 .kU.bTZ9RXm5bC9BuUglF51R9yB4Tipz81YW4RL7BufmECwdZBd8NwKla0iplm0LSR7Um4rz7xJG
 z5UH_sT.iAUQ4S6pwZAeUsvc8lmOfJfQGAtwMrdRDjzJzSm7fzWnJCeNzBDnYAupNO.67UkbnUx4
 t34H6cJbtl3I.vRCbd_N6vsq.CnMYN.tuxfRS05hB_d4KbC8BiBLfzpX2R32XSq7eMKwZ4TYNj2R
 USfNdYYIXHwfKXCZWOexOH0SMkBwX6iVpGrvQWRwSHXYFbOZzCbZhMyB.zhHMBMPRaspkzYlznQg
 sJAV.sYufoxQ6nn4oI8u2ngSkiLJYp.wGa9yzPfyw.RWhs4XJB8vxP5xuix4CxOTemsf2N.A1Xjv
 ChKQ4CrJ3SZbD1bb4YA_fK2gc3cCa868AH9UXdfcTmrnUzxYKU1VxF0zDVscJkoplnGz3iYfnIGj
 YmXzeHzUrq6eFjvlBdMsG5.lv5K6Nxz1LPCAMetciN.5hW0jGEy2oQS0yV.14Mu.eiTerIew3wIY
 Y3qHwLMQsx.f5lFWsYrsRsGD6Q.zEdheX.SPDSBRyj5fmZlx85TalUWd3PVv51Pp7WsXBTrKbyFO
 uAHMRXbW3xJrcK.0BAdHWEjIJOU4bQRuru7Q8dHup78bjuSxfZ6erNbV92wul8.slUEB1Ad8deY_
 zWcmBuFN1GV1cb1KZEw_gIZ.YIbhuJctIE2pvsU5R489vKoA0VIs9.kNJDEV1xZdj6529HENSHsy
 w.0ejLP9Ckn0z.VIBKlpL3eC9bAwwbqUkK0ULhXpmsG_5CuOXwCdCTXNPat4bBKbzQjcArFPWb9D
 w0.8RupKMhYcOki3GhLOJSTmg2bsZlEfHaDqg7N_hsCR5lHrPbyhLSoIY5zUNe3mx_0SKLdhsH6n
 ODSwQM3DBOC5QD55TDpjTsqUElh1njAUoScoqKK4isqJUIauYPm7DBJoXIqs5mMWaf_Eo6qZCklt
 WC.EwcUk7UYVtBMUjQPtcy8vpwZDsbIkQhgeaggHU8HYrLmNrvz5ZY3O08vSMggTUrHanqrkriiF
 7OYWo0gvu5UvcHLgdHPRxBJqck08QXOYUSt9B1j2akZX7HBe3mJ9bBgqqVDc8AoIG_obA6KGAtC2
 N62JJM1vE8I6lWbEI4MIgo7dYaAe6OZ5aRmU9ceNL8ssQDzu1ILA9NmEUTUO2t3fsqwqRcUoTPwq
 V3s9UtJGExO4nmqwBFyj.xv2ikHJSrIlnagWJYPp8t69AL76MOhMUoWG30ClnswyDFN0c_Gh1lAu
 yhI54deX8ukivMkdtJ6zmb23D58KXzXwjJXU4WB7lylNWrnzvEHyExZqQMcOPRR8n2ll4_e1ket2
 O2ClkVXBkHOcjHY_QvURP6k7DvYPbTzDnCDwpMcE4kLLRih2hkJTPa5vwjr1D_ypPcb8WGfU5qV.
 wC4zdxG7esCWuto3i6VgDhKrL1OdrofmN_36kiKqHhEK8bFXeIsdGV3eREAPU01LPPRjB25QqYux
 CeKac1C27Th6RSeuQDWh5LvBPM.zyOLttDxXjkEgCkEL0ftE9b7e8eh6NUQxH9AicDZJVUThXGxx
 Mdo42HNYYWdcuOkI0ZixjtNfhZlMbImVOwBqdRCjGDTBArtkjCbM8j029pk0_bUdW09SB0QizpHm
 NOM9k6xnpgYozLiqudLwDcXpKx9DMBA--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Mon, 13 Feb 2023 18:29:11 +0000
Received: by hermes--production-gq1-655ddccc9-zfzhj (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b8c1300af8bfc82838ee07ea3d1e6045;
          Mon, 13 Feb 2023 18:29:07 +0000 (UTC)
Message-ID: <be87a5c2-5766-1096-11cb-e0910a9fa7d4@schaufler-ca.com>
Date:   Mon, 13 Feb 2023 10:29:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH bpf-next 0/4] Reduce overhead of LSMs with static calls
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     Kees Cook <keescook@chromium.org>, KP Singh <kpsingh@kernel.org>,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, jackmanb@google.com,
        renauld@google.com, song@kernel.org, revest@chromium.org,
        casey@schaufler-ca.com
References: <20230119231033.1307221-1-kpsingh@kernel.org>
 <CAHC9VhRpsXME9Wht_RuSACuU97k359dihye4hW15nWwSQpxtng@mail.gmail.com>
 <63e525a8.170a0220.e8217.2fdb@mx.google.com>
 <CAHC9VhTCiCNjfQBZOq2DM7QteeiE1eRBxW77eVguj4=y7kS+eQ@mail.gmail.com>
 <98799a20-1025-3677-d215-69b13ac73ee5@schaufler-ca.com>
 <CAHC9VhTo=VDuFFfX7o__CRwbHTT-OTDBQ090-ZwbTRQYdO-_Gg@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhTo=VDuFFfX7o__CRwbHTT-OTDBQ090-ZwbTRQYdO-_Gg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21183 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/12/2023 2:00 PM, Paul Moore wrote:
> On Fri, Feb 10, 2023 at 9:32 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 2/10/2023 12:03 PM, Paul Moore wrote:
>>> On Thu, Feb 9, 2023 at 11:56 AM Kees Cook <keescook@chromium.org> wrote:
>>>> On Fri, Jan 27, 2023 at 03:16:38PM -0500, Paul Moore wrote:
>>>>> On Thu, Jan 19, 2023 at 6:10 PM KP Singh <kpsingh@kernel.org> wrote:
>>>>>> # Background
>>>>>>
>>>>>> LSM hooks (callbacks) are currently invoked as indirect function calls. These
>>>>>> callbacks are registered into a linked list at boot time as the order of the
>>>>>> LSMs can be configured on the kernel command line with the "lsm=" command line
>>>>>> parameter.
>>>>> Thanks for sending this KP.  I had hoped to make a proper pass through
>>>>> this patchset this week but I ended up getting stuck trying to wrap my
>>>>> head around some network segmentation offload issues and didn't quite
>>>>> make it here.  Rest assured it is still in my review queue.
>>>>>
>>>>> However, I did manage to take a quick look at the patches and one of
>>>>> the first things that jumped out at me is it *looks* like this
>>>>> patchset is attempting two things: fix a problem where one LSM could
>>>>> trample another (especially problematic with the BPF LSM due to its
>>>>> nature), and reduce the overhead of making LSM calls.  I realize that
>>>>> in this patchset the fix and the optimization are heavily
>>>>> intermingled, but I wonder what it would take to develop a standalone
>>>>> fix using the existing indirect call approach?  I'm guessing that is
>>>>> going to potentially be a pretty significant patch, but if we could
>>>>> add a little standardization to the LSM hooks without adding too much
>>>>> in the way of code complexity or execution overhead I think that might
>>>>> be a win independent of any changes to how we call the hooks.
>>>>>
>>>>> Of course this could be crazy too, but I'm the guy who has to ask
>>>>> these questions :)
>>>> Hm, I am expecting this patch series to _not_ change any semantics of
>>>> the LSM "stack". I would agree: nothing should change in this series, as
>>>> it should be strictly a mechanical change from "iterate a list of
>>>> indirect calls" to "make a series of direct calls". Perhaps I missed
>>>> a logical change?
>>> I might be missing something too, but I'm thinking of patch 4/4 in
>>> this series that starts with this sentence:
>>>
>>>  "BPF LSM hooks have side-effects (even when a default value is
>>>   returned), as some hooks end up behaving differently due to
>>>   the very presence of the hook."
>> My understanding of the current "agreement" is that we keep BPF
>> hooks at the end for this very reason.
> It would be nice to not have these conventions.  I get that it's the
> only knob we have at the moment to tweak, but I would hope that we
> could do better in the future.

Agreed. I don't much care for what we have now. The enthusiasm for BPF
overwhelmed the caution that would normally protect the LSM infrastructure.

>>> Ignoring the static call changes for a moment, I'm curious what it
>>> would look like to have a better mechanism for handling things like
>>> this.  What would it look like if we expanded the individual LSM error
>>> reporting back to the LSM layer to have a bit more information, e.g.
>>> "this LSM erred, but it is safe to continue evaluating other LSMs" and
>>> "this LSM erred, and it was too severe to continue evaluating other
>>> LSMs"?  Similarly, would we want to expand the hook registration to
>>> have more info, e.g. "run this hook even when other LSMs have failed"
>>> and "if other LSMs have failed, do not run this hook"?
>> I really don't want another LSM to have sway over Smack enforcement.
> I think we can all agree that the one LSM should not have the ability
> to affect the operation of another, especially when it would cause the
> violation of a different LSM's security policy.
>
>> I would hate to see, for example, an LSM decide that because it has
>> initialized an inode no other LSM should be allowed to, even in an
>> error situation. There are really only two options Call all the hooks
>> every time and either succeed on all or report the most important
>> error. Or, "bail on fail", and acknowledge that following hooks may
>> not be called. Really, does "I failed, but it's not that important"
>> make sense as a return value?
> Of the two things I tossed out, richer return values and richer hook
> registration, perhaps it's really only the latter, richer hook
> registration that is important here.  It would allow a LSM to indicate
> to the LSM hook layer how the individual hook implementation should be
> called: always, or only if previously called implementations have not
> failed.  I believe that should eliminate any worry of a BPF LSM, or
> any LSM for that matter, from impacting the security policy of
> another.  However, I will admit that I haven't spent the necessary
> amount of time chasing down all the hooks to verify if that is 100%
> correct.

Even this approach leads to the problem of which error to return in
the presence of multiple, unrelated failures. My earliest efforts on
stacking used a "call all" approach, with success returned if all
modules approved. I abandoned this because it's impossible to identify
for all cases which error is best to report. In some cases -EACCES is
less significant than -EPERM, but if you have both, what might the
application care about most?

>>> I realize that loading a BPF LSM is a privileged operation so we've
>>> largely mitigated the risk there, but with stacking on it's way to
>>> being more full featured, and IMA slowly working its way to proper LSM
>>> status, it seems to me like having a richer, and proper way to handle
>>> individual LSM failures would be a good thing.  I feel like patch 4/4
>>> definitely hints at this, but I could be mistaken.
>> We have bigger issues with BPF. There's nothing to prevent BPF from
>> implementing a secid_to_secctx() hook and making a system with SELinux
>> go cattywampus. BPF is stacked as if it isn't a "major" LSM, while
>> allowing it to do "major" LSM things. One reason we need full stacking
>> is to address this.
> That's a different issue, and one of the reasons why I suggested
> taking an all-or-nothing approach to stacking many years ago, but ...
> well, you know how that worked out.

I'm still shooting for getting "all".

>   I promise to not keep saying "I
> told you so" if you promise to not keep bringing up LSM stacking as
> the answer to all that ails you ;)

Sigh.

