Return-Path: <bpf+bounces-19152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3D2825C9D
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 23:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0E831F241C1
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 22:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FA736096;
	Fri,  5 Jan 2024 22:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDTqx0Yh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E735364A5
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 22:53:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D278C433CD
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 22:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704495195;
	bh=JN4MrwJ8+mZT5H0IDLvRE9rkr24OJssXRb16kOf/TU8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZDTqx0Yh+wFbjNVsqUWxXATlc2dR8QH81QOW9LAyM+Rn9MLTLIlJY+CyRHtnriADO
	 Ylu0zcY+qviV5JgJSrHPPiRNyNMh+qtXxPruIKf0Z0+d93bMBR+KydfQgJgrowjNAn
	 XU22k0VYDnaKJ7v7QjwXwdMmkE5q6hohfJz1A/n8cRsWMRIg0kOCvrVWUv+MNAjUTk
	 NwhRM0sW6wcjhNIG2BCWDP62M0kBAChz4rSzcqkF3nOkV4iqQYI/DX0bxOhkFB4nKn
	 cofVm6gdDqaDEvXCojv/Xy1EEB+Dx475q2p5HflW6dBFF8Z5GEsYMHcuyRhgw9rH2X
	 fpJrQTQ4Dib5w==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50eabbc3dccso39829e87.2
        for <bpf@vger.kernel.org>; Fri, 05 Jan 2024 14:53:15 -0800 (PST)
X-Gm-Message-State: AOJu0YycUH+2tBAhEEIwEQ+Hr9dJF4DsxjBjOuqilBMYKpFB3dJt1f02
	5MI8R6+qa2N0U8il7s7Y/TMN9rlL0fsDAmiBYNg=
X-Google-Smtp-Source: AGHT+IEB4rul45fOGxLxa8DaMzZ4Utg8wfnohIcD8uc4tG2yyflxeBnOw6rDY0x5ys0aoj+MWiMN4DY4spZ3ElIV5v0=
X-Received: by 2002:a05:6512:3f6:b0:50e:7b61:cf4f with SMTP id
 n22-20020a05651203f600b0050e7b61cf4fmr20665lfq.191.1704495193253; Fri, 05 Jan
 2024 14:53:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105104819.3916743-1-houtao@huaweicloud.com>
In-Reply-To: <20240105104819.3916743-1-houtao@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Fri, 5 Jan 2024 14:53:01 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6EFyr-CrsOfsJBgCJzygV7-v52aKvLJgTBzMdoVm8pSw@mail.gmail.com>
Message-ID: <CAPhsuW6EFyr-CrsOfsJBgCJzygV7-v52aKvLJgTBzMdoVm8pSw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/3] bpf: inline bpf_kptr_xchg()
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 2:47=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> From: Hou Tao <houtao1@huawei.com>
>
> Hi,
>
> The motivation of inlining bpf_kptr_xchg() comes from the performance
> profiling of bpf memory allocator benchmark [1]. The benchmark uses
> bpf_kptr_xchg() to stash the allocated objects and to pop the stashed
> objects for free. After inling bpf_kptr_xchg(), the performance for
> object free on 8-CPUs VM increases about 2%~10%. However the performance
> gain comes with costs: both the kasan and kcsan checks on the pointer
> will be unavailable. Initially the inline is implemented in do_jit() for
> x86-64 directly, but I think it will more portable to implement the
> inline in verifier.

How much work would it take to enable this on other major architectures?
AFAICT, most jit compilers already handle BPF_XCHG, so it should be
relatively simple?

Other than this, for the set

Acked-by: Song Liu <song@kernel.org>

Thanks,
Song

