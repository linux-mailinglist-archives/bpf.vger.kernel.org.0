Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9532343A9A0
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 03:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234977AbhJZBPJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 21:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbhJZBPI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Oct 2021 21:15:08 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FF0C061745
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 18:12:45 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id v1-20020a17090a088100b001a21156830bso850486pjc.1
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 18:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1tkV+WpD9RntgSEftJLd97opbVceXNf5+MwCm/zmONQ=;
        b=H1K7vZJ3zdS2AfD8FMA+GWTT6eQvL6fF2Njr19gp+OItSNY0y2f2OmQl8JAt+i4pGa
         H0XhYV0jhpw+lS3h2dALhiVXft7i2WH+xgUhijnx65E/N3j+wObkeKyYsEweCFkQUBwV
         +9DX9tUSNuZ+Mf2HadaGPhbIJkUZNzY0BLWACSfkeB5YCIOPUXNKiq+eYk6oFJMiy7Rq
         OKOGTuSVfSjkP4PiPTGJ7lB4OWJKqs4jn+bEn1n9zK6BbPiUevjnFHVoRFs2a1AYLkts
         IW7G0yQFsp/heJ3gAywAkUUkIc54Zv+iaDjYj96q1UFTH3V5wBw2wTY5C3kUUcIZIvIc
         iSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1tkV+WpD9RntgSEftJLd97opbVceXNf5+MwCm/zmONQ=;
        b=uh11fdOSl5Obqdx/Ul7PAdgkYEVdGAr0gRTZLfY2fajyxLXx/A3EsbhHlbAUX9ZJqk
         Rn6F1KM//ZV4BPUyZ8mcGDbDJpreuo02FpmUwY2wP4sU1TJCon48wF9ZrQ/aVlAKTdG6
         /S3mhZExLUiYJKZWUkvriAChQeiyAYxDY1eQ13DJdMZICDXmzbSDAz9bk12indQ+n7gE
         3Sn9tpdUdJvVhjhwzT6l/m6xflMbQ++FKr2caLQ4mzZ4XBvAbvDF2Jo8bCZCyLS484JA
         h/+r2vdaCnmED1zAePSWs9Z6TeonqQotpY1D+8Qi4DMtQKNo5SGwrB1vO0Ag0bD2I8wK
         OWrQ==
X-Gm-Message-State: AOAM5306nliBdRkB0qDnBRyOCoZZiJDJMOjGaVM2cSKJ49sB9BXvHDwj
        ZWWzHjLU8h8T1EJ5lGA4jht0//qJ5dyDzIQOD/k=
X-Google-Smtp-Source: ABdhPJyWnhpxliF41wP7nCiH8SIObS2xfrnkmprdUtoCPZddo7TcwjcBbk6xUTb/OvwvFcdQi81VAaXqX5WDzf7o/ys=
X-Received: by 2002:a17:902:8211:b0:13f:afe5:e4fb with SMTP id
 x17-20020a170902821100b0013fafe5e4fbmr19836046pln.20.1635210765129; Mon, 25
 Oct 2021 18:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211022223228.99920-1-andrii@kernel.org> <CAJygYd11fmiNsw2F1HV1NxCkj_ustqWRdxJqRUpKPimAG37+8A@mail.gmail.com>
In-Reply-To: <CAJygYd11fmiNsw2F1HV1NxCkj_ustqWRdxJqRUpKPimAG37+8A@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 25 Oct 2021 18:12:34 -0700
Message-ID: <CAADnVQ+QmM95VC69F=GHhnKWXBfpG7EF2ohsEqEuBqT27eO=Cg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] Parallelize verif_scale selftests
To:     "sunyucong@gmail.com" <sunyucong@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 25, 2021 at 1:15 PM sunyucong@gmail.com <sunyucong@gmail.com> wrote:
>
> Thanks, this patch is awesome!
>
> Acked-by: Yucong Sun <sunyucong@gmail.com>
>
>
> On Fri, Oct 22, 2021 at 3:33 PM Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > Reduce amount of waiting time when running test_progs in parallel mode (-j) by
> > splitting bpf_verif_scale selftests into multiple tests. Previously it was
> > structured as a test with multiple subtests, but subtests are not easily
> > parallelizable with test_progs' infra. Also in practice each scale subtest is
> > really an independent test with nothing shared across all substest.
> >
> > This patch set changes how test_progs test discovery works. Now it is possible
> > to define multiple tests within a single source code file. One of the patches
> > also marks tc_redirect selftests as serial, because it's extremely harmful to
> > the test system when run in parallel mode.

The patch set was applied.
