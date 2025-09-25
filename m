Return-Path: <bpf+bounces-69744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0898BA08F1
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 18:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE7197B4AEB
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 16:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B47303CBD;
	Thu, 25 Sep 2025 16:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cJMWqO0w"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30593596B
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 16:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758816807; cv=none; b=Yhle7Dg5uaSVsD1fhAIk4a1/e/xXSJ+r0RSYLTRj9Nbl3tB4gZT4iJmXDbqiU73zzJnMMfy+w2/HDkOVSZtRTZXMf/KRGd5Z/whlBBJCHo9b3pZBe9bW/3z0ooo8kgh9BCWKFEbXEieWrIbGC2g2t4d8UfYa0bIDvxmzWOYuYkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758816807; c=relaxed/simple;
	bh=jXFdzTOLovsJrN9Nfs//Q5qxLuBEFEGKhi+yA65myVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZpY/NJEJiu7C59EygAL2BfAXvRpZ8sPFAuASSRIcSfIE+Z/TOUo6zSwYtdhh5oxkuX+ANyCKX5rdbjtmPvQLOWMCRiVV6klgpjEwtJddQ7s63Cj9/CSoVh6QgHGiYAB4SNnn7ZJrjxUF8jYlmk+efin+rJhGER5RLxZM/GYamwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cJMWqO0w; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6a6403ec-166a-4d48-8bf5-f43ae1759e5f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758816802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v1lzzFfCMcFF938iOkK2Z663LjuwV7KmPYm7+6fFCMc=;
	b=cJMWqO0wO5K4Q+rErfGLe/ps9Tt5Se2RTOHUZ525iSrHg5r1IzqWt1BMLdlPZc+GAWCm8i
	FiUWAwEKpHfGyWgev6FgVAnAuDcft6cKnn2yq/79/Sdz7djcvIPC1AUR2QqiWOzDowktEr
	AN0CBjLP9Xmu7iLrnoQr51q89qO4MVY=
Date: Thu, 25 Sep 2025 09:13:17 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 1/6] bpf: implement KF_IMPLICIT_PROG_AUX_ARG
 flag
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Eduard <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, dwarves <dwarves@vger.kernel.org>,
 Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Tejun Heo <tj@kernel.org>,
 Kernel Team <kernel-team@meta.com>
References: <20250924211716.1287715-1-ihor.solodrai@linux.dev>
 <20250924211716.1287715-2-ihor.solodrai@linux.dev>
 <CAADnVQLvuubey0A0Fk=bzN-=JG2UUQHRqBijZpuvqMQ+xy4W4g@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAADnVQLvuubey0A0Fk=bzN-=JG2UUQHRqBijZpuvqMQ+xy4W4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 9/25/25 2:49 AM, Alexei Starovoitov wrote:
