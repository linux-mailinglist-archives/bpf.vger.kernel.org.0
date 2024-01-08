Return-Path: <bpf+bounces-19206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E9A827979
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 21:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA9811F23FA6
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 20:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DDB55C28;
	Mon,  8 Jan 2024 20:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpcw9jTn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BA255C09
	for <bpf@vger.kernel.org>; Mon,  8 Jan 2024 20:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9201C433B1
	for <bpf@vger.kernel.org>; Mon,  8 Jan 2024 20:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704747108;
	bh=0OPhYk2xderx9pYgUD5dzUZnAeIpu2Rq+iujdsMQvfs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gpcw9jTnST9NtkRYc02XMfwC6Df/qBgap11ztW2K+10EV/9onFvjagTnu5EzE+6f3
	 j+n2su0QE/ELlQANwLL0J3nZkzXd1v9zXARWWDO4FZToBDlIx+g/BO9UWsPKs4Onc3
	 aeA7+atYlGHmXlgsdEk4XNNCvaK9GlCjLwrPUe5KR9hixs5q/3yukHHm7EMC6PJdWB
	 TsQPMMR25fSOIAnG/OFuYhRXPamgjFGNtY4VuSQN4f6B+A4F0M2in7/cjWQONMWDHB
	 j2Ccv/WY/F68RBNyt64bFl9tzNxEOjIR3EBYmr3LfcNOb/F5Vz7dtSrGkHtwjpRPWy
	 PSJzc7MtrrI0Q==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e7dd8bce8so2471394e87.1
        for <bpf@vger.kernel.org>; Mon, 08 Jan 2024 12:51:48 -0800 (PST)
X-Gm-Message-State: AOJu0Ywcb36udGu0/lsFyZuJOYX5SsaqIoS2Pl1LlYwsQoSJI/K0cNCH
	zq4GxNd7EKf8lD/IDFSEa4RyAPrYsuDcUtJ/gq8=
X-Google-Smtp-Source: AGHT+IG0Q5zyr+l2GHExUV4bCyx7GOhNUKTib9tiOfI+bFheJWhFN22UTTHjfSmycUSCabXg3ZGgEahO6FeN1hKUpYE=
X-Received: by 2002:a05:6512:4002:b0:50e:40bf:e0a4 with SMTP id
 br2-20020a056512400200b0050e40bfe0a4mr2119990lfb.132.1704747106890; Mon, 08
 Jan 2024 12:51:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221141501.3588586-1-houtao@huaweicloud.com> <20231221141501.3588586-2-houtao@huaweicloud.com>
In-Reply-To: <20231221141501.3588586-2-houtao@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Mon, 8 Jan 2024 12:51:35 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5DLQrb5oHsx309F2ATj5hzuDrZw+ZseDxy4Js6EjHVpA@mail.gmail.com>
Message-ID: <CAPhsuW5DLQrb5oHsx309F2ATj5hzuDrZw+ZseDxy4Js6EjHVpA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: Move bench specific metrics
 into union of structs
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 6:14=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> Various benchmarks define its specific metrics in bench_res. This not
> only bloats the size of bench_res, but also make the code that tries to
> reuse the space hard to follow.
>
> So move benchmark specific metrics into stand-alone structs and pack
> these structs into a union to reduce the size of bench_res.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Acked-by: Song Liu <song@kernel.org>

