Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C97440B995
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 23:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbhINVFd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 17:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234189AbhINVFc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 17:05:32 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C88EC061574
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 14:04:15 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso3254068pjh.5
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 14:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SqMHTsTRh3I14VMvIXxV+Ov1vz7ty++tYfPp3DFdHYY=;
        b=nj4jfAXkf49kqRmEUYso2JD/yZPTNL+QKY2L85bPkmbjPHTjSftds6KPIbvzS+yR8Y
         mQrkwbZkw3a7yE9zHPPOr01KbNhfUNKhePtFxmGPL5ijPbP6xyHyZ7d/jMQTJQr1dqJ1
         cUrDuiTl2FVVdJa7pvtAW2I7BcxrwihcwHrzKGMMOutaC5BQisiduHJVHvVYf2n6dKxp
         +45HGEtyXgFy687chRk3BM8SflEn7ld8VynEqIEZs0BMtQrgYSHCvgMf7rG1grIurCMB
         vcRiHKLFRxXshktjTbG09EZORXWYh+1jcwExJGx94aUe0EEQLD2AA078E19kGQLgfRYQ
         UrGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SqMHTsTRh3I14VMvIXxV+Ov1vz7ty++tYfPp3DFdHYY=;
        b=TjAa5C1OjyHyejBnnxTVwUoOkD2E5Uclqyo9KjFmfq4t9f56wwDW5joZOXP6r2FSQB
         3bV8/ECISjXSEMgtUw1oNWxV3iJ2kG9AJhj5rxfUQe00F9LZhowI+CXSUs41t+kojjr1
         4Npzd3g/Y9QzZkmCMDn5bGeOgDGyauKHBFjxiYVw9OHN8OGUMzdauXgJgfC3xMgUaIcX
         TgNT11J58lhNEMQDQnNJRHPsNBs4opzYy3VsIGLaZvn9/yzlKKTLCohqu6Exp7qg3ZZJ
         A4c/NCAsFiSoszG9PlkDLpZLy4XKXHfBNjIOBLNr4WVF2aULeECvP7Skh+kUDjmcuUPw
         voOA==
X-Gm-Message-State: AOAM5329BJ1GupDN72QC0L6QsAr1cp0YdSD/ynTMOJsErv5xCyJ6qETd
        +rdo/w7GZFRUIu1X5/2opw6gSp6qlDBsAK5Tr1c=
X-Google-Smtp-Source: ABdhPJzLR7G6e7Q84YnAtRHv+wzHR+4A9QWs0z7AMK/zFO4MPX4yhYV1HXyaL3Cv7yL2M/G0ha6xRPLn3PQ+NYLHYtI=
X-Received: by 2002:a17:90a:9cd:: with SMTP id 71mr4275635pjo.62.1631653454439;
 Tue, 14 Sep 2021 14:04:14 -0700 (PDT)
MIME-Version: 1.0
References: <7500F71C-79CF-449C-819E-7734B6B62EA5@gmail.com> <20210914203458.2102503-1-rafaeldtinoco@gmail.com>
In-Reply-To: <20210914203458.2102503-1-rafaeldtinoco@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 14 Sep 2021 14:04:03 -0700
Message-ID: <CAADnVQKxhwn=Q4gJhMDy9r9jcTuaJe=FYkk0fYZr66-pnjJ+=A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: fix build error introduced by legacy
 kprobe feature
To:     Rafael David Tinoco <rafaeldtinoco@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, sunyucong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 14, 2021 at 1:36 PM Rafael David Tinoco
<rafaeldtinoco@gmail.com> wrote:
>
> Fix commit 467b3225553a ("libbpf: Introduce legacy kprobe events
> support") build issue under FORTIFY_SOURCE.
>
> Reported-by: sunyucong@gmail.com
> Cc: andrii.nakryiko@gmail.com
> Signed-off-by: Rafael David Tinoco <rafaeldtinoco@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 6ecfdc1fa7ba..b45eab3d30cd 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8997,7 +8997,7 @@ static int poke_kprobe_events(bool add, const char *name, bool retprobe, uint64_
>  {
>         int fd, ret = 0;
>         pid_t p = getpid();
> -       char cmd[192], probename[128], probefunc[128];
> +       char cmd[192] = "\0", probename[128] = "\0", probefunc[128] = "\0";

It doesn't look that it solves the issue:
https://github.com/kernel-patches/bpf/runs/3603448190
