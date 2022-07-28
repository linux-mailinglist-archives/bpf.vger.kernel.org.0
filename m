Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF8E5839C0
	for <lists+bpf@lfdr.de>; Thu, 28 Jul 2022 09:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbiG1HqV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 28 Jul 2022 03:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbiG1HqT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jul 2022 03:46:19 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8D954AC0
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 00:46:18 -0700 (PDT)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LtjJW3Jbnz67N96;
        Thu, 28 Jul 2022 15:41:31 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Jul 2022 09:46:15 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2375.024;
 Thu, 28 Jul 2022 09:46:15 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: RE: [PATCH bpf-next v1 1/2] bpf: Add support for per-parameter
 trusted args
Thread-Topic: [PATCH bpf-next v1 1/2] bpf: Add support for per-parameter
 trusted args
Thread-Index: AQHYoZEjMBI1olYJVEOQ/pvQfthTZq2TaAQA
Date:   Thu, 28 Jul 2022 07:46:15 +0000
Message-ID: <fd75bc5ed2564f558000284c44c89632@huawei.com>
References: <20220727081559.24571-1-memxor@gmail.com>
 <20220727081559.24571-2-memxor@gmail.com>
In-Reply-To: <20220727081559.24571-2-memxor@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.81.203.37]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> From: Kumar Kartikeya Dwivedi [mailto:memxor@gmail.com]
> Sent: Wednesday, July 27, 2022 10:16 AM
> Similar to how we detect mem, size pairs in kfunc, teach verifier to
> treat __ref suffix on argument name to imply that it must be a trusted
> arg when passed to kfunc, similar to the effect of KF_TRUSTED_ARGS flag
> but limited to the specific parameter. This is required to ensure that
> kfunc that operate on some object only work on acquired pointers and not
> normal PTR_TO_BTF_ID with same type which can be obtained by pointer
> walking. Release functions need not specify such suffix on release
> arguments as they are already expected to receive one referenced
> argument.

Thanks, Kumar. I will try it.

Roberto

