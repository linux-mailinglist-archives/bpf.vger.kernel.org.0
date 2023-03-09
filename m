Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0F66B1D3C
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 09:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjCIIAP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 03:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjCIH7u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 02:59:50 -0500
Received: from smtp.gentoo.org (smtp.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E571A57D0C;
        Wed,  8 Mar 2023 23:58:15 -0800 (PST)
Date:   Thu, 9 Mar 2023 08:58:06 +0100
From:   Guilherme Amadio <amadio@gentoo.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andres Freund <andres@anarazel.de>,
        Quentin Monnet <quentin@isovalent.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Michael Petlan <mpetlan@redhat.com>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH v2 0/3] Assume libbpf 1.0+
Message-ID: <ZAmRjk1x4p4TrFb0@gentoo.org>
References: <20230116010115.490713-1-irogers@google.com>
 <CAP-5=fVUgc8xtBzGi66YRUxZHyXvW2kiMjGz39dywaLxrO4Hpg@mail.gmail.com>
 <Y8mAuDvs566zwG67@kernel.org>
 <Y8myfqy5EMit3Kr/@krava>
 <CAP-5=fUugnKd=pGpZve7tKThhM5b0AqGMnuiELF+fZQw-xJz9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUugnKd=pGpZve7tKThhM5b0AqGMnuiELF+fZQw-xJz9w@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 08, 2023 at 06:13:34PM -0800, Ian Rogers wrote:
> On Thu, Jan 19, 2023 at 1:13 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Thu, Jan 19, 2023 at 02:41:12PM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Thu, Jan 19, 2023 at 09:11:03AM -0800, Ian Rogers escreveu:
> > > > On Sun, Jan 15, 2023 at 5:01 PM Ian Rogers <irogers@google.com> wrote:
> > > > > libbpf 1.0 was a major change in API. Perf has partially supported
> > > > > older libbpf's but an implementation may be:
> > > > > ..
> > > > >        pr_err("%s: not support, update libbpf\n", __func__);
> > > > >        return -ENOTSUP;
> > > > > ..
> > > > >
> > > > > Rather than build a binary that would fail at runtime it is
> > > > > preferrential just to build libbpf statically and link against
> > > > > that. The static version is in the kernel tools tree and newer than
> > > > > 1.0.
> > > > >
> > > > > These patches change the libbpf test to only pass when at least
> > > > > version 1.0 is installed, then remove the conditional build and
> > > > > feature logic.
> > > > >
> > > > > The issue is discussed here:
> > > > > https://lore.kernel.org/lkml/20230106151320.619514-1-irogers@google.com/
> > > > > perf bpf:
> > > > >
> > > > > A variant of this fix was added to Linux 6.2 in:
> > > > > "perf bpf: Avoid build breakage with libbpf < 0.8.0 + LIBBPF_DYNAMIC=1"
> > > > > https://lore.kernel.org/lkml/Y71+eh00Ju7WeEFX@kernel.org/
> > > > > This change goes further in removing logic that is now no longer
> > > > > necessary.
> > > > >
> > > > > v2. Rebase now that breakage fix patch is in linus/master.
> > > >
> > > > I missed the:
> > > > Acked/Tested-by: Jiri Olsa <jolsa@kernel.org>
> > > > I believe we are waiting for package maintainer input.
> > >
> > > Yes, as fedora:37 still is at libbpf 0.8.0 :-\
> >
> > rawhide (f38) is already on 1.1.0 ... I'll check how bad it'd be to move
> > f37 to 1.x, but I had to do bulk update of like 10 other dependent packages
> > for f38, so not sure how bad it'd be for f37
> >
> > jirka
> 
> +Guilherme
> 
> We were looking for maintainer input on these changes, but there is no
> update in over a month. Here is the original lore link:
> https://lore.kernel.org/lkml/CAP-5=fVUgc8xtBzGi66YRUxZHyXvW2kiMjGz39dywaLxrO4Hpg@mail.gmail.com/
> Should these changes land in perf-tools-next targeting Linux 6.4?

Gentoo has libbpf-1.1 already available, so requiring >libbpf-1.0 is not
a problem. We (Gentoo) just need to make sure to stabilize libbpf-1.x before
stabilizing newer versions of perf, as the stable libbpf is 0.8.1 at the moment.

Best regards,
-Guilherme

