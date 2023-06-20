Return-Path: <bpf+bounces-2955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B21737691
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 23:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12142281464
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 21:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F93182C7;
	Tue, 20 Jun 2023 21:22:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7421417AB2
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 21:22:14 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04571DC;
	Tue, 20 Jun 2023 14:22:13 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-519b771f23aso6816165a12.1;
        Tue, 20 Jun 2023 14:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687296131; x=1689888131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l25q0nDbX64Q4NQ/7YLY/l1l/6F0DR4cuAypL+FKwEA=;
        b=WM1Yb2Ik3akdQ+w2usD9eiDDO7nRcNDFoDjr/UbUSBXpbGVhtoKaqzRufOek6yLZB2
         +fchhqCemVgP7A5MSaaYjFhwd6R5RXo5dREqT/77fTzGyPtBESqXgNi9IQLX+5v5pwCb
         +lKlyBZWl80l02nVyV4gknoY3TAkCQ9qmBKXfc1xMIWjB4ePVHhzwLx15AZZFDF5FD/F
         dqF06hD+UBjsnsolTmfQ67v/axs9EqgcoRK+IcbhIUI9T5TBup98uAtEvycS3AQEcVW/
         gLD4cuUjE3Qzf9fo9eeAiTcw/RmUoppOuYurGx1+pVxqPOooEFW3DKoXeu7qYO9ArUog
         pFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687296131; x=1689888131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l25q0nDbX64Q4NQ/7YLY/l1l/6F0DR4cuAypL+FKwEA=;
        b=TyLU4k2xtLPfDo6gaWN/Ph6W0GFqLEtKDhUfASYNmpI7blvzu+QhrdbtMmumFnKZWm
         idP7MNizIP45ZMwTGXHFx2UYW1/iPKVjD7Vp89zyQnLjNyI0RXlPBD54PIzq12LfLUEz
         rSFAFCh9vznLDOTUk6LYwOKf957Ylx2hjaVqD6EYigXzahxTx+QgcBlnfNKvGvgNje0Q
         WXxWEdaR+JE0OBRC1YRHYi4PlJDGkWSOV5eiMpr/Z3Gi+sKEE5kJQo24SGx6R1G+hSY8
         5XfrrqwkuueHB048ag7L5EUhAiXCTTl8rhvyUyh226JCyzHzitfX00XbQjoqShRqaoGw
         FTwQ==
X-Gm-Message-State: AC+VfDxfJh+s5ANk+hCvBphmmLfqf4DYjwGDyAtD+Jve/kxbeP+FbiQH
	A6Ashf2MzCyK22ahU985116kkZONhypL2kQOAVk=
X-Google-Smtp-Source: ACHHUZ6sKZeI9lMkfEwPbiRy8jlZ95af+fSx1XHpNiG77d/mGdJWIeSei7RDjJ+MpSj9vpRGfZ+6qrMf8UriaBJqQA0=
X-Received: by 2002:aa7:d9c3:0:b0:51a:3df4:5697 with SMTP id
 v3-20020aa7d9c3000000b0051a3df45697mr8894950eds.35.1687296131216; Tue, 20 Jun
 2023 14:22:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230620163008.3718-1-laoar.shao@gmail.com> <20230620163008.3718-10-laoar.shao@gmail.com>
In-Reply-To: <20230620163008.3718-10-laoar.shao@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 20 Jun 2023 14:22:00 -0700
Message-ID: <CAADnVQLjaKbe6JgPFe+=dJWxmNwdo9rQzCjvoqJ9Frn_DOSpCw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 09/11] bpf: Support ->fill_link_info for perf_event
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Quentin Monnet <quentin@isovalent.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 20, 2023 at 9:30=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> +enum bpf_perf_event_type {
> +       BPF_PERF_EVENT_UNSPEC =3D 0,
> +       BPF_PERF_EVENT_UPROBE =3D 1,
> +       BPF_PERF_EVENT_KPROBE =3D 2,
> +       BPF_PERF_EVENT_TRACEPOINT =3D 3,
> +       BPF_PERF_EVENT_EVENT =3D 4,
> +
> +       MAX_BPF_PERF_EVENT_TYPE,
> +};

afaics MAX_BPF_PERF_EVENT_TYPE is completely unused.
Every patch should be focusing on minimizing additions to uapi.

