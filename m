Return-Path: <bpf+bounces-77085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 042FACCE196
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 01:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77501306E97D
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 00:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E284F217F29;
	Fri, 19 Dec 2025 00:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJp4BF6C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27E721018A
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 00:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766105747; cv=none; b=jadZZlAg7rTYjmeNFEYmtndE74LvBGoEoTTklLfMuAKSlG6MpaCma2iH5i5XGP2J7M187f9dEOjF7Nke+i+TDIUrVhTbO5B+hSaj6kYGAhFMLYnr1ye3j+2r/IYPlliFwHY5e+01Ygbg5ZOaxR+fD67yBQDpPody4xiCBIR09Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766105747; c=relaxed/simple;
	bh=P6PYzhg6YrCPfw9cAIWKUtyArqpaadWb2MQPkNH6Vw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=klDCa6lXL3n+7HuSddGYR0jK1cE+pe7ovdtdZUzWKKXY6xVXzFFYpOQwpW8dfYQbK4rw0RDloOqPVWeg85GK9bfIuZ+XBAihyijY2usNYsnmwkFvKcCMjjK5RvS9ZbXsJpPFeutPqaKi3nbZQ84dVx5iK1yruczodh8jcqw4YQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJp4BF6C; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34c2f335681so988447a91.1
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 16:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766105745; x=1766710545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdG1nX7VMlHMMa9d9DKmKoMzFrfMC4MWpL3TMsN/J2o=;
        b=jJp4BF6CtNNrl3F4hLthpChwnmemw6Ixm6N+F/KkinyjL9S1RMEPoCTDXAcYkMoupj
         oSKnmgh6o/Xi93zyeejwD9/B1/buB3EtbCNXtIjMzjsSvbYICM5DQeZUq5mLz9KNItQb
         yFb0AEAmr75Gqg3RaWgr6nkha4IGYLWMS0+FZ5dXAo12MnhCtKGI8mi80SalqtBeU/NC
         m9W3vcgU+WHReFB6Nt91h4cFzevwkwyJ1a8+pYJvwHG1F4IEJLMrBPzqvRWBML9iXkx3
         76c1WOxtmC7YCR1gq5fMt6QBDUrrWZTjYI2lZRF/r7BzCD3oz9fdl9q2mD6c/8KCWTnh
         8+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766105745; x=1766710545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AdG1nX7VMlHMMa9d9DKmKoMzFrfMC4MWpL3TMsN/J2o=;
        b=XZadT1OsMqqd/Cfe+myhJOtQXHPxj9849scJAKLNlVEd0nudWRYK/lcNtQJtFY6qkO
         GGmTtBg2aj0MfyrjD6CRmtjMWXAlBojyrnlQcjRlzdTWPf/h0IW8oTQ+3KR0ukIeidbD
         cB9gCopKBvrH2+3jSIKCqyDMqgzjoqgpIw+QLVsv7l7CzV9drTCTKlhAS90JnXOhcdPH
         lXenxRYGPbs5gBbQGwElXZOgqp9r9thCr1kXPy+FmGFO7Gc9HpO7Oyh55/wk3XMexHoH
         ZubGOk759Zp4KD9P9GRE1zPvjoYunIPmaitxuhi8dq6Lb7dzotsZdDvwGMKP6qfF3b+j
         T2eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUc/i7koDs/D34hOHXtVJQiXeZca8ZLRbLoM1cGl9+q2ktHEeq8VU1UgoziySM2H6iEkqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcjLzWOkwBWSHGbcIgJBU0eodTNMIoNDtWPrk9n37L2HhgYSXy
	YGuMxZX8n6qwfgHO2xf3N4b8Mkb3WJXJjINZ5Oa0OuAWzORs+sIkWP6SWmHzcgU+rLkcP2QB18x
	zPNnHBeiPSu6PqShrbaM4Nis1pU8ItaE=
