Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41F4C1689F9
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2020 23:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgBUWbZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Feb 2020 17:31:25 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com ([66.163.190.153]:40159
        "EHLO sonic315-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729179AbgBUWbZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 21 Feb 2020 17:31:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1582324283; bh=jc/HfK4tULEWIIf03UPNZk6W/FdQqeotiRsUI8KrqUk=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=sI+dv1qxbF4pi0+2+yKbdAdaATpi185kDqUWqovZXegbaZr+KTVwLgcfOFugIIe7jNq9paC49ZKWTL+KqcDtJoTdAGwgkM7sYst2wkLUHht4dCVh6qneUOK54GQEsqKJBxP2eOrV9IIw0XL8On41ZZJcxgBt5Otz6ULRvevyqJ4uPN0A4JDmZV/vd/e38lx8D/n4gw1WIaVEXXmB2mApSvNN86E4lXc8b15JwzsR1MYyPEKzy9Fflg2v1XwsYGTnkAGgc7Xbtaf1sw59S2oSokPp/m3/3NNKT6Z7CzZh5p0qnAftC080pbRJ2G70iDvTUVeyGnzUMgxXisMtukdK/A==
X-YMail-OSG: R1jCGQ4VM1mMrsnsP0q2t3E3Lw5OgxlPuex1td.TGDjLESNbV6Hc.VBF2TMvRyr
 mxPwJD85re7bm9EuEngnMJhVhRsrs_S7GOzMZa9RY5Lmd6mW5BGiwXDt0paYo.LdGn8w6q09v7Yx
 bwBDx9bUpEm0GwHs2d_FTN0OQ8cT.1iZUFpDztKk.mZt9zdBCA6G4hO0NhodU2ycdO41Am6Rbb9p
 .pV7DMt0UKz4ftWOa87rDGmade0FS9CFXogCVDy0EYMptkx0DYd0udmsCiV1zP0g5rwbEUkfgt9s
 LL67M0c_JGl5uQvG8Q8y05WTfceNSB0d6Xy6MK7FAPi1Vks0lgt2RCmR_f.nZH9RqLPHKqowwjcr
 wfNcJMEXzxLU4LCIdqgTDmqfZVzF9jOG1VYVojdmyylp7zgnQKFRoJv_1iC4Qi7rDJbavhPgKTZ5
 zdiZ3hbkhWlkedJYMhIh5wHedL1_rm7j9JRoXMTqdkfgYIKRz3Xc2GP_9ri_DTfxe0E_urpCQxq1
 MkZc0lq4l4cxVl_5gEyCbd5HMNPS5vwYv.LN8FkvAKpUq8dlkdkLG3zUesiRiupJDrt4oTouF3rz
 6zPZrmCp45m3JbcAk3X13DejjM3nGzv8uHwJ816x5ZcsbMg6SrndbMLlQePV_Zv40M3gdXFLSO3h
 YtuyuDhRDpz9hZ5DKvrJvosTrndmtfZFnPQ_qa30Je3GHMJ8qjfqvJA5tu9t88cbVbqoA0znM8GN
 oxi9VaNHya.FukWkGXeWVjpb5AClWP5cNlAVwJkiAjjfeigPq19zMsLLXhXFaZZiYnqjtymy14Ze
 aktMlok2x_p7wdgOrFKIzVTQ71PlgcBDgMIxthi3cJYasiHtR4FtKtQQa32jC9fMymLXdjUb52HO
 Blg1Ct1wBJ7NHdXkr9294X3Y08DeZrzv_DzOyQLVYQi702YlyJlMLp23F8UiitsSyAUUa5q4Q2dL
 F792LEQwtHTQuKD9g2ajXdZkpE2MCxthZTjVF5UkHNXbY0.CZ5Le4LFfPwZA9ZumMUy4mskR3Ow7
 2D8outbKPcq53CcsUEB3hS7s0ecd7x1JwbjYPbJXUeq58sR8uT9vF.NCsoUir7er3WBwBnAxPneM
 SGHWadiWHcWWDTCwfPLRWZFIUfRv7W0ta7ftgDSWllAuPb.pfmmzNLb2sqHlTKV2JY9LM69Yz8Jr
 VAE_w5unkEJ1FLSK2DyTRO_f4W9KA7HbQTdDalStaoXYrFeyya_jGKy5ijfbShUkQv01EPFmHqfJ
 mTUdUIc6eehtmUj1Urd_SpUGrbREuZrvu6QlKxVYPat8Z3a3mRkcmBipmABbbxHbW0xSY_.Yv6DN
 qdOSsOx7eps9Yugv41q1k7PkUqFCSphmFpUTlhukKpP.95pX_UBtht9yKWJ0gOfS1qiNWmJuZ6Lh
 6iRxaGhbFVf4MlvPDKsAixh5h9tkuGP2r23OEYtIB6Tw-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Fri, 21 Feb 2020 22:31:23 +0000
Received: by smtp432.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 26726cd77560c9d1061a27006ed9df19;
          Fri, 21 Feb 2020 22:31:19 +0000 (UTC)
Subject: Re: [PATCH bpf-next v4 0/8] MAC and Audit policy using eBPF (KRSI)
To:     KP Singh <kpsingh@chromium.org>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200220175250.10795-1-kpsingh@chromium.org>
 <85e89b0c-5f2c-a4b1-17d3-47cc3bdab38b@schaufler-ca.com>
 <20200221194149.GA9207@chromium.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <8a2a2d59-ec4b-80d1-2710-c2ead588e638@schaufler-ca.com>
Date:   Fri, 21 Feb 2020 14:31:18 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200221194149.GA9207@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.15199 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_241)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/21/2020 11:41 AM, KP Singh wrote:
> On 21-Feb 11:19, Casey Schaufler wrote:
>> On 2/20/2020 9:52 AM, KP Singh wrote:
>>> From: KP Singh <kpsingh@google.com>
>> Again, apologies for the CC list trimming.
>>
>>> # v3 -> v4
>>>
>>>   https://lkml.org/lkml/2020/1/23/515
>>>
>>> * Moved away from allocating a separate security_hook_heads and addin=
g a
>>>   new special case for arch_prepare_bpf_trampoline to using BPF fexit=

