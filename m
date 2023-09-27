Return-Path: <bpf+bounces-10983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EF47B0A7A
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 18:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 13D6A2821BA
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 16:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD7F347D2;
	Wed, 27 Sep 2023 16:37:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CF514F69
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 16:37:34 +0000 (UTC)
Received: from sonic304-27.consmr.mail.ne1.yahoo.com (sonic304-27.consmr.mail.ne1.yahoo.com [66.163.191.153])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214AB9C
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 09:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1695832651; bh=7N9S2a9BlDc74qB09A++4aSR1lRJkqjkhaOVzfYfAgg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=AEWnsljoVZUtZErvLldLVMUu427MEeTrC8hIbuGM3ofH1L1x1Us+VU2DF5sExL0pfZUgvUmkt8XFEJ6yVIRGWIkjeapAvwRVJRKI75F94uI7G1rcewRD9p2+VoVafzjPHGgBK2/rnG2TJULJSG/oJ6YTbWjvMXypuUlQ9vtRmnfoRUnRbuCYDtka10IO/ODDttFp3qB4x/RBRPrdCq1fbl/ke9ommVM/he0MPUZUHVaR8FKg1M2s3Qv9vhQ79N6IgG4nqe9IMNWRPdeKALieZufXBUvdbTppiFWPD9u0FcRhG6Wew2DQw5tp+kn+h0k/Jdmo4D71WkCEVflJnHIb7g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1695832651; bh=UzjUgn1j0v2J4YWQE0m8UI5svhPc8nhTsC32XRx4jkY=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=gO156L9DtCPW7HRvv8i8YU2HjIizuLh3oP0GTLfEBRLPMKzNfsbGqMq49wTqgKtKdYEmNnp8JzX1fpQJrb5c5PAZi+d3qxhX0XVBx9cPaaofQvC2ZovS5yqD7D9lPZzmLvBTXqF7QIMAZAVqxPaEQa5FuPUL3V9F8KUzoEYfy+/bsFfrS7idcKFwdyPyIow+86UvhuJFwmrXX7o8SjPfRkkIw+FpIZ5rpISWB4KHfTm0vSlnBtCo0/5lLwdqz2G32IaO9z3GViAR89icBA/LaLGb7oPXc0tr3z9dqUBGuWREsQW5Wp3DCKtide1hxWzrWMgnPJNHj7YS+t7M9IPGBg==
X-YMail-OSG: Nh81ZOMVM1m6jVO2nuAOS_elDLlF2UaMsKUbkCdNCSFUKI_Tt6sX75KNM32iaXA
 l0yxi7MbjTKnJ4eGPcTGWhxX0QZNb2f9PS9GQcma6HCC3jU2NGpeUnYPK8GJjTAmFvu9R8R831Nl
 t4aY3V.iXI2i3vCHQ8N9v4VnueuJ6Mz_nhY9uZzPy.HC5TL9Eza.HYhfaXFUxKsNLtMag_xwqkNG
 aZw9kpnvVBH2agGfcQjNL4eaZ2Rc_9Pfz2Fg15CyHRTO3QjPFOkCfkA9aUZWHAcTqEWDj7aseRP0
 eANtW.Bqs7RMyoLECGV4.1dn9uHGPmGbNfgUz82aoHlVXkdhVI8txlG6EAHoldt5QXa05.hF15W2
 _c3v05DFMb7zaJCVNQj9yMfL1miI2hOXbQo1SnpCVgQOdj2FR7nde8o4o0jbYD.B6R5RtSIvxHru
 MR2UCW2Bzm.NBPu.zZI09lxX7fCnvqk8MbN3tFfPS3y_4GMvv7mD4OUshoQpx.Znve0Gq4naME0D
 FB2oiRgBg4R5w2llOFx0FdV_nnnE8RAprMGmFUy10iNH.wMnD15srK0VWcRJfg8rXjUtr2ejN39t
 sRquHLjjVGgCQn704vCXu1fw7cAq19c1NNS2F0D.zQP9MivfdjXdvxJyTd3tDWs9z9vbGGAIjtbx
 PrYS73ihVwF_FI29HzBVgikkhrcWodRlrjYD5JGR5cGQjPeJzTYNHHRJzeLAqeQKy9N2MXPeV5B8
 mhzK7QO0A9UZL7aexImm0VhTeBSg7aaKN3QJ0nhEraqqHynLmTD898WgnJUUPdSZwvTjdcBKzO71
 OF_REusEhTlPNHo4Ia12JaL5kET9JKs.DS_ZGc9cgueWqoEwPbGqJqm18WRN9mqVwIduwjT66FIl
 FsQ2Z54.k7ongsNhbK7nMJfbmqX3SlORUv2WRXIEKhPJMMkdgVPDdVWxMOyQ.Z5cLEpjsFh4i_Pw
 KkKsL9T8PnGwnwMLNwPZqpZAStzwqMx3vzwudOdf6DnQnWLIVmYEQsELyM0gvo8UwslYRWoCl8Y0
 ZhX7c8v1Yt6KflSQP5hAVEvD9GT07L6p5sDOneLB8CFI2hMzA09tMq.SCTQ61fzqc4UAmQu.QCUK
 QncX8QP29I5.2Z5TYmH0t6CaGFvD2.vIuTTUzmf9s.hslR676RgOz6nIwerq.2dw4XqjnQ_5ib6c
 uPwM9vimNNg8QWwVba_IVpVE.gS8yLzUtb2dYU5042OeqWQWvFeUfogCypWIJnHkyrFfI0uG7_KO
 jcD8e1Ogy6gIsRBe0Fv5ITiKTxfZ8q3l2Bo.c7TJLZZNOjo.xG3fxYCm5k0781PaJZrKFuhQzMFZ
 JeXRaLANyIhE98qtwqycliH.I7bG75Y6tiTNJu1K77W47BE5XJ5ENLYOWk_be6MjDo4Zyoj930Oo
 AKl54bhJ1kCn.8JmQrin5_4.vfhA187StGh3.l125kgjpzR6V.IS_FiHw78l7GTs9Mawwasv8n5X
 BuIY9Pj3k66lb9WjkkxvsJijjcqPtNBbZEMdefQL8I_yfxBMbipchS0Ve0NA7eGCUa_Y9g97DBEr
 pVeZknwpCvkEEkI25uFJLbsAMR5QSdN0bMcWjBFm1q0fY7hGBW5eIcqmVsMa6T92IIZ0134afDU7
 selb_JWIXns8a0PugUTPWAeXYdm5dBJ_ehWMoqejv8YE7RaXgndWtP2scJCHDaOt_7UnQFpj4MW7
 sOJ0O8XtwLtpaGRXCC3nv32x0wW6xpISl7_KlnVvWPqumbh4w0XljObwehC2efNzc2lov6Zrbgcj
 59vpJq0g_wBNF_ov7u1qnjyNd2AAl7gNJ0BIps0RgJ1oN2jdKIv_tnuMNuBExRfp38F9gBYl7.Oi
 TbFXhVvaqwUnz4SGrHM.vG4fv76s9LKezPfUxmu9ydSRPktrHgBEAPhyGKl1uObCelTHBY2pie.u
 MbIDW7v5cyoZ9Luu9Xch5cXgrwT6EMDIXMMh8_kbp9p0UuFu91qvHiBaQYgxfAZxWPZlJhIVq543
 C6bltVr35LYmI2z6dPYl5L7.Y8FFZ8hyYaaTaxlO4nV1eIc2Citzn31HH8Y5lOcGKiBh0yYQ5a1t
 O1lMcBsECQdY3RqawZnl_Aw8BuLlALXFEG1G0Uv9icyYiYaX_B5AGfBj6o4qS69n6kOYHpfj.GXL
 SkpJZno.OMrWj6E4qp1twKw36Uj2eycxC_t7AhrG._TEHwcpA_fKZL.vLhGbv7ehwR0dhqyB.LvJ
 vUf6JbgbEjDbGbgXHjiclcnAhfJIsFwS_97rSl5x30zf8Z4ki1edJY64Z0nuXR7XrX2_laWVKEvc
 80A--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 10357545-7d4d-4633-9a0e-ac619ac57b86
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Wed, 27 Sep 2023 16:37:31 +0000
Received: by hermes--production-bf1-7cf89fd98c-ff8xs (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5b2b4b951fd59d12f6b70c33c8cab420;
          Wed, 27 Sep 2023 16:37:25 +0000 (UTC)
Message-ID: <57295dac-9abd-3bac-ff5d-ccf064947162@schaufler-ca.com>
Date: Wed, 27 Sep 2023 09:37:22 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 1/2] LSM: Allow dynamically appendable LSM modules.
Content-Language: en-US
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 linux-security-module <linux-security-module@vger.kernel.org>,
 KP Singh <kpsingh@kernel.org>, Paul Moore <paul@paul-moore.com>,
 bpf <bpf@vger.kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <cc8e16bb-5083-01da-4a77-d251a76dc8ff@I-love.SAKURA.ne.jp>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <cc8e16bb-5083-01da-4a77-d251a76dc8ff@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21797 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/27/2023 8:08 AM, Tetsuo Handa wrote:
> Recently, the LSM community is trying to make drastic changes.

I'd call them "significant" or "important" rather than "drastic".

> Crispin Cowan has explained
>
>   It is Linus' comments that spurred me to want to start this undertaking.  He
>   observes that there are many different security approaches, each with their own
>   advocates.  He doesn't want to arbitrate which of them should be "the" Linux
>   security approach, and would rather that Linux can support any of them.
>
>   That is the purpose of this project:  to allow Linux to support a variety of
>   security models, so that security developers don't have to have the "my dog's
>   bigger than your dog" argument, and users can choose the security model that
>   suits their needs.
>
> when the LSM project started [1].
>
> However, Casey Schaufler is trying to make users difficult to choose the
> security model that suits their needs, by requiring LSM ID value which is
> assigned to only LSM modules that succeeded to become in-tree [2].

This statement is demonstrably false, and I'm tired of hearing it.

> Therefore, I'm asking Casey and Paul Moore to change their mind to allow
> assigning LSM ID value to any LSM modules (so that users can choose the
> security model that suits their needs) [3].
>
> I expect that LSM ID value will be assigned to any publicly available LSM
> modules. Otherwise, it is mostly pointless to propose this patch; there
> will be little LSM modules to built into vmlinux; let alone dynamically
> loading as LKM-based LSMs.
>
> Also, KP Singh is trying to replace the linked list with static calls in
> order to reduce overhead of indirect calls [4]. However, this change
> assumed that any LSM modules are built-in. I don't like such assumption
> because I still consider that LSM modules which are not built into vmlinux
> will be wanted by users [5].
>
> Then, Casey told me to supply my implementation of loadable security
> modules [6]. Therefore, I post this patch as basic changes needed for
> allowing dynamically appendable LSM modules (and an example of appendable
> LSM modules). This patch was tested on only x86_64.

