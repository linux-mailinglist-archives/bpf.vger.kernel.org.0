Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F6A2CDE83
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 20:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgLCTKm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 14:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgLCTKm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 14:10:42 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0644BC061A4E
        for <bpf@vger.kernel.org>; Thu,  3 Dec 2020 11:10:01 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id t22so3805076ljk.0
        for <bpf@vger.kernel.org>; Thu, 03 Dec 2020 11:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KWdnhz/krUjvIWTLIillI+m2YiUKft/qp1AMeP2r40M=;
        b=kpGpUDGkCwMiCdWCoy2TA045eFxYfZTmsHamTdHG/L6Fzj6wwVMiiQguvIJqMnIGGt
         gsGmSSjUGWDwYByL1FGj0Xq8GZMyYVaSk7TvHtanRcktFXgQgtIXV42H7e4j/u1oOwa3
         9/vcAt+uFWaGsDF7fsDBjxgQqeTK+ulICk+26OPBvCFUPZE9e7iW0SIhCqOQIa4xMOBg
         W1zt5QBAwyzegVZXRGAlyLdpKb0D1TOgUJ3xCdYoVc7a9wiEr6EkpTGcURDS6dlswhC6
         SqZT+JbWBoa4kbvcCqmBKX+AJLxvRn6et68q5Md18FXDEboVsMjVzD7dhMgPUD3fNyHJ
         seyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KWdnhz/krUjvIWTLIillI+m2YiUKft/qp1AMeP2r40M=;
        b=O0DO8DruoSpxlOTm6S/pOUp/VXzDLQS3BSUMrf45O2Grc/xObO8YXZO22KUvznRpIs
         Ldaz2Waru52PNrAv8zrmUjU7CuFM+67Qt5Y6CEOvplPQ9fyR04jVLQtRuaXoFsdWSyb/
         QyGRjQNqfiPd8BbfWeeCN8CWbLpYYUl9v3drcUGXHLr5zL9+vIbN37lTJsAUP5bM7qpI
         VqIN1cjUOF7XCBicGoNz95W7Tb2K3P+B4mwhefLFpDvrWbZ8qxRa7Lqj6v/HfF+whycd
         FcEXnifVwT7QLaDBU6PP/Y4ZLGIFu33lKsOCwPm42lrMXym8dxmC9rl27Pc+OGVJISMH
         5sGQ==
X-Gm-Message-State: AOAM532SBCUJ4UifhSCPwX8zP9xT9Qj5WIDRPgQc2Kf5sVjzmzpm8kth
        Fm2aWyO312HLz7LswRd0h8faYqxpZK6/3aRCdS8=
X-Google-Smtp-Source: ABdhPJyxMxkx/SFBPEpG1NjPuCVh8RQF3k6MYZbH68sTpvUS/kfSg5DlVBTYxW3U3ISp7mVY1PvRjxxsns6yuphkkVs=
X-Received: by 2002:a2e:6c14:: with SMTP id h20mr1804968ljc.450.1607022600413;
 Thu, 03 Dec 2020 11:10:00 -0800 (PST)
MIME-Version: 1.0
References: <20201203005807.486320-1-kpsingh@chromium.org> <20201203005807.486320-5-kpsingh@chromium.org>
 <CAEf4BzZSw-338WCzhbWyJGOVnkBvOsLqoqa1yTA88aNe8JdJtA@mail.gmail.com> <CACYkzJ6p9ev0dKGUTpcgmjs5cU=9VRvOMqhKYgFLOaAtSa5pXw@mail.gmail.com>
In-Reply-To: <CACYkzJ6p9ev0dKGUTpcgmjs5cU=9VRvOMqhKYgFLOaAtSa5pXw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 3 Dec 2020 11:09:49 -0800
Message-ID: <CAADnVQLR=PzGCU4-GLLgY7R5DT6xyOgf3z0QKU+bDVFW2zWChg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/4] selftests/bpf: Indent ima_setup.sh with tabs.
To:     KP Singh <kpsingh@chromium.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 3, 2020 at 3:02 AM KP Singh <kpsingh@chromium.org> wrote:
>
> On Thu, Dec 3, 2020 at 6:46 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Dec 2, 2020 at 4:58 PM KP Singh <kpsingh@chromium.org> wrote:
> > >
> > > From: KP Singh <kpsingh@google.com>
> > >
> >
> > Commit message is missing completely.
>
> I thought the subject is enough in this case to explain that we are
> re-indenting the file.

If there is nothing to add just copy paste the subject into commit log.

> I can explain that this was missed because checkpatch.pl did not
> complain about shell
> scripts and that we would like to be consistent with the other shells scripts.

checkpatch is a guidance. It's not a must have requirement.
It works both ways. Sometimes we ignore checkpatch complaints.
Sometimes we ask for things that checkpatch doesn't know about.

Please respin at your earliest convenience. CI is suffering at the moment.
It needs to be unbroken soon.
