Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A76F269958
	for <lists+bpf@lfdr.de>; Tue, 15 Sep 2020 00:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgINW7k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Sep 2020 18:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgINW7i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Sep 2020 18:59:38 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F595C06174A
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2020 15:59:38 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id x8so1088741ybm.3
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2020 15:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IuudMKVDakRKPWGRMEqPXYX3Oi2/4uB01iuRRhheNiQ=;
        b=gzGN6eB5JZG+rmUvvSUhVo3MZek8Yf9ZcfFknaHCF4kELQbIQBZiJDwN9VZtGljbPh
         rue7CuUdX20JE9NyQe6xljk1rtlDp8nTeKPLfD3xBCzwloF76XjdFmf+3CxIJ0901f3+
         iS3oxTux7QGvz94oyL3wS8PWk9mfDCgewGWVcWq/3bi+Cp5yYqh5mB7Mjs/R/9Tzef4r
         KiOtor4x+Z9KYoNlmBVJ2vw2kOdKGpabQKY4bUZbJjC8tLpMmJA5nh1tQ8rxXDUNirbM
         4tsghTtiO3KRIpjVy8+he5N5OMZzu5tLVBN96fNV61taINv8xdi4YrJOXtW2nDg3T6L8
         1o6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IuudMKVDakRKPWGRMEqPXYX3Oi2/4uB01iuRRhheNiQ=;
        b=eBCePkkgPLtzyH2fHU7gVoGMi59THQDPDOSPm/v5wUp4l7tTFt7OZK6G02buaPgdqG
         v4nx0uZaB3fqw8yMF8C7e32Tjz1abD2auM3ldzWQUIv7QlwB5qEXOAd6AzAcxpCnlFts
         27gpuWarTHErQyElw3z7R/8T9H1PjZIslqyieiAXyB8bQA0BMVmQ/RPK+2VIWk4bujNh
         Wu52K/vxw2cF8mNMHwoJStKv+GEXsK+oAaVolQ90Ub0K3Ui7Htt8SRvL+oBk2M+5m7Ms
         UGIw7nDWZZFC8gS6jD8qfKRXvDlgdkH07qI4AQ9isYdWYyTHvJofhJH8+yetSuORTp8b
         d0vw==
X-Gm-Message-State: AOAM530uEl1KpiqJzGQ2Fypo76ZMhMLv2q7Sie8YNgl3DZAx5lS4WxhU
        w3ODqthFHPyCmz2kWcspT1gjt0b1pqu7e/I3Kpk=
X-Google-Smtp-Source: ABdhPJzFSem8QQscV0xCwIuejEHVg2OWYQZHtBPmzSgoUkGDx2LfHZXqvsA3dV3hRQ4kO3UJzJ8+N3h3GKVFZTLNInA=
X-Received: by 2002:a25:e655:: with SMTP id d82mr25137535ybh.347.1600124377524;
 Mon, 14 Sep 2020 15:59:37 -0700 (PDT)
MIME-Version: 1.0
References: <6CAD359B-F446-4C5D-9C71-3902762ED8D6@fb.com> <47929B19-E739-4E74-BBB7-B2C0DCC7A7F8@fb.com>
 <0fb36afb-6056-5e44-77d8-1ad57d82db1c@iogearbox.net> <BE639CE6-8566-4184-B386-7AEED22939FB@fb.com>
 <fae5ddc7-b7b5-e757-fdbb-2946d56caca3@iogearbox.net> <107FC288-D07C-4881-82BD-8FD29CE42290@fb.com>
 <DEBBD27D-188D-4EFD-8C04-838F54689587@fb.com> <9E8ACC53-12CD-42B5-8419-2ABDCE5967DA@fb.com>
