Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2622CDEA7
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 20:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbgLCTS1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 14:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgLCTS1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 14:18:27 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF6FC061A51
        for <bpf@vger.kernel.org>; Thu,  3 Dec 2020 11:17:46 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id r18so3823762ljc.2
        for <bpf@vger.kernel.org>; Thu, 03 Dec 2020 11:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WMHwuy1Lb5y4C5DqRhRZgvIin0to9kcGFamkvkxXTQc=;
        b=KAHRFfBWb1gQ10QzmUa4rEzNLJZCXNNYYM8l3nMBk57HaJJEfwiKJS/yesBY0spHSG
         hSXYeS3Q+8rn0NAkVJXujH+H4Aivvx1ibPWof6wYkx9xfEZYtM91lzaa4kcChEm0xeo8
         J8nneCrZP2n2DF6A3v1DdinTqq4llxTRtdQDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WMHwuy1Lb5y4C5DqRhRZgvIin0to9kcGFamkvkxXTQc=;
        b=HHefC84rYEPT8dd7rToULZTAfSlD1HitOhtZCUd7nsD7sI170m1wMHDdsoWRO3RRQi
         h6n3gBO6sYm39BaN/R2bf2uzqjTapJi11zEMwgrTE3olfJ7gZtOm/tXvLW6ssLsyKAe2
         rxgzQV458O+x5r2rbnxjQ/CxuNZZrGTtJDK2nU0nroYlNevbFIQR0SSvSKzEq3y+D0eu
         e3HOQMaCYmGwLZVSTrEqe5X4OpCNPoKZ4QhkxJJZJu88uKM091w0N/iWiudrqADSGoqr
         LYgVYtCkPCE/2adiipPT2Qj19GRvbr1HktJEK7/zoWBj3BTzfo9wWOAPde5yQ3UeE1v9
         jgmA==
X-Gm-Message-State: AOAM530ThLZHT0vWY4oyhgq1oDujnzh8g1wiMNwEnAxad3/uotf8KAuB
        1S2E51OS/96EgbGDC0pBYNkCQSgL8Be9EY8g5AxVLw==
X-Google-Smtp-Source: ABdhPJyz/gC0XZfWpPAGFVzOnsadOcUWrt//sUZC/7ZXN+k769DJXwSHXd2ppBq4Q8Wazme1YkmUU6z8tzfk6328djQ=
X-Received: by 2002:a2e:97ce:: with SMTP id m14mr1808414ljj.49.1607023065205;
 Thu, 03 Dec 2020 11:17:45 -0800 (PST)
MIME-Version: 1.0
References: <20201203005807.486320-1-kpsingh@chromium.org> <20201203005807.486320-5-kpsingh@chromium.org>
 <CAEf4BzZSw-338WCzhbWyJGOVnkBvOsLqoqa1yTA88aNe8JdJtA@mail.gmail.com>
 <CACYkzJ6p9ev0dKGUTpcgmjs5cU=9VRvOMqhKYgFLOaAtSa5pXw@mail.gmail.com> <CAADnVQLR=PzGCU4-GLLgY7R5DT6xyOgf3z0QKU+bDVFW2zWChg@mail.gmail.com>
In-Reply-To: <CAADnVQLR=PzGCU4-GLLgY7R5DT6xyOgf3z0QKU+bDVFW2zWChg@mail.gmail.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Thu, 3 Dec 2020 20:17:34 +0100
Message-ID: <CACYkzJ7giwtZ=2iHTifvJAZE7K3FyNRuqrObG9X4SzVKsX+K7g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/4] selftests/bpf: Indent ima_setup.sh with tabs.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 3, 2020 at 8:10 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Dec 3, 2020 at 3:02 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > On Thu, Dec 3, 2020 at 6:46 AM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, Dec 2, 2020 at 4:58 PM KP Singh <kpsingh@chromium.org> wrote:
> > > >
> > > > From: KP Singh <kpsingh@google.com>
> > > >
> > >
> > > Commit message is missing completely.
> >
> > I thought the subject is enough in this case to explain that we are
> > re-indenting the file.
>
> If there is nothing to add just copy paste the subject into commit log.
>
> > I can explain that this was missed because checkpatch.pl did not
> > complain about shell
> > scripts and that we would like to be consistent with the other shells scripts.
>
> checkpatch is a guidance. It's not a must have requirement.
> It works both ways. Sometimes we ignore checkpatch complaints.
> Sometimes we ask for things that checkpatch doesn't know about.

Agreed, I, personally, just missed it because my editor did a weird thing
and I was relying too much on checkpatch.

>
> Please respin at your earliest convenience. CI is suffering at the moment.
> It needs to be unbroken soon.

Done. I was aware of the CI being broken :) thus this shabby work on the cover
letter and commit message (not really an excuse though).

Also, as mentioned previously, we will script and allow users to run the tests
in a CI equivalent environment so that it spares us of this pain. That's next
on my TODO list.

- KP
