Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8C217958F
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 17:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387969AbgCDQnm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Mar 2020 11:43:42 -0500
Received: from sonic305-27.consmr.mail.ne1.yahoo.com ([66.163.185.153]:44069
        "EHLO sonic305-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388019AbgCDQnm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 4 Mar 2020 11:43:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1583340220; bh=pF8i3jQaBWYW0YSqWSIJCOBBZOg8hm9R3c40ED3EfUY=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=jn1INvtjhx/6Klddo6IRhJHCa+9Yq8vxcAFrDPKiwfvRdSrWt9PB23xyDj3FZ95SVkq7pMkzweffdix+nkzVVkuLC2ozsfpU03cM6Dkgv94RS7pCmmyK6zAlFtbARPdzuXESIR5M+sfblPC1InqJYdZ+hjiut0/Jow+y15gCHeJDznIc3n6ILfvPNRHLjpwstn9qQP950FAfg6xmUEuqM2ed2ndQrf9GsPCT2LZKOr8Ns6+RMhjGzeFLf1XwiDB8CVcZWeaALRlz8ZwLWWIcDrhEqXXKCg7uyugSEDCJX/Uu81ke7kRU5IAFVLB92SZZExIm+iYf81qIE1ACJxeR9w==
X-YMail-OSG: TPOFwEAVM1nQAtbrfj4cYBlDmImPXELIvy53tsXWE.VpuhYdt4uIbl9whySuXrD
 Vw9aksTL2_zsqyJ4XMj3W2Yjay5_LQ8P5ZZpF8wVW4la0hORaPSoIiNwFHd__hoSkJApAr3XmIFH
 CG7pIb7emEvVvNDbpL9ReFcyATkos61esyWAb0LfvP67bSkK8m7coaPv1lSqSlZ.JLcfX8Kx6Q.c
 P5HDkzEYgm6NkQ1upwWUEnWCgwmOE5MSify843FYvIw48NTPI4tSzNgV6YK1siMv1QEP9u7LdQtM
 KggWaT3AI2GpBDj2mjaxoFbLnIzesko0c2ST4dfV52jVoCL_P8A72XDTorn_OUp5sZyQLTEkWiD0
 K9SsZVYBFCwEZ_.6FeeP7UMJh6HzpSmAoL4QlseX6NZ.uRXmioIN3L4xIe4k_smSm7UPAseQs__W
 fq_kkp0j1jYBoGwTJSeEiTIpKyCKKYXO.hzr45Tw6_IEDpgasXEPTtHBAdc0O5AMpLKHt8BFsEjB
 OWkebkZV4uIZourIfRaOH4XL4bj3EvkwPHTS3jd5NRMmdl6NwhyHHPwYWzgpQvsk5PXNxbMFvLGg
 KqrUjc4jEnhmuNkcu5Di2uf8npjh4ieEXpIWjgxVjq5V8OtkcE3j0nMRgcnzbATmCJE4IyaflJ5v
 rbOhf0svGGOXyT3zJ0850FOGf9AdlETWqPV85QpklBKCczwZ9CdFkO7wqGuM0gTeozazwVoxmAPG
 jOcDT60GYs4SURZxQoBlw6MdzHVXidInxTQ7WdLgBOUDs8s8PieKtBwjR7LFXwUssehjwRTUv_8K
 2TywW2lMYKb1X_VEtVvxJYrGiQMoQx3jPhUzUT0_GgGMfSrnpgrSmIlDbyFueae8r25WjDW0MAdE
 jvHuuIzpji1xT3EH7uxCjisF4jBJ51LCT6FrrcNXNPic2E7rRf0Owa2lFqpxKbCGjW1vsyBre_i2
 GcBY7P3FqWULcQXcgkERWhRVYt5PFn6YJ65mNSAKIJShFaPlHIUMK_5pQuLjT4YwnuWlEooOyPEC
 RLLjqa6tEJcv4zYX7uHUknLe5qWo.rt4dlS1feDCqAvPqUekGFs1dAZRDbc8TsFJqPT5lbYzF6T_
 aWhFck6769VyiqlH3b9RK0aI6gufLP.XPlhvsmb5XTb_ZrL2hv8hgCZMEG6Pi.9E0t3q7rAk6MWR
 hndCUvRT_xONVF2u.WQZ57WKv6o2JM2v_Jm3dF25kMrCC7dY.2j3Jueyxu8797mMR6a5u4mvwUP0
 h42XzUOMGBskS3ebrZqYRX5O9dxCd421s3dMEf4ROn8Q8ZWmYchrHgkHD6ZZqioEfeZvY27vVPS5
 KiraA47RPUFAOCBUUYg5JsI75gFPtj_Wuqf.GtNUF2SSViLqUhrNsEkBhAVkekWuvRoFjxodU2LB
 WkIsCgSDBKUHQZTJq91mZsrv0h91O
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Wed, 4 Mar 2020 16:43:40 +0000
Received: by smtp402.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID fae7d59caaea2c03bfc0d7411cba6386;
          Wed, 04 Mar 2020 16:43:36 +0000 (UTC)
Subject: Re: [PATCH bpf-next v3 4/7] bpf: Attachment verification for
 BPF_MODIFY_RETURN
To:     KP Singh <kpsingh@chromium.org>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
References: <20200304154747.23506-1-kpsingh@chromium.org>
 <20200304154747.23506-5-kpsingh@chromium.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <cf599ab4-c291-56bc-4ec2-958387d9930e@schaufler-ca.com>
Date:   Wed, 4 Mar 2020 08:43:35 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200304154747.23506-5-kpsingh@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.15302 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_241)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/4/2020 7:47 AM, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
>
> - Allow BPF_MODIFY_RETURN attachment only to functions that are:
>
>     * Whitelisted for error injection by checking
>       within_error_injection_list. Similar discussions happened for the
>       bpf_override_return helper.
>
>     * security hooks, this is expected to be cleaned up with the LSM
>       changes after the KRSI patches introduce the LSM_HOOK macro:
>
>         https://lore.kernel.org/bpf/20200220175250.10795-1-kpsingh@chromium.org/

