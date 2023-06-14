Return-Path: <bpf+bounces-2607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0A3730A63
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 00:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB5F61C20DB2
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 22:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707B6134DA;
	Wed, 14 Jun 2023 22:08:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39794134A7
	for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 22:08:06 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34031A1
	for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 15:08:05 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5695f6ebd85so13992887b3.3
        for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 15:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686780485; x=1689372485;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x3BUJLDspDnJhEEyf+azmgiFOjJ2X54+mzIKWsRlcE0=;
        b=N3p52AIWMxc/Elpz8txy9HvdmfisqXbrd7PNb4MixAl/uoiJRiLkJqugVLOEx4Vrbn
         FEr4aURTqna51lpuCS5kb1HwgEn1AX2MGsqvXliZMUyRgSWPqH7QMOvHZkphMf3YFI/F
         5mRIzIamfv8/Ii/8GQF4imMH6WWUXxAD4Aif7jbqVgLrcbJnC96FYZo6oTFP4EmgM6J7
         bK34YSI4atUPlHcPwlzIXfOu2QgeBhcPSsyaHj5hrCD6cTuqzEg6KE6Lg0mhxiU3O9fJ
         Tfojb1YpGauGmZ2n33KIh/ZYaBiQTlvP/cRgfKbMZLLLZbjrZnQiZGX0wYvOSnY6CDX0
         dQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686780485; x=1689372485;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x3BUJLDspDnJhEEyf+azmgiFOjJ2X54+mzIKWsRlcE0=;
        b=EbS9sy1VgMkbOo2OJ16i6yXxKpZqMKOk1QALPtUc0JfupH4iDnJvP9t0jMBkIJkM/O
         8x5X+/BGiRfoZBMISBpx/agIgzwMbtCNsmEfzlMsJ0u1rWzIPsjA2MDREIP0GiuE7j1X
         z/NpXCXQco1GubxWW0oDQtDcV/JYZVSgRx8f+bCS5nYHkM6unGK0FWdBR+vYtV4Qcrgm
         sfY884/5SScS0CAsmfAbVFk/UJR2egNOMEhWdLme7o9X5XFLbSqWlzeDkoEtPcWNu0b+
         Cr9xFXi0MZ6xSVyfAGGJz3FAegr/sZs+FdRqARTnoF1ANTtjaWK0NrLZEVHZaIqReNnY
         pkBA==
X-Gm-Message-State: AC+VfDxh82mXlMnE8AyRPdHUPiQlEYWD1ALIOzBWl3LzMX6R3ZOhhSlr
	IbkuHCHh0gFdIuOSWwChV1m7ZLg=
X-Google-Smtp-Source: ACHHUZ7zCsNNz5sEJkXpC7NOxRmeFDGj+nZBU27IX3Pujt76AV+qlOW1p3GYDhcoC68Y0YQctO1i+qE=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:4325:0:b0:56d:502:9eb0 with SMTP id
 q37-20020a814325000000b0056d05029eb0mr1367581ywa.6.1686780484915; Wed, 14 Jun
 2023 15:08:04 -0700 (PDT)
Date: Wed, 14 Jun 2023 15:08:03 -0700
In-Reply-To: <20230613223533.3689589-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230613223533.3689589-1-andrii@kernel.org>
Message-ID: <ZIo6Q60/OdG6AqhW@google.com>
Subject: Re: [PATCH bpf-next 0/4] Clean up BPF permissions checks
From: Stanislav Fomichev <sdf@google.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 06/13, Andrii Nakryiko wrote:
> This patch set contains a few refactorings to BPF map and BPF program creation
> permissions checks, which were originally part of BPF token patch set ([0]),
> but are logically completely independent and useful in their own right.
> 
>   [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=755113&state=*
> 
> Andrii Nakryiko (4):
>   bpf: move unprivileged checks into map_create() and bpf_prog_load()
>   bpf: inline map creation logic in map_create() function
>   bpf: centralize permissions checks for all BPF map types
>   bpf: keep BPF_PROG_LOAD permission checks clear of validations
> 
>  kernel/bpf/bloom_filter.c                     |   3 -
>  kernel/bpf/bpf_local_storage.c                |   3 -
>  kernel/bpf/bpf_struct_ops.c                   |   3 -
>  kernel/bpf/cpumap.c                           |   4 -
>  kernel/bpf/devmap.c                           |   3 -
>  kernel/bpf/hashtab.c                          |   6 -
>  kernel/bpf/lpm_trie.c                         |   3 -
>  kernel/bpf/queue_stack_maps.c                 |   4 -
>  kernel/bpf/reuseport_array.c                  |   3 -
>  kernel/bpf/stackmap.c                         |   3 -
>  kernel/bpf/syscall.c                          | 155 +++++++++++-------
>  net/core/sock_map.c                           |   4 -
>  net/xdp/xskmap.c                              |   4 -
>  .../bpf/prog_tests/unpriv_bpf_disabled.c      |   6 +-
>  14 files changed, 102 insertions(+), 102 deletions(-)
> 
> -- 
> 2.34.1
> 

Since I took a look at this as part of the original series, and these
are really non-controversial changes, feel free to use:

Acked-by: Stanislav Fomichev <sdf@google.com>

