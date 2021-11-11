Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2EB144DCDC
	for <lists+bpf@lfdr.de>; Thu, 11 Nov 2021 22:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbhKKVKp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Nov 2021 16:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhKKVKp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Nov 2021 16:10:45 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3290C061766
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 13:07:55 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id b17so14729810uas.0
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 13:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mVJTBUug7dGTDdi6d+Vb8XnUz0vv5GEP+4puyQk5prE=;
        b=m7z+AfXIUYB6YCH8M96Rt6l73fn1T/Wl+yr78qk0svl8KJkmnN6gh1Q21VqskGMyIx
         XsAcPLIiCoXsVqSMQTYOhLe6YyuMteoMwzjGEpOLRw6wFZ3j+HHJ6MdR77w2X0wHAU0C
         Y6D5LRrpN4w7FA2MHIPqMlmC4dqYUTFVbcsVKCckPeQsl+dxg1lHgmMinQvJ0p8MVfbs
         HSPiAgXogK1Dj1YYb3w8BraseaRNibgDxoq3zlPjYPTsZC0VJxwAJiItoMiCQ49zlw6B
         BMQUu1/NQehiFi6FdADp1HEDlS3s4kqknxzE9HGm9QdXzhNUa2w0tkwnmRowonNMkCRl
         Gybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mVJTBUug7dGTDdi6d+Vb8XnUz0vv5GEP+4puyQk5prE=;
        b=p3I/ueQBw1o/Tiu90PvZIlPzEU2dPsf2aETy8/oQj8bUWg1EOzDD9X65tdsH/HxGET
         4lyGqIonOncmDzHKEByyIDn2dUTHOt8+lMEFHRlhtey2hYvkfJdmNotBCYadbUMARKm1
         4WFgMYgKCaSDNcUWhqgaNvVFlnLPaTrLSTlldSCGnl2FpFB2R53cUTDfe9v78x90Mp6t
         Egp4LgLILIlSo1AB/1gq2qA4fg+mDAMTQPlVeCHSMCEpzhPY0iBaCxOOh2D7/HjN6EWy
         qdKk6rzDtGHXoLhDhbEqugdyP3Hok/X+ka8ruUoj89B7H9j0zdnL8NE9UmXdhb2pFeOI
         PFgQ==
X-Gm-Message-State: AOAM532Tsxy1PK090n51TdlvCA+S6cqMac4R/GCv9XAp9usVV/HzuQQe
        x4V3F2cWKbJs94RYDH/MF/Q8UD6xIGOkQPTjf2oHGw==
X-Google-Smtp-Source: ABdhPJyoXb2JVRi0dn+P8NlgxQOyTPHU6eplzwbikd4e6kXBg41P/DM28MJgum8KxcUnEhCEM3CAmqiNPb9afaf5ctg=
X-Received: by 2002:ab0:70cd:: with SMTP id r13mr14267691ual.99.1636664874724;
 Thu, 11 Nov 2021 13:07:54 -0800 (PST)
MIME-Version: 1.0
References: <20211110192324.920934-1-sdf@google.com> <CAEf4BzYbvKjOmvgWvNWSK6ra0X5mM_=igi8DVwdojtZodz5pbQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYbvKjOmvgWvNWSK6ra0X5mM_=igi8DVwdojtZodz5pbQ@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Thu, 11 Nov 2021 21:07:43 +0000
Message-ID: <CACdoK4JzQ2_v+TtLY=61rkv4VPYHBQRgjW-ikMi6KSiBjK7CBg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpftool: enable libbpf's strict mode by default
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 11 Nov 2021 at 18:19, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Nov 10, 2021 at 11:23 AM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > Otherwise, attaching with bpftool doesn't work with strict section names.
> >
> > Also:
> >
> > - add --legacy option to switch back to pre-1.0 behavior
> > - print a warning when program fails to load in strict mode to point
> >   to --legacy flag
> > - by default, don't append / to the section name; in strict
> >   mode it's relevant only for a small subset of prog types
> >
>
> LGTM. I'll wait for Quenting's ack before applying. Thanks!

Looks good as well, thanks Stanislav!

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

I wonder if we should display some indication ("libbpf_strict"?) in
the output of "bpftool version", alongside "libbfd" and "skeleton"?
It's not strictly a feature (and would always be present for newer
versions), but it could help to check how a bpftool binary will
behave? (I don't mind taking it as a follow-up.)

Quentin
