Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1341C30FC9D
	for <lists+bpf@lfdr.de>; Thu,  4 Feb 2021 20:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239809AbhBDTXh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Feb 2021 14:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239806AbhBDTXa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Feb 2021 14:23:30 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89FFC061786
        for <bpf@vger.kernel.org>; Thu,  4 Feb 2021 11:22:49 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id v123so4265474yba.13
        for <bpf@vger.kernel.org>; Thu, 04 Feb 2021 11:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mky/RPygIdDHW340hqn5JFU7/zA4sgHipNd4rb4i7OQ=;
        b=KAibljmRlbCcRb6SnIuI1f9yBT48XHQiHsB507mucODQk5vEghych6hIICY8DWikQo
         98uPRAouS5e7QpmqqdeVF3sZcxm5qS2ApaiPIkiopjBIYD1o0hKZKfzfpXsA6QaRbCn1
         dmGBygvoIwh5q8UA0WZtLlZH8WVCjLMRlqZVKXZtDryrwjlTlL8soa0mwH7oTsrmTbR/
         lyQ3hbYJ+LKP1LmT8LlpLtGA5LnVC6pBNPrRMJouMM61M+Qm7U+1rv2QX1G84U4TMXnb
         lt505NekHPTqvuqMioaJsigaz7IoZyrR7N7DkERajLpvXg2DwraCKpKU/w+gSMXwKH1n
         YcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mky/RPygIdDHW340hqn5JFU7/zA4sgHipNd4rb4i7OQ=;
        b=kpljPRpJyIMuCu5E/FxVCaJ0y0W5yfEO4Vm9h/lYEZ8XUmcGdZKvou6muE1QLiPXIt
         ZpErpZWa01fVvrjXqmkgwvTr+o02uYu1jegAd2hQG0bLvcTMKeeqk5JuFIrUCTSnK/u4
         1Aq04FA0P6V8F2ymueD6BtmDtRXYDGv2oyPraeSWcLCgBjHNLxMpcbaSphiXDd+1uw0o
         l6oAD8EOv14jMCx+PTTIpcmQkC1EaTr2j/69XDXlL0JqKDVc9p1ibvFRhK0wcGnLp0SY
         ZwQKJahFWyHVCE9CLgv9jd3KVhcBleKvZPxK93gasGhaSsC14xxS+PlR2fiItjpI1/UP
         MMDA==
X-Gm-Message-State: AOAM5337TQWnq3mIM3RXVHPNKKlV8pd09eLUIosO16IjTUhD+0sATxIx
        CWbtdMdM2VbspAjyHYTuKk/A6p8RrxwaWOJiMg0=
X-Google-Smtp-Source: ABdhPJzdnRmWBgZOV/PWyg+GeUYaAH7j2R0eJIPkKx21Ka+B4iLVw0K/qDGkoYvh4qxz9c5zqXrz7BkrOVHt5bcW0/U=
X-Received: by 2002:a25:f40e:: with SMTP id q14mr1158993ybd.230.1612466568956;
 Thu, 04 Feb 2021 11:22:48 -0800 (PST)
MIME-Version: 1.0
References: <20210202221557.2039173-1-kpsingh@kernel.org> <20210202221557.2039173-2-kpsingh@kernel.org>
 <CAEf4BzZtG2WtVcjXP24J9TRJ4=gQE02Tb2fXQ4Tiaf9=bADJBA@mail.gmail.com> <CACYkzJ7F8ZdpyAbMrkPX5Y6g+MXVo4FY1s-AizThYcuHuZWhdg@mail.gmail.com>
In-Reply-To: <CACYkzJ7F8ZdpyAbMrkPX5Y6g+MXVo4FY1s-AizThYcuHuZWhdg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 4 Feb 2021 11:22:37 -0800
Message-ID: <CAEf4BzZEB2sEcLM04AocfBRp_fdaAbjZyJO9gnj+bgrxxTwyCg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Helper script for running BPF
 presubmit tests
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 4, 2021 at 10:59 AM KP Singh <kpsingh@kernel.org> wrote:
>
> On Thu, Feb 4, 2021 at 5:52 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Feb 2, 2021 at 2:16 PM KP Singh <kpsingh@kernel.org> wrote:
> > >
> > > The script runs the BPF selftests locally on the same kernel image
> > > as they would run post submit in the BPF continuous integration
> > > framework.
> > >
> > > The goal of the script is to allow contributors to run selftests locally
> > > in the same environment to check if their changes would end up breaking
> > > the BPF CI and reduce the back-and-forth between the maintainers and the
> > > developers.
> > >
> > > Tested-by: Jiri Olsa <jolsa@redhat.com>
> > > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > > ---
> >
> > I almost applied it :) But found two problems still, which ruins
> > experience in my environment, see below.
> >
> > Also, do you mind renaming the script (and updating the doc in patch
> > #2)to vmtest.sh for a shorter name without underscores?
>
> Sure, I like vmtest.sh better too.
>
> >
> > First problem is that it still doesn't propagate exit codes properly.
> > Try ./run_in_vm.sh -- false, followed by echo $? It should print 1,
> > but currently it prints zero.
>
> So propagating the error from the script that ran in the VM would I
> think be a little
> tricky. This is just the error from the wrapper script.
>
> I can take a stab at it in a later patch (hope that's okay for now) as it's
> not trivial [at least in my head] as we might have to save the status in a file,
> copy the file back to the host and then use that status code instead or
> do something socket / SSH.
>

Yeah, follow up is ok. Storing in file and returning that seems ok,
similar to what you do with logs.

> >
> > >  tools/testing/selftests/bpf/run_in_vm.sh | 368 +++++++++++++++++++++++
> > >  1 file changed, 368 insertions(+)
> > >  create mode 100755 tools/testing/selftests/bpf/run_in_vm.sh
> > >
> >
> > [...]
> >
> > > +
> > > +update_kconfig()
> > > +{
> > > +       local kconfig_file="$1"
> > > +       local update_command="curl -sLf ${KCONFIG_URL} -o ${kconfig_file}"
> > > +       # Github does not return the "last-modified" header when retrieving the
> > > +       # raw contents of the file. Use the API call to get the last-modified
> > > +       # time of the kernel config and only update the config if it has been
> > > +       # updated after the previously cached config was created. This avoids
> > > +       # unnecessarily compiling the kernel and selftests.
> > > +       if [[ -f "${kconfig_file}" ]]; then
> > > +               local last_modified_date="$(curl -sL -D - "${KCONFIG_API_URL}" -o /dev/null | \
> > > +                       grep "last-modified" | awk -F ': ' '{print $2}')"
> > > +               local remote_modified_timestamp="$(date -d "${last_modified_date}" +"%s")"
> > > +               local local_creation_timestamp="$(-c %W "${kconfig_file}")"
> > > +
> >
> > %W breaks the entire experience for me. stat -c %W returns 0 in my
> > environment, don't know why. But it's also not clear why %W (file
> > creation time) was used instead of %Y (file modification time)? When
> > we overwrite latest.config, it will get updated modification time, but
> > old creation time, so this whole idea with %W seems wrong?
> >
> > So, do you mind switching to local_modification_timestamp with %Y? I
> > checked locally, it finally allowed to skip rebuilding both the kernel
> > and selftests.
>
> Sure, I can switch to %Y. Both seem to work for me.
>
> >
> > > +               if [[ "${remote_modified_timestamp}" -gt "${local_creation_timestamp}" ]]; then
> > > +                       ${update_command}
> > > +               fi
> > > +       else
> > > +               ${update_command}
> > > +       fi
> > > +}
> > > +
> >
> > [...]
