Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDAE1B7DA9
	for <lists+bpf@lfdr.de>; Fri, 24 Apr 2020 20:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgDXSPl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Apr 2020 14:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726793AbgDXSPk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 24 Apr 2020 14:15:40 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2355C09B048
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2020 11:15:40 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id v26so3105572qto.0
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2020 11:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pPafUjv32X7Tp6z/45/uvMkZXVHK036vfrGmxlDoCqc=;
        b=DRcfUVUcUWKg4AXmvPS5YV2TnyQVwV6mYLNRJhtC0ZuNJ2nRMqQtFh+ErdTEtGW0oF
         D9GVX+ovK0K6dybpjHTNXr8b8WgWa+6ZcGYQDdGVxIEOrmvNLutBACZBvemGoLBFtHDC
         /4u/JnsFj41bXETuZpkXecnhWUDQaDDKTQ9dtomcXBJF72z6l9GZJpJmGHN34uIgVGyz
         g+nIzYUNZLJUOLo8yDikAjdjh/KyeSE9hvKD8QEqgYCKNpBlds9LzWKAVmUzXJT3kHvY
         ljcJB3E8iUFdCK86jr/dnk3jxsenzeXe0ln5ExR0XD5GMCNA2hfsOjpuPR7wZTXiMnLO
         V81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pPafUjv32X7Tp6z/45/uvMkZXVHK036vfrGmxlDoCqc=;
        b=lxb8GWEPF9GI38HsakbKv4VqB89cd6VJ8JSyj1RcyuATdF+r5m0saF3pREqtnuBOiP
         tL7sefp/9DyfIxehFJVF5v1HnOVh9K1eSIHJsP1cKNOZhvfaJXJhNqR5BsSqxSJ6FQlB
         rRNda/vgDuHtFCnEG4e3LfvAu9lAQCmFYhalW7LuBmmml1UHjI9lG1OcYaifnAIgk8Nc
         tFUEhnG9fdPfG1iClH/WtpXlmsLHTnZOg1rfy33ERihOrGWcY1cLnTsi6oElO5V42a8B
         ijynGf9EEFvRCQdD0Fr3Pqd/1O1KPl+RDrlQKuavlPLz4gH3CosMRguMXpphpTf1NGD+
         hcgg==
X-Gm-Message-State: AGi0Pub3Kz45e1y9n3+cBESHXlNWJkDjUf0gOR7jOkfE0l1Wauo2hOMR
        0d3B2ElpdZUFds5hwqquKSdG9/jPhukAfmTcscg=
X-Google-Smtp-Source: APiQypLPVDzxvhzLFVRP24q9WZFFMHeyKpXAbDxeXZ4V20xdJBm29lyw6WCS3lh6VyzEe+6YE83kfBq7PUDsUmvro1c=
X-Received: by 2002:ac8:3f6d:: with SMTP id w42mr10567626qtk.171.1587752139952;
 Fri, 24 Apr 2020 11:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <187929551.20583102.1587742448675.JavaMail.zimbra@redhat.com> <1205209934.20590134.1587745755940.JavaMail.zimbra@redhat.com>
In-Reply-To: <1205209934.20590134.1587745755940.JavaMail.zimbra@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 24 Apr 2020 11:15:29 -0700
Message-ID: <CAEf4BzYB0gdKuK3Jg9Qj6LTGBsbYOz2+=LqBG-G9Kq_-YxDVZQ@mail.gmail.com>
Subject: Re: selftests 'make install' crashing due to bpf makefile bug
To:     Veronika Kabatova <vkabatov@redhat.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Jesper Brouer <jbrouer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 24, 2020 at 9:29 AM Veronika Kabatova <vkabatov@redhat.com> wrote:
>
>
> Hi,
>
> we've been working on adding selftests to CI for bpf-next and ran into
> problems when running 'make install'.
>
> Steps to reproduce:
>
> make -C tools/testing/selftests install TARGETS="bpf"
>
> The underlying build completes fine but the install step crashes with
> following error:

I assume "crashes" means fails here, not really core-dumping process, right?

>
> rsync: link_stat "/kernel/bpf-next/tools/testing/selftests/bpf/runqslower"
>        failed: No such file or directory (2)
>
> lib.mk expects all TEST_GEN_PROGS_EXTENDED to be present in the subsystem
> selftests directory, while runqslower is located in tools subdirectory
> instead [0].
>
> The directory override was originally added together with the runqslower
> target in [1] a few months ago. The issue was most likely overlooked for
> two reasons:
> - people don't use 'make install' for bpf selftests
> - kselftest_install.sh script happily continues after errors so while
>   the same error is present, it is easy to overlook. runqslower is
>   "simply" not present in the created kselftest_install/bpf
>
>
> We currently see two potential solutions:
> a) Remove "OUTPUT=$(SCRATCH_DIR)/" from runqslower target
>    - Tested this for our use case but it has a potential of breaking
>      workflows
> b) Add a copy from bpf/tools to the bpf directory at the end of the target

We don't want to do a) to keep runqslower completely isolated from
selftest build. Doing b) should be fine, though.

>
> Which one of them is preferred? Or does anyone have an alternative idea?
> I'm willing to post a proper patch if needed (once we agree on the proper
> fix) or test any proposals in our environment.
>
>
> [0]: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/tools/testing/selftests/bpf/Makefile#n143
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3a0d3092a4edbbc
>
> Thanks,
> Veronika
>
