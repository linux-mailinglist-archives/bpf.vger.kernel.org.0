Return-Path: <bpf+bounces-3214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9041E73AD41
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 01:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C14B51C20CE9
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 23:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C1623C7A;
	Thu, 22 Jun 2023 23:37:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B602108B
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 23:37:26 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8307211D
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 16:37:25 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f8775126d3so6312009e87.1
        for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 16:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687477044; x=1690069044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+AuM36eXOtsjFQBmuO8yry0YQw9InFR5SnkDwQ2TBRA=;
        b=buGaHdp+kJ2Ks2IZOnCFKt4A2wnyfhOB4CKQIEd3nUOneHLa2k+dJzGDqjbCX177QJ
         jznEQreJHZuN2qtB30R8yDBIguwr73p7C1Z86+YyIZXv0kPrW3hsrzVOQnOXbPQ6JwE0
         DRVidiw3nCsxaDsXwcHpNKLW3YuyMQfZJ+1/7rNmBBfQaKb7n7m/7Wa0+k+D44YjVAz7
         ji0vgxnmVNCAT6f23U/GoNQFUiLeSdK/Fa5nrwy4emAKootS2Pov2+FYoRUzH/GftSmP
         lvNnsnsys9IxDG3Q5NF5iIXP02ftD6s673yOU8UAEJc15UInr9uIctIEUoffW528Jqjr
         TOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687477044; x=1690069044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+AuM36eXOtsjFQBmuO8yry0YQw9InFR5SnkDwQ2TBRA=;
        b=cCFndahOBlvB8tt+aWP4nu5EZzLPrHrsysS1oKx2jX2Uqds+P6gCS1TuCQBDIZpo0A
         RwBpVOyboqV/v8VWH0g0R21j71WbjTMf7vqkWFfJLhcy1APdScKiKfBYzhOn10ivkYM/
         2nofAM6LKXCHv+6JPK69/yjU5i/C+6e34BNNQK26QmonVlBPxI1JPsPjPKeBHnKfTIJB
         ArvE6x+QxIN+DVhmM9DD27KHUNDBN3/szs0oiq8LNhEhfBRCcQ5HH0w2voiqaBJZu8HB
         GJbqs9bk80PnuxmlK5nB7p1FtMLDX0xrTL8Tnf/FmvtUeQCmX3jsW1MmqBNAkv/iCHnv
         SaAw==
X-Gm-Message-State: AC+VfDy8mL8rvoZQonKDPJm1MMACmnw9zw+jE9eE6/ixFFb2saXn5LPo
	Pcj7DfbVmuiLcHtP3O5iyLdpawr0Vjshn859pgQ=
X-Google-Smtp-Source: ACHHUZ4LRSNHONZTfLhpibddEaTvX2MMR9hKUnOMlfnUaWPFaYvCbq/SlNXKfoaUqB41eGwitoLrxj+k3LDHQUog3JU=
X-Received: by 2002:a19:6748:0:b0:4f8:6600:4074 with SMTP id
 e8-20020a196748000000b004f866004074mr10115092lfj.17.1687477043498; Thu, 22
 Jun 2023 16:37:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230621120042.3903-1-laoar.shao@gmail.com> <20230621120042.3903-3-laoar.shao@gmail.com>
In-Reply-To: <20230621120042.3903-3-laoar.shao@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 22 Jun 2023 16:37:12 -0700
Message-ID: <CAADnVQKSqc5LQi2x7nkoVK3JHbqZDKc1E14ODy6HQSEdup6TFQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next] bpf: Add two new bpf helpers bpf_perf_type_[uk]probe()
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 21, 2023 at 5:01=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> We are utilizing BPF LSM to monitor BPF operations within our container
> environment. Our goal is to examine the program type and perform the
> respective audits in our LSM program.
>
> When it comes to the perf_event BPF program, there are no specific
> definitions for the perf types of kprobe or uprobe. In other words, there
> is no PERF_TYPE_[UK]PROBE. It appears that defining them as UAPI at this
> stage would be impractical.

and yet that's what your patch does.
New helpers are uapi too.
So no-go.

Just do in your filtering bpf prog:
        is_kprobe =3D event->tp_event->flags & TRACE_EVENT_FL_KPROBE;
        is_uprobe =3D event->tp_event->flags & TRACE_EVENT_FL_UPROBE;
when it's checking perf_ioctl.

