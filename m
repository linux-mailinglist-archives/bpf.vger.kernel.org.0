Return-Path: <bpf+bounces-53127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B22A4CF30
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 00:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C313E189510E
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 23:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E942823A9AB;
	Mon,  3 Mar 2025 23:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzdRogCK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4471EA7D7
	for <bpf@vger.kernel.org>; Mon,  3 Mar 2025 23:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741044223; cv=none; b=e4QnhHTzUh+5SZi3LVyfDs6TGcuVfaGjRUNVLL9QBkyaRD6CXNcCOHff6Ut663HidBA+LfB8gAeX/wL229oVSBZzg/3FQ1afXeodMzYl2c0T+uS9TM+Wok3xKY3Uf5Xtf57ODZn6PxvgNRCYVsqe0YLfVtWyCLNvA8Us/6lnOHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741044223; c=relaxed/simple;
	bh=u520ol0Vqr4yjN5C/ZUt5LBpXi4/P2cmi5SWImkz/ng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U+7vSMFII5kXv+p/O9loTPEchuBcr+8S23GBla8uNB7mxZjkT6d+xxku/8KTU4lqEG6KHt6jc1if35UOFm2qaCtNM87A8L7egKKI5bbA5hGv5u05TSra7FMulxir5XSn7p1fi1kJY9z9UMLXAKuEwzbcMnIgAj9lzefrigNb9Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QzdRogCK; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fee05829edso4482143a91.3
        for <bpf@vger.kernel.org>; Mon, 03 Mar 2025 15:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741044221; x=1741649021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OgvJob6UOE+0Sd7DVFyx/yu7hzbff6e4uSCLWQCkwBk=;
        b=QzdRogCKlDbviLQRfNd7DwCdEztRGNfCV3VO6NLkU7bLdAf/TTq03w9fK/Q+TvMGp4
         33VsU6Pys1DBtGS192WuQ2NyeNCzYyWtOPKoZcvY4j3Bcxe2zZTzjaPJKwuWDxrrImwe
         Fs4gflV9tMl0CVAak+QfIRaB25MPC3chqAzkB3cW8tr+8hwfJa+3y2DavDrDm/CjJAwS
         DLlsceKpQqAZgUyRjJgc5wipPZYVVx9dIPcGh7Zz2rCWYb1a8+0emlhgJbkgYsi8Zano
         SeTCOHhdzYeu0mPjod/THoaSW1Lvv0a98yIgo9B65b5vXqhHoKhylhlGGLsB64vjc+3n
         WU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741044221; x=1741649021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OgvJob6UOE+0Sd7DVFyx/yu7hzbff6e4uSCLWQCkwBk=;
        b=KzqX1Tms1vxXwzF57fyDAnGpCwkvYwDIA2z1DVb7IzUjS4P0ZUPeMuTs+lmi4imTcZ
         24M39f/oBoXxuEUAwKFN8Qm+et7HYy2V0wHKUJNSflnMvCwExVyU0krAF1kl8MGx9V12
         35BhmFlq4XWg8m6byVJzrxbyite2KVjcTGnf3Iu/B06eWnNgcGvniM6j0/MfILRKaI2W
         RwA1PvgBIBMs7roirDhqn9216Aeyfj1H1ISKNQvL9SdZwt7N+UWkKvFbhB0DgW337TjS
         qjKJHggWEeFNyAUpEyQBXNFH4RQN1zMsKBW9bzVJoEBXqK8KVM6SW3ih63+00KaHFIJE
         xrEA==
X-Gm-Message-State: AOJu0YyaTYlkrmRgX9prpdh+HOoRcywhATi5zRlG9Zj1RsNkSsyOwel4
	3/YH7r7RpHIFc31DtF+iEBnDwJi5dw+AKfh2DwXGJ9idoC7QYF9xvz5VTSeutu0Utu69Es39mVA
	k2eqU6pvHEQM7pl+XJFrwnBix/ao=
