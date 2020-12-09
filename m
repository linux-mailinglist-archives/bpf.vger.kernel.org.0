Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7FB92D4BF6
	for <lists+bpf@lfdr.de>; Wed,  9 Dec 2020 21:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbgLIUeD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Dec 2020 15:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729563AbgLIUdy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Dec 2020 15:33:54 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6585FC0613D6
        for <bpf@vger.kernel.org>; Wed,  9 Dec 2020 12:33:14 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id r127so2546836yba.10
        for <bpf@vger.kernel.org>; Wed, 09 Dec 2020 12:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uOWIaVHX1g8m3Lh8OngkG5wK1AD68AOfszlTYV3ODHo=;
        b=MFy7NJYbLeqNt81comhcNmlWrlX2kPKIZyxdN1K26ZFRba0rAewqFbqrRXqSJCI7pi
         AdnI/ADM5X+MuLX7VPYZlMnLeumWxLvn3uuOreHWCVqq5G/KWyCSUqds9dYHJ5M77hwB
         q0mQPo8IppJvGpUehHQr+qncw/HO+nrq7P+RHdJ/vSW+Squ/e2M0yu73zTpG016VRIUn
         wzRPf68aGXmLESjOdabskqenWJT+yMVDcRu6Xfzeomq3KV5MA7Tlr8Mi1FZ4GQCjfMfD
         xb3x/VhGFfjXvSYcq+CMlTywX8gx5X9F0Hz6fMcOWGbyrmZ8AiqqIyE+WwwLByMDKNhp
         h5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uOWIaVHX1g8m3Lh8OngkG5wK1AD68AOfszlTYV3ODHo=;
        b=a6spWEJPfiX2WXDK+U4fgHnVLvQtjowcpaMMsmYetdxNm4i97DAEPxM0SdDs3a/5JL
         rsPsPwcP8cD9LLWwdowA7jQYs0eU/w+90/5LnirotJ0NUG9a/5gaJhu7MuqDZlkOdFkL
         /T1eR0Tp/EvSzCz8U3Lrd3Tj1f+csTc+au0LLpnaktCQmuQ/LmQt50jhnO/YxdVu6jkP
         KeUARNQcOhvrs2rVIY4wZPpXu464R+Bwbk3HeeZm9zXIIOyyFPwi7LsY09033dR+quRe
         hagbOGYQgE2Ks9eY5g90/1yL0BmaWE/+h50iH/W2ZLg5Bxn4eBhZRQwiDXkMtYZjY5E2
         PyXQ==
X-Gm-Message-State: AOAM530xIUDvQHs6XFH2w1j/ig0x5v6GWfCK1Xm47KAd+dwx1Mjvqh08
        WQewRwHIal1ASXgOUAXazzxFEWFyLP4LyqqrH6U=
X-Google-Smtp-Source: ABdhPJwqRvzh4Q5FSGeQSKUaTJS5RbGrwrzowxZZjwHIMhCpeqJDG+elsL02mW+bDEcuibEthBUco1b3vH6FndOMJzU=
X-Received: by 2002:a25:aea8:: with SMTP id b40mr6259529ybj.347.1607545993714;
 Wed, 09 Dec 2020 12:33:13 -0800 (PST)
MIME-Version: 1.0
References: <20201209000120.2709992-1-kpsingh@kernel.org>
In-Reply-To: <20201209000120.2709992-1-kpsingh@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 9 Dec 2020 12:33:02 -0800
Message-ID: <CAEf4BzZC+Oz3BL5m4aAbtSKsz-6xBrH42C0CvDZbBT=ubH8gMA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Silence ima_setup.sh when not
 running in verbose mode.
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 8, 2020 at 4:01 PM KP Singh <kpsingh@kernel.org> wrote:
>
> Currently, ima_setup.sh spews outputs from commands like mkfs and dd
> on the terminal without taking into account the verbosity level of
> the test framework. Update test_progs to set the environment variable
> SELFTESTS_VERBOSE=1 when a verbose output is requested. This
> environment variable is then used by ima_setup.sh (and can be used by
> other similar scripts) to obey the verbosity level of the test harness
> without needing to re-implement command line options for verbosity.
>
> Fixes: 34b82d3ac105 ("bpf: Add a selftest for bpf_ima_inode_hash")
> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  tools/testing/selftests/bpf/ima_setup.sh |  6 ++++++
>  tools/testing/selftests/bpf/test_progs.c | 10 ++++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/ima_setup.sh b/tools/testing/selftests/bpf/ima_setup.sh
> index 2bfc646bc230..7490a9bae33e 100755
> --- a/tools/testing/selftests/bpf/ima_setup.sh
> +++ b/tools/testing/selftests/bpf/ima_setup.sh
> @@ -81,9 +81,15 @@ main()
>
>         local action="$1"
>         local tmp_dir="$2"
> +       local verbose="${SELFTESTS_VERBOSE:=0}"
>
>         [[ ! -d "${tmp_dir}" ]] && echo "Directory ${tmp_dir} doesn't exist" && exit 1
>
> +       if [[ "${verbose}" -eq 0 ]]; then
> +               exec 1> /dev/null
> +               exec 2>&1

can't this be done with one exec, though:

exec 2>&1 1>/dev/null

?

It also actually would be nice to not completely discard the output,
but rather redirect it to a temporary file and emit it on error with
trap. test_progs behavior is no extra output on success, but emit it
fully at the end if test is failing. Would be nice to preserve this
for shell script as well, as otherwise debugging this in CI would be
nearly impossible.


> +       fi
> +
>         if [[ "${action}" == "setup" ]]; then
>                 setup "${tmp_dir}"
>         elif [[ "${action}" == "cleanup" ]]; then
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index 5ef081bdae4e..7d077d48cadd 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -587,6 +587,16 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
>                                 return -EINVAL;
>                         }
>                 }
> +
> +               if (env->verbosity > VERBOSE_NONE) {
> +                       if (setenv("SELFTESTS_VERBOSE", "1", 1) == -1) {
> +                               fprintf(stderr,
> +                                       "Unable to setenv SELFTESTS_VERBOSE=1 (errno=%d)",
> +                                       errno);
> +                               return -1;
> +                       }
> +               }

yep, this is what I had in mind, thanks.

> +
>                 break;
>         case ARG_GET_TEST_CNT:
>                 env->get_test_cnt = true;
> --
> 2.29.2.576.ga3fc446d84-goog
>
