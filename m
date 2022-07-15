Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA12575AF6
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 07:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiGOFZ7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 01:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiGOFZ4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 01:25:56 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5FB79EE8
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 22:25:54 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id dn9so7048919ejc.7
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 22:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dmjMmtBRGISfMkxjW88zuQ/op/Qa2y+nuXj4Qw8x7CQ=;
        b=DIeANxdfScOI93MHtalVj96a1i4ikNydAcLP2MJkf8+dpBxn65Ch5Tb26AbVD9GWtL
         dQFW/T3DJH+bgmNNfpHCp2XYTPECnW7EhxxH1U4gAAfa8RhVOGqpklCbeSJsLRK0IAae
         Bfc2mOkDcHKJGVHRTb2cj/D7LCjaGVqJb82VorRXhVsi/8ZT/qbMk8zq9+o4l8GxzVcV
         XsFOBAZPoJkkX3B0S3VMtAgBKdpatLRFBq03xoXgXGt+VH1CKxrvNg1WElLBmAvomoXJ
         TWm72wzr4cR9XKEgEuDeGTS0ngXulBUY8dhE0alPLQEcBkEBlN9bAXD72o4UutIhnlAl
         I15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dmjMmtBRGISfMkxjW88zuQ/op/Qa2y+nuXj4Qw8x7CQ=;
        b=MewmRBxTIFJNqENE8Bhb48tKI5V7LWsmdk1957j4Rr+ZFCpQ/Hnlf3wMfHLH82ioQt
         uVxx/EIIOXvKKpbBpVbqyrEJWB+WAIDmzziMkrYxCfIhcF9/jVpL2Ye8sOZQLRT9mCCh
         rwOqe/Qztis0W0gtO5ALcmsGtehg/NbARNmYT3HsENj1EcI07lkh7Csu+Ld3ixEHlbJd
         pBer9pvHLMAUk9zOl6yyBHOMX/CXKbY1Zkn5N1XwwAiMa054otMF+9nn7WmOPqN9Mjq5
         MGfLNsenYqk+aLQb6bBx+D92pgQE+1mUO8onPjHMSDraIjgag0tFl4bpFupMuHq5aGww
         X3gA==
X-Gm-Message-State: AJIora/vTzm0PQQaX9C9NxiFt6gwozKz0tLtLVmxCDzQ/2T8anXLxvcy
        3LB4H7z46c3VI8FTehT9yxwV1kDpXX9S+l1Gc9A=
X-Google-Smtp-Source: AGRyM1s+RoN2C5N7AUtedjIKgmqnc06CujvphIHn++sowJ3NHfvat6I+IyvMSrKcgKT8s2NeuNFNKipIak/me05zG20=
X-Received: by 2002:a17:907:6e05:b0:72a:a141:962 with SMTP id
 sd5-20020a1709076e0500b0072aa1410962mr11946312ejc.545.1657862753039; Thu, 14
 Jul 2022 22:25:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220714232143.3728834-1-andrii@kernel.org> <fc3dfc6c-25f8-a7a5-7ec1-b929712ed9b5@fb.com>