X-Gm-Gg: AY/fxX5neWxS71X0yE5eVTBK1IGOC2L9dT41UYMiHGKBpSLrtZrNK+5BipnoKQ1wavD
	PF9By12qLZ2YFX9VjvI0oiLidLxrT3gjqn8JRXFzfXN+9yK1xng4ZFxHbiRbFhg3NAmO9i36EGs
	uIJvlCUpOAazPkykZa9bnEBePYMqPLDMuLoyOb90RDEdcIurBaUPV/cEb87k2DyKYarpahLXmEw
	tKhrHBD/PBMxXskTnNmCUxqtY4dzvdksdlkLLQFGzopL8n+8Ie9EPVNdSMlJRP1kcwo4n+jYe3X
	md55LkRsBtE3dQliBVCKJw==
X-Google-Smtp-Source: AGHT+IHxhURUh/lm9PTNJh1TUrL7sQpKkWRuIcwowgTnArIk5K2B1ioF2tYjdG6B7tSpLXh7fcp2kQJ3jg6F6BijbQ0=
X-Received: by 2002:a17:90b:548c:b0:32d:e07f:3236 with SMTP id
 98e67ed59e1d1-34e921be38bmr684514a91.22.1766105745016; Thu, 18 Dec 2025
 16:55:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217095445.218428-1-dongml2@chinatelecom.cn> <20251217095445.218428-2-dongml2@chinatelecom.cn>
In-Reply-To: <20251217095445.218428-2-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 18 Dec 2025 16:55:30 -0800
X-Gm-Features: AQt7F2o6xKYyL_pSmWgw4qhGxJaLbWlvkmQQCkZFN7HphiLnHwaqRvvpQJthUUw
Message-ID: <CAEf4BzY3=qjfX385teDBs7G4Ae8LqFKwX0qMmDnSkkLi5qiWBg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/9] bpf: add tracing session support
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 1:55=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> The tracing session is something that similar to kprobe session. It allow
> to attach a single BPF program to both the entry and the exit of the
> target functions.
>
> Introduce the struct bpf_fsession_link, which allows to add the link to
> both the fentry and fexit progs_hlist of the trampoline.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
> v4:
> - instead of adding a new hlist to progs_hlist in trampoline, add the bpf
>   program to both the fentry hlist and the fexit hlist.
> ---
>  include/linux/bpf.h                           | 20 +++++++++++
>  include/uapi/linux/bpf.h                      |  1 +
>  kernel/bpf/btf.c                              |  2 ++
>  kernel/bpf/syscall.c                          | 18 +++++++++-
>  kernel/bpf/trampoline.c                       | 36 +++++++++++++++----
>  kernel/bpf/verifier.c                         | 12 +++++--
>  net/bpf/test_run.c                            |  1 +
>  net/core/bpf_sk_storage.c                     |  1 +
>  tools/include/uapi/linux/bpf.h                |  1 +
>  .../bpf/prog_tests/tracing_failure.c          |  2 +-
>  10 files changed, 83 insertions(+), 11 deletions(-)
>

[...]

>  int bpf_prog_ctx_arg_info_init(struct bpf_prog *prog,
>                                const struct bpf_ctx_arg_aux *info, u32 cn=
t);
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 84ced3ed2d21..696a7d37db0e 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1145,6 +1145,7 @@ enum bpf_attach_type {
>         BPF_NETKIT_PEER,
>         BPF_TRACE_KPROBE_SESSION,
>         BPF_TRACE_UPROBE_SESSION,
> +       BPF_TRACE_SESSION,

FSESSION for consistency with FENTRY and FEXIT

>         __MAX_BPF_ATTACH_TYPE
>  };
>

[...]

>  {
> -       enum bpf_tramp_prog_type kind;
> -       struct bpf_tramp_link *link_exiting;
> +       enum bpf_tramp_prog_type kind, okind;
> +       struct bpf_tramp_link *link_existing;
> +       struct bpf_fsession_link *fslink;
>         int err =3D 0;
>         int cnt =3D 0, i;
>
> -       kind =3D bpf_attach_type_to_tramp(link->link.prog);
> +       okind =3D kind =3D bpf_attach_type_to_tramp(link->link.prog);
>         if (tr->extension_prog)
>                 /* cannot attach fentry/fexit if extension prog is attach=
ed.
>                  * cannot overwrite extension prog either.
> @@ -621,13 +624,18 @@ static int __bpf_trampoline_link_prog(struct bpf_tr=
amp_link *link,
>                                           BPF_MOD_JUMP, NULL,
>                                           link->link.prog->bpf_func);
>         }
> +       if (kind =3D=3D BPF_TRAMP_SESSION) {
> +               /* deal with fsession as fentry by default */
> +               kind =3D BPF_TRAMP_FENTRY;
> +               cnt++;
> +       }

