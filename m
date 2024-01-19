Return-Path: <bpf+bounces-19950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA45A833196
	for <lists+bpf@lfdr.de>; Sat, 20 Jan 2024 00:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A251B224B7
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 23:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78C359151;
	Fri, 19 Jan 2024 23:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5UeFUvV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532801E48E
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 23:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705707203; cv=none; b=g7Gokj+3sIh28uRuV0bzByMlTraitu9AZ5rRHIyRlnUW1Naehz4KBMsmb18r4V3UxSm/DqS0hQEbYhYdm58frHJhchWwWb7Qcjla6U+xYBdjQeZu9XMWK4Qwm4g8q8Tcl4Q9chvuvgxhHeCOvTPebLmk/Pxz3l8P34LhEZiyaJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705707203; c=relaxed/simple;
	bh=mLVjCCqD40bhDcsALWbfOP5X/8yGB48uCPCLFx6kS+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VKw79v91+VXV09p15A2YR3DIc6ou/eK+DbPb7ih7xcR8+QV0X1WNXrBigf8BM8zzpkIRFNXN5AERL77D7UFiyzGAdSDnxhxiitvV6i9dL+qp/QzSaNeTkaMjEKye9U+i9lBvnawWVx4A1OsD6p0oKL8QQ8WTpomCs2norhsq03o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5UeFUvV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A5DC433B1
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 23:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705707202;
	bh=mLVjCCqD40bhDcsALWbfOP5X/8yGB48uCPCLFx6kS+s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Q5UeFUvVPHdYLowwv0ogF0bRmJSz4RCsy37vNVlTEpOX7sGPYeBG4cSibJGWp/XYb
	 id9ckU8XVsdLJ2COJUKUG7tz95GXuSx+wyv4U85lOXhWUIenV6DQLWlEg67B+7ir73
	 1el1fqM4QhxFTXD7fFmYkfMmVeqI527JfExkV57+XKm4QBNcH1zDfgPlsDx+5ztGZP
	 TnMLyX1mqCBA0w+N6qeaRsYdT13RzZBjD2631kNvhYgdFUFCuLbxOeE6M2bEj5is0L
	 9e7U/Di5LpwohAhd3a/oe4mEVX6CBvD7/t8uHsj9+52zDKiC7dvgW7oRKg2Ch1bkTn
	 T6Q1APaPSmHnw==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50eac018059so1844011e87.0
        for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 15:33:22 -0800 (PST)
X-Gm-Message-State: AOJu0Ywh1VJRL8nG+oOI/+3r2ddXZYC/IXcfAYuiTCJC0o6ls0wfIRYw
	JHoN2tgrm82W+ED4Ha4CfAZrKOB/i+O/jAyAw4WhyKvq7GqlbhDsFzXHjfu1K42cvZV78xItZ9N
	maWLoc/DEJcg1OPA8c4WpQDtlfJI=
X-Google-Smtp-Source: AGHT+IEJHQmM5rwWYTyJsG+fC0K7WZGuJBkUTsMLmZfAEMoNeTkb2ODcCQdLx5CDGOb/EteJ5xiwMwwkyx+qwTfQqcU=
X-Received: by 2002:a05:6512:4889:b0:50e:7b61:39d3 with SMTP id
 eq9-20020a056512488900b0050e7b6139d3mr222433lfb.83.1705707201103; Fri, 19 Jan
 2024 15:33:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119110505.400573-1-jolsa@kernel.org> <20240119110505.400573-4-jolsa@kernel.org>
In-Reply-To: <20240119110505.400573-4-jolsa@kernel.org>
From: Song Liu <song@kernel.org>
Date: Fri, 19 Jan 2024 15:33:09 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7FefDhrSX1Dw7dpCU8V9niwFDLXFeZ3TwtjLrs=fCjDw@mail.gmail.com>
Message-ID: <CAPhsuW7FefDhrSX1Dw7dpCU8V9niwFDLXFeZ3TwtjLrs=fCjDw@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 3/8] bpftool: Fix wrong free call in do_show_link
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Yafang Shao <laoar.shao@gmail.com>, 
	Quentin Monnet <quentin@isovalent.com>, bpf@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 3:05=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> The error path frees wrong array, it should be ref_ctr_offsets.
>
> Acked-by: Yafang Shao <laoar.shao@gmail.com>
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> Fixes: a7795698f8b6 ("bpftool: Add support to display uprobe_multi links"=
)
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Song Liu <song@kernel.org>

