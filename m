Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88220694F00
	for <lists+bpf@lfdr.de>; Mon, 13 Feb 2023 19:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjBMSOk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Feb 2023 13:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjBMSOj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Feb 2023 13:14:39 -0500
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFE518B
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 10:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1676312077; bh=RKMD+yY8dulLx8938IJ/Cp89VmQElQ25HeNolFr7j4A=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=XO4GfIMRrUxGHilAvi5qXmlsWRumqa5gum1Wl3gsvm0FxD/11cUbL0JIoGR9LAwCJsU8Mbu+DFOSuJrU7gewbqi3owKVqzJ54jWnH20UoRuS3rv+4PkUDQjp8x3qMTRPvIwRPJUjHocCjSdDffGyuOnXVskn/+H/A5RniWwpH8LMtO4THaFWf40jAeJrne/6mrNoxqkFlvi00lZJ6FQ3tJLC7qabws0HrrXfZGVNPwK70IU96iB/9+Kx2p6eB/hnbYA49xKBzW5dMcA0gmaOZdwwOA+GIR+POfNzsPpITgFY0eMue+cv+5TA7QwX8YZpKYnJpLrI9KgT3HQyxkMYLA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1676312077; bh=w1YzeiwoT/uHewaRPWB+vhnCe9MIgQdfWhg/fxW2go/=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=A+hcUgL8t8Awl/HtH1GYlTstOw85BF1lebDwGwtyTyfxGpWnT36NVD2s/xdSmhXjBMeoJQWVb0Ij0ahTv+IAcRixIBNQLUBSo2faQxB3MJWT4s09qCwnRiX6M/AL7SViF46tO8OyNlPFmHeTD6snCLkA/LBtLvmuBCqgJu7fnuJy+/bTeQ5WipJvL97RLLdI+ox7F97irM5+/3x3+BB8no5tjMu9QwKGhX2Pqpobw8OUCYboqRKqVjherWIQnQ7Bqk311DWLQ5fF6qvvXeK3du+Ar0uNAlTJWozuHqCdb2QILai1WGekQqIUcYJDu/OqYGuqn2/elf078vTNmSnevQ==
X-YMail-OSG: wbqsAxMVM1k6feaekGr9lFJG4Cg_9YQ1XuxkNFKdnwYE4lvlGcwNEVlpzFJCLRn
 kYQ1ShMEM4mpq3SMa8jR0c.vbicMP.gJ8UTgP9gbJstU0jjFbLSnZE6.6fq_7BLhPk4WxYmdnRsD
 1Pkrf1d5CeLMRkLvoeA38XysDRF2.0RxNEK58N4LlwOj_HVmW_NTTHa_e.QvrgjKKKWSM2fhhNa9
 MdAS5e1qPdiUmxDUgcUrqpYY.9JEFOUJr2n_OHzR7YOjTlMET_G7nnsKIhyp7WzZWrzLYXLPHcsZ
 6PlTW0njy9pT9j5vIn2JspLP6P18_9PZuwZqV._YZiJ6NuisMu1Bgq9Bgg6KE5FjAryWdpOZ7NYS
 OyP97SQRXvYdcj8WE7Sju_SsTkJMaFiSmjWORPwODHA2BxwSo48tJikAhiaN0Y7w96z2VvzFCIkm
 9a5ED1LdWyzMy19yHzRAFImoADIpSCWF6UFBiPU7Nq50CCCwzxCtiOJhsxvPAswWBZyS6DWfCJl9
 hLm8f1iECGKuAJQpGoVxQ6LBlGXQLT6pyZTBA5ukbmYN1Fd0_dqLaF59ihKlPgEYNgv5qznSmhTi
 KrnFVpHtr_BISiqnexCden8QXxIlxcZhx4ReZnWhB8DM4YLE19HzzeamX442IsNUcr_yz7YPW4PR
 BW05AEijSZQxpH0TNnSlGgkfRf7uVdJ.mty2p80NoMCfhIAGI7szmi0aOVUnrbRAxFl9Fkkaxp1p
 _GjEfYbIH5AoYKmj_1FZFIPFIXEnjs_sHzO4h1G3eSkV6fgvhAtwEQ_SxuuJnsgJBtsqx7.zZCja
 HrKcJsy3Ir6Yz6qfcXsa3NIoI8XmBZzNHhb4ccWMh2RDEDqG0bbMzYvQp9KuZtplpaXCLDIeJZHL
 uDOW4zZW6fd64Qkeu0WNd.czflDtztStKWSl4SCuRiKJA4vyz7o0_BNXgU5LSavIAsS.7hM3qk6F
 4lrUXWYavP21NgqW05MU3.MmAamR_MT4za7ptHjYjtCJ25GHmEVVOM49WV_twXrQwfpebsJSmo.B
 HhiV9UzNYsHxz1hLr2M6xCzePP3vb_esKZfAw6zFfkLngF.4llw1n.717QAKaSQIHb2FiM_4R1Yo
 nscqZV1k8Y3dNsVSzKnjLzQkozxzKf.1Rfe4ZyfYWgg_xvLemy1ZJAl1l1U2aO7.HysJD4rPGiTF
 S1.jrJVLrF8fMK7J9yBSu2TyARrNGe8kjVuJ8jrgkqsCWjWWbsGvwkcn5uz2uOzY3FXmI.tJQObO
 00tef5OEw3uf.PWVAOSFpFTSuwNuUR7ENdgppxxf3axgstrsauUVj_4tASCIHVqT5HFpo6v07jGO
 iITLKYTxaSqgBQeEpBu5CbvX3tboJQGKzlFdDf9mAmn8qcc1qB9juND9ATgBwhMvqxciFyhfkBQz
 r_nYCn7XPbmj8c47ZLEOXpnd7aWptt2AbQtdYHafpYDtZ4_khh8cLIHrSCJkxUh3mnHIvfCEYOrv
 of_YfpaztjCoO1KPhHMpA.N02YPugmhRZPdEFBhf03X5T0ORZsXpJMcRI1_H_PzjlBylbbAYJZsg
 o3CsTKpY6NvzqXKwLrY6YHfmf32aSLjVcTAlEfw0PR6Dh_FE.suH6EWJ6BIPKt2GHf7jMKF1VOUJ
 fMwC64jYDntAkpTf8cw.05wpybKwpsGEH9b0qub0BqBQNj9zarvk0CdKnB4sCRi0Sc2ItzAFbn.F
 GUep58q4F2Kh0amnEf874KlGZDdQJaLX8KIszA0vVW0FsoUK.ihmNRBOcbyfSw9nQRs5Nc0.HM_O
 c1yuonvbgf9LyY0.DN3xVd_p3NBVDvvtM2jYrzv58o8nePufpbhPdWV9fqU0EYI1T4zeN88ZQbE7
 arYCYGz9B7znkAqoB_RDEYvG6YnuHsQIkyQ_._Cp1EEaPFpJ.s6cVQ_qYvUUySdfYFeeGmE14r65
 .q_55s_yYsnDD93q608s.oGMX5BFJjQki9gfP4QPyo0bAKbJx4FVYszAEmD6Beb49dLLT_EGgvMF
 btU8EFit8Bz5ikLPPFDobk26IvkpAy6EPLkg1AYXANg9e0f_hy.m.sJIhlI23PQ2D6jYKC0A8dao
 lUjtn4E8w7WYp0ef6rh2IcEWa7vqeNKmAWsagbdPf3CWq.xzMwZDZ_4u_XSMqsNsJnr1w2jWBsJb
 0ca8v6DPD_5.FtvnZ_T82RbQV7WX6gEfsSodAD7GNjpf95gPjp4aVEZxZ9Qv53eckILXzixB0YbP
 Iir4b3h9GLKGOXqr_cowMdQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Mon, 13 Feb 2023 18:14:37 +0000
