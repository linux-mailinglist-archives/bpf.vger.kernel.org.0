Return-Path: <bpf+bounces-10481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E9D7A8B2C
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 20:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4924A1C208DF
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 18:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C82450C6;
	Wed, 20 Sep 2023 18:08:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52CA1A583
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 18:08:01 +0000 (UTC)
Received: from sonic315-26.consmr.mail.ne1.yahoo.com (sonic315-26.consmr.mail.ne1.yahoo.com [66.163.190.152])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C643FC6
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 11:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1695233278; bh=bI+HEsL5IIO8GrX5ATSrNrDAFppFArKI69qU9xyiuhM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=FmjZeW8q3FL8DV/e1SejPbE6wC1trLr8qzRAyUd2hI+tpjuTfO1j6U3uIkqeTcadU8j4vvyS1NQqYHh0+vLBH0J9N/lgmZ0GcIPJ/qSS3VzXHfPo/QguB9Qe0JbfmQ4Sx5AdmlJXtXih6/3Bhs/FXVL7tZ+PBjTvwpGgKlPXuZTQGHUmLPPu+VBUbpcGjFv1mG9eWUydc9LJY01tDUe8FUdifQobHCiaAyw109tdi+jVgPqN9uFovH+rw5LhsipQfdKLQBAE+rJtmGyAabTM0wp32Q5NSbEBEWdnIDncLxFZy0plmFlxsnpjOGimlsvSBYrQpgBI1PfOqnQwGH0Bpw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1695233278; bh=dFjKc9PMqzZb3a10hU1M6YuC0wobKSFM8MyrAOXpDbb=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ok5DUk9+05yWF2lmRPaBWxsI9d7N/iluEJIGV+W2nATxd/dWfmC5OfdVqNHtRmPvgZ3bbNG+dLAmDm6VPSykZr4pMcmgKEHmTgIGtf0RtBFE2lton2ZQWP+KZ5VJByQ2hi3lTuPSXdsV4LLdS0DsbNvmhJncq7j71G4A8b/EvLZ01n2PUxrq4NIW1wEWOgqVCJNGKRhfbcu8bdgJvYcWHsR9Twm68+ZBlvMT45W3pKKFU/gTWxvG5KFclhwM6VSmD39W1LMJgY79gkPiBUlrc1wGiDZLWyLEVHyEJVABs0NV3ovtMiME2F4gbMvzsxvyVnZNSQzhtRynpCB5O2fmWQ==
X-YMail-OSG: at5UIdEVM1kS0_GBEHDWeJU5rQbfG.l7L0dfMjigrhGP4Z_l7IgHZYXBVWjY_DK
 iF4X1HoE52YcYPcfIvl58VPrl_NkKByFDku9Qv9YBV8qJa5i4RsnqPXMbywgH27K9P6K71hxX9We
 VRyHWHXLZCFm2RmUf5IBfWcnY4ov3mA4b.8K23o5TziRbuvM5lUdVfy8UaqyckogiYjXkmnv7Tja
 gJTJ9CF5H_A.QrnZw0regMAwzdJggmz_ZZC1IgauOWqZicfJ.b_sUGHslLe4B2iUJwifiM2LOZN1
 xUMk_ILcQFdjWki9h.dVcZxIY0dk49NAGcqUt6rFuhQK7q1X4PSoG2nK6Zq6RCC7ikwXDGy9gElr
 KJA9yEfsGlV2LpbcA1j6Und8j06pxWfrHByLwPUeRRDGStl0d7TK_Zh7dAvWzd8aBMqCEPRVoXuX
 6PpnzdNyRJNuG0YY7z69uEreRdE8YaB5qs_anNaCO5ai0HYjk7o1fTqGx9W2TvpZF63GkN7xj_qR
 tCzhYcF2nHBFUhw_awKm8olynpdaAaAGeluz8vcrrdOO4P6rP1c2qpXfwDCSf99mGD8LVULAEbjR
 C3ZYTb2FC64EoNeKUUt1d3hvvCXoBSfEgyTMHzGzds8K26USkF44q2nHCRwgYl6A8JZnoorphpHb
 _REje4b3PW9WIBNMbE0oG7GjKUS0.xCyOaZ61HzTTpXSbOVsguQzu8qjDUdGyvcTMrfmHHH2bhWO
 XwwKS5TcCfB7dP7ICDwvdeE_VFu4bU2oFvlU7wdIffu2L8Yb9pqNN46otUpFY_RcyINBmOO_o0Hs
 nCP32TbHmxEz1JvtdDLSe.yah3dl3S5z7Xe6YbHFH3iRbgzLMwJoZoxAIF_JCUlTSM2F3VyzeMzA
 MTPEb4r3KsvSQFOAOSs.ZanparjexUX1XigVT8izLxkJ5EFBdIhMx55PscFDGuuVNsRT91hd5A1k
 8OrgLZTIaho4ZbQP0MNwK0zrCxAvQstmTpC8RsHttmZ2jJsxMJ_.ljv_3uVjtnIWARBlN1nZKkeW
 RrFTHFkxGgIGrLbWi3zaxcnW.rbEY085kQqUT3YAlK85gC205guc4_opwwNOwtAViGeodL0zwHdY
 55szm9LcZIE8hdejXbWMFRLrVg12BDg.4wW.9XKB4BNPX0uCqva6cL2HIVL1VuHK5Hm53x5WQcj0
 gVZbqTo9uFbOdFXi2JIju67soyc_S2s_jC2q1fndcqcDTyZjpg9SNJx7k8eL5xRTCexyUO9GZyVv
 5phnDRskWa6YEbqrzrHnb3yBUMHhN4Je9zmOQMCFWsqaVnxyKp345dgc8YFC1YfQZHYI4eePshBm
 cRi6UZ9aRAIDJW9RPSO44QESd8aaQq6JMb0G9mEWjUzbWkqD7NXlG6_3L67FojCugsU6vtHIo5dN
 sVtKlCdASj_mNFT62zlOUSU.X4IdxS9llnNn3Ewh4JCkY3YCI_3Paw7gsyIfzzpRjVqRhyGq7ImF
 NrXVZDqb4R7woCDMfCPR_crwlsNQnEImIdtvYdWc6KqDckSyyyTkRlcqKh1yhwDHXnIx8Y0KkXVY
 VzdwQodjVAE_hgvh5z0lVtloWmqy181rPE9axgEQDc2G1U8vuC.f_YuI_oQT4oRYYnCLtMEOFCCp
 .HHd.1Yf5Ia3vrh8i21uQJnLGztjntEYtpMDmqSrWXeCqbeHvNBmyd_p6BRSXKGnJUNTIE1k3c8V
 PsPfzHk3al0xsdNsIpL5i8dQaDGkpN7VsX9_PEFR0j78.kchnIFMdPY6XPqY7kfO2Ab2S4bVnhcV
 7Wnv1q.HrDdbh9LzwhlFsbSEM0sbsPosgW.JT.7oJ_vwyodGCvpI0CBT9muGuPryxR1sUe_XkRrb
 bBfqihB9dJ_237IMzsJ_9uBeC0q2IPgmUuhPoBDBU3sQoO58JZxADgstHVADduMh2acrNyoHjQvD
 eahPVzzPJ21v79uJYvaH_hQqPxnkNspepE03vSa1twDrCJqsD3PZkdjksjF6TKOrfKXbL_k9sME3
 ufYLuXB77YWcVb_DqLXbRbQDiMd2cjrz9SXt3PGGMowUDsn.H11n2Nqu7uFG3PBPWHN3m03xXrWC
 .ByuRwF1z6_DnVwOwkdbhOqvaQG7KwhMz2wn4pmLjE2UDc7EBUqJJPhkwqEpC7fp8p5II1z3VYJe
 o39VXK5472RvhSjXU4ZLuzoiZyh5jm2McvaS.OvVhjC4sFbNsG_rvrcmb4rrR7rYB_mLImQZVcwb
 Qfzz4sTg5.8RCg22wivOkjN_By_hLmqhkrXNO6ousPU7LQ49WIyLIwYK6GaITSmMXk9N0pxq.TVp
 .ERY8CkjW
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 72b8396d-2f91-4f26-b971-1998ef90026a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 20 Sep 2023 18:07:58 +0000
Received: by hermes--production-bf1-678f64c47b-6cjq6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f602da600db39c176407fc0e5c9b23c6;
          Wed, 20 Sep 2023 18:07:55 +0000 (UTC)
