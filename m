Return-Path: <bpf+bounces-9449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0398797C76
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 21:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3655728179A
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 19:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C846114008;
	Thu,  7 Sep 2023 19:00:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF5111CA8
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 19:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44FEDC433D9
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 19:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694113223;
	bh=Q91zkIqSC22T0MafIkc5m5YRWAi93yVjzSooqBzZlFM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FMRBGmtPtVtv7G6ItyOMbR7Ut0C6OqYjvl9t7iTKs7aCa9Qxi/S0+GUmFbsG/6t1f
	 zf+0CSSSUj9xa+JvDwmdEi0WaU1Q+0cBZv5qiGyonRxA/tFfiry/XFJSMD9Hft399A
	 2iUr7dSO/bKyDM9Fcc6837HNSenMauGl8BDgyQvXbUncuW7HuDKBNsZGtW93c6xuHP
	 ZWo8mXO/rei+yi4Vr6gI5+ZFY6a4Q3ez+r/Y7TOrWFiJSTTPMEgPmk1CCTq8zcro25
	 x8km1VH+VkhGxALqc2Wg6lMgR8oFIgHe+ZhqAaNO1ZXLLgUiDACbvjoAJm3CIeUqSv
	 muypyNt5JmIVw==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5007616b756so2179291e87.3
        for <bpf@vger.kernel.org>; Thu, 07 Sep 2023 12:00:23 -0700 (PDT)
X-Gm-Message-State: AOJu0YxXuVU+41fmAXK1H6ZUH2mzZHYIwHqXQ33JC/FFbrSLkx3pGEWI
	4BehMxOuk5Nz8hb+BtKbBvlkkDw4sUz5MUO/W3c=
X-Google-Smtp-Source: AGHT+IF1Yuv1luQZBca4a2whaZCRh1EVkMkMXlvqMi4rB7MAKxosJS6saEYdJNoqHrSZdFIKWIEEzvUSU8+HjGsCLlw=
X-Received: by 2002:a05:6512:281c:b0:4fe:ecd:4950 with SMTP id
 cf28-20020a056512281c00b004fe0ecd4950mr272319lfb.1.1694113221255; Thu, 07 Sep
 2023 12:00:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230907071311.254313-1-jolsa@kernel.org> <20230907071311.254313-10-jolsa@kernel.org>
In-Reply-To: <20230907071311.254313-10-jolsa@kernel.org>
From: Song Liu <song@kernel.org>
Date: Thu, 7 Sep 2023 12:00:09 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6+khu5rWDBQCNBLobRQ91hM3e54sq+_-NM=f0ig3tDUw@mail.gmail.com>
Message-ID: <CAPhsuW6+khu5rWDBQCNBLobRQ91hM3e54sq+_-NM=f0ig3tDUw@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 9/9] selftests/bpf: Add test for recursion
 counts of perf event link tracepoint
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Hou Tao <houtao1@huawei.com>, 
	Daniel Xu <dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 7, 2023 at 12:14=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding selftest that puts kprobe on bpf_fentry_test1 that calls bpf_print=
k
> and invokes bpf_trace_printk tracepoint. The bpf_trace_printk tracepoint
> has test[234] programs attached to it.
>
> Because kprobe execution goes through bpf_prog_active check, programs
> attached to the tracepoint will fail the recursion check and increment th=
e
> recursion_misses stats.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Reviewed-and-tested-by: Song Liu <song@kernel.org>

[...]

