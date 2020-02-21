Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEC4168714
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2020 19:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbgBUS5t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Feb 2020 13:57:49 -0500
Received: from sonic315-26.consmr.mail.ne1.yahoo.com ([66.163.190.152]:41548
        "EHLO sonic315-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729533AbgBUS5t (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 21 Feb 2020 13:57:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1582311465; bh=b8T47NxXCLWEB1H35wG7dKJKHTiAJpD7FFDz8YDKOa0=; h=Subject:To:References:Cc:From:Date:In-Reply-To:From:Subject; b=KiV8Zzu/dXmaTrendT44pZewiH6VN4TtMD1x0B2LzleEkcKaN4htsZbcP2ieQtnyzJUqUt6VSXZ4UOB23Q16pQDZeNOzAe8aZLgZyIuyipxEADsX9vfuTHiidmgdMCDD3HH6NuoscsqI5WrBFuI7dSQ24PCwvi9AaPzFk2Lqeo+fYx/CViEDNvAan8lFFBanT570eXx6eHo0Vvh16TNdMYB9+P/JjyYUoMsTZzawvqz0aTTZ9vVOI2UwJLZC2yrUisbSHzN6UiKtaOkiI13KdbGa3jShsLvWBk6ohevJT58sCb2BdZ8iXAvgLKThuDjSD/IkoW+PED/tUz0VcnLCig==
X-YMail-OSG: OQYhzh0VM1mYPah9ovcFoz8_dL4KLh4RoMKn9zKeD5YIFdiqy4FU4AIsUPtFu3A
 6EQAZq3YIo1m358xhZHna7SK7idmnYg2wVzmhRMNy2tcQsbVU3Bft_59qeEHBBs4JT27Gh0O1jDM
 xHklEab3PWBu29Hz1s7kPA77VXadauIHu89kwHo8peUdFnTaAdQJbVtNFoD.64YvCzJS89hb_692
 FuXYuC5.5uiPXT3o5S8d0CaZG5omOIIiGmuO3EFR1WBz915JoOgv2j5l44U1Cnzaqr.1uL4gfUWE
 UZsjFlzOIOGxTieQnDp5_glHyjj64uQJOT6Zb9120i2Qx0weF3BBoNcOGhqrk0B2Nwu4RGofwlO4
 l1KmuJ2.DsejefBBnULGuwjrwsJCGMa8GyKJ2tlnq8nA5mL_cPP2YSrT2qRPGEi.K5Nx6ivKlKr8
 DXz8SFSoj9rAPOJPkRgJk7HI0P88SIryMBXwGq.nhpzUXyexzSRPKiCR7u_0oHeLxWG5w7RPMaSc
 q1u8czws3WHTYBiXZ8l1ef50irr_4IemS7WfrCuIoIBeU.M3M8YwNRZ3RG7NXbWOU2muSFm5V66b
 pcfj1dkDprPj_fr8Ku2.tx2_m2PLGLaKGQBfJ2k.SpnP8MqjFNoJ4syXJnVQY_6mP.CZO5UoNkdh
 dsTOEJIeU8yH0O.RY99iJtWD05uIKnV7ETp.WpLlrRgBGTr2Yo_m9NI8dBa_JdknXumZYbWTATTc
 Ui1RfC7di66Nva4TMVk2Bu2BFn.uHXEuIOtTbDQLST.q.QUlFLqftz7TDw9L098qiw5VIkQQ.iuZ
 KcFuMT6xc5hnYnoHPhpqdYz5GU0YKnCTS1p79nJ_XZIxKj_1d_dSz46_U8tI6IdW90kdU4Jr4ugh
 XuLhWfJs9jPTFr089Y4aNmXZeR_RpzapZsVe7WhC8WJLsEa_n7ikRS_2EciNwAwAUkzoveAPWSop
 8be..ITVQEZpJllbcRpZU2XGiaIby9A3CmiA4vYOvVkFKswpSOHwHmaXFxQIkC8o2zHC2Tra3zK7
 TYm_1GTw68hskD8ihsT48vzZrXjpaJ0wz7ghSyb91vSMRq2wpa2_Q6dZdw.hYuME7am75mglCNzD
 nvh9AJ36qO8uoOIkPbUDD2oP8OaGx.q4acbS0_ukbu_eyvgRr8C_7c8jLsMUuMcUOgzDVoA5azo1
 iuM4GC2KXSenVt..Xpu9zANb6AZLEWSP.tCLclVjQprg8sUmcL307.M.JHvYYX9fyxJC4oTdi_7d
 Vq3ZJzRFME.7DPEpHAxYW4TXo8Aypp7GYpTf2N5r2_iTccvj6LK9M9_bSA5rwFXxaEdRXiv_8auX
 x0UYq.Fs7X47zrDbCAQPLbfr5rYAMLRXX9NuK.rQfvt_sj6fMpq8f4uhA2wnq9wKgwFXQOlGvxw5
 GU_GnXjwM7nGB6IixA5j4cVeYfFh80ipA
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Fri, 21 Feb 2020 18:57:45 +0000
Received: by smtp417.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e623b7807d3e08591094321f90aee448;
          Fri, 21 Feb 2020 18:57:40 +0000 (UTC)
Subject: Re: [PATCH bpf-next v4 4/8] bpf: lsm: Add support for
 enabling/disabling BPF hooks
To:     KP Singh <kpsingh@chromium.org>
References: <20200220175250.10795-1-kpsingh@chromium.org>
 <20200220175250.10795-5-kpsingh@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <bb32f155-5213-71df-c679-85c614c0ac26@schaufler-ca.com>
Date:   Fri, 21 Feb 2020 10:57:39 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200220175250.10795-5-kpsingh@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.15199 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_241)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/20/2020 9:52 AM, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>

