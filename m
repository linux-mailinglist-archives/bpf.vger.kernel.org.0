Return-Path: <bpf+bounces-18229-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC8A817945
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 18:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3912D1C21D84
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 17:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6294D5BFAC;
	Mon, 18 Dec 2023 17:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/Ya2sOs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7358C1DFDE
	for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 17:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a2331caab22so250390666b.3
        for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 09:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702922211; x=1703527011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PS2mqO2urvDYtP7sJL1mlIRoNFmeXGAmVyPLRJAXgkA=;
        b=P/Ya2sOs0nzNsQSOj6gbZn9A29MXZ2DSmXvxApKNBmsz5Spg7CEN/P7s1eF09d7i4v
         LdGEfDD2/nhQ0XX3cRA3XEhVYcK63oV5FuRjXZegmZePeSCLPkoxyFk971xXXMSBGJRb
         jurBvUh4keuC9FhQm1Nn6pmJU3l4WKnCLLx95AGsxnpiC3Tu7sJoIMgUV1lP5l9/M1fJ
         cSyCrjQPxfE/MT94d4Z0ISuKWQd+8K0PXBj21bstMV6noyI1iqF1FTuzffiX6V92yz1T
         W12Rs/1WEufN/LlPnpPEfaq5gCohGZOerHBzE1tKySa13eDPMJCEnXYsl+n2pdhS4tQt
         DjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702922211; x=1703527011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PS2mqO2urvDYtP7sJL1mlIRoNFmeXGAmVyPLRJAXgkA=;
        b=hxHblUKRDi9WbVjsP5nsux6fsu2OPsh1/Q05c5cDjuzQfNbPpHn7pwIAgv8iJ/x3li
         39vqTD1SC0/oLlUs9UYBiz+wKkbGq8XG1zJn2wP9apqSztwwnEXOV/Uju4/WcnIJECc0
         TH34ihJ4fwCgZIfIH8mYed4aO4J9/xBLWHFHhlAC4JLf0jd74d7R42QafKWb5MKYButX
         qIRYcH8fK+5N95K5pwPZY0E5U2SC5fzTAdlwlEbN5YcpkzRip0QFTw3XtcyZrcDai0nO
         0o3JHgthyB2MekuC+ErmQ6TxMskRs6NCZcdyINHKc5x1yI9VCvw/pq5wVxrpO1dNGk0N
         qiog==
X-Gm-Message-State: AOJu0YyzvnpevvUVfPcpUzVqzsHOS+k4NgjUCMTYKqaafOMaRqaQIUpo
	bT1pbYpDw+xwweZBFBfNJvmvGFA9rPgo3i0me2k=
X-Google-Smtp-Source: AGHT+IHm78oN4KcemH3cyfflHCuQzHI+GEF5N+7UmGMMztk8+NLtZ8ZQkoZw41FcBJPYmnc3TFI2hJK1JGqeiegP7uw=
X-Received: by 2002:a17:906:e4b:b0:a23:6484:5cc9 with SMTP id
 q11-20020a1709060e4b00b00a2364845cc9mr495995eji.146.1702922211209; Mon, 18
 Dec 2023 09:56:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231217215538.3361991-1-jolsa@kernel.org> <20231217215538.3361991-2-jolsa@kernel.org>
In-Reply-To: <20231217215538.3361991-2-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 18 Dec 2023 09:56:38 -0800
Message-ID: <CAEf4BzaE7DPtetyE-EBvW_QJcO9vHOAanh7aPWEXemB=J3b_Mw@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 1/2] bpf: Fail uprobe multi link with negative offset
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2023 at 1:55=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Currently the __uprobe_register will return 0 (success) when called with
> negative offset. The reason is that the call to register_for_each_vma and
> then build_map_info won't return error for negative offset. They just won=
't
> do anything - no matching vma is found so there's no registered breakpoin=
t
> for the uprobe.
>
> I don't think we can change the behaviour of __uprobe_register and fail
> for negative uprobe offset, because apps might depend on that already.
>
> But I think we can still make the change and check for it on bpf multi
> link syscall level.
>
> Also moving the __get_user call and check for the offsets to the top of
> loop, to fail early without extra __get_user calls for ref_ctr_offset
> and cookie arrays.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/trace/bpf_trace.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 97c0c49c40a0..492d60e9c480 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3391,15 +3391,19 @@ int bpf_uprobe_multi_link_attach(const union bpf_=
attr *attr, struct bpf_prog *pr
>                 goto error_free;
>
>         for (i =3D 0; i < cnt; i++) {
> -               if (ucookies && __get_user(uprobes[i].cookie, ucookies + =
i)) {
> +               if (__get_user(uprobes[i].offset, uoffsets + i)) {
>                         err =3D -EFAULT;
>                         goto error_free;
>                 }
> +               if (uprobes[i].offset < 0) {
> +                       err =3D -EINVAL;
> +                       goto error_free;
> +               }

I applied this because it does fix the problem, but the whole
reshuffle of offsets in front of cookies is pointless, because of the
common for() loop. You are saving one or two __get_user() calls before
failing.

If we really want to do validation first, reading offsets should be in
its own for loop, then uref_ctr_offsets in its own, and then cookies
in its own loop as well. That way we read and validate the entire
array before reading another array. Please consider a follow up, if
you think it's important enough.


>                 if (uref_ctr_offsets && __get_user(uprobes[i].ref_ctr_off=
set, uref_ctr_offsets + i)) {
>                         err =3D -EFAULT;
>                         goto error_free;
>                 }
> -               if (__get_user(uprobes[i].offset, uoffsets + i)) {
> +               if (ucookies && __get_user(uprobes[i].cookie, ucookies + =
i)) {
>                         err =3D -EFAULT;
>                         goto error_free;
>                 }
> --
> 2.43.0
>

