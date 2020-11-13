Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714722B13B7
	for <lists+bpf@lfdr.de>; Fri, 13 Nov 2020 02:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgKMBNE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Nov 2020 20:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgKMBNE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Nov 2020 20:13:04 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFE6C0613D1;
        Thu, 12 Nov 2020 17:13:04 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id c129so7201483yba.8;
        Thu, 12 Nov 2020 17:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ti2wDmEiazIuydvYlpnT6iwtcMlYabN02+GjWqOHtYo=;
        b=EN9H2nNORKf48jcIGzWF0t6m8XhCXPeWSheZuQfX/+Dz0Q5j7IgEYLBl64qGFctInL
         NECriVabtb4GTReg3PLT7VuoPqNtDixXFe3evtJalIBt7I/ZK03Y3YYRFYkImjncDwta
         MqahzIkX759TVKKOnpPPXzoSOhG4yy2Tqg8fuNS4n4aBNG0Q8xCgedcnzaeM29/YvyCt
         Q1X2ROAFNHkhAq3gB6Dz9LTDzR/Zs5Ev4TiF301rk+xNLhn0BDKTCaWZw6CBXj3+2ibK
         /tbIGROjFGVc0OxkfYZPPVIH1us4f1qBJUN/KkfSsccl3yZZ9Xvh+6WhpeOrpP6QBFQz
         2OAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ti2wDmEiazIuydvYlpnT6iwtcMlYabN02+GjWqOHtYo=;
        b=nhlTnaJFtv40wGfmKy9KXKFkFzROY507VydVSGNu9BMP6BXS4JpjA5Kr6vcGRUU0jR
         c2pc9h4KGg/Mv1W8I4rPe/zcW+l1CLyNITV4F1szeEblHaW+ybO0Rdytu5SRaDB8fXo1
         KKGv3zx5FlT/wAip/tY0YGaImVCg+87DFkYKXOwK2KVlv9Ag7gkNvEiGQZ1OHW+9I4Pj
         NuRr9mt1G2kKoGAx2czi7/eo9+aau2aq/fQ5UXY/ZtaHCMvki3mcY960jzbCpJTjWvKU
         i7Lll+NBDXSVED8SlVA7PrwpkTVT2+RKBXEmx7xU2m2l8yKERJBAYqxLUb/xsPDDj71T
         cr1A==
X-Gm-Message-State: AOAM533AiPZLyqIeCYcDuY3W6aFXCk+DM7cJgF9rv4nXmKPeXDWzmSh1
        1QuC+/Gym1TxAV6JVJaB38d6ibUYogQdlmFsJ+Q=
X-Google-Smtp-Source: ABdhPJzCsN2WTH9vA6jMTVocyLJJVd8gqdMNT0tEwH+x6eCFGQc5vHECZvGTF0nuzHlm0kToZhVeixCL0wI5x4iaURM=
X-Received: by 2002:a25:3d7:: with SMTP id 206mr3642175ybd.27.1605229983451;
 Thu, 12 Nov 2020 17:13:03 -0800 (PST)
MIME-Version: 1.0
References: <20201112150506.705430-1-jolsa@kernel.org> <20201112150506.705430-4-jolsa@kernel.org>
 <CAEf4BzbhojeSdASwt4y4XEtgAF1caYx=-AuwzWJZv7qKgzkroA@mail.gmail.com>
 <20201112211413.GA733055@krava> <CAEf4BzbePw8gksT0MH=hwp4Pv1EV1-MOeiwfoFVR64XWFccTHw@mail.gmail.com>
 <CAADnVQKUYFE0vE3XZB0FPNMxw_+BNpOLJ37QJ+CxLbssDPHFdw@mail.gmail.com>
 <CAEf4BzZhRPVf=qVU7vVrtVaJzvBmsWL3hHYySKczMrrO-1Xotw@mail.gmail.com> <7834ab75-6e08-9f95-4885-d65298011ad8@fb.com>
In-Reply-To: <7834ab75-6e08-9f95-4885-d65298011ad8@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 12 Nov 2020 17:12:52 -0800
Message-ID: <CAEf4BzbZ-4=gh4MAREE=W9=s3-38GL1S7EU8vbMuR6-8kZD26w@mail.gmail.com>
Subject: Re: [RFC/PATCH 3/3] btf_encoder: Func generation fix
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 12, 2020 at 5:01 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 11/12/20 4:30 PM, Andrii Nakryiko wrote:
> > On Thu, Nov 12, 2020 at 4:19 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >>
> >> On Thu, Nov 12, 2020 at 4:08 PM Andrii Nakryiko
> >> <andrii.nakryiko@gmail.com> wrote:
> >>>
> >>> So I looked at your vmlinux image. I think we should just keep
> >>> everything mostly as it it right now (without changes in this patch),
> >>> but add just two simple checks:
> >>>
> >>> 1. Skip if fn->declaration (ignore correctly marked func declarations)
> >>> 2. Skip if DW_AT_inline: 1 (ignore inlined functions).
> >>>
> >>> I'd keep the named arguments check as is, I think it's helpful. 1)
> >>> will skip stuff that's explicitly marked as declaration. 2) inline
> >>> check will partially mitigate dropping of fn->external check (and we
> >>> can't really attach to inlined functions).
> >>
> >> I thought DW_AT_inline is an indication that the function was marked "inline"
> >> in C code. That doesn't mean that the function was actually inlined.
> >> So I don't think pahole should check that bit.
> >
> > According to DWARF spec, there are 4 possible values:
> >
> > DW_INL_not_inlined = 0            Not declared inline nor inlined by
> > the compiler
> > DW_INL_inlined = 1                Not declared inline but inlined by
> > the compiler
> > DW_INL_declared_not_inlined = 2   Declared inline but not inlined by
> > the compiler
> > DW_INL_declared_inlined = 3       Declared inline and inlined by the compiler
> >
> > So DW_INL_inlined is supposed to be added to functions that are not
> > marked inline, but were nevertheless inlined. I saw this for one of
> > vfs_getattr entries in DWARF, which clearly is not marked inline.
>
> I looked at llvm source code, llvm only tries to assign DW_INL_inlined
> and also only at certain conditions. Not sure about gcc. Probably
> similar. So this field is not reliable, esp. without it does not mean it
> is not inlined.

Can't say I'm surprised...

>
> >
> > But also that DWARF entry had proper args with names, so it would work
> > fine as well. I don't know, with DWARF it's always some guessing game.
> > Let's leave DW_AT_inline alone for now.
> >
> > Important part is skipping declarations (when they are marked as
> > such), though I'm not claiming it will solve the problem completely...
> > :)
> >
