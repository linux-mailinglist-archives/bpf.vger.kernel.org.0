Return-Path: <bpf+bounces-73511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 576BEC333B9
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 23:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8A9AA34C081
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 22:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973522D322E;
	Tue,  4 Nov 2025 22:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGU9KyQ1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A37313295
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 22:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295409; cv=none; b=KlQi1Y808upzo49Nu5ITcUwE3+Ed83R1/owk+yaHMX+0gUXTRATf61DOcCztuJuhXM7RncS4oQTewkkDCSgDKe3J+hooQzCFllGlaHOzRFbUCQj+gp3WT5rlxcxd5S/7Pk5cKH64TGch8oGXkBQ2a/3/fKyTWVzgfOH07wlAzkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295409; c=relaxed/simple;
	bh=/tVLEoVAjMP5GLVHIsfTVVulzqh6t3qoCstbZdL78XQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cogLiBixDg55dhnMOmAc5eCHLdGY+CxQv++Ro+XMbxeDSkFd3PMitRbEL37XMNElFpV+GIV5OWbFOKf6bUVTrwGTTreP+2KQZE9mVimgFusGtZld7mHhBuR7WCK4sbQ/V23mIaea3pRz4SE024cydze/YeOoBlz705rM7bQqljQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGU9KyQ1; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34182b1c64bso746671a91.3
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 14:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295407; x=1762900207; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9+HfR/hbuHIi491WdjZftJVXw37Lejq3SSWcetbxvsQ=;
        b=lGU9KyQ1NYDO6Qx7f7D9dwm496C6NLv0cXCfOzMXrBRT1PZtxJuMMEnQR2nN21Wgzy
         sVkdv4ApB9JDazbEsASQ+hblH0ta/V2L/huGgxqRYEx2B+s2d5FWgJxsARWj/UBMJB4l
         XfiTq6YxA7uGxtI1R7xPLelnS+1NfcGd/mZYkM6HKpM321Jit+4/th1cnca1JkyOE4vJ
         fUGdoiAyI+NF+JSdNZ4+mCiTdn7jzmgoNIW4IHipDJYRKO1TT++le5mRxJ135u/o7WnJ
         vxswXjeNL7iD9nMOfbsBxe7Khu+UctdvuNGNyDEZZSGgZeysjETBf7HYuT/PG3Dw2/eW
         /hFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295407; x=1762900207;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9+HfR/hbuHIi491WdjZftJVXw37Lejq3SSWcetbxvsQ=;
        b=ltONwbQWkEvn7oeU+1VwHp2OkOFRrVECmwrxf9VOR1gisw6HXpgMCpCe3+7h7UevaX
         uOYoAtiR+zJz9NFTrBOY6r0LNc4TYRvXOqTda77Uu9zMt5zrzTdLiIvHWIpOIjU+h+0l
         R+sXxYumKOqS9D7SvMS82hqJ5vWO+RD8Dl8ZmypOQjN4J2HH52bEaUHIy3m4VrKY9Yl0
         gWLmcYYxC/gF4oc9cAnbTycI2eu0rtGtB7NzbnUIfuAHuZLNQXAiaPpFPSInmdW879C1
         onJbWqfKomivfGLC5HVrs+C8hHCgoyQfAqCh1CEioRVoGJeQsb/7t4HSm8Hp5Kie7MHb
         DF3g==
X-Forwarded-Encrypted: i=1; AJvYcCXTfH9sk1OQpjm2xHezWu0lC0r5nGr9SPhhlgwEoGOU1z82eztPrQh1Ibw8LM/TjrPnh6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgAM/VS3PqzS/VBVVxrUVUYi48mhx1km+QzODXLK6PqxXU9VeS
	v+4PpgCaKk0AwGfOqT5lswWwcBHhPN4hIONowUowt2hC4p8B1zRL1/6ssm2w1d2r
X-Gm-Gg: ASbGncsSkP8VMHVPax2emAEC6/4mPBtQEQzg4NsCGwDiGBjApXomLOOinEK/Ft3VpQ0
	H9aig9gh0I8v1cLBTVauVf55RzZAVpJgiYzqswcojNebiabjDsd/3gbf5Y81gYmkju5McBOD3es
	EYf4NyE/QhRHQXGyKIGUK+XYRC1qu/knnaof0EOXPH4EvbCiGMUkCLIQkRrPFKsATPJ1w2jD+H/
	DILVKKKohFunvi5NOAetMybM7UNFLhwn2eWHa0LzsA/fTEKEwFAJHP89F2bhRMXX+Ou87+ziWGk
	RVRBOKwEtsT0/QYQUB8UJWFE0GFfUcKbQJpAfmuvcJ2+e28JCsRZlDPVAUTTXnL7u36nHv/viHp
	+MQ1G7IpcJe4DTqzYdIRxyCohxywMNBeyogoDM6ghXwcBt/y4/onUDQbTzsLVt4NOh0Zxk2YGUX
	JYdoEGSnSA+otly8ho2pgpybQ=
