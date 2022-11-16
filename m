Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DF362C60B
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 18:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbiKPRMp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 12:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbiKPRMn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 12:12:43 -0500
Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C815800E
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 09:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1668618761; bh=usdsZdWfbqFa5v8LKamCUsWAuw6DIW8L3AZ8jIFKDOA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=VcxNjl7ZWqxzWr5op+8L/f31kC8lZMlDCzgW3Eiq7rvg8QwulYsBJlU142RWojlbmhWGJbtUEJxfcJSm/WprCLRd5gWjdMUSO8d7iVd3+Cfk2aWgGEdQOje7fjqADcFHUnHfn5ze6P55vmFwMWXyfSedvPRNDSZkUobPvw2nAsFya2RqcZopLBjtFX4EQY4B8k+LiNJ75LgxQav/guY7BdD4pa83a+M6qm/yIb7B5uBhqA+OmcfyfcPm9o1af3k/w0/hhIW6dS9QpFAteNsmGPnnCnfSqY8NuAUfZUXGX4JEwDemrz4AUos8xNkJoYaEzaSlpz03j2wEU7e1TJka7A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1668618761; bh=eZUTp/zmZldcM4c1nhxm5voSYaqVSoYrqG2ZqIBs1IS=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=dZqjIjfpPg1TukUUNVvVDPM5xHXcg5jcaag/JQKR/KDFdGd8BkHoLUw3nm5YBygvSsWMiWJhV6NeCi8J5qZck4n3cTHoI149gb7DQOCyahzNZaI+YY5UMCW9QHi0lPKx5k5GqxQTMNQL1y6CQDZraVBGojZJU3VuUjPdt31UrgaHRVQDBJyuOLFDGb1wWMlvBw2wfw5zggMstzwEYq8d/UY4oxz05pbYxeVmUIYxBZDUAB5PRyIpbzqEuUdAeY20FYcTiWCNP+8gw/Okw+/73aBxvmeoGlnfB9FyfeOpjFOwEPXvkUssDYPcJzryOxI+znyD/uBzjzbi2NH8f2MMlQ==
X-YMail-OSG: KI.Wg1UVM1kkXd_xRAdkA96ERj475VVyD_ndtPO.2XXkntC2A99iCmi8npZ8LtQ
 HnHxRGNwAibpuoDqgX4UQtqjWkMbjjp3zkeR7Lc.M1J0Dh3ATl3hw3AT8_XWC0oeYG11srdII6g6
 VZ3APehOrAGru9rEfZDhN4mmv1wKmE03.hQTLFR.WRXWcjiBGGOVlwvVLciwE3NWQLHgeGTi5n6d
 KYnMfQdl4Q1uLvkqW_KthbYXuCNQchon5t5at2.MvNCe3ABr10L_44nBW4YZ5AOSo_BUFaxTJHDI
 FfQp5Z5xwh0j5Jqepel9R3LGVv70JQsG8Y_W_JZCrUazKefkC_b6QJUm.F1du7eAjsE8l8JSzu4I
 Axj8aEHuLTgAiT58jG_F4YCVEQICId5gCNSIDoWzypqApaTxZ3wumNljYr5lj5qd2yOCqnFpo5VO
 jiB.zFO_LnfERfQKP3NWbqoN1D7UmVbAme8ko8HanJnnev3uis4F.mom1F_jihnq_DCJ6Iu9XYlv
 BnnY1BrLWuOcGBp7UTupf4B5Pku6vcGjQ8GJm91raKXhxWXu39YxS9yoN2YEj7aC.onrfVvAsFYp
 q_lFbDXKNH_nShhYyDFm.4JLNoIb_Lvjy5gEPve.HgN9_ZPWX60EXXwWqor0g1DiOOF1CEmeMjC4
 ENXQYodWwK9D66yg35WM9KQxO7oMZCNQEk4CUO6qnFqb4nKZvNo4vqKJ6zBhf54HmxTcfN3hhDXr
 kx2u_qm2hF7.y4ZazPAfSLAwT1lXn7a90MtbxCkT9T515uETJM_bCuCyZh8rGAyukj1_9JL3YWGl
 aBu0.DZUo_J5_9GodtoxR2PXSyNcTSWakb9E7XQPtkmf58csx7ZcZpNM03xcEuFEtAvX_APJCmFQ
 q7QvpUro8SXRWDjJ9gK6H81RAHvLDIM6rQmvZXs9.oAwyYQxq38yz3dhCTIl6m1IZ11tIagkkkIT
 P4V0Yf6VE8oFNRYHSG4GBDF3x1nCw0WWTDpx.xDCxqup.A05htMy59Hm12ozLcCac6qarcP.ir64
 KoFh4HymDdMzJaTGtwD1_XDPbdiukQVwijXLh7J380tK.TbD6rSZ9rEiVdK1eWm3tcPpJ.m4roce
 nHxbRfnZSiUXyfgjy8Tnjaha3hshGhDqCOyzwJESs7K62CrOw9p2JJqTiW4BJ1AR1vwL7KntJ8tM
 QtLIfBvev0c3zoqULIAc1yRBf561T0zltjLXu7QYvufYwAsvm8cD0YXWklM7CY_WdeBXpiSFqOyA
 IU5Vm70UrYjdeLesldvy6zNbmdqP0GukkuTv4w12NeU9M1G6TGJ9f7hT5HSKNUgtUg1Gq4vlHqHJ
 SDwJhbOcr3IfzorpMBWP7r_EzNz7BqXpQopzcYmXOoZIHGpHXzE4KnNIw9142D_fXsT9oPmo3h_1
 mEwsM4xxN5hcxMvV4hgrdChCjOd4LoseqR73Y2jSNf6u_1TQ.vZoT6DPBXHWNYuR2g3PHWEk6xz0
 rEC0LXd11QL2ZTOP2P1T0JiPgZuhFXVhgtE8FllJEo.k1UtTfn1ZrCZ8a3ZCFMM9JKbpu2gNOfyQ
 jkh6PRLlHNj_D6TfwfSAjRANSFvmb_FLJV79.Wp28ZtUAvrHSp..4Jtcaydk52Tqmj02wLs2hj3h
 pDf2x4AP59JCOUCm6O.wcvqz2lWIj.8r4C5yUi0fjJAj4dSImGf2tcR368UxNUDTtLcPdrWNHZoB
 l040IYRs7yA7g0vIAzjzPq7B7Z4GDYx3fIgw5Dc8bmakitQZA.KTM3w7AKOdZ8YDhm5IradjmKNa
 Umcf.vnTWtCOUY7DJ07yn1jKMHnQUqGh.aai_ipbZv7HsNQajJ5Im1uoUu8SUlFfQbvGB_FZ7oMi
 w4m3c.mwG017.7ubI2.lo8POINqr1K25eMs4J8JHbQec9G80dmJ4zFby1.rD5XRY8kzdlWl9e_mT
 XHMk_KP5FgnvPMSm7GrYI9IXfKj2gKZLOlE1.Rhzd8uP7BGytY8abVJckrTDmd_sKpCQNyGC3OKg
 CN0NBwsc3UmVZXrB1oSAYf6cS76XJ3nXSFoEDnZx6zEwG.kNtSnJMJKre1iUAGNN81tRDREyxJW3
 kRHtTYgBscqs1V8.w5oU88crfPNzBw_SWv0T3VthJ_kTxYNbRdVdATuCrfOrg0zhLfGEa_WFkeGE
 76VfJfsAcQjkbjrRZfZkO69uWpUBIIKqjy9vciR2UvhlFg4PISncauASy4KAzBsedTINOw58FR.0
 XHFzC2fuxLAEwhbfuCf33pS_lx7j.4etD129J
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Wed, 16 Nov 2022 17:12:41 +0000
Received: by hermes--production-bf1-5878955b5f-7hv65 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 60db94e25ec0d03fcd181327a13408bd;
          Wed, 16 Nov 2022 17:12:38 +0000 (UTC)
