Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9460B147505
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2020 00:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbgAWXuh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 18:50:37 -0500
Received: from sonic305-28.consmr.mail.ne1.yahoo.com ([66.163.185.154]:44111
        "EHLO sonic305-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729659AbgAWXuh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Jan 2020 18:50:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1579823434; bh=AZ8XDyA8mdEEn6XXq23Kda3A5Cp88RgAxBGpvcWOyjc=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=ebcEk/n+QoAm0tfRFhruj74ZYSfn9Jlm0cJFDarKhyA6pVoFyEjZBisKXPMnGObLTMZy8jDJ0FpLRhx7dKXpQdgccuvQnIq/l+dtQf32mzql0nKjLJXuwCiktVilX4cvfCzTzu3uhzxdfdjXHt4LkCFjvaj1gB8GDy49NfkDniRI7Y9DQRgYa36sBsvfxxtxXA0dCZU9+A+nIoGj+20HO7lFLpjfm1TSUn0dTwL7hRpvMli719UsyLkN+IJMwABZV2kc4zawNBcW/bLeS6vfiXnUzSNa1AmWXF7wMFu9TzGNDxnJB4P4v57Xf8LBdzCJcqwfIrSDBYlb71IJJuH6uQ==
X-YMail-OSG: wvHAuNEVM1lTpTsTNsOq3HIQthREXq.Ulhxaq8ZDS80bdkbitVb8GS8ZgWyptlj
 WCVGzESMIUBD1jWJ9.THjBIBdR8Mn5kSAVM71HbqAju42dzuswUb_XTsMavtbkH3i0OxFi33Ky2w
 xcLIASK8SolyDzRaEmS3Qd6jboqQ8wwT7jFNFwHwoYm5gnTIs6c7AflGXHXzyc8Iexmi5gPWH_2Y
 2d3jolZ1TipP5x64PcHHWFTGYkeZ2N.Xkwjr4rzKBGNHWmgrL75fQJ0dGT.jtxfSWxx5jp.H.Ih_
 KpwuJQOejyKN7JRZ9gOIg7WU86.xH6BMTQoxFf03ldK_buT8ucajKR4n3WFcOBUX1mukOVjQJdMC
 gg5Iykm7zjGGItSVk5vDarq2nUKz7DIoT4L88a0u7ePwekHTjLFFpowQX31JB4RVMZb8XuOCm6Du
 ZxAsxZMRiD6y82tn4QTWR.kH.6nq9J.C8aQh4iycmsSZuCDtHjp6EemeR4fFB6uinGVSF5GaqVC3
 B0wUrMFDyhtxm8E1sVx4k5r2bYspwQ5nZgP6nj9WfQg9qDpxZpWTzVV0Le88n.Bd6Qe6EibdmVZ.
 XWgI2EvYJynuBCCvPqjs9SAw88OFr12lCKuCcr6BG4DPv9.z.9.wdaeTlxYh5niUMKOJm3kfhk09
 Nv3II_VoXsGbOBY6pqVM2KYopj3YnJGY.GSmUsxWqvZNDUHeDn0UkKb43kF08Ofz0irc7Qfxa8Eg
 PbeapZJkgeBgk0iIdlyJtFwh5dbO5qRPfCTMx14HVBjlhA.OgDom7NSxXye2pOFs2j2i0mPNcHv2
 rYRmxYb7CL9kHOuM.ZWpPWS1vw1sSHBFiTeb7qik.cB2KYU1e5gm5TCeOR.8c3BCHq5i64yFr4d_
 k2pos_DSUKzCmDmgA5cYQ1qcVItEYFdsZ10yTQP.kryGkzC1PMcH1rZ9nLmoUHbcTXyPCdN5YxSE
 l_jfwq6Jj4c7Zjkm3xgTMkG3Ed.gh5SCoE0UV4VWZ9qtxOq3siGKDj9tPqudXeSNbHddqw0Ew0gF
 dCsH96UaJL0JbvyAk4xhlRsaqJgfI7zph2BnHA9veDWZAutzUFTvM752fjBuIW9_2SEcDj.5Fvp1
 s.FnTjsLU2tdXCp.TP9BHcno.4wWsPZfBwaq6AmK8Sloy47gc.XjGySmlXJT0XKAEeacE6t1HMU5
 kGziQK8u3mP7YfjrCdAF81Z0ydDyjb0.VWAEZaJ5DCQp8.Ex2OH6lLwzbcfivWh0vRdzFGnXDaPe
 WXB.UaHsJJDQQqkg97pzZQmjXPV2bgUWwWihksm__6mlP9sVRQku1A8QXaQGEKWg_sEHJgIu5ZxJ
 JY68taYNz7G7DbqpGqHybuEZp4QYcyZaHGLtUe80q.amScxpJcmNw.oD7to5Rn8mJb0kBabHy_Un
 YkLdPKPxs03wZBllVYAA_ekhXy0qkiW2nqNdEdLgZthXMkTMB5Q--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Thu, 23 Jan 2020 23:50:34 +0000
Received: by smtp420.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 9cc78e19df46886fe420010c17c38cf2;
          Thu, 23 Jan 2020 23:50:30 +0000 (UTC)
Subject: Re: [PATCH bpf-next v3 04/10] bpf: lsm: Add mutable hooks list for
 the BPF LSM
To:     KP Singh <kpsingh@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, bpf@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200123152440.28956-1-kpsingh@chromium.org>
 <20200123152440.28956-5-kpsingh@chromium.org>
 <29157a88-7049-906e-fe92-b7a1e2183c6b@schaufler-ca.com>
 <20200123175942.GA131348@google.com>
 <5004b3f4-ca5b-a546-4e87-b852cc248079@schaufler-ca.com>
 <20200123222436.GA1598@chromium.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <f571b719-e11f-416e-4232-f99036e38f15@schaufler-ca.com>
Date:   Thu, 23 Jan 2020 15:50:30 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200123222436.GA1598@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/23/2020 2:24 PM, KP Singh wrote:
> On 23-Jan 11:09, Casey Schaufler wrote:
>> On 1/23/2020 9:59 AM, KP Singh wrote:
>>> On 23-Jan 09:03, Casey Schaufler wrote:
>>>> On 1/23/2020 7:24 AM, KP Singh wrote:
>>>>> From: KP Singh <kpsingh@google.com>
>>>>>
>>>>> - The list of hooks registered by an LSM is currently immutable as =
they
>>>>>   are declared with __lsm_ro_after_init and they are attached to a
>>>>>   security_hook_heads struct.
>>>>> - For the BPF LSM we need to de/register the hooks at runtime. Maki=
ng
>>>>>   the existing security_hook_heads mutable broadens an
>>>>>   attack vector, so a separate security_hook_heads is added for onl=
y
>>>>>   those that ~must~ be mutable.
>>>>> - These mutable hooks are run only after all the static hooks have
>>>>>   successfully executed.
>>>>>
>>>>> This is based on the ideas discussed in:
>>>>>
>>>>>   https://lore.kernel.org/lkml/20180408065916.GA2832@ircssh-2.c.rug=
ged-nimbus-611.internal
>>>>>
>>>>> Reviewed-by: Brendan Jackman <jackmanb@google.com>
>>>>> Reviewed-by: Florent Revest <revest@google.com>
>>>>> Reviewed-by: Thomas Garnier <thgarnie@google.com>
>>>>> Signed-off-by: KP Singh <kpsingh@google.com>
>>>>> ---
>>>>>  MAINTAINERS             |  1 +
>>>>>  include/linux/bpf_lsm.h | 72 +++++++++++++++++++++++++++++++++++++=
++++
>>>>>  security/bpf/Kconfig    |  1 +
>>>>>  security/bpf/Makefile   |  2 +-
>>>>>  security/bpf/hooks.c    | 20 ++++++++++++
>>>>>  security/bpf/lsm.c      |  7 ++++
>>>>>  security/security.c     | 25 +++++++-------
>>>>>  7 files changed, 116 insertions(+), 12 deletions(-)
>>>>>  create mode 100644 include/linux/bpf_lsm.h
>>>>>  create mode 100644 security/bpf/hooks.c
>>>>>
>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>> index e2b7f76a1a70..c606b3d89992 100644
>>>>> --- a/MAINTAINERS
>>>>> +++ b/MAINTAINERS
>>>>> @@ -3209,6 +3209,7 @@ L:	linux-security-module@vger.kernel.org
>>>>>  L:	bpf@vger.kernel.org
>>>>>  S:	Maintained
>>>>>  F:	security/bpf/
>>>>> +F:	include/linux/bpf_lsm.h
>>>>> =20
>>>>>  BROADCOM B44 10/100 ETHERNET DRIVER
>>>>>  M:	Michael Chan <michael.chan@broadcom.com>
>>>>> diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
>>>>> new file mode 100644
>>>>> index 000000000000..57c20b2cd2f4
>>>>> --- /dev/null
>>>>> +++ b/include/linux/bpf_lsm.h
>>>>> @@ -0,0 +1,72 @@
>>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>>> +
>>>>> +/*
>>>>> + * Copyright 2019 Google LLC.
>>>>> + */
>>>>> +
>>>>> +#ifndef _LINUX_BPF_LSM_H
>>>>> +#define _LINUX_BPF_LSM_H
>>>>> +
>>>>> +#include <linux/bpf.h>
>>>>> +#include <linux/lsm_hooks.h>
>>>>> +
>>>>> +#ifdef CONFIG_SECURITY_BPF
>>>>> +
>>>>> +/* Mutable hooks defined at runtime and executed after all the sta=
tically
>>>>> + * defined LSM hooks.
>>>>> + */
>>>>> +extern struct security_hook_heads bpf_lsm_hook_heads;
>>>>> +
>>>>> +int bpf_lsm_srcu_read_lock(void);
>>>>> +void bpf_lsm_srcu_read_unlock(int idx);
>>>>> +
>>>>> +#define CALL_BPF_LSM_VOID_HOOKS(FUNC, ...)			\
>>>>> +	do {							\
>>>>> +		struct security_hook_list *P;			\
>>>>> +		int _idx;					\
>>>>> +								\
>>>>> +		if (hlist_empty(&bpf_lsm_hook_heads.FUNC))	\
>>>>> +			break;					\
>>>>> +								\
>>>>> +		_idx =3D bpf_lsm_srcu_read_lock();		\
>>>>> +		hlist_for_each_entry(P, &bpf_lsm_hook_heads.FUNC, list) \
>>>>> +			P->hook.FUNC(__VA_ARGS__);		\
>>>>> +		bpf_lsm_srcu_read_unlock(_idx);			\
>>>>> +	} while (0)
>>>>> +
>>>>> +#define CALL_BPF_LSM_INT_HOOKS(FUNC, ...) ({			\
>>>>> +	int _ret =3D 0;						\
>>>>> +	do {							\
>>>>> +		struct security_hook_list *P;			\
>>>>> +		int _idx;					\
>>>>> +								\
>>>>> +		if (hlist_empty(&bpf_lsm_hook_heads.FUNC))	\
>>>>> +			break;					\
>>>>> +								\
>>>>> +		_idx =3D bpf_lsm_srcu_read_lock();		\
>>>>> +								\
>>>>> +		hlist_for_each_entry(P,				\
>>>>> +			&bpf_lsm_hook_heads.FUNC, list) {	\
>>>>> +			_ret =3D P->hook.FUNC(__VA_ARGS__);		\
>>>>> +			if (_ret && IS_ENABLED(CONFIG_SECURITY_BPF_ENFORCE)) \
>>>>> +				break;				\
>>>>> +		}						\
>>>>> +		bpf_lsm_srcu_read_unlock(_idx);			\
>>>>> +	} while (0);						\
>>>>> +	IS_ENABLED(CONFIG_SECURITY_BPF_ENFORCE) ? _ret : 0;	\
>>>>> +})
>>>>> +
>>>>> +#else /* !CONFIG_SECURITY_BPF */
>>>>> +
>>>>> +#define CALL_BPF_LSM_INT_HOOKS(FUNC, ...) (0)
>>>>> +#define CALL_BPF_LSM_VOID_HOOKS(...)
>>>>> +
>>>>> +static inline int bpf_lsm_srcu_read_lock(void)
>>>>> +{
>>>>> +	return 0;
>>>>> +}
>>>>> +static inline void bpf_lsm_srcu_read_unlock(int idx) {}
>>>>> +
>>>>> +#endif /* CONFIG_SECURITY_BPF */
>>>>> +
>>>>> +#endif /* _LINUX_BPF_LSM_H */
>>>>> diff --git a/security/bpf/Kconfig b/security/bpf/Kconfig
>>>>> index a5f6c67ae526..595e4ad597ae 100644
>>>>> --- a/security/bpf/Kconfig
>>>>> +++ b/security/bpf/Kconfig
>>>>> @@ -6,6 +6,7 @@ config SECURITY_BPF
>>>>>  	bool "BPF-based MAC and audit policy"
>>>>>  	depends on SECURITY
>>>>>  	depends on BPF_SYSCALL
>>>>> +	depends on SRCU
>>>>>  	help
>>>>>  	  This enables instrumentation of the security hooks with
>>>>>  	  eBPF programs.
>>>>> diff --git a/security/bpf/Makefile b/security/bpf/Makefile
>>>>> index c78a8a056e7e..c526927c337d 100644
>>>>> --- a/security/bpf/Makefile
>>>>> +++ b/security/bpf/Makefile
>>>>> @@ -2,4 +2,4 @@
>>>>>  #
>>>>>  # Copyright 2019 Google LLC.
>>>>> =20
>>>>> -obj-$(CONFIG_SECURITY_BPF) :=3D lsm.o ops.o
>>>>> +obj-$(CONFIG_SECURITY_BPF) :=3D lsm.o ops.o hooks.o
>>>>> diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
>>>>> new file mode 100644
>>>>> index 000000000000..b123d9cb4cd4
>>>>> --- /dev/null
>>>>> +++ b/security/bpf/hooks.c
>>>>> @@ -0,0 +1,20 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>> +
>>>>> +/*
>>>>> + * Copyright 2019 Google LLC.
>>>>> + */
>>>>> +
>>>>> +#include <linux/bpf_lsm.h>
>>>>> +#include <linux/srcu.h>
>>>>> +
>>>>> +DEFINE_STATIC_SRCU(security_hook_srcu);
>>>>> +
>>>>> +int bpf_lsm_srcu_read_lock(void)
>>>>> +{
>>>>> +	return srcu_read_lock(&security_hook_srcu);
>>>>> +}
>>>>> +
>>>>> +void bpf_lsm_srcu_read_unlock(int idx)
>>>>> +{
>>>>> +	return srcu_read_unlock(&security_hook_srcu, idx);
>>>>> +}
>>>>> diff --git a/security/bpf/lsm.c b/security/bpf/lsm.c
>>>>> index dc9ac03c7aa0..a25a068e1781 100644
>>>>> --- a/security/bpf/lsm.c
>>>>> +++ b/security/bpf/lsm.c
>>>>> @@ -4,6 +4,7 @@
>>>>>   * Copyright 2019 Google LLC.
>>>>>   */
>>>>> =20
>>>>> +#include <linux/bpf_lsm.h>
>>>>>  #include <linux/lsm_hooks.h>
>>>>> =20
>>>>>  /* This is only for internal hooks, always statically shipped as p=
art of the
>>>>> @@ -12,6 +13,12 @@
>>>>>   */
>>>>>  static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_in=
it =3D {};
>>>>> =20
>>>>> +/* Security hooks registered dynamically by the BPF LSM and must b=
e accessed
>>>>> + * by holding bpf_lsm_srcu_read_lock and bpf_lsm_srcu_read_unlock.=
 The mutable
>>>>> + * hooks dynamically allocated by the BPF LSM are appeneded here.
>>>>> + */
>>>>> +struct security_hook_heads bpf_lsm_hook_heads;
>>>>> +
>>>>>  static int __init bpf_lsm_init(void)
>>>>>  {
>>>>>  	security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks), "bpf=
");
>>>>> diff --git a/security/security.c b/security/security.c
>>>>> index 30a8aa700557..95a46ca25dcd 100644
>>>>> --- a/security/security.c
>>>>> +++ b/security/security.c
>>>>> @@ -27,6 +27,7 @@
>>>>>  #include <linux/backing-dev.h>
>>>>>  #include <linux/string.h>
>>>>>  #include <linux/msg.h>
>>>>> +#include <linux/bpf_lsm.h>
>>>>>  #include <net/flow.h>
>>>>> =20
>>>>>  #define MAX_LSM_EVM_XATTR	2
>>>>> @@ -657,20 +658,22 @@ static void __init lsm_early_task(struct task=
_struct *task)
>>>>>  								\
>>>>>  		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) \
>>>>>  			P->hook.FUNC(__VA_ARGS__);		\
>>>>> +		CALL_BPF_LSM_VOID_HOOKS(FUNC, __VA_ARGS__);	\
>>>> I'm sorry if I wasn't clear on the v2 review.
>>>> This does not belong in the infrastructure. You should be
>>>> doing all the bpf_lsm hook processing in you module.
>>>> bpf_lsm_task_alloc() should loop though all the bpf
>>>> task_alloc hooks if they have to be handled differently
>>>> from "normal" LSM hooks.
>>> The BPF LSM does not define static hooks (the ones registered to
>>> security_hook_heads in security.c with __lsm_ro_after_init) for each
>>> LSM hook. If it tries to do that one ends with what was in v1:
>>>
>>>   https://lore.kernel.org/bpf/20191220154208.15895-7-kpsingh@chromium=
=2Eorg
>>>
>>> This gets quite ugly (security/bpf/hooks.h from v1) and was noted by
>>> the BPF maintainers:
>>>
>>>   https://lore.kernel.org/bpf/20191222012722.gdqhppxpfmqfqbld@ast-mbp=
=2Edhcp.thefacebook.com/
>>>
>>> As I mentioned, some of the ideas we used here are based on:
>>>
>>>   https://lore.kernel.org/lkml/20180408065916.GA2832@ircssh-2.c.rugge=
d-nimbus-611.internal
>>>
>>> Which gave each LSM the ability to add mutable hooks at runtime. If
>>> you prefer we can make this generic and allow the LSMs to register
>>> mutable hooks with the BPF LSM be the only LSM that uses it (and
>>> enforce it with a whitelist).
>>>
>>> Would this generic approach be something you would consider better
>>> than just calling the BPF mutable hooks directly?
>> What I think makes sense is for the BPF LSM to have a hook
>> for each of the interfaces and for that hook to handle the
>> mutable list for the interface. If BPF not included there
>> will be no mutable hooks.=20
>>
>> Yes, your v1 got this right.
> BPF LSM does provide mutable LSM hooks and it ends up being simpler
> to implement/maintain when they are treated as such.

