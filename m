Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E730D30FC1F
	for <lists+bpf@lfdr.de>; Thu,  4 Feb 2021 20:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239260AbhBDTAx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Feb 2021 14:00:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:50498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239136AbhBDTAV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Feb 2021 14:00:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 909D964F67
        for <bpf@vger.kernel.org>; Thu,  4 Feb 2021 18:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612465177;
        bh=p5id1kIp90hhhoHPGcH4tBouTfB6wXu4z627JlaKfXM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d9JLEnPDFO2dOPbXDVUGC1vWhKCj2eZIcQAxGtWaTCrzODjbN3LXLltCPOV78DFUL
         c23DUiFWK36i4hYMMzsPuRX90INupaJGiqA7b/T1yAnhwlXEqmvyuug2WHWr6g0l0S
         8MN6WtpErz+Zjz7GGGLgSkZuwVTVurArqquFJsGalAe8GXWad6Rwlx9uJjHmYkMyud
         O47K09wC1plkDXBcfr45sHSpTFEYrBu68fnDO2t5HtwDozQN9LndqB6YhagQWDVffI
         N1/QxmF8/pmXHS3MMTdhivehnZwe8hlk3ALT0jG7T6qCqnz/41yYwOwoAj1OaB56GY
         WxuNevFMhybRA==
Received: by mail-lj1-f169.google.com with SMTP id v15so4652801ljk.13
        for <bpf@vger.kernel.org>; Thu, 04 Feb 2021 10:59:37 -0800 (PST)
X-Gm-Message-State: AOAM530oSYwaeDIkux3Zxa7QnLrFjisPl8vvFAM4HYWZ8eOT+rd/sHuz
        2z3WB8O3I36Jrez1zIqkxophR7BhKKZiVkZAMi5c1w==
X-Google-Smtp-Source: ABdhPJz9La+uMa7VpXZ2+Dg5dYDyCtTnGiCm+9UhHhJwy9kN2TOwTuL/YloSPshIyJFXU+eZAE44YB5Vrs1pxy+aEBA=
X-Received: by 2002:a2e:b5b8:: with SMTP id f24mr451113ljn.136.1612465175794;
 Thu, 04 Feb 2021 10:59:35 -0800 (PST)
MIME-Version: 1.0
References: <20210202221557.2039173-1-kpsingh@kernel.org> <20210202221557.2039173-2-kpsingh@kernel.org>
 <CAEf4BzZtG2WtVcjXP24J9TRJ4=gQE02Tb2fXQ4Tiaf9=bADJBA@mail.gmail.com>
In-Reply-To: <CAEf4BzZtG2WtVcjXP24J9TRJ4=gQE02Tb2fXQ4Tiaf9=bADJBA@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Thu, 4 Feb 2021 19:59:25 +0100
X-Gmail-Original-Message-ID: <CACYkzJ7F8ZdpyAbMrkPX5Y6g+MXVo4FY1s-AizThYcuHuZWhdg@mail.gmail.com>
Message-ID: <CACYkzJ7F8ZdpyAbMrkPX5Y6g+MXVo4FY1s-AizThYcuHuZWhdg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Helper script for running BPF
 presubmit tests
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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

On Thu, Feb 4, 2021 at 5:52 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Feb 2, 2021 at 2:16 PM KP Singh <kpsingh@kernel.org> wrote:
> >
> > The script runs the BPF selftests locally on the same kernel image
> > as they would run post submit in the BPF continuous integration
> > framework.
> >
> > The goal of the script is to allow contributors to run selftests locally
> > in the same environment to check if their changes would end up breaking
> > the BPF CI and reduce the back-and-forth between the maintainers and the
> > developers.
> >
> > Tested-by: Jiri Olsa <jolsa@redhat.com>
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > ---
>
> I almost applied it :) But found two problems still, which ruins
> experience in my environment, see below.
>
> Also, do you mind renaming the script (and updating the doc in patch
> #2)to vmtest.sh for a shorter name without underscores?

Sure, I like vmtest.sh better too.

>
> First problem is that it still doesn't propagate exit codes properly.
> Try ./run_in_vm.sh -- false, followed by echo $? It should print 1,
> but currently it prints zero.

So propagating the error from the script that ran in the VM would I
think be a little
tricky. This is just the error from the wrapper script.

I can take a stab at it in a later patch (hope that's okay for now) as it's
not trivial [at least in my head] as we might have to save the status in a file,
copy the file back to the host and then use that status code instead or
do something socket / SSH.

>
> >  tools/testing/selftests/bpf/run_in_vm.sh | 368 +++++++++++++++++++++++
> >  1 file changed, 368 insertions(+)
> >  create mode 100755 tools/testing/selftests/bpf/run_in_vm.sh
> >
>
> [...]
>
> > +
> > +update_kconfig()
> > +{
> > +       local kconfig_file="$1"
> > +       local update_command="curl -sLf ${KCONFIG_URL} -o ${kconfig_file}"
> > +       # Github does not return the "last-modified" header when retrieving the
> > +       # raw contents of the file. Use the API call to get the last-modified
> > +       # time of the kernel config and only update the config if it has been
> > +       # updated after the previously cached config was created. This avoids
> > +       # unnecessarily compiling the kernel and selftests.
> > +       if [[ -f "${kconfig_file}" ]]; then
> > +               local last_modified_date="$(curl -sL -D - "${KCONFIG_API_URL}" -o /dev/null | \
> > +                       grep "last-modified" | awk -F ': ' '{print $2}')"
> > +               local remote_modified_timestamp="$(date -d "${last_modified_date}" +"%s")"
> > +               local local_creation_timestamp="$(-c %W "${kconfig_file}")"
> > +
>
> %W breaks the entire experience for me. stat -c %W returns 0 in my
> environment, don't know why. But it's also not clear why %W (file
> creation time) was used instead of %Y (file modification time)? When
> we overwrite latest.config, it will get updated modification time, but
> old creation time, so this whole idea with %W seems wrong?
>
> So, do you mind switching to local_modification_timestamp with %Y? I
> checked locally, it finally allowed to skip rebuilding both the kernel
> and selftests.

Sure, I can switch to %Y. Both seem to work for me.

>
> > +               if [[ "${remote_modified_timestamp}" -gt "${local_creation_timestamp}" ]]; then
> > +                       ${update_command}
> > +               fi
> > +       else
> > +               ${update_command}
> > +       fi
> > +}
> > +
>
> [...]
