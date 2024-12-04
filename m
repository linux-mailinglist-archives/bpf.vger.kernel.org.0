Return-Path: <bpf+bounces-46125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1749E48C4
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 00:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 721C11880623
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 23:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91921F03FF;
	Wed,  4 Dec 2024 23:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZE23WP3A"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC97202C50
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 23:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354688; cv=none; b=eFZiPr16evA0gKL9zv0ldrYjR/Ep13X/OvsGxlGYiFe9Hqb+I6dZtnV8LdrqzHgwtGSChCFHEEZnVwjNINifOvhZBGQSV9SddBu90qz/dnMg0TglGs9EskbU7d6Dp1HfwxTWjaGKFwtcFt+C4vkOyYrNLT1ypRr0rB3roscr4vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354688; c=relaxed/simple;
	bh=zPq05mGm+OjHL+DeeqcCmgonx9t1dGQa4PaM+L8vvpY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=a/bMqNSTadPoa7lU23kxay5CQ86qL833KideITxt1kWO6rChm3hbt0SSJLyWqwO1yBA8GEyajsZbZi2NzaqxLsCWSeXiPLGSBnFsJ6AxXtxQLTb88nNFGjOf891P4JR6RjZczmQIWMJXL8FQdIWtW8kpC2xN/K+sWCHJ657Klw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZE23WP3A; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ecd47c2c-7b34-4649-ad97-3988c7644317@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733354682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N4agCSKBlPXoMNUkEfNfjgRL1qO8rzxabGXj897UQrg=;
	b=ZE23WP3AHMkqEcjWVsipLFYc7DoNbofjHetmNq4fbqxyYGQdNfLM8IL1O54dxIH/gQzawt
	sZBIgGeu8503HvWA60OcRbTWBXDNekcL0OLGDfuqMcKj7TVRMcO7oH3DuipN0voNJDO8nP
	du/2nz03fZ2nPwHmwo+Ij19FN4wofyg=
Date: Wed, 4 Dec 2024 15:24:33 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [External] Storing sk_buffs as kptrs in map
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Amery Hung <amery.hung@bytedance.com>, bpf@vger.kernel.org,
 magnus.karlsson@intel.com, sreedevi.joshi@intel.com, ast@kernel.org
References: <Z0X/9PhIhvQwsgfW@boxer>
 <CAONe225n=HosL1vBOOkzaOnG9jTYpQwDH6hwyQRAu0Cb=NBymA@mail.gmail.com>
 <d854688a-9d2d-4fed-9cb8-3e5c4498f165@linux.dev> <Z0dt/wZZhigcgGPI@boxer>
 <d1e95498-4613-43e0-bc6b-6f6157802649@linux.dev> <Z09uQ48lKEsORsS1@boxer>
Content-Language: en-US
In-Reply-To: <Z09uQ48lKEsORsS1@boxer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/3/24 12:46 PM, Maciej Fijalkowski wrote:
> ; bpf_skb_release((struct __sk_buff *)tmp); @ bpf_bpf.c:161
> 36: (bf) r1 = r6                      ; R1_w=ptr_sk_buff(ref_obj_id=3) R6=ptr_sk_buff(ref_obj_id=3) refs=3
> 37: (85) call bpf_skb_release#102037
> arg#0 expected pointer to ctx, but got ptr_

ic. The bpf_skb_release() is hitting the KF_ARG_PTR_TO_CTX again.

