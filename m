Return-Path: <bpf+bounces-78802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67193D1BEEC
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 02:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6782F30281B0
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 01:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6385929DB99;
	Wed, 14 Jan 2026 01:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nlb2G5p6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A2B11CBA
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 01:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768353968; cv=none; b=YweMyE+L3kHLZ++kj16hzt7fLsHLBqcdNNG3W9JQnczGlyyLC/WCWs70PSIyO6Ijj91eN/3aAUTz41VnsqgsK7uoO09mi29jZUMVdowg3yXls+uoqkIBx64bkBPNt+Gfc6t29jJOkaXSw1KIqF8doj6hYELSMcxTRvDljmhTXCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768353968; c=relaxed/simple;
	bh=dxUb8+0bZwP1bzR1lehEpcpYm/HLm7LH2EQBZDHa1+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o9VpinwlklqTraxpwYKT6sjsej88+ZQtvKdlu1X0ApcwZva76gRclf6PSTmiqsVDiR9kfIZ5UtUpzyUD9p4OHsrM5iXqpJfcRVSywvYLTx21UJgfGRG3D6hdL9ng2q8igcCep1n+ytZ0mg3IHSbgJceKJvFWWtLGEaUWpHBEdP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nlb2G5p6; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34c93e0269cso262217a91.1
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 17:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768353967; x=1768958767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Dw+Re/7i5/mvsY6I7BPcHcvpWgjqO8gIzVCTTYcB80=;
        b=Nlb2G5p6NnJb5V+A5WjBOTkY34QH0SqpKju8IxEnw1+MdxkK46qEKYH0/VbzEa/Pt7
         kI7xK+Za/cJxcoySs3dJtAq6xI7//jsLfm7Ac2fFgmy6yJ9mJnb/t97SXnvkkI/z4p+y
         tL31ZA/hlXZVj/uOIi6Wey6B9wESwDNOK7vNEkg8kwPdVJpIyHX+l8+8Ct3LBWDJlXKn
         4ugLJuEW4L8qb2vrUSQNa5vYAnmWNrDBiLfk8dwj0LUipSuSmV5g77jL9WAWyy+nF6I4
         jAQX+Q+0m3vG0ik5miKPrP5nfYuBDl8kTYSqCxbLsq0400U57W+NudFoWpK9dSrNItzK
         TNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768353967; x=1768958767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Dw+Re/7i5/mvsY6I7BPcHcvpWgjqO8gIzVCTTYcB80=;
        b=lLCWbiBTOI/ZOEoOsyDnW9oGM/pBcbrOVPEDBhExqrrCBOR/OukUK1AwjIA4Q4tWQA
         KcR19xeB3xVr3q5UXXikYFSnRJ5Nh96t9toj0wIMcCC1SwDuxiCesMoegLocAa+mYYKg
         T+dUdt1wSQ4YOCodwi/Yz8rPFS5D9Hqb36ETZMI88HCjuZAbg6iYk08/hSCX0DPRifLQ
         mzbj9ikiexr/qGPwtvUCMdY2EzRq1mE2LDeadbEOKTbpPFKGymlUDgaqI/Sugk+HPRv+
         o0BtqQ3srS9U43W5+MBTOg3e6tQxveKqzHuP2s5Tnx5ALiCKOTJ+1AtlQzo3yw0H5+m5
         nAXA==
X-Forwarded-Encrypted: i=1; AJvYcCXxchL/yRxoLVPUjg/MICZwGw5rnOhQzAVJ9MzKgcwG4jSng6ywyBc1E791/LQ3yfqxL4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjqto+stR5tION4kNUzCzAYX+xhCidwp0wPmVI1bt8UkweLnmu
	JCNpLUHtb6ABBXAnWJyTwLWfoR+dEBhrfjM1zXjwvIirpTxjB+tFgR8MZcZapF6/QeYy9baK6iy
	j6dVeqtaeUr+fLZ40eBaaLFHb9tqL5j8=
X-Gm-Gg: AY/fxX5HnwKY2NSehevyNO+PZ+ZBwW8dPNpNt9GSh7O0jaa0f6xqDMU1f4vCTVYNwSh
	OHvUWuToL78qruCjkttzLstRhNcN6QA4HHWc9bZ5R/O35GbyyAjMolA3i8HJ5bKuvDlFa9KoRM3
	BpCE0I+RIvPH4BCxQMeVShBdE5QWJMQ7ZGuopY218SIH5fusA9KZOXLvfQrpaLg6O79nHCVwvbW
	lMPHrxd/tHYu2f8aA6ziYKN16fmlEaRnKXDzG8pDRrwI6oKUD808Y4ZpoOwYjLpG4JtwIu51HRv
	FVSoWa8UH2o=
X-Received: by 2002:a17:90b:5630:b0:34e:6e7d:7e73 with SMTP id
 98e67ed59e1d1-350fd17069amr4487026a91.11.1768353966899; Tue, 13 Jan 2026
 17:26:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110141115.537055-1-dongml2@chinatelecom.cn> <20260110141115.537055-8-dongml2@chinatelecom.cn>
