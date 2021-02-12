Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AADB831A695
	for <lists+bpf@lfdr.de>; Fri, 12 Feb 2021 22:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhBLVM2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Feb 2021 16:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhBLVM1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Feb 2021 16:12:27 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B542CC061756
        for <bpf@vger.kernel.org>; Fri, 12 Feb 2021 13:11:46 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id x19so836718ybe.0
        for <bpf@vger.kernel.org>; Fri, 12 Feb 2021 13:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HDNsHCLNcl6f7He29ZUqqGi5aU4IJVWHeOC+yIPRSiA=;
        b=S/dAN9xK/ueOdK6A43w/nehIxsDdFpYNhrApfIYk/hx2AGIWpPx/hscIXvQ3DQLz2y
         iCXtIwNG0SEp6Aq055aiUaCjmFg7NWOOvmG3kK4ErStSrRHgkOYDUoh+bCd3A/FyAVGB
         ys5APBsDWpHhQaLVlcGzlK1208v+Yn/aSzDWRb/IAPkDnwkFzJXgUK8Q4LNZCliih8ac
         5z6oXo5UE5SF0NJSIgwbSYIlodi3ZjCo0OQhcSVBol/W6nok+9HTkJ0yL9UR2wiHOB6+
         t7+54ID+tIyvsYmDgPd5J2fYkZgKTSFERMSnvuSAZB4H6qH9LDWFU9jf9dg+u+oZFwMM
         iNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HDNsHCLNcl6f7He29ZUqqGi5aU4IJVWHeOC+yIPRSiA=;
        b=ISpxvdncEG6cSAkqeTHjNkaJ9SGps4G3ZUl1M0pkuB+j6SO1jp/hOkxZQXb9TUnJUX
         TbAfGWkSfblJh6dFtLO4AV0VwoZOasFGzX1v3mg0+8+Ki3G3Nv294Vz0hxddO6wiOiyz
         GBDda3G5mwuM0dfwcNz5jaY3LIjtBYtq7ycY6WGY+f3rtJISvfxBhtVWAKk4VWhNLQcx
         8CtkFH8X1HycQonnQi3KtpQGbdx09cZpwRtJYhSXdy0aRP/SMDXAkJtSAvDXfyC6VAAA
         qK9DJClzuB8Mt5eRjODzCPZTBVTcqiV7EhNZMHlJ9B+4cQRneF77Le4z4k53HEe4G3pu
         ImxQ==
X-Gm-Message-State: AOAM532G7N4+3IYMFiWkK31jPbSxa9VMtl1T1QJRoDRy/DpAFPkMRwZv
        I25YoUcH7khQiz+JnW/GfEyCHo+HkO1VnrK3H81jHrFEHLLnAQ==
X-Google-Smtp-Source: ABdhPJzFKufp5kV+dIB+mCe6+tTKrMRtZAIWXU4HiXeIpipDYJRfeEaCI8S9TgnktTlifYh4kk67bXMwtCVKZclkr9s=
X-Received: by 2002:a25:9882:: with SMTP id l2mr6263282ybo.425.1613164306082;
 Fri, 12 Feb 2021 13:11:46 -0800 (PST)
MIME-Version: 1.0
References: <20210212205642.620788-1-me@ubique.spb.ru> <20210212205642.620788-2-me@ubique.spb.ru>
In-Reply-To: <20210212205642.620788-2-me@ubique.spb.ru>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 12 Feb 2021 13:11:35 -0800
Message-ID: <CAEf4BzYu1KdwvJkjEj+TRL7BFf_cA_PutqYcsqqf3QmzzTUb9Q@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/4] bpf: Rename bpf_reg_state variables
To:     Dmitrii Banshchikov <me@ubique.spb.ru>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Andrey Ignatov <rdna@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 12, 2021 at 12:57 PM Dmitrii Banshchikov <me@ubique.spb.ru> wrote:
>
> Using "reg" for an array of bpf_reg_state and "reg[i + 1]" for an
> individual bpf_reg_state is error-prone and verbose. Use "regs" for the
> former and "reg" for the latter as other code nearby does.
>
> Signed-off-by: Dmitrii Banshchikov <me@ubique.spb.ru>
> ---

Please carry over Acked-by and Reviewed-by tags next time (unless you
made substantial changes to the patch)

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  kernel/bpf/btf.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>

[...]
