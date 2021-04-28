Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC5C36D011
	for <lists+bpf@lfdr.de>; Wed, 28 Apr 2021 02:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhD1Awo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Apr 2021 20:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhD1Awo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Apr 2021 20:52:44 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E080CC061574;
        Tue, 27 Apr 2021 17:51:58 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 4so36568527lfp.11;
        Tue, 27 Apr 2021 17:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UBG7XS9thzjZcMvWkPqDMf/eiNI69sVC30py45fCdXE=;
        b=JM1K2BEPc84C9uenaUaHtI3qRtkTe4U0B85lbrMxvrg1MMEIFDxXtLzsjICYtqvYKE
         3ooPpj7sIHGwNfLHWav6hEg0WCbBuvFwHcoa8mlh7aqoXCpZqqy7vnmST95GUpoIg+eq
         PvrSdyjHx0tClpZgo12DU5m/PigWYPEAHIvfAXFQmT4rPBgPo6aGBpC29loG6ka+ViTO
         D/8cq1qJM/hdC78dYWR/KmqnmzBbHngIySIa7jGI5g7OCrkLOHJPnkGpDBE+jZr0Hrur
         WAwIOdEsLYCT2p+pEAGgABfLYo45rVasO8+dmvivw6QQJ3Yw90TWJ2B4jtpucbx8VdUt
         M1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UBG7XS9thzjZcMvWkPqDMf/eiNI69sVC30py45fCdXE=;
        b=CIQRaimee0F80CNixhgfQ+wVum/zmyuYHaN5sheQY9SkAr7DXn0TyOxP2BTnaRwOdA
         7xrTqm/RyijQCssSzCrW1IWEHXFefABTK2oevXDInd86G26KL4PruQC3Sbx3Ne01ntRl
         wxphQ6emw4wu/W3Tyrshc0pgeazXMNKdiAwlytI5OMYXCxOqXorgiWW8d1wFLP/EteAa
         3i7YdBOhyGNk6E7HFQ8htfRZXGJ8s3SnkCrrTVk/GBIjdXcfvkYhtqGxHcXbrtLP46Gb
         HEuVA37IkWfQ5LLxmOcU1NwjQHohTwxltvdoqDhqeX3TshmLEyYx+CcOe00ryPP37BCR
         MdZA==
X-Gm-Message-State: AOAM531bAOsWKJ1hiyTWSmKa98P4cN0Ydv+oA7V+dXQr7UU369bq4mA8
        Q7OR8C57l/tbgKkpP5ECp8LGCOS4kg23sqNSBejHcJ8V
X-Google-Smtp-Source: ABdhPJxXcTmwg2f3Q0Foh7P6DoA1RfUjRqMgNdjwOixjjSncCf4Lq2Td6TCdUTqYFR0ykKs+uPdQYndnoyQ3zFu3ZEM=
X-Received: by 2002:a05:6512:3f93:: with SMTP id x19mr18568740lfa.182.1619571117078;
 Tue, 27 Apr 2021 17:51:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210427174313.860948-1-revest@chromium.org> <20210427174313.860948-3-revest@chromium.org>
 <CAADnVQLQmt0-D_e=boXoK=FLRoXv9xzkCwM24zpbZERrEexLCw@mail.gmail.com> <CABRcYm+eWh5=eM9mgOsCU6-TACi-y5kviCf9Kbqxfzvgq9u5BA@mail.gmail.com>
In-Reply-To: <CABRcYm+eWh5=eM9mgOsCU6-TACi-y5kviCf9Kbqxfzvgq9u5BA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 27 Apr 2021 17:51:45 -0700
Message-ID: <CAADnVQK=K2hcrZ7=d=voQ=gxdmC_oqSWodLpck54UncSSgsLuQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] bpf: Implement formatted output helpers
 with bstr_printf
To:     Florent Revest <revest@chromium.org>
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

On Tue, Apr 27, 2021 at 5:20 PM Florent Revest <revest@chromium.org> wrote:
>
> On Wed, Apr 28, 2021 at 1:46 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Apr 27, 2021 at 10:43 AM Florent Revest <revest@chromium.org> wrote:
> > > +                       if (fmt[i + 1] == 'B') {
> > > +                               if (tmp_buf)  {
> > > +                                       err = snprintf(tmp_buf,
> > > +                                                      (tmp_buf_end - tmp_buf),
> > > +                                                      "%pB",
> > ...
> > > +                       if ((tmp_buf_end - tmp_buf) < sizeof_cur_ip) {
> >
> > I removed a few redundant () like above
>
> Oh, sorry about that.
>
> > and applied.
>
> Nice! :)
>
> > >                 if (fmt[i] == 'l') {
> > > -                       cur_mod = BPF_PRINTF_LONG;
> > > +                       sizeof_cur_arg = sizeof(long);
> > >                         i++;
> > >                 }
> > >                 if (fmt[i] == 'l') {
> > > -                       cur_mod = BPF_PRINTF_LONG_LONG;
> > > +                       sizeof_cur_arg = sizeof(long long);
> > >                         i++;
> > >                 }
> >
> > This bit got me thinking.
> > I understand that this is how bpf_trace_printk behaved
> > and the sprintf continued the tradition, but I think it will
> > surprise bpf users.
> > The bpf progs are always 64-bit. The sizeof(long) == 8
> > inside any bpf program. So printf("%ld") matches that long.
>
> Yes, this also surprised me.
>
> > The clang could even do type checking to make sure the prog
> > is passing the right type into printf() if we add
> > __attribute__ ((format (printf))) to bpf_helper_defs.h
> > But this sprintf() implementation will trim the value to 32-bit
> > to satisfy 'fmt' string on 32-bit archs.
> > So bpf program behavior would be different on 32 and 64-bit archs.
> > I think that would be confusing, since the rest of bpf prog is
> > portable. The progs work the same way on all archs
> > (except endianess, of course).
> > I'm not sure how to fix it though.
> > The sprintf cannot just pass 64-bit unconditionally, since
> > bstr_printf on 32-bit archs will process %ld incorrectly.
> > The verifier could replace %ld with %Ld.
> > The fmt string is a read only string for bpf_snprintf,
> > but for bpf_trace_printk it's not and messing with it at run-time
> > is not good. Copying the fmt string is not great either.
> > Messing with internals of bstr_printf is ugly too.
>
> Indeed, none of these solutions are satisfying.

Maybe Daniel has other ideas?

> > Maybe we just have to live with this quirk ?
>
> If we were starting from scratch, maybe just banning %ld could have
> been an option, but now that bpf_trace_printk has been behaving like
> this for a while, I think it might be best to just keep the behavior
> as it is.
>
> > Just add a doc to uapi/bpf.h to discourage %ld and be done?
>
> More doc is always good. Something like "Note: %ld behaves differently
> depending on the host architecture, it is recommended to avoid it and
> use %d or %lld instead" in the helper description of the three
> helpers? If you don't have the time to do it today, I can send a patch
> tomorrow.

bpf_trace_printk was like this for a long time, so there is no rush.
Pls wait until everything comes back to bpf tree and send a patch against it.
bpf_trace_printk comment in uapi/bpf.h is outdated too. Would be good
to document the latest behavior for them all.
