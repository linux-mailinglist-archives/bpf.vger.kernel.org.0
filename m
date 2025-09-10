Return-Path: <bpf+bounces-67955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9879B50A06
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 02:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 653D15E1CC6
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 00:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187E51C84DC;
	Wed, 10 Sep 2025 00:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhwOFCEY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1960E13AD1C
	for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 00:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757465691; cv=none; b=FxF/Y86CGdhhXU9k3fqHznBhVNH6a0czsqtruZaTMCCq5NVz9xVA1oCvp4Bhs1iyKdmyCKvSl3BnvkHE6goeTxk7nSR2EqipWBJAd9g8DFFxrLBe6QskFCoQad0kbldyVfPwRfszbI4B9BTV9rEl/Ja2dQ/o2vcsudjBE8oH1K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757465691; c=relaxed/simple;
	bh=zr6E075yfRWWlsNCRH0t0EqsVOTONyJNPXV1Jncxwko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LpLUAbGp4UAZECxr7Uk3JxRaG2PNykU+TVslmDFa6DlJfbYPpE/WZCDhSG9BCk10bt7OEzzxnA8udlVQmZWKak01IGtD5y1lSpAejyWPbLzphvIxWXB46fvPbaqSFP06iKWZBobIKwDCihB8Y5B6fANqlEbeADeRd5T+YG+I6Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhwOFCEY; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45b9c35bc0aso54663065e9.2
        for <bpf@vger.kernel.org>; Tue, 09 Sep 2025 17:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757465684; x=1758070484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4YIuUISh2rDovl13FIKmdNaWq5xsG3/fxm4a5mE6iE=;
        b=bhwOFCEYqMkstMaOxUkqtnJ/8gufjl5gUiwKo6BAf966eK+PMCyUBfMthk3D6gKjen
         nAh7J8WUJi87TXDUcQ06c12gzjqph66C9hU4idMnDHQheiXGWVGehNUh07nYMElk+Dwa
         DylQEW2Yaj9CKbZFaRQPcVBqkUN8S+g84hDtcAO4Fcje4tLz7Qmrakgv37WO7amUMP3U
         VvlQ7SBuyAPPPrqHKgF3spy9+MMMLVWn7G57HI+n82GBw+ZKCvj9Iy3famvJrBx5DTKL
         bChe7i+mozsoaKTCG4k6/vW1OZZX4DzX4XPxKEpJOwV4D2CMVNzU4SjQ9HaRsw//3odz
         9Dgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757465684; x=1758070484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J4YIuUISh2rDovl13FIKmdNaWq5xsG3/fxm4a5mE6iE=;
        b=iz50eZsS2yhWG5vm2Qkb75eIJqh63eJgq6t/0t9LPuKG5R6Y6/+vBiHyvJXu+b9Htx
         AY/b3LEEs9+M0pgiGvEub3wI+BhuAhAw4PXxq20Fli652hsMAs+FRQZw3UvSV44Ooj6/
         AXO/KDZP0kr+5QokCLCJ0HunWlB4cH9BbYUGOqiGKOJPOaBnHIqukkohY1dtbKr3Q56x
         c3IgMk/OSLhnDTja16f3NsM83O7+UNRMQbAH5IvSOk63SyX/jb/D7G6+x2LHvBkyN85e
         tEsQvXH1QKVlfoPR12Uh0CndgtWDm3ZGId7HNhEOFTl087guKfvA1kWZXm8choYNIWQi
         D2vg==
X-Gm-Message-State: AOJu0Yx8+ztyE1FQaSpmoGYadgjtqMvhQgV0WJYKtAnqlNVBQj1ucqZ8
	6IYQbls0Eq/7uvRlb8N1WCtCqTF1yuurdFpjEz7Nbh6kYDt0oNYkqDxyIvAWbguILAJ2XgrPCob
	zeXDRnIsozugl5SsQb3FowRqLjaOH20Y=
