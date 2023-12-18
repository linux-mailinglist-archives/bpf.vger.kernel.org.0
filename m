Return-Path: <bpf+bounces-18219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 655E4817721
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 17:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8CE1B249A1
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 16:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2664A4239E;
	Mon, 18 Dec 2023 16:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZH5XR0tj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE77B42360
	for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 16:13:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415D5C433C7
	for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 16:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702915984;
	bh=gvNiTyLGql03vob10s6vNYuQmn/1PS9Ww+FzjA1fNPQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZH5XR0tj6fexE4f07PuvA9vz9xZUEEifruPEalnGU6N/pmhkdZJEbZLrl5nnHOKg3
	 YOtq1IUAEJz6sZtqroDN4Xp0rrbs5hnql/xqW9xddVlP7rcGfmGZOdcw3M5GIj0NMT
	 nBqjpbf1Y+uLETlssTO/K7UEcC7OtY7cIQihiWCgRexgDoMwPHa29Y5aMzWFWEFc06
	 X3yu3ObnWTdBqboAPM9SVHlTAhM3b6B6RP4sei41QjR8zY+tRH/sCg37nL0VRhlYXJ
	 Bp+FckjzRQ0lmPhHSG6iXGeXKBk62d8B3xtCts9UArUBXt3HbRcTqj1R5mNdD3YDAT
	 krST+6pDsGDvg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e1112b95cso3494339e87.0
        for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 08:13:04 -0800 (PST)
X-Gm-Message-State: AOJu0YxUL0bN/kjd4nuPIQZrvL4ozNM9ngLEzKCzJWwSxs63f0dYgT/w
	bDRJPIsm+iS3K4B6ALTKMHblTuO4onU3gB9470o=
X-Google-Smtp-Source: AGHT+IF/WaJkqkCSWGePbY0IBi5e3RUPrixWXSyo2WjPR6s5P5K/Q895kACFlwo1mwz3wDKaIA7l25eHKZNJtQiyPwU=
X-Received: by 2002:ac2:57d5:0:b0:50e:3aaa:586e with SMTP id
 k21-20020ac257d5000000b0050e3aaa586emr430111lfo.136.1702915982516; Mon, 18
 Dec 2023 08:13:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231217215538.3361991-1-jolsa@kernel.org> <20231217215538.3361991-2-jolsa@kernel.org>
In-Reply-To: <20231217215538.3361991-2-jolsa@kernel.org>
From: Song Liu <song@kernel.org>
Date: Mon, 18 Dec 2023 08:12:51 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5mPVzJrmzYDiBD3F9wQdr9q-+jFA9fy2-_y4spwFUSQg@mail.gmail.com>
Message-ID: <CAPhsuW5mPVzJrmzYDiBD3F9wQdr9q-+jFA9fy2-_y4spwFUSQg@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 1/2] bpf: Fail uprobe multi link with negative offset
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2023 at 1:55=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Currently the __uprobe_register will return 0 (success) when called with
> negative offset. The reason is that the call to register_for_each_vma and
> then build_map_info won't return error for negative offset. They just won=
't
> do anything - no matching vma is found so there's no registered breakpoin=
t
> for the uprobe.
>
> I don't think we can change the behaviour of __uprobe_register and fail
> for negative uprobe offset, because apps might depend on that already.
>
> But I think we can still make the change and check for it on bpf multi
> link syscall level.
>
> Also moving the __get_user call and check for the offsets to the top of
> loop, to fail early without extra __get_user calls for ref_ctr_offset
> and cookie arrays.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Song Liu <song@kernel.org>

