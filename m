Return-Path: <bpf+bounces-73188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF931C26BD1
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 20:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EE6746704F
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 19:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3502E6CB6;
	Fri, 31 Oct 2025 19:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brER211k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CA02EB857
	for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 19:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761938701; cv=none; b=qiZQEIqyijZS7BqAEfXH08SUENvHMixc+jjdBlxTfDLk/YUyXL+p62MGkT1l9P86g6ZqnPntedcWpToq0tizU7NWzdAREwQU3CbyTt591uzpeM1YsW3FUwi9mIvl0y6bszJIwvEbo3g9iiMCHcUzMKsUgKoO35P30sL4SGhBIhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761938701; c=relaxed/simple;
	bh=ZxMoj9DfjOruQDto1UZvB4qT9/zlk5Pn4yGAuH8T1SQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DoWprUEJvJuG1J/IPgwp5KSAFQANrAnKqHDmJ/3nfzBxPRm4vsdfURuyDSPEZr2LfCg626kjhLmYAhbp+tLfaoO/S3ghoJQ1CnYmiT4hVOH5kEdzQtOj4H/3s+x+qP1c6c63+3jCX7tQ9Kc1VXocmfrJqZz383d2zeY2xcQL8Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brER211k; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7a23208a0c2so2208570b3a.0
        for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 12:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761938699; x=1762543499; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/TBrDy9Cw8m6DLql4nk//ktmh+AGY+mp6gF3VRm0I2M=;
        b=brER211kRTPGJ+4R/QVvK8gRtUasFPgEO75ASeYrvL/Zrl9aifiV6XuYIZLi+qKJCC
         Ug1CPkSIJ6Y7LqI88ETpOPpexZAd/1jZ3dj5u6E7+RrYj3LV/OF5uSiIb024az52ER1Q
         LjMhdH6qeh6XuJZZOLjORWqtnceZFyjXor1nWtgaG6WeCeuYUkM45nQ4fwMr4f7q5KIV
         flxpcJ52sNpUqOHDshrbht793YK/a6sGO2GqpCBMVOc7xphrxSGYd6/yfHyqTIJxfH7l
         xSfQGEwRYci0IoGj4Le1a/9XC5i92f+QUootRFWak0i9IPa1eajj040dir2X9NOaSGY4
         tOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761938699; x=1762543499;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/TBrDy9Cw8m6DLql4nk//ktmh+AGY+mp6gF3VRm0I2M=;
        b=DfJdkKgOEr8ZYODVHW49UCtXQeAwrlgXkoHWTmN5ZrIEbv79jMd+qn5OSN2GTA2FH9
         L5CzP7CFWxDAhzq11TfxFgfZG0wmh0WKIKX9O3ic10k2ywzvLYmkyx/X28yN7IV5Dyqv
         B5GTxdpgTz1uSUtwtCTId293HXWsudkosX8Jy/pDF+3p9iBXxYIlNbBZeTKvSnUXv9sb
         LOSw0jcTay4QSLyvdtYGzLgEptdBaEfQA18QlDvsXbxwwE3YPsrOXJae6wvSRczGNFYW
         G6xQGl0iwsdkji+QCjLdYzvxYIMlGC4chNcpCs+CmbrTdusEACYcNpAojHytENKl089C
         0IdQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7zoZQ26R5RnVygdj/gx2BxbcBTRoVqLnc+QDkTjMbHAT5RmU+uxX5oXry/CHsxQrkhdA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx66kSkhpY3JCpPt0BzvSPJ7EGY3mdF3EJVvydsnHU7rZBsc+H
	ClLcSxup231DeOs5Ne6SO1gOjSroQZKqu6U5Zl9OkhW3RPVK6jdV9F2m
X-Gm-Gg: ASbGncvCqZvSxitHF7wFXVKVoalhxeSzCmNzUDKNv62TNJ/8Y8mXF87R2Z5Fi2TOaNL
	zfDm5qTEW9MA3ZcRko2WHHFiyhvr0Iys8W+JLhWP21k9Q3s1FR9MND6LPpWpBsSDy9lkJ5xVc/O
	GzBMlKop8+jGAR7ca9KWGZnozub44uSMI+IMqMhkCeWGHn3EOkTjqG5QKw+qez2+hkMAGWHrdO7
	yIAyVMln6KW97k+AsEpqnl7H9cheksVaMkKL5I5md4GG5Nug3DuJokoUXVVhOPjnj+ZinpW3BGu
	Uge+djJcno504E/mPHKe0KRfmH4uhWd7P5bFJFT6ND9w79YaKrIla58WWyKTtUIHoBYxJ7sv2u5
	66W2nitdqbkx+vz2/F3Cc1uyLTzmhaFXWIlQc7ekuMmGzcZFdJm0MSnaBGlrt00GSSln1sABekg
	==
X-Google-Smtp-Source: AGHT+IFPvfmzgmZ6hVzDsN553A/5XMNAvnkFs1pvvo93IHfP543GaAj6iIL98pD0Xlff/TT/XqlBdg==
X-Received: by 2002:a05:6a00:92a4:b0:7a2:7157:6d95 with SMTP id d2e1a72fcca58-7a777952b44mr5738338b3a.14.1761938699278;
        Fri, 31 Oct 2025 12:24:59 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db67cac6sm2968832b3a.51.2025.10.31.12.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 12:24:58 -0700 (PDT)
