Return-Path: <bpf+bounces-56704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C24B8A9CE21
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 18:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F36D13AA9EC
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 16:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB1B19D88B;
	Fri, 25 Apr 2025 16:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6Bhwbhw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CF318C337
	for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 16:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745598524; cv=none; b=oZq6PqACpUpRGF03ZvwWRZaysAjqcMoUIMrTYc4LchhxnDBMo2UGZHoS/1SuLxofIBEr8B/N6nyCEqiDLcWlNKFQ2Q3vnM0b++H5pfOCDIf4pqtUGTcpFIiEC0jJ+oJ+2vPknbQk1JrgjPC9FRuHfCOJHdEX3JxPEBeldHf3xb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745598524; c=relaxed/simple;
	bh=z8/fYKeWqA9YTacLItl0KjjztnHr7E6HxQp7xdUa5ok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=crwMO4yCfoi7xSkCYj0syX8SugLKMPVZbPbpaIBu/RYcbTAcxqdbIOuddgXMVCWuGiEqP9ob+KX26L1Vzo6IF0TDIuENlqvyt3tZBPh0PaOqe+hI5Qa9OUfoQ2RQB8JXqZF8wv4/fYTsv9Pw+OPRhuIYsT7vrGG6BJOVLyLJbCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6Bhwbhw; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b0b2ce7cc81so2423952a12.3
        for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 09:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745598523; x=1746203323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v56PBXB5BArns+PuHVDV2AXpm1P+JQVJm4HLz7xXhxA=;
        b=U6Bhwbhw8dG6n3LmhJ1U9whCO/c6bb69fHc+xL32GCSdSkyyBBgCgrUfnlRyg4cQgo
         dS026InPVQMQFN4kIPm47fMDTibeAumSLOqAsQL81MzxZqUW+G7UBQ4IgzcMtttxF6Tr
         8iZBAxK5Qj9B1caJjyKyTUYhd/JIPriRT8OTsSVvLqZya50sGz+V+zUiOMlF4OfxuXP0
         eMWVg1Ca7CjKHnYzgfLbbd70jbjIdbzaRG3+g05gGzy7UNbrlxvAIRi8gFXfPkR45wUS
         HDIX/pfMjQ7ycZztOnkFcL5gDftcDuW3GrUWlq12sKT7tJ7rYbqatHENg4WKCr36W9F6
         v+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745598523; x=1746203323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v56PBXB5BArns+PuHVDV2AXpm1P+JQVJm4HLz7xXhxA=;
        b=RwQlT+APY8MHo2RI6VifzFLYbTW19gNUpDrokXnnKZBHVl0XSF1HmfTiG2kUMtIyF1
         tmyUxv3EXSt0kAUhz1Oh01MIiveyIhAfxS1WWn6krDrrBxg5giNTTM1uN+Db1HvRRsTu
         tTCt2PnNDDw0Xd/5wtzFKL0xOcxlWglinXIO9y9WhyEFnaX9P22izTtqzVyHoTQ/4ALZ
         mfDdWjRB+Wn/yGghJ1gwhQ822o3KAFYfICdyol9dIR83mTFPdBEX6vr8XTFB5SKLF2Kq
         KnvnEgHt1wBrI47v44Owqpz3wXI9X5NlJM3d/l2q5dcoY3h+PMtvz2srOIPBYh/D0bfK
         0PHQ==
X-Gm-Message-State: AOJu0YyR+zgmKGGCfxRvV4i3pkUWjvJYnpjxXC8KP3q0Ab19oCCguRxi
	H5fyfVxVzpD8TDLpm/h4a118VfZMZRNEf8QnRRnJh5voMtlNr79OGUO7CSiHOV6BbxcHXaG5mFI
	BnUXcHZM4JNERUamrv0irY0oKe3o=
X-Gm-Gg: ASbGncuB/38qkp/9Gz3VtZ9+j9vp0Ss+h27jOpBpToRmrj6b/XzvtTVt1FyEHpamqGS
	PHL7+etZoF3dsl5NWlEHlINcDJemTqN/byY+nkBKa4YsvoUcCCVtLrXE+AnotXG6Lup3yr7WbBC
	RQfOjquJ75zDyHc1SK9KDqMJ8u303r/8NmIkUBA1RMWzTwGNv9
X-Google-Smtp-Source: AGHT+IGp1WizwhnlE2+m8xejUqMhofi2WhcPvHTktCxBm5dp/8BGnheGlKOOhjWNMHGk37KkRoDeXq5gxOZdUZM5hyk=
X-Received: by 2002:a05:6a20:12cc:b0:1f5:8e54:9f07 with SMTP id
 adf61e73a8af0-2045b72e41fmr4476155637.24.1745598522626; Fri, 25 Apr 2025
 09:28:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424221457.793068-1-jonathan.wiepert@gmail.com>
In-Reply-To: <20250424221457.793068-1-jonathan.wiepert@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 25 Apr 2025 09:28:29 -0700
X-Gm-Features: ATxdqUETzzq654x3epxnzD9pASvDLxFkoxL5_B-dUDTeiCCPr555cTW_rFgFiYM
Message-ID: <CAEf4BzZAypDqJwkaxJfuhFjGofe4xw-htuYNx01DFA9jm-jSgg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] Use thread-safe function pointer in libbpf_print
To: ">" <jonathan.wiepert@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Mykyta Yatsenko <yatsenko@meta.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Jordan Rome <linux@jordanrome.com>, 
	Jiri Olsa <jolsa@kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 3:15=E2=80=AFPM > <jonathan.wiepert@gmail.com> wrot=
e:
>
> From: Jonathan Wiepert <jonathan.wiepert@gmail.com>
>
> This patch fixes a thread safety bug where libbpf_print uses the
> global variable storing the print function pointer rather than the local
> variable that had the print function set via __atomic_load_n.
>
> Signed-off-by: Jonathan Wiepert <jonathan.wiepert@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Added

Fixes: f1cb927cdb62 ("libbpf: Ensure print callback usage is thread-safe")

and applied to bpf-next, thanks.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 56250b5ac5b0..ea97a84460cd 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -284,7 +284,7 @@ void libbpf_print(enum libbpf_print_level level, cons=
t char *format, ...)
>         old_errno =3D errno;
>
>         va_start(args, format);
> -       __libbpf_pr(level, format, args);
> +       print_fn(level, format, args);
>         va_end(args);
>
>         errno =3D old_errno;
> --
> 2.42.0
>

