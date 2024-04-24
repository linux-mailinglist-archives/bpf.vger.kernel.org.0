Return-Path: <bpf+bounces-27601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E30508AFD4E
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 02:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98C3C1F22CD2
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 00:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA214C9D;
	Wed, 24 Apr 2024 00:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJItnyHf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072AC4C8D
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 00:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713918426; cv=none; b=nmhPmBVqxaNkx5yD58bJamrjz9/GK2buiLcYp3MbG0afy7OWuqNQhBIgWxZfMCyLPwFFXJmaaIHOKSCkN+5dKD6g6Uy6THZ2QBBdQQr2fyO5zgKcEtgpZaGQ4A4iPIO/d0+5+Y7SA91Av71M3Ccli3px/u6F1KmuDxMdTkPPHvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713918426; c=relaxed/simple;
	bh=WWpqSR6kHgNe6mKMm23NHwnybybNagVCcrHwCU53xgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y/axdBDjsavRuK2hcc6v+FxySwaP9t/Sr4uFKyHWHbQal4gVwDbCWdVNnwhfZYV1Q/lRyRpDO8MdAxweUHQiCXqfbv6RtEJ9uzrbJlnExq6TqEQCER26Fj2aSOetA7TugLYKLPw6EnW0QK4/yWMk++fG/IewBTaL6iFip588h7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJItnyHf; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e51398cc4eso55625205ad.2
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 17:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713918424; x=1714523224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GIrWBwCMKH98Set5r+e5ihch2JxT38UqoAY+fvwYMxY=;
        b=MJItnyHfClrZVOZzD0KKSACR+XK/diVw3seASt0dyvfQEMk+jbyIjMxnXtV5VRRuEN
         ozh+SfFY6kpInf3JfSBavbH1M8k4HL/FAhSJ8QHG6Si1YY8wZjday7+wli4zw4dwIeGA
         stPD2YeulJroG3X04f4TL4726oDlVIvowCqkiwxN50LC+SXOQ2qAmJaT8erQVy/gO+lD
         r3S5mLCq2jO+YyR3ySNHN2eZgVBcNZtejToXYVVia1dknYJKXyCMdn+jFGfdt4BMTXTa
         ueVBUk2+p2U/BHeRimzJ36A5BUZAoU0lD+hYAgspffkXLE0sWy2yZLn4R0xmcnddfR6z
         Dq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713918424; x=1714523224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GIrWBwCMKH98Set5r+e5ihch2JxT38UqoAY+fvwYMxY=;
        b=D8xMQyO0V/dOOPziY63gR7khEexPVhzuoMzClXm5yea2KvSH39se6w0zD1XgQAh3v6
         b3Xw08Tnn8mlhemyF6hmSr1nWKgCfqsJ49DsZJFRxq0pdZqOXVKuRv8Lih9HBD4FVBj9
         rEeHdnVbLPfU2rT3IlQxXZ+f3ZPIi2yNxM++VJjgUzw90rBB8zn/66ReZVmhdsIpMM+u
         TMsd6/t+LuF7y8hWoIuBFxbtYD//QhWG23TCz5uqy025i/Gwh8bMkLJn9wHwJOupyQnd
         NHk/eluri8CnXJ/dgY8e/kLIPvfrGxpoJo1smxcQvpGHmBJnOUf2i8CRYM+cjpU7xPF2
         +auA==
X-Forwarded-Encrypted: i=1; AJvYcCUV2rT2bO/2Db95AjetEasGmuBYiuGryLdqOINf56zfboNEyEF+7Tk8aNepEYazf60qr0XFdrnNUF1jwM08x7PR1IrI
X-Gm-Message-State: AOJu0YyL3qKYR36UrUrLL/EPPFZEAd1PULzn6DIsTIqWY29DZ57nOBYy
	AgnP24ZnXbj55zeBf/pNXPEK3Fw70yWhZPnD1pBU4StnHcMkr7pDCYbU+nrY8/24Ntd0i0SiPSL
	/CrNwn30aMQ47osx0VqR0wDDr7iA=
X-Google-Smtp-Source: AGHT+IHRFK+bFUrBieukx+fZNUN4QqpdnhqCQBEp28evrN2ajhjqIS+/YhVrMXylq3GKcBlYS1YO8clmvf+JfX10ZKA=
X-Received: by 2002:a17:903:124e:b0:1e5:d021:cf58 with SMTP id
 u14-20020a170903124e00b001e5d021cf58mr1293550plh.36.1713918424454; Tue, 23
 Apr 2024 17:27:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422121241.1307168-1-jolsa@kernel.org> <20240422121241.1307168-4-jolsa@kernel.org>
In-Reply-To: <20240422121241.1307168-4-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 23 Apr 2024 17:26:51 -0700
Message-ID: <CAEf4BzY4PGHARcfB3DX1keDD5SaaMv1Rezz-2V_r5B4Hi9C9Jg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/7] bpf: Add support for kprobe multi session cookie
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Viktor Malik <vmalik@redhat.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 5:13=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding support for cookie within the session of kprobe multi
> entry and return program.
>
> The session cookie is u64 value and can be retrieved be new
> kfunc bpf_session_cookie, which returns pointer to the cookie
> value. The bpf program can use the pointer to store (on entry)
> and load (on return) the value.
>
> The cookie value is implemented via fprobe feature that allows
> to share values between entry and return ftrace fprobe callbacks.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/bpf/verifier.c    |  7 +++++++
>  kernel/trace/bpf_trace.c | 19 ++++++++++++++++---
>  2 files changed, 23 insertions(+), 3 deletions(-)
>

Had the same question as Alexei, but this read-write semantics quirk
makes sense. But it's probably a bit more reliable and cleaner to
handle it by special casing this kfunc a bit earlier (see
KF_bpf_rbtree_add_impl) and setting r0_size =3D 8, r0_rdonly =3D false.
And then let generic PTR -> INT logic kick in. You'll be futzing with
register state much less.

Other than that looks good:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 68cfd6fc6ad4..baaca451aebc 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10987,6 +10987,7 @@ enum special_kfunc_type {
>         KF_bpf_percpu_obj_drop_impl,
>         KF_bpf_throw,
>         KF_bpf_iter_css_task_new,
> +       KF_bpf_session_cookie,
>  };

[...]