this "pretend we are BPF_TRAMP_FENTRY" looks a bit hacky and is very
hard to follow. I think it would be cleaner to have explicit small
special cases for BPF_TRAMP_SESSION, and then generalize
hlist_for_each_entry case by using a local variable for storing
&tr->progs_hlist[kind] (which for TRAMP_SESSION you'll set to
&tr->progs_hlist[BPF_TRAMP_FENTRY]). You'll then just do extra
hlist_add_head/hlist_del_init and count manipulation. IMO, it's better
than keeping in head what kind and okind is...


>         if (cnt >=3D BPF_MAX_TRAMP_LINKS)
>                 return -E2BIG;
>         if (!hlist_unhashed(&link->tramp_hlist))
>                 /* prog already linked */
>                 return -EBUSY;
> -       hlist_for_each_entry(link_exiting, &tr->progs_hlist[kind], tramp_=
hlist) {
> -               if (link_exiting->link.prog !=3D link->link.prog)
> +       hlist_for_each_entry(link_existing, &tr->progs_hlist[kind], tramp=
_hlist) {
> +               if (link_existing->link.prog !=3D link->link.prog)
>                         continue;
>                 /* prog already linked */
>                 return -EBUSY;

[...]

> @@ -23298,6 +23299,7 @@ static int do_misc_fixups(struct bpf_verifier_env=
 *env)
>                 if (prog_type =3D=3D BPF_PROG_TYPE_TRACING &&
>                     insn->imm =3D=3D BPF_FUNC_get_func_ret) {
>                         if (eatype =3D=3D BPF_TRACE_FEXIT ||
> +                           eatype =3D=3D BPF_TRACE_SESSION ||
>                             eatype =3D=3D BPF_MODIFY_RETURN) {
>                                 /* Load nr_args from ctx - 8 */
>                                 insn_buf[0] =3D BPF_LDX_MEM(BPF_DW, BPF_R=
EG_0, BPF_REG_1, -8);
> @@ -24242,7 +24244,8 @@ int bpf_check_attach_target(struct bpf_verifier_l=
og *log,
>                 if (tgt_prog->type =3D=3D BPF_PROG_TYPE_TRACING &&
>                     prog_extension &&
>                     (tgt_prog->expected_attach_type =3D=3D BPF_TRACE_FENT=
RY ||
> -                    tgt_prog->expected_attach_type =3D=3D BPF_TRACE_FEXI=
T)) {
> +                    tgt_prog->expected_attach_type =3D=3D BPF_TRACE_FEXI=
T ||
> +                    tgt_prog->expected_attach_type =3D=3D BPF_TRACE_SESS=
ION)) {
>                         /* Program extensions can extend all program type=
s
>                          * except fentry/fexit. The reason is the followi=
ng.
>                          * The fentry/fexit programs are used for perform=
ance
> @@ -24257,7 +24260,7 @@ int bpf_check_attach_target(struct bpf_verifier_l=
og *log,
>                          * beyond reasonable stack size. Hence extending =
fentry
>                          * is not allowed.
>                          */
> -                       bpf_log(log, "Cannot extend fentry/fexit\n");
> +                       bpf_log(log, "Cannot extend fentry/fexit/session\=
n");

fsession?

>                         return -EINVAL;
>                 }
>         } else {
> @@ -24341,6 +24344,7 @@ int bpf_check_attach_target(struct bpf_verifier_l=
og *log,
>         case BPF_LSM_CGROUP:
>         case BPF_TRACE_FENTRY:
>         case BPF_TRACE_FEXIT:
> +       case BPF_TRACE_SESSION:
>                 if (!btf_type_is_func(t)) {
>                         bpf_log(log, "attach_btf_id %u is not a function\=
n",
>                                 btf_id);

[...]

