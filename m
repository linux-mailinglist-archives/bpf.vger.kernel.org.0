Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E90E315AC60
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2020 16:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgBLPwP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Feb 2020 10:52:15 -0500
Received: from sonic307-15.consmr.mail.ne1.yahoo.com ([66.163.190.38]:36196
        "EHLO sonic307-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727458AbgBLPwP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 12 Feb 2020 10:52:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1581522732; bh=4bDYcDU7Mlh6f5S31FmwUTk/wsFQm+13ahLvA0T7G9M=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=sT/NjdFVI2M2HYotcKH5LgV8HpQBwFK3oN7BjP4LSbhqb/ESgr0O8K7rY3K28GLDwcoIoz7bihE/r/ZBHxzXfQn/D60TamWEvv0xKW0l9wXDSURP/icO155r2bwhwRR1ZFyKIo4At0pRpdV7Ig/DG9bAQXe64Xxc+7BtPUTI+BZLTANbafpvc/5ervpbKpONnwr+0C40UPd7qOd+c833IW0uvPmarsBuPYOrMD2SCJciC2UJtTqLS+Sp4sGpDPG5vs7Bv6o1kJ7gmtlzKKwa9IoYpJDlnLt3m8ZRt6CLIci0saPvGK3XpJqmV1P/Zi1leuaSiRDrUGoDmDAql4IszA==
X-YMail-OSG: MZ6b8JMVM1mj8C6.wZxAxcY5SEAf488LG6hoWbNqHvNT9NEAaRUGiBHXwUqQ.7P
 Ss31bOxqex0COunhZwX3mppFFpAsZuyIJh8nJEFWZj3Ha7020xjesUAx.poNJ7wh9S.utwPru6NP
 OZqoMl0pOU64X96BQIzz31vaWL0XI4pjrvYVj7wAKMmgHiWroaKq4ma5at8HhdFJ6lUIAId4mwFI
 Mt48gZMXIQbuPlXFsBC7dsisCE6zh8VFXtbaGwZRK.M5CzIa2pPPkVbdX2kmKGlRe1.8KB5BFkVh
 CgcQjbA_1p.9Fv1OEuZamMNJW3uZ3_oUmpUQXGytvA2w.Sl1f1kknUsOdtp9eUZYGiFrzjZqCf13
 anPtcKrZk0Qx7NoGw9jKcJrcKFbnjGjbcA8g7vrX6h.NLsAMlGZ9IU_HDkmWjl4QVjEKyF85RfxX
 lsa5D2G9WIrAyFDHvisKglBiWNw8ILc9J2qLK_YfkjjLWdf6IEBShWtRQprH8PSrT21bLXsdCExN
 dyabnD6Seu8JvWlIgfaOlcHbArI2LnlxpFc0z1o4URrXbQjXkW_LybDJyt_ivhP5iExugowkN9CO
 StXkh5_bMmyESFNwHBz8MJ05fTGFQJi_OSDlX02etKINeiJ8fEzhcw4lVoihDv._vPRtsyEYMCOY
 LR05wNApX7IVbR8ok4q9O3MDHXfNR3mcp4QFaghZ40pm1tYIoNvguSKT_GebSXgPwyNR8GH0uA3Y
 PW2zGtqkNkXiv.DlVPWG60bDlaXNJbjgxPyvxpfWGlH82kLPXyeJbFQCYczefKGt49hTcaaG1vwF
 AFWhSFmdPRYWHUjTSvFYR4ynTVAg7q6L0HfO63OOJFk0N_9YcSLamW0aJ2d8GlPBmdDh7oCbbdqP
 7nTKQb.OuHHbF0oJxPG0FrAhGKuJcJmbpwkL8Z_Aud..L3KBQTgg.HpXV0hCadZ7iZ9kERWKii3D
 GYxMTwjSlbuyxJskNs4u1idhzWCrEHvxVIY.wk0vbeHS0aqkkWtYh9m2f6nHRa9B5GM8.CprivPd
 mtBMQnskCnayT_7d9ie4iR.T_qw7BZ4gC5SMOvz2draXHjVAQMRt.dQ7OH4qZUSRhTE7PaIaX9dl
 pid047U1N81QQHnxD7JV0xpeNMYYZ4uiIiPDXjufM1rMK8AynpC2KwBMAJzhkfZtw4Ygliy6UE4T
 vFmnFbOMhVYEulvuxh0IMY803TndZo1WZ45pvvo8.KLkcyHu9JXOzxQDHWnXSjCIl_jGKitDWAEm
 SMnFP.D7pTBuGKrj1PlZW0tOZBwRtldx4LkexDKY.rNSsWupEVpFaqFZKbHgA9c2zkG4ADEXNIAG
 A9d4kzrMXW0Ch7CixDcOY5ugle3jK34jTysv4e_aZkJfnr6mvQZhAj2z12eRvAlqb4p7SiiqNQpm
 TZqxS_sFAr7UTPc4XpSNsX55Ht6hEiBcy7Q--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Wed, 12 Feb 2020 15:52:12 +0000
Received: by smtp428.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b49c7ee0068c6dfa494419f9447be234;
          Wed, 12 Feb 2020 15:52:12 +0000 (UTC)
Subject: Re: BPF LSM and fexit [was: [PATCH bpf-next v3 04/10] bpf: lsm: Add
 mutable hooks list for the BPF LSM]
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Jann Horn <jannh@google.com>, KP Singh <kpsingh@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kernel Team <kernel-team@fb.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200211124334.GA96694@google.com>
 <20200211175825.szxaqaepqfbd2wmg@ast-mbp>
 <CAG48ez25mW+_oCxgCtbiGMX07g_ph79UOJa07h=o_6B6+Q-u5g@mail.gmail.com>
 <20200211190943.sysdbz2zuz5666nq@ast-mbp>
 <CAG48ez2gvo1dA4P1L=ASz7TRfbH-cgLZLmOPmr0NweayL-efLw@mail.gmail.com>
 <20200211201039.om6xqoscfle7bguz@ast-mbp>
 <CAG48ez1qGqF9z7APajFyzjZh82YxFV9sHE64f5kdKBeH9J3YPg@mail.gmail.com>
 <20200211213819.j4ltrjjkuywihpnv@ast-mbp>
 <CAADnVQLsiWgSBXbuxmpkC9TS8d1aQRw2zDHG8J6E=kfcRoXtKQ@mail.gmail.com>
 <1cd10710-a81b-8f9b-696d-aa40b0a67225@iogearbox.net>
 <20200212024542.gdsafhvqykucdp4h@ast-mbp>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <bee0fd08-b9f2-83e4-2882-475b81c74303@schaufler-ca.com>
Date:   Wed, 12 Feb 2020 07:52:09 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200212024542.gdsafhvqykucdp4h@ast-mbp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.15199 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/11/2020 6:45 PM, Alexei Starovoitov wrote:
> On Wed, Feb 12, 2020 at 01:09:07AM +0100, Daniel Borkmann wrote:
>> Another approach could be to have a special nop inside call_int_hook()
>> macro which would then get patched to avoid these situations. Somewhat
>> similar like static keys where it could be defined anywhere in text but
>> with updating of call_int_hook()'s RC for the verdict.

Tell me again why you can't register your BPF hooks like all the
other security modules do? You keep reintroducing BPF as a special
case, and I don't see why.

> Sounds nice in theory. I couldn't quite picture how that would look
> in the code, so I hacked:
> diff --git a/security/security.c b/security/security.c
> index 565bc9b67276..ce4bc1e5e26c 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -28,6 +28,7 @@
>  #include <linux/string.h>
>  #include <linux/msg.h>
>  #include <net/flow.h>
> +#include <linux/jump_label.h>
>
>  #define MAX_LSM_EVM_XATTR      2
>
> @@ -678,12 +679,26 @@ static void __init lsm_early_task(struct task_struct *task)
>   *     This is a hook that returns a value.
>   */
>
> +#define LSM_HOOK_NAME(FUNC) \
> +       DEFINE_STATIC_KEY_FALSE(bpf_lsm_key_##FUNC);
> +#include <linux/lsm_hook_names.h>
> +#undef LSM_HOOK_NAME
> +__diag_push();
> +__diag_ignore(GCC, 8, "-Wstrict-prototypes", "");
> +#define LSM_HOOK_NAME(FUNC) \
> +       int bpf_lsm_call_##FUNC() {return 0;}
> +#include <linux/lsm_hook_names.h>
> +#undef LSM_HOOK_NAME
> +__diag_pop();
> +
>  #define call_void_hook(FUNC, ...)                              \
>         do {                                                    \
>                 struct security_hook_list *P;                   \
>                                                                 \
>                 hlist_for_each_entry(P, &security_hook_heads.FUNC, list) \
>                         P->hook.FUNC(__VA_ARGS__);              \
> +               if (static_branch_unlikely(&bpf_lsm_key_##FUNC)) \
> +                      (void)bpf_lsm_call_##FUNC(__VA_ARGS__); \
>         } while (0)
>
>  #define call_int_hook(FUNC, IRC, ...) ({                       \
> @@ -696,6 +711,8 @@ static void __init lsm_early_task(struct task_struct *task)
>                         if (RC != 0)                            \
>                                 break;                          \
>                 }                                               \
> +               if (RC == IRC && static_branch_unlikely(&bpf_lsm_key_##FUNC)) \
> +                      RC = bpf_lsm_call_##FUNC(__VA_ARGS__); \
>         } while (0);                                            \
>         RC;                                                     \
>  })
>
> The assembly looks good from correctness and performance points.
> union security_list_options can be split into lsm_hook_names.h too
> to avoid __diag_ignore. Is that what you have in mind?
> I don't see how one can improve call_int_hook() macro without
> full refactoring of linux/lsm_hooks.h
> imo static_key doesn't have to be there in the first set. We can add this
> optimization later.
