Return-Path: <bpf+bounces-2689-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CE2732451
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 02:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94B261C20EDD
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 00:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF55C373;
	Fri, 16 Jun 2023 00:38:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4ED36C
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 00:38:38 +0000 (UTC)
Received: from sonic311-31.consmr.mail.ne1.yahoo.com (sonic311-31.consmr.mail.ne1.yahoo.com [66.163.188.212])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EE62966
	for <bpf@vger.kernel.org>; Thu, 15 Jun 2023 17:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1686875915; bh=b5NSD0hZw11WVF2KQOKJVhNK+9TFCpPSxcssOqAnZcw=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ih6SQqtND9bhmAqPTnFWr70oPKg0vfcm+4k/YLnzyCW1LfFST0YxwkhPnB2JKBniI9+DwYD+0uXo+UasP2ETUWNvZVrrmNRefmSnynKdgU8FH1zk+vxMFPHMwt3Cdq0oA42Pght7blNLhpzMaaccdhb6aUGCZCmMxKQJ5OnKgwc7i4CVQL94d76VApl1jrr4ReiRtfpZaMTk63wcviQglU4aKRoW9A91w5szwjQrzRbereYrnmYiAIBptXf0dHbIHiEUzvna+nMAfHbQqCSc+Uqio0E3XeZFJH64kJ0h8K/XA9mxv3qVIieqYdgepuEMGlE5WMmAilCETad8oOP8Sw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1686875915; bh=Co0Rb7qDfK5z2qTA23JVzo3XpbVnUkaqpr3XNoWCLyc=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Zo6lmwX1iQjaIl/54Nrg5daWVSTSrKd+Yz/1auUlqJ/kZZqCzL9AJ7BnRsSnPsl32NR0bOY1kXz1KuEE19VRHI8y9OCbcZFklGwtdHcIg3lMrXk6Tu/j/1sEgjAduLHa/pvVe/IXE1Bhxshzhbxfw2LduheqvUog+x0OeEWfBPpRax+/Oc0m+RHGObZV4OyitPMvNMGjL69bIg4M2FslM2/b4A/DR6JqyncrJjq97Xdc6wmskChwWuHWfHqfb1D6jpXtYyzkJJbe2ZS3tYIpbMnLJ0LIThZU7ITj75FuKJCWgQC9gItcy46WN82M8a/1XLSxDuuHyQewjTGJc4nmug==