Received: by hermes--production-gq1-655ddccc9-spmtr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b074ad83ffd3b6b789ae4e31a6313cb6;
          Mon, 13 Feb 2023 18:04:05 +0000 (UTC)
Message-ID: <2160af7d-eaf6-511a-72a4-9bac352891e4@schaufler-ca.com>
Date:   Mon, 13 Feb 2023 10:04:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH bpf-next 0/4] Reduce overhead of LSMs with static calls
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     Kees Cook <keescook@chromium.org>, KP Singh <kpsingh@kernel.org>,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, jackmanb@google.com,
        renauld@google.com, song@kernel.org, revest@chromium.org
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
        autolearn=ham autolearn_force=no version=3.4.6
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

Agreed. I don't care much for it.

>
> Ignoring the static call changes for a moment, I'm curious what it
> would look like to have a better mechanism for handling things like
> this.  What would it look like if we expanded the individual LSM error
> reporting back to the LSM layer to have a bit more information, e.g.
> "this LSM erred, but it is safe to continue evaluating other LSMs" and
> "this LSM erred, and it was too severe to continue evaluating other
> LSMs"?  Similarly, would we want to expand the hook registration to
> have more info, e.g. "run this hook even when other LSMs have failed"
> and "if other LSMs have failed, do not run this hook"?
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
>
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
> well, you know how that worked out.  I promise to not keep saying "I
> told you so" if you promise to not keep bringing up LSM stacking as
> the answer to all that ails you ;)
>
