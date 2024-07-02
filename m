Return-Path: <bpf+bounces-33688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBBE924A2F
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 23:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1301F1F23466
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 21:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CBC205E15;
	Tue,  2 Jul 2024 21:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFvNG22q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3711BD512;
	Tue,  2 Jul 2024 21:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957413; cv=none; b=LViMfAQrJbnUEyuQYNlBtB9CWRT75YkfMcktR7r37B+PeX1Sg/IAE/b5LwDVEObU5rU2FP0Nx8RKaLUxTArhF+90tIWfj1K5e/BqNvN5qctsTtj+EIeSn0Q48o0ofJvC6APPQnqhBex2st4zelLgAc9UXoQ4UuVbnVUXPBNVjv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957413; c=relaxed/simple;
	bh=i1oI9YIzLPqNiygl/i2Sm4xEc6dmsX056kEe/jaTpLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bysTC0/qeLITpmJqoi6hDXwZSEfmk+kpJGtM6eKgazcmpYMZPImL9qa+mjW2JqpAsYLWWyyscDxghC1/VOoCHm/O1gtB4RuOzDXjU7Yi61kFKW80LDjD80+ToGxCU3jaQphz9Id38/txnjiaCeU4U50pcLcg31krv2G0XTkYuWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFvNG22q; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a729d9d7086so3850766b.0;
        Tue, 02 Jul 2024 14:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957410; x=1720562210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YlpenZm8uxQHPi2SGFCznX7ZTKNlaJSgodAnDB5qmyo=;
        b=XFvNG22qDmWuTeHnBnLX9Oll3qXt746g4SDD3xEC2yRGYKgd6FLL6gdqHfAMjhIqKg
         Cx/lCMKAbBkmKowA8NN8kiqnBm4AaZirmtQDbK4vaemstx0MU/0aiwG+SaaydhYd6dFt
         Z2PV3WiH5INEABth1QGPmM91XtC8LFG3OdckeWUpGmYd0xyGQ2S6Xcit49rupMBZbvGR
         OYQfzzX0whRARv5Wxgg+MInCqLkTFVY16JsNV0yHQRuMMzwHP72LznOje/6G/w+8jwaO
         qYX1AODqL3Y371cE2RFaR5URyN/Uf4++yUK8w/ytFKIeMtHnL7BBEr3+CPBivIXtgEcV
         2cKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957410; x=1720562210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YlpenZm8uxQHPi2SGFCznX7ZTKNlaJSgodAnDB5qmyo=;
        b=k7w4cKl6tJJ65482pShOi88apJbVyt0v7Q7EOqj1b9HBmDr6z1Qp/Kq/XMDAGvkbTV
         /3I7KBh6x3tJZAoLBs1c3g5PHNKPD7iTq/WPbkVdBgSoIW6aLom2FYdN5CRJlHFV66hh
         zEuN5W0pGHecc2xCsexG7qtDKD3PY3X/FLlCzmYMgsezyVl96HDzfeiF3OC1wr9Vygei
         CJlJDeCEEfmaXUAcH141kbrMm+iR2Ud5mkC9Ep70/HP+nv+A0jcb9ARtBgUSV1XqR7cC
         TsK3WFs2/kqkrbVyCOqlclctq6vy5qq6XMfH85Hi4z9FVrJBmA93A2BDo9RdzDpJxlXq
         ZBNg==
X-Forwarded-Encrypted: i=1; AJvYcCVPzhjUKlAQ28zPjtTjrHeMLVzQudn82sA/Iwc6XNfqX/KXjDjIoDsc9Glbid1w68qgq8zUXSZT5Ti2Q1+ythzxudoFuvHIm8L6+g96C/2/jqfOFIQucQ29N1yyNgfTjqMesdYEhsiH6rCn8UESRKqPfEMfc2EbBkdQudSfP6yzX20xe0Rs
X-Gm-Message-State: AOJu0Yxr/qPfE/Iiwn4iJvVYUOP80Nf4403Q6KKC0HPbzQ8l3+Y57xE2
	cwgs+ZStoGOdiFFqbC3BMSxp8g8UqH1npdchSMckQ894WF6ZUGfP4I7msSk3iu3NR9cthw8pIOr
	Qi1aXccdl0yYlUVh0O1Lya3H7DNU=
X-Google-Smtp-Source: AGHT+IGpXO4cs5q7hP/i2y3FPxVkmelFSitJsJjeqUMfKKPrzYwr0tTPm6CNSzX6MCtJK5aJBkcxQChl53OvsD5RfyA=
X-Received: by 2002:a17:906:eb4c:b0:a6f:935b:8777 with SMTP id
 a640c23a62f3a-a72aefa5ab3mr928231866b.25.1719957409422; Tue, 02 Jul 2024
 14:56:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701164115.723677-1-jolsa@kernel.org> <20240701164115.723677-6-jolsa@kernel.org>
In-Reply-To: <20240701164115.723677-6-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Jul 2024 14:56:34 -0700
Message-ID: <CAEf4BzZefhPv+yXJ3ozX6nCewaq4LQGOCpy_g7a9QKsAq5FDQQ@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 5/9] libbpf: Add uprobe session attach type
 names to attach_type_name
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 9:43=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding uprobe session attach type name to attach_type_name,
> so libbpf_bpf_attach_type_str returns proper string name for
> BPF_TRACE_UPROBE_SESSION attach type.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c | 1 +
>  1 file changed, 1 insertion(+)
>

Can you merge this into a patch that adds BPF_TRACE_UPROBE_SESSION to
keep bisectability of BPF selftests? It's a trivial patch, so
shouldn't be a big deal.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 492a8eb4d047..e69a54264580 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -133,6 +133,7 @@ static const char * const attach_type_name[] =3D {
>         [BPF_NETKIT_PRIMARY]            =3D "netkit_primary",
>         [BPF_NETKIT_PEER]               =3D "netkit_peer",
>         [BPF_TRACE_KPROBE_SESSION]      =3D "trace_kprobe_session",
> +       [BPF_TRACE_UPROBE_SESSION]      =3D "trace_uprobe_session",
>  };
>
>  static const char * const link_type_name[] =3D {
> --
> 2.45.2
>

