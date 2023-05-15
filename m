Return-Path: <bpf+bounces-547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B237031E8
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 17:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96B361C20C00
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 15:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D39E568;
	Mon, 15 May 2023 15:54:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8921C8FC
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 15:53:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA79C4339C
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 15:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684166038;
	bh=eXMzcC8E9qEH4tWfW/3/rvdN3Rqr/x5ZfGqubG0TEmw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Faithih8kaeTHTpFMzDI/81x/CTI/xN09OnBWZYvcZvM3Ol2CHDJXcpyUAjUtwv9k
	 uKSHhAc92Yea3ZpBC92ce/TxB/vFfIu+7JlV0ezIGXNPo/NzlFgd+YlM2lrLf6Fo2s
	 SCzsHFxzZAiX5+Oghz49T3Rw4WPPHlo8RGqzcu+i3ug+ActHaw1zA0aEIyot8Cys52
	 tmP8fa0gQYMxRvRsVsB1PIerI8O463HXssHDSASOyOAuJbCg87vOzJfsoZK/f8+Qgn
	 uGwWCWkUuXa5ali1awE5uNACuNeCtQu+h7FNGl2/1c3MikqxK+XsCvWy1OgR3Cv2Ab
	 DMNr16GaCeYCQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so14948472e87.3
        for <bpf@vger.kernel.org>; Mon, 15 May 2023 08:53:58 -0700 (PDT)
X-Gm-Message-State: AC+VfDwSUbTixGTag68XvL4BmNjw9bVUzfOtFDu04tRD+X/6SLh0yKLX
	2FSOWjfjBTDnQhpOmWrFOk4N5FgnS8qx7I3ZjKo=
X-Google-Smtp-Source: ACHHUZ5dP2zPGAzTkuHZqEw98AApUamXbvm6D8jq1F2a9uRkPcNgCJ3U5DDEFcLQORoL03s5cTLtrK6rsCB8NNuOHGA=
X-Received: by 2002:ac2:4f8e:0:b0:4f1:3eea:eaf9 with SMTP id
 z14-20020ac24f8e000000b004f13eeaeaf9mr6757897lfs.24.1684166036404; Mon, 15
 May 2023 08:53:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230515130849.57502-1-laoar.shao@gmail.com> <20230515130849.57502-3-laoar.shao@gmail.com>
In-Reply-To: <20230515130849.57502-3-laoar.shao@gmail.com>
From: Song Liu <song@kernel.org>
Date: Mon, 15 May 2023 08:53:44 -0700
X-Gmail-Original-Message-ID: <CAPhsuW545Lf=q91+L_o-ZRwpWs2xUbmoWU9CK4zNae=Dy=kSWg@mail.gmail.com>
Message-ID: <CAPhsuW545Lf=q91+L_o-ZRwpWs2xUbmoWU9CK4zNae=Dy=kSWg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] bpf: Remove bpf trampoline selector
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
> After commit e21aa341785c ("bpf: Fix fexit trampoline."), the selector
> is only used to indicate how many times the bpf trampoline image are
> updated and been displayed in the trampoline ksym name. After the
> trampoline is freed, the selector will start from 0 again. So the
> selector is a useless value to the user. We can remove it.
> If the user want to check whether the bpf trampoline image has been updat=
ed
> or not, the user can compare the address. Each time the trampoline image
> is updated, the address will change consequently.
>
> Jiri pointed out antoher issue that perf is still using the old name
> "bpf_trampoline_%lu", so this change can fix the issue in perf.
>
> Fixes: e21aa341785c ("bpf: Fix fexit trampoline.")
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Song Liu <song@kernel.org>
> Cc: Jiri Olsa <olsajiri@gmail.com>

Acked-by: Song Liu <song@kernel.org>

