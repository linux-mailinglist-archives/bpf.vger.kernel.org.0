Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86AB6146F18
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2020 18:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgAWRD4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 12:03:56 -0500
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:35196
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729856AbgAWRDx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Jan 2020 12:03:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1579799031; bh=DjIheSjYqHrWuIvRL/YFnXndELjorh97M7vPqZTiO3E=; h=Subject:To:References:Cc:From:Date:In-Reply-To:From:Subject; b=o7zm3+2FXH8ABMWty9E9cirCw069rxls+2wyKJgvk9E+eQoWWQOc9TJdDnRqmveFP8+3GTK3nBCFJjKWOSCsp8ftUqXUh5sGo9HKpzkwX/efk9UJbzUoudjmeMXpQJnY9bKENdUYVGprGI9i7YDpURwfT6YFAxkdJoALxLNQcU8FlonkXXM3InRTRnglkdvxRTsw5jb0lOis8lSCv0ILjOmZ83Rpv63o72HX23lBwDgUizzWyRv6xn7W9Y8gGeXcvNsnwApMwq38juNnTdk/lAbUtqMkHRFgLAESjbz2SGA8CVL14vuDR/JsncFYaBxDTLfcGkLY59zQAqUQyfOH1g==
X-YMail-OSG: GfmIL8kVM1lmaelH9gBL8oDSL_60sMjoDY0mfc7QcGgA3b7ToGvaqiX6xjAhQXR
 r..EU5GAy9_KZdP9ThH4AZYWbKSBMOnk2tMLqD7B4Yn1fIxYW.wbhs25WHFdnclNTBaFVyYr1WJC
 DF3Z17m1NUVewmccRZ7e84RP8x9b557V21sbo_qlgdHvhsOPrEeYr5DQKR5uxJx5BrV2xvsTb3zn
 c8QW8Gx3ACXEw1Ub4B6sD5_Cr1CswvZ3SkBtI7LWkJtbXudE8yxh03pYCvTUJTYYofQTooSxY94S
 pTN2cJjMX.mf_gy02gpc1tDdNUGk39TK1IasHJlDU2aJBG3LhDPuLXQeGaoCGrpDbx6KtV9SoqcG
 zLezXhNljOjcchP89mUZhJJ9PtHWTp9DeLvHV7bFhDxqiq2D4j0m.2lMa66RwkAZPacqNVbw8cnd
 R8GAe8D7a6vust_dTss0RMd9pZEKJKfpoqT45gOL34CdzkKjGgs4Ck7jrzK6keNfHO.HyCGTzCHp
 5WrwDmpKdZIV6PddiwxqaeRhNAPPCIr6DNG2pRNUH3lRr56cPYYHLSuixfH.aNqJVa_rnjlQtEAo
 kR4TZ_3yBZooiQLVA5Y8zwGSNLulxtvRoqSx.1nrxbECAH1gWR62J051ZVCUC.qKQ9dID_sl_j6k
 6n4I.Eo2npfvZztbkNSXD8d_g3lcIbhQYLdvVdkaDsPpUuzL7y31x0RYW1LSqYFFKtp3ff92sYbW
 h4_QSy.gJFdTeDnQrrlSUUN177qT8x5MnjoA_M1Sxds_qNp8bAVAXr4wcTuRmb5lFr3Y3ccdXTxe
 nm8.EbAkcCcWwDgk5nO4ZqlSltAMfznrUQpwEEkwCxN0oOF2NCheGNc6tGvNahx2R7RisI0JB_qF
 81VbIFMz0KHeKANx8701_EthiGSkqUYvyX_bHv.W9OGHXmVXFvyd21jd8DsxgKMyulehS0uK1Yq5
 FUfvG2a5ZQproJxbVHsIVxp9QqFQPKC6sxyKsCRF73bSMQddpxgIRhOaFEs3U9CPFTSq1tTB.z4B
 Btu0YkN1mzQF5Wcr0R0X6GUZI0VSZlqZKmjfWp4UUXZ2xybUBan5ghuMuovsmQpt8oIQlmPTJUFE
 v43Q37ZRC2oj3Iwp8xjrX..UnP6R.Yq.rHoD961TWXLuHX.BUu0iTxZnGM6nM8zAspN98539dwhO
 iH2jn37jmY.ZcTF3mH7qTiDfFkzOIJTs5sV1gRm39TDr6vrqhRzwLoCxLMU7Nz_bKSJFDK45hdHx
 1vUFvhD5xxInWzjQ9do6PsA1HnAL5grXLOF6e3lzYG.qHUb7nfsrNGhNvFd3uBxtOmenbZu2sSlu
 _kwIKMon2R8lGfwJh6k0NBIf4cMeJ103XIXmKVaBGpcMiSiwNfanhEdrpx7gMJBGtPz5Mhrvk19g
 XQCdHeepYnieMw2gyWjxn9ZsPFl1BjTYqC0XFNN6LecxUsJxaEehX0A--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Thu, 23 Jan 2020 17:03:51 +0000
