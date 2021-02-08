Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE87C31413C
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 22:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234944AbhBHVF7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 16:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234677AbhBHVFp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Feb 2021 16:05:45 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43695C061786
        for <bpf@vger.kernel.org>; Mon,  8 Feb 2021 13:05:04 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id i71so15990722ybg.7
        for <bpf@vger.kernel.org>; Mon, 08 Feb 2021 13:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aHebyGs8l0Y1ZGO2umHK3FeUw2SkiYnMl6D1HmP01eM=;
        b=P+hCdRCo8PbKCJP97OuBoZnqLwu1VOHJop0MTpqh2Ox1IvnGqz5uLUKrsAGwjKgmWO
         G7kY1yq5aHHnQGZcM5xyPsQiyJRL9DAFWEBQ5Pdap5aNhifoCWJHABZO3ptKO3kktUch
         LuAnR8MXKWQAvQ3T7bEBfKv7qRdsvNFilRsgcAapibr+15ocNc6KExWPZARCEmQaYTcj
         wVVeVGVW5Y0cQ9+A8KJFk23AwLUIOcnvy6HPpm8O443W5Vc75MDfBHEuhkM0GhDWg9i0
         3dQVtkaC/ZKXOb754DGVcREak8ZxX8jnmjNAyUT4tQzadqwG8DDZTSiiyiZsU8EgCv9p
         /Diw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aHebyGs8l0Y1ZGO2umHK3FeUw2SkiYnMl6D1HmP01eM=;
        b=IVkwbh1uK0KFa+F/8g9OpO9hmvWny00R7nRgzfk1X2YLXsSzw6hFvQblxC/Gmq+GY5
         JxEj3hyDyyumEp0MiFjckFLGU1ncDd5Q4/JnFCibYN8flglT6+Jc5+r5Hbnsm/Ihe65q
         rrCXxHaxtuMnNlRuO5B6jNXaEjMAEiyEBgFJtA+1CUZXb8nERMkfDnVLl7Neo/4M2XkE
         ppf7MnaJKQIhnj/3P9SCtH4e1pha39oyJdxaHWlJoXwUCydcP5dIx8k/gky1mKn0SL5M
         FJKqR1Nx5g17IEDPlB+TLAOdGvN1BL4+zgWrLeFubic+tHnTvE3if45yySeQpn3Q+0V8
         L6ug==
X-Gm-Message-State: AOAM530S/ZuwlacvNFAS7wcDe23uR18dcxL5Pl2bkWEC9OJh27L6Q1jA
        zWaE47FZZ0qFNwYEUjAUF5A16GZVw/DnDVyxMuw=
X-Google-Smtp-Source: ABdhPJxr5rh0jzyqRe8k/fpDB+2T+nPTyvU3jJMBOLhai/P01kO54+amVQgaUY6fCAwu311eWHbpk1ZQTAZ4WB9RE/A=
X-Received: by 2002:a25:3805:: with SMTP id f5mr11248485yba.27.1612818303673;
 Mon, 08 Feb 2021 13:05:03 -0800 (PST)
MIME-Version: 1.0
References: <20210206170344.78399-1-alexei.starovoitov@gmail.com> <20210206170344.78399-8-alexei.starovoitov@gmail.com>
In-Reply-To: <20210206170344.78399-8-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 8 Feb 2021 13:04:52 -0800
Message-ID: <CAEf4BzZ+u6cRgO++Vnfeea_G_ifCfxp41q1AtDadBiBQyMvW-g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 7/7] selftests/bpf: Add a test for map-in-map
 and per-cpu maps in sleepable progs
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 6, 2021 at 9:06 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Add a basic test for map-in-map and per-cpu maps in sleepable programs.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>


>  tools/testing/selftests/bpf/progs/lsm.c | 69 +++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>

[...]
