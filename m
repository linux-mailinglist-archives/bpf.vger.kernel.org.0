Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A212115CA
	for <lists+bpf@lfdr.de>; Thu,  2 Jul 2020 00:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgGAWXG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jul 2020 18:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgGAWXF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jul 2020 18:23:05 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF38C08C5C1
        for <bpf@vger.kernel.org>; Wed,  1 Jul 2020 15:23:05 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id d21so14643033lfb.6
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2020 15:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EPbcu96BJ5hfMvTUm07h118zB3h4xgj1aTtS4OK8Wos=;
        b=PgNxnj0GERc+cw3V9suJzdpMRAm00xRLfxrtDq3pJ1cgWQ7KQLfX48eQcIaMJBKe7A
         40hD2l/T7jh779PYvcE1eFOoKhtVrik7+tFMiX3xVaH/9pYrVOXRdYzP6UXbuAvcjeVR
         +jjmCZb51gwvXJZtlHEOA5NptVUTe+1id116y5VKn0IDVVQc5MZsPy9joiZEtPv+KE0m
         4eXQGZORUtNmuNHfzX3UBc0LNyboqh06aNWBdfa6W6ZBAdM/KY05vecjuRdXqZ8aUxnW
         UxrQEYriKVcnaH41BNq/KQ2fTc4PhLunoLuyVJTU385cwvQUptXlBj8lb+VWfxR1rV+e
         oDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EPbcu96BJ5hfMvTUm07h118zB3h4xgj1aTtS4OK8Wos=;
        b=IAMiCEz8cf/+7YDPWKHAxri+GLtGs0Fp78g12qR9LBtZo/1gbxPx41MZ5NWCu7FJe3
         8GaXegCvaA+T4PlgbimjklngPDZGz1E0Ky4xRm3y8SG5IDOy13+mb36aukStN/ro7z1x
         nXEwcsM9MxrGQq+VhbdnurqQ+aw7I2E2GrjkeS3sVN1qHL/xQM0lCbHz98R6Gu2ZN5eg
         lGvnXYq/cjB4cMSTqfVbSSkf9P37dC+kg/0H8Y+IM8Y/WhkxPYtcXhCf04qdI/lVJm2x
         CAYON5fsJ2W+BITyG3s4vD+QfnGaG2/aPITZ6R34E0RJAJjdow2pP+T8/TDIH1c4VeDN
         rjiA==
X-Gm-Message-State: AOAM531+EyOQaKb6HVmtImth/vYfmavxXfqxLImOiYb5N4QrR6VpGHW5
        7sSbx9NZqfS0wEUfRBdfElBeCMcKX/Hj1WxQTRQ=
X-Google-Smtp-Source: ABdhPJxRk7Fzix32zRt9GxspFbuMz017m01cg7PAHs9GzZJcQiItBctqElZ09LpRKZHAOx9aUb4RsuIZxDHd4rvlJ6U=
X-Received: by 2002:a05:6512:54d:: with SMTP id h13mr16432546lfl.8.1593642183637;
 Wed, 01 Jul 2020 15:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <159363976938.930467.11835380146293463365.stgit@firesoul>
In-Reply-To: <159363976938.930467.11835380146293463365.stgit@firesoul>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 1 Jul 2020 15:22:51 -0700
Message-ID: <CAADnVQKd2hoRaNxC4jy5yh2zG4_1vkzXTaViG1Ox6QCgXYkTLg@mail.gmail.com>
Subject: Re: [PATCH bpf-next V3 0/3] BPF selftests test runner test_progs
 improvement for scripting
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Hangbin Liu <haliu@redhat.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Veronika Kabatova <vkabatov@redhat.com>,
        Jiri Benc <jbenc@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 1, 2020 at 2:44 PM Jesper Dangaard Brouer <brouer@redhat.com> wrote:
>
> V3: Reorder patches to cause less code churn.
>
> The BPF selftest 'test_progs' contains many tests, that cover all the
> different areas of the kernel where BPF is used.  The CI system sees this
> as one test, which is impractical for identifying what team/engineer is
> responsible for debugging the problem.
>
> This patchset add some options that makes it easier to create a shell
> for-loop that invoke each (top-level) test avail in test_progs. Then each
> test FAIL/PASS result can be presented the CI system to have a separate
> bullet. (For Red Hat use-case in Beaker https://beaker-project.org/)
>
> Created a public script[1] that uses these features in an advanced way.
> Demonstrating howto reduce the number of (top-level) tests by grouping tests
> together via using the existing test pattern selection feature, and then
> using the new --list feature combined with exclude (-b) to get a list of
> remaining test names that was not part of the groups.
>
> [1] https://github.com/netoptimizer/prototype-kernel/blob/master/scripts/bpf_selftests_grouping.sh

Applied. Thanks