Message-ID: <41c6eac1-4e02-3499-5d83-468dd1ca434a@schaufler-ca.com>
Date:   Wed, 16 Nov 2022 09:12:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PoC][PATCH] bpf: Call return value check function in the JITed
 code
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, revest@chromium.org, jackmanb@chromium.org,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc:     bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        casey@schaufler-ca.com
References: <700dffccdfeeb3d19c5385550e4c84f08c705e19.camel@huaweicloud.com>
 <20221116154712.4115929-1-roberto.sassu@huaweicloud.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20221116154712.4115929-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20863 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/16/2022 7:47 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> eBPF allows certain types of eBPF programs to modify the return value of
> the functions they attach to. This is used for example by BPF LSM to let
> security modules make their decision on LSM hooks.
>
> The JITed code looks like the following:
>
>     ret = bpf_lsm_inode_permission_impl1(); // from a security module
>     if (ret)
>         goto out;
>
> ..
>
>     ret = bpf_lsm_inode_permission_implN(); // from a security module
>     if (ret)
>         goto out;
>
>     ret = bpf_lsm_inode_permission(); // in the kernel, returns DEFAULT
> out:
>
> If ret is not zero, the attachment points of BPF LSM are not executed. For
> this reason, the return value check cannot be done there.
>
> Instead, the idea is to use the LSM_HOOK() macro to define a per-hook check
> function.
>
> Whenever an eBPF program attaches to an LSM hook, the eBPF verifier
> resolves the address of the check function (whose name is
> bpf_lsm_<hook name>_ret()) and adds a call to that function just after the
> out label. If the return value is illegal, the check function changes it
> back to the default value defined by the LSM infrastructure:
>
> ..
>
> out:
>     ret = bpf_lsm_inode_permission_ret(ret);

