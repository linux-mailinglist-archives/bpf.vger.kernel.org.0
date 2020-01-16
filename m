Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72E5C13D4CE
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2020 08:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgAPHFE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jan 2020 02:05:04 -0500
Received: from sonic316-28.consmr.mail.ne1.yahoo.com ([66.163.187.154]:39052
        "EHLO sonic316-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726925AbgAPHFD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Jan 2020 02:05:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1579158301; bh=de8zPLdqg6fSSd4oF4kZ+iWanKGI4Sunjl1cVRgFylo=; h=Subject:To:References:Cc:From:Date:In-Reply-To:From:Subject; b=ZtUYiVHEYUpljiyYKfL9HSVOFILIrFTDy4/JBZjl2x8/slYq1bAqUCCLTuK7AomwE1+lbGMt92M4pxhm+aj13y/bWlIspQlp6wnUA9cbr3WqkfQe/eeZyK8W6/x+tK2sGYs1J6pXFQulBh7xlT8b/6/ChnsU9dzdFb/fStK0OCNG8Q7sJ7+BOCYv3mKtlCck7uNA+q0L+A10s2uUVft+Na4hXPOou8z7l8RHDhiDh4oS+65MerII2sUn9GpRg0vspeCVaDjQ1z+0S0zfyvxsNHd0skWM7lBLkPEKw5pUkj9tiDc53wMkUntgBnx3P1IV1INiO2qTK7Lt+7XyiifeXg==
X-YMail-OSG: Zm7A8X4VM1nccUeLO8jYJt3TPj6iCTl7tzlXI7jrlxt5kLQLDu6Jb9t.yMtBM0W
 2Dp_j8qtyBnGAVgGHtO3YpletQyl6sN.42wPyPS13je3lKmnH7lTUv2ZEXIZGxg6THaOYDaGeqcn
 Ijyr87r0I4IfvO61bu_hxwAvMBs.o6FSdiXnAj45_4MpQhr8jGxD6vxsOS27B1FImuMo7DlvzYgl
 Ce2UU00s7OC.rrUy9CxtSppaoGJev1dp8gs1lWEHbq9VArIw1GTLJZHjCSY5VAqQzm3mfM9FYHUM
 NPUgJv0TV0MtwK65qQ.maD9ZX1UUeyxayiopgy5DmWVSKa1.IfO1cjBmKh67js6QhZXPiI53oeez
 hRbAxf2fUpSH86cFOM65WQLrVFTL9dfMhVb2cggF26CjHZjKix26XmkkRh6EksZftFiBftD.RS9H
 ho1dXublmUvrSAZwiI1zE2KujpLY7P2c_ZxlSxceaEHZZzxG9xkAHR9Ff9D4rlwZ1TXokPDCh7pL
 baw1hrvDzrfqPCXq_O4HsRe3bzfd1CGwN_6D2p._QphGCemAPxVd8QWNE5rEBMcJMvIz4HXXo1rB
 ICjx3YtKPHWk9zg.wefYXKa7MONxWB.vIg32YsQMHH3t9V0FZTDbTYUXmtEUOvyFsCgtxPivAV_N
 jX5y..hreeBgA8myzBHdJYuUPN76WvveMbEG10SKLnqAIJWklucDQzzsS6p.3K48lFLsFk.w29P6
 GCuAPJo8kp0yukScjb.z8rWNhYh_Ya4IpJAQDsPoZ_GGf9awFVc7VjHnfrvdeEAeEHK.fam08xJO
 tAaJioTJOgKjhXsDz7_jtV6ErqfRSrLj9XG8jLbmjZ.3XpgZSycR2In1aYNNAS2g3zK3YNdc_L_m
 ig31nfiBKzXNkDFSJozhgYb9fgBNlOP2xEOrqL8fkNY_HSRBQXFw4y4grL6o_Tx_dVxOnxqvRMBh
 ZFF6NTvIFgTudaTpwrNwu7V56Pp9G1JCcfx9vXE3.cCC.wNIZMHj7dtBVYBM_Gnmdhqzq.rO_zUK
 8OYlVkO4vFOJjFahrxD_NliurtsSkLgk8f52ZPdCMGcI4G7tYZVIOXkBGsJyjbniD1gBdyMMMvH2
 sXIrisWVVRqxc13MdksAckkb7I.Bpe8k0cF85KdLIfMe.5dq_6aXRrp3V1CY.ssmob2YzJcz1UWG
 myBOVrBkcu0S5NXLFzXrOtCTDvoA1GBpG47CDhygacoHXxcgBMpUm6WPKE2QwJRg8sTw1ADR9gKs
 XnfVdG.RUCpa3xfFROphQuujJKPA0jLqi.wdfyp2ptyBmFNxIvzEfJp2OWlIQ730pQHqZ5GKREvg
 2ufJ7FCmFfyh0UtW0EY.MydAGdtSFSv76.uj_ss.xr810QwRKYYVSikfYmiDPID_hJarKPrD4_u1
 BMqh1egq7HtolB50BgkYORzGADgLqY.5KpJLg97n99GhxSUkQ3yeb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Thu, 16 Jan 2020 07:05:01 +0000
Received: by smtp422.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID bd9dfaedbc3ad3a7c1555c5ba2e872ca;
          Thu, 16 Jan 2020 07:05:00 +0000 (UTC)
Subject: Re: [PATCH bpf-next v2 02/10] bpf: lsm: Add a skeleton and config
 options
To:     KP Singh <kpsingh@chromium.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, bpf@vger.kernel.org
References: <20200115171333.28811-1-kpsingh@chromium.org>
 <20200115171333.28811-3-kpsingh@chromium.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 mQINBFzV9HABEAC/mmv3jeJyF7lR7QhILYg1+PeBLIMZv7KCzBSc/4ZZipoWdmr77Lel/RxQ
 1PrNx0UaM5r6Hj9lJmJ9eg4s/TUBSP67mTx+tsZ1RhG78/WFf9aBe8MSXxY5cu7IUwo0J/CG
 vdSqACKyYPV5eoTJmnMxalu8/oVUHyPnKF3eMGgE0mKOFBUMsb2pLS/enE4QyxhcZ26jeeS6
 3BaqDl1aTXGowM5BHyn7s9LEU38x/y2ffdqBjd3au2YOlvZ+XUkzoclSVfSR29bomZVVyhMB
 h1jTmX4Ac9QjpwsxihT8KNGvOM5CeCjQyWcW/g8LfWTzOVF9lzbx6IfEZDDoDem4+ZiPsAXC
 SWKBKil3npdbgb8MARPes2DpuhVm8yfkJEQQmuLYv8GPiJbwHQVLZGQAPBZSAc7IidD2zbf9
 XAw1/SJGe1poxOMfuSBsfKxv9ba2i8hUR+PH7gWwkMQaQ97B1yXYxVEkpG8Y4MfE5Vd3bjJU
 kvQ/tOBUCw5zwyIRC9+7zr1zYi/3hk+OG8OryZ5kpILBNCo+aePeAJ44znrySarUqS69tuXd
 a3lMPHUJJpUpIwSKQ5UuYYkWlWwENEWSefpakFAIwY4YIBkzoJ/t+XJHE1HTaJnRk6SWpeDf
 CreF3+LouP4njyeLEjVIMzaEpwROsw++BX5i5vTXJB+4UApTAQARAQABtChDYXNleSBTY2hh
 dWZsZXIgPGNhc2V5QHNjaGF1Zmxlci1jYS5jb20+iQJUBBMBCAA+FiEEC+9tH1YyUwIQzUIe
 OKUVfIxDyBEFAlzV9HACGwMFCRLMAwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQOKUV
 fIxDyBG6ag/6AiRl8yof47YOEVHlrmewbpnlBTaYNfJ5cZflNRKRX6t4bp1B2YV1whlDTpiL
 vNOwFkh+ZE0eI5M4x8Gw2Oiok+4Q5liA9PHTozQYF+Ia+qdL5EehfbLGoEBqklpGvG3h8JsO
 7SvONJuFDgvab/U/UriDYycJwzwKZuhVtK9EMpnTtUDyP3DY+Q8h7MWsniNBLVXnh4yBIEJg
 SSgDn3COpZoFTPGKE+rIzioo/GJe8CTa2g+ZggJiY/myWTS3quG0FMvwvNYvZ4I2g6uxSl7n
 bZVqAZgqwoTAv1HSXIAn9muwZUJL03qo25PFi2gQmX15BgJKQcV5RL0GHFHRThDS3IyadOgK
 P2j78P8SddTN73EmsG5OoyzwZAxXfck9A512BfVESqapHurRu2qvMoUkQaW/2yCeRQwGTsFj
 /rr0lnOBkyC6wCmPSKXe3dT2mnD5KnCkjn7KxLqexKt4itGjJz4/ynD/qh+gL7IPbifrQtVH
 JI7cr0fI6Tl8V6efurk5RjtELsAlSR6fKV7hClfeDEgLpigHXGyVOsynXLr59uE+g/+InVic
 jKueTq7LzFd0BiduXGO5HbGyRKw4MG5DNQvC//85EWmFUnDlD3WHz7Hicg95D+2IjD2ZVXJy
 x3LTfKWdC8bU8am1fi+d6tVEFAe/KbUfe+stXkgmfB7pxqW5Ag0EXNX0cAEQAPIEYtPebJzT
 wHpKLu1/j4jQcke06Kmu5RNuj1pEje7kX5IKzQSs+CPH0NbSNGvrA4dNGcuDUTNHgb5Be9hF
 zVqRCEvF2j7BFbrGe9jqMBWHuWheQM8RRoa2UMwQ704mRvKr4sNPh01nKT52ASbWpBPYG3/t
 WbYaqfgtRmCxBnqdOx5mBJIBh9Q38i63DjQgdNcsTx2qS7HFuFyNef5LCf3jogcbmZGxG/b7
 yF4OwmGsVc8ufvlKo5A9Wm+tnRjLr/9Mn9vl5Xa/tQDoPxz26+aWz7j1in7UFzAarcvqzsdM
 Em6S7uT+qy5jcqyuipuenDKYF/yNOVSNnsiFyQTFqCPCpFihOnuaWqfmdeUOQHCSo8fD4aRF
 emsuxqcsq0Jp2ODq73DOTsdFxX2ESXYoFt3Oy7QmIxeEgiHBzdKU2bruIB5OVaZ4zWF+jusM
 Uh+jh+44w9DZkDNjxRAA5CxPlmBIn1OOYt1tsphrHg1cH1fDLK/pDjsJZkiH8EIjhckOtGSb
 aoUUMMJ85nVhN1EbU/A3DkWCVFEA//Vu1+BckbSbJKE7Hl6WdW19BXOZ7v3jo1q6lWwcFYth
 esJfk3ZPPJXuBokrFH8kqnEQ9W2QgrjDX3et2WwZFLOoOCItWxT0/1QO4ikcef/E7HXQf/ij
 Dxf9HG2o5hOlMIAkJq/uLNMvABEBAAGJAjwEGAEIACYWIQQL720fVjJTAhDNQh44pRV8jEPI
 EQUCXNX0cAIbDAUJEswDAAAKCRA4pRV8jEPIEWkzEACKFUnpp+wIVHpckMfBqN8BE5dUbWJc
 GyQ7wXWajLtlPdw1nNw0Wrv+ob2RCT7qQlUo6GRLcvj9Fn5tR4hBvR6D3m8aR0AGHbcC62cq
 I7LjaSDP5j/em4oVL2SMgNTrXgE2w33JMGjAx9oBzkxmKUqprhJomPwmfDHMJ0t7y39Da724
 oLPTkQDpJL1kuraM9TC5NyLe1+MyIxqM/8NujoJbWeQUgGjn9uxQAil7o/xSCjrWCP3kZDID
 vd5ZaHpdl8e1mTExQoKr4EWgaMjmD/a3hZ/j3KfTVNpM2cLfD/QwTMaC2fkK8ExMsz+rUl1H
 icmcmpptCwOSgwSpPY1Zfio6HvEJp7gmDwMgozMfwQuT9oxyFTxn1X3rn1IoYQF3P8gsziY5
 qtTxy2RrgqQFm/hr8gM78RhP54UPltIE96VywviFzDZehMvuwzW//fxysIoK97Y/KBZZOQs+
 /T+Bw80Pwk/dqQ8UmIt2ffHEgwCTbkSm711BejapWCfklxkMZDp16mkxSt2qZovboVjXnfuq
 wQ1QL4o4t1hviM7LyoflsCLnQFJh6RSBhBpKQinMJl/z0A6NYDkQi6vEGMDBWX/M2vk9Jvwa
 v0cEBfY3Z5oFgkh7BUORsu1V+Hn0fR/Lqq/Pyq+nTR26WzGDkolLsDr3IH0TiAVH5ZuPxyz6
 abzjfg==
Message-ID: <7b11f92b-259f-f2e1-924c-5c0518f49b3f@schaufler-ca.com>
Date:   Wed, 15 Jan 2020 23:04:55 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200115171333.28811-3-kpsingh@chromium.org>
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
> The LSM can be enabled by CONFIG_SECURITY_BPF.
> Without CONFIG_SECURITY_BPF_ENFORCE, the LSM will run the
> attached eBPF programs but not enforce MAC policy based
> on the return value of the attached programs.
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
>  MAINTAINERS           |  7 +++++++
>  security/Kconfig      | 11 ++++++-----
>  security/Makefile     |  2 ++
>  security/bpf/Kconfig  | 22 ++++++++++++++++++++++
>  security/bpf/Makefile |  5 +++++
>  security/bpf/lsm.c    | 25 +++++++++++++++++++++++++
>  6 files changed, 67 insertions(+), 5 deletions(-)
>  create mode 100644 security/bpf/Kconfig
>  create mode 100644 security/bpf/Makefile
>  create mode 100644 security/bpf/lsm.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 66a2e5e07117..0941f478cfa5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3203,6 +3203,13 @@ S:	Supported
>  F:	arch/x86/net/
>  X:	arch/x86/net/bpf_jit_comp32.c
> =20
> +BPF SECURITY MODULE
> +M:	KP Singh <kpsingh@chromium.org>
> +L:	linux-security-module@vger.kernel.org
> +L:	bpf@vger.kernel.org
> +S:	Maintained
> +F:	security/bpf/
> +
>  BROADCOM B44 10/100 ETHERNET DRIVER
>  M:	Michael Chan <michael.chan@broadcom.com>
>  L:	netdev@vger.kernel.org
> diff --git a/security/Kconfig b/security/Kconfig
> index 2a1a2d396228..6f1aab195e7d 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -236,6 +236,7 @@ source "security/tomoyo/Kconfig"
>  source "security/apparmor/Kconfig"
>  source "security/loadpin/Kconfig"
>  source "security/yama/Kconfig"
> +source "security/bpf/Kconfig"
>  source "security/safesetid/Kconfig"
>  source "security/lockdown/Kconfig"
> =20
> @@ -277,11 +278,11 @@ endchoice
> =20
>  config LSM
>  	string "Ordered list of enabled LSMs"
> -	default "lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tomo=
yo,apparmor" if DEFAULT_SECURITY_SMACK
> -	default "lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,s=
mack,tomoyo" if DEFAULT_SECURITY_APPARMOR
> -	default "lockdown,yama,loadpin,safesetid,integrity,tomoyo" if DEFAULT=
_SECURITY_TOMOYO
> -	default "lockdown,yama,loadpin,safesetid,integrity" if DEFAULT_SECURI=
TY_DAC
> -	default "lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomo=
yo,apparmor"
> +	default "lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tomo=
yo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
> +	default "lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,s=
mack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
> +	default "lockdown,yama,loadpin,safesetid,integrity,tomoyo,bpf" if DEF=
AULT_SECURITY_TOMOYO
> +	default "lockdown,yama,loadpin,safesetid,integrity,bpf" if DEFAULT_SE=
CURITY_DAC
> +	default "lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomo=
yo,apparmor,bpf"
>  	help
>  	  A comma-separated list of LSMs, in initialization order.
>  	  Any LSMs left off this list will be ignored. This can be
> diff --git a/security/Makefile b/security/Makefile
> index be1dd9d2cb2f..50e6821dd7b7 100644
> --- a/security/Makefile
> +++ b/security/Makefile
> @@ -12,6 +12,7 @@ subdir-$(CONFIG_SECURITY_YAMA)		+=3D yama
>  subdir-$(CONFIG_SECURITY_LOADPIN)	+=3D loadpin
>  subdir-$(CONFIG_SECURITY_SAFESETID)    +=3D safesetid
>  subdir-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+=3D lockdown
> +subdir-$(CONFIG_SECURITY_BPF)		+=3D bpf
> =20
>  # always enable default capabilities
>  obj-y					+=3D commoncap.o
> @@ -29,6 +30,7 @@ obj-$(CONFIG_SECURITY_YAMA)		+=3D yama/
>  obj-$(CONFIG_SECURITY_LOADPIN)		+=3D loadpin/
>  obj-$(CONFIG_SECURITY_SAFESETID)       +=3D safesetid/
>  obj-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+=3D lockdown/
> +obj-$(CONFIG_SECURITY_BPF)		+=3D bpf/
>  obj-$(CONFIG_CGROUP_DEVICE)		+=3D device_cgroup.o
> =20
>  # Object integrity file lists
> diff --git a/security/bpf/Kconfig b/security/bpf/Kconfig
> new file mode 100644
> index 000000000000..a5f6c67ae526
> --- /dev/null
> +++ b/security/bpf/Kconfig
> @@ -0,0 +1,22 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright 2019 Google LLC.
> +
> +config SECURITY_BPF
> +	bool "BPF-based MAC and audit policy"
> +	depends on SECURITY
> +	depends on BPF_SYSCALL
> +	help
> +	  This enables instrumentation of the security hooks with
> +	  eBPF programs.
> +
> +	  If you are unsure how to answer this question, answer N.
> +
> +config SECURITY_BPF_ENFORCE
> +	bool "Deny operations based on the evaluation of the attached program=
s"
> +	depends on SECURITY_BPF
> +	help
> +	  eBPF programs attached to hooks can be used for both auditing and
> +	  enforcement. Enabling enforcement implies that the evaluation resul=
t
> +	  from the attached eBPF programs will allow or deny the operation
> +	  guarded by the security hook.
> diff --git a/security/bpf/Makefile b/security/bpf/Makefile
> new file mode 100644
> index 000000000000..26a0ab6f99b7
> --- /dev/null
> +++ b/security/bpf/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright 2019 Google LLC.
> +
> +obj-$(CONFIG_SECURITY_BPF) :=3D lsm.o
> diff --git a/security/bpf/lsm.c b/security/bpf/lsm.c
> new file mode 100644
> index 000000000000..5c5c14f990ce
> --- /dev/null
> +++ b/security/bpf/lsm.c
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright 2019 Google LLC.
> + */
> +
> +#include <linux/lsm_hooks.h>
> +
> +/* This is only for internal hooks, always statically shipped as part =
of the
> + * BPF LSM. Statically defined hooks are appeneded to the security_hoo=
k_heads
> + * which is common for LSMs and R/O after init.
> + */
> +static struct security_hook_list lsm_hooks[] __lsm_ro_after_init =3D {=
};

s/lsm_hooks/bpf_hooks/

The lsm prefix is for the infrastructure. The way you have it is massivel=
y confusing.

> +
> +static int __init lsm_init(void)

s/lsm_init/bpf_init/

Same reason. When I'm looking at several security modules at once I
need to be able to tell them apart.

> +{
> +	security_add_hooks(lsm_hooks, ARRAY_SIZE(lsm_hooks), "bpf");
> +	pr_info("eBPF and LSM are friends now.\n");

Cute message, but not very informative if you haven't read the code.
"LSM support for eBPF active\n" is more likely to be comprehensible.

> +	return 0;
> +}
> +
> +DEFINE_LSM(bpf) =3D {
> +	.name =3D "bpf",
> +	.init =3D lsm_init,
> +};