In-Reply-To: <fc3dfc6c-25f8-a7a5-7ec1-b929712ed9b5@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 14 Jul 2022 22:25:41 -0700
Message-ID: <CAEf4BzZHmyN5vweCNWJq=GnqGT6T0CfP7QxAHNTOoe5TJB3o-g@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 14, 2022 at 5:29 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 7/14/22 4:21 PM, Andrii Nakryiko wrote:
> > Teach libbpf to fallback to tracefs mount point (/sys/kernel/tracing) if
> > debugfs (/sys/kernel/debug/tracing) isn't mounted.
> >
> > Suggested-by: Connor O'Brien <connoro@google.com>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> Ack with a few suggestions below.
>
> Acked-by: Yonghong Song <yhs@fb.com>
>
> > ---
> >   tools/lib/bpf/libbpf.c | 33 +++++++++++++++++++++++----------
> >   1 file changed, 23 insertions(+), 10 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 68da1aca406c..4acdc174cc73 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -9828,6 +9828,19 @@ static int append_to_file(const char *file, const char *fmt, ...)
> >       return err;
> >   }
> >
> > +#define DEBUGFS "/sys/kernel/debug/tracing"
> > +#define TRACEFS "/sys/kernel/tracing"
> > +
> > +static bool use_debugfs(void)
> > +{
> > +     static int has_debugfs = -1;
> > +
> > +     if (has_debugfs < 0)
> > +             has_debugfs = access(DEBUGFS, F_OK) == 0;
> > +
> > +     return has_debugfs == 1;
> > +}
> > +
> >   static void gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
> >                                        const char *kfunc_name, size_t offset)
> >   {
> > @@ -9840,7 +9853,7 @@ static void gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
> >   static int add_kprobe_event_legacy(const char *probe_name, bool retprobe,
> >                                  const char *kfunc_name, size_t offset)
> >   {
> > -     const char *file = "/sys/kernel/debug/tracing/kprobe_events";
> > +     const char *file = use_debugfs() ? DEBUGFS"/kprobe_events" : TRACEFS"/kprobe_events";
>
> I am wondering whether we can have a helper function to return
>    use_debugfs() ? DEBUGFS"/kprobe_events" : TRACEFS"/kprobe_events"
> so use_debugfs() won't appear in add_kprobe_event_legacy() function.
>

So I'm not sure what exactly you are proposing. We have 3 different
paths involving DEBUGS/TRACEFS prefix: DEBUGFS/kprobe_events,
DEBUGFS/uprobe_events, and "%s/events/%s/%s/id where first part is
DEBUGFS/TRACEFS.

Are you proposing to add two extra helper functions effectively returning:
  - use_debugfs() ? DEBUGFS"/kprobe_events" : TRACEFS"/kprobe_events"
  - use_debugfs() ? DEBUGFS"/uprobe_events" : TRACEFS"/uprobe_events"

and leave the third case as is? That seems inconsistent, and extra
function just makes it slightly harder to track what actual path is
used.

In general, I've always argued for using such string constants inline
without extra #defines and I'd love to be able to still do that, but
this debugfs vs tracefs unfortunately means I can't do it. The current
approach was the closest I could come up with. But at least I don't
want to dig those even deeper unnecessarily into some extra helper
funcs.

> >
> >       return append_to_file(file, "%c:%s/%s %s+0x%zx",
> >                             retprobe ? 'r' : 'p',
> > @@ -9850,7 +9863,7 @@ static int add_kprobe_event_legacy(const char *probe_name, bool retprobe,
> >
> >   static int remove_kprobe_event_legacy(const char *probe_name, bool retprobe)
> >   {
> > -     const char *file = "/sys/kernel/debug/tracing/kprobe_events";
> > +     const char *file = use_debugfs() ? DEBUGFS"/kprobe_events" : TRACEFS"/kprobe_events";
> >
> >       return append_to_file(file, "-:%s/%s", retprobe ? "kretprobes" : "kprobes", probe_name);
> >   }
> > @@ -9859,8 +9872,8 @@ static int determine_kprobe_perf_type_legacy(const char *probe_name, bool retpro
> >   {
> >       char file[256];
> >
> > -     snprintf(file, sizeof(file),
> > -              "/sys/kernel/debug/tracing/events/%s/%s/id",
> > +     snprintf(file, sizeof(file), "%s/events/%s/%s/id",
> > +              use_debugfs() ? DEBUGFS : TRACEFS,
>
> The same here, a helper function can hide the details of use_debugfs().

well here I can't hide just DEBUGFS/TRACEFS parts, or are you
suggesting to move the entire snprintf() into a separate function? Not
sure I see benefits of the latter, tbh.

>
> >                retprobe ? "kretprobes" : "kprobes", probe_name);
> >
> >       return parse_uint_from_file(file, "%d\n");
> > @@ -10213,7 +10226,7 @@ static void gen_uprobe_legacy_event_name(char *buf, size_t buf_sz,
> >   static inline int add_uprobe_event_legacy(const char *probe_name, bool retprobe,
> >                                         const char *binary_path, size_t offset)
> >   {
> > -     const char *file = "/sys/kernel/debug/tracing/uprobe_events";
> > +     const char *file = use_debugfs() ? DEBUGFS"/uprobe_events" : TRACEFS"/uprobe_events";
> >
> >       return append_to_file(file, "%c:%s/%s %s:0x%zx",
> >                             retprobe ? 'r' : 'p',
> [...]
