Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D006C58C8
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 22:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjCVV2A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Mar 2023 17:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjCVV16 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Mar 2023 17:27:58 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FBF1FDC
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 14:27:57 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id cy23so78478848edb.12
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 14:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679520475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IVq1f1MiU9lfiItF2HZcmk49IC+eWMHuLHWZmZHoSks=;
        b=XxNdKsXXREsH7PYQDeNSHwAyO8GsSveceVE1Sznzm+Lo6yqagUER7Xk8MDQtaIPUze
         KkCm5L748Z4xxOVJhkXpXDYEWNDrQOeJZXvubNFke7QTTJF0Wimud9Z7jFGc7yr0dAbs
         cw2Ldleg8M3d0Q3LdRg03JU2WCfbiTJ87yPVX6qoziiFuXuoCcStqqNV+qX7ESZOMGmb
         y22RfqmUQK/ixWR1bzKgFzavDsiTRaVft+W5O9xcLeW8/PJDlFNFwnzhY40fp+gDAtYE
         TMpovuz2DZg7HwNJfQFGTjFrTy482Co0mJ1IXkLioUrCWvKZcr6qYt0qfTHUU45VF5SE
         bkbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679520475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IVq1f1MiU9lfiItF2HZcmk49IC+eWMHuLHWZmZHoSks=;
        b=BiRX7WLPNnCH/dXVAMkToglqDD+CCppxdS96Q3I/5vAJ88aHI/suwDJtMzC1xOP4u8
         e/PG8lfBT/tDIkl4QiDex9JWWDHn3SDk8BRqynsg8bBu21d9zlx0KWq9LyzDLQ9rpNBq
         x5oOy8Z5MngygagbzSIqaX8AlwG/LTHf80QksC0ukk+0VBVzLqA8NR9PRAZdFQv7ashD
         E406mfqS3CIWgoRXy5EkM3eXyyM5q8gQMQpTMVMOX7fAVMsPgh2PsRaqt7iQT/F+TXmd
         04QMP8bxh+SYJWs5E8kCzCaJonV3SKSOVQYyfPfW0SrHkj/ANCOzvQK4xRP4r9LA3R5l
         zRNA==
X-Gm-Message-State: AO0yUKUo4q9vjM43Rmb8nQYoHrPZasN/7E6nao9fPSOx0vF4N8mU+vyW
        L3CnwPnoT915awJwcilLgHwDoJbEnAZtVEMqdx0=
X-Google-Smtp-Source: AK7set9ctxRLh5kAs3C36hJOSObco0CuIfT7n3+SyfnHXurp1Ty/UxxNvsU4PT15EJQ+OmFvOIJzmdZCZz0wyVZpZ0A=
X-Received: by 2002:a17:906:85c1:b0:931:fb3c:f88d with SMTP id
 i1-20020a17090685c100b00931fb3cf88dmr4238150ejy.5.1679520475108; Wed, 22 Mar
 2023 14:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230317220351.2970665-1-andrii@kernel.org> <20230317220351.2970665-4-andrii@kernel.org>
 <bb0b7006-9a22-df8e-f623-d8a9d3069fc1@iogearbox.net> <CAEf4BzYM8Z1gp4x+tRLE2BFFi9idmuRiTSrHB7cGFA94E2hLmw@mail.gmail.com>
 <CAN+4W8j4Xi2zNx-0QgkRDgyzLFCP+-TqX3NzD=_nuJrD44TK0A@mail.gmail.com>
 <CAEf4BzYR4snO+-ntszFj-2kitAzJVi2j+O4+-KOa38g=0YS7cQ@mail.gmail.com> <CAN+4W8iNoEbQzQVbB_o1W0MWBDV4xCJAq7K3f6psVE-kkCfMqg@mail.gmail.com>
In-Reply-To: <CAN+4W8iNoEbQzQVbB_o1W0MWBDV4xCJAq7K3f6psVE-kkCfMqg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 22 Mar 2023 14:27:43 -0700
Message-ID: <CAEf4BzYEQA7R+8Y6v5uPGUkyiA9eTPynfQCLWPafy7SRpHmB2A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/6] bpf: switch BPF verifier log to be a
 rotating log by default
