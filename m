Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFC230EBA1
	for <lists+bpf@lfdr.de>; Thu,  4 Feb 2021 05:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhBDExj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 23:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbhBDExi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Feb 2021 23:53:38 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FC0C061573
        for <bpf@vger.kernel.org>; Wed,  3 Feb 2021 20:52:58 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id f67so102749ioa.1
        for <bpf@vger.kernel.org>; Wed, 03 Feb 2021 20:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WvucSWAdUCIefsUybrHb46H1tlgAmeonidtiTJS8fqQ=;
        b=kZRIHAKKtXd3wemwrWOfviiHp5RvJyh9CHVUmon1H6VxorDkn/W+F0kO32Hm3DNNHu
         Rm1bDWKHPAzGeiSPXErtx9tkenI42VHFE5ByXgZj5fNllEwS63JXraNRlkWb8mwq9/kR
         C9KXgxfTo90bDYpO3caHJPe6CNCF9IRE0zEs6X/nJUtY+frvGFWrx9NaGm/nKAj9xHqZ
         BgEGRWmUsuTY69M2WGKXc3+pvMW+4OFOgZNfUH1/lUou1X+YRNQCHYzfI6FOHtH+2pru
         gF+vZuhtbaSSEWzk3DJLaABjkjSA82ODbIMdqdy7YWVZNd85EYWA1f2ZOtYccwTafv3n
         5e2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WvucSWAdUCIefsUybrHb46H1tlgAmeonidtiTJS8fqQ=;
        b=FXWr9xaekV5NZfxb18LDfwzuD7/JD8GRsMi2L3wto5hFp+2Dk6bTNqWxN5K7gM97pE
         jKaRlqUaYv636wyTb26lX4yhQkEm3zdPFfkgLnug0JUF1YeF64Y5Z3rY3d51Nl8Oz3/f
         FDoudARrefhXGQAb4OjmjCfFuNX0XMmb6YE4KZiYoqCiYwY++cs5SR+avieR2jYCkRNS
         4jpZr8PNaW0eOT26qipomE1UD5mGxqPgzhRTsLNqxnZdJGXVCCZeVEfV8HIvpCqkBW56
         W/Jf/SVk6pG1AxvPZ/hVJg956a3BpYXw4JSQNddKZifEK7YQLz8b3GBui626NjZ8vct3
         8jdw==
X-Gm-Message-State: AOAM5306yV1s6BEsXrp5mNfWrIGbWdcmLgi4HYt9hLVpBIvdvBCIQEZ3
        FCMfrdDVcrnxg1fEkKaIIwUvHSwI3zjuVVFnON8=
X-Google-Smtp-Source: ABdhPJzHz7ujp1m5SOKvqK06BZAK03mNl8nhhHlHHqO8jW5D0IQsCYNQ9EWMZdUdpKDtrUad7h0SauWkzjgcGtfzVyg=
X-Received: by 2002:a6b:db0a:: with SMTP id t10mr5431184ioc.158.1612414377405;
 Wed, 03 Feb 2021 20:52:57 -0800 (PST)
MIME-Version: 1.0
References: <20210202221557.2039173-1-kpsingh@kernel.org> <20210202221557.2039173-2-kpsingh@kernel.org>
In-Reply-To: <20210202221557.2039173-2-kpsingh@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 3 Feb 2021 20:52:46 -0800
Message-ID: <CAEf4BzZtG2WtVcjXP24J9TRJ4=gQE02Tb2fXQ4Tiaf9=bADJBA@mail.gmail.com>
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

On Tue, Feb 2, 2021 at 2:16 PM KP Singh <kpsingh@kernel.org> wrote:
>
> The script runs the BPF selftests locally on the same kernel image
> as they would run post submit in the BPF continuous integration
> framework.
>
> The goal of the script is to allow contributors to run selftests locally
> in the same environment to check if their changes would end up breaking
> the BPF CI and reduce the back-and-forth between the maintainers and the
> developers.
>
> Tested-by: Jiri Olsa <jolsa@redhat.com>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---

I almost applied it :) But found two problems still, which ruins
experience in my environment, see below.

Also, do you mind renaming the script (and updating the doc in patch
#2)to vmtest.sh for a shorter name without underscores?

First problem is that it still doesn't propagate exit codes properly.
Try ./run_in_vm.sh -- false, followed by echo $? It should print 1,
but currently it prints zero.

>  tools/testing/selftests/bpf/run_in_vm.sh | 368 +++++++++++++++++++++++
>  1 file changed, 368 insertions(+)
>  create mode 100755 tools/testing/selftests/bpf/run_in_vm.sh
>

[...]

> +
> +update_kconfig()
> +{
> +       local kconfig_file="$1"
> +       local update_command="curl -sLf ${KCONFIG_URL} -o ${kconfig_file}"
> +       # Github does not return the "last-modified" header when retrieving the
> +       # raw contents of the file. Use the API call to get the last-modified
> +       # time of the kernel config and only update the config if it has been
> +       # updated after the previously cached config was created. This avoids
> +       # unnecessarily compiling the kernel and selftests.
> +       if [[ -f "${kconfig_file}" ]]; then
> +               local last_modified_date="$(curl -sL -D - "${KCONFIG_API_URL}" -o /dev/null | \
> +                       grep "last-modified" | awk -F ': ' '{print $2}')"
> +               local remote_modified_timestamp="$(date -d "${last_modified_date}" +"%s")"
> +               local local_creation_timestamp="$(-c %W "${kconfig_file}")"
> +

%W breaks the entire experience for me. stat -c %W returns 0 in my
environment, don't know why. But it's also not clear why %W (file
creation time) was used instead of %Y (file modification time)? When
we overwrite latest.config, it will get updated modification time, but
old creation time, so this whole idea with %W seems wrong?

So, do you mind switching to local_modification_timestamp with %Y? I
checked locally, it finally allowed to skip rebuilding both the kernel
and selftests.

> +               if [[ "${remote_modified_timestamp}" -gt "${local_creation_timestamp}" ]]; then
> +                       ${update_command}
> +               fi
> +       else
> +               ${update_command}
> +       fi
> +}
> +

[...]
