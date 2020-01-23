Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96E2D14717E
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2020 20:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgAWTJY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 14:09:24 -0500
Received: from sonic316-26.consmr.mail.ne1.yahoo.com ([66.163.187.152]:36944
        "EHLO sonic316-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729076AbgAWTJW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Jan 2020 14:09:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1579806559; bh=gv80GbpjkipMluT0DrCoBBltT4c7UVbFvrqY8WNlkEM=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=Rb1TJo3ZMT4huksRXpM8Iw5zx2gYmUzUhCXq/ipVySpedLopPvCLpLOsB+me4xprOCODDfbvXkHTU6i0gAeack3d2deKfc81876K91D+gCcS8i65NTw3nK+yHAEFkAvMMnG7PWjX7vCbN3wxSd9AJ1DngHorHBgg5s+ZFgiJY4SaR4/GuYeR/tEmue6ptx0cMrLbXwpd/D/5myjKYbjTtIGZyVjckIQlyAG42fwAYyyjJdgDMfQsT7Nijv9AqVow5XNyYX4+s57/8ql0wGlVVHszPcgGdvCrQvtpWdg+0BH1+fca9KBsIMq56zvEp4U/fTj0NJ1uXKleLtIIUPBp2Q==
X-YMail-OSG: 13lyeUcVM1lG7ztZoHF.X8uXkhOtZQ.mvO6XtnbMglRj4rYmff.TBvxnTQ3ZPFd
 _eKUmsWVO7F0bGeZAJ825sXXkThH5claB2EsBCn.1HKWKbzkSKsaSvTWfFDOxjmzg2jXiIK5kNnI
 La4sJ10qBSsXfmDk0ue2vjixPJkYOQboqbFQR3bEAbCS4Q5B1U2mlXTyZck.TA.IcmSIVuePbuqH
 zj_4hzxbDMyrjyz1gxn.XbPePO27Tb8YY99a_GaWrc7o0dZEngTuRVzJamO_74CeiX8BBHwlo6ad
 h.Uus.ilvtYF.nDIjMyzCpCREhKLzANsYuRYvBlFhb7Ypkq9HvjNmJSUFz_cD.yu6NG9zglu1mU4
 _WfhQjEwnkic.x5AZO5aZaBMU0N6HM8JBExDHclJ0YLF8bjblelrqSdVW09CwvmJT4x7v3hHtVr7
 7McfqfiqTeYeFRKkT2.hTcnSUu6KB1UJgqkLyprgO4VbyykUIwBIHJ0go86gS_AkjDbz_kWqNmji
 XEnFwq0wSYyjjQ67q4NxmnUcd4EbkuWnZOdNz84L11mggOGX_jlRoBQtDlu6wske9NE5Zp2xvzKs
 dMf68vcbaG5ClXVyxj4nprK1jdG5u5npPi6jAit3UVxY_TT27SFdf3ArpucQaxmiuqTc5tFqMCKC
 g.hDu7yzItHuMq_sB9XRTMjEgDc73b6c0rAHMMsdFh0g.bwd5Nnjk7oUODi_eyWA1t9wNf4io9wj
 vq7I.hQFAxUrLPeOpGQJ.ggrOFnr6fU6xDwgLZBm3TgTQpCCjyhm_9VqTvsIkhqJRGYtuF9RR6JS
 1xghEFS5GaXpNiURRh6sISVfQ3AnF3hh9J2vycYISCl8zh9TblRLrNcXiy56F_MY916HD68sOlwd
 pE2DIdckXzQR40VFQxfnKU8dnV5ddEaF7ACS1r6O4E86Kj6npV3hMVO1q6GmreRhTyX.OAyk1CFy
 Eel27qU_1s4sVyrBxQGkFwILSNV2L3pW77uYqXoxvMzYHoj6tpV6unBEcfUEGx0yVFqmCYK2EbuV
 mfRGdhHFUPLqKH8gIaYIqtB9RDssTTiFGqxzQGgZN0R0tBxqacyp9Miz9_BtJYiSBS99i8bmdcs9
 Gp4bu5H2Gnkayi60uTwQ_msh7fbtI2BK354zbzlKKiETaCY2xjpSA5k5qtdkzuSXY3YJUQOr2ZEe
 L0yeefw5INOVfRwaOEcxKT5A.cKN4YeVO0m.UkGerNvwFliyZGqLbFTptd3vXamh5B1J6M8WIagW
 kCkYj1Z2mgIY4IOiEa8loIFa3FAiGe6PMNd5TqTibBrRTJSYH3fIsp4YzwsKZE1LgsIrLnnNRPRf
 IUfvdiX.g7IqO98HHI3lXPSRqtCUr4xbteddlmbtZFn30dZxwupIGWoD_fIH6qLhB26DqDnxMniU
 _NYFhpBNrEU4kkAZu_yGsx1djV84sQQvHtPkqHjHWnlHJ
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Thu, 23 Jan 2020 19:09:19 +0000
Received: by smtp413.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ba26c755bb319cf136dcd3d33da92cd6;
          Thu, 23 Jan 2020 19:09:14 +0000 (UTC)
Subject: Re: [PATCH bpf-next v3 04/10] bpf: lsm: Add mutable hooks list for
 the BPF LSM
To:     KP Singh <kpsingh@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, bpf@vger.kernel.org
References: <20200123152440.28956-1-kpsingh@chromium.org>
 <20200123152440.28956-5-kpsingh@chromium.org>
 <29157a88-7049-906e-fe92-b7a1e2183c6b@schaufler-ca.com>
 <20200123175942.GA131348@google.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <5004b3f4-ca5b-a546-4e87-b852cc248079@schaufler-ca.com>
Date:   Thu, 23 Jan 2020 11:09:13 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200123175942.GA131348@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/23/2020 9:59 AM, KP Singh wrote:
> On 23-Jan 09:03, Casey Schaufler wrote:
>> On 1/23/2020 7:24 AM, KP Singh wrote:
>>> From: KP Singh <kpsingh@google.com>
>>>
>>> - The list of hooks registered by an LSM is currently immutable as th=
ey
>>>   are declared with __lsm_ro_after_init and they are attached to a
>>>   security_hook_heads struct.
>>> - For the BPF LSM we need to de/register the hooks at runtime. Making=

>>>   the existing security_hook_heads mutable broadens an
>>>   attack vector, so a separate security_hook_heads is added for only
>>>   those that ~must~ be mutable.
>>> - These mutable hooks are run only after all the static hooks have
>>>   successfully executed.
>>>
>>> This is based on the ideas discussed in:
>>>
>>>   https://lore.kernel.org/lkml/20180408065916.GA2832@ircssh-2.c.rugge=
d-nimbus-611.internal
>>>
>>> Reviewed-by: Brendan Jackman <jackmanb@google.com>
>>> Reviewed-by: Florent Revest <revest@google.com>
>>> Reviewed-by: Thomas Garnier <thgarnie@google.com>
>>> Signed-off-by: KP Singh <kpsingh@google.com>
>>> ---
>>>  MAINTAINERS             |  1 +
>>>  include/linux/bpf_lsm.h | 72 +++++++++++++++++++++++++++++++++++++++=
++
>>>  security/bpf/Kconfig    |  1 +
>>>  security/bpf/Makefile   |  2 +-
>>>  security/bpf/hooks.c    | 20 ++++++++++++
>>>  security/bpf/lsm.c      |  7 ++++
>>>  security/security.c     | 25 +++++++-------
>>>  7 files changed, 116 insertions(+), 12 deletions(-)
>>>  create mode 100644 include/linux/bpf_lsm.h
>>>  create mode 100644 security/bpf/hooks.c
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index e2b7f76a1a70..c606b3d89992 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -3209,6 +3209,7 @@ L:	linux-security-module@vger.kernel.org
>>>  L:	bpf@vger.kernel.org
>>>  S:	Maintained
>>>  F:	security/bpf/
>>> +F:	include/linux/bpf_lsm.h
>>> =20
>>>  BROADCOM B44 10/100 ETHERNET DRIVER
>>>  M:	Michael Chan <michael.chan@broadcom.com>
>>> diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
>>> new file mode 100644
>>> index 000000000000..57c20b2cd2f4
>>> --- /dev/null
>>> +++ b/include/linux/bpf_lsm.h
>>> @@ -0,0 +1,72 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +
>>> +/*
>>> + * Copyright 2019 Google LLC.
>>> + */
>>> +
>>> +#ifndef _LINUX_BPF_LSM_H
>>> +#define _LINUX_BPF_LSM_H
>>> +
>>> +#include <linux/bpf.h>
>>> +#include <linux/lsm_hooks.h>
>>> +
>>> +#ifdef CONFIG_SECURITY_BPF
>>> +
>>> +/* Mutable hooks defined at runtime and executed after all the stati=
cally
>>> + * defined LSM hooks.
>>> + */
>>> +extern struct security_hook_heads bpf_lsm_hook_heads;
>>> +
>>> +int bpf_lsm_srcu_read_lock(void);
>>> +void bpf_lsm_srcu_read_unlock(int idx);
>>> +
>>> +#define CALL_BPF_LSM_VOID_HOOKS(FUNC, ...)			\
>>> +	do {							\
>>> +		struct security_hook_list *P;			\
>>> +		int _idx;					\
>>> +								\
>>> +		if (hlist_empty(&bpf_lsm_hook_heads.FUNC))	\
>>> +			break;					\
>>> +								\
>>> +		_idx =3D bpf_lsm_srcu_read_lock();		\
>>> +		hlist_for_each_entry(P, &bpf_lsm_hook_heads.FUNC, list) \
>>> +			P->hook.FUNC(__VA_ARGS__);		\
>>> +		bpf_lsm_srcu_read_unlock(_idx);			\
>>> +	} while (0)
>>> +
>>> +#define CALL_BPF_LSM_INT_HOOKS(FUNC, ...) ({			\
>>> +	int _ret =3D 0;						\
>>> +	do {							\
>>> +		struct security_hook_list *P;			\
>>> +		int _idx;					\
>>> +								\
>>> +		if (hlist_empty(&bpf_lsm_hook_heads.FUNC))	\
>>> +			break;					\
>>> +								\
>>> +		_idx =3D bpf_lsm_srcu_read_lock();		\
>>> +								\
>>> +		hlist_for_each_entry(P,				\
>>> +			&bpf_lsm_hook_heads.FUNC, list) {	\
>>> +			_ret =3D P->hook.FUNC(__VA_ARGS__);		\
>>> +			if (_ret && IS_ENABLED(CONFIG_SECURITY_BPF_ENFORCE)) \
>>> +				break;				\
>>> +		}						\
>>> +		bpf_lsm_srcu_read_unlock(_idx);			\
>>> +	} while (0);						\
>>> +	IS_ENABLED(CONFIG_SECURITY_BPF_ENFORCE) ? _ret : 0;	\
>>> +})
>>> +
>>> +#else /* !CONFIG_SECURITY_BPF */
>>> +
>>> +#define CALL_BPF_LSM_INT_HOOKS(FUNC, ...) (0)
>>> +#define CALL_BPF_LSM_VOID_HOOKS(...)
>>> +
>>> +static inline int bpf_lsm_srcu_read_lock(void)
>>> +{
>>> +	return 0;
>>> +}
>>> +static inline void bpf_lsm_srcu_read_unlock(int idx) {}
>>> +
>>> +#endif /* CONFIG_SECURITY_BPF */
>>> +
>>> +#endif /* _LINUX_BPF_LSM_H */
>>> diff --git a/security/bpf/Kconfig b/security/bpf/Kconfig
>>> index a5f6c67ae526..595e4ad597ae 100644
>>> --- a/security/bpf/Kconfig
>>> +++ b/security/bpf/Kconfig
>>> @@ -6,6 +6,7 @@ config SECURITY_BPF
>>>  	bool "BPF-based MAC and audit policy"
>>>  	depends on SECURITY
>>>  	depends on BPF_SYSCALL
>>> +	depends on SRCU
>>>  	help
>>>  	  This enables instrumentation of the security hooks with
>>>  	  eBPF programs.
>>> diff --git a/security/bpf/Makefile b/security/bpf/Makefile
>>> index c78a8a056e7e..c526927c337d 100644
>>> --- a/security/bpf/Makefile
>>> +++ b/security/bpf/Makefile
>>> @@ -2,4 +2,4 @@
>>>  #
>>>  # Copyright 2019 Google LLC.
>>> =20
>>> -obj-$(CONFIG_SECURITY_BPF) :=3D lsm.o ops.o
>>> +obj-$(CONFIG_SECURITY_BPF) :=3D lsm.o ops.o hooks.o
>>> diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
>>> new file mode 100644
>>> index 000000000000..b123d9cb4cd4
>>> --- /dev/null
>>> +++ b/security/bpf/hooks.c
>>> @@ -0,0 +1,20 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +/*
>>> + * Copyright 2019 Google LLC.
>>> + */
>>> +
>>> +#include <linux/bpf_lsm.h>
>>> +#include <linux/srcu.h>
>>> +
>>> +DEFINE_STATIC_SRCU(security_hook_srcu);
>>> +
>>> +int bpf_lsm_srcu_read_lock(void)
>>> +{
>>> +	return srcu_read_lock(&security_hook_srcu);
>>> +}
>>> +
>>> +void bpf_lsm_srcu_read_unlock(int idx)
>>> +{
>>> +	return srcu_read_unlock(&security_hook_srcu, idx);
>>> +}
>>> diff --git a/security/bpf/lsm.c b/security/bpf/lsm.c
>>> index dc9ac03c7aa0..a25a068e1781 100644
>>> --- a/security/bpf/lsm.c
>>> +++ b/security/bpf/lsm.c
>>> @@ -4,6 +4,7 @@
>>>   * Copyright 2019 Google LLC.
>>>   */
>>> =20
>>> +#include <linux/bpf_lsm.h>
>>>  #include <linux/lsm_hooks.h>
>>> =20
>>>  /* This is only for internal hooks, always statically shipped as par=
t of the
>>> @@ -12,6 +13,12 @@
>>>   */
>>>  static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init=
 =3D {};