If you want to put mutable hook handling in the infrastructure
you need to make it general mutable hook handling as opposed to
BPF hook handling. I don't know if that would be acceptable for
all the reasons called out about dynamic module loading.

>
>  The other approaches which we have considered are:
>
> - Using macro magic to allocate static hook bodies which call eBPF
>   programs as implemented in v1. This entails maintaining a
>   separate list of LSM hooks in the BPF LSM which is evident from the
>   giant security/bpf/include/hooks.h in:
>
>   https://lore.kernel.org/bpf/20191220154208.15895-7-kpsingh@chromium.o=
rg

I haven't put much though into how you might make that cleaner,
but I don't see how you can expect any approach to turn out
smaller than or less ugly than security.c.

>
> - Another approach one can think of is to allocate all the trampoline
>   images (one page each) at __init and update these images to invoke
>   BPF programs when they are attached.
>
> Both these approaches seem to suffer from the downside of doing more
> work when it's not really needed (i.e. doing prep work for hooks which
> have no eBPF programs attached) and they appear to to mask the fact
> that what the BPF LSM provides is actually mutable LSM hooks by
> allocating static wrappers around mutable callbacks.

That's a "feature" of the LSM infrastructure. If you're not using a hook
you just don't provide one. It is a artifact of your intent of providing
a general extension that requires you provide a hook which may do nothing=