Thank you for doing so. I will be mostly off line for the next few weeks,
and will review the proposal fully on my return. I will provide some
initial feedback below.

> Question for KP Singh would be how can we allow dynamically appendable
> LSM modules if current linked list is replaced with static calls with
> minimal-sized array...
>
> Link: https://marc.info/?l=linux-security-module&m=98706471912438&w=2 [1]
> Link: https://lkml.kernel.org/r/20230912205658.3432-2-casey@schaufler-ca.com [2]
> Link: https://lkml.kernel.org/r/6e1c25f5-b78c-8b4e-ddc3-484129c4c0ec@I-love.SAKURA.ne.jp [3]
> Link: https://lkml.kernel.org/r/20230918212459.1937798-1-kpsingh@kernel.org [4]
> Link: https://lkml.kernel.org/r/ed785c86-a1d8-caff-c629-f8a50549e05b@I-love.SAKURA.ne.jp [5]
> Link: https://lkml.kernel.org/r/36c7cf74-508f-1690-f86a-bb18ec686fcf@schaufler-ca.com [6]
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  include/linux/lsm_hooks.h |   2 +
>  security/security.c       | 107 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 109 insertions(+)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index dcb5e5b5eb13..73db3c41df26 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -105,6 +105,8 @@ extern char *lsm_names;
>  
>  extern void security_add_hooks(struct security_hook_list *hooks, int count,
>  				const char *lsm);
> +extern int register_loadable_lsm(struct security_hook_list *hooks, int count,
> +				 const char *lsm);
>  
>  #define LSM_FLAG_LEGACY_MAJOR	BIT(0)
>  #define LSM_FLAG_EXCLUSIVE	BIT(1)
> diff --git a/security/security.c b/security/security.c
> index 23b129d482a7..6c64b7afb251 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -74,6 +74,7 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
>  };
>  
>  struct security_hook_heads security_hook_heads __ro_after_init;
> +EXPORT_SYMBOL_GPL(security_hook_heads);

Why disrupt the protection of security_hook_heads? You could easily add

struct security_hook_heads security_loadable_hook_heads
EXPORT_SYMBOL_GPL(security_loadable_hook_heads);

and add the loaded hooks there. A system that does not use loadable
modules would be unaffected by the ability to load modules.

