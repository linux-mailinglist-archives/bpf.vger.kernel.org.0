Return-Path: <bpf+bounces-49132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC29A14691
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 00:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84C6E188C7B3
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 23:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279571F3FDD;
	Thu, 16 Jan 2025 23:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEKrszzj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1801F3FD5
	for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 23:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737070493; cv=none; b=q+zsfdctJJeT2cd/detLj1TCYD84UD72aSeu+uEieR2dXwlGV2zbHGGC27sSxMcDC07ScAVGTCYwIQ/y92EFhEtgRpyzvmLU1WYomPG13XGrjLfj0Q5SvEwJiNvr68AbzTaEDCN6QMHY/Z8oy4N+li5I4oCbo9VN8E9o/HAbhgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737070493; c=relaxed/simple;
	bh=lG9P1koFl8VcWFa5KL6l9xL+iqBd5vkpyZtd/IgqIgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D45ufxOpbMQXpZdMaxwGw/wBFkTj4i3pbMc1ypYW4fFpLZRQMDxWtUsPxwhwSj2hhGoudo0j5mS9dIC9Q71hdVGgTW7PHbtZcq8CHeAWJxrUPQrobNrodSfTP7Bz5KlATMbC5Xas/Jd2K2kUDm3cRhJLhgc8ERnknklERSzvrTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lEKrszzj; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2efb17478adso2658293a91.1
        for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 15:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737070491; x=1737675291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P16vfkZUkQgdF+oOQRhbmRf3SdkIZTrN2wT0cMm6t6g=;
        b=lEKrszzjgylwn0cHCL3HP8fZMMk2S+RI3Zs6AO3T3TNNQEYaSbPvXdboc7wYIlshKd
         GtV6iDVcNeKCd0iyU0CvoSrANgnZ1nbxREFYqyC93GZIagPIXXiDiHP5fqsGukJNzSAn
         Os0X2x992Pa8dbcNX5NCj+1vh3d180M9KCZVAXGvXcF58Cw/y395gHK/T1VM5a+lDVgY
         zcO9xe5rKgqIct3WfkFwaPVYwO5g9QYa05TMA37cMM8WezE4+AJjevmhPhKeCaV/OLCF
         Wgf3xaOCy60V5d3kAtEuWIiMZgUN3MJGY4Gu2TuBFS6w+0mSM0wxGtFLmRM0Tiz4MQem
         rxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737070491; x=1737675291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P16vfkZUkQgdF+oOQRhbmRf3SdkIZTrN2wT0cMm6t6g=;
        b=KkX5w7vJxeNJTY4tuIl4dw1Ya4pkHen2rrSzRxAu7zU+fLiM6vlSIOd+G3uEgZ0f1w
         gzQ4OgiFQ9BteAJidA7mbuSs5hp4P2vtfw7j9bAQvDU+S/CJTotvG9PqeV9Q3/tfLeg2
         VRq6m58xkL+MS5AOnJhUznXhw8u5A8iRj0iw0PZG0BjBNnRcrGRGRT1OlllGVYeXSRtM
         wUFwDKVcik8aFN8w23dANGA+d58AnI4SryV9XFY9D9P9kHdFP4tTBIV36lNydn7ZohM4
         B/br/EBU79igOmsbFuR57nYuBH92BbzVeJ020VNGHkUiUweUlgYeJetBtIGkJkhYdAoO
         QTcQ==
X-Gm-Message-State: AOJu0YzE12Fuabm9neqvmln/MQNmAMudMGzTr9DLTA5SqDBLvbeFvq1Y
	zoLo7K+4i5FRyUhrUzsZtgv0oucUm5YayxPlMLSYQoIui6tsnXwJ7xzepGcLxuIm7UKQwnDuFZb
	Qt9aH94ow7he693cmXFx4H7lY12I=
X-Gm-Gg: ASbGncv4dvH1FXUk0ArpfAWuafwqmhrEOaLi71Cd79X/B8uhGNi5j7GBS0kh2a8XzZp
	TEcjSQcvXgKLzQkfgcAShtmRC0SecF42V/5rG
X-Google-Smtp-Source: AGHT+IHFbc7u2ZL6XTFPIq9pQAP7JStADiHnkQ+RwKGfcbD0vVW3HpPioiPX985M/WktwrdGPRXF5bQ1tzLxOTvVJR0=
X-Received: by 2002:a17:90b:534b:b0:2ee:b26c:10a0 with SMTP id
 98e67ed59e1d1-2f782d32bc6mr691859a91.24.1737070491461; Thu, 16 Jan 2025
 15:34:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115100241.4171581-1-pulehui@huaweicloud.com> <20250115100241.4171581-4-pulehui@huaweicloud.com>
In-Reply-To: <20250115100241.4171581-4-pulehui@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 16 Jan 2025 15:34:39 -0800
X-Gm-Features: AbW1kvbVtgnhaiiB0lAsErdU_gQSUQEoEB1OW5ksBvUoU0T0_zW7qpRkxbkJmkE
Message-ID: <CAEf4BzYvbeP16EoKFgfgEQwRw_zfiYVu8rRx8VLTxk=2HuxoNw@mail.gmail.com>
Subject: Re: [PATCH bpf v2 4/4] selftests/bpf: Add distilled BTF test about
 marking BTF_IS_EMBEDDED
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, 
	Pu Lehui <pulehui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 2:00=E2=80=AFAM Pu Lehui <pulehui@huaweicloud.com> =
wrote:
>
> From: Pu Lehui <pulehui@huawei.com>
>
> When redirecting the split BTF to the vmlinux base BTF, we need to mark
> the distilled base struct/union members of split BTF structs/unions in
> id_map with BTF_IS_EMBEDDED. This indicates that these types must match
> both name and size later. So if a needed composite type, which is the
> member of composite type in the split BTF, has a different size in the
> base BTF we wish to relocate with, btf__relocate() should error out.
>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
> v2: Add test about marking BTF_IS_EMBEDDED.
>
>  .../selftests/bpf/prog_tests/btf_distill.c    | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>

Nice test, thanks! Applied the series to bpf-next.

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_distill.c b/tools=
/testing/selftests/bpf/prog_tests/btf_distill.c
> index b72b966df77b..fb67ae195a73 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_distill.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_distill.c
> @@ -601,6 +601,76 @@ static void test_distilled_endianness(void)
>         btf__free(base);
>  }
>

[...]

