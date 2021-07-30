Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0E43DC0CE
	for <lists+bpf@lfdr.de>; Sat, 31 Jul 2021 00:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbhG3WGm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Jul 2021 18:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbhG3WGm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Jul 2021 18:06:42 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C807CC06175F
        for <bpf@vger.kernel.org>; Fri, 30 Jul 2021 15:06:35 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id p145so3687154ybg.6
        for <bpf@vger.kernel.org>; Fri, 30 Jul 2021 15:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fnxtEDbr0lw/93EuCcFcBfLnk0jp27VKXvX0F+QO0+0=;
        b=ClWnrOan5eb2bs7eQq9BFVAOQLOGNfCaQirL8ITdtqUksN9RoxKCWWZAuI3Shdh9OQ
         yYlmpqxKFQp9lapZt/uBU5t1CdiXCkOcTvKvfDMjz9RM/6A8fP1kvyB2VdftJZt+lWf1
         uylFh9zwNGju0aJYkBo2zRzNSL2sIvAAqC0CLBcY8Ml9eJOZDvfUn9FKQRGfq8PEd3Kq
         hrd8WZC7E6fz0WEcGCFpCoJfnXuzwEV9QjyjZcG0Oq5zREXpq+WpX/kal3ZgfubDijdb
         i0y2Blzhqk/Ob/WhsPLZJGqQ1Ceg7FTbogb3pMcVHgIdd2hZnH+0HiWJrXQTahPqlxXC
         nyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fnxtEDbr0lw/93EuCcFcBfLnk0jp27VKXvX0F+QO0+0=;
        b=TecK9VCN+CUyDQEJZhsitk9xjtFH61M3FT2a2cpMC67I8XULC6Hi4rOJdTWGLnCOEM
         u8tmdn9fVK946FJ5Zrh6PrUUZFNNwHaLVDVgDyS/x7Ku1PJ6xIb93KGKLZJXgdFSRj8G
         UoXFMX7936Rw3N406OHgVPaChN0Zr3aYg3nuBYNazUeLZo0OO8aMpyzdZUC7QMoNDto+
         AfNZOp5uhc+bwmv7DVUfiLxi8850/MEBk7x84f8P7uq+F/A1EWLJCYRAlTGT0a1kUquq
         OcOWAiCond64xMY5R80CV4jfb4KqBvQvp9ZL8AWzJ825c+ljqFlmn2qZRTJ3PqJKL0pq
         cHPA==
X-Gm-Message-State: AOAM5322wSH4f51ssRigoiESM/mAYVQUcVxQwoiSRTf8WlBLX73TGf+v
        HqaL/WcqX921jJVXAR+gaYAj1nZKN4b3U0hTDvY=
X-Google-Smtp-Source: ABdhPJw0fj4EAE7AB8WkIam/+R7ByzxaTyDfCavD2PDtW4RtH5WXAqDH+PcTWNZ5jkmC0Blpgpa3Q06O3Dh+nuPNUzk=
X-Received: by 2002:a25:1455:: with SMTP id 82mr5854910ybu.403.1627682794972;
 Fri, 30 Jul 2021 15:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210726161211.925206-1-andrii@kernel.org> <20210726161211.925206-6-andrii@kernel.org>
 <138b1ab0-1d9c-7288-06bd-fbe29285fc4f@fb.com> <CAEf4Bzb39v5kz1Gc2YjNvGwN8kK8H2fSp1qvipie=ZLpuxRV6Q@mail.gmail.com>
 <5ffd3338-fe76-2080-13a9-5102917a434a@fb.com> <CAEf4BzbR=m3Qusth-1JU_E5YMYaoxrNom9tS_pcArsHyiBD85w@mail.gmail.com>
 <dc7489f5-724b-367e-400f-86d7ccf068d3@fb.com>
In-Reply-To: <dc7489f5-724b-367e-400f-86d7ccf068d3@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 30 Jul 2021 15:06:23 -0700
Message-ID: <CAEf4BzbLAoLhGnT9Q5OjVjjSROeZVrJ=Mu3F9sE8iSoymWjwAQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 05/14] bpf: allow to specify user-provided
 context value for BPF perf links