In-Reply-To: <20260110141115.537055-8-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 Jan 2026 17:25:54 -0800
X-Gm-Features: AZwV_QiLLfmArPearnIROrWGjPzDsOJTkDcVeG08K-41K-lO77Ev2Sev_X2bLCM
Message-ID: <CAEf4BzYE0ZTrCaruJSr8MXAbZSsKz8H_BqHoZX5kS63yRBa-2g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 07/11] bpf,x86: add fsession support for x86_64
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	jiang.biao@linux.dev, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, hpa@zytor.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2026 at 6:12=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> Add BPF_TRACE_FSESSION supporting to x86_64, including:
>
> 1. clear the return value in the stack before fentry to make the fentry
>    of the fsession can only get 0 with bpf_get_func_ret().
>
> 2. clear all the session cookies' value in the stack.
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
> v5:
> - add the variable "func_meta"
> - define cookie_off in a new line
>
> v4:
> - some adjustment to the 1st patch, such as we get the fsession prog from
>   fentry and fexit hlist
> - remove the supporting of skipping fexit with fentry return non-zero
>
> v2:
> - add session cookie support
> - add the session stuff after return value, instead of before nr_args
> ---
>  arch/x86/net/bpf_jit_comp.c | 33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index d94f7038c441..0671a434c00d 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -3094,12 +3094,17 @@ static int emit_cond_near_jump(u8 **pprog, void *=
func, void *ip, u8 jmp_cond)
>  static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
>                       struct bpf_tramp_links *tl, int stack_size,
>                       int run_ctx_off, bool save_ret,
> -                     void *image, void *rw_image)
> +                     void *image, void *rw_image, u64 func_meta)
>  {
>         int i;
>         u8 *prog =3D *pprog;
>
>         for (i =3D 0; i < tl->nr_links; i++) {
> +               if (tl->links[i]->link.prog->call_session_cookie) {
> +                       /* 'stack_size + 8' is the offset of func_md in s=
tack */

not func_md, don't invent new names, "func_meta" (but it's also so
backwards that you have stack offsets as positive... and it's not even
in verifier's stack slots, just bytes... very confusing to me)

> +                       emit_store_stack_imm64(&prog, stack_size + 8, fun=
c_meta);
> +                       func_meta -=3D (1 << BPF_TRAMP_M_COOKIE);

was this supposed to be BPF_TRAMP_M_IS_RETURN?... and why didn't AI catch t=
his?

> +               }
>                 if (invoke_bpf_prog(m, &prog, tl->links[i], stack_size,
>                                     run_ctx_off, save_ret, image, rw_imag=
e))
>                         return -EINVAL;
> @@ -3222,7 +3227,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im, void *rw_im
>         struct bpf_tramp_links *fexit =3D &tlinks[BPF_TRAMP_FEXIT];
>         struct bpf_tramp_links *fmod_ret =3D &tlinks[BPF_TRAMP_MODIFY_RET=
URN];
>         void *orig_call =3D func_addr;
> +       int cookie_off, cookie_cnt;
>         u8 **branches =3D NULL;
> +       u64 func_meta;
>         u8 *prog;
>         bool save_ret;
>
> @@ -3290,6 +3297,11 @@ static int __arch_prepare_bpf_trampoline(struct bp=
f_tramp_image *im, void *rw_im
>
>         ip_off =3D stack_size;
>
> +       cookie_cnt =3D bpf_fsession_cookie_cnt(tlinks);
> +       /* room for session cookies */
> +       stack_size +=3D cookie_cnt * 8;
> +       cookie_off =3D stack_size;
> +
>         stack_size +=3D 8;
>         rbx_off =3D stack_size;
>
> @@ -3383,9 +3395,19 @@ static int __arch_prepare_bpf_trampoline(struct bp=
f_tramp_image *im, void *rw_im
>                 }
>         }
>
> +       if (bpf_fsession_cnt(tlinks)) {
> +               /* clear all the session cookies' value */
> +               for (int i =3D 0; i < cookie_cnt; i++)
> +                       emit_store_stack_imm64(&prog, cookie_off - 8 * i,=
 0);
> +               /* clear the return value to make sure fentry always get =
0 */
> +               emit_store_stack_imm64(&prog, 8, 0);
> +       }
> +       func_meta =3D nr_regs + (((cookie_off - regs_off) / 8) << BPF_TRA=
MP_M_COOKIE);

func_meta conceptually is a collection of bit fields, so using +/-
feels weird, use | and &, more in line with working with bits?

(also you defined that BPF_TRAMP_M_NR_ARGS but you are not using it
consistently...)




> +
>         if (fentry->nr_links) {
>                 if (invoke_bpf(m, &prog, fentry, regs_off, run_ctx_off,
> -                              flags & BPF_TRAMP_F_RET_FENTRY_RET, image,=
 rw_image))
> +                              flags & BPF_TRAMP_F_RET_FENTRY_RET, image,=
 rw_image,
> +                              func_meta))
>                         return -EINVAL;
>         }
>
> @@ -3445,9 +3467,14 @@ static int __arch_prepare_bpf_trampoline(struct bp=
f_tramp_image *im, void *rw_im
>                 }
>         }
>
> +       /* set the "is_return" flag for fsession */
> +       func_meta +=3D (1 << BPF_TRAMP_M_IS_RETURN);
> +       if (bpf_fsession_cnt(tlinks))
> +               emit_store_stack_imm64(&prog, nregs_off, func_meta);
> +
>         if (fexit->nr_links) {
>                 if (invoke_bpf(m, &prog, fexit, regs_off, run_ctx_off,
> -                              false, image, rw_image)) {
> +                              false, image, rw_image, func_meta)) {
>                         ret =3D -EINVAL;
>                         goto cleanup;
>                 }
> --
> 2.52.0
>

