Return-Path: <bpf+bounces-43780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6189B9912
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 20:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15ADCB20F1E
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 19:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796A21D433C;
	Fri,  1 Nov 2024 19:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCc0eynP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426BE1D1753
	for <bpf@vger.kernel.org>; Fri,  1 Nov 2024 19:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730490945; cv=none; b=eOfhDXaSSsSMyi0N5zg7QNygcz8OknKN+PWFpTHtIUqBi92NpoN2QwiYsH94Q2nH3wuz7yLp8w0uOsJmVJ4LilFK5Zg/9Czntrk4H1Ik6OkpO7pOlAkZ6Rgz+oWL6vR8NaNP74g0LKc7Kx2rUh6wet8dOhbN3joybRAs+wpPY+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730490945; c=relaxed/simple;
	bh=hgpaFRY/E1MMh/pW8+/xqpn3fXz+hzAE+IMwJtxBcs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ci2TiLlDRja+64rMkpleXOLZn5krR8SP53gTk4w+NHRg8KbYuPQpv5eqrA6ojTq8Dgfm0QelAOvsHhK3grOn1PmzvIpQd+qjxWnGgO324J5ibDdDRgC446bxMkf7/jERh2RfRoTdnX6OCECt0pdW7xZUL3adEnOghunvMUtpJW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCc0eynP; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43169902057so18071975e9.0
        for <bpf@vger.kernel.org>; Fri, 01 Nov 2024 12:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730490941; x=1731095741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QryGB3pmxvABA696HiXMHOkPY3pe+9Z1UHWfIdxQHro=;
        b=bCc0eynPjHHQDDuQXoYiz61NjKvmXsM+1453IaLcTV9KRNlwWh7NQtOFGMxUFca5kI
         ui2MzKM50u3dr2jP7vEY/EbJoPI55jMN4mj0h5gDSW7JU7TphysqdT/pN/OLThD33qDW
         sE76p+IQcI1gIUYdpfGlVmFDNQ5HiHbHhu+HzW1fqce12siQIv6FNGbvPC+ol24HnhCE
         IDaI4wgBq/OQ7e/hEvju2K59AHC1PfHz0R/DIMBaYzDdrwInUeerGF8QZMGVrR3xmktP
         TtfUGQshH98OCcEA+Fpy93clgu3snM9ry0MJS3ob3nbnE79N7ULtpUL+jwggtblli2N7
         ZxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730490941; x=1731095741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QryGB3pmxvABA696HiXMHOkPY3pe+9Z1UHWfIdxQHro=;
        b=pEBsSTg/LBwnJjNhgJEHYHO/+QBOMNWDfxCUH50P0jrKTLp3RlWVWqGkAMj/GlQ/j9
         vr2YUesd7LxuWt6n0FTzsd3WdDOuiNUr5KAtB98SLZcaJkvb6fUAK2AtlQ0c3Y1xyq7H
         a0oBNUPgN884wNF6J0vFB+SUmODFHmibQ7l+Wtphb13Tvc+yWmUt0RJtxObKyjBIt2RW
         +cktAbaPlzltBuwqXbOCLDC2eUOeqpGepc6NF+2DS3Z8Ca4GVtfLtwH6/1PEO8EHPa9k
         b2h2slGSnn0Zfe32vWObqxHD3zXx9tXAssgsmhq+C7RaQlMgQ7nhDlaU7LVoauzHyi8b
         691g==
X-Gm-Message-State: AOJu0Yw3u+afl/hT6KR75RZqx5TQQIB5Xc0//feB0N5JUZysmk5GEUID
	bTFkZ715dtaR1BZforcTtqylqZS+pS7FPcIWJbBUm22Es7KTtTkRHQC7+9A6R2A47FhIGq0G619
	HPKLwhr50zQX6w+nMyqW1aCcdd84=
X-Google-Smtp-Source: AGHT+IEEsWhDeHRjlgpv1v4/EBkuMqu1rlh8W4uv24n8c6TULjPj3JePVCwAYbIaPbyprbfIDkXAA4VMzhZDsgVMOhU=
X-Received: by 2002:a05:6000:1b08:b0:378:89be:1825 with SMTP id
 ffacd0b85a97d-381b710fbb0mr7868597f8f.49.1730490941212; Fri, 01 Nov 2024
 12:55:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101030950.2677215-1-yonghong.song@linux.dev> <20241101031006.2678685-1-yonghong.song@linux.dev>
