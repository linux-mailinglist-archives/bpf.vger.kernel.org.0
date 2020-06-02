Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B36B1EB7DF
	for <lists+bpf@lfdr.de>; Tue,  2 Jun 2020 11:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbgFBJGq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Jun 2020 05:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbgFBJGp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Jun 2020 05:06:45 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C961C061A0E
        for <bpf@vger.kernel.org>; Tue,  2 Jun 2020 02:06:44 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x14so2587539wrp.2
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2020 02:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8v86iOfFTv5BgAxyuvboR4oLRtDNPVTIFHSDTXVpBds=;
        b=M8uuyvAjamNhrQwwq0xYkQclgXmwzuX291UmA2eh4YYt+i6td+xKOzAxr0g38rgSym
         kGLTujiAzXWc3s6IPpbHo8VP8mIkzajR2qEnrc8HK7oQ/gvHcpVN2VXpVrTPMvJ4m7hF
         N54TmJSOkDH+pf8ZJogd+pu+4UDVgU1aLG4Yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8v86iOfFTv5BgAxyuvboR4oLRtDNPVTIFHSDTXVpBds=;
        b=EqIwTqacuBhkCyufplcy3DPp0FAnpTHswlnmpc1HASzQIRlIu3a/m7fys0l0coPHB8
         GTTebBmpHAKQB0XNlUeui+hG3pyg2k9fSUw4wn8yKIvKlysH3JXSoxkXWdNItVxRAjNI
         NSV2GZpx29sA/RfBUbs3nwNsiuoVDF2ujem8X2hjtmMLSfyzBSjxl81nt7UWF9HasX0c
         05USl/GjlJP2Nj2TEyXSYWbqCRT73i5t+vjqk+TXwqJIsqp93pzO62YmikM4px+cCIGl
         PNguaQ4d7QsfsfjpatYe05gVOtSBEO3L1ER6yy4Go6U30sZUjbB7PeBANGMV144muM3P
         7VHQ==
X-Gm-Message-State: AOAM53386NepLR4UCjuvVavOHpjruq5UJZb0xTOfCWlYIKrbZwnszozS
        DkK3zbBXqafHGsYqAu5ckuvqEo+/gDDYByUEDhYb9A==
X-Google-Smtp-Source: ABdhPJx6Y9xwmLNgoYiiWind01Az3F7mso6mNpKG2xSrW6WTJ19a8Nsjx96OMPLN9lu0VVk+nD+pZPRubtOi3kJyi7U=
X-Received: by 2002:adf:f30d:: with SMTP id i13mr23946962wro.146.1591088803135;
 Tue, 02 Jun 2020 02:06:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200531154255.896551-1-jolsa@kernel.org> <CAPhsuW7HevOVgEe-g3RH_OmRqzWedXzGkuoNNzJfSwKhtzGxFw@mail.gmail.com>
 <CAADnVQJquAF=XOjbyj-xmKupyCa=5O76QXWf6Pjq+j+dTvaEpg@mail.gmail.com> <20200602081339.GA1112120@krava>
In-Reply-To: <20200602081339.GA1112120@krava>
From:   KP Singh <kpsingh@chromium.org>
Date:   Tue, 2 Jun 2020 11:06:32 +0200
Message-ID: <CACYkzJ4POnqQk1zGToh5Ct8m5CHtpWyxiwjPWv5-x+gHPS5XiA@mail.gmail.com>
Subject: Re: [PATCH] bpf: Use tracing helpers for lsm programs
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@google.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>, Martin KaFai Lau <kafai@fb.com>,
        Jakub Kicinski <kuba@kernel.org>,
        David Miller <davem@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 2, 2020 at 10:13 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Mon, Jun 01, 2020 at 03:12:13PM -0700, Alexei Starovoitov wrote:
> > On Mon, Jun 1, 2020 at 12:00 PM Song Liu <song@kernel.org> wrote:
> > >
> > > On Sun, May 31, 2020 at 8:45 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > >
> > > > Currenty lsm uses bpf_tracing_func_proto helpers which do
> > > > not include stack trace or perf event output. It's useful
> > > > to have those for bpftrace lsm support [1].
> > > >
> > > > Using tracing_prog_func_proto helpers for lsm programs.
> > >
> > > How about using raw_tp_prog_func_proto?
> >
> > why?
> > I think skb/xdp_output is useful for lsm progs too.
> > So I've applied the patch.
>
> right, it's also where d_path will be as well
>
> >
> > > PS: Please tag the patch with subject prefix "PATCH bpf" for
> > > "PATCH bpf-next". I think this one belongs to bpf-next, which means
> > > we should wait after the merge window.
>
> I must have missed info about that,
> thanks for info

Thanks for adding this! LGTM as well.

- KP

>
> >
> > +1.
> > Jiri,
> > pls tag the subject properly.
>
> will do, sry
>
> thanks,
> jirka
>
