Return-Path: <bpf+bounces-41774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4EB99AAF5
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 20:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075A81C22411
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 18:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B53D1C68AC;
	Fri, 11 Oct 2024 18:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5ZTJ+yy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CCA19E970
	for <bpf@vger.kernel.org>; Fri, 11 Oct 2024 18:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728671033; cv=none; b=lT/Xl0cyQPXKpsAvOf1jfkiI2V6BKFHUwLZc/mh6tbb2k09Lh789jpLmAELElcy2w6EXHoD9FySFSqCgh8Nvsr788VDveiguD7sst229A0M6CQeocHQB26yG1wHGh/ahOXPIJYkSxn9vA5lgR53/AHlIirzp+xbdBDFJtUpyfm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728671033; c=relaxed/simple;
	bh=wXBJr9yzAVb+pbWmMkbfgwpxZJH49ta5N4TqlV/HbUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OKZ+9b9/twqtQ4wZ5Yuz1YvdQINSKBsXENME9y4KsF//k9eb4mO3JcFs0l0y39eSnDu1eT+C0KgjR7B2jbCO0eb3gmxEaRthUdfArbg7qkkSIgfWJn+6du89GhAQVhbpcCmuId+A66XD1M3+LACd3AxkXS9aGST0HpL0rPHRt6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5ZTJ+yy; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d4ec26709so1251318f8f.0
        for <bpf@vger.kernel.org>; Fri, 11 Oct 2024 11:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728671030; x=1729275830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXBJr9yzAVb+pbWmMkbfgwpxZJH49ta5N4TqlV/HbUU=;
        b=X5ZTJ+yyDmw7GaNBoYehBILpy6mHdHySDccJ3GT7ozEyPqBtmfHUfqhSpNQCZeZqT9
         xuTUXImuWeDAOR4vZAukijegBSo3yCh7ZudmNhM/AP5kEmZejTlo0Q8bW/qkOgIJnrCN
         cVpMpE/9KLFDiiXkARhewJxTvn4ackZxTdo6VYZ07+E+k/byQlsiqvh6USs24dgvDchD
         aMjTc3Ra7napTrMRHHQ3txFntiWF1buCmHesBtFK6pPkLglFKIW5qhhHEnlEEmAnkew6
         kEC5/nPGh9e8rVB2zQ1uEg4MrVdKrz73r/4llLOlJ7fMd6Fd+IHs/sKwjUdY765V1rQn
         73lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728671030; x=1729275830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXBJr9yzAVb+pbWmMkbfgwpxZJH49ta5N4TqlV/HbUU=;
        b=u6TiYGeVbajEO06NcAnqoLvwb+YQbBDQbZDWa7s8wj/0ckdaplO2lCJTnPKeBUY+8q
         n1i1/HmFBTn+SEd+BPSkUTIiVJ/NWC4f9XSP3k3LOcNWH6GWqv6LkJjWBzHTsbjTH6c/
         WCZcpW7/Xq7J495mqz8+PR5e91BEcwMCpYmD+cwvobhEGngI8DCUKN+ezWLv1oxf+/sV
         PHsvYrv3fJ0cO+EfgMmfF4DzG6xIuQpQuDV26M3jEu3WYMzYxa2HU3/atM/GjOH0BJV2
         hWwJXXH7L+wh+UPv/yDEyA5KS2qoFmLLHzudCd9XIHsVlJwYW6dLLwaw9E9gpMOTo2qY
         kCIQ==
X-Gm-Message-State: AOJu0YxRgtpkfdBgWkG76BKwR5o7rcw8Bg96kzpw/Mvpg8hfbMNQcoeS
	hGFaXpCBwuYavF5PcPdYj7q1aPB4EpNRojMUrPo+sZ3T3WhmXJAJedvdOXQTUSS33CS+eVOpv4H
	NmmDaT50LA4N7KwzygJ8va9mFFow=
X-Google-Smtp-Source: AGHT+IFx4CrA/My5imYbO/XkL+aBHkW/xFKnBPbd0DgUcaQC7o7qESQK62z9YXMckSljBjqCsn4/O5ccOyatTwGT4PA=
X-Received: by 2002:a05:6000:1101:b0:37c:c4d3:b9ba with SMTP id
 ffacd0b85a97d-37d5519998amr2426722f8f.12.1728671029436; Fri, 11 Oct 2024
 11:23:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008091501.8302-1-houtao@huaweicloud.com> <20241008091501.8302-17-houtao@huaweicloud.com>
In-Reply-To: <20241008091501.8302-17-houtao@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 11 Oct 2024 11:23:37 -0700
Message-ID: <CAADnVQJ-z3eFa06FhvTZc7aOJX3R7=SeoXnmgtQ5TpzGNpZ0KA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 16/16] selftests/bpf: Add test cases for hash map
 with dynptr key
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>, 
	Xu Kuohai <xukuohai@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 2:02=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> +
> +SEC("?fentry/" SYS_PREFIX "sys_nanosleep")
> +int BPF_PROG(pure_dynptr_key)

...

> +SEC("?fentry/" SYS_PREFIX "sys_nanosleep")
> +int BPF_PROG(mixed_dynptr_key)

...
> +SEC("?fentry/" SYS_PREFIX "sys_nanosleep")
> +int BPF_PROG(multiple_dynptr_key)

attaching to syscalls with pid filtering is ok-ish,
but it's a few unnecessary steps.
Use tracing prog for non-sleepable and syscall prog for sleepable
and bpf_prog_run() it.
More predictable and no need for a pid filter.