As I've mentioned elsewhere, the return value is a small part of
the problem you have with eBPF programs and the BPF LSM. Because
the LSM infrastructure is inconsistent with regard to return codes,
values returned in pointers and use of secids there is no uniform
mechanism that I can see to address the "legitimate return" problem.

Lets look at one of the ickyest interfaces we have, security_getprocattr().
It returns the size of a string that it has allocated. It puts the
pointer to the allocated buffer into a char **value that was passed to it.
If bpf_getprocattr() returns a positive number and sets value to NULL Bad
Things can happen. If the return value is greater than the size allocated
ditto. If it returns an error but allocates a string you get a memory leak.

security_secid_to_secctx() has to work in concert with security_release_secctx()
to do memory lifecycle management. If secid_to_secctx() allocates memory
release_secctx() has to free it, while if secid_to_secctx() doesn't allocate
memory it better not. (SELinux allocates memory, Smack does not. It's a real
distinction) Your return checker would need to understand a lot more about
the behavior of your eBPF programs than what value they return.

>
> In this way, an eBPF program cannot cause illegal return values to be sent
> to BPF LSM, and to the callers of the LSM infrastructure.
>
> This is just a PoC, to validate the idea and get an early feedback.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  arch/arm64/net/bpf_jit_comp.c |  7 ++++---
>  arch/x86/net/bpf_jit_comp.c   | 17 ++++++++++++++++-
>  include/linux/bpf.h           |  4 +++-
>  kernel/bpf/bpf_lsm.c          | 20 ++++++++++++++++++++
>  kernel/bpf/bpf_struct_ops.c   |  2 +-
>  kernel/bpf/trampoline.c       |  6 ++++--
>  kernel/bpf/verifier.c         | 28 ++++++++++++++++++++++++++--
>  7 files changed, 74 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 62f805f427b7..5412230c6935 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -1764,7 +1764,7 @@ static void restore_args(struct jit_ctx *ctx, int args_off, int nargs)
>   */
>  static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
>  			      struct bpf_tramp_links *tlinks, void *orig_call,
> -			      int nargs, u32 flags)
> +			      void *ret_check_call, int nargs, u32 flags)
>  {
>  	int i;
>  	int stack_size;
> @@ -1963,7 +1963,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
>  int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
>  				void *image_end, const struct btf_func_model *m,
>  				u32 flags, struct bpf_tramp_links *tlinks,
> -				void *orig_call)
> +				void *orig_call, void *ret_check_call)
>  {
>  	int i, ret;
>  	int nargs = m->nr_args;
> @@ -1983,7 +1983,8 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
>  			return -ENOTSUPP;
>  	}
>  
> -	ret = prepare_trampoline(&ctx, im, tlinks, orig_call, nargs, flags);
> +	ret = prepare_trampoline(&ctx, im, tlinks, orig_call, ret_check_call,
> +				 nargs, flags);
>  	if (ret < 0)
>  		return ret;
>  
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index cec5195602bc..6cd727b4af0a 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -2123,7 +2123,7 @@ static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog,
>  int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *image_end,
>  				const struct btf_func_model *m, u32 flags,
>  				struct bpf_tramp_links *tlinks,
> -				void *func_addr)
> +				void *func_addr, void *func_ret_check_addr)
>  {
>  	int ret, i, nr_args = m->nr_args, extra_nregs = 0;
>  	int regs_off, ip_off, args_off, stack_size = nr_args * 8, run_ctx_off;
> @@ -2280,6 +2280,21 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>  		for (i = 0; i < fmod_ret->nr_links; i++)
>  			emit_cond_near_jump(&branches[i], prog, branches[i],
>  					    X86_JNE);
> +
> +		if (func_ret_check_addr) {
> +			emit_ldx(&prog, BPF_DW, BPF_REG_1, BPF_REG_FP, -8);
> +
> +			/* call ret check function */
> +			if (emit_call(&prog, func_ret_check_addr, prog)) {
> +				ret = -EINVAL;
> +				goto cleanup;
> +			}
> +
> +			/* remember return value in a stack for bpf prog to access */
> +			emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
> +			memcpy(prog, x86_nops[5], X86_PATCH_SIZE);
> +			prog += X86_PATCH_SIZE;
> +		}
>  	}
>  
>  	if (fexit->nr_links)
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 49f9d2bec401..f3551f7bdc28 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -919,7 +919,7 @@ struct bpf_tramp_image;
>  int arch_prepare_bpf_trampoline(struct bpf_tramp_image *tr, void *image, void *image_end,
>  				const struct btf_func_model *m, u32 flags,
>  				struct bpf_tramp_links *tlinks,
> -				void *orig_call);
> +				void *orig_call, void *ret_call);
>  u64 notrace __bpf_prog_enter_sleepable_recur(struct bpf_prog *prog,
>  					     struct bpf_tramp_run_ctx *run_ctx);
>  void notrace __bpf_prog_exit_sleepable_recur(struct bpf_prog *prog, u64 start,
> @@ -974,6 +974,7 @@ struct bpf_trampoline {
>  	struct {
>  		struct btf_func_model model;
>  		void *addr;
> +		void *ret_check_addr;
>  		bool ftrace_managed;
>  	} func;
>  	/* if !NULL this is BPF_PROG_TYPE_EXT program that extends another BPF
> @@ -994,6 +995,7 @@ struct bpf_trampoline {
>  struct bpf_attach_target_info {
>  	struct btf_func_model fmodel;
>  	long tgt_addr;
> +	long tgt_ret_check_addr;
>  	const char *tgt_name;
>  	const struct btf_type *tgt_type;
>  };
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index 37bcedf5a44e..f7f25d0064dd 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -18,6 +18,17 @@
>  #include <linux/ima.h>
>  #include <linux/bpf-cgroup.h>
>  
> +static bool is_ret_value_allowed(int ret, u32 ret_flags)
> +{
> +	if ((ret < 0 && !(ret_flags & LSM_RET_NEG)) ||
> +	    (ret == 0 && !(ret_flags & LSM_RET_ZERO)) ||
> +	    (ret == 1 && !(ret_flags & LSM_RET_ONE)) ||
> +	    (ret > 1 && !(ret_flags & LSM_RET_GT_ONE)))
> +		return false;
> +
> +	return true;
> +}
> +
>  /* For every LSM hook that allows attachment of BPF programs, declare a nop
>   * function where a BPF program can be attached.
>   */
> @@ -30,6 +41,15 @@ noinline RET bpf_lsm_##NAME(__VA_ARGS__)	\
>  #include <linux/lsm_hook_defs.h>
>  #undef LSM_HOOK
>  
> +#define LSM_HOOK(RET, DEFAULT, RET_FLAGS, NAME, ...)	\
> +noinline RET bpf_lsm_##NAME##_ret(int ret)	\
> +{						\
> +	return is_ret_value_allowed(ret, RET_FLAGS) ? ret : DEFAULT; \
> +}
> +
> +#include <linux/lsm_hook_defs.h>
> +#undef LSM_HOOK
> +
>  #define LSM_HOOK(RET, DEFAULT, RET_FLAGS, NAME, ...) \
>  	BTF_ID(func, bpf_lsm_##NAME)
>  BTF_SET_START(bpf_lsm_hooks)
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 84b2d9dba79a..22485f0df534 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -346,7 +346,7 @@ int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks,
>  	 */
>  	flags = model->ret_size > 0 ? BPF_TRAMP_F_RET_FENTRY_RET : 0;
>  	return arch_prepare_bpf_trampoline(NULL, image, image_end,
> -					   model, flags, tlinks, NULL);
> +					   model, flags, tlinks, NULL, NULL);
>  }
>  
>  static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index d6395215b849..3c6821b3c08c 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -464,7 +464,8 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
>  
>  	err = arch_prepare_bpf_trampoline(im, im->image, im->image + PAGE_SIZE,
>  					  &tr->func.model, tr->flags, tlinks,
> -					  tr->func.addr);
> +					  tr->func.addr,
> +					  tr->func.ret_check_addr);
>  	if (err < 0)
>  		goto out;
>  
> @@ -802,6 +803,7 @@ struct bpf_trampoline *bpf_trampoline_get(u64 key,
>  
>  	memcpy(&tr->func.model, &tgt_info->fmodel, sizeof(tgt_info->fmodel));
>  	tr->func.addr = (void *)tgt_info->tgt_addr;
> +	tr->func.ret_check_addr = (void *)tgt_info->tgt_ret_check_addr;
>  out:
>  	mutex_unlock(&tr->mutex);
>  	return tr;
> @@ -1055,7 +1057,7 @@ int __weak
>  arch_prepare_bpf_trampoline(struct bpf_tramp_image *tr, void *image, void *image_end,
>  			    const struct btf_func_model *m, u32 flags,
>  			    struct bpf_tramp_links *tlinks,
> -			    void *orig_call)
> +			    void *orig_call, void *ret_check_call)
>  {
>  	return -ENOTSUPP;
>  }
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5e74f460dfd0..1ad0fe5cefe9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14988,12 +14988,13 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  {
>  	bool prog_extension = prog->type == BPF_PROG_TYPE_EXT;
>  	const char prefix[] = "btf_trace_";
> -	int ret = 0, subprog = -1, i;
> +	int ret = 0, subprog = -1, i, tname_len;
>  	const struct btf_type *t;
>  	bool conservative = true;
>  	const char *tname;
> +	char *tname_ret;
>  	struct btf *btf;
> -	long addr = 0;
> +	long addr = 0, ret_check_addr = 0;
>  
>  	if (!btf_id) {
>  		bpf_log(log, "Tracing programs must provide btf_id\n");
> @@ -15168,6 +15169,28 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  					tname);
>  				return -ENOENT;
>  			}
> +
> +			if (prog->expected_attach_type == BPF_LSM_MAC) {
> +				tname_len = strlen(tname);
> +				tname_ret = kmalloc(tname_len + 5, GFP_KERNEL);
> +				if (!tname_ret) {
> +					bpf_log(log,
> +						"Cannot allocate memory for %s_ret string\n",
> +						tname);
> +					return -ENOMEM;
> +				}
> +
> +				snprintf(tname_ret, tname_len + 5, "%s_ret", tname);
> +				ret_check_addr = kallsyms_lookup_name(tname_ret);
> +				kfree(tname_ret);
> +
> +				if (!ret_check_addr) {
> +					bpf_log(log,
> +						"Kernel symbol %s_ret not found\n",
> +						tname);
> +					return -ENOENT;
> +				}
> +			}
>  		}
>  
>  		if (prog->aux->sleepable) {
> @@ -15210,6 +15233,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  		break;
>  	}
>  	tgt_info->tgt_addr = addr;
> +	tgt_info->tgt_ret_check_addr = ret_check_addr;
>  	tgt_info->tgt_name = tname;
>  	tgt_info->tgt_type = t;
>  	return 0;
