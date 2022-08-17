Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B8259734B
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 17:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiHQPuY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 11:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237205AbiHQPuQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 11:50:16 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CAF75CDA
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 08:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660751414; bh=IRd/YUZMbvM4XhlVg6o42f9hHAZIsjqYGMpOa3dXxVk=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=oF5zb10aaP1gzIjNOsbA2ZobrmhWRcVXR52jScEig/cazzm4MVOFs/vMukgGLaaVdcLbMo46uemCCSshG14QmeGF8wXbCwE1HY35emWOw+UTuzFOcutaiD8/4l3dGeiwtZ2hMz2Bhq+vC6rsWEtaE5NrvJa57jZmWoik+hoCGM/UDIPDXOOXftkl+Nxg9zURMoWzUid7yha7vtO3k4rJkF5yzOiuYVVjL3AftnxnC9OxtUhdvc2ZBi2YgLceuXdjUkOnWjcuC1sDo/ScuwAnmKSQKBil/Ze+YcPvPCErOYeusvLWoovy+j4iHjQAkk+gs0HuFBzfRJzzkoMcVwAuiw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660751414; bh=igRrhz0NWpxt+gQuvQt48Eltb/Lsb1etecmDShxEfHX=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=aviq2q+v7aqvEhATE/GtZSzv3IOUp9KYk9i3BaT4im6u4wfsM8AzyK4wkgxHZzsp1m0MUYitMC0yK84rC/K9gifzNPmOhslKxAtpd/yu6WfU1leo7V/p8mzgNkpOScH041UDpwAUhzCSBQi1jbcmHWiSqvB99H9ArxFV16kqYMoAwUiUMWvd9s3NFeW96BAEjBeoJhF+U7XWn4vIO5THyIkFhdZeugz6acvS2nlKeJhrEQ5fI5XaP3iMnwosJuQX8uh6gv2SJmlETjDZGOdotNAE92a8+UZbd+ifbBv7Sm0q7ET8vC/ouS9W+6/8gHV1d2bRFBamGzMIDPoF5SxQ8Q==
X-YMail-OSG: gCz7YkkVM1n_AD5bbh.FxCfZoIfOVcr7DD.w80RsIMy3Otevr91fQDek.WDNwJM
 x9csdEFMSw7UjcJMBFaSufmsUH6atj6O1TnrB.xJsnRfwJ1wlUXkSciBNbxsuV0I3dxD0QihMtRQ
 m0_oTWWVB2YsETM0zDmUy.XOv8.LwcFi4cZ2zJi.zJpyBdVBRBiPS3hOgq6UFV1ibMKVlgxUK7e1
 a7U66WR4LRDUgdhEYNzlsd4lx2t8uF4cDQfzywTN..V10vH0H6gs5P3Sfq7DW9z9S_arACu7cEQ6
 VsPpuw7o5ifn43VK__7C0qPg6_QAuN9GhFYocQ8JChevrFVlkZghMGU8UNhflurQNKQ4IRcsxSE3
 2cvB09qPAhVGX4ejKb5CnVOXDONc0TA5VzvU7Vc9auPlrp8e.52gKjdq.U5lUTFrf4TIgfvkoc3e
 udr4wK_6s4GIBtwG4Zmgw88dxw_0PE.4I2RHXTE1GIq1YP9KyH.yeeBZKmQqOlrawfdSvQ2aMvdt
 B_KZM_Q58bAE6x7TfEyoQCiLOfXHcbWLEFTadPnD_jvOKmOE72SWAUOM3cNFBqQtI22cqSiN3FSV
 cKUCAZhZiofwEnRGQ31Ca7b1qpR9Bm8iCmo77xCfdi6BuSeVHaXEyinJSgD0e5fE_YybUHRnt9_z
 qMA7jut8dHw_T7ELAbI08tZdoS22YEnlUktfxkHGRZ0qCxsSrSMp6ioHUv5vcyObTh9pj4yOdFkT
 DWGu8PEsQ2cOFx0PaYN8SbzerBcP2q9wQbZd5YBKAtyZ2lNFImYF_qL.HOPPPZ6mhONh5dGDbiWj
 IyuCRtsGBfMZf37r2QrBxnx3FVsjt3b_m_1GynU2HA8XfFoCWNaFfxN0jLq.kufy_Qa1BtXMko9r
 NNYc7pDyTb9q663QPjFEKdJQEK5TpgYQDDQQ8Yjc1kEmyZm.vXgdjzSAomXWTiNCQS4OqPVQuJob
 V7U3f61xoyN417ttvV8hhsxzNfTwinsWEw7X2DHc98Q8jrxn97EUNlpvfV648ODVrbbovbGORxZ3
 3WGl5qASAiuvm4lfo6OA6gVhVSXXwsng5JoJA7qS.76mQLpxSOJesqPpasJ2TfEyYL0r3aX9t1o5
 xskFISh6vHo.mV9IlJCcb.C5qec7btIswEp4o4ou2dz68W7sb8M4TQ5EsPNQsQ16t9xC3ibEC9SV
 gBBEw.tqeZyFJ7ZEYiQKHgcIjCtnIOSMktq0dvVfph4NuM.d1Y16fGOlUgoU3UVju.jA3ZXsneQj
 XUUHNi6fGqW5BgGlzzbSzYK8.zaXb8x9FLkohcF.75uvkaSrpLsUXgeOskDKTc4sdqskbsjuLJAF
 vlOlKCJV7rhhjyuLapQnoF7qzyLZTiZsnzOSH8IHcOwyfIuZ7WFRW1_6dBR0zgp3a4w9J1EmCHPh
 BdUN3C6fb5Ds7lr7Y2nQoqeaq0mu6gYlEthSa858Nz7vmizGqB_DZ.F1vu9ennpjjkP2oDgd4j5n
 mLqi_HJYDBBzYxNhx8VgyY7qqjY8_5xi2mBrpXCjNGtx2Zdd07_pl1YEbdH127gAGd8aWt8J4nHG
 45hH.U0KJg_Z9B0vuca7Xizr8HunWBnc.xrU93Kry9M5tssvALwziR0XGxRHpWOINI9cA9vMIbkM
 sPJ70VyIjO3qa7jgbPGE.PRQqdaJGc2bXByIFNS0tiS.y8zu5L6RzBMB.hS2tZ6.I8hSPMgkaY.O
 LB4NObiXTIgD4V5L0Lo4SB99CwDR2a6I4hkEm76f13LbpBxrXpysZJ6TbIDG.IBvqSbcdKoWJlkp
 pRJiGChPHRMVf.JO4cpb5Con1KBMavdrfALJ22g2wUfZfYuY02vFV9yokKA86UcJraW8vNZdvO3c
 X0Xg1Luk406pxqlgPGmyB0tpUKNbIarZG3NzdnK1xO6z6cRbeQPM3l22SkKK.yETtnOqjwscak15
 D11YufiykxTMbQ9HM1XwGNniCUam_QXolRqTqanFRqxUaKHdQvYEXETU1kmFnQ5_MLDkDHZIyhyC
 fqCIcTYMTVhalZX88hl2_xeB89PVXOfNvqDfIdmfZPifAk8EfAUtWUeYd3h9jES9nTm4NX3FLga1
 5J9uzGB6PVFgPk6G0HY_HHxPZb1uaGL48zfqX_vamJFlHg8wBTVYnMLQ0RHpwJBTryVmv8gGJUgM
 Q.hyoT0k.EtYrXB1ejUPD4_yv1tCqlGYiF2N4tbQkTlOACxVmvOYEurkqLCsEAil8foD7GMZa6Bo
 QtYmJBedC_f11Ykso3Knwz7DRuayAIOrBmZANZZDpng06hghVWFev8Xefyn.68KzNwdjqZU12xl4
 7y8QVU28NTNY.AOvEar6EjXpmhQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Wed, 17 Aug 2022 15:50:14 +0000
