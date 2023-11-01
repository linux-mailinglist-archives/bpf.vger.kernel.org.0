Return-Path: <bpf+bounces-13853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEE47DE819
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 23:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A4581C20E3E
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 22:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D2D1C297;
	Wed,  1 Nov 2023 22:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSMKZyW6"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6333D33FA
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 22:27:28 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B605010F
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 15:27:25 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9c603e2354fso62097966b.1
        for <bpf@vger.kernel.org>; Wed, 01 Nov 2023 15:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698877644; x=1699482444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0l0MzE6iyG10NOMbghdiNnjZecxOoUy1Ev3HgM/KGk=;
        b=NSMKZyW6Y8uWMWhxRIc7MxLHGivNugKPtPTygJ6MQBm+nO19O4b5wu15mdXlmiPwF4
         jdn/+uhmNaBFE/7cMhMEz4FglturtTbkvJK7Qg7lMBTGWSHv6uzN4bWowd5d9oBlqX/g
         9Ala7orvXihbHtPQxWgxqsO9zTp8PlJrn9HpFwWw8R2Ajta6ylpov/8CdKXNKctWZG71
         ao7U6+P9kyJIN8DhZD6YZt7FFJZpmuMTSoQZH0H9/FOIIWmIpitDqmsfT1xeTidMxAKM
         VwjHorIJmAkou40LZcgBTtuEzFURkQMiGjFZwXIs/KFF1iWmwzE15u8+X9ZcPct1movL
         C7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698877644; x=1699482444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w0l0MzE6iyG10NOMbghdiNnjZecxOoUy1Ev3HgM/KGk=;
        b=Tt2HWJ+051IUYboL/UHxHUszqzDJiJg9HQiYASVEEJfrZQZ+IcgtvcUhJsGU3reeFW
         btiYn42DbwxOEvnb8GIwPNs5eDMg1CYEiPkyGd1QnHmk+VApnqX6R15bVw7p7Qk7IEeu
         cW1DzEX5XXwJuatrnm7xgiVrKe0zxqfzHMN1E6wuQJpiwJcGa0fpOdBmXVY3KLX/YAd/
         c2c/zoebD4xscPGQiaNOhnDu+GapkrHgcURt96hmFx/AXwBLuBWWyl+fNDg3QfB7ZE/j
         IxLOitwoBnQUfvfrOuFLxCemz/0lwJf4MhXBJ5Kre8UBZZ3CnGHRLT0AtTKy62iIgmYN
         QQvQ==
X-Gm-Message-State: AOJu0YzUSbLDUJXTLfOT2+Mfx1iEn/TBdZLh6ydFGXRAYVWGmYnbYjjV
	RUbAKX29+WeJWwEGChmct7kxIPzQXUhxViHhDM8=
X-Google-Smtp-Source: AGHT+IFb4mt5z6cLifMNTbTYICBQFTMI5h2TIPN26iPNCeRem4l8ZLMMTsT6r/ncU2Rb4ZGc9ygINTN0kFPYpBa6hcg=
X-Received: by 2002:a17:906:6b84:b0:98e:4f1:f987 with SMTP id
 l4-20020a1709066b8400b0098e04f1f987mr3494930ejr.3.1698877644059; Wed, 01 Nov
 2023 15:27:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025202420.390702-1-jolsa@kernel.org> <20231025202420.390702-6-jolsa@kernel.org>
In-Reply-To: <20231025202420.390702-6-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 Nov 2023 15:27:12 -0700
Message-ID: <CAEf4BzbPE1Y_sNhXxSJcLeptVcD6hmoQCX_suPpMYNeY1bfV2w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/6] selftests/bpf: Add link_info test for
 uprobe_multi link
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
> Adding fill_link_info test for uprobe_multi link.
>
> Setting up uprobes with bogus ref_ctr_offsets and cookie values
> to test all the bpf_link_info::uprobe_multi fields.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../selftests/bpf/prog_tests/fill_link_info.c | 189 ++++++++++++++++++
>  .../selftests/bpf/progs/test_fill_link_info.c |   6 +
>  2 files changed, 195 insertions(+)
>

Please don't use C++-style comments.

[...]

