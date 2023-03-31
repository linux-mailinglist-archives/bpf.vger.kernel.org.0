Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55ACB6D2491
	for <lists+bpf@lfdr.de>; Fri, 31 Mar 2023 18:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjCaQAQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Mar 2023 12:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbjCaQAP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Mar 2023 12:00:15 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA10B44E
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 09:00:10 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id eh3so91411364edb.11
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 09:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680278409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NA8ZfrWiBmY1+1zNdgSA+xwqJGbytmMkfuQg3UsTjU0=;
        b=VAxWNjEDh/BbFOt0n7tZ5hPSikkKM7bT3blQrjC8bribrbnuXcEGZQcF2hxkTGbu8J
         p1mzjdt7btKRumoagvQtE9aF5mak/wy8qElpTGT+wOYEZr0avY1kg3sBJgDHl+EgCUvt
         Ml4eQdenGPwth/S4dVNQcegN7wcB2M//XIuC025Kf2bcUL34U2skpldojob8kXqy44Ey
         kbIYYyLlLvAcHTlHtb57Lm7Rsjk6KYyfM19GjF4PkXGXqZOvEHblSn6LKzC8u9nKep2F
         OX8wQqWquItyQkI695ibX4vXoi25eThdWH9KiLy4Q3pOEAtT5qsB80L0k8Kt6Ls6idAO
         k3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680278409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NA8ZfrWiBmY1+1zNdgSA+xwqJGbytmMkfuQg3UsTjU0=;
        b=mVv5zUJCBjm3BPKYBS8KgsWU8t/2T4PIG7ACfd45vxPz0IUYD0hEiDBnK9ofEMm9Ov
         EIQ8szCT5nSP0BbXJJU61XTuza75/6PEwXVh6DR8KFYOi/BrObeXaO8nD0O5BytHRga3
         wke9taUeziO/AGF8ZLHx2VP7OOSkNXvSUxQGFBHDmsNS5CmATa1YqxZec6qc/Y5qzbE6
         ydoPH7DfjcI+LI4a1gpYVdSNaQMqgTU0h2kQJbw/jxLNb3mcrbQM2po8S8V0sWrVHum4
         cvf3qJk2DYyZG/c/MavcA5kJ0JeLQg4ch7NdyM9CA9cH3fcQ64Rd8/5KxuDJG8Ejm1iS
         JTIA==
X-Gm-Message-State: AAQBX9fg/a5e/pYnLYtTsChE4OHKen3ftpEqDQUMniixa6jKYe8Uvlfv
        TGJZajTBypeGw8JphjnAaGvUL+0mwJqLP0ka260=
X-Google-Smtp-Source: AKy350bY4GB5+tkebYMUAYCa2a/GlbLYvKaC1G/v++o4Txaso3xWF0OvKXjuF9S0dvgeyuNjfeqyRgg2HJNRZ++8M5w=
X-Received: by 2002:a50:d58c:0:b0:502:719e:e7e9 with SMTP id
 v12-20020a50d58c000000b00502719ee7e9mr2893252edi.1.1680278409022; Fri, 31 Mar
 2023 09:00:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230328235610.3159943-1-andrii@kernel.org> <20230328235610.3159943-5-andrii@kernel.org>
 <CAN+4W8h4QwvVcKkfTGOKAug2wnbZi5t5GyXXK0VWoobrNo1jpA@mail.gmail.com>
 <CAEf4BzbH7tB+zaK=DJtpR+SXqhNqwYMwiru9xpuAhGpaaFrJsg@mail.gmail.com> <68b1465b-e970-15c3-37a6-f81a639bc71c@incline.eu>
In-Reply-To: <68b1465b-e970-15c3-37a6-f81a639bc71c@incline.eu>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 31 Mar 2023 08:59:56 -0700
Message-ID: <CAEf4BzarW-zUiP19_Xn5-1YgVkLXES4L1rqk1m5H7cqgKqMxNQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/6] libbpf: don't enforce verifier log levels
 on libbpf side