Message-ID: <ec29fa64723036f672afd18686454d02857ea4e9.camel@gmail.com>
Subject: Re: [PATCH bpf] bpf: tail calls do not modify packet data
From: Eduard Zingerman <eddyz87@gmail.com>
To: Martin Teichmann <martin.teichmann@xfel.eu>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org
Date: Fri, 31 Oct 2025 12:24:55 -0700
In-Reply-To: <20251029105828.1488347-1-martin.teichmann@xfel.eu>
References: <20251029105828.1488347-1-martin.teichmann@xfel.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-29 at 11:58 +0100, Martin Teichmann wrote:
> The bpf verifier checks whether packet data is modified within a helper
> function, and if so invalidates the pointer to that data. Currently the
> verifier always invalidates if the helper function called is a tail
> call, as it cannot tell whether the called function does or does not
> modify the packet data.
>
> However, in this case, the fact that the packet might be modified is
> irrelevant in the code following the helper call, as the tail call only
> returns if there is nothing to execute, otherwise the calling
> (sub)program will return directly after the tail call finished.
>
> So it is this (sub)program for which the pointer to packet data needs to
> be invalidated.
>
> Fortunately, there are already two distinct points in the code for
> invalidating packet pointers directly after a helper call, and for
> entire (sub)programs. This commit assures that the pointer is only
> invalidated in the relevant case.
>
> Note that this is a regression bug: taking care of tail calls only
> became necessary when subprograms were introduced, before commit
> 1a4607ffba35 using a packet pointer after a tail call was working fine,
> as it should.
>
> Fixes: 1a4607ffba35 ("bpf: consider that tail calls invalidate packet poi=
nters")
> Signed-off-by: Martin Teichmann <martin.teichmann@xfel.eu>
> ---

Hi Martin,

Sorry for delayed response, missed this patch.
I don't think this is safe to do, consider the following example:

  main:
    p =3D pkt
    foo()
    use p

  foo: // assume that 'foo' is a static function (local subprogram)
    if (something) do tail call
    don't modify packet data

Verifier does not track if jump table map contains programs that
modify or don't packet pointers, meaning that tail call can do both.

When local subprograms are processed, the logic checking
.changes_pkt_data does not kick in:

  static int check_func_call(...)
  {
        ...
        if (subprog_is_global(env, subprog)) {
                ...
                if (env->subprog_info[subprog].changes_pkt_data)
                        clear_all_pkt_pointers(env);
        ...
  }

And verifier relies on reaching:

  static int check_helper_call(...)
  {
        ...
        changes_data =3D bpf_helper_changes_pkt_data(func_id);
        ...
        if (changes_data)
                clear_all_pkt_pointers(env);
        ...
  }

To decide if to invalidate packet pointers.
Meaning that in the example above, the 'use p' part of 'main' won't be
safe if packet pointers are not invalidated upon seeing tail call.

---

Alexei vaguely remembers discussion about using decl_tag's to mark
maps containing programs that don't modify packet pointers.


>  kernel/bpf/verifier.c                          |  3 ++-
>  net/core/filter.c                              |  2 --
>  .../selftests/bpf/progs/verifier_sock.c        | 18 ++++++++++++++++--
>  3 files changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6d175849e57a..4bc36a1efe93 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17879,7 +17879,8 @@ static int visit_insn(int t, struct bpf_verifier_=
env *env)
>  			 */
>  			if (ret =3D=3D 0 && fp->might_sleep)
>  				mark_subprog_might_sleep(env, t);
> -			if (bpf_helper_changes_pkt_data(insn->imm))
> +			if (bpf_helper_changes_pkt_data(insn->imm)
> +					|| insn->imm =3D=3D BPF_FUNC_tail_call)
>  				mark_subprog_changes_pkt_data(env, t);
>  		} else if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL) {
>  			struct bpf_kfunc_call_arg_meta meta;
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 9d67a34a6650..71a1cfed49f1 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -8038,8 +8038,6 @@ bool bpf_helper_changes_pkt_data(enum bpf_func_id f=
unc_id)
>  	case BPF_FUNC_xdp_adjust_head:
>  	case BPF_FUNC_xdp_adjust_meta:
>  	case BPF_FUNC_xdp_adjust_tail:
> -	/* tail-called program could call any of the above */
> -	case BPF_FUNC_tail_call:
>  		return true;
>  	default:
>  		return false;
> diff --git a/tools/testing/selftests/bpf/progs/verifier_sock.c b/tools/te=
sting/selftests/bpf/progs/verifier_sock.c
> index 2b4610b53382..3e22b4f8aec4 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_sock.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_sock.c
> @@ -1117,10 +1117,10 @@ int tail_call(struct __sk_buff *sk)
>  	return 0;
>  }
>
> -/* Tail calls invalidate packet pointers. */
> +/* Tail calls in sub-programs invalidate packet pointers. */
>  SEC("tc")
>  __failure __msg("invalid mem access")
> -int invalidate_pkt_pointers_by_tail_call(struct __sk_buff *sk)
> +int invalidate_pkt_pointers_by_indirect_tail_call(struct __sk_buff *sk)
>  {
>  	int *p =3D (void *)(long)sk->data;
>
> @@ -1131,4 +1131,18 @@ int invalidate_pkt_pointers_by_tail_call(struct __=
sk_buff *sk)
>  	return TCX_PASS;
>  }
>
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