> On Wed, Sep 24, 2025 at 10:17 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> Define KF_IMPLICIT_PROG_AUX_ARG and handle it in the BPF verifier.
>>
>> The mechanism of patching is exactly the same as for __prog parameter
>> annotation: in check_kfunc_args() detect the relevant parameter and
>> remember regno in cur_aux(env)->arg_prog.
>>
>> Then the (unchanged in this patch) fixup_kfunc_call() adds a mov
>> instruction to set the actual pointer to prog_aux.
>>
>> The caveat for KF_IMPLICIT_PROG_AUX_ARG is in implicitness. We have to
>> separately check that the number of arguments is under
>> MAX_BPF_FUNC_REG_ARGS.
>>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>> ---
>>  include/linux/btf.h   |  3 +++
>>  kernel/bpf/verifier.c | 43 ++++++++++++++++++++++++++++++++++++-------
>>  2 files changed, 39 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/linux/btf.h b/include/linux/btf.h
>> index f06976ffb63f..479ee96c2c97 100644
>> --- a/include/linux/btf.h
>> +++ b/include/linux/btf.h
>> @@ -79,6 +79,9 @@
>>  #define KF_ARENA_RET    (1 << 13) /* kfunc returns an arena pointer */
>>  #define KF_ARENA_ARG1   (1 << 14) /* kfunc takes an arena pointer as its first argument */
>>  #define KF_ARENA_ARG2   (1 << 15) /* kfunc takes an arena pointer as its second argument */
>> +/* kfunc takes a pointer to struct bpf_prog_aux as the last argument,
>> + * passed implicitly in BPF */
> 
> This is neither networking nor kernel comment style.
> Pls use proper kernel comment style in a new code,
> and reformat old net/bpf style when adjusting old comments.
> 
>> +#define KF_IMPLICIT_PROG_AUX_ARG (1 << 16)
> 
> The name is too verbose imo.
> How about
> KF_HIDDEN_PROG_ARG
> or
> KF_PROG_LAST_ARG
> 
> "Implicit" is not 100% correct, since it's very explicit
> in kfunc definition in C, but removed from BTF.
> "Hidden" is also not an exact fit for the same reasons.
> Hence my preference is KF_PROG_LAST_ARG.
> 
> "aux" part is also an implementation detail.
> 
>>  /*
>>   * Tag marking a kernel function as a kfunc. This is meant to minimize the
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index e892df386eed..f1f9ea21f99b 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -11948,6 +11948,11 @@ static bool is_kfunc_rcu_protected(struct bpf_kfunc_call_arg_meta *meta)
>>         return meta->kfunc_flags & KF_RCU_PROTECTED;
>>  }
>>
>> +static bool is_kfunc_with_implicit_prog_aux_arg(struct bpf_kfunc_call_arg_meta *meta)
>> +{
>> +       return meta->kfunc_flags & KF_IMPLICIT_PROG_AUX_ARG;
>> +}
>> +
>>  static bool is_kfunc_arg_mem_size(const struct btf *btf,
>>                                   const struct btf_param *arg,
>>                                   const struct bpf_reg_state *reg)
>> @@ -12029,6 +12034,18 @@ static bool is_kfunc_arg_prog(const struct btf *btf, const struct btf_param *arg
>>         return btf_param_match_suffix(btf, arg, "__prog");
>>  }
>>
>> +static int set_kfunc_arg_prog_regno(struct bpf_verifier_env *env, struct bpf_kfunc_call_arg_meta *meta, u32 regno)
>> +{
>> +       if (meta->arg_prog) {
>> +               verifier_bug(env, "Only 1 prog->aux argument supported per-kfunc");
>> +               return -EFAULT;
>> +       }
>> +       meta->arg_prog = true;
>> +       cur_aux(env)->arg_prog = regno;
>> +
>> +       return 0;
>> +}
>> +
>>  static bool is_kfunc_arg_scalar_with_name(const struct btf *btf,
>>                                           const struct btf_param *arg,
>>                                           const char *name)
>> @@ -13050,6 +13067,21 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>>                 return -EINVAL;
>>         }
>>
>> +       /* KF_IMPLICIT_PROG_AUX_ARG means that the kfunc has one less argument in BTF,
>> +        * so we have to set_kfunc_arg_prog_regno() outside the arg check loop.
>> +        */
> 
> Use kernel comment style.
> 
>> +       if (is_kfunc_with_implicit_prog_aux_arg(meta)) {
>> +               if (nargs + 1 > MAX_BPF_FUNC_REG_ARGS) {
>> +                       verifier_bug(env, "A kfunc with KF_IMPLICIT_PROG_AUX_ARG flag has %d > %d args",
>> +                                    nargs + 1, MAX_BPF_FUNC_REG_ARGS);
>> +                       return -EFAULT;
>> +               }
>> +               u32 regno = nargs + 1;
> 
> Variable declaration should be first in the block
> followed by a blank line.
> 
> Also I would remove this double "> MAX_BPF_FUNC_REG_ARGS" check.
> Move if (is_kfunc_with_prog_last_arg(meta))
> couple lines above before the check,
> and actual_nargs = nargs + 1;
> if (actual_nargs > MAX_BPF_FUNC_REG_ARGS)
> to cover both cases.
> I wouldn't worry that verbose() isn't too specific.
> If it prints nargs and actual_nargs whoever develops a kfunc
> can get an idea.
> Also in the future there is a good chance we will add more
> KF_FOO_LAST_ARG flags to cleanup other *_impl() kfuncs
> that have a special last argument, like bpf_rbtree_add_impl.
> If all of them copy paste "> MAX_BPF_FUNC_REG_ARGS" check
> it will be too verbose. Hence one nargs check for them all.

Hi Alexei, thank you for the review.

Sorry for the styling mistakes, forgot to run patches through
checkpatch.pl

In the other thread Eduard proposes a different approach to the
implementation [1].  Basically, leave BTF unmodified and move argument
hiding logic to bpftool's vmlinux.h generation.

IMO modifying BTF is more straightforward, but if the main goal is to
have a nice BPF C interface, maybe Eduard is onto something.

Curious to hear yours and Andrii's opinion on that.

Thanks.

[1] https://lore.kernel.org/bpf/b92d892f6a09fc7a411838ccf03dfebbba96384b.camel@gmail.com/

> 
> pw-bot: cr


