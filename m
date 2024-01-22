Return-Path: <bpf+bounces-20054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC62783773B
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 00:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEF911C23052
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 23:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D56E495C7;
	Mon, 22 Jan 2024 23:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUarzsQU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B431E4B6;
	Mon, 22 Jan 2024 22:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705964399; cv=none; b=rWX3/p85WfPg1CS4qlTBe9Dh3geGruflTPgkTgn/ZdDgBZCyrUmBJlfMFrZwCaIRTrL/kjtQu3ZiW/TrbrknmsSOthmDn3tWOrPMvTNqJDrM2FWkVrlPYlll3+RZjL3uIbyYbSDM4Ec4DwGMEkloKiYO8p8tysAvHKgaGNtlLQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705964399; c=relaxed/simple;
	bh=P+lLUFcKbgaw62nJsWY79RoGrwUu1qdo7Aga5YdAO9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d6wie3cg2xgHHF/UwVKXOCvxyDgNeJaLJnOlrws5b9NyWyzwRBPl/tzrZxzrOJIB+jCMlu5JCha6UhuMilvsavsH1GeWk+9p+OYNZsW8wR8ijm7Eq6r+tHcAktbC6wM+tx6tvHI/ITz4BRDirRHKXSgDFxVFRCXzKpC8Aplt7D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUarzsQU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1341C43141;
	Mon, 22 Jan 2024 22:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705964399;
	bh=P+lLUFcKbgaw62nJsWY79RoGrwUu1qdo7Aga5YdAO9Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SUarzsQUQmCc76k5oiHQIldqeNSjoajXTKYtOLH3AQ1jK4bwg9iAUWcW6Bcz8oMU9
	 yiZFwTVSvW+9P3IS0ECHvQ2XPgMg9cLP8FopJaoIrB6fIz8pZU4rXNlN1Hts/LkDKo
	 ewapeWBCM9wUwGgYaZogkWOb9NWBV/PcD5p9l6Bn18lWEDfpSNFQAE5zh9uWeVDa8U
	 1y5dB0Hvqbij+Of9tRseiJiJgvApynhjoL9a5IEQ/09pZWpEyB+WsLkR1xJoOWlQif
	 svbdLDuDbdnMRP3VyBrxG2FDnW8fd61nroVc3thW0xJ6ugPyVmag99vNOvQTPv0gTn
	 w2poeoBMdVFDA==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cd0f4797aaso36181961fa.0;
        Mon, 22 Jan 2024 14:59:59 -0800 (PST)
X-Gm-Message-State: AOJu0YztOMkAwNWJC5HFH0ZOLlTarGMa3g08P41Elu1O9VAgyM9Gj/j/
	31ksBb+1x6+qK061h6cGQY4GOw4pbY+3HvLHHdLZdf76PtVzRyJ6Kzh4iFilcfdn3mfq3gjt4sM
	1vEpaIOQqxge7nAIVA+TdZRrqvDo=
X-Google-Smtp-Source: AGHT+IFih/EQB2okjKYdkuLFHs5nIfhXH9B79lEyTW/QBe3Xff893sJyOY8NY1U1c6X/Qc+AHogQDgFfHHTc0mUGwEs=
X-Received: by 2002:a2e:86cf:0:b0:2cd:ee6d:a280 with SMTP id
 n15-20020a2e86cf000000b002cdee6da280mr1740068ljj.38.1705964397915; Mon, 22
 Jan 2024 14:59:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122075700.7120-1-yangtiezhu@loongson.cn> <20240122075700.7120-3-yangtiezhu@loongson.cn>
In-Reply-To: <20240122075700.7120-3-yangtiezhu@loongson.cn>
From: Song Liu <song@kernel.org>
Date: Mon, 22 Jan 2024 14:59:46 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7QpiUTaqRp=mnWvxCY_mSeuaFpiY4G9OdAZBZ6RmnPBg@mail.gmail.com>
Message-ID: <CAPhsuW7QpiUTaqRp=mnWvxCY_mSeuaFpiY4G9OdAZBZ6RmnPBg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 2/3] selftests/bpf: Copy insn_is_pseudo_func()
 into testing_helpers
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 21, 2024 at 11:57=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.c=
n> wrote:
>
> insn_is_pseudo_func() will be used in test_verifier, the original idea is
> to move it from libbpf.c to libbpf_internal.h and then include the header
> to reuse this function, this just adds more internal code of libbpf used
> by selftests. While we have allowed it in some cases to avoid duplication
> of more complex logic, it is not justified in this case.
>
> Since insn_is_pseudo_func() and its helper is_ldimm64_insn() are trivial
> enough, just copy into testing_helpers.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Acked-by: Song Liu <song@kernel.org>

