Return-Path: <bpf+bounces-77087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52752CCE1A8
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 01:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8CD830595B1
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 00:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B5C221275;
	Fri, 19 Dec 2025 00:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXxqKhix"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD99213E6A
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 00:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766105763; cv=none; b=P+tmEhV8jEr4TjpOQgZORiQKsK/c/5eaG2yfySvdcHIamy87jG4631pLZg+4xYQt1fv4f03nojVK53wsxOFrDyzrtlXOgom3rkQcGR+1GS/tL2kqcNlRAefd04LTtISi8vx1QbYXN1nVpPhU07mnOrbaQxvQgorWfhb1rIHivS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766105763; c=relaxed/simple;
	bh=8hBsrvdZSrQqBRlZ4yjLvmDqn8p6ddGv4PX2QkfkI1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AKOVbGnAzTPcvBMHvDAaCigvM01zExIlc2c8xo6DaSVVUhsYr8MJYWrhKxJX7a4w5kqIYk+oMQusEkq20tv03qVv72uW3OCTRQb1i6KGPKNPbcp7SVbEIt910KFigPdXPu72J37S2tyns6Zs9UixI5uGJOMBaqvnMDo6NodL/m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXxqKhix; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-34c2f52585fso1031993a91.1
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 16:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766105760; x=1766710560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yIJblLoluhSY45jC3GMQJxyhUMxz0c4b5BNsAEhHXU=;
        b=JXxqKhixs+dzPkgTlaFiOqImvIPtSiYmS74uQL6n1sVB9WMMNmmAgOqx+xd/XPSHIa
         O8wdTA0NWSKHVi+pQBy+hOYPCDTRyXT9ZlRQnHu3BNatf2d7jlRvea6HPz4Ubh+oxkg2
         255QOlaQzpP2WrH5TsP3t+Y5t8irhDgHVo5NvspTLlrGKpMjq47QzXwBghaDDSN9Y4Qq
         8vpMR6GHk+hsorRHqlbG/U201iXOvLQTB7XmFhETIi5+2F0LP/jlg8ewKeFexSt0IMF3
         TP2r26WAeNiZCiX8tJevCKZduQsSRKN5xGevkkvjs1T9W6+FToljTiFGpavHSlyqP/vM
         /VtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766105760; x=1766710560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+yIJblLoluhSY45jC3GMQJxyhUMxz0c4b5BNsAEhHXU=;
        b=PoUdb6a76+497qq79kMIGJxmHhI7V6b5qPMvQqPqiWRxQeh+VDmjcUDiOLrstr6z1w
         /bv1SpmKgwbv6UNXI7lB/3dd4dDNl+ty+6mS0e43Uv3FovQVNrV/HK4mcI/ax347AwCd
         sCyqnUCO5TfK1/lrMxyOhZevphtd5sGW7JXbzPE/65Ry29IuAdCqdDyjWO47Ind/isGB
         hCDe+iDo9bWK0uk47tf2jdVCdkPLlo8g0x8u5qHfqEwSe+yHrTKUFNAAVh376id1dvST
         TtUGBPjD+qX8jbTCNnLwvBkszp0zM410QswnpyPv5qY5MoMjrb8xXiy+uq7Kpa0yGJAZ
         r6Fw==
X-Forwarded-Encrypted: i=1; AJvYcCU/+w9LO3rlvSAmivmMtRVSP5RSsGxeozJp0D87l1CisZO4Nb8BHemejgG/V2h0YIyNI4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyKhHSM4phY4cKCVJyxAxcF+sG3mWWWLC0Tj6YfvmSBU8FKLeV
	mbwH9rET3TX2T3kGf3iy6dBDjkR3KDoWvnuAQU592NG22tvdtwED0MVhZDiH0jhpdur38s5tU9m
	mzT7mo8iJmECzJ9IRhuOW0vjXhThvBJU=
X-Gm-Gg: AY/fxX4JMhIKKThx8Ofudh2dLEZzBgp7wnZQ7stNcHD/P2hBaa+k416o8/TTsZ5YGrZ
	i8n2s6U3egtmsVh/l81XcrHgqaoYB/V7Y5juJCyb18j338bSBxL5q6qJJNAtpieCRB9HbBGRWmr
	0lk0sszUgb4koh9BMUQb3rZzHQ8qcCIsuPoMsUFTRxbB1EjQkJ787OW7onTu1oPkJ9THfaoRsOn
	ZHi33vauthSi15XzAP8lYXepp1z50iE5bPbgfFzw+cOxMB8nMfzWXl+xUS7rPPN/IpRThcPsqft
	Kj8fBabuy+U=
