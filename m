Return-Path: <bpf+bounces-19956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E82798331AF
	for <lists+bpf@lfdr.de>; Sat, 20 Jan 2024 00:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E6A51C21206
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 23:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079E659173;
	Fri, 19 Jan 2024 23:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXr7YtON"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F6E59162
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 23:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705708222; cv=none; b=R/U5CxDg/LfeovSgmjq+vTmBA/nxFmDeb7EpHr2jgNN2rjl1JPfJKLCf+48V/1lu5I2+BAiVePNc0t1myB/VUeuFKdfz1WjkKw0G1xFL824VkDK9wWEKTUfXJacHbAvKxKrkKGCynlMF8FdsZsMGA9Zg9yJah5mT5xwJJTg6Ddg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705708222; c=relaxed/simple;
	bh=2m6ZHd38iTXPHwhOdofUoO2VlWlTEL1Jwk3H28cj6vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qwy06WT+tNyquSS1zdwf86eo+U6gaTtAEuCosjW5uI4/I5tPT15C6VL484WyCvVt8dRdbdq61FChxRbD2EUyqbAIOp+NNM3t1KeXj9VTlhXG27TmeSLSmZLsFsn1F5otVIjoZNnexeAP4uzipenNbIDrx9VwbY0YJ8bgStnBBGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXr7YtON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03775C433F1
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 23:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705708222;
	bh=2m6ZHd38iTXPHwhOdofUoO2VlWlTEL1Jwk3H28cj6vw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IXr7YtONdWALWijSDD/STcQyKjxiRz+X/S1g5szS/BnmEiTcD/8aiCWndsot4+2Ct
	 jFj7fyE4Qe2WHmye+vVU95gB8dmy7ewo1qG88RvGbluXvU/EH06QfndDJv8bLId1Jm
	 iL4xYMe923RsnyE4097kce8ZKTFPRbRjMywnGWx5bcXxFepBeZdYNYLTlHYMhZpBFX
	 AB8V1PkfwXusKLoURGUuYEJGLcuN4E+5RuO/p4Fmn0dYtPRFeCKIIOWd98IlRGxoLM
	 Wys9twj1rH8dTSDrivX+scFEAarjLKgL4fMePqAjGv35LOzy4ib5CnIYQ1h9XPwjL7
	 JsrYraSKtwzxg==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50eaaf2c7deso1564194e87.2
        for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 15:50:21 -0800 (PST)
X-Gm-Message-State: AOJu0YxLfQbpRLv2fHSVN6GIpPN8MG3XklSBN8RUz31IGDxUPJVyim23
	hOCe3q+K1BKWh1uFwD3JUQeXEiuGAI8DtzXm+y5eCQFU7/PtRP0yT0xoY3nHK5KFVq8nZTNQFa5
	XDlm97nkNtqwiTEy5vRh5S3B8MNI=
X-Google-Smtp-Source: AGHT+IG3L6g9fbfjQRMOO/Uf4whT2KT/YWUJdpBAcJ+/sU0Ai3Vjcj1ZTyLUYXPI5mCgkHP6IXXcxs8ayzhxqPaIOmI=
X-Received: by 2002:a19:e04b:0:b0:50e:7bbb:55c with SMTP id
 g11-20020a19e04b000000b0050e7bbb055cmr170747lfj.139.1705708220251; Fri, 19
 Jan 2024 15:50:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119110505.400573-1-jolsa@kernel.org> <20240119110505.400573-9-jolsa@kernel.org>
In-Reply-To: <20240119110505.400573-9-jolsa@kernel.org>
From: Song Liu <song@kernel.org>
Date: Fri, 19 Jan 2024 15:50:08 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5NOMfa5iu_rHbL6GEaB9GPdUYnyxe3URdWzMVPtFqSGw@mail.gmail.com>
Message-ID: <CAPhsuW5NOMfa5iu_rHbL6GEaB9GPdUYnyxe3URdWzMVPtFqSGw@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 8/8] bpftool: Display cookie for kprobe multi link
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Quentin Monnet <quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 3:06=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
[...]
> Cookie is attached to specific address, and because we sort addresses
> before printing, we need to sort cookies the same way, hence adding
> the struct addr_cookie to keep and sort them together.
>
> Also adding missing dd.sym_count check to show_kprobe_multi_json.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Song Liu <song@kernel.org>

