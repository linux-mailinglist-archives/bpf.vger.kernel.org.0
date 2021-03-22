Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2552B344E9E
	for <lists+bpf@lfdr.de>; Mon, 22 Mar 2021 19:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhCVSds (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Mar 2021 14:33:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:58688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231310AbhCVSdS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Mar 2021 14:33:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64D87619A3
        for <bpf@vger.kernel.org>; Mon, 22 Mar 2021 18:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616437997;
        bh=qQPdBp28RRybB+Ab812GEW/mpCmck2a6Ki0cynXYl2s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T2L5aExbq9M82gkBQvrafERNi6D2zskI1dIVUdenY5HpbrPBc7OwuapH2fkxRNtdH
         fys4nWsJcMCj2FfX3DzvrPG2e5zdpFYj/ggz6oMR6DXXE3XntoQWcHsFbRzoYjk0Mb
         kuJhVjVcjbpfASb6mgZ3VEgD9ixikn8CcL4acQDKW1h4ulIqxAeE+nwsz0uibiUvLz
         DZ915o8uFQBgJA8ZuFtaNVjNrT69Wxz2XA8ugqAmQXWtvviKB2NYoeUJzmx6HSYd4Z
         6VNscZSMQetnVTXqq8ib+AoWKr97dLEvKHlNF8/syWIXa9jWOVB1RK29gmee2cGMJy
         I3xIdYSPz32nw==
Received: by mail-lj1-f174.google.com with SMTP id 15so22405443ljj.0
        for <bpf@vger.kernel.org>; Mon, 22 Mar 2021 11:33:17 -0700 (PDT)
X-Gm-Message-State: AOAM5313SX66OhmC7okfld4iYzl1qm3AauAtREnlHe1Vu0E2loWNB5zK
        LuG3ITJbN6LbHjPFLZJY286K9fgZ1+yRx4x2sWKfJA==
X-Google-Smtp-Source: ABdhPJy8q9Wu2e8FGOQq3hGdRST3smdTTzKwdXMI44XMqHgKekDacT0cg+Trn1rO0CqndkWp21jjfvHrF+Rxq3DfCeY=
X-Received: by 2002:a05:651c:387:: with SMTP id e7mr502497ljp.425.1616437995687;
 Mon, 22 Mar 2021 11:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210322163659.2873534-1-kpsingh@kernel.org> <CAEf4BzYR2Ny2JnMVZ_N76EN1f-8PyFKj3aZkWmjzkC_d8U-30w@mail.gmail.com>
In-Reply-To: <CAEf4BzYR2Ny2JnMVZ_N76EN1f-8PyFKj3aZkWmjzkC_d8U-30w@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Mon, 22 Mar 2021 19:33:05 +0100
X-Gmail-Original-Message-ID: <CACYkzJ6JmG=VFPTk1MdXzEc2kFDMZsSDpWC8fEzLqeWZ+NUE9w@mail.gmail.com>
Message-ID: <CACYkzJ6JmG=VFPTk1MdXzEc2kFDMZsSDpWC8fEzLqeWZ+NUE9w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add an option for a debug shell
 in vmtest.sh
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 22, 2021 at 6:54 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Mar 22, 2021 at 9:37 AM KP Singh <kpsingh@kernel.org> wrote:
> >
> > The newly introduced -s command line option starts an interactive shell
> > after running the intended command in instead of powering off the VM.
> > It's useful to have a shell especially when debugging failing
> > tests or developing new tests.
> >
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/vmtest.sh | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
> > index 22554894db99..3f248e755755 100755
> > --- a/tools/testing/selftests/bpf/vmtest.sh
> > +++ b/tools/testing/selftests/bpf/vmtest.sh
> > @@ -24,7 +24,7 @@ EXIT_STATUS_FILE="${LOG_FILE_BASE}.exit_status"
> >  usage()
> >  {
> >         cat <<EOF
> > -Usage: $0 [-i] [-d <output_dir>] -- [<command>]
> > +Usage: $0 [-i] [-s] [-d <output_dir>] -- [<command>]
>
> wouldn't it make more sense to just run bash without any default
> commands, if -s is specified? So "shell mode" gets you into shell.
> Then you can run whatever you want.
>

Yep, that would be better indeed. Will send an updated v2.