To:     Lorenz Bauer <lmb@isovalent.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, martin.lau@kernel.org, kernel-team@meta.com,
        timo@incline.eu, alessandro.d@gmail.com,
        Dave Tucker <dave@dtucker.co.uk>,
        =?UTF-8?B?Um9iaW4gR8O2Z2dl?= <robin.goegge@isovalent.com>
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

On Tue, Mar 21, 2023 at 9:18=E2=80=AFAM Lorenz Bauer <lmb@isovalent.com> wr=
ote:
>
> On Mon, Mar 20, 2023 at 6:55=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > Great feedback. Let me address all of it in one place.
> >
> > Let's start with right-sizing the buffer. Curiously, with existing
> > (fixed) log behavior, verifier doesn't and can't know the full size of
> > the buffer it needs, as we stop producing log after -ENOSPC condition
> > was detected. log->ubuf is set to NULL, after which
> > bpf_verifier_log_needed() will start returning false. So in existing
> > "logging mode" it's impossible to support this without major changes.
>
> I think that's fine, as long as we keep the door open to later on
> extending the log_buf_max_size to append mode.

Sure.

>
> > On the other hand, with rotating log, we could determine this very
> > easily! We can just maintain max(log->end_pos, last_max_end_pos)
> > throughout the verification process (we need max due to log reset: it
> > still might need bigger buffer than final log length).
>
> Ah, tricky! Nitty gritty detail: can I get the max required size with
> log_level > 0 but log_buf =3D=3D NULL / log_size =3D=3D 0?

See above about ubuf=3D=3DNULL ignoring any log calls, so no. And
currently specifying log_level without specifying log_buf/log_size is
-EINVAL.

>
> > So, to get the full size, we need rotating log behavior.
> >
> > What if we just make rotating log still return -ENOSPC, and set this
> > new "log_buf_max_size" field to actual required full size. That will
> > keep existing retry/resize logic intact and would be backwards
> > compatible, right?
>
> There is a subtlety here: with this design it's impossible to load a
> program with a rotating log and a buffer that is smaller than
> log_buf_max_size. A contrived use case: for each program we load we'd
> like to get the verifier stats printed as one of the last lines.
> Without ENOSPC this can be done by allocating a buffer of 512 bytes or
> something.

You can do this with -ENOSPC as well. log_level =3D 4 will not emit lots
of data or require big buffer, verifier will just print out few lines
of log. So I think this case is covered just fine.

>
> Tying errno to log buffer size is wrong imo, so it'd be nice if we
> could fix the interface going forward.

You are nitpicking a bit here :) What I'd do in practice would be to
set a buffer to 128 bytes (minimum size allowed before my changes)
requested log_level=3D2 and would have guaranteed -ENOSPC. E.g. for
empty program that just returns 0, I get (with log_level 2):

0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
0: (b4) w0 =3D 0                        ; R0_w=3D0
1: (95) exit
verification time 210 usec
stack depth 0
processed 2 insns (limit 1000000) max_states_per_insn 0 total_states 0
peak_states 0 mark_read 0

Which is 210 bytes. So practically speaking there is no issue at all.
But as you mentioned below, passing BPF_LOG_FIXED and expecting
-EINVAL is straightforward as well.

>
> > As for feature detecting this change. Yes, there is no UAPI change
> > (unless we add extra field, of course), but as I implemented it right
> > now it's trivial to detect the change in behavior: set small buffer
> > (few bytes), try load trivial program. If you get -EINVAL, then we
> > have old kernel that enforces >=3D128 bytes for buffer. If you specify =
a
> > bit bigger buffer, you should get -ENOSPC. If you get success, it's
> > the new behavior.
>
> I think a better test would actually be to pass the new BPF_LOG flag
> and check for EINVAL. Relying on buffer sizes is maybe a bit too
> indirect?

