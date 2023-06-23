Return-Path: <bpf+bounces-3297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF43373BD90
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 19:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 881C7281C8E
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 17:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837B0100C4;
	Fri, 23 Jun 2023 17:14:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBD1944B
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 17:14:10 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE5C1731;
	Fri, 23 Jun 2023 10:14:08 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b45b6adffbso14928051fa.3;
        Fri, 23 Jun 2023 10:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687540446; x=1690132446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNBYW2wHc9QjZxDDA2F8viEB3UJaejuAIETj8SdangU=;
        b=Pw8d/jio3zpgOoOWi8eUyxmA6YfPSzp6HJ3RItOkwOOuhPCkDc/l4jL/y60kq4bwEb
         oDhKmK89G2Su0A4pS2NWTkSXZ51795BWmz4PmYt8z8hqczIPEDOb1IztT0ixl+jWrViW
         N7MEMS08Pmj98nB1As4VZSWYGAL2K53X7zyowCvLItNhOJmDfDmHmkbuL2ZNPNf7f7hX
         WIiEb1KqtKzqirCbg6dUXHaVc/vBJKdR3LDzHbI1Uyt5GDBcCPsDkmXmRavXdNn4oI+T
         KnnusBKj7GfDsQntnkF7B6CnLDu1vYjjWGyOpSeOh6K/EzOwVpFp/3bMDx39X13bqlYM
         hrUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687540446; x=1690132446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNBYW2wHc9QjZxDDA2F8viEB3UJaejuAIETj8SdangU=;
        b=NRhtd30Y+YwsonrmHIHARKZHNtuf/zONuowkByj2Q0quX+bhttb5ml6IqDPDBu2gih
         MDLdgKPFNsviLP0dYbdE88tf0n4IhE85AU9OuMO/XoT77zW7cnYBEr+DaGZZ7iUUklGs
         Fz54RU9XHkf3LSD+wQ3/St2+TZ3NEsjsK9BIqPx19lxC4OnD2IPwRlLb00OLdD/kJsBA
         yUQrlP+gyNInX3pr5o+YXRSCfoixWrroDRhurvwr9WMwCG8MNw5LBHvzYId2lB2vgghz
         IctUO6EDSpbx1XJqtRHFahQhNmnp+mejsi5c40PFZB8X0pDPt8I1mIxBJXJl1+jsFjcS
         51VQ==
X-Gm-Message-State: AC+VfDwcBDQpQgpv8dIrgv+Evbbnh+XIvVgHrFKKZq1UEvDMoVj/IC3x
	tyuZBBrFqaT2y9s5fkHrZNBMU33xbW234nhO4no=
X-Google-Smtp-Source: ACHHUZ6rhL8tSX7f/fRfFTQCU7NJFD1+Y90OCRMl2C9BXB7rjUTy/i3FzWk9uK09fHWQnrjlHZZX+SQq8Ki5bspib9w=
X-Received: by 2002:a2e:8085:0:b0:2b4:76d9:e6cc with SMTP id
 i5-20020a2e8085000000b002b476d9e6ccmr11264075ljg.17.1687540446187; Fri, 23
 Jun 2023 10:14:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230623141546.3751-1-laoar.shao@gmail.com> <20230623141546.3751-12-laoar.shao@gmail.com>
In-Reply-To: <20230623141546.3751-12-laoar.shao@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 23 Jun 2023 10:13:54 -0700
Message-ID: <CAADnVQL5b+qnKc74bqi1UJ+PXjE81ZvATDEJJcsjV=1UDaSpdg@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 11/11] bpftool: Show perf link info
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

On Fri, Jun 23, 2023 at 7:16=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>         pids uprobe(27503)
> 6: perf_event  prog 31
...
>         pids kprobe(27777)
> 7: perf_event  prog 30
...
>         pids kprobe(27777)
> 8: perf_event  prog 37
>         tracepoint sched_switch
>         bpf_cookie 0
>         pids tracepoint(28036)

uprobe/kprobe/tracepoint are really the names of your user space applicatio=
ns?

or something broke in bpftool that it doesn't show comm correctly?

