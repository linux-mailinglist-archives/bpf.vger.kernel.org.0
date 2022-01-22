Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F8549698E
	for <lists+bpf@lfdr.de>; Sat, 22 Jan 2022 04:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiAVDXo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Jan 2022 22:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiAVDXn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Jan 2022 22:23:43 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70AAC06173B
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 19:23:43 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id d7so10406533plr.12
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 19:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V5fVtG/9hIvd5He72iR0WN5CBw0UqVl2MwRj3ilD3Tg=;
        b=aSUH0WF5pRmnBLS4uAmNPE4E+nuJSTO4sMIa5aa6af1Jmifq6hPnCQtk8NvNmY9n0u
         ZpMOzvdAlvrs1Rp2HbXi8tbTZUI/KfHIgmldaG0nGRf5Ynkibllw7EMfeYw7BZ61GpQj
         Y5gd/sLZA/X5725+dRfPfUC+oHgDAWKUHgm/JzRg0bOJCUVRHgGPFZc0iLY6h0IzrCh+
         TD2jREfAIeKSovIJg+acffpvHNnEOmyzwwCh+ta5pKlqxcNoauOeOI9YhE0Yha3mljh9
         aR198tbUQ91e5ZHSfOG6cXHs0Z2QGpMOUxd2IKW02HCxQbnIA9akVUGw9VHKlJJeXimi
         L4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V5fVtG/9hIvd5He72iR0WN5CBw0UqVl2MwRj3ilD3Tg=;
        b=phVFNW7zRdwe28A+uGnW4LGgjjgeU+166ePujzCwMfBSUxsA02aFHV8xU0TRD8YJw4
         QPdDOG8QLj6Z2DA/uLz5aXbhQqpWis/jzh8ycy/632iRq6WYj4rrVypJTEp9Fu+Kh4hd
         GHI6HQEzNi+AoTQ7TmyKcYEbAOZXRIWOojcoSOU+XMskkpUmD+hNI1ME/MrtyDR/M0Pf
         23nsobgv7fozdGZfP4vQd2BlhfrwZK2xdQPAx7zbz0pFERJNrBWLrVf4aLJhyI9gsA5b
         esClk0cha4GWdA/ny7JBzDJmhvjR18r9SwRc0GCMfZECLtlNl91oy4xrzdxkZSgrmXEW
         jqeA==
X-Gm-Message-State: AOAM531X4HDU8KZ5KgtjUfmW7pWe5DO/qSUJGcucYAcztUy0bZ/rilxU
        2JDIGOz3BvNNznDHq7nu+G5Sl4NM+kNlcA==
X-Google-Smtp-Source: ABdhPJxHG8v83KvhiKh+CiA23uhDypdRTpc+bqmMfurAxVi8tn7Y+amQO8vAI07ownIyXbS0uegZuA==
X-Received: by 2002:a17:902:ceca:b0:14a:3eba:41ed with SMTP id d10-20020a170902ceca00b0014a3eba41edmr6100831plg.118.1642821822821;
        Fri, 21 Jan 2022 19:23:42 -0800 (PST)
Received: from localhost ([2405:201:6014:d064:1fb1:21a:3dae:742c])
        by smtp.gmail.com with ESMTPSA id b12sm8612603pfv.148.2022.01.21.19.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 19:23:42 -0800 (PST)
Date:   Sat, 22 Jan 2022 08:53:39 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Usama Arif <usama.arif@bytedance.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii.nakryiko@gmail.com, fam.zheng@bytedance.com,
        cong.wang@bytedance.com, song@kernel.org
Subject: Re: [RFC bpf-next 1/3] bpf: btf: Introduce infrastructure for module
 helpers
Message-ID: <20220122032053.pb7lk5wvrfg2bo75@thp>
References: <20220121193956.198120-1-usama.arif@bytedance.com>
 <20220121193956.198120-2-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121193956.198120-2-usama.arif@bytedance.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jan 22, 2022 at 01:09:54AM IST, Usama Arif wrote:
