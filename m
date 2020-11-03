Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B192A489D
	for <lists+bpf@lfdr.de>; Tue,  3 Nov 2020 15:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgKCOw5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Nov 2020 09:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727911AbgKCOwZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Nov 2020 09:52:25 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1484C0617A6
        for <bpf@vger.kernel.org>; Tue,  3 Nov 2020 06:52:23 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id t13so19284376ljk.12
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2020 06:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ziLXV25+/VgkRjtCBH8eTUr48viz4+7r4YIXYGGc87k=;
        b=GzOPzNmfOxjgnsy4Kf5awce40cdqg1bFz8bapoBLI8vlmAZSWoMxZtz3BxYhoLTPvV
         POC+tT0f/y6GlaQMOhzPLQfu50Q6WNYudaOL47leJTZWiNdP6AkaPJLl996Zv1rreZNf
         rMQ9b/OvY3d7NvYAdhnCF4Wo0dsyPWqFc2Ei4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ziLXV25+/VgkRjtCBH8eTUr48viz4+7r4YIXYGGc87k=;
        b=Mx5l+1NVxME3GrXeN5uJ8sdb0xXDKhim7AHNGqY8lxpzH+8rQ2IRy2ZE9misTevAzE
         L1fZhE0x2sMgWnrXwJ1iaisG5uUnzCZS658ZUIaGAtSOfaIc/v4bNRQys0zbpabSKIKF
         LMFk3m5kcPTHIRrqFzBpyXJMUUdTeoAU1VXaYulRPKrXY7x9PhHq6qdxsmjGV8HZh4XQ
         ptQygxglSYY7zId/NfB/dbpZD8sSHSc1n4V5w5DOyfyFJJNitj/P9ooyQqWJ+GLQCNXa
         ia5eFj2UxQRR6mdqCYJMAnfGJyfmVgJn6f4yPkLhIcSqpoV+1ejt23egZhbTUx1ePcit
         7Avg==
X-Gm-Message-State: AOAM531IEnKp/mG35vS6//Epgaf4eNT34AhA4bnaA5uDn0HFAPo2EjOW
        Zx7kzqQ/WRcOA+hSe24aUsy5PJZRrIJvv6hbX8fL+kHoFYQOwQ==
X-Google-Smtp-Source: ABdhPJz0XGm7P3cYiOFqENHpKPsGGATrEhj+iik1GrPr7VWBjcd0YfAeSez/zAgz0eJUQbwvBlaYvP29E1xMc4qM9/k=
X-Received: by 2002:a05:651c:1345:: with SMTP id j5mr9327077ljb.430.1604415142054;
 Tue, 03 Nov 2020 06:52:22 -0800 (PST)
MIME-Version: 1.0
References: <20201027170317.2011119-1-kpsingh@chromium.org>
 <20201027170317.2011119-2-kpsingh@chromium.org> <20201028012206.zsa3udr7rqqe3q7y@kafai-mbp>
In-Reply-To: <20201028012206.zsa3udr7rqqe3q7y@kafai-mbp>
From:   KP Singh <kpsingh@chromium.org>
Date:   Tue, 3 Nov 2020 15:52:11 +0100
Message-ID: <CACYkzJ436Q4j+DRNn56njJ3V6f7_vt+412_16i=-oWAoGFo_0A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] bpf: Implement task local storage
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

[,,,]

> > + *
> > + * void *bpf_task_storage_get(struct bpf_map *map, void *task, void *value, u64 flags)
> After peeking patch 2,  I think the pointer type should be
> "struct task_struct *task" instead of "void *task".
>
> Same for bpf_task_storage_delete().

Done. Thanks!