To:     Yonghong Song <yhs@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 30, 2021 at 2:34 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 7/30/21 10:48 AM, Andrii Nakryiko wrote:
> > On Thu, Jul 29, 2021 at 10:49 PM Yonghong Song <yhs@fb.com> wrote:
> >>
> >>
> >>
> >> On 7/29/21 9:31 PM, Andrii Nakryiko wrote:
> >>> On Thu, Jul 29, 2021 at 11:00 AM Yonghong Song <yhs@fb.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 7/26/21 9:12 AM, Andrii Nakryiko wrote:
> >>>>> Add ability for users to specify custom u64 value when creating BPF link for
> >>>>> perf_event-backed BPF programs (kprobe/uprobe, perf_event, tracepoints).
> >>>>>
> >>>>> This is useful for cases when the same BPF program is used for attaching and
> >>>>> processing invocation of different tracepoints/kprobes/uprobes in a generic
> >>>>> fashion, but such that each invocation is distinguished from each other (e.g.,
> >>>>> BPF program can look up additional information associated with a specific
> >>>>> kernel function without having to rely on function IP lookups). This enables
> >>>>> new use cases to be implemented simply and efficiently that previously were
> >>>>> possible only through code generation (and thus multiple instances of almost
> >>>>> identical BPF program) or compilation at runtime (BCC-style) on target hosts
> >>>>> (even more expensive resource-wise). For uprobes it is not even possible in
> >>>>> some cases to know function IP before hand (e.g., when attaching to shared
> >>>>> library without PID filtering, in which case base load address is not known
> >>>>> for a library).
> >>>>>
> >>>>> This is done by storing u64 user_ctx in struct bpf_prog_array_item,
> >>>>> corresponding to each attached and run BPF program. Given cgroup BPF programs
> >>>>> already use 2 8-byte pointers for their needs and cgroup BPF programs don't
> >>>>> have (yet?) support for user_ctx, reuse that space through union of
> >>>>> cgroup_storage and new user_ctx field.
> >>>>>
> >>>>> Make it available to kprobe/tracepoint BPF programs through bpf_trace_run_ctx.
> >>>>> This is set by BPF_PROG_RUN_ARRAY, used by kprobe/uprobe/tracepoint BPF
> >>>>> program execution code, which luckily is now also split from
> >>>>> BPF_PROG_RUN_ARRAY_CG. This run context will be utilized by a new BPF helper
> >>>>> giving access to this user context value from inside a BPF program. Generic
> >>>>> perf_event BPF programs will access this value from perf_event itself through
> >>>>> passed in BPF program context.
> >>>>>
> >>>>> Cc: Peter Zijlstra <peterz@infradead.org>
> >>>>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> >>>>> ---
> >>>>>     drivers/media/rc/bpf-lirc.c    |  4 ++--
> >>>>>     include/linux/bpf.h            | 16 +++++++++++++++-
> >>>>>     include/linux/perf_event.h     |  1 +
> >>>>>     include/linux/trace_events.h   |  6 +++---
> >>>>>     include/uapi/linux/bpf.h       |  7 +++++++
> >>>>>     kernel/bpf/core.c              | 29 ++++++++++++++++++-----------
> >>>>>     kernel/bpf/syscall.c           |  2 +-
> >>>>>     kernel/events/core.c           | 21 ++++++++++++++-------
> >>>>>     kernel/trace/bpf_trace.c       |  8 +++++---
> >>>>>     tools/include/uapi/linux/bpf.h |  7 +++++++
> >>>>>     10 files changed, 73 insertions(+), 28 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/media/rc/bpf-lirc.c b/drivers/media/rc/bpf-lirc.c
> >>>>> index afae0afe3f81..7490494273e4 100644
> >>>>> --- a/drivers/media/rc/bpf-lirc.c
> >>>>> +++ b/drivers/media/rc/bpf-lirc.c
> >>>>> @@ -160,7 +160,7 @@ static int lirc_bpf_attach(struct rc_dev *rcdev, struct bpf_prog *prog)
> >>>>>                 goto unlock;
> >>>>>         }
> >>>>>
> >>>>> -     ret = bpf_prog_array_copy(old_array, NULL, prog, &new_array);
> >>>>> +     ret = bpf_prog_array_copy(old_array, NULL, prog, 0, &new_array);
> >>>>>         if (ret < 0)
> >>>>>                 goto unlock;
> >>>>>
> >>>> [...]
> >>>>>     void bpf_trace_run1(struct bpf_prog *prog, u64 arg1);
> >>>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> >>>>> index 00b1267ab4f0..bc1fd54a8f58 100644
> >>>>> --- a/include/uapi/linux/bpf.h
> >>>>> +++ b/include/uapi/linux/bpf.h
> >>>>> @@ -1448,6 +1448,13 @@ union bpf_attr {
> >>>>>                                 __aligned_u64   iter_info;      /* extra bpf_iter_link_info */
> >>>>>                                 __u32           iter_info_len;  /* iter_info length */
> >>>>>                         };
> >>>>> +                     struct {
> >>>>> +                             /* black box user-provided value passed through
> >>>>> +                              * to BPF program at the execution time and
> >>>>> +                              * accessible through bpf_get_user_ctx() BPF helper
> >>>>> +                              */
> >>>>> +                             __u64           user_ctx;
> >>>>> +                     } perf_event;
> >>>>
> >>>> Is it possible to fold this field into previous union?
> >>>>
> >>>>                    union {
> >>>>                            __u32           target_btf_id;  /* btf_id of
> >>>> target to attach to */
> >>>>                            struct {
> >>>>                                    __aligned_u64   iter_info;      /*
> >>>> extra bpf_iter_link_info */
> >>>>                                    __u32           iter_info_len;  /*
> >>>> iter_info length */
> >>>>                            };
> >>>>                    };
> >>>>
> >>>>
> >>>
> >>> I didn't want to do it, because different types of BPF links will
> >>> accept this user_ctx (or now bpf_cookie). And then we'll have to have
> >>> different locations of that field for different types of links.
> >>>
> >>> For example, when/if we add this user_ctx to BPF iterator programs,
> >>> having __u64 user_ctx in the same anonymous union will make it overlap
> >>> with iter_info, which is a problem. So I want to have a link
> >>> type-specific sections in LINK_CREATE command section, to allow the
> >>> same field name at different locations.
> >>>
> >>> I actually think that we should put iter_info/iter_info_len into a
> >>> named field, like this (also added user_ctx for bpf_iter link as a
> >>> demonstration):
> >>>
> >>> struct {
> >>>       __aligned_u64 info;
> >>>       __u32         info_len;
> >>>       __aligned_u64 user_ctx;  /* see how it's at a different offset
> >>> than perf_event.user_ctx */
> >>> } iter;
> >>> struct {
> >>>       __u64         user_ctx;
> >>> } perf_event;
> >>>
> >>> (of course keeping already existing fields in anonymous struct for
> >>> backwards compatibility)
> >>
> >> Okay, then since user_ctx may be used by many link types. How
> >> about just with the field "user_ctx" without struct perf_event.
> >
> > I'd love to do it because it is indeed generic and common field, like
> > target_fd. But I'm not sure what you are proposing below. Where
> > exactly that user_ctx (now called bpf_cookie) goes in your example? I
> > see few possible options that allow preserving ABI backwards
> > compatibility. Let's see if you and everyone else likes any of those
> > better. I'll use the full LINK_CREATE sub-struct definition from
> > bpf_attr to make it clear. And to demonstrate how this can be extended
> > to bpf_iter in the future, please note this part as this is an
> > important aspect.
> >
> > 1. Full backwards compatibility and per-link type sections (my current
> > approach):
> >
> >          struct { /* struct used by BPF_LINK_CREATE command */
> >                  __u32           prog_fd;
> >                  union {
> >                          __u32           target_fd;
> >                          __u32           target_ifindex;
> >                  };
> >                  __u32           attach_type;
> >                  __u32           flags;
> >                  union {
> >                          __u32           target_btf_id;
> >                          struct {
> >                                  __aligned_u64   iter_info;
> >                                  __u32           iter_info_len;
> >                          };
> >                          struct {
> >                                  __u64           bpf_cookie;
> >                          } perf_event;
> >                          struct {
> >                                  __aligned_u64   info;
> >                                  __u32           info_len;
> >                                  __aligned_u64   bpf_cookie;
> >                          } iter;
> >                 };
> >          } link_create;
> >
> > The good property here is that we can keep easily extending link
> > type-specific sections with extra fields where needed. For common
> > stuff like bpf_cookie it's suboptimal because we'll need to duplicate
> > field definition in each struct inside that union, but I think that's
> > fine. From end-user point of view, they will know which type of link
> > they are creating, so the use will be straightforward. This is why I
> > went with this approach. But let's consider alternatives.
> >
> > 2. Non-backwards compatible layout but extra flag to specify that new
> > field layout is used.
> >
> >          struct { /* struct used by BPF_LINK_CREATE command */
> >                  __u32           prog_fd;
> >                  union {
> >                          __u32           target_fd;
> >                          __u32           target_ifindex;
> >                  };
> >                  __u32           attach_type;
> >                  __u32           flags; /* this will start supporting
> > some new flag like BPF_F_LINK_CREATE_NEW */
> >                  __u64           bpf_cookie; /* common field now */
> >                  union { /* this parts is effectively deprecated now */
> >                          __u32           target_btf_id;
> >                          struct {
> >                                  __aligned_u64   iter_info;
> >                                  __u32           iter_info_len;
> >                          };
> >                          struct { /* this is new layout, but needs
> > BPF_F_LINK_CREATE_NEW, at least for ext/ and bpf_iter/ programs */
> >                              __u64       bpf_cookie;
> >                              union {
> >                                  struct {
> >                                      __u32     target_btf_id;
> >                                  } ext;
> >                                  struct {
> >                                      __aligned_u64 info;
> >                                      __u32         info_len;
> >                                  } iter;
> >                              }
> >                          }
> >                  };
> >          } link_create;
> >
> > This makes bpf_cookie a common field, but at least for EXT (freplace/)
> > and ITER (bpf_iter/) links we need to specify extra flag to specify
> > that we are not using iter_info/iter_info_len/target_btf_id. bpf_iter
> > then will use iter.info and iter.info_len, and can use plain
> > bpf_cookie.
> >
> > IMO, this is way too confusing and a maintainability nightmare.
> >
> > I'm trying to guess what you are proposing, I can read it two ways,
> > but let me know if I missed something.
> >
> > 3. Just add bpf_cookie field before link type-specific section.
> >
> >          struct { /* struct used by BPF_LINK_CREATE command */
> >                  __u32           prog_fd;
> >                  union {
> >                          __u32           target_fd;
> >                          __u32           target_ifindex;
> >                  };
> >                  __u32           attach_type;
> >                  __u32           flags;
> >                  __u64           bpf_cookie;  // <<<<<<<<<< HERE
> >                  union {
> >                          __u32           target_btf_id;
> >                          struct {
> >                                  __aligned_u64   iter_info;
> >                                  __u32           iter_info_len;
> >                          };
> >                  };
> >          } link_create;
> >
> > This looks really nice and would be great, but that changes offsets
> > for target_btf_id/iter_info/iter_info_len, so a no go. The only way to
> > rectify this is what proposal #2 above does with an extra flag.
> >
> > 4. Add bpf_cookie after link-type specific part:
> >
> >          struct { /* struct used by BPF_LINK_CREATE command */
> >                  __u32           prog_fd;
> >                  union {
> >                          __u32           target_fd;
> >                          __u32           target_ifindex;
> >                  };
> >                  __u32           attach_type;
> >                  __u32           flags;
> >                  union {
> >                          __u32           target_btf_id;
> >                          struct {
> >                                  __aligned_u64   iter_info;
> >                                  __u32           iter_info_len;
> >                          };
> >                          struct {
> >                  };
> >                  __u64           bpf_cookie; // <<<<<<<<<<<<<<<<<< HERE
> >          } link_create;
> >
> > This could work. But we are wasting 16 bytes currently used for
> > target_btf_id/iter_info/iter_info_len. If we later need to do
> > something link type-specific, we can add it to the existing union if
> > we need <= 16 bytes, otherwise we'll need to start another union after
> > bpf_cookie, splitting this into two link type-specific sections.
> >
> > Overall, this might work, especially assuming we won't need to extend
> > iter-specific portions. But I really hate that we didn't do named
> > structs inside that union (i.e., ext.target_btf_id and
> > iter.info/iter.info_len) and I'd like to rectify that in the follow up
> > patches with named structs duplicating existing field layout, but with
> > proper naming. But splitting this LINK_CREATE bpf_attr part into two
> > unions would make it hard and awkward in the future.
> >
> > So, thoughts? Did you have something else in mind that I missed?
>
> What I proposed is your option 4. Yes, in the future if there is there
> are something we want to add to bpf iter, we can add to iter_info, so
> it should not be an issue. Any other new link_type may utilized the same
> union with
>     struct {
>        __aligned_u64  new_type_info;
>        __u32          new_type_info_len;
>     };
> and this will put extensibility into new_type_info.
> I know this may be a little bit hassle but it should work.
>

I see what you mean. With this extra pointer we shouldn't need more
than 16 bytes per link type. That's unnecessary complication for a lot
of simpler types of links, unfortunately, though definitely an option.

We could have also done approach #4 but maybe leave 16-32 bytes before
bpf_cookie for the union, so that it's much less likely that we'll run
out of space there. Not very clean either, so I don't know.

I'll keep it here for discussion for now, let's see if anyone has
strong preferences and opinions.

> Your option 1 should work too, which is what I proposed in the beginning
> to put into the union and we can feel free to add bpf_cookie for each
> individual link type. This is actually cleaner.

Oh, you did? I must have misunderstood then. If you like approach #1,
then it's what I'm doing right now, so let's keep it as is and let's
see if anyone else has preferences.

>
> >
> >
> >> Sometime like
> >>
> >> __u64   user_ctx;
> >>
> >> instead of
> >>
> >> struct {
> >>          __u64   user_ctx;
> >> } perf_event;
> >>
> >>>
> >>> I decided to not do that in this patch set, though, to not distract
> >>> from the main goal. But I think we should avoid this shared field
> >>> "namespace" across different link types going forward.
> >>>
> >>>
> >>>>>                 };
> >>>>>         } link_create;
> >>>>>
> >>>> [...]
