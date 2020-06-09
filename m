Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06EB1F45AD
	for <lists+bpf@lfdr.de>; Tue,  9 Jun 2020 20:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730749AbgFISTM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Jun 2020 14:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388847AbgFISTK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Jun 2020 14:19:10 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635B0C05BD1E;
        Tue,  9 Jun 2020 11:19:10 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id u16so13080263lfl.8;
        Tue, 09 Jun 2020 11:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8czp2mGud/X9y8SyDAs2+lXPkjmhftyAJy2rrCLMh7w=;
        b=LZqbSx12x35LLKdUmVUSmHuoMheWg3Tm+NXcuDzeepDPMMH0UCb1N2L0jyxK7TbyvI
         E35VVaQ+Z7Y38/aPC0+UHNVxS4jRMHme7YMCO4pz35HgHeWU22fJ2hv0mN/+K8S5slfy
         k9Vyi2qYFLBDFPbfCG4YiilDap4zxInhhtLj4xAm3ykX5qgTORMmJ0NwzK4VLNv2htaL
         8g7Bo4+teHW84V4Wlc4kN/Oq42hyjd2xfsQm95cka7tas9lGp7wJYMEJc1PdYWCyO1mC
         e1TirmSj/ilv70OZaQleZsWp6YgGn9fL45zoppLglrp/HbaljykhJhq6x6Q01AlwmgdB
         kxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8czp2mGud/X9y8SyDAs2+lXPkjmhftyAJy2rrCLMh7w=;
        b=HOOexHso2/EgosGz0RPkon8u9+wUERTYETy/9vU5X4eVsVFmD024AZhYM+DAbTtD7R
         5YvtY2dyLtTlMI0YQMirO1OQlrhaBGltRqyNEiUXQeSuWWn2HP6hyGj97zD0fSlBl2wz
         O0VVXRwgqfgI0gZxT6apJsFyUYhm0D6Lo3rPWtbEF9U05QuRoLyWI1lqmysjohJXClXN
         ACsG5VSyYrF7tZg/tu1iuEWWkkmGS0nxDh3NC9pPI5EO8+aQhV5QxQVwremkuoehCXDC
         OKaF5+fyiM0cy8qYOHFEQtn2sS9Mjoq2gjW10STGrbZgL91Z8BHW1MbqFqOnlC6gkQAO
         AQcw==
X-Gm-Message-State: AOAM533n3TSfgPpJtDrU/evgZIwui7MG+GcM/b/vYrZsx6I70hoUWPGG
        SvgBE/F7fjMw9PnWH/moRZ+Qm7JUDwExG9qEwaU=
X-Google-Smtp-Source: ABdhPJwJgkr+goe4IPDGLuPCQCuWqxBkd3MNiQkky0sI9TT2JC0L2pk6zNTvXPm+sziwRZVmsDOUBgsnUMR4Fp0WY4U=
X-Received: by 2002:a19:987:: with SMTP id 129mr16215034lfj.8.1591726748546;
 Tue, 09 Jun 2020 11:19:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200608124531.819838-1-jean-philippe@linaro.org> <20200609161234.c0b1460e6a6ce73ba478a22a@kernel.org>
In-Reply-To: <20200609161234.c0b1460e6a6ce73ba478a22a@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 9 Jun 2020 11:18:57 -0700
Message-ID: <CAADnVQ+1CsKo1wdY6hUwExP8dnCBDhjoWCjoHp-jTvOoghPh4w@mail.gmail.com>
Subject: Re: [PATCH] tracing/probe: Fix bpf_task_fd_query() for kprobes and uprobes
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 9, 2020 at 12:12 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Mon,  8 Jun 2020 14:45:32 +0200
> Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:
>
> > Commit 60d53e2c3b75 ("tracing/probe: Split trace_event related data from
> > trace_probe") removed the trace_[ku]probe structure from the
> > trace_event_call->data pointer. As bpf_get_[ku]probe_info() were
> > forgotten in that change, fix them now. These functions are currently
> > only used by the bpf_task_fd_query() syscall handler to collect
> > information about a perf event.
> >
>
> Oops, good catch!
>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
>
>
> > Fixes: 60d53e2c3b75 ("tracing/probe: Split trace_event related data from trace_probe")
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>
> Cc: stable@vger.kernel.org

Applied to bpf tree. Thanks
