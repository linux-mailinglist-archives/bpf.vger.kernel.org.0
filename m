Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1B7517B233
	for <lists+bpf@lfdr.de>; Fri,  6 Mar 2020 00:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgCEXWT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Mar 2020 18:22:19 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46012 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgCEXWT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Mar 2020 18:22:19 -0500
Received: by mail-wr1-f67.google.com with SMTP id v2so167307wrp.12
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2020 15:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UlJYZnn8gF6EelxRY7x9k7613SCS7XFaITrtE8tR1vQ=;
        b=Q0eAh/OF99KaSC2bJbBgNXpd2QkbUTjmndCby1sHRDc4RDN9PLzt+IU13Y/EcIRT3X
         wECALzFKTcmLuaIiGhTxjNKI+t6/1bm4eI9ziAC1ihdUoFAMxA+YaqzyE3zscFC153kG
         /hOYqdVEr9Qn2KYRL0tkuuHahZW5sWUkMgC34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UlJYZnn8gF6EelxRY7x9k7613SCS7XFaITrtE8tR1vQ=;
        b=Elk0oR4svwsQELDEYLyw5AgbDrFkQ0voVqHijztU2r+raGB8Ive+82oLdWL6X98rmQ
         3GCUJCMPGmusM4jrtWQKnAbLYr0PayMZFzApurksdtlDEqzwjge8GuZbHcU5TT9i+TPq
         B7gFlW2UMJIi4PgOEzHABe26Owiv64gVCBRDjzO0O74GP0iHw/QymDPMi6vziIrdUFiF
         IQU1kTBrBoZLfESR6HZhHi07wk1IYA0uYI8fDY26bNzFGUSeDQGfubS8UCpc+6f16T3z
         TwtLmbXvgC05aqHkalEXwBWxcfREW5zLTn6ueKZ6fhWBrilSKqv3Xr1YURpKHJ6+FEJ3
         auYg==
X-Gm-Message-State: ANhLgQ3ZVM6VPgTAWea8I/44na3k6w4DB5zDMhJa2yuvlDp5FC+exJpp
        9Z/nQ0HcUxEuP+d4O/TBumT7pcsMp0HY96eAsbUKUA==
X-Google-Smtp-Source: ADFU+vtuvKFZ8s0RSzwglFPDiN/FF9/4W9jJ87Uq/hW3kxlvaebx5BVTUTkvJRxM0Q/UeUYHe8Dj5RI0gNK8ohHJwL8=
X-Received: by 2002:adf:ded2:: with SMTP id i18mr271722wrn.173.1583450536966;
 Thu, 05 Mar 2020 15:22:16 -0800 (PST)
MIME-Version: 1.0
References: <20200305220127.29109-1-kpsingh@chromium.org> <92937298-69c1-be6f-3e40-75af1bc72d9e@infradead.org>
 <CAADnVQLjj+eMMLU3H4oNkzwPiSugm1knzd3RfBGb3NcVC785kg@mail.gmail.com>
In-Reply-To: <CAADnVQLjj+eMMLU3H4oNkzwPiSugm1knzd3RfBGb3NcVC785kg@mail.gmail.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Fri, 6 Mar 2020 00:22:06 +0100
Message-ID: <CACYkzJ5apfT5F4RGvnZiCZnfMOqi7n8_sypQgeLhZY7J4RdDjg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix bpf_prog_test_run_tracing for !CONFIG_NET
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 6, 2020 at 12:16 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Mar 5, 2020 at 3:12 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> > On 3/5/20 2:01 PM, KP Singh wrote:
> > > From: KP Singh <kpsingh@google.com>
> > >
> > > test_run.o is not built when CONFIG_NET is not set and
> > > bpf_prog_test_run_tracing being referenced in bpf_trace.o causes the
> > > linker error:
> > >
> > > ld: kernel/trace/bpf_trace.o:(.rodata+0x38): undefined reference to
> > >  `bpf_prog_test_run_tracing'
> > >
> > > Add a __weak function in bpf_trace.c to handle this.
> > >
> > > Fixes: da00d2f117a0 ("bpf: Add test ops for BPF_PROG_TYPE_TRACING")
> > > Signed-off-by: KP Singh <kpsingh@google.com>
> >
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>

Thanks!

Apologies, I should have added the "Reported-by:" tag.

- KP

> > Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
>
> Since it was at the top of the tree I amended the commit
> with your tags.
> Thanks for reporting and testing.