X-Google-Smtp-Source: AGHT+IGVTQ1civOHUZLhyoN+GDvkyGIKt4LNNLQeWKXMFCn+zfO3FMLGL/wmqyztbGYOhVvZpI4jiw==
X-Received: by 2002:a17:90b:584d:b0:341:315:f50d with SMTP id 98e67ed59e1d1-341a6bfb59bmr871924a91.8.1762295406371;
        Tue, 04 Nov 2025 14:30:06 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:a643:22b:eb9:c921? ([2620:10d:c090:500::5:99aa])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a69b698asm617878a91.21.2025.11.04.14.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:30:06 -0800 (PST)
Message-ID: <3fd72f5e97f7c5e863d3686d5eb062048e9192b2.camel@gmail.com>
Subject: Re: [PATCH v2 bpf] bpf: properly verify tail call behavior
From: Eduard Zingerman <eddyz87@gmail.com>
To: Martin Teichmann <martin.teichmann@xfel.eu>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org
Date: Tue, 04 Nov 2025 14:30:05 -0800
In-Reply-To: <20251104133004.2559222-1-martin.teichmann@xfel.eu>
References: <ec29fa64723036f672afd18686454d02857ea4e9.camel@gmail.com>
	 <20251104133004.2559222-1-martin.teichmann@xfel.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-11-04 at 14:30 +0100, Martin Teichmann wrote:
