Return-Path: <bpf+bounces-51165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 514B8A312A3
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 18:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BADC3A834D
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 17:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D11262174;
	Tue, 11 Feb 2025 17:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvrtmoYZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3FC261362
	for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 17:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739294357; cv=none; b=Y8kX/Pkul6ByocUCa9RqP7y/be4lpr96kgeSim4ERbhJwFYPZO2VQqAIF8jeBVqKDEsxmO5niplRYZuj6bA17APYPTEqEx7Ncc8VNFFRB03yebU7VdqxE29KkSUlQRVwyWG/wySxn/BSKWF3typ7e3tW/3gBbzo+6XqAUM2mArg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739294357; c=relaxed/simple;
	bh=GFoLUeSJlbEkQoE3jeTDCejl8fjiMUnl4z5UC9GDpuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s8zkUGdyAzk4K8BNwv1bO3uKYwtosg+K8aSjLyKULsdCf9YYe37FwuZ/641+wiuC+pOSCujbGUtFRge/L/U+9nhVQOrZzdocW8v3wUOlbqY/q/YhbWBFhj/m7CFuoZOX4UrzYDeUlMXhuNfhkPsIBMvfd7gzTKB/YGpUANgoL18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvrtmoYZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBAFBC4CEE6
	for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 17:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739294356;
	bh=GFoLUeSJlbEkQoE3jeTDCejl8fjiMUnl4z5UC9GDpuk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UvrtmoYZuQeebEhNGiQcOe+8gTXFuwtpKOJKjXCZvRw2spYsW6i7c+S6zMwg3QyYc
	 gJkSMDmqEZ9fdcOUPo1V+LJqVYRvkM1o+ee37bUvNhBjwEl16RRX4F80l/z1gs2gC/
	 YmePe9fr0rlWBXbHHoFhPAFChvE//Sj09ckZSbNaBr4TeBO7Dsa3DJbEGcKwNIIM0S
	 nQosEiZkqFvuC9yG3gSIM13c0ZLzycaLDR1h5C3GyyFbsh8kLsRKnBxIJkHeDntmQP
	 X2vYHb8ToQeN2HbaMEL/awGSR2okUcE8+1fWsnH20ZjljspEN23PJ2IoiYppFqj7kK
	 Sv1L4OQf7jbIA==
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3cfeff44d94so16556315ab.0
        for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 09:19:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXLU37yiyzwnVpe6UB+yHF/CF8CYBIvn9jkCT72N4ZvHFD1+PtgMwYJ/djHi5iMpYhU+8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrK/C8JPErFK5iFQPb5nownK5aEU1h+6GejDN8IvU51aEmQD3x
	R3U4E03vTgkLbdM/myKbB5W3IWGdO0mFRl9+e1ONzaOiOw2P8Sde6rDkYTnV5R9ncy06CX2F8Ur
	VLU3AHyFCCkHnwiOD738Gyc3lpwI=
X-Google-Smtp-Source: AGHT+IHL9OgBhzFZS8kYdkOrjFtboY0/LqwWUVvvu/9Cg9JnpqoqE1iTpfMjFQkiR2zA52vL/QjkWM/3jtVHSYiPxhk=
X-Received: by 2002:a05:6e02:1fc9:b0:3d0:27f5:1b6c with SMTP id
 e9e14a558f8ab-3d17bfde870mr1980495ab.14.1739294355213; Tue, 11 Feb 2025
 09:19:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211023359.1570-1-laoar.shao@gmail.com> <20250211023359.1570-3-laoar.shao@gmail.com>
In-Reply-To: <20250211023359.1570-3-laoar.shao@gmail.com>
From: Song Liu <song@kernel.org>
Date: Tue, 11 Feb 2025 09:19:03 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5TRdcpy-br1n4esGAasM+=F58LJWJq=6gYGRMeSr=pdQ@mail.gmail.com>
X-Gm-Features: AWEUYZm-xJpwuPCd1IK9xZifot5j5hKLgh-yxvtmNl7-OiqCzuJXq6P1CUuoo5g
Message-ID: <CAPhsuW5TRdcpy-br1n4esGAasM+=F58LJWJq=6gYGRMeSr=pdQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Reject attaching fexit to functions
 annotated with __noreturn
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, jpoimboe@kernel.org, 
	peterz@infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 6:34=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> If we attach fexit to a function annotated with __noreturn, it will
> cause an issue that the bpf trampoline image will be left over even if
> the bpf link has been destroyed. Take attaching do_exit() for example. Th=
e
> fexit works as follows,
>
>   bpf_trampoline
>   + __bpf_tramp_enter
>     + percpu_ref_get(&tr->pcref);
>
>   + call do_exit()
>
>   + __bpf_tramp_exit
>     + percpu_ref_put(&tr->pcref);
>
> Since do_exit() never returns, the refcnt of the trampoline image is
> never decremented, preventing it from being freed. This can be verified
> with as follows,
>
>   $ bpftool link show                                   <<<< nothing outp=
ut
>   $ grep "bpf_trampoline_[0-9]" /proc/kallsyms
>   ffffffffc04cb000 t bpf_trampoline_6442526459    [bpf] <<<< leftover
>
> With this change, attaching fexit probes to functions like do_exit() will
> be rejected.
>
> $ ./fexit
> libbpf: prog 'fexit': BPF program load failed: -EINVAL
> libbpf: prog 'fexit': -- BEGIN PROG LOAD LOG --
> processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 pe=
ak_states 0 mark_read 0
> -- END PROG LOAD LOG --
> libbpf: prog 'fexit': failed to load: -EINVAL
> libbpf: failed to load object 'fexit_bpf'
> libbpf: failed to load BPF skeleton 'fexit_bpf': -EINVAL
> failed to load BPF object -22
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  kernel/bpf/verifier.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9971c03adfd5..f7224fc61e0c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -22841,6 +22841,13 @@ BTF_ID(func, __rcu_read_unlock)
>  #endif
>  BTF_SET_END(btf_id_deny)
>
> +/* The functions annotated with __noreturn are denied. */
> +BTF_SET_START(fexit_deny)
> +#define NORETURN(fn) BTF_ID(func, fn)
> +#include <linux/noreturns.h>
> +#undef NORETURN
> +BTF_SET_END(fexit_deny)
> +
>  static bool can_be_sleepable(struct bpf_prog *prog)
>  {
>         if (prog->type =3D=3D BPF_PROG_TYPE_TRACING) {
> @@ -22929,6 +22936,9 @@ static int check_attach_btf_id(struct bpf_verifie=
r_env *env)
>         } else if (prog->type =3D=3D BPF_PROG_TYPE_TRACING &&
>                    btf_id_set_contains(&btf_id_deny, btf_id)) {
>                 return -EINVAL;
> +       } else if (prog->expected_attach_type =3D=3D BPF_TRACE_FEXIT &&
> +                  btf_id_set_contains(&fexit_deny, btf_id)) {

Please add a verifier log (with verbose()) here, so that the user knows
why the program failed to attach.

Thanks,
Song

> +               return -EINVAL;
>         }
>
>         key =3D bpf_trampoline_compute_key(tgt_prog, prog->aux->attach_bt=
f, btf_id);
> --
> 2.43.5
>