To:     Timo Beckers <timo@incline.eu>
Cc:     Lorenz Bauer <lmb@isovalent.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
        robin.goegge@isovalent.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 31, 2023 at 2:39=E2=80=AFAM Timo Beckers <timo@incline.eu> wrot=
e:
>
> On 3/30/23 23:05, Andrii Nakryiko wrote:
> > On Thu, Mar 30, 2023 at 10:13=E2=80=AFAM Lorenz Bauer <lmb@isovalent.co=
m> wrote:
> >> On Wed, Mar 29, 2023 at 12:56=E2=80=AFAM Andrii Nakryiko <andrii@kerne=
l.org> wrote:
> >>> This basically prevents any forward compatibility. And we either way
> >>> just return -EINVAL, which would otherwise be returned from bpf()
> >>> syscall anyways.
> >> In your cover letter you make the argument that applications can opt
> >> out of the behaviour, but I think shows that this isn't entirely true.
> >> Apps linking old libbpf won't be able to fix their breakage without
> >> updating libbpf. This is especially annoying when you have to support
> >> multiple old versions where doing this isn't straightforward.
> >>
> > Ok, technically, you are correct. If you somehow managed to get a
> > bleeding edge kernel, but outdated libbpf, you won't be able to
> > specify log_level =3D 8. This is not the only place where too old libbp=
f
> > would limit you from using bleeding edge kernel features, though, and
> > we have to live with that (though try our best to avoid such
> > dependencies, of course).
> >
> > But in practice you get the freshest libbpf way before your kernel
> > becomes the freshest one, so I don't think this is a big deal in
> > practice.
> Hey Andrii,
>

Hi Timo, thanks for chiming in!

> In an ideal world, yes, but not how it works out in practice. Anything
> that ships in a container obviously misses out on distro packages of the
> underlying host that are tied to the running kernel. This looks like it's
> quickly becoming a majority use case of bpf in the wild, barring of cours=
e
> Android and systemd.
>
> In practice, we get to deal with rather large version swings in both
> directions; users may want to run the latest tools on 4.19, or last
> year's stable tool release on 6.1, so the need for both backwards- and
> forwards-compatibility is definitely there.

Yep, that sucks. And just reminds us again and again what I've been
consistently telling anyone who wanted to listen: statically linking
against libbpf is the best strategy to avoid unnecessary headaches.
Control your destiny (i.e., dependencies).

But in general, yes, I totally agree that unnecessary changes that
require the newest libbpf should be avoided. I think that in this case
with BPF_LOG_FIXED it's justified, though, and I think you are
agreeing as well, see below.

>
> Fortunately, things don't break that often. :) The biggest papercut
> we've had recently was the introduction of enum64, which just flat
> out requires the latest userspace if kernel btf is needed.

Yep, BTF changes are most painful and are felt across the entire range
of tools, unfortunately. This is offtopic, but this is one of the
reasons we were discussing with Alan how to make BTF more
self-describing. I still think we should do this, no one had time to
take this on, yet.

> >> Take this as another plea to make this opt in and instead work
> >> together to make this a default on the lib side. :)
> > Please, help me understand the arguments against making rotating mode
> > a default, now that we return -ENOSPC on truncation. In which scenario
> > this difference matters?
> I think there may be a misunderstanding. As you mentioned, there's rarely
> anything useful at the start of the log. I think the opt-in behaviour
> under discussion here is the lack of ENOSPC when the buffer is undersized=
.
> Userspace should set a flag if it supports receiving a partial log withou=
t
> expecting ENOSPC.

Great, thanks for specifics. I think we can finally be on the same
page. Pretty much the only change in this v2 is exactly the -ENOSPC on
log truncation in *either mode*. See version log from cover letter:

  - return -ENOSPC even in rotating log mode for preserving backwards
    compatibility (Lorenz);