In-Reply-To: <20241101031006.2678685-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 1 Nov 2024 12:55:29 -0700
Message-ID: <CAADnVQ+r2zxVmXOwQHPZjTjRS1FhUycnMufKf1KvrhxH40REtg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 3/9] bpf: Check potential private stack
 recursion for progs with async callback
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 8:12=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> In previous patch, tracing progs are enabled for private stack since
> recursion checking ensures there exists no nested same bpf prog run on
> the same cpu.
>
> But it is still possible for nested bpf subprog run on the same cpu
> if the same subprog is called in both main prog and async callback,
> or in different async callbacks. For example,
>   main_prog
>    bpf_timer_set_callback(timer, timer_cb);
>    call sub1
>   sub1
>    ...
>   time_cb
>    call sub1
>
> In the above case, nested subprog run for sub1 is possible with one in
> process context and the other in softirq context. If this is the case,
> the verifier will disable private stack for this bpf prog.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  kernel/bpf/verifier.c | 46 ++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 41 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d3f4cbab97bc..596afd29f088 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6070,7 +6070,8 @@ static int round_up_stack_depth(struct bpf_verifier=
_env *env, int stack_depth)
>   */
>  static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, i=
nt idx,
>                                          int *subtree_depth, int *depth_f=
rame,
> -                                        int priv_stack_supported)
> +                                        int priv_stack_supported,
> +                                        char *subprog_visited)
>  {
>         struct bpf_subprog_info *subprog =3D env->subprog_info;
>         struct bpf_insn *insn =3D env->prog->insnsi;
> @@ -6120,8 +6121,12 @@ static int check_max_stack_depth_subprog(struct bp=
f_verifier_env *env, int idx,
>                                         idx, subprog_depth);
>                                 return -EACCES;
>                         }
> -                       if (subprog_depth >=3D BPF_PRIV_STACK_MIN_SIZE)
> +                       if (subprog_depth >=3D BPF_PRIV_STACK_MIN_SIZE) {
>                                 subprog[idx].use_priv_stack =3D true;
> +                               subprog_visited[idx] =3D 1;
> +                       }
> +               } else {
> +                       subprog_visited[idx] =3D 1;
>                 }
>         }
>  continue_func:
> @@ -6222,19 +6227,42 @@ static int check_max_stack_depth_subprog(struct b=
pf_verifier_env *env, int idx,
>  static int check_max_stack_depth(struct bpf_verifier_env *env)
>  {
>         struct bpf_subprog_info *si =3D env->subprog_info;
> +       char *subprogs1 =3D NULL, *subprogs2 =3D NULL;
>         int ret, subtree_depth =3D 0, depth_frame;
> +       int orig_priv_stack_supported;
>         int priv_stack_supported;
>
>         priv_stack_supported =3D bpf_enable_priv_stack(env);
>         if (priv_stack_supported < 0)
>                 return priv_stack_supported;
>
> +       orig_priv_stack_supported =3D priv_stack_supported;
> +       if (orig_priv_stack_supported !=3D NO_PRIV_STACK) {
> +               subprogs1 =3D kvmalloc(env->subprog_cnt * 2, __GFP_ZERO);

Just __GFP_ZERO ?!

Overall the algo is messy. Pls think of a cleaner way of checking.
Add two bool flags to bpf_subprog_info:
visited_with_priv_stack
visited_without_priv_stack
and after walking all subrpogs add another loop over subprogs
that checks for exclusivity of these flags?

Probably other algos are possible.

> +               if (!subprogs1)
> +                       priv_stack_supported =3D NO_PRIV_STACK;
> +               else
> +                       subprogs2 =3D subprogs1 + env->subprog_cnt;
> +       }
> +
>         for (int i =3D 0; i < env->subprog_cnt; i++) {
>                 if (!i || si[i].is_async_cb) {
>                         ret =3D check_max_stack_depth_subprog(env, i, &su=
btree_depth, &depth_frame,
> -                                                           priv_stack_su=
pported);
> +                                                           priv_stack_su=
pported, subprogs2);
>                         if (ret < 0)
> -                               return ret;
> +                               goto out;
> +
> +                       if (priv_stack_supported !=3D NO_PRIV_STACK) {
> +                               for (int j =3D 0; j < env->subprog_cnt; j=
++) {
> +                                       if (subprogs1[j] && subprogs2[j])=
 {
> +                                               priv_stack_supported =3D =
NO_PRIV_STACK;
> +                                               break;
> +                                       }
> +                                       subprogs1[j] |=3D subprogs2[j];
> +                               }
> +                       }
> +                       if (priv_stack_supported !=3D NO_PRIV_STACK)
> +                               memset(subprogs2, 0, env->subprog_cnt);
>                 }
>         }
>         if (priv_stack_supported =3D=3D NO_PRIV_STACK) {
> @@ -6243,10 +6271,18 @@ static int check_max_stack_depth(struct bpf_verif=
ier_env *env)
>                                 depth_frame, subtree_depth);
>                         return -EACCES;
>                 }
> +               if (orig_priv_stack_supported =3D=3D PRIV_STACK_ADAPTIVE)=
 {
> +                       for (int i =3D 0; i < env->subprog_cnt; i++)
> +                               si[i].use_priv_stack =3D false;
> +               }
>         }
>         if (si[0].use_priv_stack)
>                 env->prog->aux->use_priv_stack =3D true;
> -       return 0;
> +       ret =3D 0;
> +
> +out:
> +       kvfree(subprogs1);
> +       return ret;
>  }
>
>  #ifndef CONFIG_BPF_JIT_ALWAYS_ON
> --
> 2.43.5
>

