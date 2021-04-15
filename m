Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8108E3615B1
	for <lists+bpf@lfdr.de>; Fri, 16 Apr 2021 00:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236260AbhDOWs7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Apr 2021 18:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234854AbhDOWs7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Apr 2021 18:48:59 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1C2C061574
        for <bpf@vger.kernel.org>; Thu, 15 Apr 2021 15:48:36 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id v72so7236034ybe.11
        for <bpf@vger.kernel.org>; Thu, 15 Apr 2021 15:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tSiO0jn4nV2VGPM0OzJXClbTqqDhlx99TVF4qefMrwk=;
        b=XCjRoJFGnou/nP7KCKeCqd5SmqxQ4Bo+MjEq8fC1FUwyWIH7dG2clYp9tjo4ZuxcFF
         051rKDvCwGmIF1EJtZVmY/cniLnZ4VW4jO9OzA67KfsPiZHLHpv/oD6idij0sIbMYWs7
         qoV3C9IojT+etEvvZNb6nwB+cQBg1PfbtJqoS9nuhRP0xUzXTej4S0hQTY650mgIPmVj
         jBRy5EqQ1sSE66NYlA4EhjEBpkyGySTuKTU5UOknLXBLrzz0qRHrIVO7e1gCDE8xk2NE
         iIAlPoLcPF/B/ylWlgeMXkAMtrEr3ljE5hkJXp9QX6v1YQpPHXcjziH1ivbUpqMjZ1pB
         aDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tSiO0jn4nV2VGPM0OzJXClbTqqDhlx99TVF4qefMrwk=;
        b=SCzklfElQo+5XwH7sAyWnQL3Io+geUGKAgQ/Msg5uCy1CimQygYjIrsdaenJyXO2cF
         hnymtLm+i8ZCjfQAiZwTQ1NXdC+THPN9sx2mfeudtzKr8w629cSP11FhUrXSTh1jNvBq
         BCjjEdrHfh3aKV1vIB0OcFhFT1IunBKKblPYdk+TmoHU6BTHHaOL5+BxUEdKX+2/DV73
         m0rnNLXsyAAMq4vuYBxPF0IgcltAwEsNYLH4JbnpdbTjGCBZYTBFcN0mIHs3Yi2vd0r0
         zo8nOLepQ81ptdAudp/JqogtU7ruxtu7WYxlAFDEQpfhwd3qC+R6BzrSfPmqpyHgepEW
         ehlg==
X-Gm-Message-State: AOAM531NAZXIJHBtGQyzu0fq75V9bqWTraW01LZw+Ww3xWQGyneXWHnA
        PzLgB13YuXUDUvpPbUWroJwbuOP9tK1Fn/NEcMQ=
X-Google-Smtp-Source: ABdhPJwdM58/dyLXb20cnf4Aof2icvIjFeQuSNCe9xNiDELOQ+mnSv+ADwMP0cqU/Lbxp00F2cuPMtu0G6R2Yiv4YGk=
X-Received: by 2002:a25:c4c5:: with SMTP id u188mr7525679ybf.425.1618526915534;
 Thu, 15 Apr 2021 15:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4Bzap6qS9_HQZTHJsM-X2VZso+N5xMwa3HNG9ycMW4WXtQg@mail.gmail.com>
 <20210322180441.1364511-1-rafaeldtinoco@ubuntu.com> <4BB60234-7970-405C-9447-D19CA6564BC2@ubuntu.com>
 <CAEf4BzaimrGXFrfFVHvV53ta7NwDWsN0YHcDiVJELEnbdjmKdg@mail.gmail.com>
 <045DF0ED-10A2-4D9F-AA01-5CE7E3E95193@ubuntu.com> <CAEf4BzbPdH+pV9NpCW+piROOfCme=erGQOHs8XcA_e=pYcV2=g@mail.gmail.com>
 <4F445042-0ECC-4654-B334-E2364B5B9B8D@ubuntu.com> <CAEf4BzYQcD8vrTkXSgwBVGhRKvSWM6KyNc07QthK+=60+vUf8w@mail.gmail.com>
 <9B5EDB10-0235-451C-BC12-A3123DC0D496@ubuntu.com>
In-Reply-To: <9B5EDB10-0235-451C-BC12-A3123DC0D496@ubuntu.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 15 Apr 2021 15:48:24 -0700
Message-ID: <CAEf4BzY09+RUNmVU4SQ5gDcxH4X_zCqh=rSGYhHwMseHNwZedw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next][RFC] libbpf: introduce legacy kprobe events support
To:     Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 14, 2021 at 10:53 PM Rafael David Tinoco
<rafaeldtinoco@ubuntu.com> wrote:
>
>
> >> Yes, with a small reservation I just found out: function names might
> >> change because of GCC optimisations.. In my case I found out that:
> >>
> >> # cat /proc/kallsyms | grep udp_send_skb
> >> ffffffff8f9e0090 t udp_send_skb.isra.48
> >>
> >> udp_send_skb probe was not always working because the function name
> >> was changed. Then I saw BCC had this issue back in 2018 and is
> >> fixing it now:
> >>
> >> https://github.com/iovisor/bcc/issues/1754
> >> https://github.com/iovisor/bcc/pull/2930
> >>
> >> So I thought I could do the same: check if function name is the same
> >> in /proc/kallsyms or if it has changed and use the changed name if
> >> needed (to add to kprobe_events).
> >>
> >> Will include that logic and remove the =E2=80=98enables=E2=80=99.
> >
> > No, please stop adding arbitrary additions. Function renames, .isra
> > optimizations, etc - that's all concerns of higher level, this API
> > should not try to be smart. It should try to attach to exactly the
> > kprobe specified.
>
> :\ how can this be done in a higher level if it needs to be done
> runtime at the time the event is being enabled ? skel will contain
> hardcoded kprobe names and won=E2=80=99t be able to get runtime optimised
> symbol names, correct ? (unless bpftool gen generates an intermediate
> code to check kallsyms and solve those symbols before calling the lib).

user-space code can specify whichever kernel function name it needs
with direct call to bpf_program__attach_kprobe().
bpf_program__attach_kprobe() should attempt to attach *exactly* to the
function specified, even if it doesn't exist. That's not the place to
make any substitutions, otherwise that API will become an unreliable
mess.

>
> I see BCC has some options for regexing symbol names for the probes=E2=80=
=A6
> obviously in BCC=E2=80=99s case is simpler.

That regexing can be built on top of bpf_program__attach_kprobe(), if
necessary. If user says 'attach to X', API should attach to "X", not
"X.something".

>
> I made it work by checking kallsyms for the exact symbol and,
> if not found, for the variants (only for the legacy kprobe event
> probe, but it would work for the current one, passing discovered
> symbol name for the ioctl attrs. My WIP version (to clarify what I=E2=80=
=99m
> saying):
>
> https://paste.ubuntu.com/p/DpqDsGdVff/
