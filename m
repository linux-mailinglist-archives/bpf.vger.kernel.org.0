Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 262A02CD42B
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 12:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbgLCLDS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 06:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbgLCLDS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 06:03:18 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1DFC061A4D
        for <bpf@vger.kernel.org>; Thu,  3 Dec 2020 03:02:37 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id t6so2056814lfl.13
        for <bpf@vger.kernel.org>; Thu, 03 Dec 2020 03:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kFtuDae3CWo/l0RthqEkVPp2B+lh8EbRh81NSdxjSgM=;
        b=R3ceNOv1nFfIOjUysryzs1/7Y0zUo66o5T+qwGJ7VLU8zUJno5wzYlNPWfzpitkqd5
         +CtRYEspK27dOuCKr2SnTC1I6tXy+wqu6GGE2MCE0frbNEdUj1ZUivPhsOLt76ZCwZCh
         AHwu4n8Df3mW4nxN9cyh4RKWxRoli+T6MTPF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kFtuDae3CWo/l0RthqEkVPp2B+lh8EbRh81NSdxjSgM=;
        b=nVPOdrc3twVkTJX+VSZTEahHkmVaIicMnWutM42y6iv26ViBSNnXHGXbASq/6yEOl1
         f6pEpU9pvIv84otsjL7MeDV157RUkpx1WdenYL1Zi258vAJ5bgrxE9XYfdJiNvPCloke
         N9EkTsLv1ruoHGpOkZN4Zczi7fj3qB8AtLmEQlaEPpfbtIAGuugsapmT2piBMVil0iWY
         /27fQRluKXfmu0S8sZ0fJRrX+0AZfs2pHhH4fCiDq9nbi52OAoYZRat3ns3n1+hyMizK
         4Z8yavOkDljx5KlWZ8gENYedUvozjtwA8aoTHxlYXYB3OXax02oJEwFA/F11UcqSgHuq
         wB0A==
X-Gm-Message-State: AOAM530vZUlIvxe0M0cCAkihinHyfLMgOoBt556gkWj3sgDXklYfXHR9
        +CS3EHXkvT1eA+1yVY9iy4pe3IO4yol/KymTXhKlDg==
X-Google-Smtp-Source: ABdhPJxLT2pRnZ+TOQjJNqh4oqbqZlU25EDywS9M9OTDHAz0Wu8bNsgTFd2nJzx12lFN9Eb/728vuK+idbp09qgOKRk=
X-Received: by 2002:a05:6512:110a:: with SMTP id l10mr1066936lfg.167.1606993356433;
 Thu, 03 Dec 2020 03:02:36 -0800 (PST)
MIME-Version: 1.0
References: <20201203005807.486320-1-kpsingh@chromium.org> <20201203005807.486320-5-kpsingh@chromium.org>
 <CAEf4BzZSw-338WCzhbWyJGOVnkBvOsLqoqa1yTA88aNe8JdJtA@mail.gmail.com>
In-Reply-To: <CAEf4BzZSw-338WCzhbWyJGOVnkBvOsLqoqa1yTA88aNe8JdJtA@mail.gmail.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Thu, 3 Dec 2020 12:02:25 +0100
Message-ID: <CACYkzJ6p9ev0dKGUTpcgmjs5cU=9VRvOMqhKYgFLOaAtSa5pXw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/4] selftests/bpf: Indent ima_setup.sh with tabs.
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 3, 2020 at 6:46 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Dec 2, 2020 at 4:58 PM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
>
> Commit message is missing completely.

I thought the subject is enough in this case to explain that we are
re-indenting the file.

I can explain that this was missed because checkpatch.pl did not
complain about shell
scripts and that we would like to be consistent with the other shells scripts.

>
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> >  tools/testing/selftests/bpf/ima_setup.sh | 108 +++++++++++------------
> >  1 file changed, 54 insertions(+), 54 deletions(-)
> >
>
> [...]
