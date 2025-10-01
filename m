Return-Path: <bpf+bounces-70116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEDBBB14FE
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 19:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B6727A5AFC
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 16:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE5D286D56;
	Wed,  1 Oct 2025 17:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgCgLoq+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3896262A6
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 17:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759338052; cv=none; b=qoxysMnrWDGB1V5HK/DQ44cbxuxwskMI5CUl6cIPB6WSS+QbTB69bi+B89myzl9cMKXarBNV7jBBOoCbIXpeptPchtjcEwmR+ya/lnkQlQ77UvkevmsUGaqMVjKn4GclJS5NOVW6t4xibCUF6AUyQmW/gInRKgL1C+waUx30D+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759338052; c=relaxed/simple;
	bh=sjX50G/tUq/U897C1bpd/HimoHHU1H7tUmHrOvEGfTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Txg+0O5Ddj4jbcALbVT28E3HfneM43ddczVAclGj5y5XKIqSRA8w5Bp+YxkfZiaAyIcpDnstVrNRxCPd3V6DnMSmIIdw3+VfZ0BDGxg2V8ueZvkRbxKo924p8oeoQNQbrWKFrSCh3ml3RSSlZvS15WVqwmIH5fZXSvZIjXLMkQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgCgLoq+; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-330b4739538so137573a91.3
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 10:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759338050; x=1759942850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fT5p4Btk56TCbl3BFicN1GMSxSDzWy0fbwzYm7Xb0S4=;
        b=NgCgLoq+twHmO1A9maqhbH8zJA2u4v+R1/+LR96WFBY1cmi9efueVxnH9UVEekMGCO
         cxCBkiPlIV9PYfXk0hvdkmY/VMT2DgC5nKZAaNca34XMFb8HNHlYjh6axLcuiXIrMz89
         8Z6rIorL5XMVfwpjpGMQVc79CAWstXUpp/MC0bfVHU+8baRw6vmFygImYKFAp3cVfsHo
         z6i/e+sSk8LWQVLzhky3ziNaqkiOvhNf6J3uovsVnL5JabNsqn7AH9hrsGk831W7EkQm
         6adSqcbW7oVi66ml/hVaCesIT51h94+y59USJ9B9Ga4IyJXWEQUuQs04+Cnt1d2M2gIe
         eVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759338050; x=1759942850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fT5p4Btk56TCbl3BFicN1GMSxSDzWy0fbwzYm7Xb0S4=;
        b=J0IwUa1WaZSLc5b2CmmmxLzXA+Oy6U+78MD0X6Nuj8HPuI5CE4Yy9FyL6Pk3Ns5rJh
         w2ytO1lZu+kFa/iiVkWTD8vaoJZre8bAQo22jB3j8QKqkbu2CUZtUvlcpvpo9XaD0ByK
         Ob0O6EVz84vBwdeNOj4Wi18MA03gY+R+2tbVkyI0rH1d6QZHz98RoeJryqP5INgVVZSv
         h22NT5Wbt8sZn3JiWmGelgYKf+hpMALAEVkG6dhJutweAa9pOJ9bYfykgcawl3uWOYHB
         k5FlJ13UwBl4wewoCQUi4LYjIW/SqAEMhxXbp1xUg/WLxXzlY4AQYk1IEH0oigSxkAxI
         uDPA==
X-Gm-Message-State: AOJu0Yx5m9KWpW7eyRovkLFYEhgPfRIvkQR6ivq/gAjU8X9UjnAZRTLD
	zU8a4tjcUO96OkNNv5PWmEORZo3CnPu2L4sX5d7V/QR3/7eMrC/axEk1VAti7TTgboHaUJdQLar
	PW2E7jJheLzJVpe3wqSnQFVgH4pN09jBNLQ==
X-Gm-Gg: ASbGncvOHhbhCDWt7e42qKbsNl1YDBFSiNvbM9+bpK3eJTMHpLFZqmVMIw7xhI7atty
	g1pvTC70wN4PAddrCWnWlftjZRVwL0NOgeUNxTTijIaWliA6rSxQqqn1T9ATkBc92bwV4JZXkAs
	lmEBx07oX2QLnglx6L0k/Gmo6d4gscrcXCN0mywVqlvJUldYVc5U37V7VElVlya9qjKyTt9ya5m
	b7UTcj6YQaUMnHZacCR7xmFIE7rtilsVRBU5Cpd9UGFfO8=
X-Google-Smtp-Source: AGHT+IEB5D+uhHBdhCgO0xffDauPePoEVIEowtMGuewPmKha9MGEBbV1kgo354MvppSI6n1jqrdHn0YFQa4UCtBmQDU=
X-Received: by 2002:a17:90b:33c2:b0:32e:36f4:6fdc with SMTP id
 98e67ed59e1d1-339a6e62b1fmr4846680a91.4.1759338049940; Wed, 01 Oct 2025
 10:00:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001132252.385398-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20251001132252.385398-1-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 Oct 2025 10:00:34 -0700
X-Gm-Features: AS18NWCeNKu9_msZa4OpjKdFwGWnW7ssb5HH8TNuoYslPmzPQ7eHx-nOMZy75C4
Message-ID: <CAEf4BzYju+8nCwsb9MsvNRepX+=yHH0dPMMftPfXJqaJ9=SzeA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: verifier: refactor bpf_wq handling
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 6:23=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Move bpf_wq map-field validation into the common helper by adding a
> BPF_WORKQUEUE case that maps to record->wq_off, and switch
> process_wq_func() to use it instead of doing its own offset math.
>
> This de-duplicates logic with other internal structs (task_work, timer),
> keeps error reporting consistent, and makes future changes to the layout
> handling centralized.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  kernel/bpf/verifier.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>


> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e892df386eed..b2d8847b25cf 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8464,6 +8464,9 @@ static int check_map_field_pointer(struct bpf_verif=
ier_env *env, u32 regno,
>         case BPF_TASK_WORK:
>                 field_off =3D map->record->task_work_off;
>                 break;
> +       case BPF_WORKQUEUE:
> +               field_off =3D map->record->wq_off;
> +               break;
>         default:
>                 verifier_bug(env, "unsupported BTF field type: %s\n", str=
uct_name);
>                 return -EINVAL;
> @@ -8505,13 +8508,17 @@ static int process_wq_func(struct bpf_verifier_en=
v *env, int regno,
>  {
>         struct bpf_reg_state *regs =3D cur_regs(env), *reg =3D &regs[regn=
o];
>         struct bpf_map *map =3D reg->map_ptr;
> -       u64 val =3D reg->var_off.value;
> +       int err;
>
> -       if (map->record->wq_off !=3D val + reg->off) {
> -               verbose(env, "off %lld doesn't point to 'struct bpf_wq' t=
hat is at %d\n",
> -                       val + reg->off, map->record->wq_off);
> -               return -EINVAL;
> +       err =3D check_map_field_pointer(env, regno, BPF_WORKQUEUE);
> +       if (err)
> +               return err;
> +
> +       if (meta->map.ptr) {
> +               verifier_bug(env, "Two map pointers in a bpf_wq helper");
> +               return -EFAULT;
>         }
> +
>         meta->map.uid =3D reg->map_uid;
>         meta->map.ptr =3D map;
>         return 0;
> --
> 2.51.0
>

