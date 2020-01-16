Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8910A13D45D
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2020 07:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgAPGeC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jan 2020 01:34:02 -0500
Received: from sonic316-28.consmr.mail.ne1.yahoo.com ([66.163.187.154]:34053
        "EHLO sonic316-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725973AbgAPGeC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Jan 2020 01:34:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1579156440; bh=yBJigrGHSG+66XAcgXMw4QEc7iJLVOGtM+zuEg68q9I=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=BO0AMyZ3Kh1CXwmeHQGAOQ8Ua75LKtIcqaGWf5SE4MLkoK3Y5CgAAS7b316VvCVSMRM83tOr+9HlEqgAWctGc5jjpGyTgUW9BCR+EZyJ7jRaVKzW1sE5AVhzMMWtk89jiyOXCx68svMtKfYaP9emhF+m+h4iQ6WoyecrTxp/Nmp9BPhKsFb2bIzaDAwnjs5vIx3O/6tngXExLXrMvs1V5y4dvIyoRkJOY6GRWHHeKcrtO74T99QDa8A2ifxORZuFiVorcTDq+t074opPMdRDpQMuQwEkwG7UIyV2orDdDyOB2zhWcSnhJSCEos6NpMmTqlkYwd8l2bV6BiQ9rI6EzQ==
X-YMail-OSG: 91hBtu8VM1kNMVul5AviEjYZBoBFCeaRfgifNL6yiyQenk6pLy5Io5XO5Y43auZ
 AMIaoq11Ol5jO15St_fdrMrI1qWL77vIb7xG4o_03ZBqBkfxtvZxd5Pqv9FJC29b_hnk84tAtk.6
 jF6xRI1LxknAmeBC5Qg3f50MVSYM8fQeDwtxwVCi1..tIBeIzCai7Dcg6jn32KGDS0oc51zNfRdX
 e18fkPKRa4Yre.59eiIzD5m9wZDb9xvGiGHGRdxVw5KNZRXGqcgL0zjYWBIytnoMHqBOr0yfw.qm
 m2pFZ8lad0umtgd5PUkDymXi0OZIL0kZWTR4TBS2Ga5UeWBc8y9STGRLTzl5nxdltLkBPQMkvEhf
 GrjzI23wNk7kH7hTEb3CVgzPNI2oJV6RBBfOfTvzMLBMguN9BlSkYb9PXOve4XHKVmd5PPBdEbJp
 2vEi8iZSJJBrk_yrgLCOLiM4SCnJM.WN6DqdaT8uuqLPDtdkQzqc18K3Egjl0SoUewDtTzyjs8Mr
 .hV4vZ17sD8CQEJUGBtT9_v3W3cgfQV5ueDRK58wPVSuR.aP49y3DHWiRmzgSmdZG.Ica8MUuB0O
 bXyx6IAFEfXxS_Hr.1Ne_6dP5j5o64dffX1w8XRlfR.1vbITRu941ueWUQh7KBcjQNxGixCzhVpR
 ViX8.eRdx37Z2lqA9xja8TZ5JFrcrUTMu2aquvNzkRrgQ0zz_HxSakpwrTzptWuPB_J.02XcBmRK
 rwdt1jNWOLm_yDjVsnux0aUXkTErrUiE.jZ9uTlLW5lEGME.GHKd3_EBGCxp8C7823ZQBxVeeujX
 nP7SIsXOVN2VWsUQARtwM2yn0.k7DLTWPr9_HWnOFX2Lb94UsU0c.T7XzTEOXGp_pZzvF.Xp4qbf
 o3dYnRve5VKzhsuiDVzhE16xIXPhvzeORIeC9Hkl6wErZ0SAPMFXBRR8lr5rS.juqhrNrqYnjZPi
 nz.XKGmk9GZcNFuFarHfnF69gA1rpBOVJu6YVyu6pOqwOs41ar0Nb9pOSd_w_WGa_pIbzaY5OlG.
 2ACNVJboVK.CB5vbVsQUSz5i4Z0y3zxDzI_LTo9vWAw0n_AnU0VVAWS.Pv_7OjLb6kzuWkyJmibG
 aQeqM2SqTTN.EFP0zJPE1Kuz7kSyzYhxWbidCIX_W4WS32Ay9nTInGZUzXq21KnonCt9ggheQgaz
 VIe1qy.OBaKPiaTe0cK.0iYbG1vvauESLSFnPQNj3BOa2FZdySGQ7U_ec4oUXfvxgD7OEP7C6FHm
 cO41FLTeuf2Gv04TlAAZEtNWnTnm2ko9Ms6ZixtM9Cjsf960ytF83ckcM99ezbhG5VfHwgCg6R42
 dYbdk5qBxyI76tsEvFckTQSsckyMtr0XDfLWPtiTd90l5ik_bjMndenQRlcZKkyrUK.Iocw7rr_v
 TxlHFvAjqXa4apzam2trmZ_YH7N2FUM1FHJCULGMr9Up1UuU-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Thu, 16 Jan 2020 06:34:00 +0000
Received: by smtp404.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 453737c9233b3dc179b8cf9008f50acc;
          Thu, 16 Jan 2020 06:33:57 +0000 (UTC)
Subject: Re: [PATCH bpf-next v2 04/10] bpf: lsm: Add mutable hooks list for
 the BPF LSM
To:     KP Singh <kpsingh@chromium.org>, bpf@vger.kernel.org,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200115171333.28811-1-kpsingh@chromium.org>
 <20200115171333.28811-5-kpsingh@chromium.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <5793e9a8-e9cf-dd2d-261d-61f533cca20c@schaufler-ca.com>
Date:   Wed, 15 Jan 2020 22:33:53 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200115171333.28811-5-kpsingh@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.15038 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/15/2020 9:13 AM, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
>
> - The list of hooks registered by an LSM is currently immutable as they=

>   are declared with __lsm_ro_after_init and they are attached to a
>   security_hook_heads struct.
> - For the BPF LSM we need to de/register the hooks at runtime. Making
>   the existing security_hook_heads mutable broadens an
>   attack vector, so a separate security_hook_heads is added for only
>   those that ~must~ be mutable.
> - These mutable hooks are run only after all the static hooks have
>   successfully executed.
>
> This is based on the ideas discussed in:
>
>   https://lore.kernel.org/lkml/20180408065916.GA2832@ircssh-2.c.rugged-=
nimbus-611.internal
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
>  MAINTAINERS             |  1 +
>  include/linux/bpf_lsm.h | 71 +++++++++++++++++++++++++++++++++++++++++=

>  security/bpf/Kconfig    |  1 +
>  security/bpf/Makefile   |  2 +-
>  security/bpf/hooks.c    | 20 ++++++++++++
>  security/bpf/lsm.c      |  9 +++++-
>  security/security.c     | 24 +++++++-------
>  7 files changed, 115 insertions(+), 13 deletions(-)
>  create mode 100644 include/linux/bpf_lsm.h
>  create mode 100644 security/bpf/hooks.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0941f478cfa5..02d7e05e9b75 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3209,6 +3209,7 @@ L:	linux-security-module@vger.kernel.org
>  L:	bpf@vger.kernel.org
>  S:	Maintained
>  F:	security/bpf/
> +F:	include/linux/bpf_lsm.h
> =20
>  BROADCOM B44 10/100 ETHERNET DRIVER
>  M:	Michael Chan <michael.chan@broadcom.com>
> diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> new file mode 100644
> index 000000000000..9883cf25241c
> --- /dev/null
> +++ b/include/linux/bpf_lsm.h
> @@ -0,0 +1,71 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Copyright 2019 Google LLC.
> + */
> +
> +#ifndef _LINUX_BPF_LSM_H
> +#define _LINUX_BPF_LSM_H
> +
> +#include <linux/bpf.h>
> +#include <linux/lsm_hooks.h>
> +
> +#ifdef CONFIG_SECURITY_BPF
> +
> +/* Mutable hooks defined at runtime and executed after all the statica=
lly
> + * define LSM hooks.
> + */
> +extern struct security_hook_heads bpf_lsm_hook_heads;
> +
> +int bpf_lsm_srcu_read_lock(void);
> +void bpf_lsm_srcu_read_unlock(int idx);
> +
> +#define CALL_BPF_LSM_VOID_HOOKS(FUNC, ...)			\
> +	do {							\
> +		struct security_hook_list *P;			\
> +		int _idx;					\
> +								\
> +		if (hlist_empty(&bpf_lsm_hook_heads.FUNC))	\
> +			break;					\
> +								\
> +		_idx =3D bpf_lsm_srcu_read_lock();		\
> +		hlist_for_each_entry(P, &bpf_lsm_hook_heads.FUNC, list) \
> +			P->hook.FUNC(__VA_ARGS__);		\
> +		bpf_lsm_srcu_read_unlock(_idx);			\
> +	} while (0)
> +
> +#define CALL_BPF_LSM_INT_HOOKS(RC, FUNC, ...) ({		\
> +	do {							\
> +		struct security_hook_list *P;			\
> +		int _idx;					\
> +								\
> +		if (hlist_empty(&bpf_lsm_hook_heads.FUNC))	\
> +			break;					\
> +								\
> +		_idx =3D bpf_lsm_srcu_read_lock();		\
> +								\
> +		hlist_for_each_entry(P,				\
> +			&bpf_lsm_hook_heads.FUNC, list) {	\
> +			RC =3D P->hook.FUNC(__VA_ARGS__);		\
> +			if (RC && IS_ENABLED(CONFIG_SECURITY_BPF_ENFORCE)) \
> +				break;				\
> +		}						\
> +		bpf_lsm_srcu_read_unlock(_idx);			\
> +	} while (0);						\
> +	IS_ENABLED(CONFIG_SECURITY_BPF_ENFORCE) ? RC : 0;	\
> +})
> +
> +#else /* !CONFIG_SECURITY_BPF */
> +
> +#define CALL_BPF_LSM_INT_HOOKS(RC, FUNC, ...) (RC)
> +#define CALL_BPF_LSM_VOID_HOOKS(...)
> +
> +static inline int bpf_lsm_srcu_read_lock(void)
> +{
> +	return 0;
> +}
> +static inline void bpf_lsm_srcu_read_unlock(int idx) {}
> +
> +#endif /* CONFIG_SECURITY_BPF */
> +
> +#endif /* _LINUX_BPF_LSM_H */
> diff --git a/security/bpf/Kconfig b/security/bpf/Kconfig
> index a5f6c67ae526..595e4ad597ae 100644
> --- a/security/bpf/Kconfig
> +++ b/security/bpf/Kconfig
> @@ -6,6 +6,7 @@ config SECURITY_BPF
>  	bool "BPF-based MAC and audit policy"
>  	depends on SECURITY
>  	depends on BPF_SYSCALL
> +	depends on SRCU
>  	help
>  	  This enables instrumentation of the security hooks with
>  	  eBPF programs.
> diff --git a/security/bpf/Makefile b/security/bpf/Makefile
> index c78a8a056e7e..c526927c337d 100644
> --- a/security/bpf/Makefile
> +++ b/security/bpf/Makefile
> @@ -2,4 +2,4 @@
>  #
>  # Copyright 2019 Google LLC.
> =20
> -obj-$(CONFIG_SECURITY_BPF) :=3D lsm.o ops.o
> +obj-$(CONFIG_SECURITY_BPF) :=3D lsm.o ops.o hooks.o
> diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
> new file mode 100644
> index 000000000000..b123d9cb4cd4
> --- /dev/null
> +++ b/security/bpf/hooks.c
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright 2019 Google LLC.
> + */
> +
> +#include <linux/bpf_lsm.h>
> +#include <linux/srcu.h>
> +
> +DEFINE_STATIC_SRCU(security_hook_srcu);
> +
> +int bpf_lsm_srcu_read_lock(void)
> +{
> +	return srcu_read_lock(&security_hook_srcu);
> +}
> +
> +void bpf_lsm_srcu_read_unlock(int idx)
> +{
> +	return srcu_read_unlock(&security_hook_srcu, idx);
> +}
> diff --git a/security/bpf/lsm.c b/security/bpf/lsm.c
> index 5c5c14f990ce..d4ea6aa9ddb8 100644
> --- a/security/bpf/lsm.c
> +++ b/security/bpf/lsm.c
> @@ -4,14 +4,21 @@
>   * Copyright 2019 Google LLC.
>   */
> =20
> +#include <linux/bpf_lsm.h>
>  #include <linux/lsm_hooks.h>
> =20
>  /* This is only for internal hooks, always statically shipped as part =
of the
> - * BPF LSM. Statically defined hooks are appeneded to the security_hoo=
k_heads
> + * BPF LSM. Statically defined hooks are appended to the security_hook=
_heads
>   * which is common for LSMs and R/O after init.
>   */
>  static struct security_hook_list lsm_hooks[] __lsm_ro_after_init =3D {=
};
> =20
> +/* Security hooks registered dynamically by the BPF LSM and must be ac=
cessed
> + * by holding bpf_lsm_srcu_read_lock and bpf_lsm_srcu_read_unlock. The=
 mutable
> + * hooks dynamically allocated by the BPF LSM are appeneded here.
> + */
> +struct security_hook_heads bpf_lsm_hook_heads;
> +
>  static int __init lsm_init(void)
>  {
>  	security_add_hooks(lsm_hooks, ARRAY_SIZE(lsm_hooks), "bpf");
> diff --git a/security/security.c b/security/security.c
> index cd2d18d2d279..4a2eb4c089b2 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -27,6 +27,7 @@
>  #include <linux/backing-dev.h>
>  #include <linux/string.h>
>  #include <linux/msg.h>
> +#include <linux/bpf_lsm.h>
>  #include <net/flow.h>
> =20
>  #define MAX_LSM_EVM_XATTR	2
> @@ -652,20 +653,21 @@ static void __init lsm_early_task(struct task_str=
uct *task)
>  								\
>  		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) \
>  			P->hook.FUNC(__VA_ARGS__);		\
> +		CALL_BPF_LSM_VOID_HOOKS(FUNC, __VA_ARGS__);	\
>  	} while (0)
> =20
> -#define call_int_hook(FUNC, IRC, ...) ({			\
> -	int RC =3D IRC;						\
> -	do {							\
> -		struct security_hook_list *P;			\
> -								\
> +#define call_int_hook(FUNC, IRC, ...) ({				\
> +	int RC =3D IRC;							\
> +	do {								\
> +		struct security_hook_list *P;				\
>  		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
> -			RC =3D P->hook.FUNC(__VA_ARGS__);		\
> -			if (RC !=3D 0)				\
> -				break;				\
> -		}						\
> -	} while (0);						\
> -	RC;							\
> +			RC =3D P->hook.FUNC(__VA_ARGS__);			\
> +			if (RC !=3D 0)					\
> +				break;					\
> +		}							\
> +		RC =3D CALL_BPF_LSM_INT_HOOKS(RC, FUNC, __VA_ARGS__);	\

Do not do this. Add LSM_ORDER_LAST for the lsm_order field of lsm_info
and use that to identify your module as one to be put on the list last.
Update the LSM registration code to do this. It will be much like the cod=
e
that uses LSM_ORDER_FIRST to put the capabilities at the head of the list=
s.

What you have here to way to much like the way Yama was invoked before
stacking.

> +	} while (0);							\
> +	RC;								\
>  })
> =20
>  /* Security operations */