>>> =20
>>> +/* Security hooks registered dynamically by the BPF LSM and must be =
accessed
>>> + * by holding bpf_lsm_srcu_read_lock and bpf_lsm_srcu_read_unlock. T=
he mutable
>>> + * hooks dynamically allocated by the BPF LSM are appeneded here.
>>> + */
>>> +struct security_hook_heads bpf_lsm_hook_heads;
>>> +
>>>  static int __init bpf_lsm_init(void)
>>>  {
>>>  	security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks), "bpf")=
;
>>> diff --git a/security/security.c b/security/security.c
>>> index 30a8aa700557..95a46ca25dcd 100644
>>> --- a/security/security.c
>>> +++ b/security/security.c
>>> @@ -27,6 +27,7 @@
>>>  #include <linux/backing-dev.h>
>>>  #include <linux/string.h>
>>>  #include <linux/msg.h>
>>> +#include <linux/bpf_lsm.h>
>>>  #include <net/flow.h>
>>> =20
>>>  #define MAX_LSM_EVM_XATTR	2
>>> @@ -657,20 +658,22 @@ static void __init lsm_early_task(struct task_s=
truct *task)
>>>  								\
>>>  		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) \
>>>  			P->hook.FUNC(__VA_ARGS__);		\
>>> +		CALL_BPF_LSM_VOID_HOOKS(FUNC, __VA_ARGS__);	\
>> I'm sorry if I wasn't clear on the v2 review.
>> This does not belong in the infrastructure. You should be
>> doing all the bpf_lsm hook processing in you module.
>> bpf_lsm_task_alloc() should loop though all the bpf
>> task_alloc hooks if they have to be handled differently
>> from "normal" LSM hooks.
> The BPF LSM does not define static hooks (the ones registered to
> security_hook_heads in security.c with __lsm_ro_after_init) for each
> LSM hook. If it tries to do that one ends with what was in v1:
>
>   https://lore.kernel.org/bpf/20191220154208.15895-7-kpsingh@chromium.o=
rg
>
> This gets quite ugly (security/bpf/hooks.h from v1) and was noted by
> the BPF maintainers:
>
>   https://lore.kernel.org/bpf/20191222012722.gdqhppxpfmqfqbld@ast-mbp.d=
hcp.thefacebook.com/
>
> As I mentioned, some of the ideas we used here are based on:
>
>   https://lore.kernel.org/lkml/20180408065916.GA2832@ircssh-2.c.rugged-=
nimbus-611.internal
>
> Which gave each LSM the ability to add mutable hooks at runtime. If
> you prefer we can make this generic and allow the LSMs to register
> mutable hooks with the BPF LSM be the only LSM that uses it (and
> enforce it with a whitelist).
>
> Would this generic approach be something you would consider better
> than just calling the BPF mutable hooks directly?

