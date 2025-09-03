Return-Path: <bpf+bounces-67312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A8CB4265B
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 18:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1D801BA36D0
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 16:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175632C027F;
	Wed,  3 Sep 2025 16:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CR7nn9HP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FA32BEC28;
	Wed,  3 Sep 2025 16:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756915993; cv=none; b=hdvYpK07GoGs3aXjghmGuhiVptwckw8JckwiHmd5f4Cfsn4Y0tcC7BhwMuOH22mI2CR/1nW6xhGdKpYEy06CsU8vBHErSGB9pi5NobBICL9ubQjQunna0gfv3HNA5/ByC/4It5IaLg8eMPA5/G9/+9aUtKozc/xlxGtqo7KEl7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756915993; c=relaxed/simple;
	bh=KV9h0jB/Dpni635qfNAzbUivui5+egl9pMeR6wNS3zU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=piTNuvcNdkozROGp3rhCpEkTHTUlNbVERgukXGJM4QvqylVzLAE9KkpK78zvUxVchzxs1k5v3whuxRJ3+sf1M5fSEepim4hCYJR74HTu+kVbmXvuwJzoWjYYe74N2T0rRDxVo9yozr2K+MeX+Lrkj9Dog8j7mOgPA4YUt5Bw4fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CR7nn9HP; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b042cc3954fso13304666b.0;
        Wed, 03 Sep 2025 09:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756915990; x=1757520790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqQ276H+ZGBj+GWdZPrO90Ud1e9U0xYuurgCHIHtniE=;
        b=CR7nn9HPtrOzquqJcLAHScEmgycdfFenLxs4LxZF/qbfjWHRBfiCBv9x4DLZZspzeS
         WTQMAMEcHwRl10zac4sS9oXFXmO5QhVhp+FIK4vcvV/+Jr4KZ8wKtEz2NA+mwGkN1Ig4
         zmkiXaZakGHHcSiI18pS8ZtRVIL8i56H6WM7ECKYowBqKmQwJs6Z1h8P7I7WlUZm+5wi
         AqUYvw6XoLnDUUQOQ4AOZnl0QCuuxM1+BRUEOlD5cl2ocBZCfG7G2dQ+CDr88pIxkdh6
         pvm5OMhHdY+zXZZfDOzNuh1UMenZmLwpwQuuJj9e+M88yII+4moK8qshtQHude21951V
         7mAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756915990; x=1757520790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqQ276H+ZGBj+GWdZPrO90Ud1e9U0xYuurgCHIHtniE=;
        b=GoYHCiMQwyY7P61YAW8dbPv0FYlNtnrMr4uPRsG+FCDS1n0s14xt9SjKCy2NsgarFd
         buQ/3CzFyfKCfFfsebVLRHRjqha11uX0tIsXXLlN+F2mQIP5XaWsb4p9Y0QE5FSzk3F0
         34Rv+Uh/XG15mt2l1rKWUkAfrOa2zvtfho9KINX6elfme0qsIVo613r7lmW5uvefUxbz
         2ytsTB733XN45m/CVpd7aKzobNuDC/7dBZP6jtt/+/qqIxWOKQlnsVcZokTpGNmQoR+t
         f7uEMtuoDSLZ0tRfADmrjSlS58Nt6zEsBbEYxjEeQs8FNRiOrp2UdDCvGt+AHWbm8Z9N
         LtlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUomXZUpZjXy35mIpMeu+nwRJrqzGAQghee8sWe+KlAH7wYRnaZ0rdKcIGToMVqDFF9/Jk=@vger.kernel.org, AJvYcCXZH0s8t1Wue3+or0WESEByoMOpHdqruNCUn9hfAayK4cB3R9JpuxFz8hKi7rmoXf8hVnBqznVOptiM4JRO@vger.kernel.org
X-Gm-Message-State: AOJu0YwzJw2DDBtqiMu+8qi2JU3nPp7GbNoPTzX9aOYSfZeBmnwE/S7S
	JmTWk/lqDZn673srfo9//LLWkHpjYMvxmrYbAtPd8Zke//RQtct6rzzTDQDbYEJsTjVEJkFUgoZ
	NYANC+eI92PeYTeztL6kezinyde2yfL42Eg==
X-Gm-Gg: ASbGnctMBbTZWk+abQlDxGtmEhhzVMOzNBM0JwpdMmijFh2ex9l4WxofvtYTeqzJCX8
	zWReDDp5YP9toDnTsEVEuxsxLkoya5IIaODYf+uQKaI4xDAwfoc7I4Z/CKIH6J8JGSyhWaxFPMv
	tTMRMOhd53wnJe2qoU0kM7lAucLyZVwRc8mukvbPm7yWOxBVRpTeblZbx4E8SYt3V5hwg7QsA+8
	0CAhlkUGbqhDfRKyJfvtatS6lNMI+DSHQ==
X-Google-Smtp-Source: AGHT+IGG9nARcHXdnW5cfbqf12EMzOAGjea8g0A5eZDL73b4moCN11elfVEvZ/SKUzEyjH8vgMpBWEHiwyMD+EjDo60=
X-Received: by 2002:a17:907:961c:b0:b04:5a68:8674 with SMTP id
 a640c23a62f3a-b045a688c30mr138899366b.35.1756915989783; Wed, 03 Sep 2025
 09:13:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903135222.97604-1-contact@arnaud-lcm.com>
In-Reply-To: <20250903135222.97604-1-contact@arnaud-lcm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 3 Sep 2025 09:12:58 -0700
X-Gm-Features: Ac12FXxMF5_Z21DPYKT6G-cJnN1Ifl2kBmk78jHTFHImaXrxBR3GfRlkFrAqMf8
Message-ID: <CAADnVQLf0wj9hV=tAA=p_GXgpQ6DxtB4heoDqTmb5dEc5P6zfg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/2] bpf: refactor max_depth computation in bpf_get_stack()
To: Arnaud Lecomte <contact@arnaud-lcm.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, 
	syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 6:52=E2=80=AFAM Arnaud Lecomte <contact@arnaud-lcm.c=
om> wrote:
>
> A new helper function stack_map_calculate_max_depth() that
> computes the max depth for a stackmap.
>
> Changes in v2:
>  - Removed the checking 'map_size % map_elem_size' from
>    stack_map_calculate_max_depth
>  - Changed stack_map_calculate_max_depth params name to be more generic
>
> Changes in v3:
>  - Changed map size param to size in max depth helper
>
> Changes in v4:
>  - Fixed indentation in max depth helper for args
>
> Changes in v5:
>  - Bound back trace_nr to num_elem in __bpf_get_stack
>  - Make a copy of sysctl_perf_event_max_stack
>    in stack_map_calculate_max_depth
>
> Changes in v6:
>  - Restrained max_depth computation only when required
>  - Additional cleanup from Song in __bpf_get_stack

This is not a refactor anymore.
Pls don't squash different things into one patch.
Keep refactor as patch 1, and another cleanup as patch 2.

pw-bot: cr