X-Gm-Gg: ASbGncuRoGsC3EZVq54Vxc3levBP4obbkiXUescgrzzRAgz3GoSXO9XHm/5vsSo1p55
	tYxwKqwaxDm3oVE6uU0PMEhFWavFLq8mTw3EYJgX2d0Cuu1U22JuQ/fywpzLgPg50wYxwRBnwWP
	yjBjBn+TfjnMsTDewEkSaRXLSO
X-Google-Smtp-Source: AGHT+IH6eHoSOq3Hg1LTvPagd1Gorxg9e1KlDoV9cYh8xC3UgFh0AqeU08AHRY7y07jGnhqwX+e+zKqAaPtrAknff8k=
X-Received: by 2002:a17:90b:4c07:b0:2fe:6942:3710 with SMTP id
 98e67ed59e1d1-2febab2ebe5mr21826412a91.3.1741044221359; Mon, 03 Mar 2025
 15:23:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303135752.158343-1-mykyta.yatsenko5@gmail.com> <20250303135752.158343-4-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250303135752.158343-4-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 3 Mar 2025 15:23:28 -0800
X-Gm-Features: AQ5f1JpL-VNxf7HIX68ovNLtwfw3fiPVo4z6RdB0gjXRmNSyhdvLvzQphkqZCsI
Message-ID: <CAEf4BzZ1+wojkBW+LLdKa1bUE4Jt+FhfUq_4DwzW8YOq64S1tg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] libbpf: split bpf object load into prepare/load
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 5:58=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Introduce bpf_object__prepare API: additional intermediate preparation
> step that performs ELF processing, relocations, prepares final state of
> BPF program instructions (accessible with bpf_program__insns()), creates
> and (potentially) pins maps, and stops short of loading BPF programs.
>
> We anticipate few use cases for this API, such as:
> * Use prepare to initialize bpf_token, without loading freplace
> programs, unlocking possibility to lookup BTF of other programs.
> * Execute prepare to obtain finalized BPF program instructions without
> loading programs, enabling tools like veristat to process one program at
> a time, without incurring cost of ELF parsing and processing.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/lib/bpf/libbpf.c   | 144 +++++++++++++++++++++++++++------------
>  tools/lib/bpf/libbpf.h   |  13 ++++
>  tools/lib/bpf/libbpf.map |   1 +
>  3 files changed, 115 insertions(+), 43 deletions(-)
>

[...]

> +       err =3D bpf_object_prepare_token(obj);
> +       err =3D err ? : bpf_object__probe_loading(obj);
> +       err =3D err ? : bpf_object__load_vmlinux_btf(obj, false);
> +       err =3D err ? : bpf_object__resolve_externs(obj, obj->kconfig);
> +       err =3D err ? : bpf_object__sanitize_maps(obj);
> +       err =3D err ? : bpf_object__init_kern_struct_ops_maps(obj);
> +       err =3D err ? : bpf_object_adjust_struct_ops_autoload(obj);
> +       err =3D err ? : bpf_object__relocate(obj, obj->btf_custom_path ? =
: target_btf_path);
> +       err =3D err ? : bpf_object__sanitize_and_load_btf(obj);
> +       err =3D err ? : bpf_object__create_maps(obj);
> +       err =3D err ? : bpf_object_prepare_progs(obj);
> +       obj->state =3D OBJ_PREPARED;
> +
> +       if (err) {
> +               bpf_object_unpin(obj);
> +               bpf_object_unload(obj);

I think it's best to set obj->state =3D OBJ_LOADED here to prevent
subsequent bpf_object__load() from trying to do anything (and probably
crashing). I'll add this while applying.

> +               return err;
> +       }
> +       return 0;
> +}
> +
>  static int bpf_object_load(struct bpf_object *obj, int extra_log_level, =
const char *target_btf_path)
>  {
> -       int err, i;
> +       int err;
>
>         if (!obj)
>                 return libbpf_err(-EINVAL);

[...]

