Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5DC344FB7
	for <lists+bpf@lfdr.de>; Mon, 22 Mar 2021 20:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbhCVTRN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Mar 2021 15:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbhCVTRG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Mar 2021 15:17:06 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0685C061574
        for <bpf@vger.kernel.org>; Mon, 22 Mar 2021 12:17:05 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id j198so7743334ybj.11
        for <bpf@vger.kernel.org>; Mon, 22 Mar 2021 12:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L0G8SqxfBKChmMaW7zN+6Fh7BmCjrPXcXKzQoo2GtNQ=;
        b=G5QvbK5bv7gNdMoejYkE8LdR/1NpXaehgeL0PENbuFL6ZhkH7TFKVnuey21lcRF+O9
         V7xIOzLbzBO6blqHLWSuubMDXnPEOKPTWSUEAv5Gh315voVyj1LmhvNHpy1GYLCEiopH
         dSy76L7uRjbckXIZeE7VIUM6T7Dca6wRDqU+OFtqkycivrM/IJCXP7fndj4rl6WsRCEK
         BhanLtew9EyGBxuEIioPnvHbWGnk1bnGgAQ/PkYM6/+L16BqM3dFqeGb1eiAEPgL14hq
         enqNHi5CMOGlQoLSdmhaxpn+ECAGHHK5/EKVviIA4yGl6+Un3H3Y2YQ5KVk9VOxVemBX
         KI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L0G8SqxfBKChmMaW7zN+6Fh7BmCjrPXcXKzQoo2GtNQ=;
        b=TxugU1qQAs9AV+6+mv+nPnLLXm/vU7wL8MMGej5VILM7lSt//GNdBluHY7fHuwa4+r
         Fio/DAiNsesTYYbMDYbjLaYeyYY/8qC4ZBbp6RDwprqy24uqgnTnkDU47Vat7DiifwYj
         zr5XOFJJ2Hp5r8R2ule/qt5QwtXREWhsm1gn620HZUo1VuNz/ubrhyF1QBpVE8unGWWC
         7+G1GdstAMtkAmnUNNYk7z3c1YqxLELWS8WHcHvQgZVJxhwgFFxf3ZyOxL4zE7QccY64
         LKQ/HnjFMTCz4i8sKloluqv1NanSDF0sP5utvKW55l6qI5IgD5/dStTUWyfHRcnadWux
         qu0A==
X-Gm-Message-State: AOAM5331BuBkHyfQvgAjHyCyOl+/vfgyDu2kGyuu7EaoecR7wr/tIgLA
        iw8mjPQBPpObkUeASHjy3IVLJe+SKCMp/omSNIA=
X-Google-Smtp-Source: ABdhPJy1PO2hoNcjEweVQbhvwsEzeQ+8eBfIWMEqnaFrArvMChS4nUmg00OYu2el5lbOa3V1TcjE1DueyKvuMpS7B4E=
X-Received: by 2002:a25:becd:: with SMTP id k13mr61529ybm.459.1616440625229;
 Mon, 22 Mar 2021 12:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210322163659.2873534-1-kpsingh@kernel.org> <CAEf4BzYR2Ny2JnMVZ_N76EN1f-8PyFKj3aZkWmjzkC_d8U-30w@mail.gmail.com>
 <CACYkzJ6JmG=VFPTk1MdXzEc2kFDMZsSDpWC8fEzLqeWZ+NUE9w@mail.gmail.com>
In-Reply-To: <CACYkzJ6JmG=VFPTk1MdXzEc2kFDMZsSDpWC8fEzLqeWZ+NUE9w@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 22 Mar 2021 12:16:54 -0700
Message-ID: <CAEf4BzYd=c1FS-zTc6N-D=r_3Y1PDPWowhhQcusUGmzLu30YTg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add an option for a debug shell
 in vmtest.sh
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 22, 2021 at 11:33 AM KP Singh <kpsingh@kernel.org> wrote:
>
> On Mon, Mar 22, 2021 at 6:54 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Mar 22, 2021 at 9:37 AM KP Singh <kpsingh@kernel.org> wrote:
> > >
> > > The newly introduced -s command line option starts an interactive shell
> > > after running the intended command in instead of powering off the VM.
> > > It's useful to have a shell especially when debugging failing
> > > tests or developing new tests.
> > >
> > > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > > ---
> > >  tools/testing/selftests/bpf/vmtest.sh | 15 +++++++++++----
> > >  1 file changed, 11 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
> > > index 22554894db99..3f248e755755 100755
> > > --- a/tools/testing/selftests/bpf/vmtest.sh
> > > +++ b/tools/testing/selftests/bpf/vmtest.sh
> > > @@ -24,7 +24,7 @@ EXIT_STATUS_FILE="${LOG_FILE_BASE}.exit_status"
> > >  usage()
> > >  {
> > >         cat <<EOF
> > > -Usage: $0 [-i] [-d <output_dir>] -- [<command>]
> > > +Usage: $0 [-i] [-s] [-d <output_dir>] -- [<command>]
> >
> > wouldn't it make more sense to just run bash without any default
> > commands, if -s is specified? So "shell mode" gets you into shell.
> > Then you can run whatever you want.
> >
>
> Yep, that would be better indeed. Will send an updated v2.

Cool. If it's not too hard, it still makes sense to run <command> in
bash, if it was specified explicitly.