> Cc: Roberto Sassu <roberto.sassu@huawei.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  Documentation/bpf/kfuncs.rst | 18 +++++++++++++++++
>  kernel/bpf/btf.c             | 39 ++++++++++++++++++++++++------------
>  net/bpf/test_run.c           |  9 +++++++--
>  3 files changed, 51 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index c0b7dae6dbf5..41dff6337446 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
> @@ -72,6 +72,24 @@ argument as its size. By default, without __sz annotation,
> the size of the type
>  of the pointer is used. Without __sz annotation, a kfunc cannot accept a void
>  pointer.
> 
> +2.2.2 __ref Annotation
> +----------------------
> +
> +This annotation is used to indicate that the argument is trusted, i.e. it will
> +be a pointer from an acquire function (defined later), and its offset will be
> +zero. This annotation has the same effect as the KF_TRUSTED_ARGS kfunc flag
> but
> +only on the parameter it is applied to. An example is shown below::
> +
> +        void bpf_task_send_signal(struct task_struct *task__ref, int signal)
> +        {
> +        ...
> +        }
> +
> +Here, bpf_task_send_signal will only act on trusted task_struct pointers, and
> +cannot be used on pointers obtained using pointer walking. This ensures that
> +caller always calls this kfunc on a task whose lifetime is guaranteed for the
> +duration of the call.
> +
>  .. _BPF_kfunc_nodef:
> 
>  2.3 Using an existing kernel function
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 7ac971ea98d1..3ce9b2deef9c 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6141,18 +6141,13 @@ static bool __btf_type_is_scalar_struct(struct
> bpf_verifier_log *log,
>  	return true;
>  }
> 
> -static bool is_kfunc_arg_mem_size(const struct btf *btf,
> -				  const struct btf_param *arg,
> -				  const struct bpf_reg_state *reg)
> +static bool btf_param_match_suffix(const struct btf *btf,
> +				   const struct btf_param *arg,
> +				   const char *suffix)
>  {
> -	int len, sfx_len = sizeof("__sz") - 1;
> -	const struct btf_type *t;
> +	int len, sfx_len = strlen(suffix);
>  	const char *param_name;
> 
> -	t = btf_type_skip_modifiers(btf, arg->type, NULL);
> -	if (!btf_type_is_scalar(t) || reg->type != SCALAR_VALUE)
> -		return false;
> -
>  	/* In the future, this can be ported to use BTF tagging */
>  	param_name = btf_name_by_offset(btf, arg->name_off);
>  	if (str_is_empty(param_name))
> @@ -6161,10 +6156,26 @@ static bool is_kfunc_arg_mem_size(const struct btf
> *btf,
>  	if (len < sfx_len)
>  		return false;
>  	param_name += len - sfx_len;
> -	if (strncmp(param_name, "__sz", sfx_len))
> +	return !strncmp(param_name, suffix, sfx_len);
> +}
> +
> +static bool is_kfunc_arg_ref(const struct btf *btf,
> +			     const struct btf_param *arg)
> +{
> +	return btf_param_match_suffix(btf, arg, "__ref");
> +}
> +
> +static bool is_kfunc_arg_mem_size(const struct btf *btf,
> +				  const struct btf_param *arg,
> +				  const struct bpf_reg_state *reg)
> +{
> +	const struct btf_type *t;
> +
> +	t = btf_type_skip_modifiers(btf, arg->type, NULL);
> +	if (!btf_type_is_scalar(t) || reg->type != SCALAR_VALUE)
>  		return false;
> 
> -	return true;
> +	return btf_param_match_suffix(btf, arg, "__sz");
>  }
> 
>  static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> @@ -6174,7 +6185,7 @@ static int btf_check_func_arg_match(struct
> bpf_verifier_env *env,
>  				    u32 kfunc_flags)
>  {
>  	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
> -	bool rel = false, kptr_get = false, trusted_arg = false;
> +	bool rel = false, kptr_get = false, kf_trusted_args = false;
>  	struct bpf_verifier_log *log = &env->log;
>  	u32 i, nargs, ref_id, ref_obj_id = 0;
>  	bool is_kfunc = btf_is_kernel(btf);
> @@ -6211,7 +6222,7 @@ static int btf_check_func_arg_match(struct
> bpf_verifier_env *env,
>  		/* Only kfunc can be release func */
>  		rel = kfunc_flags & KF_RELEASE;
>  		kptr_get = kfunc_flags & KF_KPTR_GET;
> -		trusted_arg = kfunc_flags & KF_TRUSTED_ARGS;
> +		kf_trusted_args = kfunc_flags & KF_TRUSTED_ARGS;
>  	}
> 
>  	/* check that BTF function arguments match actual types that the
> @@ -6221,6 +6232,7 @@ static int btf_check_func_arg_match(struct
> bpf_verifier_env *env,
>  		enum bpf_arg_type arg_type = ARG_DONTCARE;
>  		u32 regno = i + 1;
>  		struct bpf_reg_state *reg = &regs[regno];
> +		bool trusted_arg = false;
> 
>  		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
>  		if (btf_type_is_scalar(t)) {
> @@ -6239,6 +6251,7 @@ static int btf_check_func_arg_match(struct
> bpf_verifier_env *env,
>  		/* Check if argument must be a referenced pointer, args + i has
>  		 * been verified to be a pointer (after skipping modifiers).
>  		 */
> +		trusted_arg = kf_trusted_args || is_kfunc_arg_ref(btf, args + i);
>  		if (is_kfunc && trusted_arg && !reg->ref_obj_id) {
>  			bpf_log(log, "R%d must be referenced\n", regno);
>  			return -EINVAL;
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index cbc9cd5058cb..247bfe52e585 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -691,7 +691,11 @@ noinline void bpf_kfunc_call_test_mem_len_fail2(u64
> *mem, int len)
>  {
>  }
> 
> -noinline void bpf_kfunc_call_test_ref(struct prog_test_ref_kfunc *p)
> +noinline void bpf_kfunc_call_test_trusted(struct prog_test_ref_kfunc *p)
> +{
> +}
> +
> +noinline void bpf_kfunc_call_test_ref(struct prog_test_ref_kfunc *p__ref)
>  {
>  }
> 
> @@ -718,7 +722,8 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail3)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_pass1)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail1)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail2)
> -BTF_ID_FLAGS(func, bpf_kfunc_call_test_ref, KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_kfunc_call_test_trusted, KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_kfunc_call_test_ref)
>  BTF_SET8_END(test_sk_check_kfunc_ids)
> 
>  static void *bpf_test_init(const union bpf_attr *kattr, u32 user_size,
> --
> 2.34.1