> processed 34 insns (limit 1000000) max_states_per_insn 0 total_states 3 peak_states 3 mark_read 1
> -- END PROG LOAD LOG --
> 
> 
> Still the same problem. Also even it would work it was not very convenient
> to cast these types back and forth...I then tried to store __sk_buff as
> kptr but I ended up with:
> 
> "map 'skb_map' has to have BTF in order to use bpf_kptr_xchg"
> 
> which got me lost:) I have a solution though which I'd like to discuss.
> 
>>
>> Please share the patch and the test case. It will be easier for others to help.
> 
> I have come up with rather simple way of achieving what I desired when
> starting this thread, how about something like this:
> 
>  From 0df7760330cccfe71235b56018d0a33d4a3b9863 Mon Sep 17 00:00:00 2001
> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Date: Tue, 3 Dec 2024 21:00:44 +0100
> Subject: [PATCH RFC bpf-next] bpf: add __ctx_ref kfunc argument suffix
> 
> The use case is when user wants to use sk_buff pointers as kptrs against
> program types that take in __sk_buff struct as context.
> 
> A pair of kfuncs for acquiring and releasing skb would look as follows:
> 
> __bpf_kfunc struct sk_buff *bpf_skb_acquire(struct sk_buff *skb__ctx_ref)
> __bpf_kfunc void bpf_skb_release(struct sk_buff *skb__ctx_ref)
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>   kernel/bpf/verifier.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 60938b136365..b16a39d28f8a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11303,6 +11303,11 @@ static bool is_kfunc_arg_const_str(const struct btf *btf, const struct btf_param
>   	return btf_param_match_suffix(btf, arg, "__str");
>   }
>   
> +static bool is_kfunc_arg_ctx_ref(const struct btf *btf, const struct btf_param *arg)
> +{
> +	return btf_param_match_suffix(btf, arg, "__ctx_ref");

imo, new tagging is not needed. It does not give new information to
the ptr type. I still think the verifier can be taught to handle
it better.

I took a closer look. I think the issue is btf_is_prog_ctx_type() selectively
treating some kfunc arg type as the uapi prog ctx instead of honoring what
has been written in the kernel source code.

The projection_of test was first added in
commit 2f4643934670 ("bpf: Support "sk_buff" and "xdp_buff" as valid kfunc arg types").
It was originally added to allow the kfunc to accept reg->type == PTR_TO_CTX
as its "struct sk_buff/xdp_buff *" argument.

After commit cce4c40b9606 ("bpf: treewide: Align kfunc signatures to prog point-of-view"),
the need of projection_of in btf_is_prog_ctx_type() should be gone.
However, this projection_of check has an unintentional side effect
for the other btf_is_prog_ctx_type() callers. It treats subprog
(in the bpf prog code) taking the "struct sk_buff *skb" arg as the uapi
prog ctx also. I don't think the bpf prog should do this though. I have a
"call_dynptr_skb" subprog to show this.

For the skb acquire/release kfunc, I think it is better to begin with
the "struct sk_buff *" as its arg type and return type
instead of "struct __sk_buff *" because it is the __kptr type stored
in the map. The kptr_xchg will also return the PTR_TO_BTF_ID.
It will need another cast call for acquire, like
"bpf_skb_acauire(bpf_cast_to_kern_ctx(ctx))" but this should be fine.
The "struct sk_buff __kptr *skb" stored in the map cannot
be passed to the bpf_dynptr_from_skb() also. It shouldn't be
allowed because bpf_dynptr_from_skb will allow skb write
in the tc bpf prog. The same goes for other tc bpf helpers which
takes ARG_PTR_TO_CTX.

I think we can remove the projection_of call from the
bpf_is_prog_ctx_type() such that it honors the exact argument
type written in the kernel source code. Add this particular projection_of
check (renamed to bpf_is_kern_ctx in the diff) to the other callers for
backward compat such that the caller can selectively translate
the argument of a subprog to the corresponding prog ctx type.

Lightly tested only:

diff --git i/kernel/bpf/btf.c w/kernel/bpf/btf.c
index e7a59e6462a9..2d39f91617fb 100644
--- i/kernel/bpf/btf.c
+++ w/kernel/bpf/btf.c
@@ -5914,6 +5914,26 @@ bool btf_is_projection_of(const char *pname, const char *tname)
  	return false;
  }
  
