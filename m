Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24F54A6996
	for <lists+bpf@lfdr.de>; Wed,  2 Feb 2022 02:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236419AbiBBBYl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 20:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbiBBBYl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Feb 2022 20:24:41 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4315BC061714
        for <bpf@vger.kernel.org>; Tue,  1 Feb 2022 17:24:41 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id d3so15777152ilr.10
        for <bpf@vger.kernel.org>; Tue, 01 Feb 2022 17:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CR7c75KqviMmDH1TpHZzc55/DL6CoE+fa6iiDf5qJQ4=;
        b=igOkQUCj3MqOeRtyWSZZGGtvWKWcpYcdhj9a5bqLRAMkcNjNJ9pMPk9WImmZBATCO1
         Ri/4Xd8AjtGzi32CJ8DY8081kSrDKDueeLZYO0EDK06ssFUyt+D5BUpkZfOCMhqGyFVW
         +S8zdaO0NKl4ziC4cAu10cAtvupXZ2g/6dSseQe5Me6YlpTAXakz7jQoP1JuAUYmVdr4
         XL1bTF27HFRZ1XXLbetcFBERKKxb9BYcqRfvLBjJGV9/Sl1JwY1G/W1HU5Xru7xgZHO/
         wK6AcobnCBC+185cUwkBm9xMmmE5t2a9tSnXe65GX4tS5kynU/o1XfAtAegXuVNXNwcE
         igmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CR7c75KqviMmDH1TpHZzc55/DL6CoE+fa6iiDf5qJQ4=;
        b=4sBaGIy01DBNTM+Sft7x4Jzc49tOIBPZHDxRJmFnv+woVPt6Ep9FqJ+gedHACPw4JG
         xcZxB0u4hlpFG3qOBt8VOHude/+6ejXZHBYf/gGszvIHtkExQkJxDVrJfUr11RSjrGw1
         AmMM9AMtn5C7e6xg2rA1STM6MzLENCJd23RjMSIDF75NgJJa4lVWld6rVF9AZHxwm8bv
         WWDOp107RftnrvQSnZn96Z7V3HCupb8W7RdR/xDCafyn8RBEuixjmZdWvVyNt2tKraN7
         TDUVpJAjFmkW8dwN4DFShiDE69S3FJ+oYwZhZHP+Yezv+ctXUKzgygqKaOMjkhwI2snw
         RASw==
X-Gm-Message-State: AOAM531ggXgF/RDk7oj872mJ1MFbv6ZnbjGzCn+cnXWKybaDNZBEzE6M
        IZxmAv2G+xw/9A2/1x2Py4crUV3YM/+HeQ4DeBE=
X-Google-Smtp-Source: ABdhPJwFmphZkgtDI5MqtKo8vLXHVnIUMaZ2kbZw5S1pxrQRfTaOuqeYrdAX0FpNLZ0bAFqZy/ajHfuR3mOK9yoGU08=
X-Received: by 2002:a05:6e02:1a6c:: with SMTP id w12mr11043467ilv.305.1643765080484;
 Tue, 01 Feb 2022 17:24:40 -0800 (PST)
MIME-Version: 1.0
References: <20220126214809.3868787-1-kuifeng@fb.com> <20220126214809.3868787-5-kuifeng@fb.com>
 <CAEf4BzaLaPfnYTQppVq1ixACLQJcDWYyjMRD42YuQFMUb4rLDA@mail.gmail.com> <CAADnVQKEQFhkcnQLqNWDkmtyBq-35UkPGf0Rcj3BtFXCZQXLQg@mail.gmail.com>
In-Reply-To: <CAADnVQKEQFhkcnQLqNWDkmtyBq-35UkPGf0Rcj3BtFXCZQXLQg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 1 Feb 2022 17:24:29 -0800
Message-ID: <CAEf4BzYNedX0W41GpE4Um7iZYUAtg9-edgGRo4KbMhnvJ_AwCw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/5] bpf: Attach a cookie to a BPF program.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Kui-Feng Lee <kuifeng@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 1, 2022 at 12:17 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jan 31, 2022 at 10:47 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > >  struct bpf_array_aux {
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index 16a7574292a5..3fa27346ab4b 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -1425,6 +1425,7 @@ union bpf_attr {
> > >         struct { /* anonymous struct used by BPF_RAW_TRACEPOINT_OPEN command */
> > >                 __u64 name;
> > >                 __u32 prog_fd;
> > > +               __u64 bpf_cookie;
> > >         } raw_tracepoint;
> > >
> >
> > As an aside, Alexei, should we bite a bullet and allow attaching
> > raw_tp, fentry/fexit, and other tracing prog attachment through the
> > LINK_CREATE command? BPF_RAW_TRACEPOINT_OPEN makes little sense for
> > anything but raw_tp programs.
>
> raw_tp_open is used for raw_tp, tp_btf, lsm, fentry.
> iirc it's creating a normal bpf_link underneath.
> link_create doesn't exist for raw_tp and friends,
> so this is the best place to add a cookie.
> We can add an alias cmd (instead of raw_tp_open)
> to make it a bit cleaner from uapi naming pov.
> We can allow link_create to do the attach in all those cases as well,
> but it's a different discussion.

I was actually proposing exactly the latter: to allow LINK_CREATE to
create all the programs that RAW_TRACEPOINT_OPEN allows. It's already
confusing because bpf_iter programs are created using LINK_CREATE
(realized that when I saw your recent patches). Also extension
programs are attached through LINK_CREATE. So while we can't get rid
of BPF_RAW_TRACEPOINT_OPEN, I hoped we can add lsm and fentry support
as well (I don't mind raw_tp/tp_btf there as well for completeness),
so at least in the future it would be we all just a universal
LINK_CREATE command.

> link_create.perf_event.bpf_cookie isn't the best name.
> That name was a cause of confusion for me.
> I thought it applies to perf_event only,
> but it's for kuprobe too.

Yeah, not great, but given it was "attach to perf_event FD" command,
it seemed like the most accurate name at the time :) I still don't
know what I'd call it today, apart from having separate (and
duplicate) link_create.kprobe.bpf_cookie,
link_create.uprobe.bpf_cookie, etc. At least libbpf is hiding it
behind bpf_program__attach_kprobe and bpf_program__attach_uprobe,
though.


> So plenty of bikeshedding to do if we decide to do
> link_create for raw_tp. Hence, for now, I'd add a cookie to
> raw_tp/tp_btf/lsm/fentry like this patch is doing.

Sure, that's fine, it was a long shot anyway. But I'd like to get back
to this discussion when we are going to multi-attach fentry/fexit :)
