Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1351D56EE
	for <lists+bpf@lfdr.de>; Fri, 15 May 2020 19:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgEORAL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 May 2020 13:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726250AbgEORAL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 15 May 2020 13:00:11 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA83AC061A0C
        for <bpf@vger.kernel.org>; Fri, 15 May 2020 10:00:09 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id y10so1181181ybm.12
        for <bpf@vger.kernel.org>; Fri, 15 May 2020 10:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7FCtnhxXRkcL3anwH9mEdDuKXNzEgQcRUlM4mCBSwPs=;
        b=ccbWLnUtUwiKAn842+6hU4C8edxHHnDZVhGAcXJ4MHD2aPM6Y9mOFtesaLH/exfbRt
         V8+JUSsPRZGS6hqOjAIdFZfjzoqsQd2EFR1KpOCWVsK8DeNYUfpVPeuX+Bc1ljak+GmK
         IXRcsBaTgrtooRn0FHSrLzePzaHbEIPHqyT7MivD7o8WNzJZAywU2+W4FDZ/61x78tN+
         ijTVdyvNlGULn23pBqyFlg5XtYzRLEJRj2EC4Bv5rvQILYRVWMtK3yB6og4PdN3nWygU
         YUR1czuWUDExyXOofEPeqN2USbyL9tKoOXk+6h7oEeUKlWH/11Da1+aoBE84Br767RNx
         08XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7FCtnhxXRkcL3anwH9mEdDuKXNzEgQcRUlM4mCBSwPs=;
        b=gmRaXum/5S4Wyw5BsD92oRLssJal8o8FTS+lSxk4KzHCXqkAy0SNomaHTTqkm8oQnn
         LZKaapLEey6T3IS+YX9QYmctKGA4YD34oiZmlW3FkDWgbZiN1DPHRNtKLhKBhHABY81x
         P2kQDKOhIbmhjFkZXthk1zJw1Z8IqN+oJYESms4zkDVVQGn9e849i+yAyWODxgkArXrN
         KKkNQA2OoLMvjPpIYmwtKIfAsKI6j3bWpatuLgOLVGoLPRXRpekfXQYARZn8UUR2tOxn
         mIjfKTtf1SRu8k2lO2jGn16tPeOsLeU35KVZL09I62hVRAweh8HiGpMc4O8NB6tz0pnc
         ZUpQ==
X-Gm-Message-State: AOAM532AmRq9M1fLn3u1KvdGkDznGbBrOslEI6nmNG00M+13Ma98TiSG
        A1B01GoZiS/tLldMM0BPHAPOFh8HRfPVW3sixi9lqQ==
X-Google-Smtp-Source: ABdhPJyH3+hVuoWG26jUdXOuiqO06AU3SHQ71fqWw7wtANcrcWD7kOBFVq4nqnjQ0Txo9ZKUonn51mDqXlP2DLGicIk=
X-Received: by 2002:a25:c08b:: with SMTP id c133mr7057333ybf.286.1589562008534;
 Fri, 15 May 2020 10:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200515065624.21658-1-irogers@google.com> <20200515065624.21658-5-irogers@google.com>
 <20200515091707.GC3511648@krava> <20200515142917.GT5583@kernel.org>
 <CAP-5=fXtXgnb4nrVtsoxQ6vj8YtzPicFsad6+jB5UUFqMzg4mw@mail.gmail.com> <20200515163146.GA9335@kernel.org>