Be careful with this forward reference. Changes suggested to LSM_HOOK
macros remain contentious.

>
> - The attachment is currently limited to functions that return an int.
>   This can be extended later other types (e.g. PTR).
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> Acked-by: Andrii Nakryiko <andriin@fb.com>
> ---
>  kernel/bpf/btf.c      | 28 ++++++++++++++++++++--------
>  kernel/bpf/verifier.c | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 51 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 30841fb8b3c0..50080add2ab9 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -3710,14 +3710,26 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
>  		nr_args--;
>  	}
>  
> -	if ((prog->expected_attach_type == BPF_TRACE_FEXIT ||
> -	     prog->expected_attach_type == BPF_MODIFY_RETURN) &&
> -	    arg == nr_args) {
> -		if (!t)
> -			/* Default prog with 5 args. 6th arg is retval. */
> -			return true;
> -		/* function return type */
> -		t = btf_type_by_id(btf, t->type);
> +	if (arg == nr_args) {
> +		if (prog->expected_attach_type == BPF_TRACE_FEXIT) {
> +			if (!t)
> +				return true;
> +			t = btf_type_by_id(btf, t->type);
> +		} else if (prog->expected_attach_type == BPF_MODIFY_RETURN) {
> +			/* For now the BPF_MODIFY_RETURN can only be attached to
> +			 * functions that return an int.
> +			 */
> +			if (!t)
> +				return false;
> +
> +			t = btf_type_skip_modifiers(btf, t->type, NULL);
> +			if (!btf_type_is_int(t)) {
> +				bpf_log(log,
> +					"ret type %s not allowed for fmod_ret\n",
> +					btf_kind_str[BTF_INFO_KIND(t->info)]);
> +				return false;
> +			}
> +		}
>  	} else if (arg >= nr_args) {
>  		bpf_log(log, "func '%s' doesn't have %d-th argument\n",
>  			tname, arg + 1);
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2460c8e6b5be..ae32517d4ccd 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19,6 +19,7 @@
>  #include <linux/sort.h>
>  #include <linux/perf_event.h>
>  #include <linux/ctype.h>
> +#include <linux/error-injection.h>
>  
>  #include "disasm.h"
>  
> @@ -9800,6 +9801,33 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
>  
>  	return 0;
>  }
> +#define SECURITY_PREFIX "security_"
> +
> +static int check_attach_modify_return(struct bpf_verifier_env *env)
> +{
> +	struct bpf_prog *prog = env->prog;
> +	unsigned long addr = (unsigned long) prog->aux->trampoline->func.addr;
> +
> +	if (within_error_injection_list(addr))
> +		return 0;
> +
> +	/* This is expected to be cleaned up in the future with the KRSI effort
> +	 * introducing the LSM_HOOK macro for cleaning up lsm_hooks.h.
> +	 */
> +	if (!strncmp(SECURITY_PREFIX, prog->aux->attach_func_name,
> +		     sizeof(SECURITY_PREFIX) - 1)) {
> +
> +		if (!capable(CAP_MAC_ADMIN))
> +			return -EPERM;
> +
> +		return 0;
> +	}
> +
> +	verbose(env, "fmod_ret attach_btf_id %u (%s) is not modifiable\n",
> +		prog->aux->attach_btf_id, prog->aux->attach_func_name);
> +
> +	return -EINVAL;
> +}
>  
>  static int check_attach_btf_id(struct bpf_verifier_env *env)
>  {
> @@ -10000,6 +10028,9 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
>  		}
>  		tr->func.addr = (void *)addr;
>  		prog->aux->trampoline = tr;
> +
> +		if (prog->expected_attach_type == BPF_MODIFY_RETURN)
> +			ret = check_attach_modify_return(env);
>  out:
>  		mutex_unlock(&tr->mutex);
>  		if (ret)
