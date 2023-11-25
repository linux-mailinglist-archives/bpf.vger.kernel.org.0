Return-Path: <bpf+bounces-15854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 989DF7F8F15
	for <lists+bpf@lfdr.de>; Sat, 25 Nov 2023 21:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 234DFB21047
	for <lists+bpf@lfdr.de>; Sat, 25 Nov 2023 20:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3B53064D;
	Sat, 25 Nov 2023 20:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQf3inOT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0A92D029
	for <bpf@vger.kernel.org>; Sat, 25 Nov 2023 20:47:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C92C433C7
	for <bpf@vger.kernel.org>; Sat, 25 Nov 2023 20:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700945231;
	bh=CRZ/sUiV1NKDt5LnjURnVJSvOhGeF2I/Lsja7wUtypc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YQf3inOTwPxaBw+vk/G7YZ8dgfn6SOOkB7Li4QRmf3vj157DSFcFTDUiFBYqNG7/t
	 ZOzB9oEEY2L2ofDdwR2FNq5wVviSs9KPeYHL7rUfkXb8h7K4S15SstAvXcx7DudtqT
	 BGDbtmpZ+1KSNp3dlRGK3DxSQ+whpMX0GDp1EwffopI85uXNShq4+1TOa/mjwsLlx+
	 aN6njH2LiUVmYRUvpNMQ+HGYUQZLM1rRl4yqzbHYOU7eGwE6Bf/czOpk/iDA6qsgZh
	 D2sCR2YDZfnvb2f5w2bkn3FhKCaaSiEU6etOqCYk4l1r5B4IzO3q/8H38W7jnjgvjr
	 jHTW+x61vB2tA==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-507a98517f3so4088568e87.0
        for <bpf@vger.kernel.org>; Sat, 25 Nov 2023 12:47:11 -0800 (PST)
X-Gm-Message-State: AOJu0Yxm38XIjhGeyylhdV5gpZql/c9HesvIonZcil1nNgKfO3E25RQp
	4qdU5b9R7mUDPxlectwGRe77WTXO9J5b4q/EPJ0=
X-Google-Smtp-Source: AGHT+IHXfui2EnDscwnJIKZZ/oTGxppCmy9lz5KkuY1gizQsFDcjmjhNa2IueGyHpHaKuMKKpS2Gv++AwZg8RL5rIko=
X-Received: by 2002:a05:6512:3da2:b0:50b:a69e:4285 with SMTP id
 k34-20020a0565123da200b0050ba69e4285mr3663370lfv.34.1700945229398; Sat, 25
 Nov 2023 12:47:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122191816.5572-1-9erthalion6@gmail.com>
In-Reply-To: <20231122191816.5572-1-9erthalion6@gmail.com>
From: Song Liu <song@kernel.org>
Date: Sat, 25 Nov 2023 12:46:57 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5A6t+g77GiOJdeK0fmshe2uKg5yLSOHEuVczhzKNTvFw@mail.gmail.com>
Message-ID: <CAPhsuW5A6t+g77GiOJdeK0fmshe2uKg5yLSOHEuVczhzKNTvFw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2] bpf: Relax tracing prog recursive attach rules
To: Dmitrii Dolgov <9erthalion6@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, yonghong.song@linux.dev, 
	dan.carpenter@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 11:22=E2=80=AFAM Dmitrii Dolgov <9erthalion6@gmail.=
com> wrote:
>
> Currently, it's not allowed to attach an fentry/fexit prog to another
> one of the same type. At the same time it's not uncommon to see a
> tracing program with lots of logic in use, and the attachment limitation
> prevents usage of fentry/fexit for performance analysis (e.g. with
> "bpftool prog profile" command) in this case. An example could be
> falcosecurity libs project that uses tp_btf tracing programs.
>
> Following the corresponding discussion [1], the reason for that is to
> avoid tracing progs call cycles without introducing more complex
> solutions. Relax "no same type" requirement to "no progs that are
> already an attach target themselves" for the tracing type. In this way
> only a standalone tracing program (without any other progs attached to
> it) could be attached to another one, and no cycle could be formed.

Actually, is it really possible to have tracing programs form a cycle?
AFAICT, attach_prog_fd is specified at BPF_PROG_LOAD. So a
program can never attach to another program loaded after it. Did I
miss something? Only BPF_PROG_TYPE_EXT program can change
target_fd at BPF_LINK_CREATE time.

Thanks,
Song