X-YMail-OSG: KB_PE1QVM1kahSPet73i.PpHC5z4Gz8QJrCB5AcHl6M5MQ_QaaNC9Q8HLfRFwO0
 5Dfiy8YAIB2nzSZFYxf8eH24S9MfOe7S9CYslkpWNz5R_tcsWnlBu07x3PywVGPGEtE99AOirVs6
 5xRFSLNMp0yBzn8yWZ6IDm7AltG4Y36R5iMcPGr9M.yk03R2oQByKNOS8mMEaVHtZDpEeIdBksUh
 ClgV9mRh0KVlQIvHV7v.6V69UogDCyCiaXt2g4phgwM5sbtgl2dV8FGd1Mm2X.sEJlNi3de_MqPZ
 e4FdGlPui89Hf_oGSSb5TOy4Z0eBUYTYYAAWvpSOX1wdL2cbfHAjOOhfiXq.krQKjHIkZS0sEsMl
 WCA5TvwZqSC9gn62NoNBE46rwS2lOKJaZ1m52n8SeYbDPE1WKMwAEFsG8WmSTgX3b5mFYCmFUNnL
 eh22ovn0rdU4IIhSP07gLZ5mXyWecSnZoZP_4EBZvJxPQWOxnxO3i2eEzPKS9gV12FsHfe45Ft6f
 n2yPa2i6kgsSJzqPL6UHwyVR.Phi37U7xVOTlYtqb__ut16yx6LM5iy1eMDFj606AAfooGwjG_ck
 pEg8hOf5aFisOMfooCNSX021bD_PCFP4eInCcfwxqMJSk3rbmquK0BgvqSD0dZebJylYiMwMfIpc
 SoaSBYrOowWCudhd72xaTEcSINeckHjeS3dkVdoj6BuwkeyqPfWWdEDdXozZGbNvCm076r_hE3Xn
 A.e01mGoSCHjyxW7AOvqW0HqxYd3wSRp2LKFFDiiPZwtOjwySOGa7EilD2ZkKTfsQOJo.Fx6Mqyz
 WLNbN0fTFCbQIH6qQZiHQGLOX2joapQ4Jo2N_DpDpvfurv7F6tAleoZSb7N.sUDetBpq4iniZOMi
 x_2A5KZeaZF_aBr67Y2SxsBAubQN5GWWcBXsSgUJ6.b8zj3iMs8IS7Mq.Z.Ncc442GD_vbYkfgqT
 N3.Lgj22FZqy25ZVRQtsRmsBAiGiRMb8QTFULeTlYSB.3zD1t6wwQ5LRXbPFD2RL6T5094SeRXZL
 1LypG_.BHlYUwg7942xLIWs8cOTRLdhvrPYCcSdSDaIIu8oSaGRYhqRI46aNrqAD1crmGwGHkUdk
 bYqsy6RuGhuAlR8oyrtJjwUs4BxBJrohLm9ob11fS.RPBZDbjY2dv.Y69l4noUK0q_EtzPGPzl.Z
 _6TvgISLzz3038wEzOgAng_CNsgs4qw4GIPP7fo5zlnyagWVuFfGGBE27RfLjlXW2Ybo6gsp62vL
 UE6m3j_HanFKANmu_1QH9B8wYcxX0TxpUdt_G3cezryaYtnFDTAoG6EKiYKv60aaBiwsggjTWKY6
 SUCNSJ6STWetbepMBCouZUfi_MujbNpyuucUWy6RGK8x5ImgNubrhPxK_YcMHcSWbOAU8vwLw_Km
 CZj3O4XgXHUMTypLbiHtzOeSaOawJawWyLv0IJF4kA13fHqx1qQ7PKIoPHWLvDB9cdeg8sPmFFa_
 G_w3cGl0nf7_wWbRHzyXG7R7EReaXUdNdrT97Dnld.Pvw9k05M8xtMyvFf31WWumdIcZ9B3NZXVf
 oMoYq1TNUL79WWWIQTnsZgceWmaMqvRQQNsGHy7O.KTkFfampYpbjJUZBuTfNDFzni_SgTmKraF.
 obDU5PlzCOnVI7FKHsD5ztneQV0.BEZNb7n3bfkJaXQRh17UWc4W5CwE0AW4X_ruXr5u0TW495tv
 QVLCctheitu34tfKvithMKAqGjDHntMDbZ0FIo_FPbc_xVUctSifWWZbtKwAewGita78jzsMp3P4
 bENuXcDqErtrX1WVjKnz2fP4S7DHlQPpDoJmao247rHO9AyigdwSmgeR7Q4qBxHIN709tY4q8TB0
 AEIcL_KN21XxyddBztX.NGubMXwqPH85ZLisLzfLVr8tb32Asp2JsfOqhdaX.UNMYDvlj1TGQcNU
 6_13neeygBwXkp9mlaE.xfePF3_WPqqtdTbU173ubfGraYiAJ_Ak91musLDAiEp34R_dhYXprK7b
 sXZ0RDbGjqrJa8rm3Jlij3Fmka2JdjP601mBr6WPsB4BhTzvT1FlIPhkKHmRdpnm5PiMaN4QS7gj
 lUueS.jk8GS.uH74tWLEVoImfW72GF0B0dkSIsisIp_AXBpIcqrmHJUlrD0dYPUliJUM.ctRgJs2
 TXFc_NNKR7Hj8P50ivdLEb2MVSznn.MuBpMpzoalDA51Dc61QvtH3sUviNz73YXB7Yc.Blz_gMId
 fQvYKGU5glz..Z8eyeQoXmkjsxDWyjxaKU9qdVWxh.BofLJqf6trbugTvBVB1pXjOGfWYVmz3.D5
 ZG8jd
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 242e23ce-9301-4ab5-b29c-53a2e7e56607
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Fri, 16 Jun 2023 00:38:35 +0000
Received: by hermes--production-bf1-54475bbfff-g6lsn (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID fea64ea356d76a5f70401e93b37a3f95;
          Fri, 16 Jun 2023 00:38:30 +0000 (UTC)
Message-ID: <72bd13a2-a5b3-328e-a751-87102107293e@schaufler-ca.com>
Date: Thu, 15 Jun 2023 17:38:28 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/5] security: Count the LSMs enabled at compile time
Content-Language: en-US
To: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org,
 bpf@vger.kernel.org
