Return-Path: <bpf+bounces-42720-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A19C9A9579
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 03:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13A9428416E
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 01:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069EF84A32;
	Tue, 22 Oct 2024 01:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnh5ko3x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF58FDDAB
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 01:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729560865; cv=none; b=MFxihkvGB5Imss2lZ5F76+GQCQwul/BSVtI0H0NRgDjIR8okJRPR13nQ6nvLy/HBXmqyr5yd/e6PNLlDkiXUQcKQo36l52o5VIpCpwCklpysKWcZC3b8g7xlTN5Va2mCdFwqjpwxt1/Jq3UnMpwoPXrNGOF6So8Z+UFieDj1ZcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729560865; c=relaxed/simple;
	bh=xIBCpCWubQ+S7u8gAhDIlziW62PS+dj2Of8IRTHBVnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pFbY7xin8b5i9B94P+H1DAh2RHcW/dUqvPYVMdCpUJUXvwCc6njcNh5Cjjnvk8FIEA4nu5C9OnHNuYecmlklU5KkWrElTWS/SIIirKHDlPwIObkpMIOqpSHcZ1uBUWhlYw8D4ff0lSPx8GP/AFF2obn/rxQhtj55235r+mjp6T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnh5ko3x; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d50fad249so3925590f8f.1
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 18:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729560862; x=1730165662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJ0wI2R4txhfyxnLqvlmyeu+fiVKECEQ4qO7p690sfY=;
        b=hnh5ko3xLFU5m9XhJZYmQBA8vX5V2we1NRvAjr1nkYU92ygBEhlFqYFVhRFjwV4jv+
         2OOppNr5YlvAXKlhCKbogHl3ts5sS/oJu53N5wl8NtwFP7/oXRrpKv1pcUQprxYSutmB
         GEuWcr45L6BBzAfw5WJ9ZdjcGCGYgGxyrNnWf5eWO7H+/IRX3qjaGzzOAgayW4go0Zju
         qprWtvjCbyBQbdjkYgsPz3o+Wax/s8Pmkr4FNgH6EtdMlBDBZbgf7gfG0WQQneJjzPnU
         c9iY3JvYQYXggX9xzb6q+Wpq6PlxNHXW40UcKus1iUfbFJqg70J+UKca0RAn3Zc+HTMx
         GXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729560862; x=1730165662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJ0wI2R4txhfyxnLqvlmyeu+fiVKECEQ4qO7p690sfY=;
        b=LZhhEPdV0ofyRjXYEVjACbyD5mhoiMKDYJvgm8OB72BFs5V551iNZnUoM9o2nAxTqj
         kyJ/tDk3HJn6+yJSQxAoUe0prXn6dyV+2FUlrTKnJdbOIA1im/4b6q3/tt3unscaKkFN
         D2KVP3u53OWW55gXaiTXQy7tHUu1CN5MVOi/XlV9YfuPdsJaQybXGTSmFBfs93CXI6q+
         VxxfU51cYdAGhWNqc88TMAtM1fL01taTCaFKGsSYIPW9buIRz/bhOcqfctri7FEFdIB4
         xNIRqgdOWMoRWisvE/8Z3QafXiFa23+a1syHKAHtlhRcUXBCl+G3yIgY7w9AjCKXemGP
         fjxA==
X-Gm-Message-State: AOJu0YwpEc5XuqgiXKew94QGys6UbOBb6hYnvBqUZPkhmhT+qBX3hzDy
	1ahVpVviMUJyJ/oWsTaJlFrei0K8Ldc0kWzSp9X/ksorxtqJinaeTGFeUWVKD+echJGX43vZYRO
	xJhp5S+LHBiOB00aaPCrp5dn4F5k=
X-Google-Smtp-Source: AGHT+IGorneamNQwUYLWc2OfpRKEzmzYSs/c+rplfyjp9ODAEkAadbEBSj/38l2dChXmw5kajkaVer/6dwn8cDHeMTw=
X-Received: by 2002:adf:e7c8:0:b0:37d:4ab2:9cdc with SMTP id
 ffacd0b85a97d-37eab4d7a60mr7560247f8f.13.1729560861781; Mon, 21 Oct 2024
 18:34:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241020191341.2104841-1-yonghong.song@linux.dev> <20241020191400.2105605-1-yonghong.song@linux.dev>
