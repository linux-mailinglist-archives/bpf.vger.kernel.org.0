Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5965315AA01
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2020 14:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbgBLN11 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Feb 2020 08:27:27 -0500
Received: from www62.your-server.de ([213.133.104.62]:57368 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgBLN11 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Feb 2020 08:27:27 -0500
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1j1s2v-0004et-Je; Wed, 12 Feb 2020 14:27:18 +0100
Received: from [2001:1620:665:0:5795:5b0a:e5d5:5944] (helo=linux-3.fritz.box)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1j1s2u-000X31-Sa; Wed, 12 Feb 2020 14:27:16 +0100
Subject: Re: BPF LSM and fexit [was: [PATCH bpf-next v3 04/10] bpf: lsm: Add
 mutable hooks list for the BPF LSM]
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
        Kernel Team <kernel-team@fb.com>
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
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ff6dec98-5e33-4603-1b90-e4bff23695cc@iogearbox.net>
Date:   Wed, 12 Feb 2020 14:27:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200212024542.gdsafhvqykucdp4h@ast-mbp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.1/25721/Wed Feb 12 06:24:38 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/12/20 3:45 AM, Alexei Starovoitov wrote:
> On Wed, Feb 12, 2020 at 01:09:07AM +0100, Daniel Borkmann wrote:
>>
>> Another approach could be to have a special nop inside call_int_hook()
>> macro which would then get patched to avoid these situations. Somewhat
>> similar like static keys where it could be defined anywhere in text but
>> with updating of call_int_hook()'s RC for the verdict.
> 
> Sounds nice in theory. I couldn't quite picture how that would look
> in the code, so I hacked:
> diff --git a/security/security.c b/security/security.c
> index 565bc9b67276..ce4bc1e5e26c 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -28,6 +28,7 @@
>   #include <linux/string.h>
>   #include <linux/msg.h>
>   #include <net/flow.h>
> +#include <linux/jump_label.h>
> 
>   #define MAX_LSM_EVM_XATTR      2
> 
> @@ -678,12 +679,26 @@ static void __init lsm_early_task(struct task_struct *task)
>    *     This is a hook that returns a value.
>    */
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
>   #define call_void_hook(FUNC, ...)                              \
>          do {                                                    \
>                  struct security_hook_list *P;                   \
>                                                                  \
>                  hlist_for_each_entry(P, &security_hook_heads.FUNC, list) \
>                          P->hook.FUNC(__VA_ARGS__);              \
> +               if (static_branch_unlikely(&bpf_lsm_key_##FUNC)) \
> +                      (void)bpf_lsm_call_##FUNC(__VA_ARGS__); \
>          } while (0)
> 
>   #define call_int_hook(FUNC, IRC, ...) ({                       \
> @@ -696,6 +711,8 @@ static void __init lsm_early_task(struct task_struct *task)
>                          if (RC != 0)                            \
>                                  break;                          \
>                  }                                               \
> +               if (RC == IRC && static_branch_unlikely(&bpf_lsm_key_##FUNC)) \
> +                      RC = bpf_lsm_call_##FUNC(__VA_ARGS__); \

Nit: the `RC == IRC` test could be moved behind the static_branch_unlikely() so
that it would be bypassed when not enabled.

>          } while (0);                                            \
>          RC;                                                     \
>   })
> 
> The assembly looks good from correctness and performance points.
> union security_list_options can be split into lsm_hook_names.h too
> to avoid __diag_ignore. Is that what you have in mind?
> I don't see how one can improve call_int_hook() macro without
> full refactoring of linux/lsm_hooks.h
> imo static_key doesn't have to be there in the first set. We can add this
> optimization later.

Yes, like the above diff looks good, and then we'd dynamically attach the program
at bpf_lsm_call_##FUNC()'s fexit hook for a direct jump, so all the security_blah()
internals could stay as-is which then might also address Jann's concerns wrt
concrete annotation as well as potential locking changes inside security_blah().
Agree that patching out via static key could be optional but since you were talking
about avoiding indirect jumps..

Thanks,
Daniel
