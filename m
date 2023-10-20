Return-Path: <bpf+bounces-12775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E4D7D05EA
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 02:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6CE4B2147C
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 00:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6227E38A;
	Fri, 20 Oct 2023 00:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uy0DNuH8"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C3F361
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 00:43:00 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F30CFA
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 17:42:59 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4084de32db5so2273295e9.0
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 17:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697762578; x=1698367378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WosUEZNzZk8sTLPVXmDpvL+G7MHtV5dQK8vXI230v4=;
        b=Uy0DNuH8DvfIYqc513cldv/LmDRmULImxtPIo2cDyp1NWTzsf4Dbd0SyyKukmhSBc6
         M7AYJ+7Zb3nkWsRc5LzmpRdOKzQaFXuKhbqj2qmPt8P45z6ytwAfNtZ6D+iChjzVZFjg
         6yJZQv7HoAnHDmjfXrUgqraYNefv+oXBYkq0GDvegkrkd9SFG6c0p4EQSr8MjIKLFMpc
         PO+rLDjJ5eegJRAMK191VsTXC1LXwnGJwFv87nz/USVBPPq9nZCngQE6Vi29Sc6/iLK6
         /e1K+bZPp9n4xvV7qCTZFQ5yRxBXc/96eE7i+FSY9Sc/Mo+HoFnjdMaD2O6BSdOMXpjF
         vqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697762578; x=1698367378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3WosUEZNzZk8sTLPVXmDpvL+G7MHtV5dQK8vXI230v4=;
        b=WhRFpz/jgW0s6jtc6lzgA1UnYuGu4y5ATgUOdKI7s+Vzjw0y3TaNH3PTG+Sd+TEgoh
         FmRYUNfcBaZFecQbrawnNOTVk8+b3/MGb5BP6ia1XZuDvwFaL6oaHK4o3MkG0OK3Ch3Y
         DMta8REmF8OkzoiLkvbw01UPs4vXR/U4ql5oBK7KE7VMgeBTGuiilKVHA+3rXL3xCL/z
         0dVJPpxTYwkLw43RQD7IyJutsVhzmSxumFPj9y1OlB9cTl4VWTnpK8wtFrIW1/GVzblL
         7yOPaXHTxRyHD9eWSw2CeIufCks8Wj7iStmaD2OogV4lvIKguscZ7EFnyyvQNnw/vEUn
         JsIA==
X-Gm-Message-State: AOJu0YyoiPxpF5naYUIA8bMLD5SP0lImTBBj0wpjtS3dg6vml6G9EKYr
	j3TUSd+P2zeTud/unj2osKCwlngXEbuq9EpkdUr0N9FeKnA=
X-Google-Smtp-Source: AGHT+IHjkCb9EFFWgpRved7LrHooEAiUYkqWH4797rT36Ujb7Ko54dE5BX+qmpWh1sFEJ7F1yyKKmAIyq6by0Kg3KO0=
X-Received: by 2002:a5d:638b:0:b0:32d:b184:3822 with SMTP id
 p11-20020a5d638b000000b0032db1843822mr214082wru.54.1697762577736; Thu, 19 Oct
 2023 17:42:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231005084123.1338-1-laoar.shao@gmail.com>
In-Reply-To: <20231005084123.1338-1-laoar.shao@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 19 Oct 2023 17:42:46 -0700
Message-ID: <CAADnVQKUBJqg+hHtbLeeC2jhoJAWqnmRAzXW3hmUCNSV9kx4sQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Inherit system settings for CPU security mitigations
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, Luis Gerhorst <gerhorst@cs.fau.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 5, 2023 at 1:41=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> Currently, there exists a system-wide setting related to CPU security
> mitigations, denoted as 'mitigations=3D'. When set to 'mitigations=3Doff'=
, it
> deactivates all optional CPU mitigations. Therefore, if we implement a
> system-wide 'mitigations=3Doff' setting, it should inherently bypass Spec=
tre
> v1 and Spectre v4 in the BPF subsystem.
>
> Please note that there is also a 'nospectre_v1' setting on x86 and ppc
> architectures, though it is not currently exported. For the time being,
> let's disregard it.
>
> This idea emerged during our discussion about potential Spectre v1 attack=
s
> with Luis[1].
>
> [1]. https://lore.kernel.org/bpf/b4fc15f7-b204-767e-ebb9-fdb4233961fb@iog=
earbox.net/
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Luis Gerhorst <gerhorst@cs.fau.de>
> ---
>  include/linux/bpf.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index a82efd34b741..61bde4520f5c 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2164,12 +2164,12 @@ static inline bool bpf_allow_uninit_stack(void)
>
>  static inline bool bpf_bypass_spec_v1(void)
>  {
> -       return perfmon_capable();
> +       return perfmon_capable() || cpu_mitigations_off();
>  }
>
>  static inline bool bpf_bypass_spec_v4(void)
>  {
> -       return perfmon_capable();
> +       return perfmon_capable() || cpu_mitigations_off();
>  }

Yafang,

this patch breaks several
test_progs -t verifier

tests when system is booted with mitigations=3Doff command line.

Please follow up with a patch to fix this.

As you noticed cpu_mitigations_off() is not quite right here.
The system might have booted without that command line, but
spec_v1 and spec_v4 mitigations are turned off.
Unfortunately there is no good way to check that atm.
Have you seen this patch set ?
https://lore.kernel.org/all/20231019181158.1982205-1-leitao@debian.org/
Please take a look at it and comment if you think it will help.

In the meantime please fix test_progs -t verifier

Thanks