What I think makes sense is for the BPF LSM to have a hook
for each of the interfaces and for that hook to handle the
mutable list for the interface. If BPF not included there
will be no mutable hooks.=20

Yes, your v1 got this right.

>
> - KP
>
>>>  	} while (0)
>>> =20
>>> -#define call_int_hook(FUNC, IRC, ...) ({			\
>>> -	int RC =3D IRC;						\
>>> -	do {							\
>>> -		struct security_hook_list *P;			\
>>> -								\
>>> +#define call_int_hook(FUNC, IRC, ...) ({				\
>>> +	int RC =3D IRC;							\
>>> +	do {								\
>>> +		struct security_hook_list *P;				\
>>>  		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
>>> -			RC =3D P->hook.FUNC(__VA_ARGS__);		\
>>> -			if (RC !=3D 0)				\
>>> -				break;				\
>>> -		}						\
>>> -	} while (0);						\
>>> -	RC;							\
>>> +			RC =3D P->hook.FUNC(__VA_ARGS__);			\
>>> +			if (RC !=3D 0)					\
>>> +				break;					\
>>> +		}							\
>>> +		if (RC =3D=3D 0)						\
>>> +			RC =3D CALL_BPF_LSM_INT_HOOKS(FUNC, __VA_ARGS__);	\
>>> +	} while (0);							\
>>> +	RC;								\
>>>  })
>>> =20
>>>  /* Security operations */

