Return-Path: <bpf+bounces-70329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 79057BB7E43
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 20:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 291714E375F
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 18:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED662DA750;
	Fri,  3 Oct 2025 18:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIazYUrr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245B91F0991
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 18:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759516737; cv=none; b=mryq8k+f51bOS9BgJuySEMyUaf7YDMmaQCMeLF0F5yGRT2Th+YgMU1EHNlJINi5414d70UrPO0oMScafbzQkSkyeA9YJNvgOvQ5btXh9bj4thW85rbAWgMSdg6JwN0Azfvw7P4mY80rauanBq8O6yyOK100bkF04vg9fPyzemkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759516737; c=relaxed/simple;
	bh=/VNNcKduapbgSNGY5u9u7EVBbrgcJ9nGjAStpdzE5F4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VmipWTcECXmMSnhY52Ge2e2uZPL9D61A7zCYdW1MtKfEd/VNGCnBqm12DJ6RmvkJZ/0CJCgVHk5xmv3nQasvFb+IhpUuirjSwQo1KjRpkC9LmGwFHevukyJaI/kYGtwCWcy0C2odR+1jJvjfc+mU+C6Vrl9ro8yoElSTzSoEvyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIazYUrr; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-28832ad6f64so30634095ad.1
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 11:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759516734; x=1760121534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6Ur6zVZ/fYynGVHZXez85LnNPC6dAXtC+tyGQ/82Gc=;
        b=nIazYUrr59OwcfWP8DlKhrm5NKa/3z4UywwT7T7VG6qs+nFw0R8MuzhzllQ4HPOLFU
         zsB4F63S/hlDA8qOzQjYUUVsEEd6YkxbjG54d+5M4hu4HVT8GN54B+3dUV1jwYcROYwE
         LJCpDZzICMRpD8a7EPItAkyoMLqX9YCwbuw/rX1ROWsUuwMVp/+2AeKKacY0jF5YY8Fs
         nRC79k0MNNKURWc+VSguX8SdLlOe2s9bRTeKVgG4n/SwCtkUmNcxe9H1jBNn3vOXJVDF
         AM4p2o6od9wpZayCHITvy+EOpHx/Fc6bTJylX1tqgv9e1biOrCS+oRtgT7qjQXqywD0J
         h1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759516734; x=1760121534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z6Ur6zVZ/fYynGVHZXez85LnNPC6dAXtC+tyGQ/82Gc=;
        b=NQ4cQgLeAcfpcM9SpJM+KuPKzVqe15WmUWVGq94ff4mgx0uwzw+GJL+hD8vBryB5t9
         8tEsFdxv0dkH3uh29NpDSNn/cOqODNAR0i5uRrwEnQtmOLRoFXKfz+YGPXsBu6ig+TeM
         B1wYpS584HmEDQ9mDhjP+pJmmCDh2Rl5t60W3XZdqvpjXEttkHg6lOVI7zaOpmV2dImP
         z9uaP8VzHymN4MljGOKLyRUnK6nruZZ/xe260W1H6tHxvRIORwmu4Hig35lJP3dAYfsb
         cQDcJkz1jhfScVhgZuY0JSMM7CQmIwsx15NjL/54GnJCRCKKJAAHRACGrAps1hvS+J69
         C6wA==
X-Gm-Message-State: AOJu0YxprmKnOqMXgsPzuiFI+bPcVTsrCtFzD5by4NALwKSvnNQmf+i9
	Wm+kVkJhXbxnl37mKk27zILzfYAcrszTloqgudUhRCqjNPCOEYHigp0P/KXgw6jjo++rVk28luH
	5P7VnmR2jb3DY1Smvb53YqS6tH8Z9SlQ=
X-Gm-Gg: ASbGncu2ReiCBXedF37nhomSb8S//Cza/SLV0lgXw8EfkRmdgKtGHcoQV5P9f3Hugrz
	+8f1oNy18dfdZclswLB9LKnwtrrokkzpA63T0L5T5VdQjJUDkHCIDm6NWXRPW3QJxFMrfMR6AcG
	wXX1yiXQLsTAdU4UwllDSOmUadpoZAzvT/voEibEmL7OYceuThoU3XYe5+43VHKNKIMDKm3wgSj
	qU02kN8t4ZSYp+uOp/9W6zwps2ykJ0Ew5+Vqr6cM9NMvCM=
X-Google-Smtp-Source: AGHT+IEWHKl4GxQGAVfmS0+gtm95NW8BAvNxuIjpODnrZdIyOEYlnHezwvNl8jMohrBdTbkYMXCWRakTn3r/ltGPnmU=
X-Received: by 2002:a17:903:1a4c:b0:263:3e96:8c1b with SMTP id
 d9443c01a7336-28e9a61aba5mr43331485ad.33.1759516733743; Fri, 03 Oct 2025
 11:38:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com> <20251003160416.585080-7-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20251003160416.585080-7-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 3 Oct 2025 11:38:39 -0700
