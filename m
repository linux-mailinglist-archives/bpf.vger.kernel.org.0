Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D9A4A54AF
	for <lists+bpf@lfdr.de>; Tue,  1 Feb 2022 02:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbiBABc0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 31 Jan 2022 20:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbiBABcZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 31 Jan 2022 20:32:25 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B7DC061714
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 17:32:25 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id x6so502235ilg.9
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 17:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CdU9vcK2zuGqHz/vYNGBNH9JUXoxq/3mI0RmDX5pRSc=;
        b=WfGUhVT6/0MQeZqKESSVNXQ7BAywAgYjSCRz2mVPunBwZKgvDD5496d1dhCrsEcq8p
         NJj4OcmZK4AsoGY6edprIo6zPxcnaZLY++luZtWayJO+w+Yi+xNeuD6D2lghChggePvt
         uac2MN3LwH5zcB32eMnS8ZqydqIJlXePHI4Q1kFSBHdUm75oxYHIUVm6iyCpMEy2QTOs
         WQq1/7COubMoxf1uy9f7nxRHoKuDGBnOh8QNrdq3kguyORAt6BXb6HvYYAxbkK/zdHf7
         DxOH7KUbmpjFmxOg77ES6Z8f898xnEhyLUQGE8Gxbq7IDwB4Ad00XUGiUiP7w0kmxNVZ
         5xyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CdU9vcK2zuGqHz/vYNGBNH9JUXoxq/3mI0RmDX5pRSc=;
        b=JXFzZS+XeKPoA8KNNGSoFc86gZ70UD3DpWmVN8j+PFY932mcXhLr6btjiiythrAl1i
         aulQspKSjYbiN7TBDV2duJqRLp3aT1X6GF6izWt6SegvJASWIMqLDao0q80Jb54w+Pur
         WX/eeOHSZS8kUosn1zgcEdj9aKjHJtDJ4DsObBTT+XX+n0pldnHRr2Z65fNij+bRQ08a
         lTLa7JauNETXSDnFAWQCkTSFloOLyh+cv0BYsb8ME64nWd58U8lc19ACtIXgA7hhOGMU
         wiW5VGuA4Zhr72UD1P8JxwO0f+ZgPCvo6kmmwp95ljnElpe2r9ulpn7RWKPGqpQEtZhM
         VvcQ==
X-Gm-Message-State: AOAM533pThB2855FTppW0cPhsTvOMp1/Bj54eKvyO+orsKmUKBzBDTjI
        GtTAlEwalt6wlg1yaQDhIDPuz1CEjvM5TdGa/3A=
X-Google-Smtp-Source: ABdhPJzhB7Fr9B+RIlYzuEy9d/eJYf8jnUL5GmNL8pUH8tqK2SaEuy27ktZ3BBEGOuXq9WLcHsIaUePG+7zSceLdOmw=
X-Received: by 2002:a05:6e02:1b81:: with SMTP id h1mr14232182ili.239.1643679145244;
 Mon, 31 Jan 2022 17:32:25 -0800 (PST)
MIME-Version: 1.0
References: <20220128012319.2494472-1-delyank@fb.com> <20220128012319.2494472-3-delyank@fb.com>
In-Reply-To: <20220128012319.2494472-3-delyank@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 31 Jan 2022 17:32:14 -0800
Message-ID: <CAEf4BzaQhqL+qQt6RcK5kUZHAy39GqRLCPH8zeJBaiYh+f65vQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/4] selftests: bpf: migrate from bpf_prog_test_run_xattr
To:     Delyan Kratunov <delyank@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 27, 2022 at 5:23 PM Delyan Kratunov <delyank@fb.com> wrote:
>
> Signed-off-by: Delyan Kratunov <delyank@fb.com>
> ---

You can avoid a bunch of code churn if you name the new opts variable
as tattr, let's do that in this patch?

CHECK_FLOW_KEYS() is probably justified, so feel free to stick to
using CHECK() internally for extra formatting capabilities (we might
extend ASSERT_xxx() macros eventually to support vararg format args).

Also, forgot to mention in the previous patch reply, please use
"selftests/bpf: " subject prefix. We are never perfectly consistent,
but stats still favor selftests/bpf heavily:

$ git log --oneline -- . | rg 'selftests: bpf: ' | wc -l
102
$ git log --oneline -- . | rg 'selftests/bpf: ' | wc -l
1090

>  .../selftests/bpf/prog_tests/check_mtu.c      | 47 +++++-----
>  .../selftests/bpf/prog_tests/cls_redirect.c   | 30 +++---
>  .../selftests/bpf/prog_tests/dummy_st_ops.c   | 31 +++----
>  .../selftests/bpf/prog_tests/flow_dissector.c | 75 ++++++++-------
>  .../selftests/bpf/prog_tests/kfree_skb.c      | 16 ++--
>  .../selftests/bpf/prog_tests/prog_run_xattr.c |  5 +
>  .../bpf/prog_tests/raw_tp_test_run.c          | 85 ++++++++---------
>  .../selftests/bpf/prog_tests/skb_ctx.c        | 93 ++++++++-----------
>  .../selftests/bpf/prog_tests/skb_helpers.c    | 16 ++--
>  .../selftests/bpf/prog_tests/sockmap_basic.c  | 19 ++--
>  .../selftests/bpf/prog_tests/syscall.c        | 12 +--
>  .../selftests/bpf/prog_tests/test_profiler.c  | 16 ++--
>  .../bpf/prog_tests/xdp_adjust_tail.c          | 34 +++----
>  13 files changed, 227 insertions(+), 252 deletions(-)
>

[...]