X-Google-Smtp-Source: AGHT+IGrEwacY10ytywyxZVCNQW/JlZX/1UWpJTfnytBn3WXImL5b2tIpMuIF01pbwm94/wfQ+AU18Wta7m9yI+FNqw=
X-Received: by 2002:a17:90b:2d81:b0:334:cb89:bde6 with SMTP id
 98e67ed59e1d1-34e9212a469mr930884a91.4.1766105759804; Thu, 18 Dec 2025
 16:55:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217095445.218428-1-dongml2@chinatelecom.cn> <20251217095445.218428-7-dongml2@chinatelecom.cn>
In-Reply-To: <20251217095445.218428-7-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 18 Dec 2025 16:55:46 -0800
X-Gm-Features: AQt7F2o1STOxSnmXOLaFD08IS8Zfbat-UgT7sWHW_o3Op_DT7d0Cj7paD8b6JyM
Message-ID: <CAEf4BzZOfB310d4_1eznUgkGwK5cwhZSEgc9SANJskCbctDoMQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 6/9] bpf,x86: add tracing session supporting
 for x86_64
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
> Add BPF_TRACE_SESSION supporting to x86_64, including:
>
> 1. clear the return value in the stack before fentry to make the fentry
>    of the fsession can only get 0 with bpf_get_func_ret(). If we can limi=
t
>    that bpf_get_func_ret() can only be used in the
>    "bpf_fsession_is_return() =3D=3D true" code path, we don't need do thi=
s
>    thing anymore.

What does bpf_get_func_ret() return today for fentry? zero or just
random garbage? If the latter, we can keep the same semantics for
fsession on entry. Ultimately, result of bpf_get_func_ret() is
meaningless outside of fexit/session-exit

>
> 2. clear all the session cookies' value in the stack. If we can make sure
>    that the reading to session cookie can only be done after initialize i=
n
>    the verifier, we don't need this anymore.
>
> 2. store the index of the cookie to ctx[-1] before the calling to fsessio=
n
>
> 3. store the "is_return" flag to ctx[-1] before the calling to fexit of
>    the fsession.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
> v4:
> - some adjustment to the 1st patch, such as we get the fsession prog from
>   fentry and fexit hlist
> - remove the supporting of skipping fexit with fentry return non-zero
>
> v2:
> - add session cookie support
> - add the session stuff after return value, instead of before nr_args
> ---
>  arch/x86/net/bpf_jit_comp.c | 36 +++++++++++++++++++++++++++++++-----
>  1 file changed, 31 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 8cbeefb26192..99b0223374bd 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -3086,12 +3086,17 @@ static int emit_cond_near_jump(u8 **pprog, void *=
func, void *ip, u8 jmp_cond)
>  static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
>                       struct bpf_tramp_links *tl, int stack_size,
>                       int run_ctx_off, bool save_ret,
> -                     void *image, void *rw_image)
> +                     void *image, void *rw_image, u64 nr_regs)
>  {
>         int i;
>         u8 *prog =3D *pprog;
>
>         for (i =3D 0; i < tl->nr_links; i++) {
> +               if (tl->links[i]->link.prog->call_session_cookie) {
> +                       /* 'stack_size + 8' is the offset of nr_regs in s=
tack */
> +                       emit_st_r0_imm64(&prog, nr_regs, stack_size + 8);
> +                       nr_regs -=3D (1 << BPF_TRAMP_M_COOKIE);

you have to rename nr_regs to something more meaningful because it's
so weird to see some bit manipulations with *number of arguments*

> +               }
>                 if (invoke_bpf_prog(m, &prog, tl->links[i], stack_size,
>                                     run_ctx_off, save_ret, image, rw_imag=
e))
>                         return -EINVAL;
> @@ -3208,8 +3213,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im, void *rw_im
>                                          struct bpf_tramp_links *tlinks,
>                                          void *func_addr)
>  {
> -       int i, ret, nr_regs =3D m->nr_args, stack_size =3D 0;
> -       int regs_off, nregs_off, ip_off, run_ctx_off, arg_stack_off, rbx_=
off;
> +       int i, ret, nr_regs =3D m->nr_args, cookie_cnt, stack_size =3D 0;
> +       int regs_off, nregs_off, ip_off, run_ctx_off, arg_stack_off, rbx_=
off,
> +           cookie_off;

if it doesn't fit on a single line, just `int cookie_off;` on a
separate line, why wrap the line?

>         struct bpf_tramp_links *fentry =3D &tlinks[BPF_TRAMP_FENTRY];
>         struct bpf_tramp_links *fexit =3D &tlinks[BPF_TRAMP_FEXIT];
>         struct bpf_tramp_links *fmod_ret =3D &tlinks[BPF_TRAMP_MODIFY_RET=
URN];

[...]