X-Gm-Gg: ASbGncunzKy21z/dv7xrOKi7M1iAlRXUPTjBQNFoXQXglPi6jrrmqjhybxSVJc8VTZd
	wdIq1A4OD9q1hi2ekl0PBIn45/DxzDCs6LXJjS6/xQev0cAkqVc8N+FfGG25qyhGj5cNtDzpald
	v3ouLfcIU/3FHur45vh+vhM/MA8umdBKdvZTPedcKV28/2V4rJur9oVc/yoUlbhH3PKosYVC9Eu
	JAc2Y0sTEVj/dJWnJbzDYCaGTTC3cKyzzR5
X-Google-Smtp-Source: AGHT+IGvFVCn1t4L2wmjoeDjVhbg8M0XCT28ZW3Z2Lpb7l8zMQmq9161tl+gVWpVXBrzWT29nF1mAL802LsaSJxMSaQ=
X-Received: by 2002:a05:6000:2510:b0:3e0:152a:87a9 with SMTP id
 ffacd0b85a97d-3e641c4ec99mr12794790f8f.28.1757465684189; Tue, 09 Sep 2025
 17:54:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905133226.84675-1-leon.hwang@linux.dev> <20250905133226.84675-2-leon.hwang@linux.dev>
In-Reply-To: <20250905133226.84675-2-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 9 Sep 2025 17:54:33 -0700
X-Gm-Features: AS18NWAgpE8qfOkoF07n65pjFDbUdSbtUhivMvufcVXgMHnrpH2buHMK1w3S6m8
Message-ID: <CAADnVQ+uk+sqZhYPJu78NETidUiCa617Wa_YdnmvefOZnNoeZg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Support fentry/fexit for functions with
 union args
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 6:32=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
> Currently, functions with 'union' arguments cannot be traced with
> fentry/fexit:

union-s passed _by value_.
It's an important detail.

>
> bpftrace -e 'fentry:release_pages { exit(); }' -v
> AST node count: 6
> Attaching 1 probe...
> ERROR: Error loading BPF program for fentry_vmlinux_release_pages_1.
> Kernel error log:
> The function release_pages arg0 type UNION is unsupported.
> processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 pe=
ak_states 0 mark_read 0
>
> ERROR: Loading BPF object(s) failed.
>
> The type of the 'release_pages' argument is defined as:
>
> typedef union {
>         struct page **pages;
>         struct folio **folios;
>         struct encoded_page **encoded_pages;
> } release_pages_arg __attribute__ ((__transparent_union__));
>
> This patch relaxes the restriction by allowing function arguments of type
> 'union' to be traced.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  kernel/bpf/btf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 64739308902f7..86883b3c97d20 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6762,7 +6762,7 @@ bool btf_ctx_access(int off, int size, enum bpf_acc=
ess_type type,
>         /* skip modifiers */
>         while (btf_type_is_modifier(t))
>                 t =3D btf_type_by_id(btf, t->type);
> -       if (btf_type_is_small_int(t) || btf_is_any_enum(t) || __btf_type_=
is_struct(t))
> +       if (btf_type_is_small_int(t) || btf_is_any_enum(t) || btf_type_is=
_struct(t))
>                 /* accessing a scalar */
>                 return true;
>         if (!btf_type_is_ptr(t)) {
> @@ -7334,7 +7334,7 @@ static int __get_type_size(struct btf *btf, u32 btf=
_id,
>         if (btf_type_is_ptr(t))
>                 /* kernel size of pointer. Not BPF's size of pointer*/
>                 return sizeof(void *);
> -       if (btf_type_is_int(t) || btf_is_any_enum(t) || __btf_type_is_str=
uct(t))
> +       if (btf_type_is_int(t) || btf_is_any_enum(t) || btf_type_is_struc=
t(t))
>                 return t->size;

Did you look at
commit 720e6a435194 ("bpf: Allow struct argument in trampoline based progra=
ms")
that added support for accessing struct passed by value?

Study it and figure out what part of the verifier you forgot
to update while adding this support for accessing unions
passed by value.
Think it through and update the selftest to make sure it tests
the support end-to-end and covers the bug in this patch.

pw-bot: cr