> A successful ebpf tail call does not return to the caller, but to the
> caller-of-the-caller, often just finishing the ebpf program altogether.
>=20
> Any restrictions that the verifier needs to take into account - notably
> the fact that the tail call might have modified packet pointers - are to
> be checked on the caller-of-the-caller. Checking it on the caller made
> the verifier refuse perfectly fine programs that would use the packet
> pointers after a tail call, which is no problem as this code is only
> executed if the tail call was unsuccessful, i.e. nothing happened.
>=20
> This patch simulates the behavior of a tail call in the verifier. A
> conditional jump to the code after the tail call is added for the case
> of an unsucessful tail call, and a return to the caller is simulated for
> a successful tail call.
>=20
> For the successful case we assume that the tail call returns an int,
> as tail calls are currently only allowed in functions that return and
> int. We always assume that the tail call modified the packet pointers,
> as we do not know what the tail call did.
>=20
> For the unsuccessful case we know nothing happened, so we do not need to
> add new constraints. Some test are added, notably one corner case found
> by Eduard Zingerman.
>=20
> Fixes: 1a4607ffba35 ("bpf: consider that tail calls invalidate packet poi=
nters")
> Link: https://lore.kernel.org/bpf/20251029105828.1488347-1-martin.teichma=
nn@xfel.eu/
> Signed-off-by: Martin Teichmann <martin.teichmann@xfel.eu>
> ---

Hi Martin,

I think this is a viable idea.
Please see a few notes below.

>  kernel/bpf/verifier.c                         | 25 ++++++++++--
>  .../selftests/bpf/progs/verifier_sock.c       | 39 ++++++++++++++++++-
>  2 files changed, 59 insertions(+), 5 deletions(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e4928846e763..9a091e0f2f07 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11005,6 +11005,10 @@ static int prepare_func_exit(struct bpf_verifier=
_env *env, int *insn_idx)
>  	bool in_callback_fn;
>  	int err;
> =20
> +	err =3D bpf_update_live_stack(env);
> +	if (err)
> +		return err;
> +
>  	callee =3D state->frame[state->curframe];
>  	r0 =3D &callee->regs[BPF_REG_0];
>  	if (r0->type =3D=3D PTR_TO_STACK) {
> @@ -11911,6 +11915,24 @@ static int check_helper_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn
>  		env->prog->call_get_func_ip =3D true;
>  	}
> =20
> +	if (func_id =3D=3D BPF_FUNC_tail_call) {
> +		if (env->cur_state->curframe) {
> +			struct bpf_verifier_state *branch;
> +			mark_reg_scratched(env, BPF_REG_0);
> +			branch =3D push_stack(env, env->insn_idx + 1, env->insn_idx, false);
> +			if (IS_ERR(branch))
> +				return PTR_ERR(branch);
> +			clear_all_pkt_pointers(env);
> +			mark_reg_unknown(env, regs, BPF_REG_0);
> +			err =3D prepare_func_exit(env, &env->insn_idx);
> +			if (err)
> +				return err;
> +			env->insn_idx--;
> +		} else {
> +			changes_data =3D false;
> +		}
> +	}
> +

Could you please update bpf_insn_successors()?
Technically, it should do something similar to what Anton does in [1].
W/o bpf_insn_successors() reflecting that control flow might jump over
the instructions between tail call and function exit, verifier might
assume that some writes to parent stack always happen, which is not
the case.

I think this is a long standing bug, was here even before my changes
for stack liveness.

[1] https://lore.kernel.org/bpf/20251102205722.3266908-7-a.s.protopopov@gma=
il.com/

>  	if (changes_data)
>  		clear_all_pkt_pointers(env);
>  	return 0;
> @@ -19876,9 +19898,6 @@ static int process_bpf_exit_full(struct bpf_verif=
ier_env *env,
>  		return PROCESS_BPF_EXIT;
> =20
>  	if (env->cur_state->curframe) {
> -		err =3D bpf_update_live_stack(env);
> -		if (err)
> -			return err;
>  		/* exit from nested function */
>  		err =3D prepare_func_exit(env, &env->insn_idx);
>  		if (err)
> diff --git a/tools/testing/selftests/bpf/progs/verifier_sock.c b/tools/te=
sting/selftests/bpf/progs/verifier_sock.c
> index 2b4610b53382..a2132c72d3b8 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_sock.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_sock.c
> @@ -1117,10 +1117,17 @@ int tail_call(struct __sk_buff *sk)
>  	return 0;
>  }
> =20
> -/* Tail calls invalidate packet pointers. */
> +static __noinline
> +int static_tail_call(struct __sk_buff *sk)
> +{
> +	bpf_tail_call_static(sk, &jmp_table, 0);
> +	return 0;
> +}
> +
> +/* Tail calls in sub-programs invalidate packet pointers. */
>  SEC("tc")
>  __failure __msg("invalid mem access")
> -int invalidate_pkt_pointers_by_tail_call(struct __sk_buff *sk)
> +int invalidate_pkt_pointers_by_global_tail_call(struct __sk_buff *sk)
>  {
>  	int *p =3D (void *)(long)sk->data;
> =20
> @@ -1131,4 +1138,32 @@ int invalidate_pkt_pointers_by_tail_call(struct __=
sk_buff *sk)
>  	return TCX_PASS;
>  }
>

Usually, test cases are added as separate commits.
Changes to tests are bundled with changes to kernel only if that is
necessary to keep bisect happy (tests passing on each commit).

--

Also, could you please add a test case verifying that:
- Precision propagation works correctly when processing program
  fragment containing tail call. (I think that is_jmp_point() logic
  should kick-in automatically here, but would be nice to have a
  test).
- Live stack tracking works correctly under the same circumstances.
  (Test case exercising bpf_update_live_stack() call you inserted).

See verifier_subprog_precision.c and verifier_live_stack.c for
examples.

> +/* Tail calls in static sub-programs invalidate packet pointers. */
> +SEC("tc")
> +__failure __msg("invalid mem access")
> +int invalidate_pkt_pointers_by_static_tail_call(struct __sk_buff *sk)
> +{
> +	int *p =3D (void *)(long)sk->data;
> +
> +	if ((void *)(p + 1) > (void *)(long)sk->data_end)
> +		return TCX_DROP;
> +	static_tail_call(sk);
> +	*p =3D 42; /* this is unsafe */
> +	return TCX_PASS;
> +}
> +
> +/* Direct tail calls do not invalidate packet pointers. */
> +SEC("tc")
> +__success
> +int invalidate_pkt_pointers_by_tail_call(struct __sk_buff *sk)
> +{
> +	int *p =3D (void *)(long)sk->data;
> +
> +	if ((void *)(p + 1) > (void *)(long)sk->data_end)
> +		return TCX_DROP;
> +	bpf_tail_call_static(sk, &jmp_table, 0);
> +	*p =3D 42; /* this is NOT unsafe: tail calls don't return */
> +	return TCX_PASS;
> +}
> +
>  char _license[] SEC("license") =3D "GPL";