Received: by hermes--production-bf1-7586675c46-7c7p2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 058d68e14750c70c30f0e5a1ea6d7644;
          Wed, 17 Aug 2022 15:50:10 +0000 (UTC)
Message-ID: <ab1bbd48-c48d-5f5a-f090-428ffd54c07e@schaufler-ca.com>
Date:   Wed, 17 Aug 2022 08:49:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC PATCH v4 0/2] Add capabilities file to securityfs
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        Francis Laniel <flaniel@linux.microsoft.com>
Cc:     linux-security-module@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BPF [MISC]" <bpf@vger.kernel.org>,
        casey@schaufler-ca.com
References: <20220725124123.12975-1-flaniel@linux.microsoft.com>
 <CAHC9VhTmgMfzc+QY8kr+BYQyd_5nEis0Y632w4S2_PGudTRT7g@mail.gmail.com>
 <4420381.LvFx2qVVIh@pwmachine>
 <CAHC9VhSMeefG5W_uuTNQYmUUZ1xcuqArxYs5sL9KOzUO_skCZw@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhSMeefG5W_uuTNQYmUUZ1xcuqArxYs5sL9KOzUO_skCZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.20531 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/17/2022 7:52 AM, Paul Moore wrote:
> On Wed, Aug 17, 2022 at 7:53 AM Francis Laniel
> <flaniel@linux.microsoft.com> wrote:
>> Le mardi 16 août 2022, 23:59:41 CEST Paul Moore a écrit :
>>> On Mon, Jul 25, 2022 at 8:42 AM Francis Laniel
>>>
>>> <flaniel@linux.microsoft.com> wrote:
>>>> Hi.
>>>>
>>>> First, I hope you are fine and the same for your relatives.
>>> Hi Francis :)
>>>
>>>> A solution to this problem could be to add a way for the userspace to ask
>>>> the kernel about the capabilities it offers.
>>>> So, in this series, I added a new file to securityfs:
>>>> /sys/kernel/security/capabilities.
>>>> The goal of this file is to be used by "container world" software to know
>>>> kernel capabilities at run time instead of compile time.
>>> ...
>>>
>>>> The kernel already exposes the last capability number under:
>>>> /proc/sys/kernel/cap_last_cap
>>> I'm not clear on why this patchset is needed, why can't the
>>> application simply read from "cap_last_cap" to determine what
>>> capabilities the kernel supports?
>> When you capabilities with, for example, docker, you will fill capabilities
>> like this:
>> docker run --rm --cap-add SYS_ADMIN debian:latest echo foo
>> As a consequence, the "echo foo" will be run with CAP_SYS_ADMIN set.
>>
>> Sadly, each time a new capability is added to the kernel, it means "container
>> stack" software should add a new string corresponding to the number of the
>> capabilities [1].
> Thanks for clarifying things, I thought you were more concerned about
> detecting what capabilities the running kernel supported, I didn't
> realize it was getting a string literal for each supported capability.
> Unless there is a significant show of support for this

I believe this could be a significant help in encouraging the use of
capabilities. An application that has to know the list of capabilities
at compile time but is expected to run unmodified for decades isn't
going to be satisfied with cap_last_cap. The best it can do with that
is abort, not being able to ask an admin what to do in the presence of
a capability that wasn't around before because the name isn't known.

On the other hand, it's possible that capabilities are a failure,
and that any effort to make them easier to use is pointless.

>  - and I'm
> guessing there isn't due to the lack of comments - I don't think this
> is something we want to add to the kernel, especially since the kernel
> doesn't really care about the capabilities' names, it's the number
> that matters.
>
