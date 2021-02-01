Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA0330B38F
	for <lists+bpf@lfdr.de>; Tue,  2 Feb 2021 00:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhBAX2W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Feb 2021 18:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhBAX2V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Feb 2021 18:28:21 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF753C061573;
        Mon,  1 Feb 2021 15:27:40 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id h7so25267449lfc.6;
        Mon, 01 Feb 2021 15:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EjvkqNV3yKzly7yLuBoaIr5wpK8OrxpWH9YRQsNyHaA=;
        b=dhMnRDcNX9OsQJKrXz9yYh0j/fhr++0wMYkwXvfeJaHU4y66CTAo96Ir7wY81isDcl
         fiFp0otLS2O16NYVMBA/JvwWG5xgjrTdle9Z/JM/twrtqu9hzQCvOo0lzBfRiVbnQ/UZ
         /w6ohU5Zg1FH2tx0KLJtW9LFUEpF5f/39PXJByuGecqFubk038KA2gVkC+brQ2MbwyQ8
         +au5v9vcbIHk3STl2XDMS/mFwwNycQqYZil/dJUn5XPpe5XK1Vn+JJawXvp0n9fP6+sM
         9hsGV4l/p3f2xAavrQOgVo7u2t5DswvrQD2qYgf3mYIpy4Ny8kQM8dWYDqeVLav83d2V
         jmlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EjvkqNV3yKzly7yLuBoaIr5wpK8OrxpWH9YRQsNyHaA=;
        b=LhLeTZ1QA1Gplu/AkShG8LvhQwphfxBVzS6ADGXrVU6ReDvQU0JFFSDrx9QIHhDhti
         jsPWMuwob8+5dwRB5Xa8Dl/vdsPhAPr3Sx7z71K5kTQcjA+wvGvKpEleeJuGUG7d+YTV
         YrxBGCFzSL+417Epr9TV9OzDdrNObO54zXT+0+h+oBmItsIMgWkmqsyf5bghaBjYqC97
         pTBAwaso/efxPwBT1JpIVXFb9aug0fbfRQze5zFY3GzwxykdDDMw4IzMsg7n6fJ8RyrO
         I8p0bkKvVDRuCGUwMCsygstL2g/0pjcqtM4aSN9KDcMHWFUufHRi6rWmx8dRrElSATzv
         ffAA==
X-Gm-Message-State: AOAM531ZaL9hM0zOIl7/T9Lq/mGxshI76jRKH5/vVZgyjpf6sKa2bCXm
        u9GzO4O2tSL7ovc1UmXVH8fs7XTKi8YMUXvfEq1vJkLnCYQ=
X-Google-Smtp-Source: ABdhPJxDD6oHSznvO+1c0ax7RCtqBpAnpiTQ/JfEnoj4glkmzDwSlKmwqDfmmvpH1oKTqoQRXxznLzro8uiYZfOy17s=
X-Received: by 2002:a19:ad0d:: with SMTP id t13mr9412240lfc.539.1612222057872;
 Mon, 01 Feb 2021 15:27:37 -0800 (PST)
MIME-Version: 1.0
References: <20210201150028.2279522-1-jackmanb@google.com>
In-Reply-To: <20210201150028.2279522-1-jackmanb@google.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 1 Feb 2021 15:27:26 -0800
Message-ID: <CAADnVQKAaoiVM6=VGxKh=T1PWUNWLKFx+3zKf3Ehud6+LsJB3w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Propagate memory bounds to registers in
 atomics w/ BPF_FETCH
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        John Fastabend <john.fastabend@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 1, 2021 at 7:00 AM Brendan Jackman <jackmanb@google.com> wrote:
> +
> +SEC("fentry/bpf_fentry_test1")
> +int BPF_PROG(sub, int x)
> +{
> +       int a = 0;
> +       int b = __sync_fetch_and_add(&a, 1);

It probably needs ENABLE_ATOMICS_TESTS ?

Otherwise clang without -mcpu=v3 will complain:
"fatal error: error in backend: Invalid usage of the XADD return value"