X-Gm-Features: AS18NWDBMvgCu1ruaXbcLPseK2G10harWSbDsi9oBENGQfcJd1sYR3Cf-hEJ_LE
Message-ID: <CAEf4BzY4nHek8Bm2G-4xQ9FTK-Ge5b-B0-w2PiZMxLKLTn_T-w@mail.gmail.com>
Subject: Re: [RFC PATCH v1 06/10] bpf: add plumbing for file-backed dynptr
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 9:04=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Add the necessary verifier plumbing for the new file-backed dynptr type.
> Introduce two kfuncs for its lifecycle management:
>  * bpf_dynptr_from_file() for initialization
>  * bpf_dynptr_file_discard() for destruction
>
> Currently there is no mechanism for kfunc to release dynptr, this patch
> add one:
>  * Introduce is_dynptr_release_arg() to tell if given dynptr argument
>  should be released
>  * Set meta->release_regno and regs[regno].ref_obj_id to make release
>  happen
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  include/linux/bpf.h   |  7 ++++++-
>  kernel/bpf/helpers.c  | 12 ++++++++++++
>  kernel/bpf/log.c      |  2 ++
>  kernel/bpf/verifier.c | 22 ++++++++++++++++++++--
>  4 files changed, 40 insertions(+), 3 deletions(-)
>

[...]

>  static void __mark_dynptr_reg(struct bpf_reg_state *reg,
> @@ -12258,6 +12262,8 @@ enum special_kfunc_type {
>         KF_bpf_res_spin_unlock,
>         KF_bpf_res_spin_lock_irqsave,
>         KF_bpf_res_spin_unlock_irqrestore,
> +       KF_bpf_dynptr_from_file,
> +       KF_bpf_dynptr_file_discard,
>         KF___bpf_trap,
>         KF_bpf_task_work_schedule_signal,
>         KF_bpf_task_work_schedule_resume,
> @@ -12330,6 +12336,8 @@ BTF_ID(func, bpf_res_spin_lock)
>  BTF_ID(func, bpf_res_spin_unlock)
>  BTF_ID(func, bpf_res_spin_lock_irqsave)
>  BTF_ID(func, bpf_res_spin_unlock_irqrestore)
> +BTF_ID(func, bpf_dynptr_from_file)

KF_TRUSTED for that file reference?


> +BTF_ID(func, bpf_dynptr_file_discard)
>  BTF_ID(func, __bpf_trap)
>  BTF_ID(func, bpf_task_work_schedule_signal)
>  BTF_ID(func, bpf_task_work_schedule_resume)
> @@ -13293,6 +13301,11 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
>                                 dynptr_arg_type |=3D DYNPTR_TYPE_XDP;
>                         } else if (meta->func_id =3D=3D special_kfunc_lis=
t[KF_bpf_dynptr_from_skb_meta]) {
>                                 dynptr_arg_type |=3D DYNPTR_TYPE_SKB_META=
;
> +                       } else if (meta->func_id =3D=3D special_kfunc_lis=
t[KF_bpf_dynptr_from_file]) {
> +                               dynptr_arg_type |=3D DYNPTR_TYPE_FILE;
> +                       } else if (meta->func_id =3D=3D special_kfunc_lis=
t[KF_bpf_dynptr_file_discard]) {
> +                               dynptr_arg_type |=3D DYNPTR_TYPE_FILE;
> +                               meta->release_regno =3D regno;
>                         } else if (meta->func_id =3D=3D special_kfunc_lis=
t[KF_bpf_dynptr_clone] &&
>                                    (dynptr_arg_type & MEM_UNINIT)) {
>                                 enum bpf_dynptr_type parent_type =3D meta=
->initialized_dynptr.type;
> @@ -13969,7 +13982,12 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>          * PTR_TO_BTF_ID in bpf_kfunc_arg_meta, do the release now.
>          */
>         if (meta.release_regno) {
> -               err =3D release_reference(env, regs[meta.release_regno].r=
ef_obj_id);
> +               struct bpf_reg_state *reg =3D &regs[meta.release_regno];
> +
> +               if (meta.initialized_dynptr.ref_obj_id)
> +                       err =3D unmark_stack_slots_dynptr(env, reg);
> +               else
> +                       err =3D release_reference(env, reg->ref_obj_id);
>                 if (err) {
>                         verbose(env, "kfunc %s#%d reference has not been =
acquired before\n",
>                                 func_name, meta.func_id);
> --
> 2.51.0
>