for every interface.

>
> Are there other downsides apart from the fact we have an explicit call
> to the mutable hooks in the LSM code? (Note that we want to have these
> mutable hooks run after all the static LSM hooks so ordering
> would still end up being LSM_ORDER_LAST)

My intention when I suggested using LSM_ORDER_LAST was to
remove the explicit calls to BPF in the infrastructure.

>
> It would be great to hear the maintainers' perspective based on the
> trade-offs involved with the different approaches discussed.

Please bear in mind that the maintainer (James Morris) didn't
develop the hook list scheme.

> We are happy to adapt our approach based on the consensus we reach
> here.
>
> - KP
>
>>> - KP
>>>
>>>>>  	} while (0)
>>>>> =20
>>>>> -#define call_int_hook(FUNC, IRC, ...) ({			\
>>>>> -	int RC =3D IRC;						\
>>>>> -	do {							\
>>>>> -		struct security_hook_list *P;			\
>>>>> -								\
>>>>> +#define call_int_hook(FUNC, IRC, ...) ({				\
>>>>> +	int RC =3D IRC;							\
>>>>> +	do {								\
>>>>> +		struct security_hook_list *P;				\
>>>>>  		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
>>>>> -			RC =3D P->hook.FUNC(__VA_ARGS__);		\
>>>>> -			if (RC !=3D 0)				\
>>>>> -				break;				\
>>>>> -		}						\
>>>>> -	} while (0);						\
>>>>> -	RC;							\
>>>>> +			RC =3D P->hook.FUNC(__VA_ARGS__);			\
>>>>> +			if (RC !=3D 0)					\
>>>>> +				break;					\
>>>>> +		}							\
>>>>> +		if (RC =3D=3D 0)						\
>>>>> +			RC =3D CALL_BPF_LSM_INT_HOOKS(FUNC, __VA_ARGS__);	\
>>>>> +	} while (0);							\
>>>>> +	RC;								\
>>>>>  })
>>>>> =20
>>>>>  /* Security operations */