Again, sorry for trimming the CC list, but thunderbird ...

>
> Each LSM hook defines a static key i.e. bpf_lsm_<name>
> and a bpf_lsm_<name>_set_enabled function to toggle the key
> which enables/disables the branch which executes the BPF programs
> attached to the LSM hook.
>
> Use of static keys was suggested in upstream discussion:
>
>   https://lore.kernel.org/bpf/1cd10710-a81b-8f9b-696d-aa40b0a67225@ioge=
arbox.net/
>
> and results in the following assembly:
>
>   0x0000000000001e31 <+65>:    jmpq   0x1e36 <security_bprm_check+70>
>   0x0000000000001e36 <+70>:    nopl   0x0(%rax,%rax,1)
>   0x0000000000001e3b <+75>:    xor    %eax,%eax
>   0x0000000000001e3d <+77>:    jmp    0x1e25 <security_bprm_check+53>
>
> which avoids an indirect branch and results in lower overhead which is
> especially helpful for LSM hooks in performance hotpaths.
>
> Given the ability to toggle the BPF trampolines, some hooks which do
> not call call_<int, void>_hooks as they have different default return
> values, also gain support for BPF program attachment.
>
> There are some hooks like security_setprocattr and security_getprocattr=

> which are not instrumentable as they do not provide any monitoring or
> access control decisions. If required, generation of BTF type
> information for these hooks can be also be blacklisted.
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
>  include/linux/bpf_lsm.h | 30 +++++++++++++++++++++++++++---
>  kernel/bpf/bpf_lsm.c    | 28 ++++++++++++++++++++++++++++
>  security/security.c     | 32 ++++++++++++++++++++++++++++++++
>  3 files changed, 87 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> index f867f72f6aa9..53dcda8ace01 100644
> --- a/include/linux/bpf_lsm.h
> +++ b/include/linux/bpf_lsm.h
> @@ -8,27 +8,51 @@
>  #define _LINUX_BPF_LSM_H
> =20
>  #include <linux/bpf.h>
> +#include <linux/jump_label.h>
> =20
>  #ifdef CONFIG_BPF_LSM
> =20
> +#define LSM_HOOK(RET, NAME, ...)		\
> +DECLARE_STATIC_KEY_FALSE(bpf_lsm_key_##NAME);   \
> +void bpf_lsm_##NAME##_set_enabled(bool value);
> +#include <linux/lsm_hook_names.h>
> +#undef LSM_HOOK

This is an amazing amount of macro magic. You're creating
dependencies that will make changes to the infrastructure
much more difficult. I think. It's really hard to tell.
At the very least you should have a description of what this
accomplishes, as it's far from obvious.

> +
>  #define LSM_HOOK(RET, NAME, ...) RET bpf_lsm_##NAME(__VA_ARGS__);
>  #include <linux/lsm_hook_names.h>
>  #undef LSM_HOOK
> =20
> -#define RUN_BPF_LSM_VOID_PROGS(FUNC, ...) bpf_lsm_##FUNC(__VA_ARGS__)
> +#define HAS_BPF_LSM_PROG(FUNC) (static_branch_unlikely(&bpf_lsm_key_##=
FUNC))
> +
> +#define RUN_BPF_LSM_VOID_PROGS(FUNC, ...)				\
> +	do {								\
> +		if (HAS_BPF_LSM_PROG(FUNC))				\
> +			bpf_lsm_##FUNC(__VA_ARGS__);			\
> +	} while (0)
> +
>  #define RUN_BPF_LSM_INT_PROGS(RC, FUNC, ...) ({				\
>  	do {								\
> -		if (RC =3D=3D 0)						\
> -			RC =3D bpf_lsm_##FUNC(__VA_ARGS__);		\
> +		if (HAS_BPF_LSM_PROG(FUNC)) {				\
> +			if (RC =3D=3D 0)					\
> +				RC =3D bpf_lsm_##FUNC(__VA_ARGS__);	\
> +		}							\
>  	} while (0);							\
>  	RC;								\
>  })
> =20
> +int bpf_lsm_set_enabled(const char *name, bool value);
> +
>  #else /* !CONFIG_BPF_LSM */
> =20
> +#define HAS_BPF_LSM_PROG false
>  #define RUN_BPF_LSM_INT_PROGS(RC, FUNC, ...) (RC)
>  #define RUN_BPF_LSM_VOID_PROGS(FUNC, ...)
> =20
> +static inline int bpf_lsm_set_enabled(const char *name, bool value)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  #endif /* CONFIG_BPF_LSM */
> =20
>  #endif /* _LINUX_BPF_LSM_H */
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index abc847c9b9a1..d7c44433c003 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -8,6 +8,20 @@
>  #include <linux/bpf.h>
>  #include <linux/btf.h>
>  #include <linux/bpf_lsm.h>
> +#include <linux/jump_label.h>
> +#include <linux/kallsyms.h>
> +
> +#define LSM_HOOK(RET, NAME, ...)					\
> +	DEFINE_STATIC_KEY_FALSE(bpf_lsm_key_##NAME);			\
> +	void bpf_lsm_##NAME##_set_enabled(bool value)			\
> +	{								\
> +		if (value)						\
> +			static_branch_enable(&bpf_lsm_key_##NAME);	\
> +		else							\
> +			static_branch_disable(&bpf_lsm_key_##NAME);	\
> +	}
> +#include <linux/lsm_hook_names.h>
> +#undef LSM_HOOK
> =20
>  /* For every LSM hook  that allows attachment of BPF programs, declare=
 a NOP
>   * function where a BPF program can be attached as an fexit trampoline=
=2E
> @@ -24,6 +38,20 @@
>  #include <linux/lsm_hook_names.h>
>  #undef LSM_HOOK
> =20
> +int bpf_lsm_set_enabled(const char *name, bool value)
> +{
> +	char toggle_fn_name[KSYM_NAME_LEN];
> +	void (*toggle_fn)(bool value);
> +
> +	snprintf(toggle_fn_name, KSYM_NAME_LEN, "%s_set_enabled", name);
> +	toggle_fn =3D (void *)kallsyms_lookup_name(toggle_fn_name);
> +	if (!toggle_fn)
> +		return -ESRCH;
> +
> +	toggle_fn(value);
> +	return 0;
> +}
> +
>  const struct bpf_prog_ops lsm_prog_ops =3D {
>  };
> =20
> diff --git a/security/security.c b/security/security.c
> index aa111392a700..569cc07d5e34 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -804,6 +804,13 @@ int security_vm_enough_memory_mm(struct mm_struct =
*mm, long pages)
>  			break;
>  		}
>  	}
> +#ifdef CONFIG_BPF_LSM
> +	if (HAS_BPF_LSM_PROG(vm_enough_memory)) {
> +		rc =3D bpf_lsm_vm_enough_memory(mm, pages);
> +		if (rc <=3D 0)
> +			cap_sys_admin =3D 0;
> +	}
> +#endif
>  	return __vm_enough_memory(mm, pages, cap_sys_admin);
>  }
> =20
> @@ -1350,6 +1357,13 @@ int security_inode_getsecurity(struct inode *ino=
de, const char *name, void **buf
>  		if (rc !=3D -EOPNOTSUPP)
>  			return rc;
>  	}
> +#ifdef CONFIG_BPF_LSM
> +	if (HAS_BPF_LSM_PROG(inode_getsecurity)) {
> +		rc =3D bpf_lsm_inode_getsecurity(inode, name, buffer, alloc);
> +		if (rc !=3D -EOPNOTSUPP)
> +			return rc;
> +	}
> +#endif
>  	return -EOPNOTSUPP;
>  }
> =20
> @@ -1369,6 +1383,14 @@ int security_inode_setsecurity(struct inode *ino=
de, const char *name, const void
>  		if (rc !=3D -EOPNOTSUPP)
>  			return rc;
>  	}
> +#ifdef CONFIG_BPF_LSM
> +	if (HAS_BPF_LSM_PROG(inode_setsecurity)) {
> +		rc =3D bpf_lsm_inode_setsecurity(inode, name, value, size,
> +					       flags);
> +		if (rc !=3D -EOPNOTSUPP)
> +			return rc;
> +	}
> +#endif
>  	return -EOPNOTSUPP;
>  }
> =20
> @@ -1754,6 +1776,12 @@ int security_task_prctl(int option, unsigned lon=
g arg2, unsigned long arg3,
>  				break;
>  		}
>  	}
> +#ifdef CONFIG_BPF_LSM
> +	if (HAS_BPF_LSM_PROG(task_prctl)) {
> +		if (rc =3D=3D -ENOSYS)
> +			rc =3D bpf_lsm_task_prctl(option, arg2, arg3, arg4, arg5);
> +	}
> +#endif
>  	return rc;
>  }
> =20
> @@ -2334,6 +2362,10 @@ int security_xfrm_state_pol_flow_match(struct xf=
rm_state *x,
>  		rc =3D hp->hook.xfrm_state_pol_flow_match(x, xp, fl);
>  		break;
>  	}
> +#ifdef CONFIG_BPF_LSM
> +	if (HAS_BPF_LSM_PROG(xfrm_state_pol_flow_match))
> +		rc =3D bpf_lsm_xfrm_state_pol_flow_match(x, xp, fl);
> +#endif
>  	return rc;
>  }
> =20

