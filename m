Return-Path: <bpf+bounces-546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AF97031E5
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 17:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86572281376
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 15:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7CCE567;
	Mon, 15 May 2023 15:52:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849F7C8FC
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 15:52:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FDC5C433A0
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 15:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684165946;
	bh=7O/7NYamSvGoG1QVJZAFoDXYRSQzNZIa299RguuTcC0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=E/cmQ4w8Ba157Y35QANYhUxnhvDRDn2z5D7M/rA9vIc0aMLpHA0ydryc+GUe3Asux
	 0x0gKJYsr7FACgi1dDXt+ubZ1M9n/A2us94L+IIZPp20c7WI/SZQNevU+Z5WYV8Ht2
	 cHFm6ltJq4w0hWlRBFAOzsE5W5G8ajHOmZBbw3E/jVnoUPzxm+vxEDquV7nGlhLv97
	 WIMSwM1rZ7LEc7tTRUm/nkQN+Eiuen74rApis0wjvPX5uZTawKHfWD98xiXBDrt5fj
	 Z9E9p5iQb8jJFXwtA8jEe20eoAizELFhrfUUuQJqRfzcjlUanelB993A9uXsQx0sFs
	 XAMLqDcv7BekQ==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4f14468ef54so15032536e87.0
        for <bpf@vger.kernel.org>; Mon, 15 May 2023 08:52:26 -0700 (PDT)
X-Gm-Message-State: AC+VfDwdp7gKaDFVMvzH6zW2gbGSlhG7DEV/YYcB/jq0ZyUNrBwZcag0
	UgVlFpgW35oIoUjI5D3SR+kOmr8M/XXiur8Bzm8=
X-Google-Smtp-Source: ACHHUZ4pcb/NRKQfkvWUptFkG5mIfQLHU517cDTM+SSVKs4+7fGsLSuA6hCXIN616l1w+lnF2BF62acY/tPTonYCzhE=
X-Received: by 2002:ac2:411a:0:b0:4ef:f01d:5a96 with SMTP id
 b26-20020ac2411a000000b004eff01d5a96mr5391541lfi.21.1684165944260; Mon, 15
 May 2023 08:52:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230515130849.57502-1-laoar.shao@gmail.com> <20230515130849.57502-2-laoar.shao@gmail.com>
In-Reply-To: <20230515130849.57502-2-laoar.shao@gmail.com>
From: Song Liu <song@kernel.org>
Date: Mon, 15 May 2023 08:52:10 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4_wBBKDfmCos+rXvYoT3H9=0W3EEzAWhS79i4-oHHYnA@mail.gmail.com>
Message-ID: <CAPhsuW4_wBBKDfmCos+rXvYoT3H9=0W3EEzAWhS79i4-oHHYnA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Fix memleak due to fentry attach failure
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com, 
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org, Jiri Olsa <olsajiri@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2023 at 6:09=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> If it fails to attach fentry, the allocated bpf trampoline image will be
> left in the system. That can be verified by checking /proc/kallsyms.
>
> This meamleak can be verified by a simple bpf program as follows,
>
>   SEC("fentry/trap_init")
>   int fentry_run()
>   {
>       return 0;
>   }
>
> It will fail to attach trap_init because this function is freed after
> kernel init, and then we can find the trampoline image is left in the
> system by checking /proc/kallsyms.
>   $ tail /proc/kallsyms
>   ffffffffc0613000 t bpf_trampoline_6442453466_1  [bpf]
>   ffffffffc06c3000 t bpf_trampoline_6442453466_1  [bpf]
>
>   $ bpftool btf dump file /sys/kernel/btf/vmlinux | grep "FUNC 'trap_init=
'"
>   [2522] FUNC 'trap_init' type_id=3D119 linkage=3Dstatic
>
>   $ echo $((6442453466 & 0x7fffffff))
>   2522
>
> Note that there are two left bpf trampoline images, that is because the
> libbpf will fallback to raw tracepoint if -EINVAL is returned.
>
> Fixes: e21aa341785c ("bpf: Fix fexit trampoline.")
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Song Liu <song@kernel.org>
> Cc: Jiri Olsa <olsajiri@gmail.com>

Acked-by: Song Liu <song@kernel.org>

