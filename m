Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775E46748E1
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 02:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjATBdF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 20:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjATBc7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 20:32:59 -0500
Received: from sonic314-27.consmr.mail.ne1.yahoo.com (sonic314-27.consmr.mail.ne1.yahoo.com [66.163.189.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58722A792B
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 17:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1674178362; bh=ikj1o4veVLP5Bzj1y2o4Maw2G1CqVWCXasYMvGmY/kM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=iZfndns9AFgVl8uA+kJWbMXMq/MsbJNzCiLUMgb3N8qDi545tS86HbV/mO39vyeRltei74Jr2eeSinY0zp/K3ShNUOalK5Ar6r93J7ExcTABKw9DtVkqN+M4c943QtaOyqBP2GkGNdUvBe4GzDIL6AaS82CSsy7JdlQPfDJ/iBgxrwoZoCcO/usppa/wZKcTy4wmXnSMQGfR8C77/ojTN35mMNasWhemJaQmnRKhIfF26afUu3+7fNDWmjuKVcQ+Ce6pey38j5i4IrDMR5UqSwosZbbQdqzQNIITHozFzuI132eONlVSVCXL7D4eWfabkKQyGEJ1MMPsSocRo35KvA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1674178362; bh=FulndP8c4qyzgen1AI/PGpJVwpbmNyumNeC+f32n5KB=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ICEQ/2XLEE8nT3Qn0KGbPtuYlAGlJCVuEpXtbGNDwsUlbbOQAYjIAQUYFrBf9IedfmkiWk7jsa6TmsdBqWvleyHzxUJO8A75nPRAY81jXx6sHni8irDZllZbxZoQHA/G9ZtDprkYe+sQL7nFsLT9hNn6al5sKEXJciObc80n0TTSCwbySLm6Nmzi58WMrp+IBds8E1AGe/r09BivafVHQ9pR+6H+bKVmSKIabddc3/Rz/vfvkKzZrP0ciJZYsjhVL2+ONzUpKDG+9k47GAPcDSRj7FG6YHU6CI8bTL3OP5CwVpLp4kpIFoMwJzm5ywvYA8XwoZ7QV3fgTe7/1p1y8Q==
X-YMail-OSG: ZIzqUY4VM1nDwW2822EGBGdRRSHa5ked5XgWmKh4FAnd9HLwonctlpnmRZDRNOw
 NV8K9t9nU_S9zc7PHqVkQ0BhrF3a7lj9Pvdx3ATVK59CTnn__.gA3NWPSvg2hSBBGnkXG10anYAc
 vAbaZiQ3Yh_jCZycV3zTE5zyBOIzMcd_EPfbUNO0eB5f6hJnvTDdX.xlSK4CpSsT__pt1plpV0HL
 UEjZbZ3WteBtIkN0zbSlFNYeK0biUcnRTcc0nbPUMQB_cv8GdcA8KGUGnzpBuIxPSsUlxHzn9xmQ
 4a1F8aM5ptaofuF7_DblGmaCNY8DjFqfWMbNDIpXt_sEOvKBLJSqZAQ.cozPepfGAhJpnPh48QL4
 5Z4UaHExofyRb56F0w_uM_Liig0FOrt5_A_C9RykpVFs3spEpAOxEZRSDXCCm1AG3aLWQ6GsATqu
 OYNXLhyWPQl6LWqhLA_WkC.Pt8MI4skjQouTeq9cVPPfspPHWrb3wtfzJnb0y49opxaHEtml_V80
 JiLaed7CuNIJKV.jUCcUYKnXq6z3P8yCfX8l8K.V0PJEcYArzHr3xmb9dCE2IGB9IFVoTO33u2lG
 P73sauNbNCxmL1rk1J1IFl1UMq_PLzwf2waxIxJaYUmMVCyV02JsF86PVBU_I7SEh2n37hhItFHk
 BotiSV3mmEOtmT6.mja9c06X5CotlqW1Eu1ycFbZphMAHg099H4KVQCx6Qlx1a6RJM.dKSDub2Sr
 fhabja8qhUCsjY6LYhk1KtdROgc0uxdcOqcm1iZd7umwGdWhg1ei_dSI20JJi8g6bHRK8fZBM98Y
 EFWBPRxw3LTsbhEOXlA22dxFeZMvtfYinZHOsrww7adSOoTa7Idh70mVCd87Cx.54O_bKbqXE8jq
 7V6z0CgA6SbMcSFxvic80m7ayDJxK5lOgirYfEW87sceMjOl4geR4lFDNwQe1o18abqFgrusJFNE
 ZHgAh70Hsc4bBRFjfqgm.QricArhwfzd0DVDfXaSxkECVVkA9jRJBa.o9vHcdq0r3iFWLoGq0wye
 DpI5OFeTpr3iXJjHpJjVQIjemEoCcFJXJhxcxTa2Qsw2bsYk3Jze.51L2F0oGUQ6D6BA4BQtxqVp
 _S_f7dbYDMwLeh3TnGv2pjezDfnnTdSZggMlIqmRKotuOe4J57AsHCZI9qgk6AwVtt0mwhCMrMZ9
 nBh9NdMbzgzxQqzO2I6inXFwGd74KDzDJD9OlgtIGlWPxK09mC0ETeujUaP3CIfHsRUkbpHbsqwk
 ucRkDKaZynC6BbEXa5Wrq8NccxGGWLRYV2hVr8twLs0F55ixn0AcaMe8XXUlcewC._NEIh6IEIFw
 ZwwYVDMidZOOJp0qnR2A6sTJNaYSU07DWqB2JEY8kCaO_IV2o3cdMYGDtCH9U7SxYoV45vBeMlRn
 dmLxlXP4UNaL0U2hRuqfbiiAp6x68QpEGs12slcZYqm4ph1RIwrOIWxlcdADC9S4yAUzt2pYkpGp
 PBKyD36Zu0mMlbkNksNBAQTOEsiHF5VY2LSxN6ttUVfglIGkQuoSsX8Y8oATonb2p2QuCLqyeopf
 dU__zSNtOBlwfz6ik.lfnqFQCkjv0.yh620wjTxhrdVFFXf1T8qpQzCdK8hVmRiYkubesdW9XDKZ
 V2oyzcKQwNamf4FsXeeK8AACAD2XVxdjkKTSjF9BLNUyWFZQkAb3CcrTMYtJ6pT85CIABFokJToq
 iEY3Dz3aBEdxwaUPIB4Ikc4j.56D6PXf_6cKQzYiI9OZTRg8fFJjy4jSWL8NVLnr9TNE3BiTEHcV
 Z6nXhyjUwTxAoRLKr599j854SNEk7UwFzQiDDtbkLg7tqjoadfV5xrneZS32UApug2NpPIj6SrKk
 K3NrxuMu_ybWoeqyed.5A4yY0TbnTaau9FhQ5XwkYdFTEwEsjqeQjbOSrCTaEFWYhXj0LW4B01mB
 YAEIg0ZrYa0ujAydeiJlik6WvuHhBT.4._szBSK2gch.vtvlkMPwUbfWq9ewVWDJqv2nm.PTTIkS
 y5Amy7eXiW6v3l3PRBLt3seIrZAhIBIjuTB_r7sqBfqf.DtBkm4DYRZ4EYD.RIRYFObRSjtqmIra
 DYpv_J63T__z8r3YDhATGDMIaeA0M3sakBHILUlg6OkmDou50BbLrwiy_eLmac67TiSHDaHs1B17
 3SSoAaB1_fGgQD_otg2ELHgCY3vIjWwWIauwbTMPwbBq596tKGTZbZ1x13Oatd4YgBbIw3Nr_yyn
 BhstcQpe2Cbuaw8nhTeoBZ81ltSH6yAwd_HI-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Fri, 20 Jan 2023 01:32:42 +0000
Received: by hermes--production-ne1-749986b79f-rhfqw (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a1731533e87b8887676d9129866cea32;
          Fri, 20 Jan 2023 01:32:40 +0000 (UTC)
Message-ID: <5e99e2d6-30a8-ea94-d911-de272a2a0a69@schaufler-ca.com>
Date:   Thu, 19 Jan 2023 17:32:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH bpf-next 2/4] security: Generate a header with the count
 of enabled LSMs
Content-Language: en-US
To:     KP Singh <kpsingh@kernel.org>,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, jackmanb@google.com,
        renauld@google.com, paul@paul-moore.com, song@kernel.org,
        revest@chromium.org, keescook@chromium.org, casey@schaufler-ca.com
References: <20230119231033.1307221-1-kpsingh@kernel.org>
 <20230119231033.1307221-3-kpsingh@kernel.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230119231033.1307221-3-kpsingh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21096 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/19/2023 3:10 PM, KP Singh wrote:
> The header defines a MAX_LSM_COUNT constant which is used in a
> subsequent patch to generate the static calls for each LSM hook which
> are named using preprocessor token pasting. Since token pasting does not
> work with arithmetic expressions, generate a simple lsm_count.h header
> which represents the subset of LSMs that can be enabled on a given
> kernel based on the config.
>
> While one can generate static calls for all the possible LSMs that the
> kernel has, this is actually wasteful as most kernels only enable a
> handful of LSMs.

Why "generate" anything? Why not include your GEN_MAX_LSM_COUNT macro
in security.h and be done with it? I've proposed doing just that in the
stacking patch set for some time. This seems to be much more complicated
than it needs to be.

> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  scripts/Makefile                 |  1 +
>  scripts/security/.gitignore      |  1 +
>  scripts/security/Makefile        |  4 +++
>  scripts/security/gen_lsm_count.c | 57 ++++++++++++++++++++++++++++++++
>  security/Makefile                | 11 ++++++
>  5 files changed, 74 insertions(+)
>  create mode 100644 scripts/security/.gitignore
>  create mode 100644 scripts/security/Makefile
>  create mode 100644 scripts/security/gen_lsm_count.c
>
> diff --git a/scripts/Makefile b/scripts/Makefile
> index 1575af84d557..9712249c0fb3 100644
> --- a/scripts/Makefile
> +++ b/scripts/Makefile
> @@ -41,6 +41,7 @@ targets += module.lds
>  subdir-$(CONFIG_GCC_PLUGINS) += gcc-plugins
>  subdir-$(CONFIG_MODVERSIONS) += genksyms
>  subdir-$(CONFIG_SECURITY_SELINUX) += selinux
> +subdir-$(CONFIG_SECURITY) += security
>  
>  # Let clean descend into subdirs
>  subdir-	+= basic dtc gdb kconfig mod
> diff --git a/scripts/security/.gitignore b/scripts/security/.gitignore
> new file mode 100644
> index 000000000000..684af16735f1
> --- /dev/null
> +++ b/scripts/security/.gitignore
> @@ -0,0 +1 @@
> +gen_lsm_count
> diff --git a/scripts/security/Makefile b/scripts/security/Makefile
> new file mode 100644
> index 000000000000..05f7e4109052
> --- /dev/null
> +++ b/scripts/security/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +hostprogs-always-y += gen_lsm_count
> +HOST_EXTRACFLAGS += \
> +	-I$(srctree)/include/uapi -I$(srctree)/include
> diff --git a/scripts/security/gen_lsm_count.c b/scripts/security/gen_lsm_count.c
> new file mode 100644
> index 000000000000..a9a227724d84
> --- /dev/null
> +++ b/scripts/security/gen_lsm_count.c
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/* NOTE: we really do want to use the kernel headers here */
> +#define __EXPORTED_HEADERS__
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <errno.h>
> +#include <ctype.h>
> +
> +#include <linux/kconfig.h>
> +
> +#define GEN_MAX_LSM_COUNT (				\
> +	/* Capabilities */				\
> +	IS_ENABLED(CONFIG_SECURITY) +			\
> +	IS_ENABLED(CONFIG_SECURITY_SELINUX) +		\
> +	IS_ENABLED(CONFIG_SECURITY_SMACK) +		\
> +	IS_ENABLED(CONFIG_SECURITY_TOMOYO) +		\
> +	IS_ENABLED(CONFIG_SECURITY_APPARMOR) +		\
> +	IS_ENABLED(CONFIG_SECURITY_YAMA) +		\
> +	IS_ENABLED(CONFIG_SECURITY_LOADPIN) +		\
> +	IS_ENABLED(CONFIG_SECURITY_SAFESETID) +		\
> +	IS_ENABLED(CONFIG_SECURITY_LOCKDOWN_LSM) + 	\
> +	IS_ENABLED(CONFIG_BPF_LSM) + \
> +	IS_ENABLED(CONFIG_SECURITY_LANDLOCK))
> +
> +const char *progname;
> +
> +static void usage(void)
> +{
> +	printf("usage: %s lsm_count.h\n", progname);
> +	exit(1);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	FILE *fout;
> +
> +	progname = argv[0];
> +
> +	if (argc < 2)
> +		usage();
> +
> +	fout = fopen(argv[1], "w");
> +	if (!fout) {
> +		fprintf(stderr, "Could not open %s for writing:  %s\n",
> +			argv[1], strerror(errno));
> +		exit(2);
> +	}
> +
> +	fprintf(fout, "#ifndef _LSM_COUNT_H_\n#define _LSM_COUNT_H_\n\n");
> +	fprintf(fout, "\n#define MAX_LSM_COUNT %d\n", GEN_MAX_LSM_COUNT);
> +	fprintf(fout, "#endif /* _LSM_COUNT_H_ */\n");
> +	exit(0);
> +}
> diff --git a/security/Makefile b/security/Makefile
> index 18121f8f85cd..7a47174831f4 100644
> --- a/security/Makefile
> +++ b/security/Makefile
> @@ -3,6 +3,7 @@
>  # Makefile for the kernel security code
>  #
>  
> +gen := include/generated
>  obj-$(CONFIG_KEYS)			+= keys/
>  
>  # always enable default capabilities
> @@ -27,3 +28,13 @@ obj-$(CONFIG_SECURITY_LANDLOCK)		+= landlock/
>  
>  # Object integrity file lists
>  obj-$(CONFIG_INTEGRITY)			+= integrity/
> +
> +$(addprefix $(obj)/,$(obj-y)): $(gen)/lsm_count.h
> +
> +quiet_cmd_lsm_count = GEN     ${gen}/lsm_count.h
> +      cmd_lsm_count = scripts/security/gen_lsm_count ${gen}/lsm_count.h
> +
> +targets += lsm_count.h
> +
> +${gen}/lsm_count.h: FORCE
> +	$(call if_changed,lsm_count)