>>>   trampolines called from the right place in the LSM hook and toggled=
 by
>>>   static keys based on the discussion in:
>>>
>>>     https://lore.kernel.org/bpf/CAG48ez25mW+_oCxgCtbiGMX07g_ph79UOJa0=
7h=3Do_6B6+Q-u5g@mail.gmail.com/
>>>
>>> * Since the code does not deal with security_hook_heads anymore, it g=
oes
>>>   from "being a BPF LSM" to "BPF program attachment to LSM hooks".
>> I've finally been able to review the entire patch set.
>> I can't imagine how it can make sense to add this much
>> complexity to the LSM infrastructure in support of this
>> feature. There is macro magic going on that is going to
>> break, and soon. You are introducing dependencies on BPF
>> into the infrastructure, and that's unnecessary and most
>> likely harmful.
> We will be happy to document each of the macros in detail. Do note a
> few things here:
>
> * There is really nothing magical about them though,


+#define LSM_HOOK_void(NAME, ...) \
+	noinline void bpf_lsm_##NAME(__VA_ARGS__) {}
+
+#include <linux/lsm_hook_names.h>
+#undef LSM_HOOK

I haven't seen anything this ... novel ... in a very long time.
I see why you want to do this, but you're tying the two sets
of code together unnaturally. When (not if) the two sets diverge
you're going to be introducing another clever way to deal with
the special case.

It's not that I don't understand what you're doing. It's that
I don't like what you're doing. Explanation doesn't make me like
it better.

>  the LSM hooks are
>   collectively declared in lsm_hook_names.h and are used to delcare
>   the security_list_options and security_hook_heads for the LSM
>   framework (this was previously maitained in two different places):
>
>   For BPF, they declare:
>
>     * bpf_lsm_<name> attachment points and their prototypes.
>     * A static key (bpf_lsm_key_<name>) to enable and disable these
>        hooks with a function to set its value i.e.
>        (bpf_lsm_<name>_set_enabled).
>
> * We have kept the BPF related macros out of security/.
> * All the BPF calls in the LSM infrastructure are guarded by
>   CONFIG_BPF_LSM (there are only two main calls though, i.e.
>   call_int_hook, call_void_hook).
>
> Honestly, the macros aren't any more complicated than
> call_int_progs/call_void_progs.
>
> - KP
>
>> Would you please drop the excessive optimization? I understand
>> that there's been a lot of discussion and debate about it,
>> but this implementation is out of control, disruptive, and
>> dangerous to the code around it.
>>
>>

