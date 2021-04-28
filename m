Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3E236D9DE
	for <lists+bpf@lfdr.de>; Wed, 28 Apr 2021 16:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239641AbhD1Ow7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Apr 2021 10:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239584AbhD1Ow7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Apr 2021 10:52:59 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C7AC061574
        for <bpf@vger.kernel.org>; Wed, 28 Apr 2021 07:52:13 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id f21so26881041ioh.8
        for <bpf@vger.kernel.org>; Wed, 28 Apr 2021 07:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wl8vFQIjo6JFIlbBjxksAQ+tRE1MsO+XMq0c0IigsWE=;
        b=MM/udYhW0KLGS6PAS//T0vIl6yk09P4m++UFIZlz9dO3xasmCnpXPjrv3/fcO08LDy
         HulSCuchGrPYnE3w4ZF8GWojnhR2jekrD//XUIuSo3BZIWsSbYsj/0HczjYAuoTgntxe
         os32CwfSlpN2bVqanLH7oAtVSEotnQsE1nzMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wl8vFQIjo6JFIlbBjxksAQ+tRE1MsO+XMq0c0IigsWE=;
        b=oDU7s+rwy1PLK1jWIk2/2FLhNeF/G6qEdcHc0yXPOHtaecvkfJjvuysiyfO5kCHocw
         htI+Q3vI/rpxHSoPxHo9hF1C76cXZbVFFoexGgXlxMxJR0ke3O1Z47SwHjmKgyPU2MTw
         mhmV1ed5R0nkvPtoCY9xNsFkUuQt8XEbki8T6xUlUE+R6PgNXrY6HrL8kpqTCISnoiKq
         mXUsiLzmp9+DmEqD87qO96WeJzPfFau4Ox7KZUYurW/OjIPbvc97KfqQDjp0GSnMkQuy
         bg8T14Q3VLHMDLJPhCJ5D/Xq6euSOGtmvY3dinI/sM75VS32QJnYObVnyk/2t3zH1Tc7
         jAAg==
X-Gm-Message-State: AOAM533NQWC7WI3pl9b59w6vSrIedGJgIBDTHcccTjdfnxCBjmxEp95R
        F2DHFE5J1uMLF1ftrum2DXTuju9leef0s8jjonBznA==
X-Google-Smtp-Source: ABdhPJxT4SjHctUYdhXojoF+Pq6ZlW2Bx8U9fEoC3p8PufgNTDURTmll7KbFBIVAqt5XOfAUZmM1xYMPN0BqVCkrI7M=
X-Received: by 2002:a05:6638:304:: with SMTP id w4mr27476121jap.32.1619621533025;
 Wed, 28 Apr 2021 07:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210427174313.860948-1-revest@chromium.org> <20210427174313.860948-3-revest@chromium.org>
 <CAADnVQLQmt0-D_e=boXoK=FLRoXv9xzkCwM24zpbZERrEexLCw@mail.gmail.com>
 <CABRcYm+eWh5=eM9mgOsCU6-TACi-y5kviCf9Kbqxfzvgq9u5BA@mail.gmail.com> <CAADnVQK=K2hcrZ7=d=voQ=gxdmC_oqSWodLpck54UncSSgsLuQ@mail.gmail.com>
In-Reply-To: <CAADnVQK=K2hcrZ7=d=voQ=gxdmC_oqSWodLpck54UncSSgsLuQ@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 28 Apr 2021 16:52:02 +0200
Message-ID: <CABRcYmKb0Nft+whG0nv3QkAQszpctdpyXxN=uo2LJdEnzeEZaA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] bpf: Implement formatted output helpers
 with bstr_printf
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 28, 2021 at 2:51 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Apr 27, 2021 at 5:20 PM Florent Revest <revest@chromium.org> wrote:
> >
> > On Wed, Apr 28, 2021 at 1:46 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Apr 27, 2021 at 10:43 AM Florent Revest <revest@chromium.org> wrote:
> > > > +                       if (fmt[i + 1] == 'B') {
> > > > +                               if (tmp_buf)  {
> > > > +                                       err = snprintf(tmp_buf,
> > > > +                                                      (tmp_buf_end - tmp_buf),
> > > > +                                                      "%pB",
> > > ...
> > > > +                       if ((tmp_buf_end - tmp_buf) < sizeof_cur_ip) {
> > >
> > > I removed a few redundant () like above
> >
> > Oh, sorry about that.
> >
> > > and applied.
> >
> > Nice! :)
> >
> > > >                 if (fmt[i] == 'l') {
> > > > -                       cur_mod = BPF_PRINTF_LONG;
> > > > +                       sizeof_cur_arg = sizeof(long);
> > > >                         i++;
> > > >                 }
> > > >                 if (fmt[i] == 'l') {
> > > > -                       cur_mod = BPF_PRINTF_LONG_LONG;
> > > > +                       sizeof_cur_arg = sizeof(long long);
> > > >                         i++;
> > > >                 }
> > >
> > > This bit got me thinking.
> > > I understand that this is how bpf_trace_printk behaved
> > > and the sprintf continued the tradition, but I think it will
> > > surprise bpf users.
> > > The bpf progs are always 64-bit. The sizeof(long) == 8
> > > inside any bpf program. So printf("%ld") matches that long.
> >
> > Yes, this also surprised me.
> >
> > > The clang could even do type checking to make sure the prog
> > > is passing the right type into printf() if we add
> > > __attribute__ ((format (printf))) to bpf_helper_defs.h
> > > But this sprintf() implementation will trim the value to 32-bit
> > > to satisfy 'fmt' string on 32-bit archs.
> > > So bpf program behavior would be different on 32 and 64-bit archs.
> > > I think that would be confusing, since the rest of bpf prog is
> > > portable. The progs work the same way on all archs
> > > (except endianess, of course).
> > > I'm not sure how to fix it though.
> > > The sprintf cannot just pass 64-bit unconditionally, since
> > > bstr_printf on 32-bit archs will process %ld incorrectly.
> > > The verifier could replace %ld with %Ld.
> > > The fmt string is a read only string for bpf_snprintf,
> > > but for bpf_trace_printk it's not and messing with it at run-time
> > > is not good. Copying the fmt string is not great either.
> > > Messing with internals of bstr_printf is ugly too.
> >
> > Indeed, none of these solutions are satisfying.
>
> Maybe Daniel has other ideas?
>
> > > Maybe we just have to live with this quirk ?
> >
> > If we were starting from scratch, maybe just banning %ld could have
> > been an option, but now that bpf_trace_printk has been behaving like
> > this for a while, I think it might be best to just keep the behavior
> > as it is.
> >
> > > Just add a doc to uapi/bpf.h to discourage %ld and be done?
> >
> > More doc is always good. Something like "Note: %ld behaves differently
> > depending on the host architecture, it is recommended to avoid it and
> > use %d or %lld instead" in the helper description of the three
> > helpers? If you don't have the time to do it today, I can send a patch
> > tomorrow.
>
> bpf_trace_printk was like this for a long time, so there is no rush.
> Pls wait until everything comes back to bpf tree and send a patch against it.
> bpf_trace_printk comment in uapi/bpf.h is outdated too. Would be good
> to document the latest behavior for them all.

Ok :)
