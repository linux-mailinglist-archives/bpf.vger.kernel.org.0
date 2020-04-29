Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3ED11BD0DC
	for <lists+bpf@lfdr.de>; Wed, 29 Apr 2020 02:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgD2AQH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Apr 2020 20:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726355AbgD2AQG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 28 Apr 2020 20:16:06 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02210C03C1AC
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2020 17:16:06 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id p13so294118qvt.12
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2020 17:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QjcMVd62cBcBYuo19RjjPoO7o0XbAonG5SKrDKCtA1M=;
        b=QO5OIfa4ZqCrAt1z0eIBZqkXIf65B/SmL5u0Ks679Hu6BLtXKArYM8cz6y+EbF+SV9
         pOlcpwjltm+Vbep5MjEUxeaPpIVgAzq5JmiSGpieUbLQoinAbPBO7i1fmuUSf5zuBngS
         n9BKrn/4vMLeYx3S9BbQwW3GePiNcVCy8XFgRL94wziLWzMtK6Y93HUH+xlRivRFeiJc
         3VoXrJ3/QxI0XaYKZ50/xoNLrRprRCHP67jXMH2V7DkZ9pXipyqzkvpZDmWEF0RjtkV7
         8stlFGTpUXDmUUM/N6zpXMji9eBacq7EXDrJlviBNlk2wKAJ2RPh4j+ShdesL4jMDpOa
         0TjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QjcMVd62cBcBYuo19RjjPoO7o0XbAonG5SKrDKCtA1M=;
        b=FBWeQoeqQWZxIoP+MEeCpD2MVZHvHeAyHn0nq+D9+g24BXru81uugfSr5LQZyngeMT
         xwryId2qbboHIxcKOG0Cpl7JBBXK3tSeaeTnFpS5zSyaQLg2IdOUmO5hn6UZKKcZf3HO
         slHPTSQqN/TizlTwzgB3S8keoP7ueu2mWairosPbT6Y2usrBfABzrogQ6bmXIPdFaNxc
         3HCJJbkKE0WfX6Ax60RlU6ieTTeeSPMkXj+chmE+i7y2B970QxmxYxSNN2ZHcRXnWITv
         XDM3SYDh0xB7cVjLSOr1o9DlsSSYpZrYvae75H2+Tx3qr9/uccgs3Jro81R9xJVNiKCw
         X/cg==
X-Gm-Message-State: AGi0PuZ2Iz1sejFkv5L1hfq6GLtCJJ+XUAwzcAdiq+0hobbu8onUtCVi
        16wp2UwgVNpNkoeI8YD//WtdFOOxay+9H86l0yE=
X-Google-Smtp-Source: APiQypI4jreJ//CEGRbBF5uReLc79x4Ttxl4o8nH+uYWpJYA3GonowLXKWmk3pdKX9xuLjlTg7yqS1oqtf8r87F7FjI=
X-Received: by 2002:a0c:fd8c:: with SMTP id p12mr31094520qvr.163.1588119364118;
 Tue, 28 Apr 2020 17:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200428173742.2988395-1-vkabatov@redhat.com> <CAEf4Bzbp44pnj-yNP61enxh8-ZvFn56fSF4uDHLz0ZcY-H2yAA@mail.gmail.com>
 <8e07a2db-a258-f1b3-d1f4-74f131cbcb6d@iogearbox.net>
In-Reply-To: <8e07a2db-a258-f1b3-d1f4-74f131cbcb6d@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 28 Apr 2020 17:15:53 -0700
Message-ID: <CAEf4BzactULF+w-0yWt83T1thv3G+KoQ9ciqZF+PrnGBATc2Sw@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/bpf: Copy runqslower to OUTPUT directory
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Veronika Kabatova <vkabatov@redhat.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 28, 2020 at 12:40 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 4/28/20 8:57 PM, Andrii Nakryiko wrote:
> > On Tue, Apr 28, 2020 at 10:38 AM Veronika Kabatova <vkabatov@redhat.com> wrote:
> >>
> >> $(OUTPUT)/runqslower makefile target doesn't actually create runqslower
> >> binary in the $(OUTPUT) directory. As lib.mk expects all
> >> TEST_GEN_PROGS_EXTENDED (which runqslower is a part of) to be present in
> >> the OUTPUT directory, this results in an error when running e.g. `make
> >> install`:
> >>
> >> rsync: link_stat "tools/testing/selftests/bpf/runqslower" failed: No
> >>         such file or directory (2)
> >>
> >> Copy the binary into the OUTPUT directory after building it to fix the
> >> error.
> >>
> >> Fixes: 3a0d3092a4ed ("selftests/bpf: Build runqslower from selftests")
> >> Signed-off-by: Veronika Kabatova <vkabatov@redhat.com>
> >> ---
> >
> > Acked-by: Andrii Nakryiko <andriin@fb.com>
>
> Applied, thanks!

Veronika,

This change leaves runqslower laying around in selftests/bpf directory
and available to be committed into git. Can you please follow up with
adding runqslower to .gitignore? Thanks!
