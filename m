Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E2F5766E9
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 20:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiGOSqm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 14:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiGOSql (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 14:46:41 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5353CBCA
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 11:46:39 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id r18so7382599edb.9
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 11:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=trutshYT4pF6x9O0GeYh4p5cQt9lOfMhi+6LpApr7ss=;
        b=OPuMtLA80TMGBITBM88YCTQPLSyRfqmgvThD0AUTdOvnnhLdf1+NDW1RS+G5Ul+188
         oD1Dz++uZBuKCTgbQ/sjXbnYShSmLGO8dFeHvuAO+N4QJbYk9+u04WZKGzKO1GcsQ7Mv
         88jsk2O4LBB97VTUiiG50RGBRvcdfOZ58JA03aHmQns2dNpY4m1/frlHFdryXdaXNQez
         Vd+9ZowBaAieeCqgzWOVHy7Ac+Hh6pSEIIVupfQvbBBCo6Nh9Ot7z65mlUxPIieUAgkI
         o0HZiL7kso8yjwJDO/sRt4CcyjD3uQYa3dcV0sMrA/gSgMoqWp0T9mAtNgQ6YKHfeZUT
         57og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=trutshYT4pF6x9O0GeYh4p5cQt9lOfMhi+6LpApr7ss=;
        b=iArKAsPLDhj+uevLcZeesUB2sp90M5x2GxoKdQNbEEGZjuCb1AOOiA0TxZ+PL3lo1J
         zOiIRyUJadzJDvspoIZaMznatyDNM1B5d9w8JNERq7ACfo9jZisINMVkPgW8iCMZh7Jd
         gxDUWKakv3QJZVub6hfulLmFGYBjRERqcnf/DQYkvBMGq4zRnlm5GXpwJxbLQm0sHEBf
         5VqxIXcUl3p+GNCi4Pjve3BCbWYf7JAlbZ4GR+c3E4CkmMAePUYgyir7JGZSzpnnedNi
         b/RCGS9wb00evjmou9Dyr8UFuPM+Bkk1E3Gf7+KLREETYfKs4ExWxXgc6KLQA9GPHFd1
         1CzQ==
X-Gm-Message-State: AJIora/AssoeMFWB7C3oyH7MTly4biKrFIZigP97m6uCkUhK2b2sUlu4
        GqD7D0IXjZ2UM1htjeOf+6/j+6yILhktuV86NzHdcOWKFB0=
X-Google-Smtp-Source: AGRyM1ukOYJmK1u4CbXp3RtHZqMlDzeQkWxxcKLYLxIsC3ufBbCCu5kUJf1FFS+F/MHVrrzk42M/Q7PZQ+JVJJzXIBc=
X-Received: by 2002:a05:6402:5114:b0:43a:d072:83b9 with SMTP id
 m20-20020a056402511400b0043ad07283b9mr21314072edd.260.1657910798108; Fri, 15
 Jul 2022 11:46:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220714232143.3728834-1-andrii@kernel.org> <fc3dfc6c-25f8-a7a5-7ec1-b929712ed9b5@fb.com>
 <CAEf4BzZHmyN5vweCNWJq=GnqGT6T0CfP7QxAHNTOoe5TJB3o-g@mail.gmail.com> <17dbbee6-f7d1-0e8d-ddf6-d713eda5b498@fb.com>
In-Reply-To: <17dbbee6-f7d1-0e8d-ddf6-d713eda5b498@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 15 Jul 2022 11:46:26 -0700
Message-ID: <CAEf4BzbiXrsfzyxsN7xviK+JqtPAusc_DiR-w+5Wxuhjo__Yhg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: fallback to tracefs mount point if
 debugfs is not mounted
To:     Yonghong Song <yhs@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        "Connor O'Brien" <connoro@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 14, 2022 at 11:13 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 7/14/22 10:25 PM, Andrii Nakryiko wrote:
> > On Thu, Jul 14, 2022 at 5:29 PM Yonghong Song <yhs@fb.com> wrote:
> >>
> >>
> >>
> >> On 7/14/22 4:21 PM, Andrii Nakryiko wrote:
> >>> Teach libbpf to fallback to tracefs mount point (/sys/kernel/tracing) if
> >>> debugfs (/sys/kernel/debug/tracing) isn't mounted.
> >>>
> >>> Suggested-by: Connor O'Brien <connoro@google.com>
> >>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> >>
> >> Ack with a few suggestions below.
> >>
> >> Acked-by: Yonghong Song <yhs@fb.com>
> >>
> >>> ---
> >>>    tools/lib/bpf/libbpf.c | 33 +++++++++++++++++++++++----------
> >>>    1 file changed, 23 insertions(+), 10 deletions(-)
> >>>
> >>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> >>> index 68da1aca406c..4acdc174cc73 100644
> >>> --- a/tools/lib/bpf/libbpf.c
> >>> +++ b/tools/lib/bpf/libbpf.c
> >>> @@ -9828,6 +9828,19 @@ static int append_to_file(const char *file, const char *fmt, ...)
> >>>        return err;
> >>>    }
> >>>
> >>> +#define DEBUGFS "/sys/kernel/debug/tracing"
> >>> +#define TRACEFS "/sys/kernel/tracing"
> >>> +
> >>> +static bool use_debugfs(void)
> >>> +{
> >>> +     static int has_debugfs = -1;
> >>> +
> >>> +     if (has_debugfs < 0)
> >>> +             has_debugfs = access(DEBUGFS, F_OK) == 0;
> >>> +
> >>> +     return has_debugfs == 1;
> >>> +}
> >>> +
> >>>    static void gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
> >>>                                         const char *kfunc_name, size_t offset)
> >>>    {
> >>> @@ -9840,7 +9853,7 @@ static void gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
> >>>    static int add_kprobe_event_legacy(const char *probe_name, bool retprobe,
> >>>                                   const char *kfunc_name, size_t offset)
> >>>    {
> >>> -     const char *file = "/sys/kernel/debug/tracing/kprobe_events";
> >>> +     const char *file = use_debugfs() ? DEBUGFS"/kprobe_events" : TRACEFS"/kprobe_events";
> >>
> >> I am wondering whether we can have a helper function to return
> >>     use_debugfs() ? DEBUGFS"/kprobe_events" : TRACEFS"/kprobe_events"
> >> so use_debugfs() won't appear in add_kprobe_event_legacy() function.
> >>
> >
> > So I'm not sure what exactly you are proposing. We have 3 different
> > paths involving DEBUGS/TRACEFS prefix: DEBUGFS/kprobe_events,
> > DEBUGFS/uprobe_events, and "%s/events/%s/%s/id where first part is
> > DEBUGFS/TRACEFS.
> >
> > Are you proposing to add two extra helper functions effectively returning:
> >    - use_debugfs() ? DEBUGFS"/kprobe_events" : TRACEFS"/kprobe_events"
> >    - use_debugfs() ? DEBUGFS"/uprobe_events" : TRACEFS"/uprobe_events"
> >
> > and leave the third case as is? That seems inconsistent, and extra
> > function just makes it slightly harder to track what actual path is
> > used.
> >
> > In general, I've always argued for using such string constants inline
> > without extra #defines and I'd love to be able to still do that, but
> > this debugfs vs tracefs unfortunately means I can't do it. The current
> > approach was the closest I could come up with. But at least I don't
> > want to dig those even deeper unnecessarily into some extra helper
> > funcs.
>
> The following is what I mean (on top of your patch):
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 4acdc174cc73..38cdeab1622d 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9841,6 +9841,18 @@ static bool use_debugfs(void)
>          return has_debugfs == 1;
>   }
>
> +static const char *kprobe_events_path(void) {
> +       return use_debugfs() ? DEBUGFS"/kprobe_events" :
> TRACEFS"/kprobe_events";
> +}
> +
> +static const char *uprobe_events_path(void) {
> +       return use_debugfs() ? DEBUGFS"/uprobe_events" :
> TRACEFS"/uprobe_events";
> +}
> +
> +static const char *tracefs_path(void) {
> +       return use_debugfs() ? DEBUGFS : TRACEFS;
> +}
> +
>   static void gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
>                                           const char *kfunc_name, size_t
> offset)
>   {
> @@ -9853,7 +9865,7 @@ static void gen_kprobe_legacy_event_name(char
> *buf, size_t buf_sz,
>   static int add_kprobe_event_legacy(const char *probe_name, bool retprobe,
>                                     const char *kfunc_name, size_t offset)
>   {
> -       const char *file = use_debugfs() ? DEBUGFS"/kprobe_events" :
> TRACEFS"/kprobe_events";
> +       const char *file = kprobe_events_path();
>
>          return append_to_file(file, "%c:%s/%s %s+0x%zx",
>                                retprobe ? 'r' : 'p',
> @@ -9863,7 +9875,7 @@ static int add_kprobe_event_legacy(const char
> *probe_name, bool retprobe,
>
>   static int remove_kprobe_event_legacy(const char *probe_name, bool
> retprobe)
>   {
> -       const char *file = use_debugfs() ? DEBUGFS"/kprobe_events" :
> TRACEFS"/kprobe_events";
> +       const char *file = kprobe_events_path();
>
>          return append_to_file(file, "-:%s/%s", retprobe ? "kretprobes"
> : "kprobes", probe_name);
>   }
> @@ -9873,7 +9885,7 @@ static int determine_kprobe_perf_type_legacy(const
> char *probe_name, bool retpro
>          char file[256];
>
>          snprintf(file, sizeof(file), "%s/events/%s/%s/id",
> -                use_debugfs() ? DEBUGFS : TRACEFS,
> +                tracefs_path(),
>                   retprobe ? "kretprobes" : "kprobes", probe_name);
>
>          return parse_uint_from_file(file, "%d\n");
> @@ -10226,7 +10238,7 @@ static void gen_uprobe_legacy_event_name(char
> *buf, size_t buf_sz,
>   static inline int add_uprobe_event_legacy(const char *probe_name, bool
> retprobe,
>                                            const char *binary_path,
> size_t offset)
>   {
> -       const char *file = use_debugfs() ? DEBUGFS"/uprobe_events" :
> TRACEFS"/uprobe_events";
> +       const char *file = uprobe_events_path();
>
>          return append_to_file(file, "%c:%s/%s %s:0x%zx",
>                                retprobe ? 'r' : 'p',
> @@ -10236,7 +10248,7 @@ static inline int add_uprobe_event_legacy(const
> char *probe_name, bool retprobe,
>
>   static inline int remove_uprobe_event_legacy(const char *probe_name,
> bool retprobe)
>   {
> -       const char *file = use_debugfs() ? DEBUGFS"/uprobe_events" :
> TRACEFS"/uprobe_events";
> +       const char *file = uprobe_events_path();
>
>          return append_to_file(file, "-:%s/%s", retprobe ? "uretprobes"
> : "uprobes", probe_name);
>   }
> @@ -10246,7 +10258,7 @@ static int
> determine_uprobe_perf_type_legacy(const char *probe_name, bool retpro
>          char file[512];
>
>          snprintf(file, sizeof(file), "%s/events/%s/%s/id",
> -                use_debugfs() ? DEBUGFS : TRACEFS,
> +                tracefs_path(),
>                   retprobe ? "uretprobes" : "uprobes", probe_name);
>
>          return parse_uint_from_file(file, "%d\n");
> @@ -10796,7 +10808,7 @@ static int determine_tracepoint_id(const char
> *tp_category,
>          int ret;
>
>          ret = snprintf(file, sizeof(file), "%s/events/%s/%s/id",
> -                      use_debugfs() ? DEBUGFS : TRACEFS,
> +                      tracefs_path(),
>                         tp_category, tp_name);
>          if (ret < 0)
>                  return -errno;
>
> The goal is to hide use_debugfs() from functions
> {add,remove)_kprobe_event_legacy and {add,remove)_uprobe_event_legacy.
> Previously I missed the different usage of kprobe/uprobe, so now my
> approach has three (inlinable) static functions instead two.
> I guess your current approach should be okay then. I have acked anyway.
>

Ok, I'll send v2 with use_debugfs() hidden.


> >
> >>>
> >>>        return append_to_file(file, "%c:%s/%s %s+0x%zx",
> >>>                              retprobe ? 'r' : 'p',
> >>> @@ -9850,7 +9863,7 @@ static int add_kprobe_event_legacy(const char *probe_name, bool retprobe,
> >>>
> >>>    static int remove_kprobe_event_legacy(const char *probe_name, bool retprobe)
> >>>    {
> >>> -     const char *file = "/sys/kernel/debug/tracing/kprobe_events";
> >>> +     const char *file = use_debugfs() ? DEBUGFS"/kprobe_events" : TRACEFS"/kprobe_events";
> >>>
> >>>        return append_to_file(file, "-:%s/%s", retprobe ? "kretprobes" : "kprobes", probe_name);
> >>>    }
> >>> @@ -9859,8 +9872,8 @@ static int determine_kprobe_perf_type_legacy(const char *probe_name, bool retpro
> >>>    {
> >>>        char file[256];
> >>>
> >>> -     snprintf(file, sizeof(file),
> >>> -              "/sys/kernel/debug/tracing/events/%s/%s/id",
> >>> +     snprintf(file, sizeof(file), "%s/events/%s/%s/id",
> >>> +              use_debugfs() ? DEBUGFS : TRACEFS,
> >>
> >> The same here, a helper function can hide the details of use_debugfs().
> >
> > well here I can't hide just DEBUGFS/TRACEFS parts, or are you
> > suggesting to move the entire snprintf() into a separate function? Not
> > sure I see benefits of the latter, tbh.
> >
> >>
> >>>                 retprobe ? "kretprobes" : "kprobes", probe_name);
> >>>
> >>>        return parse_uint_from_file(file, "%d\n");
> >>> @@ -10213,7 +10226,7 @@ static void gen_uprobe_legacy_event_name(char *buf, size_t buf_sz,
> >>>    static inline int add_uprobe_event_legacy(const char *probe_name, bool retprobe,
> >>>                                          const char *binary_path, size_t offset)
> >>>    {
> >>> -     const char *file = "/sys/kernel/debug/tracing/uprobe_events";
> >>> +     const char *file = use_debugfs() ? DEBUGFS"/uprobe_events" : TRACEFS"/uprobe_events";
> >>>
> >>>        return append_to_file(file, "%c:%s/%s %s:0x%zx",
> >>>                              retprobe ? 'r' : 'p',
> >> [...]
