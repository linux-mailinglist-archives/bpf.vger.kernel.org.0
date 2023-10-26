Return-Path: <bpf+bounces-13347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF097D883B
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 20:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BAA81C20F75
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 18:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083DC3A267;
	Thu, 26 Oct 2023 18:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRPuP+yI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5394E11CB3
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 18:27:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61C0C433CA
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 18:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698344859;
	bh=XVVlRq7WkgCDz5IAy49xP/EmrDSBW+zWNlqP7/3tklw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KRPuP+yIiRNCdL2NvQdlYXCwmLX36a1ZEdnFegL+8HXP1fCcL87AAGSdemJl8xqHt
	 6EOYM8JoIW65B+KJEmK1Xax2Nl1Z9/4vFr16WsWq68SJjM6ZatO+OFK2eoNwA587A8
	 aBUTKXdqg60Ph6PA80m3EXGfekmmXnQJomtTXCOaB5pbr+7gOyBgNUhLd4KCjEEtYF
	 bJwjfl1kB4uiLM24JjlZUJ43ckIpzWpJ+YLGTx5eXEijDU4IapFXwnwZ5sLxHAbLGh
	 YApByRVbTS/LX5Yom9wF20l8fsEL6uky5+SawPCmdvplOKE/m8uqOCVAablFBKUhuK
	 oEy8f45499Idg==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2c518a1d83fso20204551fa.3
        for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 11:27:39 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx2VMW0aTqQElxC5cFGTal0KjoBFqHx+ULyOtdDRrXzEG11K5Rw
	k3hf9CxQOQ7YFWrqY6TIE6eqRiB0fcnvDwoaUDs=
X-Google-Smtp-Source: AGHT+IGTu2wrYqjKeHYBr1kS9WvdM8Mgsxc9Vjs8XhGgy/ggKuIcIJOjX3sN0//vPcpQam7MJ0zqXE4dh9NeZ/0v+BM=
X-Received: by 2002:ac2:4462:0:b0:500:adbd:43e7 with SMTP id
 y2-20020ac24462000000b00500adbd43e7mr156867lfl.8.1698344858011; Thu, 26 Oct
 2023 11:27:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025202420.390702-1-jolsa@kernel.org> <20231025202420.390702-7-jolsa@kernel.org>
In-Reply-To: <20231025202420.390702-7-jolsa@kernel.org>
From: Song Liu <song@kernel.org>
Date: Thu, 26 Oct 2023 11:27:25 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7_G7LEpaJNxUeMWMmv8EYDDy==yQ09pNUAMTaxug3z8g@mail.gmail.com>
Message-ID: <CAPhsuW7_G7LEpaJNxUeMWMmv8EYDDy==yQ09pNUAMTaxug3z8g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 6/6] bpftool: Add support to display uprobe_multi links
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Yafang Shao <laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 1:25=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding support to display details for uprobe_multi links,
> both plain:
>
>   # bpftool link -p
>   ...
>   24: uprobe_multi  prog 126
>           uprobe.multi  path /home/jolsa/bpf/test_progs  func_cnt 3  pid =
4143
>           offset             ref_ctr_offset     cookies
>           0xd1f88            0xf5d5a8           0xdead
>           0xd1f8f            0xf5d5aa           0xbeef
>           0xd1f96            0xf5d5ac           0xcafe
>
> and json:
>
>   # bpftool link -p | jq
>   [{
>   ...
>       },{
>           "id": 24,
>           "type": "uprobe_multi",
>           "prog_id": 126,
>           "retprobe": false,
>           "path": "/home/jolsa/bpf/test_progs",
>           "func_cnt": 3,
>           "pid": 4143,
>           "funcs": [{
>                   "offset": 860040,
>                   "ref_ctr_offset": 16111016,
>                   "cookie": 57005
>               },{
>                   "offset": 860047,
>                   "ref_ctr_offset": 16111018,
>                   "cookie": 48879
>               },{
>                   "offset": 860054,
>                   "ref_ctr_offset": 16111020,
>                   "cookie": 51966
>               }
>           ]
>       }
>   ]
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Song Liu <song@kernel.org>