+static bool btf_is_kern_ctx(const struct btf *btf,
+			    const struct btf_type *t,
+			    enum bpf_prog_type prog_type)
+{
+	const struct btf_type *ctx_type;
+	const char *tname, *ctx_tname;
+
+	t = btf_type_skip_modifiers(btf, t->type, NULL);
+	if (!btf_type_is_struct(t))
+		return false;
+
+	tname = btf_name_by_offset(btf, t->name_off);
+	if (!tname)
+		return false;
+
+	ctx_type = find_canonical_prog_ctx_type(prog_type);
+	ctx_tname = btf_name_by_offset(btf_vmlinux, ctx_type->name_off);
+	return btf_is_projection_of(ctx_tname, tname);
+}
+
  bool btf_is_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
  			  const struct btf_type *t, enum bpf_prog_type prog_type,
  			  int arg)
@@ -5976,8 +5996,6 @@ bool btf_is_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
  	 * int socket_filter_bpf_prog(struct __sk_buff *skb)
  	 * { // no fields of skb are ever used }
  	 */
-	if (btf_is_projection_of(ctx_tname, tname))
-		return true;
  	if (strcmp(ctx_tname, tname)) {
  		/* bpf_user_pt_regs_t is a typedef, so resolve it to
  		 * underlying struct and check name again
@@ -6140,7 +6158,8 @@ static int btf_translate_to_vmlinux(struct bpf_verifier_log *log,
  				     enum bpf_prog_type prog_type,
  				     int arg)
  {
-	if (!btf_is_prog_ctx_type(log, btf, t, prog_type, arg))
+	if (!btf_is_prog_ctx_type(log, btf, t, prog_type, arg) &&
+	    !btf_is_kern_ctx(btf, t, prog_type))
  		return -ENOENT;
  	return find_kern_ctx_type_id(prog_type);
  }
@@ -7505,7 +7524,8 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
  		if (!btf_type_is_ptr(t))
  			goto skip_pointer;
  
-		if ((tags & ARG_TAG_CTX) || btf_is_prog_ctx_type(log, btf, t, prog_type, i)) {
+		if ((tags & ARG_TAG_CTX) || btf_is_prog_ctx_type(log, btf, t, prog_type, i) ||
+		    btf_is_kern_ctx(btf, t, prog_type)) {
  			if (tags & ~ARG_TAG_CTX) {
  				bpf_log(log, "arg#%d has invalid combination of tags\n", i);
  				return -EINVAL;

diff --git a/tools/testing/selftests/bpf/progs/skb_acquire.c b/tools/testing/selftests/bpf/progs/skb_acquire.c
new file mode 100644
index 000000000000..65d62fd97905
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/skb_acquire.c
@@ -0,0 +1,59 @@
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "bpf_kfuncs.h"
+#include "bpf_tracing_net.h"
+
+struct sk_buff *dummy_skb;
+
+struct sk_buff *bpf_skb_acquire(struct sk_buff *skb) __ksym;
+void bpf_skb_release(struct sk_buff *skb) __ksym;
+void *bpf_cast_to_kern_ctx(void *) __ksym;
+
+struct map_value {
+	int a;
+	struct sk_buff __kptr *skb;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct map_value);
+	__uint(max_entries, 16);
+} skb_map SEC(".maps");
+
+__noinline int call_dynptr_skb(struct sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_dynptr_from_skb((struct __sk_buff *)skb, 0, &ptr);
+
+	return 0;
+}
+
+__success
+SEC("tc")
+int bpf_tc_egress(struct __sk_buff *ctx)
+{
+	struct sk_buff *skb;
+	struct map_value *map_entry;
+	u32 zero = 0;
+
+	call_dynptr_skb((struct sk_buff *)ctx);
+
+	map_entry = bpf_map_lookup_elem(&skb_map, &zero);
+	if (!map_entry)
+		return TC_ACT_SHOT;
+
+	skb = bpf_skb_acquire(bpf_cast_to_kern_ctx(ctx));
+	if (!skb)
+		return TC_ACT_SHOT;
+
+	skb = bpf_kptr_xchg(&map_entry->skb, skb);
+	if (skb)
+		bpf_skb_release(skb);
+
+	return TC_ACT_OK;
+}
+
+char LICENSE[] SEC("license") = "GPL";

