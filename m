Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B482DD43A
	for <lists+bpf@lfdr.de>; Thu, 17 Dec 2020 16:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbgLQPcA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Dec 2020 10:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgLQPb7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Dec 2020 10:31:59 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709DCC061794
        for <bpf@vger.kernel.org>; Thu, 17 Dec 2020 07:31:19 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id w18so14027441iot.0
        for <bpf@vger.kernel.org>; Thu, 17 Dec 2020 07:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SNLzqNA7Yv8jUaImikGcte3pXfNXnVGyGGbxaqJSnmE=;
        b=NstEXwcBZ58bsIqvPEou/vpNRiwQWHboP9Z0GcBCOZ8Zb8GlpgRMYIix6IgT+k1c7q
         /ZeFfGVxYFWgLX6Ra5z66ckoBCfcJRLVAijaEbs4WtQkm9kvUtr3hYUGj0cl7RMfjhaU
         xdRAHAGvTvaTGOVG0cHMEgHCEmVfY0ft1egwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SNLzqNA7Yv8jUaImikGcte3pXfNXnVGyGGbxaqJSnmE=;
        b=fv6LB5R1UZMZ2zWYvmiH63c5PYk/68KuKk++ZKumjAiUSmBcdA4bMUzaLdW6UwiUzE
         C+PA0nY7gHzFZ0aerrLR05v/2Uuvl02lBFR5ofh1Vo22V4dd/P4/HMaZBPgmvW0+TSAp
         7xeYxFLh3bQHOudta6cEMcDfsDE4gnbAej+T8pCBVxe/+yMXcx7UmNmlfGI3Oj73TO8g
         yguikW3hEjg5TCZQurz6LdO3gxx6XMuuPPgNkweIJjzsKBjp2PjbUhSjnIMNZuo15fVH
         RxRHhUFVa5g2idyOuG4QQAQE+fv3HPTl27OcAYUQJT3omWkbpua0Uyo1bh1C8l7zovEz
         3Tlw==
X-Gm-Message-State: AOAM532sQsEHJHntRrnomdPJLGwlrBCrRB5D6cw2udDSWB1a5BApURnk
        oqgXiW/eVpU8T2Jl6xQ0oEOGu9a2UjTNe9wBCIYj4w==
X-Google-Smtp-Source: ABdhPJwGHY8bZs97SycriCjRPbd9tDIlKsouhD/rI6FdX+ZALVYkmXeiTNH2xpyk3fGPfBBSWYjON8DeZP3ikISG75g=
X-Received: by 2002:a05:6602:387:: with SMTP id f7mr22817510iov.209.1608219078885;
 Thu, 17 Dec 2020 07:31:18 -0800 (PST)
MIME-Version: 1.0
References: <20201126165748.1748417-1-revest@google.com> <50047415-cafe-abab-a6ba-e85bb6a9b651@fb.com>
 <CACYkzJ7T4y7in1AsCvJ2izA3yiAke8vE9SRFRCyTPeqMnDHoyQ@mail.gmail.com>
 <e8b03cbc-c120-43d5-168c-cde5b6a97af8@fb.com> <CAEf4BzYz9Yf9abPBtP+swCuqvvhL0cbbbF1x-3stg9mp=a6+-A@mail.gmail.com>
 <194b5a6e6e30574a035a3e3baa98d7fde7f91f1c.camel@chromium.org>
 <CAADnVQK6GjmL19zQykYbh=THM9ktQUzfnwF_FfhUKimCxDnnkQ@mail.gmail.com>
 <CABRcYm+zjC-WH2gxtfEX5S6mZj-5_ByAzVd5zi3aRmQv-asYqg@mail.gmail.com> <221fb873-80fc-5407-965e-b075c964fa13@fb.com>
In-Reply-To: <221fb873-80fc-5407-965e-b075c964fa13@fb.com>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 17 Dec 2020 16:31:08 +0100
Message-ID: <CABRcYmLL=SUsPS6qWVgTyYJ26r-QtECfeTZXkXSp7iRBDZRbZA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add a bpf_kallsyms_lookup helper
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@google.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 14, 2020 at 7:47 AM Yonghong Song <yhs@fb.com> wrote:
> On 12/11/20 6:40 AM, Florent Revest wrote:
> > On Wed, Dec 2, 2020 at 10:18 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >> I still think that adopting printk/vsnprintf for this instead of
> >> reinventing the wheel
> >> is more flexible and easier to maintain long term.
> >> Almost the same layout can be done with vsnprintf
> >> with exception of \0 char.
> >> More meaningful names, etc.
> >> See Documentation/core-api/printk-formats.rst
> >
> > I agree this would be nice. I finally got a bit of time to experiment
> > with this and I noticed a few things:
> >
> > First of all, because helpers only have 5 arguments, if we use two for
> > the output buffer and its size and two for the format string and its
> > size, we are only left with one argument for a modifier. This is still
> > enough for our usecase (where we'd only use "%ps" for example) but it
> > does not strictly-speaking allow for the same layout that Andrii
> > proposed.
>
> See helper bpf_seq_printf. It packs all arguments for format string and
> puts them into an array. bpf_seq_printf will unpack them as it parsed
> through the format string. So it should be doable to have more than
> "%ps" in format string.

This could be a nice trick, thank you for the suggestion Yonghong :)

My understanding is that this would also require two extra args (one
for the array of arguments and one for the size of this array) so it
would still not fit the 5 arguments limit I described in my previous
email.
eg: this would not be possible:
long bpf_snprintf(const char *out, u32 out_size,
                  const char *fmt, u32 fmt_size,
                 const void *data, u32 data_len)

Would you then suggest that we also put the format string and its
length in the first and second cells of this array and have something
along the line of:
long bpf_snprintf(const char *out, u32 out_size,
                  const void *args, u32 args_len) ?
This seems like a fairly opaque signature to me and harder to verify.