Sure, send BPF_LOG_FIXED and expect -EINVAL. Simple and works
reliably. So I guess I'd do that.

>
> > What I'm worried with switching this to opt-in
> > (BPF_LOG_TRUNCATE_HEAD), is that for various application that would
> > want to use log_level 1/2 for some diagnostics in runtime, *they*
> > would need to perform this feature detection just to know that it's
> > safe to provide BPF_LOG_TRUNCATE_HEAD.
>
> Can you sketch this out a bit more, what kind of diagnostics do you
> have in mind? If the application wants to parse the log it kind of
> needs to know anyways? Going back to my "get verifier stats from prog
> load" example above, if the rotating log isn't available I need to
> either
>
> - skip getting verifier stats
> - allocate a possibly large buffer to get at it in append mode
>
> That choice isn't one I can make as a library author.

See above, if you want only verifier stats, log_level=3D4 is the way to
go. It's guaranteed to fit in 512 buffer, so I don't think there is
any issue here.

As for user needing to feature-detect BPF_LOG_FIXED vs rotating log.
Libbpf provides ability to set custom buffer and log_level per program
or per entire BPF object, and libbpf passes this through to kernel. If
user wants rotating log and it's opt-in, then they would need to do
explicit feature detection, because libbpf can't guess user's intent.

Similarly, tools like veristat, they'd need to do their detection.

But we all agree that as a default, tail of the too long verifier log
is desirable default behavior. So I think it's worth fighting for
smooth experience, provided we don't break any reasonable application.

>
> > So I decided that it's better
> > use experience to do opt-out. Just to explain my reasoning, I wanted
> > to make users not care about this and just get useful log back.
>
> Ah, this is probably where our disconnect is. In my mind, detecting
> and passing BPF_LOG_TRUNCATE_HEAD is definitely the responsibility of
> the library, not the users. At least for the happy / common path.
> Rough sketch of how PROG_LOAD and log_buf is handled in Go (probably
> similar to libbpf?)
>
>     if PROG_LOAD(user supplied log_level) < 0 && user supplied log_level =
=3D=3D 0:
>         retry PROG_LOAD(log_level=3D1)
>
> There is some trickery when the user passes a log_level !=3D 0, but most
> PROG_LOAD go through this logic. The way I'd go about it is to add
> TRUNCATE_HEAD to the retry PROG_LOAD call if the feature exists. As a
> result, most failed program loads would get the benefit of this
> feature.

Right, this is not a big deal for libbpf and other loader libraries
for default "retry with log_level=3D1 if program load failed". But I'm
hoping we can get good default behavior for any other application to
get reasonable output when they provide their custom log_level and/or
log buffer.

>
> If a user explicitly requests a log I assume they know what they are
> doing and it's probably best not to mess with it. To play the devil's
> advocate, I think that making this behaviour opt out does break
> expectations that user space has. See [0] for example which will have
> to detect that rotating mode is used and deliberately disable that. We
> can of course argue whether parsing the log is a wise thing to do, but
> it's good to keep that fact in mind.

I'm not familiar with coverbee, which specific part will break due to
rotating vs fixed verifier log, assuming both return -ENOSPC?

CoverBee seems to be parsing verifier log and trying to make sense out
it (I see parsing register state, etc), so that tool definitely
expects that it would have to follow any verifier log format changes
and would have to accommodate them.

>
> > Heh, it actually does automatically as it uses bpf_verifier_log struct
> > as well. So all the BPF_PROG_LOAD changes for log apply to BPF_BTF_LOG
> > command.
>
> Nice :)

Yep.


So, in short, it still seems like -ENOSPC and rotating log behavior
covers all reasonable cases, except some specialized tools that
heavily rely on getting strictly head part of verifier log on -ENOSPC.

I do think providing needed log buffer size is a nice feature and will
add it in the next revision.

Please let me know if I addressed your concerns above (e.g.,
log_level=3D4 for verifier stats, etc)?

>
> Best
> Lorenz
>
> 0: https://github.com/cilium/coverbee
