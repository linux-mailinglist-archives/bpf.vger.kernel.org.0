Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BB72B1340
	for <lists+bpf@lfdr.de>; Fri, 13 Nov 2020 01:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgKMAay (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Nov 2020 19:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgKMAay (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Nov 2020 19:30:54 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330ABC0613D1;
        Thu, 12 Nov 2020 16:30:54 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id 10so7103526ybx.9;
        Thu, 12 Nov 2020 16:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fuEYzdlLXwaY8ZetRyzFSP/5EN+gEqSQFl5ccS3Ot6w=;
        b=Zx4VarjuAVk1QiiT2ixgEqdgQASRi8ZbWl5g/0lDgW1+vuvO7Z2YWt7FtL3MMjh4Ad
         usJI2grYkrMJoTmthuDL4V6R7yXmaVL9IfPbhQaXBkkmYZUjLDoBj0y+qF4M467722eL
         TDPLFP+Ptv8Q4DfH5fLWtGdxyxR9cu3ZGMjOE9uzxf2V8G5f62MQYgZAnO4qeFkCZQXM
         fShefqfcrd7lhSgaADtUjb/JowZ4Z/VIcbHh3VoE6spUjD+DOhLCIdoZW6x598FMSXBE
         PEtBOJbjt623DHeO7kvSecBpk2ouUdXx1NKHiFN73WjMye6LeMYXeZeM4AYDxAFNQhfO
         UZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fuEYzdlLXwaY8ZetRyzFSP/5EN+gEqSQFl5ccS3Ot6w=;
        b=TRCmkQuEl+aevuIofn0sGvVpZ2sI1XzlaI7tz3hbs18HAE8Ux6JWBInfmoP70GHL31
         kD00cml09UTTqfa/G6r6hb0DAsOiNAdhnLaPfSYIsLk9i5EgaY0JjwFHv1aSFZS8TldY
         8RpTWByyo9/bu6sRpvEJ8Jn2mroKpzkz9eLkWdbnlj3CxxYr2sUM2vbJIF7U8JL6R0My
         ZUJicLpfNTBuATaY6TaKrNiTfTe/O/OoBaDQHomiwUNtXIgRIAB4vW40W1HU9jyOmMam
         kEi2GUBCmsYLUzk0znrRzSKnkeHhLQS+Y0mCEqbafB3wN7zFmuFEVOYxKnYuGZVfryoN
         bJ2w==
X-Gm-Message-State: AOAM5320TPE2gcmhXDgG9CcUH0P/FSC7E9JhttAKk9HAMoENo6X+sC4i
        xYlt1FgGdgeBaDlFvXIftFAhiMawBwiBZi2G/1Y=
X-Google-Smtp-Source: ABdhPJyPKEZK5IApihWoOlVl3wUuT1x/a/eJ2eK3QxlJfJ8DfyRj1iiCOw3menx7LGc9xrqGnbr80CcpQrncfv7G5QE=
X-Received: by 2002:a25:3d7:: with SMTP id 206mr3444781ybd.27.1605227452989;
 Thu, 12 Nov 2020 16:30:52 -0800 (PST)
MIME-Version: 1.0
References: <20201112150506.705430-1-jolsa@kernel.org> <20201112150506.705430-4-jolsa@kernel.org>
 <CAEf4BzbhojeSdASwt4y4XEtgAF1caYx=-AuwzWJZv7qKgzkroA@mail.gmail.com>
 <20201112211413.GA733055@krava> <CAEf4BzbePw8gksT0MH=hwp4Pv1EV1-MOeiwfoFVR64XWFccTHw@mail.gmail.com>
 <CAADnVQKUYFE0vE3XZB0FPNMxw_+BNpOLJ37QJ+CxLbssDPHFdw@mail.gmail.com>
In-Reply-To: <CAADnVQKUYFE0vE3XZB0FPNMxw_+BNpOLJ37QJ+CxLbssDPHFdw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 12 Nov 2020 16:30:42 -0800
Message-ID: <CAEf4BzZhRPVf=qVU7vVrtVaJzvBmsWL3hHYySKczMrrO-1Xotw@mail.gmail.com>
Subject: Re: [RFC/PATCH 3/3] btf_encoder: Func generation fix
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 12, 2020 at 4:19 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Nov 12, 2020 at 4:08 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > So I looked at your vmlinux image. I think we should just keep
> > everything mostly as it it right now (without changes in this patch),
> > but add just two simple checks:
> >
> > 1. Skip if fn->declaration (ignore correctly marked func declarations)
> > 2. Skip if DW_AT_inline: 1 (ignore inlined functions).
> >
> > I'd keep the named arguments check as is, I think it's helpful. 1)
> > will skip stuff that's explicitly marked as declaration. 2) inline
> > check will partially mitigate dropping of fn->external check (and we
> > can't really attach to inlined functions).
>
> I thought DW_AT_inline is an indication that the function was marked "inline"
> in C code. That doesn't mean that the function was actually inlined.
> So I don't think pahole should check that bit.

According to DWARF spec, there are 4 possible values:

DW_INL_not_inlined = 0            Not declared inline nor inlined by
the compiler
DW_INL_inlined = 1                Not declared inline but inlined by
the compiler
DW_INL_declared_not_inlined = 2   Declared inline but not inlined by
the compiler
DW_INL_declared_inlined = 3       Declared inline and inlined by the compiler

So DW_INL_inlined is supposed to be added to functions that are not
marked inline, but were nevertheless inlined. I saw this for one of
vfs_getattr entries in DWARF, which clearly is not marked inline.

But also that DWARF entry had proper args with names, so it would work
fine as well. I don't know, with DWARF it's always some guessing game.
Let's leave DW_AT_inline alone for now.

Important part is skipping declarations (when they are marked as
such), though I'm not claiming it will solve the problem completely...
:)
