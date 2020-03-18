Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E282189392
	for <lists+bpf@lfdr.de>; Wed, 18 Mar 2020 02:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbgCRBMM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Mar 2020 21:12:12 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:44762 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbgCRBMK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Mar 2020 21:12:10 -0400
Received: by mail-ua1-f67.google.com with SMTP id a33so8817056uad.11;
        Tue, 17 Mar 2020 18:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YQUxQsKTflSf1jqqu7EXyaCvYDjM7rXV3AdTgILyGLc=;
        b=Ka9KVMMXYype3zBtxFLeMETam2trwKLJi84DPgEkEazxab2hIpGlSXAk3szajTm6qm
         nWmjvC22N441B7WvyYSrdMVA7Y/f4C8IlFanyael2OElgg3YzAi9q4RWSQ2LtfymLiVh
         7NqreOoagLOdU9Zldx9NT1IvEvrcKzAg9jdRVBifLdoWOFCm6WUefHck3H7aK46H+RGk
         SL79LRVqTy/Yr1Z/fJyjjBY6K3Upnlxr4rWiUVeg1AQ7VwHlJcYalAPBaDwiXdxzKYTP
         YyioKXyiSqKMFBVHDxVSc2fszLWoVxxqEcEBQnfUNW9KbkFe1tKI3N3NCVEMbTj1oA/p
         dycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YQUxQsKTflSf1jqqu7EXyaCvYDjM7rXV3AdTgILyGLc=;
        b=YQVEhAgm8tyLqws313nOmSY8nV1quRlNMF1yG34NV0GW3/Whm3c5zDA1f+dXi/nynB
         EInivxPkq2eD92si98ktgL/OFT3aRuXqIK4C4f7R2hnUnV+kHW9oYesyeo7Z+ZyVanAa
         qmRDYMHkfiDLEKivGscs8PnKjU8WnxOKuGWKORBANmohlDL6Va65qwRy5c8edlopeEvZ
         NadNrukTD25wwPAGsUeb9Zr0C1/AU30jn2xg+86jhLIUmFOS594pq2Aj4vKkURP1BMQ6
         HdsfY/eqjdI19y4fVA5+LjNEiMcUiwmsomQnM3ONw73jQ5G7RFIJEJGrGzcWAC4VTHwW
         nX6w==
X-Gm-Message-State: ANhLgQ1yS5smouGGc25UfFpax6e70oEyKrk1YZMsqVxbY7i7OjMFi4LF
        q6edWuULt27bMqJ2iP2LV6mOP4AXDxqQOCf1pOc=
X-Google-Smtp-Source: ADFU+vveNKEgyfn+pXyNzSHLXVXMVYZf1qY4AqaVW6j1CQugHCxtDn/EHyqWR7bwHrM9prMnRlCcXUjadRSVFEoDyPg=
X-Received: by 2002:a9f:2f08:: with SMTP id x8mr1387838uaj.49.1584493928730;
 Tue, 17 Mar 2020 18:12:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200316163646.2465-1-a.s.protopopov@gmail.com>
 <202003161423.B51FDA8083@keescook> <CAGn_itw594Q_-4gC8=3jjRGF-wx90GeXMWBAz54X-UEer9pbtA@mail.gmail.com>
 <202003171314.387F3F187D@keescook>
In-Reply-To: <202003171314.387F3F187D@keescook>
From:   Anton Protopopov <a.s.protopopov@gmail.com>
Date:   Tue, 17 Mar 2020 21:11:57 -0400
Message-ID: <CAGn_itz7jgoP5J1pjJ7BLaeh4my=JY2yQ7T8ssoYrqPOWvwKug@mail.gmail.com>
Subject: Re: [PATCH] seccomp: allow BPF_MOD ALU instructions
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

=D0=B2=D1=82, 17 =D0=BC=D0=B0=D1=80. 2020 =D0=B3. =D0=B2 16:21, Kees Cook <=
keescook@chromium.org>:
>
> On Mon, Mar 16, 2020 at 06:17:34PM -0400, Anton Protopopov wrote:
> > and in every case to walk only a corresponding factor-list. In my case
> > I had a list of ~40 syscall numbers and after this change filter
> > executed in 17.25 instructions on average per syscall vs. 45
> > instructions for the linear filter (so this removes about 30
> > instructions penalty per every syscall). To replace "mod #4" I
> > actually used "and #3", but this obviously doesn't work for
> > non-power-of-two divisors. If I would use "mod 5", then it would give
> > me about 15.5 instructions on average.
>
> Gotcha. My real concern is with breaking the ABI here -- using BPF_MOD
> would mean a process couldn't run on older kernels without some tricks
> on the seccomp side.

Yes, I understood. Could you tell what would you do exactly if there
was a real need in a new instruction?

> Since the syscall list is static for a given filter, why not arrange it
> as a binary search? That should get even better average instructions
> as O(log n) instead of O(n).

Right, thanks! This saves about 4 more instructions for my case and
works 1-2 ns faster.

> Though frankly I've also been considering an ABI version bump for adding
> a syscall bitmap feature: the vast majority of seccomp filters are just
> binary yes/no across a list of syscalls. Only the special cases need
> special handling (arg inspection, fd notification, etc). Then these
> kinds of filters could run as O(1).
>
> --
> Kees Cook

Thanks,
Anton