Message-ID: <98b02c73-295d-baad-5c77-0c8b74826ca9@schaufler-ca.com>
Date: Wed, 20 Sep 2023 11:07:52 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 2/5] security: Count the LSMs enabled at compile time
Content-Language: en-US
To: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org,
 bpf@vger.kernel.org
Cc: paul@paul-moore.com, keescook@chromium.org, song@kernel.org,
 daniel@iogearbox.net, ast@kernel.org, Kui-Feng Lee <sinquersw@gmail.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20230918212459.1937798-1-kpsingh@kernel.org>
 <20230918212459.1937798-3-kpsingh@kernel.org>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230918212459.1937798-3-kpsingh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21797 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/18/2023 2:24 PM, KP Singh wrote:
> These macros are a clever trick to determine a count of the number of
> LSMs that are enabled in the config to ascertain the maximum number of
> static calls that need to be configured per LSM hook.
>
> Without this one would need to generate static calls for (number of
> possible LSMs * number of LSM hooks) which ends up being quite wasteful
> especially when some LSMs are not compiled into the kernel.
>
> Suggested-by: Kui-Feng Lee <sinquersw@gmail.com>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org
> Signed-off-by: KP Singh <kpsingh@kernel.org>

Much better than previous versions.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  include/linux/lsm_count.h | 106 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 106 insertions(+)
>  create mode 100644 include/linux/lsm_count.h
>
> diff --git a/include/linux/lsm_count.h b/include/linux/lsm_count.h
> new file mode 100644
> index 000000000000..0c0ff3c7dddc
> --- /dev/null
> +++ b/include/linux/lsm_count.h
> @@ -0,0 +1,106 @@
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
> +#ifdef CONFIG_SECURITY
> +
> +/*
> + * Macros to count the number of LSMs enabled in the kernel at compile time.
> + */
> +
> +/*
> + * Capabilities is enabled when CONFIG_SECURITY is enabled.
> + */
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
> +#if IS_ENABLED(CONFIG_SECURITY_LANDLOCK)
> +#define LANDLOCK_ENABLED 1,
> +#else
> +#define LANDLOCK_ENABLED
> +#endif
> +
> +
> +#define __COUNT_COMMAS(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _n, X...) _n
> +#define COUNT_COMMAS(a, X...) __COUNT_COMMAS(, ##X, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
> +#define ___COUNT_COMMAS(args...) COUNT_COMMAS(args)
> +
> +
> +#define MAX_LSM_COUNT			\
> +	___COUNT_COMMAS(		\
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
> +#else
> +
> +#define MAX_LSM_COUNT 0
> +
> +#endif /* CONFIG_SECURITY */
> +
> +#endif  /* __LINUX_LSM_COUNT_H */

