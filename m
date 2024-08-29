Return-Path: <bpf+bounces-38412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B269649F6
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 17:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8F6C1F23879
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 15:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6EF1B29AF;
	Thu, 29 Aug 2024 15:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KalopebI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9D81B251F
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 15:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724945193; cv=none; b=qzvfAr0jxhTnpHzmTywhyD8vhExVQ4yz6FtDWLyGBTzOdwo7qRXWvDQA3yNCa8iZ4AaW6t+DRJ5bfKFjOVVV7IZS03nnTbpb7w79FrprqlXWl+NWySA/ykyzaI+16j87YRyTODMf1apkVMk0PYJS5awQccnbl5Ffl/TCUVX1qK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724945193; c=relaxed/simple;
	bh=UA/rpNs+aVAVIH+2o5lAyJ08ajsMYEDYCcxXL6fiYuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dxIChcMOR1I5e326w8dt7o3DY8dbKV96XYwgzXHInwkgFjRZwwk0EBq1VxDdKF6USOYLM36yW0HGL79qZI6gvoa0hzW2i2mhW47VWZuFg50yiN8lM96rUHjcSTkunbHI31yd1+tQfxrqBQO1tkareKM7j2khpr2uTzZDmKUJZQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KalopebI; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-429ec9f2155so7194365e9.2
        for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 08:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724945190; x=1725549990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UA/rpNs+aVAVIH+2o5lAyJ08ajsMYEDYCcxXL6fiYuU=;
        b=KalopebIcUPq4pta9s8zekyPwKWMMsABqQ1RamhY1iJeWoBN9JVtAbCzwTDyqLtw6r
         yFtGyTJkqGtvVYHfKQFne1oZxmHGmjZdP+G3Im5mLcCIloW9Mhfi3ggHMGJRdvT0KChW
         QwAHPpkIlUGkSITVr5C9vzYdBA2o2zAGwi3FflraOCN5Dbf/HTadGz2120DXD/yx3635
         oIXafD+eq46ljK+nmGwj0/DLrgrtH0bjaSCVdhUOzRTAtl3sfHfIJqUKFDHdgP+KWW2U
         1L/1CnTwPrTjTSbCY/ff6g0oGUmHdaqp71YwQc7UkI24y6pwF3HDtYJMjID2aLaYgAu0
         0j9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724945190; x=1725549990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UA/rpNs+aVAVIH+2o5lAyJ08ajsMYEDYCcxXL6fiYuU=;
        b=YITMvfJXrfMH9FBKRqZca8zr6T0YqftpRnQtKjPL/EEE37Sww5RkBwi76EbktXhEVA
         s94Ae9lfIS5R0xsJPUYCKuciK4lrQ/rt0c0hfF2HUCHauoXLHlubyIqeI8CnfRvIA/Yo
         58/yuAzNNcippa48lffx6ROEHDUzcg5NDdGGZEKhZTWTFHBErZMvzkIAafX6Aj641v/7
         h3cQQfP2UblwlItR2FgXERU5KpeIlA0OimMAlCPGdKEupi82px7fZ/Rsqy3DOyHW+MB3
         kHfm2rDaXIf1+kKsbSGcpGEGLOsUdOxkB3/FfQoG6VsrPKiQDd3finKF3RQIgkI+uK6M
         RNbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpiDECyD8GGVYivt8e5a6HG7RSqNeMigmxMeRCPS14IbC7I4US/QGi9m4/yugHhAGnAMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT3LKlK1xQ5d8OKs+bT5/znDQIuWD2dj+sUt0i6z55hoXlA043
	UiLR5zOcEn5/DuUY97ODflNhqWHUxqE18Bc9uso9hKML9RHovohLffDg62wb0XcxXBrc1Up8Qx8
	DogFH4jI3V8fzmi/FZmY4OpBBDdEn+w==
X-Google-Smtp-Source: AGHT+IFBaVD+tCDz9N7YjGkam7YzVfDsPcGvDhyPxCYVq1W4A1+viTuHdXUo1NONvFj7LKGrrB1U3OH3YmfF6figWRw=
X-Received: by 2002:a05:600c:1c83:b0:42b:a9b4:3f59 with SMTP id
 5b1f17b1804b1-42bb0293da3mr24291405e9.14.1724945189821; Thu, 29 Aug 2024
 08:26:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827194834.1423815-1-martin.lau@linux.dev>
 <20240827194834.1423815-2-martin.lau@linux.dev> <9bcfc97f011f4b4d5dc312e26074d0c1d744af02.camel@gmail.com>
 <CAADnVQKfuWjpDxL=0OYMe_u37tTpPgPUW3-5L7X-QVUGh5x1gw@mail.gmail.com> <bff92d52-344e-46bf-ac0c-f03e1b22d22b@linux.dev>
In-Reply-To: <bff92d52-344e-46bf-ac0c-f03e1b22d22b@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 29 Aug 2024 08:26:18 -0700
Message-ID: <CAADnVQ+jBwKQGR3LpRwZJT0G7pB+Xzf+L0gJkZdjL7UTrZeg_Q@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/9] bpf: Move insn_buf[16] to bpf_verifier_env
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song <yonghong.song@linux.dev>, 
	Amery Hung <ameryhung@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 8:20=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 8/28/24 6:46 PM, Alexei Starovoitov wrote:
> > On Wed, Aug 28, 2024 at 5:41=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> >>
> >> On Tue, 2024-08-27 at 12:48 -0700, Martin KaFai Lau wrote:
> >>> From: Martin KaFai Lau <martin.lau@kernel.org>
> >>>
> >>> This patch moves the 'struct bpf_insn insn_buf[16]' stack usage
> >>> to the bpf_verifier_env. A '#define INSN_BUF_SIZE 16' is also added
> >>> to replace the ARRAY_SIZE(insn_buf) usages.
> >>>
> >>> Both convert_ctx_accesses() and do_misc_fixup() are changed
> >>> to use the env->insn_buf.
> >>>
> >>> It is a prep work for adding the epilogue_buf[16] in a later patch.
> >>>
> >>> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> >>> ---
> >>
> >> Not sure if this refactoring is worth it but code looks correct.
> >> Note that there is also inline_bpf_loop()
> >> (it needs a slightly bigger buffer).
> >
> > Probably worth it in the follow up, since people complain that
> > this or that function in verifier.c reaches stack size limit
> > when compiled with sanitizers.
> > These buffers on stack are the biggest consumers.
>
> ok. I will drop this patch for now. Redo it again as a followup and will
> consider inline_bpf_loop() together at that time.

why? Keep it. It's an improvement already.

> Regarding the stack size, I did notice the compilation warning difference=
 on the
> stack size which I should have put in the commit message.
>
> Before:
> ./kernel/bpf/verifier.c:22133:5: warning: stack frame size (2584) exceeds=
 limit
> (2048) in 'bpf_check' [-Wframe-larger-than]
>
> After:
> ./kernel/bpf/verifier.c:22184:5: warning: stack frame size (2264) exceeds=
 limit
> (2048) in 'bpf_check' [-Wframe-larger-than]

Exactly. It's a step forward.

