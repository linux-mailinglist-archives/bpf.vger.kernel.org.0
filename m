Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B53F277A08
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 22:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgIXUOW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 16:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgIXUOW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 16:14:22 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C517C0613CE
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 13:14:22 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id h9so360838ybm.4
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 13:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gKbjaIqU/CYMB8rCN/PbG4Cd+ubxegiADnbogjJ3AFM=;
        b=b/c4uALnhPcwwZVvPD61khZI7mYXCx1+Z19qRUGED5F3sKGsj7Q11Pd86VNT9ugtQl
         pkSzNwtH3r8jkWHB2Ftbb6OYn7Z780srTowYQ+9eCd9E6RJUtbpztCKVcQv57nbMIsBN
         u5UnUK/RIfmesVCdIfko0D1UsfTjE0I82d9iZDFfTmpOv53D90CuxPtr/hj5Ne4Q+fTd
         sx7HizrkSiOqJMcC2NRVT4afFNx7uNq1ju89rxKoiBIjoVekfhuIdFyQ8ybIwehMXCu7
         k6lulV11FePfYdNqe2pzO+9Z2eub+3ESO566tp/iL9VZb4aLwrY1WRO20ngrq7ktwTn4
         FCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gKbjaIqU/CYMB8rCN/PbG4Cd+ubxegiADnbogjJ3AFM=;
        b=p+oeMSIKlSyB1fo0fMrOo2Tm1LdQGry4/ZMtAXX9nJRxqd+n+8t4ipJAkQUZPEIm10
         IElovC4Tet3Zp3zjnHqt2n2rI45eG2C2mGCTLIjNsI6eF/Zkqeanweycor4JGiQROcde
         1oxRKt81oAIZvlhf0erBHUQ/fnWrUnHS3r42pm+qRBTwxAQXNqjIbJERHx54/Ab8KvAp
         0UD15ybUrVEIEjFAe80C9mwlkTH8f//MRlGdWXJTCUc7U9xEJ/0xDeyLnmbM2MVJA8eX
         sSWUYmpEskkvb5G5y8SfijTKWkDlE82dgyekv+bU06FV9SDu2kYMTesoyodkAOXZpv5Y
         BFaw==
X-Gm-Message-State: AOAM530MkH9KpTcvEm8wHRWAOTFLKXA5MMX0zFXUq1NeuencJuSKwUFq
        66jiLTNEFT0ltzv/dlJZrqM/MSDmUjZq/ETmg5c=
X-Google-Smtp-Source: ABdhPJxw0RBTZ6EdJl7c1tWe8jQLg2nx2DYD8VzgTpfGNWUJjdVFWynOnd3uYzKcPAB5zKWALNWMIEM+oUUU+K1a4aM=
X-Received: by 2002:a25:33c4:: with SMTP id z187mr674685ybz.27.1600978461370;
 Thu, 24 Sep 2020 13:14:21 -0700 (PDT)
MIME-Version: 1.0
References: <6CAD359B-F446-4C5D-9C71-3902762ED8D6@fb.com> <47929B19-E739-4E74-BBB7-B2C0DCC7A7F8@fb.com>
 <0fb36afb-6056-5e44-77d8-1ad57d82db1c@iogearbox.net> <BE639CE6-8566-4184-B386-7AEED22939FB@fb.com>
 <fae5ddc7-b7b5-e757-fdbb-2946d56caca3@iogearbox.net> <107FC288-D07C-4881-82BD-8FD29CE42290@fb.com>
 <DEBBD27D-188D-4EFD-8C04-838F54689587@fb.com> <9E8ACC53-12CD-42B5-8419-2ABDCE5967DA@fb.com>
 <CAEf4BzbDMRzHGyxqXoA+bt_QJvybrjLG1EW9xdYLbDTQ5jLbMA@mail.gmail.com>
 <8AF90C54-22F4-46D3-8D79-A6B002BF3F45@fb.com> <374342b3-9504-7ec3-ff73-54cf621c244a@iogearbox.net>
In-Reply-To: <374342b3-9504-7ec3-ff73-54cf621c244a@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 24 Sep 2020 13:14:10 -0700
Message-ID: <CAEf4Bza9e3RiZAS4EAxruYoyj4cccYR5jydhxLBnp__j=fkxjQ@mail.gmail.com>
Subject: Re: Behavior of pinned perf event array
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Song Liu <songliubraving@fb.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 24, 2020 at 1:43 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 9/23/20 6:21 PM, Song Liu wrote:
> >> On Sep 14, 2020, at 3:59 PM, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >> On Fri, Sep 11, 2020 at 1:36 PM Song Liu <songliubraving@fb.com> wrote:
> [...]
> >> Daniel, are you aware of any use cases that do rely on such a behavior
> >> of PERV_EVENT_ARRAY?
> >>
> >> For me this auto-removal of elements on closing *one of a few*
> >> PERF_EVENT_ARRAY FDs (original one, but still just one of a few active
> >> ones) was extremely surprising. It doesn't follow what we do for any
> >> other BPF map, as far as I can tell. E.g., think about
> >> BPF_MAP_TYPE_PROG_ARRAY. If we pin it in BPF FS and close FD, it won't
> >> auto-remove all the tail call programs, right? There is exactly the
> >> same concern with not auto-releasing bpf_progs, just like with
> >> perf_event. But it's not accidental, if you are pinning a BPF map, you
> >> know what you are doing (at least we have to assume so :).
> >>
> >> So instead of adding an extra option, shouldn't we just fix this
> >> behavior instead and make it the same across all BPF maps that hold
> >> kernel resources?
> >
> > Could you please share your thoughts on this? I personally don't have
> > strong preference one way (add a flag) or the other (change the default
> > behavior). But I think we need to agree on the direction to go.
>
> My preference would be to have an opt-in flag, we do rely on the auto-removal
> of the perf event map entry on client close in Cilium at least, e.g. a monitor
> application can insert itself into the map to start receiving events from
> the BPF datapath, and upon exit (no matter whether graceful or not) we don't
> consume any more cycles in the data path than necessary for events, and
> from the __bpf_perf_event_output() we bail out right after checking the
> READ_ONCE(array->ptrs[index]) instead of pushing data that later on no-one
> picks up.

Well, then that's settled. We can't break existing use cases.
