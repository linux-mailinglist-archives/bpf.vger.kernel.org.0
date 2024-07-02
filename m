Return-Path: <bpf+bounces-33695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28479924B54
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 00:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D93F228D977
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 22:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDC61494BC;
	Tue,  2 Jul 2024 22:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOAfEtuT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65EC17A581;
	Tue,  2 Jul 2024 22:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957711; cv=none; b=chJ9U3ixV5C/G5qwAxHUb75tTkqfIM2vlliRXbX8Sp+bngi4VtK94USIF8/e5dYSPeuIIZyFKhvtK0huQUlCOAOjbPIEsza6hnpNITboFsTZ99SxOv+sMcQcE+bGQ5IkcjoMV0GMWO/nnwzTLnuO68kveu3RdxF82Gyk7UsJAX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957711; c=relaxed/simple;
	bh=x9TR6F4CU4eFhoGdlKth5Lbc6M+fhMnep//ITSqx3XQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ak6frxKtasqJHW1n5D6TYmFhWHERxagTyI0+gUD7oc4LSokH+/TkisLT35qVhJHOuNlDxCJ9TbnUoMbnIqguilw7PVO5CAsAL9bPWDtgMZn0IStJjFEzCrcNBEW/flL2WRJkdsRwOrFvvAHVFLbxWP4jqlaUl/9j4374DS5Rq9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOAfEtuT; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7178ba1c24bso2969933a12.3;
        Tue, 02 Jul 2024 15:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957709; x=1720562509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EWkHzOswqlI88EF9PPRADA+9kVB/Of7diYTRBDZojs=;
        b=FOAfEtuT/qOLrpO1QCG4vM04n2ilgzmSXFpD4tqVpRirg5l35fWjC3PGUa5ZqRqow5
         HpvV6HAZTtN6IgfHhi5jszIi8dtyvkwoMmpy9nZgVgDqg3O9bUoyyb/A5nKC2ITcVtFo
         mSqHre+LB5SgpMQ71fNYnGITBuRvGLBwmC9m7nfbMgofMQiPFaiuEF6TBkGS91ylZadF
         pqjVwqPKEyU1CYJ/TofTAPTPTba4q+/Kfi2AMEgkQz7qNFQljYOKumEOhX/UjEIXYqIN
         yx/efDIVAgkRs3sEUY5kkMCSV/WE/UWbDrOrnyVDcXwprNND1eK+gt7+eRvP45I+00A7
         Z9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957709; x=1720562509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1EWkHzOswqlI88EF9PPRADA+9kVB/Of7diYTRBDZojs=;
        b=JuP0LdGKFfwfX7pj0qpHvfX0/hTRKwtWYQOEfsLPT/5aSM18895k3u8eyIoH+hrZ9k
         1IR+kHeNA0uFo4YPRn057jxoG6TjfjkyqdNv+5ZJ4JMV9HS6/fb5VJsCxx64U3fmt53Y
         sTw1RTed2PTonhT1x48cWCdZYZ6vEUkoKK/oRxJ6mVDpvaNVBj+wxDi4ZjOXHlBofTv9
         rghV6RDQoa0DLK5/inVwoyw8M3wWf+QTLeawpwZjCnqNujFdBaEF1xUOkZbRd6lxVzAx
         m/wnkMmYtE7ICobxLDD1YfgCPBUup5xAzOdSQ+j+ieiQxrIYO6ub2iD7KCUwZ9GN58aB
         g8gw==
X-Forwarded-Encrypted: i=1; AJvYcCWGfhStmaLt1fvFn4I5yeT2avJyrLUrJ7fBEeSRcSIYolaJUP5+WnmjV2I8c4h6VM0OIOLSYZIJsOHSpARCN55O/RNzPpUYLlamj4i387OEq5+SmeGvalBWgQs9NdMVTNZS2AWqaXD4bc6o61BUyn/ObExZml7/plsuOaGMpR4QQEdK0Jzi
X-Gm-Message-State: AOJu0Yy0Qo//DU2uWTdXv+4ZnoxOWSjlle0WWY6hlLhrHvqT2nVe3P6v
	IP6D2bL+NshMnkCmgNyFfS3NlNdlednx2Srubc9cbNBBP8rxJnHs/7cJwe+GtbwK/1XmJiphALb
	aGd7KU47wml3qIvWl7Kcv4uDlbZA=
X-Google-Smtp-Source: AGHT+IFRzYY9nL79tum69W8+zH9JxFHnx5wiGPumsTiY7HS9IX+Wjp1BlDDDRowDhTqRlHtpFeCImEmdSPtsOsAoWbI=
X-Received: by 2002:a05:6a21:999e:b0:1bd:feed:c031 with SMTP id
 adf61e73a8af0-1bef61255c2mr16816646637.28.1719957709044; Tue, 02 Jul 2024
 15:01:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701164115.723677-1-jolsa@kernel.org> <20240701164115.723677-9-jolsa@kernel.org>
In-Reply-To: <20240701164115.723677-9-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Jul 2024 15:01:35 -0700
Message-ID: <CAEf4BzYRPVHQyi-gU3C8B8J93tRe8T47dXi+0iYYw81Wen_uvg@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 8/9] selftests/bpf: Add uprobe session
 recursive test
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
> Adding uprobe session test that verifies the cookie value is stored
> properly when single uprobe-ed function is executed recursively.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../bpf/prog_tests/uprobe_multi_test.c        | 57 +++++++++++++++++++
>  .../progs/uprobe_multi_session_recursive.c    | 44 ++++++++++++++
>  2 files changed, 101 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_sessio=
n_recursive.c
>

Nice!

Acked-by: Andrii Nakryiko <andrii@kernel.org>


[...]

> +static void test_session_recursive_skel_api(void)
> +{
> +       struct uprobe_multi_session_recursive *skel =3D NULL;
> +       int i, err;
> +
> +       skel =3D uprobe_multi_session_recursive__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "uprobe_multi_session_recursive__open_an=
d_load"))
> +               goto cleanup;
> +
> +       skel->bss->pid =3D getpid();
> +
> +       err =3D uprobe_multi_session_recursive__attach(skel);
> +       if (!ASSERT_OK(err, "uprobe_multi_session_recursive__attach"))
> +               goto cleanup;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(skel->bss->test_uprobe_cookie_entry)=
; i++)
> +               skel->bss->test_uprobe_cookie_entry[i] =3D i + 1;
> +
> +       uprobe_session_recursive(5);
> +
> +       /*

nit: unnecessary empty comment line

> +        *                                         entry uprobe:
> +        * uprobe_session_recursive(5) {             *cookie =3D 1, retur=
n 0
> +        *   uprobe_session_recursive(4) {           *cookie =3D 2, retur=
n 1
> +        *     uprobe_session_recursive(3) {         *cookie =3D 3, retur=
n 0
> +        *       uprobe_session_recursive(2) {       *cookie =3D 4, retur=
n 1
> +        *         uprobe_session_recursive(1) {     *cookie =3D 5, retur=
n 0
> +        *           uprobe_session_recursive(0) {   *cookie =3D 6, retur=
n 1
> +        *                                          return uprobe:
> +        *           } i =3D 0                          not executed
> +        *         } i =3D 1                            test_uprobe_cooki=
e_return[0] =3D 5
> +        *       } i =3D 2                              not executed
> +        *     } i =3D 3                                test_uprobe_cooki=
e_return[1] =3D 3
> +        *   } i =3D 4                                  not executed
> +        * } i =3D 5                                    test_uprobe_cooki=
e_return[2] =3D 1
> +        */
> +

[...]