In-Reply-To: <9E8ACC53-12CD-42B5-8419-2ABDCE5967DA@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 14 Sep 2020 15:59:26 -0700
Message-ID: <CAEf4BzbDMRzHGyxqXoA+bt_QJvybrjLG1EW9xdYLbDTQ5jLbMA@mail.gmail.com>
Subject: Re: Behavior of pinned perf event array
To:     Song Liu <songliubraving@fb.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 11, 2020 at 1:36 PM Song Liu <songliubraving@fb.com> wrote:
>
>
>
> > On Sep 8, 2020, at 5:32 PM, Song Liu <songliubraving@fb.com> wrote:
> >
> >
> >
> >> On Sep 8, 2020, at 10:22 AM, Song Liu <songliubraving@fb.com> wrote:
> >>
> >>
> >>
> >>> On Sep 3, 2020, at 2:22 PM, Daniel Borkmann <daniel@iogearbox.net> wrote:
> >>>
> >>> On 9/3/20 1:05 AM, Song Liu wrote:
> >>>>> On Sep 2, 2020, at 3:28 PM, Daniel Borkmann <daniel@iogearbox.net> wrote:
> >>>>>
> >>>>> Hi Song,
> >>>>>
> >>>>> Sorry indeed missed it.
> >>>>>
> >>>>> On 9/2/20 11:33 PM, Song Liu wrote:
> >>>>>>> On Aug 24, 2020, at 4:57 PM, Song Liu <songliubraving@fb.com> wrote:
> >>>>>>>
> >>>>>>> We are looking at sharing perf events amount multiple processes via
> >>>>>>> pinned perf event array. However, we found this doesn't really work
> >>>>>>> as the perf event is removed from the map when the struct file is
> >>>>>>> released from user space (in perf_event_fd_array_release). This
> >>>>>>> means, the pinned perf event array can be shared among multiple
> >>>>>>> process. But each perf event still has single owner. Once the owner
> >>>>>>> process closes the fd (or terminates), the perf event is removed
> >>>>>>> from the array. I went thought the history of the code and found
> >>>>>>> this behavior is actually expected (commit 3b1efb196eee).
> >>>>>
> >>>>> Right, that auto-cleanup is expected.
> >>>>>
> >>>>>>> In our use case, however, we want to share the perf event among
> >>>>>>> different processes. I think we have a few options to achieve this:
> >>>>>>>
> >>>>>>> 1. Introduce a new flag for the perf event map, like BPF_F_KEEP_PE_OPEN.
> >>>>>>> Once this flag is set, we should not remove the fd on struct file
> >>>>>>> release. Instead, we remove fd in map_release_uref.
> >>>>>>>
> >>>>>>> 2. Allow a different process to hold reference to the perf_event
> >>>>>>> via pinned perf event array. I guess we can achieve this by
> >>>>>>> enabling for BPF_MAP_UPDATE_ELEM perf event array.
> >>>>>>>
> >>>>>>> 3. Other ideas?
> >>>>>>>
> >>>>>>> Could you please let us know your thoughts on this?
> >>>>>
> >>>>> One option that would work for sure is to transfer the fd to the other
> >>>>> processes via fd passing e.g. through pipe or unix domain socket.
> >>>> I haven't tried to transfer the fd, but it might be tricky. We need to
> >>>> plan for more than 2 processes sharing the events, and these processes
> >>>> will start and terminate in any order.
> >>>>> I guess my question would be that it would be hard to debug if we keep
> >>>>> dangling perf event entries in there yb accident that noone is cleaning
> >>>>> up. Some sort of flag is probably okay, but it needs proper introspection
> >>>>> facilities from bpftool side so that it could be detected that it's just
> >>>>> dangling around waiting for cleanup.
> >>>> With my latest design, we don't need to pin the perf_event map (neither
> >>>> the prog accessing the map. I guess this can make the clean up problem
> >>>> better? So we will add a new flag for map_create. With the flag, we
> >>>
> >>> I mean pinning the map itself or the prog making use of accessing the map
> >>> is not the issue. Afaik, it's more the perf RB that is consuming memory and
> >>> can be dangling, so the presence of the /entry/ in the map itself which
> >>> would then not be cleaned up by accident, I think this was the motivation
> >>> back then at least.

Daniel, are you aware of any use cases that do rely on such a behavior
of PERV_EVENT_ARRAY?

For me this auto-removal of elements on closing *one of a few*
PERF_EVENT_ARRAY FDs (original one, but still just one of a few active
ones) was extremely surprising. It doesn't follow what we do for any
other BPF map, as far as I can tell. E.g., think about
BPF_MAP_TYPE_PROG_ARRAY. If we pin it in BPF FS and close FD, it won't
auto-remove all the tail call programs, right? There is exactly the
same concern with not auto-releasing bpf_progs, just like with
perf_event. But it's not accidental, if you are pinning a BPF map, you
know what you are doing (at least we have to assume so :).

So instead of adding an extra option, shouldn't we just fix this
behavior instead and make it the same across all BPF maps that hold
kernel resources?

> >>>
> >>>> will not close the perf_event during process termination, and we block
> >>>> pinning for this map, and any program accessing this map. Does this
> >>>> sounds like a good plan?
> >>>
> >>> Could you elaborate why blocking pinning of map/prog is useful in this context?
> >>
> >> I was thinking, we are more likely to forget cleaning up pinned map. If the
> >> map is not pinned, it will be at least cleaned up when all processes accessing
> >> it terminate. On the other hand, pinned map would stay until someone removes
> >> it from bpffs. So the idea is to avoid the pinning scenario.
> >>
> >> But I agree this won't solve all the problems. Say process A added a few
> >> perf events (A_events) to the map. And process B added some other events
> >> (B_events)to the same map. Blocking pinning makes sure we clean up everything
> >> when both A and B terminates. But if A terminates soon, while B runs for a
> >> long time, A_events will stay open unnecessarily.
> >>
> >> Alternatively, we can implement map_fd_sys_lookup_elem for perf event map,
> >> which returns an fd to the perf event. With this solution, if process A added
> >> some events to the map, and process B want to use them after process A
> >> terminates. We need to explicitly do the lookup in process B and holds the fd
> >> to the perf event. Maybe this is a better solution?
> >
> > Actually, this doesn't work. :( With map_fd_sys_lookup_elem(), we can get a fd
> > on the perf_event, but we still remove the event from the map in
> > perf_event_fd_array_release(). Let me see what the best next step...
>
> CC Andrii and bpf@

thanks, Song!

>
> Andrii and I had some discussion on this.
>
> Currently, I am working on something with a new flag BPF_F_SHARE_PE. I attached
> the diff below.
>
> On the other hand, we found current behavior of perf_event_array puzzling,
> especially pinned perf_event_array (as pinning doesn't really pin the content).
> Therefore, we may consider changing the behavior without a flag?
>
> Thanks,
> Song
>
>
> ========================================================================
>

[...]
