Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9624E4598F0
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 01:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhKWAIZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 19:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbhKWAIW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Nov 2021 19:08:22 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720B5C061574
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 16:05:15 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id v64so54591121ybi.5
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 16:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ehV/o7hapwtv0bw7Q17ypW8LSdkPWaMW38EXEbeE88Y=;
        b=p3cmap4ywtXZrfS/EQ96nEbbbD0wm8+Sp6BnPFRWNecOrVNH9y9xGekUnm2IEfmryh
         VsRLliwcazae/8NkDFb22eCAJ2CgA5A2XhVBCciLw3+EZ0XgtfSF3Q9VRfo0P+1tnUss
         4lJpJJR0KPuQfhEVbqVLmKk3vYT7nxEaAnih0vWIggdtNpmXKWMuNkcfNUSapDfk6VqX
         YrJVkagSmT1f1xebzQSRaecjhRFOZIwmYiow8vcbJvW9z2JW+LZpuR6aPdOQUAt/Ss1V
         wKhs3kGCGt8DqsVSHzU/n+bRd+3Zj7jzb+6KqJO7toUsLBkk9njjZgGo+bzL+qVppBpD
         4DrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ehV/o7hapwtv0bw7Q17ypW8LSdkPWaMW38EXEbeE88Y=;
        b=FkhC0gR5B/t5ZAeXRzFo/IsNDprPmLKT3dpkHLAVkU8or+SnJhKb0EriwIFOj4ahzC
         bxdEWpwIw1/nkf7lnDcgEyOiYZoplFtjrrCfLlJJgGYhHk/CInbU9H97V6n0qTSEZJfS
         XmtXKsT5Du59Q5bVVSK2BJ+8Kun17L0/XdcsQCbAIf/70LdQdIFriq01wd6jD+3rzrUj
         9mc5dc0RnKfLeY6CdnX7x+tOYcM29ThqeYBKWJ61E0p1Rmug4mxaAJtJueeDBXWdYAXI
         2PwYPRmiUzI0p//4Q6JR8n/sEDrDYkmbfsHenBd6aZc7fa7lL/GeAgvGkvedNivyt4fy
         DgVQ==
X-Gm-Message-State: AOAM532wNc5OtY3QW4Qwz73exEpNaBqBK0sEuWM6azoj3AKWbAmKeSy/
        KHy8mBG24D7ARVaHd94LbKDh8qVpYM8mv0CclXqqTwNGQPk2uA==
X-Google-Smtp-Source: ABdhPJyQIqQh+5vlopxIQToh6lEPrHb08ej6AJ/fOLeXPHcZDoOsLG2NRRPbIuY60zrLaP4cKDLcXDoMEsQ0W0xJcNU=
X-Received: by 2002:a25:d16:: with SMTP id 22mr1261736ybn.51.1637625914808;
 Mon, 22 Nov 2021 16:05:14 -0800 (PST)
MIME-Version: 1.0
References: <20211120033255.91214-1-alexei.starovoitov@gmail.com> <20211120033255.91214-10-alexei.starovoitov@gmail.com>
In-Reply-To: <20211120033255.91214-10-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 22 Nov 2021 16:05:03 -0800
Message-ID: <CAEf4BzYhBxCKnxtga5RhPGUoawxFsUOSKQv49mdi4f_C_M_W1Q@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 09/13] selftests/bpf: Add lskel version of
 kfunc test.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 19, 2021 at 7:33 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Add light skeleton version of kfunc_call_test_subprog test.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/testing/selftests/bpf/Makefile          |  2 +-
>  .../selftests/bpf/prog_tests/kfunc_call.c     | 24 +++++++++++++++++++
>  2 files changed, 25 insertions(+), 1 deletion(-)
>

[...]
