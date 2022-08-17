Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF07259748D
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 18:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241111AbiHQQuC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 12:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241161AbiHQQtu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 12:49:50 -0400
Received: from sonic304-27.consmr.mail.ne1.yahoo.com (sonic304-27.consmr.mail.ne1.yahoo.com [66.163.191.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2D46BCFB
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 09:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660754985; bh=Ny9gKY0wd/5ZfGgioSP7TsK+27gqEMxkOBVNAODpUC8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=PVm7RwcUroWU78cMoAJNQvwYWonhla2/OPYto/Y7sGTaZd0v57YCckfNtMGsyKlOqn5jo/nLFbH0QgLZ+dCRhgB95V69TWjjqdCZGskoZWr5x3e2tGRqT5eqH/5GJdAoG9baXzZhhYx40kchDNAp5uLv4ooVsFrGranILyqD4gjDZxxVhWzXqM8oQWPZv/Oq75H4sOLtbyGsjVUJqidx5zlwtTH/2f3jTUetAJAQS8ZgOePjbAjOwIKPDyqY9kzFD7BwlDMw/zlfJ5R4ybjgVkqMCwwsv7Q65T+AfE4XtnLFbFccby7+ZDeT+jAhOYGzI9MWQOz6E0W6eLUJvPuCLg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660754985; bh=nItPm8YWg465I0hPRwZl9/cWkmh+DRwj2wGVa5ZiSEW=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=WW1XusOYXJtoZhUKV+ccRD2mdq2lTNNlqm0QYkekGxvGuGtZHqSOMNqe63xftW/P8WLnPDJwwvESK1NPR7ZNeGDkn7RJGUQjzvhsWjBoPQRWtbUh/j2+CWp163piFRfrDL/Da+uxFcw4ULVrxSYtHXXs5WgFzTU8rUnEKHJzGPdEYbtLykjcd6H2PTGhNS4kvI1zRjmDBsFvoa08VIy2l2SV9rYLUmK+7l0LddREFMSwaQweTjdyBv5EkyuPRPl+YQ8xZenUNllag+cKi1hWH3tQKFVGKD3HFzPtNxJRwd6Nd+SWTjzVV32wjlzGXWByblJvsGkEsbDNxbDPzWeekg==
X-YMail-OSG: nQyc35AVM1ljY_NZDq1WiI9xnOazY7sjROJ8UOVmXimny823KsFHkEAN8BnWT8E
 RdDggBn4ct_jw4vNUJ1Ur1DezOANqpTMamvP5ocTQwfbFYu2Igymui5X9M6FSPCJKuQ5uoAVnV2f
 vNN0K2qtUcwC4ofiRT8uTkMbc4cBJEwLL1Rj9gAIybANozNF.Vq2hOQ1VNkyVqxbUyiMc4i.Lfa_
 e0vsfqB2BB8jc3lUhP95NegnCGwznqLkjMcHFuthFU8eNOw7Gtcj3BZkXjE7r6u_.6BR7wi.R.Le
 Zw3VfjtwVLAcnGqeHC3YKrBkxxsnGmDK5PRuZRhhc5LbY_iuYdlkmus5F6Z6qOjZGZO9s3lpCr9Q
 nBfd2t8KpRFUa.GxiAkc80.ai7MF_8mNcqXwAUwojzzZuoPNFT4XK1CYMAfrviFx3zTDlWFoOcfc
 vpt.P8gXA60ql6QovZ3oM5KjfpYGtTeWKQHhcMU8UmMyUKlRYQ3LZ7YM0kI0ibljGY2Qs.3XNtxV
 0V6_fV_PC3c0Ku8kD7nK7ag08BXr2QxyJHrtZLhiJ.8UdCfFC7D427cpVRMI0telU.CbZlZoLF.0
 BYjRbWnvaKY_ZgeDx.zxPbwDBHoou6ovhUGjeBYRi4BivzS5GrDMtwz4hN8VwLhH1tCu7_bUeoQK
 Z9UkT_1baRS1g7U6XNZzNnUyzDxLOKJgdIa_62CyfxOX9EvwomBCCQLk94wak3.QyYR50SqQy1i7
 FulHgHFKnoQ0ZqNZ8qHrvslW.nSlG6VeF6wUgb2FUq9vo4A7ILdJjvGm.AZFibgyY0Ox.BE5XWKU
 d83JTiVKa0P282A2Yd5GycKvOZMt72n0C3Vce9thMs1vVobCY4VH2QNdtIUDZS_JXEP3cd4OuQYD
 IT7mJZdcXHroUsKQ9G7UulZzBddKwkXhr8cgZ4ZygciosbZ51MWBB0mO61tmAK8gO3i8q58rlux1
 j8veunrU_.ljR4SDZFEVzXZ_EVATn42WxsqUW_hhBWvPLK0vBBy5RYmRAQMD8DBddIi8dlFHlU8f
 pA7K2Q6E.sDPrzWrINCazwRp05rcU2tZrrrYbK2Cscp5whBcsm0ZwG..IdGYJqptagw4QNmfwMwq
 88NRo.wLglvJydBVo_qwLNOvBlAlk78MNvCa2z4naUTJMjVstq4UNlcZmqfgy5Wzf1y3tCSSpVbS
 jXCqNfhoD0Th146MGdSabheiXX1Bb..eNbJme6niEIdCdSkCOgG6nfRCxssHM1CSjePkAZXyS1Zh
 QufHzsbDuhyLrBeo9nu4YDLYLKxMQ34ART7b8Bqp9D2.wvqP27PT4fTVTeoNFSr3v9E86k6u7__X
 7G5Rp.fF4GdtV_GP.WIjl0wOiWH2m8Gk7Hdm7udDrgSQd3mVn_BIbqyevYgZbwe5q1Dp5Sm5hbeX
 qq8xcr96Q1MAIsCbWy0r6kppgqku0OtqzkHagxGlZdyyxeupMRkYcLZZBYwbUD9rZqwO7hS0ASYL
 EKkyBSzQ6cqlXrs78IbEJbgf91HWuOERaHjd1dS6DjbugfDnQOxpMikidSSIOgqizxWYej0kCA7.
 y5IhgBN02UV21F5dVeLqOm2RrhFxTkjysw1IG_P7Q4wFzhx71KTUNRH74Khgq5nO61DUBOb_SEgD
 f5a2A4mUgvK9tkqC3kQ_kXhPtfq5hqBPbR6i14YmxybLmycK.bYiSPWYxMCej6Hwto4MkAbgImd5
 rVVnmZ73O4jrV0oMPx4WzLtw4tKZMK4jcTy9kFDj9Eb1hXl_4nLH_zzUkhWH.FnvxnIGSpCYX_Uc
 d1TwFyb4hjxwgE9EbWbJHcpHfkNJ7kFLBPUL.oZLMRkiiOSftzioQkeNqIon1v98NnkhRM_rk8nk
 FZoadhNMs4XYaIHnXXLmNWQgEJAx1DE03viw.OCUpa1Zu2fNzJw0rHNj3I7BID2Hs7myEvJ2Q3J_
 ipIGAbzC5d7Vyg71xDWZxQB8OUksKvyaJh6OT5NHIVtkpwn.5a4ES_3JSEhcIJ3CXdXVCYfZ27k4
 ikcOW_hg5AOsyxT9g4MI_7rjlOOhBQmNX4HLeW1PKoAdaPBbtFY34SmaqBNTDqYYzlVw9lX7oO1s
 46KBwN1qdHTQ6iinlWCdU1s.KkymrcRpnKCMZk.69gSofX6MxSm1N5K.Z8awJEcVCR07dBhFngGK
 HlJf9FeaF2QWssoyZP5513O8osrkVW40b0eAnc1Um7ch1.DgldQ4NlwHOv4ghkPhF3U4CZ6vafRs
 tUC4mZWWQFEYTF4QrDZzybVCt44TiA4pvajBWoqa1uU9U5QwRqXh7R3uw8PhTS13RKRehD3E048p
 oz5UNlY64EiXS
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Wed, 17 Aug 2022 16:49:45 +0000
Received: by hermes--production-bf1-7586675c46-7c7p2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 64aab401d4f89b4fef5c137bccf625b3;
          Wed, 17 Aug 2022 16:49:44 +0000 (UTC)
Message-ID: <664f29c3-77a6-2ed9-5c55-f181397b09a2@schaufler-ca.com>
Date:   Wed, 17 Aug 2022 09:49:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC PATCH v4 0/2] Add capabilities file to securityfs
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     Francis Laniel <flaniel@linux.microsoft.com>,
        linux-security-module@vger.kernel.org,
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
 <ab1bbd48-c48d-5f5a-f090-428ffd54c07e@schaufler-ca.com>
 <CAHC9VhTxYaLXFbS6JnpskOkADNbL8BA5614VuK3sDTHW6DE3uQ@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhTxYaLXFbS6JnpskOkADNbL8BA5614VuK3sDTHW6DE3uQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.20560 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/17/2022 9:10 AM, Paul Moore wrote:
> On Wed, Aug 17, 2022 at 11:50 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 8/17/2022 7:52 AM, Paul Moore wrote:
>>> On Wed, Aug 17, 2022 at 7:53 AM Francis Laniel
>>> <flaniel@linux.microsoft.com> wrote:
>>>> Le mardi 16 août 2022, 23:59:41 CEST Paul Moore a écrit :
>>>>> On Mon, Jul 25, 2022 at 8:42 AM Francis Laniel
>>>>>
>>>>> <flaniel@linux.microsoft.com> wrote:
>>>>>> Hi.
>>>>>>
>>>>>> First, I hope you are fine and the same for your relatives.
>>>>> Hi Francis :)
>>>>>
>>>>>> A solution to this problem could be to add a way for the userspace to ask
>>>>>> the kernel about the capabilities it offers.
>>>>>> So, in this series, I added a new file to securityfs:
>>>>>> /sys/kernel/security/capabilities.
>>>>>> The goal of this file is to be used by "container world" software to know
>>>>>> kernel capabilities at run time instead of compile time.
>>>>> ...
>>>>>
>>>>>> The kernel already exposes the last capability number under:
>>>>>> /proc/sys/kernel/cap_last_cap
>>>>> I'm not clear on why this patchset is needed, why can't the
>>>>> application simply read from "cap_last_cap" to determine what
>>>>> capabilities the kernel supports?
>>>> When you capabilities with, for example, docker, you will fill capabilities
>>>> like this:
>>>> docker run --rm --cap-add SYS_ADMIN debian:latest echo foo
>>>> As a consequence, the "echo foo" will be run with CAP_SYS_ADMIN set.
>>>>
>>>> Sadly, each time a new capability is added to the kernel, it means "container
>>>> stack" software should add a new string corresponding to the number of the
>>>> capabilities [1].
>>> Thanks for clarifying things, I thought you were more concerned about
>>> detecting what capabilities the running kernel supported, I didn't
>>> realize it was getting a string literal for each supported capability.
>>> Unless there is a significant show of support for this
>> I believe this could be a significant help in encouraging the use of
>> capabilities. An application that has to know the list of capabilities
>> at compile time but is expected to run unmodified for decades isn't
>> going to be satisfied with cap_last_cap. The best it can do with that
>> is abort, not being able to ask an admin what to do in the presence of
>> a capability that wasn't around before because the name isn't known.
> An application isn't going to be able to deduce the semantic value of
> a capability based solely on a string value,

True, but it can ask someone what to do, and in that case a string is
much better than a number:

  thwonkd: Unknown capability 42 - update thwonkd.conf policy section
  thwonkd: Unknown capability butter_toast - update thwonkd.conf policy section

The thwonkd configuration could be updated to use that capability correctly.
Yes, you could look capability 42 up in the system header files, but only
if they're installed and there's no guarantee that the header files match
the running kernel. That said, I can't think of a case where this would be
useful in real life except for systemd and chcap. I can't speak to the
container manager proposed, as I don't see containers being deployed with
finer granularity than "privileged" or "unprivileged".

>  an integer is just as
> meaningful in that regard.  What might be useful is if the application
> simply accepts a set of capabilities from the user and then checks
> those against the maximum supported by the kernel, but once again that
> doesn't require a string value, it just requires the application
> taking a set of integers and passing those into the kernel when a
> capability set is required.  I still don't see how adding the
> capability string names to the kernel is useful here.
>
