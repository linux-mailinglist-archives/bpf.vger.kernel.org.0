Return-Path: <bpf+bounces-19949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CF7833192
	for <lists+bpf@lfdr.de>; Sat, 20 Jan 2024 00:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A1E51C21F19
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 23:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3013A5914D;
	Fri, 19 Jan 2024 23:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYUtFW3g"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3991E48E
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 23:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705707117; cv=none; b=S7ffrDO/HamcpNtVWmL1yWAtENzAqRDiaU8M1CLRC6/oqDiv9j/1CW9vDdWd0nf1Uy+ELJuPBtSDv/eWvqAOiiBbvMOJqjVk1QrAQ6owY2+HrMCOvUD5VKHZu3v8bwrqOZEQmCiEn/g1E3jPyTpFbnMrj0DRSbyQ3d97YEMZXS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705707117; c=relaxed/simple;
	bh=8lLIchXajZfV+ZK0O8A2tOHiwM8Q32ka5EuOGnElS8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E+QrYO7UAjyxMP0j7WoVWJUm2/bvDR0IiWIg8qxOmHxIIRSkIzTFiFvmmQEEcD9kux0wTDG68qSDko9T9i8TCu1p6M7cU8p3CCbr6E5VaB60LG9WLOQpX7UkEbk0EHxczrCEWRaiAX9ELvwY7vDBF9HIhcnZ5vnRjEoxXxlIYXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYUtFW3g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E01EC43399
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 23:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705707117;
	bh=8lLIchXajZfV+ZK0O8A2tOHiwM8Q32ka5EuOGnElS8s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SYUtFW3gDjL6T8F1KVqM2tHPns9JEBEIccijEz02XFMzvXl7y9+GB5yeeNuMo7iJF
	 uKVJimjxGNk1V4m1gEmDBkOiCcNAxFUJzPfe0eyZTGZ4y0R7PS1DcEueVy5jFMpHkR
	 RaS45Cc3NW6ajlEPHv0ZSZpVqiJnDMACAozNtg5VDs0k3nbn/lXFbXt4pd1wRzDc2W
	 IXZWG7Km92DE+HvxFVIByubwzkSkCLxY86vvWZv27SnnsrbBoZqGL9QNoUb7Csk6PW
	 Q7ZHpMYFiNhSD9BJ5zuZgpKgPDc8ZRgrxEnonhBfGE9xOkLS7X5Py46u89hknRmYbU
	 opg+OVrL3C+eg==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50ea9e189ebso1512286e87.3
        for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 15:31:57 -0800 (PST)
X-Gm-Message-State: AOJu0Yxs/hvHrAoO5QQ/reag6E5uZ3OGP9FcRSxVbf9NMu9E4lpRrJTg
	fmwNSYayA6Y5rlU2XkXAf9/wcvVDBVtJ8lP4XKLCSE0khwhxfwqOT23Z/FWPJtbePzmowCn9xzJ
	vNSFPghXOsucvtOLKawieI0uqkvQ=
X-Google-Smtp-Source: AGHT+IGv6l1VHGfKnaFX3t5l2sOYxpkCsK+v7StfBwT2fGE3sjcZ16OLSXhqaw0RN+lybG3PHnf3bSVcPhw0b0i9lkk=
X-Received: by 2002:a19:9106:0:b0:50e:7c08:4351 with SMTP id
 t6-20020a199106000000b0050e7c084351mr177300lfd.44.1705707115375; Fri, 19 Jan
 2024 15:31:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119110505.400573-1-jolsa@kernel.org> <20240119110505.400573-3-jolsa@kernel.org>
In-Reply-To: <20240119110505.400573-3-jolsa@kernel.org>
From: Song Liu <song@kernel.org>
Date: Fri, 19 Jan 2024 15:31:43 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4th05b42=0ujY7jc5HQ603_+=qLnZ9qEPf8VL_Squ=MA@mail.gmail.com>
Message-ID: <CAPhsuW4th05b42=0ujY7jc5HQ603_+=qLnZ9qEPf8VL_Squ=MA@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 2/8] bpf: Store cookies in kprobe_multi
 bpf_link_info data
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Yafang Shao <laoar.shao@gmail.com>, bpf@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Quentin Monnet <quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 3:05=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Storing cookies in kprobe_multi bpf_link_info data. The cookies
> field is optional and if provided it needs to be an array of
> __u64 with kprobe_multi.count length.
>
> Acked-by: Yafang Shao <laoar.shao@gmail.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Song Liu <song@kernel.org>