In-Reply-To: <20200515163146.GA9335@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 15 May 2020 09:59:57 -0700
Message-ID: <CAP-5=fWiaVXVHVu7iFw+7V21Ztf6VU7BtwhUa5gsq3f+ZryQ+w@mail.gmail.com>
Subject: Re: [PATCH 4/8] libbpf hashmap: Localize static hashmap__* symbols
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 15, 2020 at 9:31 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Fri, May 15, 2020 at 07:53:33AM -0700, Ian Rogers escreveu:
> > On Fri, May 15, 2020 at 7:29 AM Arnaldo Carvalho de Melo
> > <arnaldo.melo@gmail.com> wrote:
> > >
> > > Em Fri, May 15, 2020 at 11:17:07AM +0200, Jiri Olsa escreveu:
> > > > On Thu, May 14, 2020 at 11:56:20PM -0700, Ian Rogers wrote:
> > > > > Localize the hashmap__* symbols in libbpf.a. To allow for a version in
> > > > > libapi.
> > > > >
> > > > > Before:
> > > > > $ nm libbpf.a
> > > > > ...
> > > > > 000000000002088a t hashmap_add_entry
> > > > > 000000000001712a t hashmap__append
> > > > > 0000000000020aa3 T hashmap__capacity
> > > > > 000000000002099c T hashmap__clear
> > > > > 00000000000208b3 t hashmap_del_entry
> > > > > 0000000000020fc1 T hashmap__delete
> > > > > 0000000000020f29 T hashmap__find
> > > > > 0000000000020c6c t hashmap_find_entry
> > > > > 0000000000020a61 T hashmap__free
> > > > > 0000000000020b08 t hashmap_grow
> > > > > 00000000000208dd T hashmap__init
> > > > > 0000000000020d35 T hashmap__insert
> > > > > 0000000000020ab5 t hashmap_needs_to_grow
> > > > > 0000000000020947 T hashmap__new
> > > > > 0000000000000775 t hashmap__set
> > > > > 00000000000212f8 t hashmap__set
> > > > > 0000000000020a91 T hashmap__size
> > > > > ...
> > > > >
> > > > > After:
> > > > > $ nm libbpf.a
> > > > > ...
> > > > > 000000000002088a t hashmap_add_entry
> > > > > 000000000001712a t hashmap__append
> > > > > 0000000000020aa3 t hashmap__capacity
> > > > > 000000000002099c t hashmap__clear
> > > > > 00000000000208b3 t hashmap_del_entry
> > > > > 0000000000020fc1 t hashmap__delete
> > > > > 0000000000020f29 t hashmap__find
> > > > > 0000000000020c6c t hashmap_find_entry
> > > > > 0000000000020a61 t hashmap__free
> > > > > 0000000000020b08 t hashmap_grow
> > > > > 00000000000208dd t hashmap__init
> > > > > 0000000000020d35 t hashmap__insert
> > > > > 0000000000020ab5 t hashmap_needs_to_grow
> > > > > 0000000000020947 t hashmap__new
> > > > > 0000000000000775 t hashmap__set
> > > > > 00000000000212f8 t hashmap__set
> > > > > 0000000000020a91 t hashmap__size
> > > > > ...
> > > >
> > > > I think this will break bpf selftests which use hashmap,
> > > > we need to find some other way to include this
> > > >
> > > > either to use it from libbpf directly, or use the api version
> > > > only if the libbpf is not compiled in perf, we could use
> > > > following to detect that:
> > > >
> > > >       CFLAGS += -DHAVE_LIBBPF_SUPPORT
> > > >       $(call detected,CONFIG_LIBBPF)
> > >
> > > And have it in tools/perf/util/ instead?
>
> > *sigh*
>
> > $ make -C tools/testing/selftests/bpf test_hashmap
> > make: Entering directory
> > '/usr/local/google/home/irogers/kernel-trees/kernel.org/tip/tools/testing/s
> > elftests/bpf'
> >  BINARY   test_hashmap
> > /usr/bin/ld: /tmp/ccEGGNw5.o: in function `test_hashmap_generic':
> > /usr/local/google/home/irogers/kernel-trees/kernel.org/tip/tools/testing/selftests/bpf/test_hashmap.
> > c:61: undefined reference to `hashmap__new'
> > ...
>
> > My preference was to make hashmap a sharable API in tools, to benefit
>
> That is my preference as well, I'm not defending having it in
> tools/perf/util/, just saying that that is a possible way to make
> progress with the current situation...

Thanks, it'd be nice to be expedient as both Jiri and myself are
changing code in this area. v2 is up for review here:
https://lore.kernel.org/lkml/20200515165007.217120-8-irogers@google.com/
An ifdef when the hashmap.h is used, and one in the build. It could be worse.

Thanks,
Ian

> > not just perf but say things like libsymbol, libperf, etc. Moving it
> > into perf and using conditional compilation is kinda gross but having
> > libbpf tests depend on libapi also isn't ideal I guess. It is tempting
> > to just cut a hashmap from fresh cloth to avoid this and to share
> > among tools/. I don't know if the bpf folks have opinions?
> >
> > I'll do a v2 using conditional compilation to see how bad it looks.
>
> Cool, lets see how it looks.
>
> - Arnaldo