In-Reply-To: <20241020191400.2105605-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 21 Oct 2024 18:34:10 -0700
Message-ID: <CAADnVQ+o35Gf3nmNQLob9PHXj5ojQvKd64MaK+RBJUEOAW1akQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 3/9] bpf: Support private stack for struct ops programs
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 20, 2024 at 12:16=E2=80=AFPM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
> To identify whether a st_ops program requests private stack or not,
> the st_ops stub function is checked. If the stub function has the
> following name
>    <st_ops_name>__<member_name>__priv_stack
> then the corresponding st_ops member func requests to use private
> stack. The information that the private stack is requested or not
> is encoded in struct bpf_struct_ops_func_info which will later be
> used by verifier.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  include/linux/bpf.h         |  2 ++
>  kernel/bpf/bpf_struct_ops.c | 35 +++++++++++++++++++++++++----------
>  kernel/bpf/verifier.c       |  8 +++++++-
>  3 files changed, 34 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index f3884ce2603d..376e43fc72b9 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1491,6 +1491,7 @@ struct bpf_prog_aux {
>         bool exception_boundary;
>         bool is_extended; /* true if extended by freplace program */
>         bool priv_stack_eligible;
> +       bool priv_stack_always;
>         u64 prog_array_member_cnt; /* counts how many times as member of =
prog_array */
>         struct mutex ext_mutex; /* mutex for is_extended and prog_array_m=
ember_cnt */
>         struct bpf_arena *arena;
> @@ -1776,6 +1777,7 @@ struct bpf_struct_ops {
>  struct bpf_struct_ops_func_info {
>         struct bpf_ctx_arg_aux *info;
>         u32 cnt;
> +       bool priv_stack_always;
>  };
>
>  struct bpf_struct_ops_desc {
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 8279b5a57798..2cd4bd086c7a 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -145,33 +145,44 @@ void bpf_struct_ops_image_free(void *image)
>  }
>
>  #define MAYBE_NULL_SUFFIX "__nullable"
> -#define MAX_STUB_NAME 128
> +#define MAX_STUB_NAME 140
>
>  /* Return the type info of a stub function, if it exists.
>   *
> - * The name of a stub function is made up of the name of the struct_ops =
and
> - * the name of the function pointer member, separated by "__". For examp=
le,
> - * if the struct_ops type is named "foo_ops" and the function pointer
> - * member is named "bar", the stub function name would be "foo_ops__bar"=
.
> + * The name of a stub function is made up of the name of the struct_ops,
> + * the name of the function pointer member and optionally "priv_stack"
> + * suffix, separated by "__". For example, if the struct_ops type is nam=
ed
> + * "foo_ops" and the function pointer  member is named "bar", the stub
> + * function name would be "foo_ops__bar". If a suffix "priv_stack" exist=
s,
> + * the stub function name would be "foo_ops__bar__priv_stack".
>   */
>  static const struct btf_type *
>  find_stub_func_proto(const struct btf *btf, const char *st_op_name,
> -                    const char *member_name)
> +                    const char *member_name, bool *priv_stack_always)
>  {
>         char stub_func_name[MAX_STUB_NAME];
>         const struct btf_type *func_type;
>         s32 btf_id;
>         int cp;
>
> -       cp =3D snprintf(stub_func_name, MAX_STUB_NAME, "%s__%s",
> +       cp =3D snprintf(stub_func_name, MAX_STUB_NAME, "%s__%s__priv_stac=
k",
>                       st_op_name, member_name);

I don't think this approach fits.
pw-bot: cr

Also looking at original
commit 1611603537a4 ("bpf: Create argument information for nullable argumen=
ts.")
that added this %s__%s notation I'm not sure why we went
with that approach.

Just to avoid adding __nullable suffix in the actual callback
and using cfi stub callback names with such suffixes as
a "proxy" for the real callback?

Did we ever use this functionality for anything other than
bpf_testmod_ops__test_maybe_null selftest ?

Martin ?

