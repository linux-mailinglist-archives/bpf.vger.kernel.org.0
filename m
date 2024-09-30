Return-Path: <bpf+bounces-40612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A22198AF41
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 23:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C9001C21815
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 21:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2763185B6B;
	Mon, 30 Sep 2024 21:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiEz7gTG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB31318595B;
	Mon, 30 Sep 2024 21:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727732204; cv=none; b=r+un9bh8FqLK9cq8jmc5P37jGfXngWhvqIbOXD7TQzOzEVM//v2VAPQCC2wfCMgmVRoOnKOQt7leRA9MHC39AVbptp0vlop6+aT5ohq6NstFW9qqQMdKN6sG69LXdZ0rG14/ZICZp36Ub2d/fxOHEKylZxpfAOXCjh5755v0TIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727732204; c=relaxed/simple;
	bh=5cuMI3om88BUUMqZH888CtpsCILIjlNN62/RKIPXdHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SjdnzY8VO8uBRkHlUilK/0yxgqiPKLEAz8ZmPWBKP/DdkaTvtQVNUZ4CluFuIAyPwk59f5KqdnJd5SWbaEil3rxdmNweFwaTRdXZM9lWN3JqrsJ5LkWyFufFvVHjmhFt8S+urxAZk9aJEugavH8DZc101jAZ1dnjBk5xSMuI1xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RiEz7gTG; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20b84bfbdfcso9910685ad.0;
        Mon, 30 Sep 2024 14:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727732202; x=1728337002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mvp0EZznMrjG0yB++1XvszXI+Lq0fFiprpYVbfeckzo=;
        b=RiEz7gTGA1gYhTojdcaxKqco7QHD8TwxjH+8G5EF0uSGD8vKplMvpdRkrZOTEToLKp
         XHdZPK3vCKaNHb+ek+0XBv//r7u5OYPrY6yl6mNBCa6nOBuKjRj14koe8oou9ct5BJnO
         TvQjFnphwJdDpQcu7kTZOI4v+zyD2C+w/rDcg5xhXBBAJ4mCHuWXHJJHThUl6juUO3js
         uq0XuDghxlnTNfSx54xxBtOpjvNKR50YicQobATiWPX/9fn/GMFvN3SP/InBSgczbs95
         ZJk7vH6QdFGWnOq3K8xy4V8yeZcyrCkvjOuFa7Mg601FTSLgBvWJ5/DsT5iz/GdkbVQE
         7EAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727732202; x=1728337002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mvp0EZznMrjG0yB++1XvszXI+Lq0fFiprpYVbfeckzo=;
        b=dPMqz3lfDqhRNVZCQJZwmNFYwzM9kIB5c/21cRam1jBaVZ1tJWeCPW7kn9BRLEmovR
         3UgJ4LYf6Hf+aM0sJGJNpQoP7wHu9TIfJti/cqOfG04qc/wo5d909VWuTZD82o6JHEAp
         TC5Co5swNPMmNdWxpof5uClG3j0blYNj5gcBK4OlygnFgCNb0LZn/5vg4Xvw9T88ID4u
         y4YBD1LigvZYYhonQDQTbiWK5HLsJlwfpM+xa/SCW7N4a65xSX/47f3fH6Bdbh5MyGw5
         gLIZGaZn15A/oGXJH4BiRPMGvKlt0OpPVNQgh3eOwxL2mUs59Twa3TrDBkD93mheZj0a
         BHng==
X-Forwarded-Encrypted: i=1; AJvYcCUB4Oh28z0bDNn7z2skIKPQjHzm573k0ZOKEC1n1EEhNKAG4zxX6HuSiCn55jKK6vA4Bbj+rcH662j6FMs5@vger.kernel.org, AJvYcCVIsUA4X0GOxzwK14DOxtRr1boKrxhkSC7A5wR7v0PN3ftulLE7tg9e9MdaoV1b2aQ1RIg=@vger.kernel.org, AJvYcCXTpQuSdJnCbYLLSz3ki6ZWRR3TqM6pQdxCEvPziEyJafrNBghvk0KEgr49Ab0RjUiG/vME53kyElhfFHXJrhbx3taH@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/eVKQOa+AwdAHjJ1S2TdhtiX0bGN4eAYmS9FAUuSy5WkqzLOv
	/UyUrpp5aTjc8cC47LHIHRmu7ZWkmbGtiyAH9WQnv6qyWe3CB56ne2YX5m1+MUseqBAfEkVYDBG
	Dilp1fu048WDyZg7FFKGdNuaBm+DKoA==
X-Google-Smtp-Source: AGHT+IGmfblU/lMueBKG/rKVb7d04yilvi5p0QesIirKJSa7t4W2iWkrYY/GCmnGDBmXIZ2SdLcgDeRdUfiDVzL0zUo=
X-Received: by 2002:a17:90a:e397:b0:2d8:8a3a:7b88 with SMTP id
 98e67ed59e1d1-2e15a1e61c5mr1478857a91.6.1727732202195; Mon, 30 Sep 2024
 14:36:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240929205717.3813648-1-jolsa@kernel.org> <20240929205717.3813648-6-jolsa@kernel.org>
In-Reply-To: <20240929205717.3813648-6-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 30 Sep 2024 14:36:28 -0700
Message-ID: <CAEf4BzbeseQimT6OFjrvC+iWOk81wTQB8Zxf03QkcED58WaKbg@mail.gmail.com>
Subject: Re: [PATCHv5 bpf-next 05/13] bpf: Allow return values 0 and 1 for
 uprobe/kprobe session
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 29, 2024 at 1:58=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> The uprobe and kprobe session program can return only 0 or 1,
> instruct verifier to check for that.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/bpf/verifier.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>

Do we need Fixes: tag?

Acked-by: Andrii Nakryiko <andrii@kernel.org>


> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7d9b38ffd220..c4d7b7369259 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -15910,6 +15910,16 @@ static int check_return_code(struct bpf_verifier=
_env *env, int regno, const char
>                         return -ENOTSUPP;
>                 }
>                 break;
> +       case BPF_PROG_TYPE_KPROBE:
> +               switch (env->prog->expected_attach_type) {
> +               case BPF_TRACE_KPROBE_SESSION:
> +               case BPF_TRACE_UPROBE_SESSION:
> +                       range =3D retval_range(0, 1);
> +                       break;
> +               default:
> +                       return 0;
> +               }
> +               break;
>         case BPF_PROG_TYPE_SK_LOOKUP:
>                 range =3D retval_range(SK_DROP, SK_PASS);
>                 break;
> --
> 2.46.1
>

