Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF0AC18FFBE
	for <lists+bpf@lfdr.de>; Mon, 23 Mar 2020 21:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgCWUre (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Mar 2020 16:47:34 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com ([66.163.186.211]:36939
        "EHLO sonic310-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726145AbgCWUre (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 23 Mar 2020 16:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1584996452; bh=7Q91aiE4rFiKsFv4/8Et+8SX35Ktzhult4cEA7Ku6uY=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=VhBNvBYqlpgwd1HYJJny3nPGyY/O2s2IHFcKiPZQSYfHWyp2hEyHfqNcL/MlfmBVwNxoclR8V9Gq7AUrorTaJ8nWtl3rvAIk0YL5vLQgd4e8tH9P557p2rkCNiuBBoIGg11BPeqE9MgEHANeFNaDlr+XJtcGXSNZZzYBtz6QGI2TdEAgCo1P7mTq7polNHHAW6R40vGRWvUsE/N4EtvTqT7bXIuxOUY/WQMpn/XY2uyCuk5zoX9d5M+84gEqeW/sGGRdc4ZdulQS6CPKpfXMLXkqFNpxGFXpZBOwz9tlOV7q00WcSBL3ETE/LxGXXMpGCWTa9OlWyWYC7jR2lhj74g==
X-YMail-OSG: 70TLNYAVM1nhPMew0yp2AgZ0iUX9b8y1ZAwqKq_MvUt1wwEZOCBfxdxymHrAl8s
 GZGT2CEr5jCAXi2UgzndzWyQ9rImG7wc5Rp5By7dStr4WmHlImkAqmXSH3X2PCqg7LZ2fw8uDq3P
 mHSMiFNSVji4BOc6lhNBWw_AmA_F6CeC.L4E.0.WWP9ZZm3hzFPPvNgRmO5plWVopKV9zzpNSwD_
 DlRlcQ.DtwSZS8FxV2riAEOhaqW4xny1azw7Ma7ym8jOO7hpRbnK8VzcVy3kmzyUvmCi1MQ4RXKy
 XOfnWea24.s9.tBguJOCbL4kinaAidak5Gs6Dm.zek2IvXHqxVSDIVb980h5NzSF9dABH9HAchXU
 Mqdnfb_D3Z_PrGsgz9lj8frxPGpHk4z.GcF421c8GNCg_iyJbNXrK.ygTaSYktFwl6rPokRR93y0
 nj8ezzdmYDNCJ_q5KxPbVZ2zfHDfGp3IWWyuzqVpc7V_202Ww5C28HvG5PvfUA7wCNP4yRpJs_ZM
 nNBUThIYaYNTK0MyQ8_t5wXXDOSMRc9mbdAQWrq8OM7n5fRYDrtS.OBLmB_M1U4PJAdV.fpcnvkJ
 4zB_T4APqnlJlyP47plxgWlnl6E1dcUsa0D.OyHgPZjO6D52Ywma9cEAb3zo7NLI6a1YdHFM6ixF
 hAQCtL.TuXQD1FSkyc2X4F7L70EIavgm54at1HDnNlLeRslaT1qBC6URNoXX8xsmAzczBI8w3Jpx
 iAOwj1nEt43XlzAbG3M9xAeesiIc1pvlkr2auAW3SLl2klndPtbp3ohiMkTYaGe87OZ_q18.MD8z
 3WyntLBZOmqo4bfeXVKSpRASWxVLUgXUS.sHe9_O4c6rIyDoRew957ao_7peexOXDewdQevQVvL9
 3oGKAQC6sowDXwpXGtBJcl2NE_U32rBRd3X.4Fy5LufqHiNIjwt1VDVkUqLQAnMj2_X5_Y3gBxlR
 sKEGLV34_qJj_YxvvLudaiuRbQ9fZlKVAmrMWWFhgrmtT2GOKlK5HuegzYvr4Y17pakyW6E8ypm.
 szLPAFcKu_Mzp9GafUeA3zKUocozjY30KtGBU5gDp.tjAdTocQBUfMHz3x3HOJbTe_MiBMSIEWbR
 xfrUMoDjFhR1X8mJkQ0pPgMdKGeX5yiMxqNwfu9pnorYBunE0_kBNHjkgDHCqEUjR8R5B3p5LGDu
 nb4xX8PTGgBVLNZhbROlsJTxSuxvfVCR0OC0XPGCx7hZeBhOBKIcP6MNK7sC.iCwOicGUQYy3dwn
 c6dX43.iB4yf_59nd4IHhPud6GcDKtBCfZUsEMNYHFJuHrwEtmoG5tqs1MYQ2opvXGML.5QJcdRK
 r34BJIQ9bz3mabF83gaRLQjLIU6_A79k6yO1F6Cmm_0yY.9B7eCw1kQYButm3TRpWRduml_y9QrX
 hTG_cbsdelaZYNoiV105rbztUqYOCGHR6Qo1w
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Mon, 23 Mar 2020 20:47:32 +0000
Received: by smtp432.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID f2519a3a28c5deca2168a06d076f32a1;
          Mon, 23 Mar 2020 20:47:31 +0000 (UTC)
Subject: Re: [PATCH bpf-next v5 5/7] bpf: lsm: Initialize the BPF LSM hooks
To:     Kees Cook <keescook@chromium.org>, KP Singh <kpsingh@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200323164415.12943-1-kpsingh@chromium.org>
 <20200323164415.12943-6-kpsingh@chromium.org>
 <202003231237.F654B379@keescook>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <0655d820-4c42-cf9a-23d3-82dc4fdeeceb@schaufler-ca.com>
Date:   Mon, 23 Mar 2020 13:47:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <202003231237.F654B379@keescook>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.15518 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_242)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/23/2020 12:44 PM, Kees Cook wrote:
> On Mon, Mar 23, 2020 at 05:44:13PM +0100, KP Singh wrote:
>> From: KP Singh <kpsingh@google.com>
>>
>> The bpf_lsm_ nops are initialized into the LSM framework like any othe=
r
>> LSM.  Some LSM hooks do not have 0 as their default return value. The
>> __weak symbol for these hooks is overridden by a corresponding
>> definition in security/bpf/hooks.c
>>
>> The LSM can be enabled / disabled with CONFIG_LSM.
>>
>> Signed-off-by: KP Singh <kpsingh@google.com>
> Nice! This is super clean on the LSM side of things. :)
>
> One note below...
>
>> Reviewed-by: Brendan Jackman <jackmanb@google.com>
>> Reviewed-by: Florent Revest <revest@google.com>
>> ---
>>  security/Kconfig      | 10 ++++----
>>  security/Makefile     |  2 ++
>>  security/bpf/Makefile |  5 ++++
>>  security/bpf/hooks.c  | 55 ++++++++++++++++++++++++++++++++++++++++++=
+
>>  4 files changed, 67 insertions(+), 5 deletions(-)
>>  create mode 100644 security/bpf/Makefile
>>  create mode 100644 security/bpf/hooks.c
>>
>> diff --git a/security/Kconfig b/security/Kconfig
>> index 2a1a2d396228..cd3cc7da3a55 100644
>> --- a/security/Kconfig
>> +++ b/security/Kconfig
>> @@ -277,11 +277,11 @@ endchoice
>> =20
>>  config LSM
>>  	string "Ordered list of enabled LSMs"
>> -	default "lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tom=
oyo,apparmor" if DEFAULT_SECURITY_SMACK
>> -	default "lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,=
smack,tomoyo" if DEFAULT_SECURITY_APPARMOR
>> -	default "lockdown,yama,loadpin,safesetid,integrity,tomoyo" if DEFAUL=
T_SECURITY_TOMOYO
>> -	default "lockdown,yama,loadpin,safesetid,integrity" if DEFAULT_SECUR=
ITY_DAC
>> -	default "lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tom=
oyo,apparmor"
>> +	default "lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tom=
oyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
>> +	default "lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,=
smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
>> +	default "lockdown,yama,loadpin,safesetid,integrity,tomoyo,bpf" if DE=
FAULT_SECURITY_TOMOYO
>> +	default "lockdown,yama,loadpin,safesetid,integrity,bpf" if DEFAULT_S=
ECURITY_DAC
>> +	default "lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tom=
oyo,apparmor,bpf"
>>  	help
>>  	  A comma-separated list of LSMs, in initialization order.
>>  	  Any LSMs left off this list will be ignored. This can be
>> diff --git a/security/Makefile b/security/Makefile
>> index 746438499029..22e73a3482bd 100644
>> --- a/security/Makefile
>> +++ b/security/Makefile
>> @@ -12,6 +12,7 @@ subdir-$(CONFIG_SECURITY_YAMA)		+=3D yama
>>  subdir-$(CONFIG_SECURITY_LOADPIN)	+=3D loadpin
>>  subdir-$(CONFIG_SECURITY_SAFESETID)    +=3D safesetid
>>  subdir-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+=3D lockdown
>> +subdir-$(CONFIG_BPF_LSM)		+=3D bpf
>> =20
>>  # always enable default capabilities
>>  obj-y					+=3D commoncap.o
>> @@ -30,6 +31,7 @@ obj-$(CONFIG_SECURITY_LOADPIN)		+=3D loadpin/
>>  obj-$(CONFIG_SECURITY_SAFESETID)       +=3D safesetid/
>>  obj-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+=3D lockdown/
>>  obj-$(CONFIG_CGROUP_DEVICE)		+=3D device_cgroup.o
>> +obj-$(CONFIG_BPF_LSM)			+=3D bpf/
>> =20
>>  # Object integrity file lists
>>  subdir-$(CONFIG_INTEGRITY)		+=3D integrity
>> diff --git a/security/bpf/Makefile b/security/bpf/Makefile
>> new file mode 100644
>> index 000000000000..c7a89a962084
>> --- /dev/null
>> +++ b/security/bpf/Makefile
>> @@ -0,0 +1,5 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# Copyright (C) 2020 Google LLC.
>> +
>> +obj-$(CONFIG_BPF_LSM) :=3D hooks.o
>> diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
>> new file mode 100644
>> index 000000000000..68e5824868f9
>> --- /dev/null
>> +++ b/security/bpf/hooks.c
>> @@ -0,0 +1,55 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +/*
>> + * Copyright (C) 2020 Google LLC.
>> + */
>> +#include <linux/lsm_hooks.h>
>> +#include <linux/bpf_lsm.h>
>> +
>> +/* Some LSM hooks do not have 0 as their default return values. Overr=
ide the
>> + * __weak definitons generated by default for these hooks
> If you wanted to avoid this, couldn't you make the default return value=

> part of lsm_hooks.h?
>
> e.g.:
>
> LSM_HOOK(int, -EOPNOTSUPP, inode_getsecurity, struct inode *inode,
> 	 const char *name, void **buffer, bool alloc)

If you're going to do that you'll have to keep lsm_hooks.h and security.c=

default values in sync somehow. Note that the four functions you've calle=
d
out won't be using call_int_hook() after the next round of stacking. I'm =
not
nixing the idea, I just don't want the default return for the security_
functions defined in two places.

>
> ...
>
> #define LSM_HOOK(RET, DEFAULT, NAME, ...)	\
> 	LSM_HOOK_##RET(NAME, DEFAULT, __VA_ARGS__)
> ...
> #define LSM_HOOK_int(NAME, DEFAULT, ...)	\
> noinline int bpf_lsm_##NAME(__VA_ARGS__)	\
> {						\
> 	return (DEFAULT);			\
> }
>
> Then all the __weak stuff is gone, and the following 4 functions don't
> need to be written out, and the information is available to the macros
> if anyone else might ever want it.
>
> -Kees
>
>> + */
>> +noinline int bpf_lsm_inode_getsecurity(struct inode *inode, const cha=
r *name,
>> +				       void **buffer, bool alloc)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +noinline int bpf_lsm_inode_setsecurity(struct inode *inode, const cha=
r *name,
>> +				       const void *value, size_t size,
>> +				       int flags)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +noinline int bpf_lsm_task_prctl(int option, unsigned long arg2,
>> +				unsigned long arg3, unsigned long arg4,
>> +				unsigned long arg5)
>> +{
>> +	return -ENOSYS;
>> +}
>> +
>> +noinline int bpf_lsm_xfrm_state_pol_flow_match(struct xfrm_state *x,
>> +					       struct xfrm_policy *xp,
>> +					       const struct flowi *fl)
>> +{
>> +	return 1;
>> +}
>> +
>> +static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init =
=3D {
>> +	#define LSM_HOOK(RET, NAME, ...) LSM_HOOK_INIT(NAME, bpf_lsm_##NAME)=
,
>> +	#include <linux/lsm_hook_names.h>
>> +	#undef LSM_HOOK
>> +};
>> +
>> +static int __init bpf_lsm_init(void)
>> +{
>> +	security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks), "bpf");=

>> +	pr_info("LSM support for eBPF active\n");
>> +	return 0;
>> +}
>> +
>> +DEFINE_LSM(bpf) =3D {
>> +	.name =3D "bpf",
>> +	.init =3D bpf_lsm_init,
>> +};
>> --=20
>> 2.20.1
>>