Received: by smtp427.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 411c2b259896b6d5783089d449bbf34d;
          Thu, 23 Jan 2020 17:03:48 +0000 (UTC)
Subject: Re: [PATCH bpf-next v3 04/10] bpf: lsm: Add mutable hooks list for
 the BPF LSM
To:     KP Singh <kpsingh@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, bpf@vger.kernel.org
References: <20200123152440.28956-1-kpsingh@chromium.org>
 <20200123152440.28956-5-kpsingh@chromium.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <29157a88-7049-906e-fe92-b7a1e2183c6b@schaufler-ca.com>
Date:   Thu, 23 Jan 2020 09:03:47 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200123152440.28956-5-kpsingh@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/23/2020 7:24 AM, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
>
> - The list of hooks registered by an LSM is currently immutable as they
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
>   https://lore.kernel.org/lkml/20180408065916.GA2832@ircssh-2.c.rugged-nimbus-611.internal
>
> Reviewed-by: Brendan Jackman <jackmanb@google.com>
> Reviewed-by: Florent Revest <revest@google.com>
> Reviewed-by: Thomas Garnier <thgarnie@google.com>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
>  MAINTAINERS             |  1 +
>  include/linux/bpf_lsm.h | 72 +++++++++++++++++++++++++++++++++++++++++
>  security/bpf/Kconfig    |  1 +
>  security/bpf/Makefile   |  2 +-
>  security/bpf/hooks.c    | 20 ++++++++++++
>  security/bpf/lsm.c      |  7 ++++
>  security/security.c     | 25 +++++++-------
>  7 files changed, 116 insertions(+), 12 deletions(-)
>  create mode 100644 include/linux/bpf_lsm.h
>  create mode 100644 security/bpf/hooks.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e2b7f76a1a70..c606b3d89992 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3209,6 +3209,7 @@ L:	linux-security-module@vger.kernel.org
>  L:	bpf@vger.kernel.org
>  S:	Maintained
>  F:	security/bpf/
> +F:	include/linux/bpf_lsm.h
>  
>  BROADCOM B44 10/100 ETHERNET DRIVER
>  M:	Michael Chan <michael.chan@broadcom.com>
> diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> new file mode 100644
> index 000000000000..57c20b2cd2f4
> --- /dev/null
> +++ b/include/linux/bpf_lsm.h
> @@ -0,0 +1,72 @@
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
> +/* Mutable hooks defined at runtime and executed after all the statically
> + * defined LSM hooks.
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
> +		_idx = bpf_lsm_srcu_read_lock();		\
> +		hlist_for_each_entry(P, &bpf_lsm_hook_heads.FUNC, list) \
> +			P->hook.FUNC(__VA_ARGS__);		\
> +		bpf_lsm_srcu_read_unlock(_idx);			\
> +	} while (0)
> +
> +#define CALL_BPF_LSM_INT_HOOKS(FUNC, ...) ({			\
> +	int _ret = 0;						\
> +	do {							\
> +		struct security_hook_list *P;			\
> +		int _idx;					\
> +								\
> +		if (hlist_empty(&bpf_lsm_hook_heads.FUNC))	\
> +			break;					\
> +								\
> +		_idx = bpf_lsm_srcu_read_lock();		\
> +								\
> +		hlist_for_each_entry(P,				\
> +			&bpf_lsm_hook_heads.FUNC, list) {	\
> +			_ret = P->hook.FUNC(__VA_ARGS__);		\
> +			if (_ret && IS_ENABLED(CONFIG_SECURITY_BPF_ENFORCE)) \
> +				break;				\
> +		}						\
> +		bpf_lsm_srcu_read_unlock(_idx);			\
> +	} while (0);						\
> +	IS_ENABLED(CONFIG_SECURITY_BPF_ENFORCE) ? _ret : 0;	\
> +})
> +
> +#else /* !CONFIG_SECURITY_BPF */
> +
> +#define CALL_BPF_LSM_INT_HOOKS(FUNC, ...) (0)
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
>  
> -obj-$(CONFIG_SECURITY_BPF) := lsm.o ops.o
> +obj-$(CONFIG_SECURITY_BPF) := lsm.o ops.o hooks.o
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
> index dc9ac03c7aa0..a25a068e1781 100644
> --- a/security/bpf/lsm.c
> +++ b/security/bpf/lsm.c
> @@ -4,6 +4,7 @@
>   * Copyright 2019 Google LLC.
>   */
>  
> +#include <linux/bpf_lsm.h>
>  #include <linux/lsm_hooks.h>
>  
>  /* This is only for internal hooks, always statically shipped as part of the
> @@ -12,6 +13,12 @@
>   */
>  static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {};
>  
> +/* Security hooks registered dynamically by the BPF LSM and must be accessed
> + * by holding bpf_lsm_srcu_read_lock and bpf_lsm_srcu_read_unlock. The mutable
> + * hooks dynamically allocated by the BPF LSM are appeneded here.
> + */
> +struct security_hook_heads bpf_lsm_hook_heads;
> +
>  static int __init bpf_lsm_init(void)
>  {
>  	security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks), "bpf");
> diff --git a/security/security.c b/security/security.c
> index 30a8aa700557..95a46ca25dcd 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -27,6 +27,7 @@
>  #include <linux/backing-dev.h>
>  #include <linux/string.h>
>  #include <linux/msg.h>
> +#include <linux/bpf_lsm.h>
>  #include <net/flow.h>
>  
>  #define MAX_LSM_EVM_XATTR	2
> @@ -657,20 +658,22 @@ static void __init lsm_early_task(struct task_struct *task)
>  								\
>  		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) \
>  			P->hook.FUNC(__VA_ARGS__);		\
> +		CALL_BPF_LSM_VOID_HOOKS(FUNC, __VA_ARGS__);	\

I'm sorry if I wasn't clear on the v2 review.
This does not belong in the infrastructure. You should be
doing all the bpf_lsm hook processing in you module.
bpf_lsm_task_alloc() should loop though all the bpf
task_alloc hooks if they have to be handled differently
from "normal" LSM hooks.

>  	} while (0)
>  
> -#define call_int_hook(FUNC, IRC, ...) ({			\
> -	int RC = IRC;						\
> -	do {							\
> -		struct security_hook_list *P;			\
> -								\
> +#define call_int_hook(FUNC, IRC, ...) ({				\
> +	int RC = IRC;							\
> +	do {								\
> +		struct security_hook_list *P;				\
>  		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
> -			RC = P->hook.FUNC(__VA_ARGS__);		\
> -			if (RC != 0)				\
> -				break;				\
> -		}						\
> -	} while (0);						\
> -	RC;							\
> +			RC = P->hook.FUNC(__VA_ARGS__);			\
> +			if (RC != 0)					\
> +				break;					\
> +		}							\
> +		if (RC == 0)						\
> +			RC = CALL_BPF_LSM_INT_HOOKS(FUNC, __VA_ARGS__);	\
> +	} while (0);							\
> +	RC;								\
>  })
>  
>  /* Security operations */
