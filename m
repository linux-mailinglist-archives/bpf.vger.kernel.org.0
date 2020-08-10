Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4E224096F
	for <lists+bpf@lfdr.de>; Mon, 10 Aug 2020 17:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbgHJPbs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Aug 2020 11:31:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36285 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729217AbgHJPbr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Aug 2020 11:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597073505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=49mIs1krmG+iR3HJEEmuWB8gA7Ofz9+tG03UbSFdT1k=;
        b=O5z34UShXZi6XBkHGLfnw+Y+DNpdlEMVCL/6F7dntIIDnQfPYs2JG4N+r981CfOHTZ9P03
        3tVS1VdkQE6kf7U8vD9rsNs6Of3REK/C+tXhs1/Pc7s4GWq8QD7h8sgz3TTBQKMnhbBmc+
        3M7j14P+2O5jfD4udiQO2loCZCP5B4E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-xQxV4eDZMDm-X8KaW1wVaw-1; Mon, 10 Aug 2020 11:31:44 -0400
X-MC-Unique: xQxV4eDZMDm-X8KaW1wVaw-1
Received: by mail-wr1-f69.google.com with SMTP id 89so4359403wrr.15
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2020 08:31:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=49mIs1krmG+iR3HJEEmuWB8gA7Ofz9+tG03UbSFdT1k=;
        b=ZBzSklFVaeDOfvcEgz5SKd5ZceQbu53Zod0R0BZN9HQFRwASzbtrKGQMviASr10m/S
         /kmAqOuzbMaasgS29e8eZcN5RHKxuO0VJ73SF2t/ftOMekAzy6oFXJQa7QdpY9lXOokZ
         +UtnTcO8yu45Zle/gHZiWvigrtbGswPTyc0gI2aBmG+LqO1mzsOGNpKMjkaovpQFME/v
         JSAJwx/j24jExe9Zzr4WR0s6jiKdwiC6oOGpiE0GKrC4tjMtiPgpFEzmplrWQNZe6DHl
         cc+LP+VIx+PTMtjeQYR8AJwhsGBAr4ivn8sB5xMniI/qOOk3TlMbCa6PtQiAgzgJQIFs
         dkjw==
X-Gm-Message-State: AOAM532LOqsPLRTRFjQpyB8EcAutcFeLGhrDSHeWCbblBBhm4kjY7T49
        MhK/v8RTrExvDfT3XkQIh2utpCf0xfmnesumeNXEJSeka3K8GIoyYUHOeW3r8PbK2uy/IMHcklL
        YYax69oy3s7RIzhRJ9ex7su54Vw0l
X-Received: by 2002:adf:a35e:: with SMTP id d30mr26838942wrb.53.1597073503096;
        Mon, 10 Aug 2020 08:31:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+Nji/hLYfwwpTdfhFfArxO6JJU6plpG+a7/WuLrVnK26SdjV5QVgAsPQAIK3pEkG3x6WwcWzVGpXomv6UMxM=
X-Received: by 2002:adf:a35e:: with SMTP id d30mr26838927wrb.53.1597073502922;
 Mon, 10 Aug 2020 08:31:42 -0700 (PDT)
MIME-Version: 1.0
References: <xunyft9i1olx.fsf@redhat.com> <CAEf4BzZGUB5oqmFnV8Xmw+hXGr3fxRno0nkOuG+f5b9vNhbEHQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZGUB5oqmFnV8Xmw+hXGr3fxRno0nkOuG+f5b9vNhbEHQ@mail.gmail.com>
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Date:   Mon, 10 Aug 2020 18:31:26 +0300
Message-ID: <CANoWswm-8oV5vQmcq68ncwCU5QhqRv12v8BMpsMO2rOeox-F8A@mail.gmail.com>
Subject: Re: selftests: bpf: mmap question
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>,
        Jiri Olsa <jolsa@redhat.com>, Jiri Benc <jbenc@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi!

On Tue, Jul 28, 2020 at 8:15 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Jul 23, 2020 at 4:02 AM Yauheni Kaliuta
> <yauheni.kaliuta@redhat.com> wrote:
> >
> > Hi!
> >
> > I have a question about the part of the test:
> >
>
> [...]
>
> >
> > In my configuration the first mapping
> >
> >         /* map all but last page: pages 1-3 mapped */
> >         tmp1 = mmap(NULL, 3 * page_size, PROT_READ, MAP_SHARED,
> >                           data_map_fd, 0);
> >
> >
> > maps the area to the 3 pages right before the TLS page.
> > I find it's pretty ok.
>
> Hm... I never ran into this problem. The point here is to be able to
> re-mmap partial ranges. One way would be to re-write all those
> manipulations to start with a full range map, and then do partial
> un-mmaps/re-mmaps, eventually just re-mmaping everything back. I think
> that would work, right, as long as we never unmmap the last page? Do
> you mind trying to fix the test in such a fashion?

Sorry for the delay. I don't sure, sending the patch.