Cc: paul@paul-moore.com, keescook@chromium.org, song@kernel.org,
 daniel@iogearbox.net, ast@kernel.org, jannh@google.com,
 Kui-Feng Lee <sinquersw@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>
References: <20230616000441.3677441-1-kpsingh@kernel.org>
 <20230616000441.3677441-3-kpsingh@kernel.org>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230616000441.3677441-3-kpsingh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21557 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/15/2023 5:04 PM, KP Singh wrote:
> These macros are a clever trick to determine a count of the number of
> LSMs that are enabled in the config to ascertain the maximum number of
> static calls that need to be configured per LSM hook.
>
> Without this one would need to generate static calls for (number of
> possible LSMs * number of LSM hooks) which ends up being quite wasteful
> especially when some LSMs are not compiled into the kernel.
>
> Suggested-by: Kui-Feng Lee <sinquersw@gmail.com>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  include/linux/lsm_count.h | 131 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 131 insertions(+)
>  create mode 100644 include/linux/lsm_count.h
>
> diff --git a/include/linux/lsm_count.h b/include/linux/lsm_count.h
> new file mode 100644
> index 000000000000..818f62ffa723
> --- /dev/null
> +++ b/include/linux/lsm_count.h
> @@ -0,0 +1,131 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Copyright (C) 2023 Google LLC.
> + */
> +
> +#ifndef __LINUX_LSM_COUNT_H
> +#define __LINUX_LSM_COUNT_H
> +
> +#include <linux/kconfig.h>
> +
> +/*
> + * Macros to count the number of LSMs enabled in the kernel at compile time.
> + */
> +
> +#define __LSM_COUNT_15(x, y...) 15
> +#define __LSM_COUNT_14(x, y...) 14
> +#define __LSM_COUNT_13(x, y...) 13
> +#define __LSM_COUNT_12(x, y...) 12
> +#define __LSM_COUNT_11(x, y...) 11
> +#define __LSM_COUNT_10(x, y...) 10
> +#define __LSM_COUNT_9(x, y...) 9
> +#define __LSM_COUNT_8(x, y...) 8
> +#define __LSM_COUNT_7(x, y...) 7
> +#define __LSM_COUNT_6(x, y...) 6
> +#define __LSM_COUNT_5(x, y...) 5
> +#define __LSM_COUNT_4(x, y...) 4
> +#define __LSM_COUNT_3(x, y...) 3
> +#define __LSM_COUNT_2(x, y...) 2
> +#define __LSM_COUNT_1(x, y...) 1
> +#define __LSM_COUNT_0(x, y...) 0
> +
> +#define __LSM_COUNT1_15(x, y...) __LSM_COUNT ## x ## _15(y)
> +#define __LSM_COUNT1_14(x, y...) __LSM_COUNT ## x ## _14(y)
> +#define __LSM_COUNT1_13(x, y...) __LSM_COUNT ## x ## _13(y)
> +#define __LSM_COUNT1_12(x, y...) __LSM_COUNT ## x ## _12(y)
> +#define __LSM_COUNT1_10(x, y...) __LSM_COUNT ## x ## _11(y)
> +#define __LSM_COUNT1_9(x, y...) __LSM_COUNT ## x ## _10(y)
> +#define __LSM_COUNT1_8(x, y...) __LSM_COUNT ## x ## _9(y)
> +#define __LSM_COUNT1_7(x, y...) __LSM_COUNT ## x ## _8(y)
> +#define __LSM_COUNT1_6(x, y...) __LSM_COUNT ## x ## _7(y)
> +#define __LSM_COUNT1_5(x, y...) __LSM_COUNT ## x ## _6(y)
> +#define __LSM_COUNT1_4(x, y...) __LSM_COUNT ## x ## _5(y)
> +#define __LSM_COUNT1_3(x, y...) __LSM_COUNT ## x ## _4(y)
> +#define __LSM_COUNT1_2(x, y...) __LSM_COUNT ## x ## _3(y)
> +#define __LSM_COUNT1_1(x, y...) __LSM_COUNT ## x ## _2(y)
> +#define __LSM_COUNT1_0(x, y...) __LSM_COUNT ## x ## _1(y)
> +#define __LSM_COUNT(x, y...) __LSM_COUNT ## x ## _0(y)
> +
> +#define __LSM_COUNT_EXPAND(x...) __LSM_COUNT(x)
> +
> +#if IS_ENABLED(CONFIG_SECURITY)
> +#define CAPABILITIES_ENABLED 1,
> +#else
> +#define CAPABILITIES_ENABLED
> +#endif
> +
> +#if IS_ENABLED(CONFIG_SECURITY_SELINUX)
> +#define SELINUX_ENABLED 1,
> +#else
> +#define SELINUX_ENABLED
> +#endif
> +
> +#if IS_ENABLED(CONFIG_SECURITY_SMACK)
> +#define SMACK_ENABLED 1,
> +#else
> +#define SMACK_ENABLED
> +#endif
> +
> +#if IS_ENABLED(CONFIG_SECURITY_APPARMOR)
> +#define APPARMOR_ENABLED 1,
> +#else
> +#define APPARMOR_ENABLED
> +#endif
> +
> +#if IS_ENABLED(CONFIG_SECURITY_TOMOYO)
> +#define TOMOYO_ENABLED 1,
> +#else
> +#define TOMOYO_ENABLED
> +#endif
> +
> +#if IS_ENABLED(CONFIG_SECURITY_YAMA)
> +#define YAMA_ENABLED 1,
> +#else
> +#define YAMA_ENABLED
> +#endif
> +
> +#if IS_ENABLED(CONFIG_SECURITY_LOADPIN)
> +#define LOADPIN_ENABLED 1,
> +#else
> +#define LOADPIN_ENABLED
> +#endif
> +
> +#if IS_ENABLED(CONFIG_SECURITY_LOCKDOWN_LSM)
> +#define LOCKDOWN_ENABLED 1,
> +#else
> +#define LOCKDOWN_ENABLED
> +#endif
> +
> +#if IS_ENABLED(CONFIG_BPF_LSM)
> +#define BPF_LSM_ENABLED 1,
> +#else
> +#define BPF_LSM_ENABLED
> +#endif
> +
> +#if IS_ENABLED(CONFIG_BPF_LSM)
> +#define BPF_LSM_ENABLED 1,
> +#else
> +#define BPF_LSM_ENABLED
> +#endif
> +
> +#if IS_ENABLED(CONFIG_SECURITY_LANDLOCK)
> +#define LANDLOCK_ENABLED 1,
> +#else
> +#define LANDLOCK_ENABLED
> +#endif
> +
> +#define MAX_LSM_COUNT			\
> +	__LSM_COUNT_EXPAND(		\
> +		CAPABILITIES_ENABLED	\
> +		SELINUX_ENABLED		\
> +		SMACK_ENABLED		\
> +		APPARMOR_ENABLED	\
> +		TOMOYO_ENABLED		\
> +		YAMA_ENABLED		\
> +		LOADPIN_ENABLED		\
> +		LOCKDOWN_ENABLED	\
> +		BPF_LSM_ENABLED		\
> +		LANDLOCK_ENABLED)
> +

Wouldn't the following be simpler? It's from my LSM syscall patchset.
It certainly takes up fewer lines and would be easier to maintain
than the set of macros you've proposed.

+#define LSM_COUNT ( \
+	(IS_ENABLED(CONFIG_SECURITY) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_TOMOYO) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_IMA) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_APPARMOR) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_YAMA) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_LOADPIN) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_SAFESETID) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_LOCKDOWN_LSM) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_LANDLOCK) ? 1 : 0))
 

> +#endif  /* __LINUX_LSM_COUNT_H */