> This adds support for calling helper functions in eBPF applications
> that have been declared in a kernel module. The corresponding
> verifier changes for module helpers will be added in a later patch.
>
> Module helpers are useful as:
> - They support more argument and return types when compared to module
> kfunc.
> - This adds a way to have helper functions that would be too specialized
> for a specific usecase to merge upstream, but are functions that can have
> a constant API and can be maintained in-kernel modules.
> - The number of in-kernel helpers have grown to a large number
> (187 at the time of writing this commit). Having module helper functions
> could possibly reduce the number of in-kernel helper functions growing
> in the future and maintained upstream.
>
> When the kernel module registers the helper, the module owner,
> BTF id set of the function and function proto is stored as part of a
> btf_mod_helper entry in a btf_mod_helper_list which is part of
> struct btf. This entry can be removed in the unregister function
> while exiting the module, and can be used by the bpf verifier to
> check the helper call and get function proto.
>
> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> ---
>  include/linux/btf.h | 44 +++++++++++++++++++++++
>  kernel/bpf/btf.c    | 88 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 132 insertions(+)
>
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index b12cfe3b12bb..c3a814404112 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -40,6 +40,18 @@ struct btf_kfunc_id_set {
>  	};
>  };
>
> +struct btf_mod_helper {
> +	struct list_head list;
> +	struct module *owner;
> +	struct btf_id_set *set;
> +	struct bpf_func_proto *func_proto;
> +};
> +
> +struct btf_mod_helper_list {
> +	struct list_head list;
> +	struct mutex mutex;
> +};
> +
>  extern const struct file_operations btf_fops;
>
>  void btf_get(struct btf *btf);
> @@ -359,4 +371,36 @@ static inline int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
>  }
>  #endif
>
> +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> +int register_mod_helper(struct btf_mod_helper *mod_helper);
> +int unregister_mod_helper(struct btf_mod_helper *mod_helper);
> +const struct bpf_func_proto *get_mod_helper_proto(const struct btf *btf,
> +	const u32 kfunc_btf_id);
> +
> +#define DEFINE_MOD_HELPER(mod_helper, owner, helper_func, func_proto) \
> +BTF_SET_START(helper_func##__id_set) \
> +BTF_ID(func, helper_func) \
> +BTF_SET_END(helper_func##__id_set) \
> +struct btf_mod_helper mod_helper = { \
> +	LIST_HEAD_INIT(mod_helper.list), \
> +	(owner), \
> +	(&(helper_func##__id_set)), \
> +	(&(func_proto)) \
> +}

This macro needs to be outside the ifdef, otherwise when
CONFIG_DEBUG_INFO_BTF_MODULES is not set, code will fail to compile.  Also, I
would use static and const on the variable, so that compiler can optimize it out
when the config option is disabled.

> +#else
> +int register_mod_helper(struct btf_mod_helper *mod_helper)
> +{
> +	return -EPERM;
> +}
> +int unregister_mod_helper(struct btf_mod_helper *mod_helper)
> +{
> +	return -EPERM;
> +}
> +const struct bpf_func_proto *get_mod_helper_proto(const struct btf *btf,
> +	const u32 kfunc_btf_id)
> +{
> +	return NULL;
> +}

In the else block, these need to be static inline functions, otherwise you'll
get a warning and link time error because the same symbol will be present in
multiple objects.

> +#endif
> +
>  #endif
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 57f5fd5af2f9..f9aa6ba85f3f 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -228,6 +228,7 @@ struct btf {
>  	u32 id;
>  	struct rcu_head rcu;
>  	struct btf_kfunc_set_tab *kfunc_set_tab;
> +	struct btf_mod_helper_list *mod_helper_list;

What will free this struct when btf goes away? I don't see any cleanup code in
btf_free.

>
>  	/* split BTF support */
>  	struct btf *base_btf;
> @@ -6752,6 +6753,93 @@ int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
>  }
>  EXPORT_SYMBOL_GPL(register_btf_kfunc_id_set);
>
> +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> +int register_mod_helper(struct btf_mod_helper *mod_helper)
> +{
> +	struct btf_mod_helper *s;
> +	struct btf *btf;
> +	struct btf_mod_helper_list *mod_helper_list;
> +
> +	btf = btf_get_module_btf(mod_helper->owner);
> +	if (!btf_is_module(btf)) {

You need to check for IS_ERR_OR_NULL before calling btf_is_module.

Also, this would fail if the module is compiled as built-in, because
mod_helper->owner will be NULL, and btf_get_module_btf will return btf_vmlinux.

> +		pr_err("%s can only be called from kernel module", __func__);
> +		return -EINVAL;
> +	}
> +
> +	if (IS_ERR_OR_NULL(btf))
> +		return btf ? PTR_ERR(btf) : -ENOENT;
> +
> +	mod_helper_list = btf->mod_helper_list;
> +	if (!mod_helper_list) {
> +		mod_helper_list = kzalloc(sizeof(*mod_helper_list), GFP_KERNEL | __GFP_NOWARN);
> +		if (!mod_helper_list)
> +			return -ENOMEM;

Here, you are not doing btf_put for module btf. Also, you'll have to guard the
btf_put with `if (btf_is_module(btf))` because reference is not raised for
btf_vmlinux.

> +		INIT_LIST_HEAD(&mod_helper_list->list);
> +		mutex_init(&mod_helper_list->mutex);
> +		btf->mod_helper_list = mod_helper_list;
> +	}
> +
> +	// Check if btf id is already registered

No C++ style comments.

> +	mutex_lock(&mod_helper_list->mutex);
> +	list_for_each_entry(s, &mod_helper_list->list, list) {
> +		if (mod_helper->set->ids[0] == s->set->ids[0]) {
> +			pr_warn("Dynamic helper %u is already registered\n", s->set->ids[0]);
> +			mutex_unlock(&mod_helper_list->mutex);
> +			return -EINVAL;

Need to free mod_helper_list and conditionally btf_put before returning.

> +		}
> +	}
> +	list_add(&mod_helper->list, &mod_helper_list->list);
> +	mutex_unlock(&mod_helper_list->mutex);
> +	btf_put(btf);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(register_mod_helper);
> +
> +int unregister_mod_helper(struct btf_mod_helper *mod_helper)
> +{
> +	struct btf *btf;
> +	struct btf_mod_helper_list *mod_helper_list;
> +
> +	btf = btf_get_module_btf(mod_helper->owner);
> +	if (!btf_is_module(btf)) {

Same error as above, need the IS_ERR_OR_NULL check to be before this.

> +		pr_err("%s can only be called from kernel module", __func__);
> +		return -EINVAL;
> +	}
> +
> +	if (IS_ERR_OR_NULL(btf))
> +		return btf ? PTR_ERR(btf) : -ENOENT;
> +
> +	mod_helper_list = btf->mod_helper_list;
> +	mutex_lock(&mod_helper_list->mutex);
> +	list_del(&mod_helper->list);
> +	mutex_unlock(&mod_helper_list->mutex);
> +	btf_put(btf);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(unregister_mod_helper);
> +const struct bpf_func_proto *get_mod_helper_proto(const struct btf *btf, const u32 kfunc_btf_id)
> +{
> +	struct btf_mod_helper *s;
> +	struct btf_mod_helper_list *mod_helper_list;
> +
> +	mod_helper_list = btf->mod_helper_list;
> +	if (!mod_helper_list)
> +		return NULL;
> +
> +	mutex_lock(&mod_helper_list->mutex);
> +	list_for_each_entry(s, &mod_helper_list->list, list) {
> +		if (s->set->ids[0] == kfunc_btf_id) {

If there is only one BTF ID, I think you can just use BTF_ID_LIST instead.

> +			mutex_unlock(&mod_helper_list->mutex);
> +			return s->func_proto;
> +		}
> +	}
> +	mutex_unlock(&mod_helper_list->mutex);
> +	return NULL;
> +}
> +#endif /* CONFIG_DEBUG_INFO_BTF_MODULES */
> +
>  int bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id,
>  			      const struct btf *targ_btf, __u32 targ_id)
>  {
> --
> 2.25.1
>
