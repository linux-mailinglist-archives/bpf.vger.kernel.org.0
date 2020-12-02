Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3DD2CC8C4
	for <lists+bpf@lfdr.de>; Wed,  2 Dec 2020 22:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbgLBVTT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Dec 2020 16:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgLBVTS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Dec 2020 16:19:18 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D07C0617A6;
        Wed,  2 Dec 2020 13:18:31 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id 142so40790ljj.10;
        Wed, 02 Dec 2020 13:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EI4CSuTv2wEsS6T91oCvuRtV6x23dQrXCg0M4nsr/m8=;
        b=aUt3HHwV9QQLK8YlaGPTy0WNFeECBgUFVc11N+nROxAz+1pH/WLdNdZR4fLOPzjKM5
         1YbKfkldPD31Cc603AWw3TjTcPydsbu2utFNrsOuAFCdht4fDhq6bs5vKO+iIVINgh7D
         bW552fXzWNMdgpo/mpkluyx/07MDqMXIWogDEn2srImCBWXV1bRHOIqF06EdjrqcedhZ
         aydQuIMlt03Y93gUvBZYY+GpQ2xzlKhlW2QLsWYRAaJqdtHC0/xiMOMxdk/SdxLkEBxY
         9NNslmYeHzu4zwWCQcNIqzhaHdPV1rL9l0CEDmFGFQKqEqol38Cg4BDh++68ykEBWH++
         wAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EI4CSuTv2wEsS6T91oCvuRtV6x23dQrXCg0M4nsr/m8=;
        b=YRA7BC27VE19afuSQTxrt1X/YPM/52Eafmx3/2+T7ffYgIn2C7oCaF03+0R0SJSvpx
         hSeIFLx7aYP543l7dx2lahhTnAPVTnxR50Du9qV+lub+HdcCnk6U4xeJgQ5MMIYFZNr6
         luhkiCRJ0YVPH+A3SNVxU4tzvQFtC/u7ek+Ja8HIV50sxOgj4Zz0xMKbKsEkNSqtcpTq
         geJmrI68GoNhvXOJvIYyo5lu9pIyWc2CKwcREUeBv5SEyabQVR96wzQw+NEv5Z4IEIo9
         kAtIWW0KDORlDVXD5nuPXKH4ygejVBZ+kg0F+sLqTKCoo/ypdTMtjYHJe8AcivTQONaz
         5GJA==
X-Gm-Message-State: AOAM5312ULlWZkq0imnlFyvQn0QPp8Kh8sbDju73z0z0LdzG6BbDioTs
        CJGFxlRhNLaoS3P5CQLTypj8cYrdb3ahbN7PrcU=
X-Google-Smtp-Source: ABdhPJzTu+DvMa8Xrm2mHNlrtdcuTgE3Dhds3rjdEz9CgoY82wKoC6ekQg4WiSknNyAWp6dqX335FRSb25pFibWeFXQ=
X-Received: by 2002:a2e:6c14:: with SMTP id h20mr1997445ljc.450.1606943910156;
 Wed, 02 Dec 2020 13:18:30 -0800 (PST)
MIME-Version: 1.0
References: <20201126165748.1748417-1-revest@google.com> <50047415-cafe-abab-a6ba-e85bb6a9b651@fb.com>
 <CACYkzJ7T4y7in1AsCvJ2izA3yiAke8vE9SRFRCyTPeqMnDHoyQ@mail.gmail.com>
 <e8b03cbc-c120-43d5-168c-cde5b6a97af8@fb.com> <CAEf4BzYz9Yf9abPBtP+swCuqvvhL0cbbbF1x-3stg9mp=a6+-A@mail.gmail.com>
 <194b5a6e6e30574a035a3e3baa98d7fde7f91f1c.camel@chromium.org>
In-Reply-To: <194b5a6e6e30574a035a3e3baa98d7fde7f91f1c.camel@chromium.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 2 Dec 2020 13:18:18 -0800
Message-ID: <CAADnVQK6GjmL19zQykYbh=THM9ktQUzfnwF_FfhUKimCxDnnkQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add a bpf_kallsyms_lookup helper
To:     Florent Revest <revest@chromium.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@chromium.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@google.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 2, 2020 at 12:32 PM Florent Revest <revest@chromium.org> wrote:
>
> On Tue, 2020-12-01 at 16:55 -0800, Andrii Nakryiko wrote:
> > On Fri, Nov 27, 2020 at 8:09 AM Yonghong Song <yhs@fb.com> wrote:
> > >
> > >
> > > On 11/27/20 3:20 AM, KP Singh wrote:
> > > > On Fri, Nov 27, 2020 at 8:35 AM Yonghong Song <yhs@fb.com> wrote:
> > > > >
> > > > > In this case, module name may be truncated and user did not get
> > > > > any indication from return value. In the helper description, it
> > > > > is mentioned that module name currently is most 64 bytes. But
> > > > > from UAPI perspective, it may be still good to return something
> > > > > to let user know the name is truncated.
> > > > >
> > > > > I do not know what is the best way to do this. One suggestion
> > > > > is to break it into two helpers, one for symbol name and
> > > > > another
> > > >
> > > > I think it would be slightly preferable to have one helper
> > > > though. maybe something like bpf_get_symbol_info (better names
> > > > anyone? :)) with flags to get the module name or the symbol name
> > > > depending
> > > > on the flag?
> > >
> > > This works even better. Previously I am thinking if we have two
> > > helpers,
> > > we can add flags for each of them for future extension. But we
> > > can certainly have just one helper with flags to indicate
> > > whether this is for module name or for symbol name or something
> > > else.
> > >
> > > The buffer can be something like
> > >     union bpf_ksymbol_info {
> > >        char   module_name[];
> > >        char   symbol_name[];
> > >        ...
> > >     }
> > > and flags will indicate what information user wants.
> >
> > one more thing that might be useful to resolve to the symbol's "base
> > address". E.g., if we have IP inside the function, this would resolve
> > to the start of the function, sort of "canonical" symbol address.
> > Type of ksym is another "characteristic" which could be returned (as
> > a single char?)
> >
> > I wouldn't define bpf_ksymbol_info, though. Just depending on the
> > flag, specify what kind of memory layou (e.g., for strings -
> > zero-terminated string, for address - 8 byte numbers, etc). That way
> > we can also allow fetching multiple things together, they would just
> > be laid out one after another in memory.
> >
> > E.g.:
> >
> > char buf[256];
> > int err = bpf_ksym_resolve(<addr>, BPF_KSYM_NAME | BPF_KSYM_MODNAME |
> > BPF_KSYM_BASE_ADDR, buf, sizeof(buf));
> >
> > if (err == -E2BIG)
> >   /* need bigger buffer, but all the data up to truncation point is
> > filled in */
> > else
> >   /* err has exact number of bytes used, including zero terminator(s)
> > */
> >   /* data is laid out as
> > "cpufreq_gov_powersave_init\0cpufreq_powersave\0\x12\x23\x45\x56\x12\
> > x23\x45\x56"
> > */
>
> Great idea! I like that, thanks for the suggestion :)

I still think that adopting printk/vsnprintf for this instead of
reinventing the wheel
is more flexible and easier to maintain long term.
Almost the same layout can be done with vsnprintf
with exception of \0 char.
More meaningful names, etc.
See Documentation/core-api/printk-formats.rst
If we force fmt to come from readonly map then bpf_trace_printk()-like
run-time check of fmt string can be moved into load time check
and performance won't suffer.
