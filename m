Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 870F2190336
	for <lists+bpf@lfdr.de>; Tue, 24 Mar 2020 02:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgCXBNP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Mar 2020 21:13:15 -0400
Received: from sonic309-28.consmr.mail.ne1.yahoo.com ([66.163.184.154]:36146
        "EHLO sonic309-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727046AbgCXBNN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 23 Mar 2020 21:13:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1585012391; bh=E8pHerNHsgqWl5NSFOxfCUBbRlZ0aBL2d+8GXaQowo0=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=CHjGmQneFxo3HOlwUQ1F5pIpkGWLUBzDtSackwOb9nsluo6LL6czIxrpLVVxZRYCDVr3JF2DqqiFyBav8yr1z8S+KYWBZLWv0ivOx+SpwXsCpVOo2ejrtcAA3j6rwLgpCL5zOwoGVplE991Q6bQBIFSalZKtiJY3j/0lDvWZ28vZHIi6B89by0r4W02V5+ICKZz/xRHoiMnwjxaeCCDd4nEk35ZHLfeSdcDEhw4/EhT/34PpTnejW8SquBnUA6K9oEdhrCZv5qNLWcGvpY8nTv5BpIlWSt1wBp5S6A+3LPAcZrhswBxWIMKT+Hie6p/sITS7JX/0AvGmpikM3AO+/Q==
X-YMail-OSG: BqJGlHUVM1lNoa2h5P_r9xXOl0mDdmmPYJz7quqH5B4YsBNHQrUgDvEberQT_EC
 ftODOoISmAR8SSLISv3T0rIghoVw_KT2mzr3x0rcdpiqgdpRKnB82hI4GfoXnyScZSbN_3oEvPWd
 ar0oJ5g_1KClK69pIfGr.LAbe7n4TBK6AZ4kBIqcRK7RzydsG4xHW9OT79Rk1VLbmXvnxFZL1ll.
 QWJzCEvgKvZt77lTSao4pWB008Ze_ccehBqHeGz6J4NiNxL0Z02gmCdOS_.j775dPPxe6.vSwn_C
 .pkWESJ0b7gx4dvoAtyT3CngXz1EzZ.P0ATbld1pE5nJ7bVynEAAbKcMGV7iy7kecVMrvQmNGZ9s
 80HL9g9e71Mfoc6zlaZWe2TABZIvQ_1rir5oDe0cv9AZfyvMBEOfxhuF86.mF_mE3uRV7rf17VK0
 0MyE56kkmoTVzB9q27Yei_4paZH_sZflguJLOEdvKG7ZWcLZXSa2UCYk4gwUEYvRRTjuaUdnTaUo
 J5LWwKcnvCJ5WiNSIOv5RFwB9K._sPZfHWiKqkHdO0ALYu9RXiKCTuoUR0YR9ajSu7o8g_lcPsLF
 QG6u8rv5sfZDOM_96aIpCSbkD4eKhRjRyjKtv3TXLClStHwCDwEEiuy5C6yRRdywiMCOx9BDfM1b
 orRwsI60QjKtpuI8X4rlT8dRlAHzisJVrpIN1dGseKQkOnHBuWu_XnYM4rzfD9kNR2dbnGr9NBCF
 oXGz15M.1mZgZk5lmfML4vNZGYp2sBFEU77zo_ZDChFt.tWtnEx_xNwzF3oqGuQ0nHYqNoQAuCrc
 xzbvMiBJNMGuDA1qUHzPYp79nBbOJBA1MTxVz2VxMtgO0_e9Sp72YZzP2Kgct.Vj1laevrf0ilwx
 F3heg.V3o9ewwqH1.M0tmEAjiE6R1Jv.AG6yfYg7W.LfoY0w8lbJebb3juASPD1RkH4k6p9_J8Hk
 SitsgX3gj_uCFBI0isfJrbCQldzN8Cf8eaYU3gMBCGtbtJ5K9MGfnEmNJTtFhVRbM7LO6cA04Aqe
 WlDZomSTAkNu84UxkFE66yHscaIgcCT9bIwiMlhqdvcBnAdiZSCNo.LMZcWgbGBQg6Pkow89tvyk
 dYslQMVga0RKJ2oZumfkwj3GeRnlM7xCpGTugErGTZd7_ElKxBLkn7ZBHl003MrNJoEr4bRsziKm
 Cx3JhFRPjnXT7jCB4N7DSee.OxMKVMRi3gA51_vw5Fvn9uc.PP3fVG4_8x60svuMDW5EPJZLn7BR
 vUCZdY0QmG9woTdBeaF2luwctPRwqDVkmvSoihzfPBLV885ANwahjgT1dobOFXBMid.oOgdpGHg2
 EUXlMONl7AKXq5yNxvw1IDMg6OiIR_R9DI937iFOUNEdgWb7pupnIJXnrv6HJrDDoClDhfWi894M
 x6jkGr49rr.L56zR7YZBey9OFnUeNBCzJCqSMv3BO0E2nWoI-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Tue, 24 Mar 2020 01:13:11 +0000
Received: by smtp416.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID eaf3f90a99241b90d501d246ab4bcf2e;
          Tue, 24 Mar 2020 01:13:08 +0000 (UTC)
Subject: Re: [PATCH bpf-next v5 5/7] bpf: lsm: Initialize the BPF LSM hooks
To:     KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200323164415.12943-1-kpsingh@chromium.org>
 <20200323164415.12943-6-kpsingh@chromium.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <6d45de0d-c59d-4ca7-fcc5-3965a48b5997@schaufler-ca.com>
Date:   Mon, 23 Mar 2020 18:13:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200323164415.12943-6-kpsingh@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.15518 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_242)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/23/2020 9:44 AM, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
>
> The bpf_lsm_ nops are initialized into the LSM framework like any other
> LSM.  Some LSM hooks do not have 0 as their default return value. The
> __weak symbol for these hooks is overridden by a corresponding
> definition in security/bpf/hooks.c
>
> The LSM can be enabled / disabled with CONFIG_LSM.
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> Reviewed-by: Brendan Jackman <jackmanb@google.com>
> Reviewed-by: Florent Revest <revest@google.com>
> ---
>  security/Kconfig      | 10 ++++----
>  security/Makefile     |  2 ++
>  security/bpf/Makefile |  5 ++++
>  security/bpf/hooks.c  | 55 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 67 insertions(+), 5 deletions(-)
>  create mode 100644 security/bpf/Makefile
>  create mode 100644 security/bpf/hooks.c
>
> diff --git a/security/Kconfig b/security/Kconfig
> index 2a1a2d396228..cd3cc7da3a55 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -277,11 +277,11 @@ endchoice
>  
>  config LSM
>  	string "Ordered list of enabled LSMs"
> -	default "lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,apparmor" if DEFAULT_SECURITY_SMACK
> -	default "lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo" if DEFAULT_SECURITY_APPARMOR
> -	default "lockdown,yama,loadpin,safesetid,integrity,tomoyo" if DEFAULT_SECURITY_TOMOYO
> -	default "lockdown,yama,loadpin,safesetid,integrity" if DEFAULT_SECURITY_DAC
> -	default "lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
> +	default "lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
> +	default "lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
> +	default "lockdown,yama,loadpin,safesetid,integrity,tomoyo,bpf" if DEFAULT_SECURITY_TOMOYO
> +	default "lockdown,yama,loadpin,safesetid,integrity,bpf" if DEFAULT_SECURITY_DAC
> +	default "lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"
>  	help
>  	  A comma-separated list of LSMs, in initialization order.
>  	  Any LSMs left off this list will be ignored. This can be
> diff --git a/security/Makefile b/security/Makefile
> index 746438499029..22e73a3482bd 100644
> --- a/security/Makefile
> +++ b/security/Makefile
> @@ -12,6 +12,7 @@ subdir-$(CONFIG_SECURITY_YAMA)		+= yama
>  subdir-$(CONFIG_SECURITY_LOADPIN)	+= loadpin
>  subdir-$(CONFIG_SECURITY_SAFESETID)    += safesetid
>  subdir-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown
> +subdir-$(CONFIG_BPF_LSM)		+= bpf
>  
>  # always enable default capabilities
>  obj-y					+= commoncap.o
> @@ -30,6 +31,7 @@ obj-$(CONFIG_SECURITY_LOADPIN)		+= loadpin/
>  obj-$(CONFIG_SECURITY_SAFESETID)       += safesetid/
>  obj-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown/
>  obj-$(CONFIG_CGROUP_DEVICE)		+= device_cgroup.o
> +obj-$(CONFIG_BPF_LSM)			+= bpf/
>  
>  # Object integrity file lists
>  subdir-$(CONFIG_INTEGRITY)		+= integrity
> diff --git a/security/bpf/Makefile b/security/bpf/Makefile
> new file mode 100644
> index 000000000000..c7a89a962084
> --- /dev/null
> +++ b/security/bpf/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (C) 2020 Google LLC.
> +
> +obj-$(CONFIG_BPF_LSM) := hooks.o
> diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
> new file mode 100644
> index 000000000000..68e5824868f9
> --- /dev/null
> +++ b/security/bpf/hooks.c
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright (C) 2020 Google LLC.
> + */
> +#include <linux/lsm_hooks.h>
> +#include <linux/bpf_lsm.h>
> +
> +/* Some LSM hooks do not have 0 as their default return values. Override the
> + * __weak definitons generated by default for these hooks
> + */
> +noinline int bpf_lsm_inode_getsecurity(struct inode *inode, const char *name,
> +				       void **buffer, bool alloc)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +noinline int bpf_lsm_inode_setsecurity(struct inode *inode, const char *name,
> +				       const void *value, size_t size,
> +				       int flags)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +noinline int bpf_lsm_task_prctl(int option, unsigned long arg2,
> +				unsigned long arg3, unsigned long arg4,
> +				unsigned long arg5)
> +{
> +	return -ENOSYS;
> +}
> +
> +noinline int bpf_lsm_xfrm_state_pol_flow_match(struct xfrm_state *x,
> +					       struct xfrm_policy *xp,
> +					       const struct flowi *fl)
> +{
> +	return 1;
> +}
> +
> +static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
> +	#define LSM_HOOK(RET, NAME, ...) LSM_HOOK_INIT(NAME, bpf_lsm_##NAME),
> +	#include <linux/lsm_hook_names.h>
> +	#undef LSM_HOOK
> +};
> +
> +static int __init bpf_lsm_init(void)
> +{
> +	security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks), "bpf");
> +	pr_info("LSM support for eBPF active\n");
> +	return 0;
> +}
> +
> +DEFINE_LSM(bpf) = {
> +	.name = "bpf",
> +	.init = bpf_lsm_init,

Have you given up on the "BPF must be last" requirement?

> +};
