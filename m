Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E094136CFF5
	for <lists+bpf@lfdr.de>; Wed, 28 Apr 2021 02:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhD1AVe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Apr 2021 20:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhD1AVe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Apr 2021 20:21:34 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7C3C061574
        for <bpf@vger.kernel.org>; Tue, 27 Apr 2021 17:20:50 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id r5so10758085ilb.2
        for <bpf@vger.kernel.org>; Tue, 27 Apr 2021 17:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LOTlmCK5gq+HHlhNi1fYC1cWCks9ISwEvyUnhRhzW1M=;
        b=MwrGNYRa/2Aplsse0gRT5HfxFK9oxD+6LmaoDXtj7QymXeN0tDgm3bmLUM7UVujror
         nXgZ2spJYrVcQeVgR97GbiOnihpaJ4Vc4qcPAqFLPiNYhTOSWHFAzQunQ74m2MtJaYDf
         8WTvz6zwy5QVkzzAupCjESLAEeQV0C9F/B//0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LOTlmCK5gq+HHlhNi1fYC1cWCks9ISwEvyUnhRhzW1M=;
        b=JqhcksIwSMD2EhZhLHAswgQpGopG3AiuhfDOaVF23ZUBhQwYpJikFCfH5O6f0mKRTP
         TtMqnBAyBU90PO4y7fiAIeqqVlHaXF3sdAFnOAxM69R/A7lqdFcZ4RqgWiTebhlm9fbb
         rJuinGPqYfGqbMYL+CaqYqPlPgn8mV8RkigVtGnO3qg8E3TQRU5e6icBQTB4EPlyZUlP
         vb9T0rf2SDz/6xVhY4ovBn78tDrCnVX19BptbZtp3N8ggsAFOmJNK4BVJ8CnB1umobgZ
         WxWSCqTLvaUsaaLbKCiUu8IQq/sdNGJa0UBcMpIHodw/Fxjw+CWGtA0KsitU0vILSyG6
         J2wA==
X-Gm-Message-State: AOAM530qBeLEw/Q8nIJ32KYCFkv3PlWOq3wUoY60St1T5iDFw+23WXqQ
        /3GyXTmor51qYya21DL4/k0m4tsOXp2+JL2QVKnMHg==
X-Google-Smtp-Source: ABdhPJzFFwlQ1tOFzeZg8AXbIu6mkRYWUxE8LdfB/Evf09W94HPKywtf7ijgiTpfcK4loo+UjRZ8xz/+ksgnm176+1Y=
X-Received: by 2002:a05:6e02:219d:: with SMTP id j29mr21619919ila.204.1619569249796;
 Tue, 27 Apr 2021 17:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210427174313.860948-1-revest@chromium.org> <20210427174313.860948-3-revest@chromium.org>
 <CAADnVQLQmt0-D_e=boXoK=FLRoXv9xzkCwM24zpbZERrEexLCw@mail.gmail.com>
In-Reply-To: <CAADnVQLQmt0-D_e=boXoK=FLRoXv9xzkCwM24zpbZERrEexLCw@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 28 Apr 2021 02:20:39 +0200
Message-ID: <CABRcYm+eWh5=eM9mgOsCU6-TACi-y5kviCf9Kbqxfzvgq9u5BA@mail.gmail.com>
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

On Wed, Apr 28, 2021 at 1:46 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Apr 27, 2021 at 10:43 AM Florent Revest <revest@chromium.org> wrote:
> > +                       if (fmt[i + 1] == 'B') {
> > +                               if (tmp_buf)  {
> > +                                       err = snprintf(tmp_buf,
> > +                                                      (tmp_buf_end - tmp_buf),
> > +                                                      "%pB",
> ...
> > +                       if ((tmp_buf_end - tmp_buf) < sizeof_cur_ip) {
>
> I removed a few redundant () like above

Oh, sorry about that.

> and applied.

Nice! :)

> >                 if (fmt[i] == 'l') {
> > -                       cur_mod = BPF_PRINTF_LONG;
> > +                       sizeof_cur_arg = sizeof(long);
> >                         i++;
> >                 }
> >                 if (fmt[i] == 'l') {
> > -                       cur_mod = BPF_PRINTF_LONG_LONG;
> > +                       sizeof_cur_arg = sizeof(long long);
> >                         i++;
> >                 }
>
> This bit got me thinking.
> I understand that this is how bpf_trace_printk behaved
> and the sprintf continued the tradition, but I think it will
> surprise bpf users.
> The bpf progs are always 64-bit. The sizeof(long) == 8
> inside any bpf program. So printf("%ld") matches that long.

Yes, this also surprised me.

> The clang could even do type checking to make sure the prog
> is passing the right type into printf() if we add
> __attribute__ ((format (printf))) to bpf_helper_defs.h
> But this sprintf() implementation will trim the value to 32-bit
> to satisfy 'fmt' string on 32-bit archs.
> So bpf program behavior would be different on 32 and 64-bit archs.
> I think that would be confusing, since the rest of bpf prog is
> portable. The progs work the same way on all archs
> (except endianess, of course).
> I'm not sure how to fix it though.
> The sprintf cannot just pass 64-bit unconditionally, since
> bstr_printf on 32-bit archs will process %ld incorrectly.
> The verifier could replace %ld with %Ld.
> The fmt string is a read only string for bpf_snprintf,
> but for bpf_trace_printk it's not and messing with it at run-time
> is not good. Copying the fmt string is not great either.
> Messing with internals of bstr_printf is ugly too.

Indeed, none of these solutions are satisfying.

> Maybe we just have to live with this quirk ?

If we were starting from scratch, maybe just banning %ld could have
been an option, but now that bpf_trace_printk has been behaving like
this for a while, I think it might be best to just keep the behavior
as it is.

> Just add a doc to uapi/bpf.h to discourage %ld and be done?

More doc is always good. Something like "Note: %ld behaves differently
depending on the host architecture, it is recommended to avoid it and
use %d or %lld instead" in the helper description of the three
helpers? If you don't have the time to do it today, I can send a patch
tomorrow.
