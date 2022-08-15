Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DB3594E56
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 03:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237962AbiHPB7E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 21:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbiHPB6l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 21:58:41 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714F8106B2C;
        Mon, 15 Aug 2022 14:52:37 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id w19so15724789ejc.7;
        Mon, 15 Aug 2022 14:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=bWWfdQ1fZAta1+VTRIUNVvKhFu0nb8tEZm/qx3ccvwQ=;
        b=gMMsNDgAfR3K/kxdlQnHJVEHkeY6aMHWEOiekL+yQtlq1PV4ENY5ZVqeya+0hoGUEV
         XJraAAmxmMXvqsg0S5gzez+uweUIuY92YzrdO7TTZegDsIaUP1vEjPdvILtxoMZbytWo
         M2BnOqqKyT8sANIw6rCUUK8RKiQ2KuEPZZLwPI4D1HepWXtB8qWrr+gVtlBWkcC9YdLi
         joG2kl6qRIK3caOiIgi8Djyy9r12b+aGprexYd+aimOyvKzVAKVm+j/v4faS+u0x4RSe
         WpL8vospzU1l+kWdNrTbxopLCFMogim4YF03tJfAJQEwGC/MQsWKhXmHOPjQaHANvya2
         yBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=bWWfdQ1fZAta1+VTRIUNVvKhFu0nb8tEZm/qx3ccvwQ=;
        b=6yHhJDYjBR3G9IVnqt2zP3tmVGbXia3e7WEIhrmnMkcu63/2rFECrEwCw+fEnLHCLp
         ojI/kQxt+Nm5+QqPq/3bZrRV1c4qh0+qbXq6dngYWoJ5za7SKZR2BzKoAeJTldOc8f5G
         f0xIuv3d200h0SYMKY20r2gWAkpEtMsxTqDYjm68axpHh1QpuJHuKiQ3Fud5DshyRhGB
         GzwW4s5Kf294+OMRrRECPafU1ti927UYy06COu0W851i3vz0cJcNma2JDK7h5IXZljRt
         whmN3VbB4ZOz64684YjMcU/sdwfj421fxGkNWz2Z2w5mfvswSWju1Qsh7HCN8/oSwFDB
         dqLg==
X-Gm-Message-State: ACgBeo05yjoAFXTT7VtFXUVqFjKt7G4ics7Wt0iwWpYbl6xKmUbYCWoe
        U01JkXg45I207TYG2sQWHopzSzF2K4kH/dqrfsE=
X-Google-Smtp-Source: AA6agR5yqc2mW5seoudCFFq9KdHmFHSX/7+isPGDgfz+q+1vriBOt1xoCZ++g1brGIsorwxjXXXf7/sEKshUziqGv+g=
X-Received: by 2002:a17:907:6e22:b0:731:152:2504 with SMTP id
 sd34-20020a1709076e2200b0073101522504mr11895143ejc.545.1660600353588; Mon, 15
 Aug 2022 14:52:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220810171702.74932-1-flaniel@linux.microsoft.com> <20220810171702.74932-2-flaniel@linux.microsoft.com>
In-Reply-To: <20220810171702.74932-2-flaniel@linux.microsoft.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 15 Aug 2022 14:52:22 -0700
Message-ID: <CAEf4BzYex03T7aYjLnbkfHb8vUsCHhj_DiMU6KbK29F+DyhXyA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/3] bpf: Make ring buffer overwritable.
To:     Francis Laniel <flaniel@linux.microsoft.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Geliang Tang <geliang.tang@suse.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 10, 2022 at 10:18 AM Francis Laniel
<flaniel@linux.microsoft.com> wrote:
>
> By default, BPF ring buffer are size bounded, when producers already filled the
> buffer, they need to wait for the consumer to get those data before adding new
> ones.
> In terms of API, bpf_ringbuf_reserve() returns NULL if the buffer is full.
>
> This patch permits making BPF ring buffer overwritable.
> When producers already wrote as many data as the buffer size, they will begin to
> over write existing data, so the oldest will be replaced.
> As a result, bpf_ringbuf_reserve() never returns NULL.
>

Part of BPF ringbuf record (first 8 bytes) stores information like
record size and offset in pages to the beginning of ringbuf map
metadata. This is used by consumer to know how much data belongs to
data record, but also for making sure that
bpf_ringbuf_reserve()/bpf_ringbuf_submit() work correctly and don't
corrupt kernel memory.

If we simply allow overwriting this information (and no, spinlock
doesn't protect from that, you can have multiple producers writing to
different parts of ringbuf data area in parallel after "reserving"
their respective records), it completely breaks any sort of
correctness, both for user-space consumer and kernel-side producers.

> Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
> ---
>  include/uapi/linux/bpf.h |  3 +++
>  kernel/bpf/ringbuf.c     | 51 +++++++++++++++++++++++++++++++---------
>  2 files changed, 43 insertions(+), 11 deletions(-)
>

[...]
