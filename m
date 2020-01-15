Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D166013CB01
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2020 18:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgAOR3b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jan 2020 12:29:31 -0500
Received: from USFB19PA34.eemsg.mail.mil ([214.24.26.197]:3817 "EHLO
        USFB19PA34.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgAOR3a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jan 2020 12:29:30 -0500
X-EEMSG-check-017: 44953522|USFB19PA34_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,323,1574121600"; 
   d="scan'208";a="44953522"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA34.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 15 Jan 2020 17:29:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579109369; x=1610645369;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Jk+Kfbr+0xRlb22n1RNuNfeIYJyPIruB9ZGTtBdVio4=;
  b=gCV8d+IVVXaeD7XLTEpTOvNdhF7Ca1RrqGk2nNOKZXa7BFEoqPYlSc8P
   FXP4SpNwn5saXgiCIANjDdQC5w/FXPsIq2WqytCKs0zc9x0Wu9idhHnjx
   Ogou900neOyhfuzRhbKbAkBgkTyhu/g3A9zbpUwfN9tU5YFbM3vtwg3pT
   akZ5QNwHmKk1LglIxgIcPMTC2JsLDbjPs2evohSGjsQbr1EKCh3eC8yvL
   3giluZ3c1ujeYY24MU1Npm94AHRZnNHeSODpZyN6xpDAKKGXWw5/duefe
   zq5OJi7dd2RruYfj/vkk9DtQpSXz122I28WKhgnMxScs3k8q2ECxm/ZXc
   Q==;
X-IronPort-AV: E=Sophos;i="5.70,323,1574121600"; 
   d="scan'208";a="31989775"
IronPort-PHdr: =?us-ascii?q?9a23=3AvS3D8hzGhb0aQcrXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd0e8RKfad9pjvdHbS+e9qxAeQG9mCt7Qc0KGH4uigATVGvc/a9ihaMdRlbF?=
 =?us-ascii?q?wssY0uhQsuAcqIWwXQDcXBSGgEJvlET0Jv5HqhMEJYS47UblzWpWCuv3ZJQk?=
 =?us-ascii?q?2sfQV6Kf7oFYHMks+5y/69+4HJYwVPmTGxfa5+IA+5oAnMucQam5duJ6g+xh?=
 =?us-ascii?q?bNpnZDZuBayX91KV6JkBvw+8m98IR//yhMvv4q6tJNX7j9c6kkV7JTES4oM3?=
 =?us-ascii?q?oy5M3ltBnDSRWA634BWWgIkRRGHhbI4gjiUpj+riX1uOx92DKHPcLtVrA7RS?=
 =?us-ascii?q?6i76ZwRxD2jioMKiM0/3vWisx0i6JbvQ6hqhliyIPafI2ZKPxzdb7GcNgEWW?=
 =?us-ascii?q?ROQNpeVy1ZAoO9cYQPCfYBPf1FpIX5vlcCsAeyCRWpCO7pxDBInHv21rAk3e?=
 =?us-ascii?q?onHw/NwQgsE8sQvHnQqdn4MroZX+Kow6nS1TjNcu1Y2Tn95obLfB4ur/6DUr?=
 =?us-ascii?q?BsfsTe0kQvCwHIg0+MpYD5MT6Y1OIAuHWb4ep6UuKvjnYqpRxtojex3scsip?=
 =?us-ascii?q?fGhoQIwV7Z8CV22oI1JdmmR097fNWpF4BQuDyBN4ZtXsMjQ31nuCY9yrEcv5?=
 =?us-ascii?q?67ZzIFxI4oxx7YdfyKao6F6Q/tWuaWJDd3nnNleLSnihax70eg0Ov8Wdew0F?=
 =?us-ascii?q?pQqSpFiNbMu3YQ3BLQ8siKUuZx80iu1DqV1w3f9/tILV47mKbFMZIt37g9nY?=
 =?us-ascii?q?cJv0vZBC/5gkD2gbeTdkUj5+en9fzqYq7jpp+AL490jRz+Mrg2lsy/H+s4Ng?=
 =?us-ascii?q?8OUnCH+eumzr3j/FD5QK5Qgv03lKnZvpfaJd8FqaGlGQNVzoYi5Aq/Dzehyt?=
 =?us-ascii?q?gYm2UILElZdx6diojpOlXOLOj5Dfe5nVusjC9my+3JM7DuGJnALmXPnK3/cb?=
 =?us-ascii?q?ty9UJQ0hc/wcha551OC7EBJPzzWlX2tNzdFhI5KBG7w/38BdVh1oIRRWKPAq?=
 =?us-ascii?q?iDPKPUql+H/PgjI+aLZI8LoDr9MeQq5+byjX8lnl8QZaqp3YMMaHC5GPRmLE?=
 =?us-ascii?q?WZbGHwjdcBC2cKuQ8+TO33iF2HSzJTYGyyX60k7DEhFI2mFZvDRpyqgLGZ2C?=
 =?us-ascii?q?e7H5tWZn1JC1yVEnfnaZ+EW/ESZyKWOcJhjDMEWqa7S4M71hGhqhX6y7x5Ie?=
 =?us-ascii?q?rQ4CEYsojj1Ndt7e3JiR4y7SB0D9ia02yVVG50hm0ISiQo3KBwv0N90E2P0a?=
 =?us-ascii?q?tmjPxCE9xc+fdJXh09NZ7GwOxwE8ryVR7ZfteVVFamRc2rATUwTtI33t8PbF?=
 =?us-ascii?q?9xG868gR/fwiqqGb4Vl6CLBZAt96Lc2GX+J9t5y3nYz6QhkVYmTdVVNWG8ha?=
 =?us-ascii?q?5w6RLTB4jXnEWdjaqqcr4c3CHV/meZ0WWOpF1YUBJ3UajdR38ffVfWoM/65k?=
 =?us-ascii?q?zcVb+uD6ooMg9bxc6FMKtKZcXjjU9aS/f7JNTef2Wxln+tChmSwLOMbZTle2?=
 =?us-ascii?q?EG0SXcD0gEnB4c8mycNQclASegrHjSDDpwGlLze0ns6/VxqGunTk8oyAGHd0?=
 =?us-ascii?q?9h17+y+h4Pn/ycSugT06kCuCg7rjV7Ale908jRC9qaqAprZL9cbs8l4FdbyW?=
 =?us-ascii?q?LZsBRwPp++IK98nV4RbwN3v0Tt1xhsFopAkdIqrHQvzApzNKKY1UlNdzSC3Z?=
 =?us-ascii?q?D/IrfXMHX9/Aiza67K3VHTyMqW+qcA6PsisVXjugCpGVQ5/np709lVyXyc5p?=
 =?us-ascii?q?DLDAoPVJL9SEE39wJ1p7vCeCky+5vU1WFwMamzqjLC3tIpC/Ehyhm8ZddfN6?=
 =?us-ascii?q?2FGRT9E80dAMiuJ+gqlEazYh0YO+BS8bY+P9m6ePuexK6rIOFgkSq+jWRF/I?=
 =?us-ascii?q?BwyU2M9y17Su7H25YK3euU0ReAVzf5lF2hqNz4mZhYZTEOGWqy0TPrBJRPaa?=
 =?us-ascii?q?10YIkEE2GuL9eqydlkiJ7tQWBX9FGsB14d18+pfACdb1353QFKyUsXpnmnkz?=
 =?us-ascii?q?OizzNoizEpsraf3CvWzuTgbhUHPGhLRGl5gFfjJoi0iN8aXEy2YAQziBSl4k?=
 =?us-ascii?q?P6zbBBpKtjN2nTXVtIfy/uImFnUKuwubqPbspU5ZMntiVXV+u8YVSERbLnvx?=
 =?us-ascii?q?Qa1CbjFXNExD8nbzGqpon5nxtihW2BLHZztnvZedpsxRfe/tPcQ+Vc0SEcRC?=
 =?us-ascii?q?ZilDnXAEazP8Oz8dWVkJfJqvq+WH65Vp1PbSnrypuNtC665WJ2GhCwgvGzmt?=
 =?us-ascii?q?LmEQg51i/0ysNmVSPWoxbgeoPrzbi1Mfp7fkl0A1/x89B6FZ9gkoQun5EQxW?=
 =?us-ascii?q?MXiYmV/XodlmfzNNRb2b/7bHYXQj4L2dHV6hD/2EJ/NnKJ2575VnKFz8tjfd?=
 =?us-ascii?q?a1fmAW2icn4MBME6iZ96BLnStvolq/qALRYOV9njIHxfsp8n4ajPkDuBAxwS?=
 =?us-ascii?q?WFHrASAU5YMDTvlxuS4dCxtqRXaX2hcberzkZxgdehDLSaqAFGRHn5YosiHT?=
 =?us-ascii?q?N37shnK1LM13vz6o7geNnRcNIcrQeUnA3ej+hULpIxmeEHhSR8Nm7noXIlzO?=
 =?us-ascii?q?s7hwR03Z6mpIiHN3lt/KWhDx9YNj31fNge+j/2gqpEgsmW2IWvFI17GjoXRJ?=
 =?us-ascii?q?voUe6oEDUKuPT8KQmOCjI8pWmAFLrfBwCf7ENmrnLJE5yxK36XI3wZx814RB?=
 =?us-ascii?q?aBPExfnBwUXDIik548Cg+qxNLucEdj6T8K4VL4sQFDyudzNxniVGffqxylaj?=
 =?us-ascii?q?QqR5iFKhpZ8AVC613SMcyE4eJ5BztY8YG5rAyRNmybYBxFAnwTVUyaGV/jO6?=
 =?us-ascii?q?Kj6sTa/OiGGOW+Kv/OYbKAqexCTfuIw4yg0pd+9TaWKsqPJmViD+E82kdbUn?=
 =?us-ascii?q?B5AdrWmzoMSywXjC/Na8+bpBGh+ix4oMC/9+nrWATy6oSVF7tSMNJv+xasja?=
 =?us-ascii?q?eELe6Qiz5zKSxE2ZMU2X/I1L8f0UYUiyFvazatFrAAujTWTK7KlK9YEQQbaz?=
 =?us-ascii?q?ltO8ZT6qI83xVCOdTcitzp1r54j+Y1B01ZWlzmn8GjfdYKLH2lNFPbGEaLM6?=
 =?us-ascii?q?yLJSbWzMH5eq68RrpQjOJbtx20pzmXCVPsPjOGlzPxTRCgLflMjD2HPBxZoI?=
 =?us-ascii?q?y9awttBnblTNL6ax27NsV7jTgxwb0ygHPFK3IcPCN6c0xTsr2Q9yRYgvN4G2?=
 =?us-ascii?q?xE8HVpN/WLmyGc7+PAMJYZreNrAjhol+Jd+Hk60aZa7CdeS/FulivdtcRirE?=
 =?us-ascii?q?2hkumK0jBnSgZBqi5XhIKXukVvIafZ9p5eVnvf8hMC92OQBAkQq9tjFNLvp7?=
 =?us-ascii?q?pcyt7OlfG7FDAX0OqcxsoaCMicfMGfK3snPhrBEz7OCw4EUDvtMnvQ0QgVlP?=
 =?us-ascii?q?CU623QrZUgrJXosIQBR6UdV1EvEP4eTEN/E5hKKo95di0rnKTdj8MS43e66h?=
 =?us-ascii?q?7LS4ESupHBS+LXGvjkNSyYkagBYhwE3Lf1BZocO5e92EF4bFR+2oPQFBn+R9?=
 =?us-ascii?q?dI9xZ9Yxc0rUMFy313Smk+ygqxcQ+2yGMCHv6z2Bgtg01xZvp7p2Sk2Es+Ol?=
 =?us-ascii?q?ef/Hh4q0I2g9iwxGnLITM=3D?=
X-IPAS-Result: =?us-ascii?q?A2BHAQAXSx9e/wHyM5BkGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBe4F9gRhUASASKoQPiQOGXgaBN4lukHIDVAkBAQEBAQEBAQEtCgEBhEACg?=
 =?us-ascii?q?iM4EwIQAQEBBAEBAQEBBQMBAWyFNwyCOykBgnkBAQEBAyMEEUEQCxUDAgImA?=
 =?us-ascii?q?gJXBgEMBgIBAYJjPwGCViUPpiR1fzOENQGBFINKgTgGgQ4oiU+CY3mBB4ERJ?=
 =?us-ascii?q?w+CXT6CS4UOgl4EkBGHGUaXVIJCgkmEdI5tBhuabo5ciF2UNCI3gSErCAIYC?=
 =?us-ascii?q?CEPO4JsEgE9GA2IDReIZIVdIwMwAgEBAY1bAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 15 Jan 2020 17:29:26 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00FHSbTP160596;
        Wed, 15 Jan 2020 12:28:39 -0500
Subject: Re: [PATCH bpf-next v2 04/10] bpf: lsm: Add mutable hooks list for
 the BPF LSM
To:     KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
References: <20200115171333.28811-1-kpsingh@chromium.org>
 <20200115171333.28811-5-kpsingh@chromium.org>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <cd1d9d9f-1b68-8d2c-118a-334e4c71eb57@tycho.nsa.gov>
Date:   Wed, 15 Jan 2020 12:30:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200115171333.28811-5-kpsingh@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/15/20 12:13 PM, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> - The list of hooks registered by an LSM is currently immutable as they
>    are declared with __lsm_ro_after_init and they are attached to a
>    security_hook_heads struct.
> - For the BPF LSM we need to de/register the hooks at runtime. Making
>    the existing security_hook_heads mutable broadens an
>    attack vector, so a separate security_hook_heads is added for only
>    those that ~must~ be mutable.
> - These mutable hooks are run only after all the static hooks have
>    successfully executed.
> 
> This is based on the ideas discussed in:
> 
>    https://lore.kernel.org/lkml/20180408065916.GA2832@ircssh-2.c.rugged-nimbus-611.internal
> 
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
[...]
> diff --git a/security/security.c b/security/security.c
> index cd2d18d2d279..4a2eb4c089b2 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -652,20 +653,21 @@ static void __init lsm_early_task(struct task_struct *task)
>   								\
>   		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) \
>   			P->hook.FUNC(__VA_ARGS__);		\
> +		CALL_BPF_LSM_VOID_HOOKS(FUNC, __VA_ARGS__);	\
>   	} while (0)
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
>   		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
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
> +		RC = CALL_BPF_LSM_INT_HOOKS(RC, FUNC, __VA_ARGS__);	\

Let's not clobber the return code from the other LSMs with the bpf one.

> +	} while (0);							\
> +	RC;								\
>   })
>   
>   /* Security operations */
> 