>  static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
>  
>  static struct kmem_cache *lsm_file_cache;
> @@ -537,6 +538,112 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>  	}
>  }
>  
> +#if defined(CONFIG_STRICT_KERNEL_RWX)
> +#define MAX_RO_PAGES 1024 /* Wild guess. Can be minimized by dynamic allocation. */
> +static struct page *ro_pages[MAX_RO_PAGES]; /* Pages that are marked read-only. */
> +static unsigned int ro_pages_len; /* Number of pages that are marked read-only. */
> +
> +/* Check whether a page containing given address does not have _PAGE_BIT_RW bit. */
> +static bool lsm_test_page_ro(void *addr)
> +{
> +	unsigned int i;
> +	int unused;
> +	struct page *page;
> +
> +	page = (struct page *) lookup_address((unsigned long) addr, &unused);
> +	if (!page)
> +		return false;
> +	if (test_bit(_PAGE_BIT_RW, &(page->flags)))
> +		return true;
> +	for (i = 0; i < ro_pages_len; i++)
> +		if (page == ro_pages[i])
> +			return true;
> +	if (ro_pages_len == MAX_RO_PAGES)
> +		return false;
> +	ro_pages[ro_pages_len++] = page;
> +	return true;
> +}
> +
> +/* Find pages which do not have _PAGE_BIT_RW bit. */
> +static bool check_ro_pages(struct security_hook_list *hooks, int count)
> +{
> +	int i;
> +	struct hlist_head *list = &security_hook_heads.capable;
> +
> +	if (!copy_to_kernel_nofault(list, list, sizeof(void *)))
> +		return true;
> +	for (i = 0; i < count; i++) {
> +		struct hlist_head *head = hooks[i].head;
> +		struct security_hook_list *shp;
> +
> +		if (!lsm_test_page_ro(&head->first))
> +			return false;
> +		hlist_for_each_entry(shp, head, list)
> +			if (!lsm_test_page_ro(&shp->list.next) ||
> +			    !lsm_test_page_ro(&shp->list.pprev))
> +				return false;
> +	}
> +	return true;
> +}
> +#endif

I'm not an expert on modern memory management, but I think introducing
security_loadable_hook_heads would make these functions unnecessary.
Please educate me if I'm wrong.

> +
> +/**
> + * register_loadable_lsm - Add a dynamically appendable module's hooks to the hook lists.
> + * @hooks: the hooks to add
> + * @count: the number of hooks to add
> + * @lsm: the name of the security module
> + *
> + * Each dynamically appendable LSM has to register its hooks with the infrastructure.
> + *
> + * Assumes that this function is called from module_init() function where
> + * call to this function is already serialized by module_mutex lock.
> + */
> +int register_loadable_lsm(struct security_hook_list *hooks, int count,
> +			  const char *lsm)
> +{
> +	int i;
> +	char *cp;
> +
> +	// TODO: Check whether proposed hooks can co-exist with already chained hooks,
> +	//       and bail out here if one of hooks cannot co-exist...
> +
> +#if defined(CONFIG_STRICT_KERNEL_RWX)
> +	// Find pages which needs to make temporarily writable.
> +	ro_pages_len = 0;
> +	if (!check_ro_pages(hooks, count)) {
> +		pr_err("Can't make security_hook_heads again writable. Retry with rodata=off kernel command line option added.\n");
> +		return -EINVAL;
> +	}
> +	pr_info("ro_pages_len=%d\n", ro_pages_len);
> +#endif
> +	// At least "capability" is already included.
> +	cp = kasprintf(GFP_KERNEL, "%s,%s", lsm_names, lsm);
> +	if (!cp) {
> +		pr_err("%s - Cannot get memory.\n", __func__);
> +		return -ENOMEM;
> +	}
> +#if defined(CONFIG_STRICT_KERNEL_RWX)
> +	// Make security_hook_heads (and hooks chained) temporarily writable.
> +	for (i = 0; i < ro_pages_len; i++)
> +		set_bit(_PAGE_BIT_RW, &(ro_pages[i]->flags));
> +#endif
> +	// Register dynamically appendable module's hooks.
> +	for (i = 0; i < count; i++) {
> +		hooks[i].lsm = lsm;
> +		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
> +	}
> +#if defined(CONFIG_STRICT_KERNEL_RWX)
> +	// Make security_hook_heads (and hooks chained) again read-only.
> +	for (i = 0; i < ro_pages_len; i++)
> +		clear_bit(_PAGE_BIT_RW, &(ro_pages[i]->flags));
> +#endif
> +	// TODO: Wait for reader side before kfree().
> +	kfree(lsm_names);
> +	lsm_names = cp;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(register_loadable_lsm);

Most of this code seems unnecessary if you use security_loadable_hook_heads.

There would need to be additions in security.c to invoke the hooks in the new
list, but that would be straightforward. Locking is another matter. I don't see
that addressed here, and I fear that it might have prohibitive performance
impact. Again, I'm not an expert on locking, so you'll need to seek advise
elsewhere.

On a less happy note, you haven't addressed security blobs in any way. You
need to provide a mechanism to allow an LSM to share security blobs with
builtin LSMs and other loadable LSMs.

> +
>  int call_blocking_lsm_notifier(enum lsm_event event, void *data)
>  {
>  	return blocking_notifier_call_chain(&blocking_lsm_notifier_chain,

