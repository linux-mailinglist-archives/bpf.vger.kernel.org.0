Return-Path: <bpf+bounces-15481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A61D7F2330
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 02:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E103282301
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 01:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1DF6FDA;
	Tue, 21 Nov 2023 01:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeVOlsvi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C91CA2
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 17:38:06 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32f7bd27c2aso3748993f8f.2
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 17:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700530684; x=1701135484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1aJigs6bIhEqfiYd5dSxdCgN3ushJ+3RGItp/Zj10I=;
        b=GeVOlsviGfDyVwPzE1r1VB2E70nA79mFb1lGUUXyMf+DkTzkflL6EJrbDDq1jSZpcO
         dLEYgNWgxANOMjfCSJABvf/KaIF3yBKekkZRfWxtijw7Eu08E3B7iU9i8me3JOVTiD/H
         lvMQ7MGFrHfhTKjwJZcNxvRGB10qJ/KEjacfiWmInG8ldoLsjh+NR+nmC2CqLy7lbfGD
         FU2gmW4B4d5rO/m6/XUYk+ab/S5Pbxji2KWM/l+s5J6PCSorCjXbiadByGMB08NeSinm
         ttbKKOT1DCE8FUFcyVe1PvFD5pit52Qay2RINFG2JYqtMvV2vkrrbIGHEOT4iOiTaJUe
         /7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700530684; x=1701135484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e1aJigs6bIhEqfiYd5dSxdCgN3ushJ+3RGItp/Zj10I=;
        b=jQoesB67OnodQyQyHO+YybpFvb9PGFqiEVrBo2tu3D0DJv7+8O7wtCZBkNxqQGfDox
         6YzkgssVnqGP1z318TwbsKKwOqIM5EaZMvqJz71YDLFxPptIYo97bcSfe6obUgPe9cnD
         0FDDAsKzFkekPc61E1cJoSfAAPlidLzBA5H1UhqeQC0w5Ma/c/TW8WHeD2B30deh7m+V
         tNZvUj/7sS8Y90ZMtl6VDWms7BEFBMi0LyvpnuAryLRGmYH2vDiHEC7KVBFZGAo8PRxa
         XGo/hCzQEbIJ5T3NDMujCEHYDxRKICxgLcdksb3c8Vsm0lXT/CF606coOgUKtz5Vs9Oh
         q0Gw==
X-Gm-Message-State: AOJu0Ywih1yB0LK0IHXyI7YtYBPHQwWE3torrjvXopp8Ui99EHCuffls
	BTV0bFLGsMto8ZM2cTyNmiVnSDJLcmyv9oSIi+g5wuFqvgE=
X-Google-Smtp-Source: AGHT+IEJkReBTTQR/FWwNexSlvXJv92djUdl3KbG8onLrhVGu42DvDEuGEI6P/pR6jVRcyqihy6gQaI78AKEuGXgses=
X-Received: by 2002:a5d:4b43:0:b0:32f:932b:e031 with SMTP id
 w3-20020a5d4b43000000b0032f932be031mr5205548wrs.68.1700530684455; Mon, 20 Nov
 2023 17:38:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116194236.1345035-1-chantr4@gmail.com> <20231116194236.1345035-2-chantr4@gmail.com>
In-Reply-To: <20231116194236.1345035-2-chantr4@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 20 Nov 2023 17:37:53 -0800
Message-ID: <CAADnVQ+Mb-eQUxp-0c_C_nVme0Sqy7CST_vaCiawefjTb5spiw@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 1/9] bpftool: add testing skeleton
To: Manu Bretelle <chantr4@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Quentin Monnet <quentin@isovalent.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 11:43=E2=80=AFAM Manu Bretelle <chantr4@gmail.com> =
wrote:
>
> +++ b/tools/testing/selftests/bpf/bpftool_tests/src/bpftool_tests.rs
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +use std::process::Command;
> +
> +const BPFTOOL_PATH_ENV: &str =3D "BPFTOOL_PATH";
> +const BPFTOOL_PATH: &str =3D "/usr/sbin/bpftool";
> +
> +/// Run a bpftool command and returns the output
> +fn run_bpftool_command(args: &[&str]) -> std::process::Output {
> +    let mut cmd =3D Command::new(std::env::var(BPFTOOL_PATH_ENV).unwrap_=
or(BPFTOOL_PATH.to_string()));
> +    cmd.args(args);
> +    println!("Running command {:?}", cmd);
> +    cmd.output().expect("failed to execute process")
> +}
> +
> +/// Simple test to make sure we can run bpftool
> +#[test]
> +fn run_bpftool() {
> +    let output =3D run_bpftool_command(&["version"]);
> +    assert!(output.status.success());
> +}
> diff --git a/tools/testing/selftests/bpf/bpftool_tests/src/main.rs b/tool=
s/testing/selftests/bpf/bpftool_tests/src/main.rs
> new file mode 100644
> index 000000000000..6b4ffcde7406
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/bpftool_tests/src/main.rs
> @@ -0,0 +1,3 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +#[cfg(test)]
> +mod bpftool_tests;

There is rust in the kernel tree already.
Most of it is #![no_std] and the rest depend on
rust_is_available.sh and the kernel build system.
This rust usage doesn't fit into two existing rust categories afaics.

Does it have to leave in the kernel tree?
We have bpftool on github, maybe it can be there?
Do you want to run bpftool tester as part of BPF CI and that's why
you want it to be in the kernel tree?