>
> I've lost track of the exact changes that are now on the table with your
> second patch set floating around. The way I understand it, there are
> multiple isolated behavioural changes, so let's discuss them separately:
>
> - Log will include the tail instead of the head. This is a good change, n=
o
>    argument there, and personally I wouldn't bother with a flag until
>    someone complains. Old userspace is (worst case) already used to retry=
ing
>    with bigger buffers until ENOSPC is gone, and (best case) gets a few
> pages
>    of actually useful log if it doesn't retry.

Agreed. And that's how it behaves, you don't need a flag to get this
behavior and that's exactly what I'm arguing with Lorenz to preserve.

>
> - log_size_actual: if populated by the kernel, userspace can do a perfect
>    retry with the correct buffer size. Userspace will naturally be able t=
o
>    pick this up when their bpf_attr gets updated. No opt-in/flags needed
>    because not a breaking change.

Yes. That's what the follow up patch set is doing. No new flag, just a
new field which kernel populates. See [0]

  [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=3D735213&=
state=3D*


>
> - No more ENOSPC: this needs to be opt-in, as old userspace relies on ENO=
SPC
>    to drive the retry loop. If the kernel no longer returns ENOSPC by
> default,
>    userspace will think it received a full log and won't be able to detec=
t
>    truncation if it doesn't yet know about the log_size_actual field.
>    From what I gather, we're also in agreement on this. Idea for a flag
> name:
>    BPF_LOG_PARTIAL?

Ok, this is where the misunderstanding is. We don't have a mode where
the verifier succeeds on log truncation. And I don't even plan to add
a flag to enable this no-ENOSPC mode. V2 always returns -ENOSPC on
truncation.

The only difference is that on truncation the user gets the tail of
the log, and that's the default behavior. And BPF_LOG_FIXED is there
only for uncommon cases where the beginning of the log is needed in
case of truncation. That's it.


>
> Hope this can move the discussion forward, it looked to me like we were j=
ust
> talking past each other. Thanks for addressing our feedback so far!

Yep, I hope so too. I think this v2 is exactly behaving like you want
and expect, and you guys missed that we do now return -ENOSPC even in
new rotating mode. Please let me know if this clarifies things,
thanks!


> > 1. If there is no truncation and the user provides a big enough buffer
> > (which my second patch set makes it even easier to do for libraries),
> > there is no difference, they get identical log contents and behavior.
> >
> > 2. If there was truncation, in both cases we get -ENOSPC. The contents
> > will differ. In one case we get the beginning of a long log with no
> > details about what actually caused the failure (useless in pretty much
> > any circumstances) versus you get the last N bytes of log, all the way
> > to actual error and some history leading towards it. Which is what we
> > used to debug and understand verification issues.
> >
> > What is the situation where the beginning of the log is preferable? I
> > had exactly one case where I actually wanted the beginning of the log,
> > that was when I was debugging some bug in the verifier when
> > implementing open-coded iterators. This bug was happening early and
> > causing an infinite loop, so I wanted to see the first few pages of
> > the output to catch how it all started. But that was a development bug
> > of a tricky feature, definitely not something we expect for end users
> > to deal with. And it was literally *once* that I needed this.
> >
> > Why are we fighting to preserve this much less useful behavior as a
> > default, if there is no reduction of functionality for end-users?
> > Library writers have full access to union bpf_attr and can opt-out
> > easily (though again, why?). Normal end users will never have to ask
> > for BPF_LOG_FIXED behavior. Maybe some advanced tool-building users
> > will want BPF_LOG_FIXED (like veristat, for example), but then it's in
> > their best interest to have fresh enough libbpf anyways.
> >
> > So instead of "I want X over Y", let's discuss "*why* X is better than =
Y"?
> >
> >> Apps linking old libbpf won't be able to fix their breakage without
> >> updating libbpf. This is especially annoying when you have to support
> > What sort of breakage would be there to fix?
> >
> > Also keep in mind that not all use cases use BPF library's high-level
> > code that does all this fancy log buf manipulations. There are
> > legitimate cases where tools/applications want direct access to
> > log_buf, so needing to do extra feature detection to get rotating mode
> > (but falling back without failing to fixed mode on the old kernel) is
> > just an unnecessary nuisance.
>
