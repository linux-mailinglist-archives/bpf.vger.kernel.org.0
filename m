Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D50DE128442
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2019 23:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfLTWFK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Dec 2019 17:05:10 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44777 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfLTWFK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Dec 2019 17:05:10 -0500
Received: by mail-pg1-f193.google.com with SMTP id x7so5598233pgl.11;
        Fri, 20 Dec 2019 14:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1Eh3tLTfa9xKRZnK5smb8nRu2xTiAGH5NS4uJ3m/L/Y=;
        b=eU1XaGdlRacM82UubO8a2yDv6v2ZTsRCgUyxOZwtINc5LvKB3kI515/oTc13VZyd/T
         csCtlwfHSnkGaXw8feY080++xDiQxmNLLh93wM7JsOarna6QBWK58vMrPbMRYFz+hmRy
         UJBPfrErxdlrk5/llt1MpiOukqK+VFCI54QhPnsbX1xun18Ie+y33DtX+uUsKVUQ7pC9
         fxyg776u4jW69fXHivM00Z3vX6M9pNG1w6KHE6BuIeGokggmRDJLmhZTsl9hUgkmQ1C/
         cFV1hNqiH3WDB668tQnrybhyJE8t6NsIXLBDit39x4vReJJ8urPruXqWd5N4KQmnZiBI
         6I4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1Eh3tLTfa9xKRZnK5smb8nRu2xTiAGH5NS4uJ3m/L/Y=;
        b=NJhhEaYfnLzT6Qhiv5r8TEL0rR5GadiYDb36AAsfilBIg6UC245AHS5odysZqNV1vI
         gwGcPaaw1t7h9cRfQh6UxF9odWThsgZNYgl7N39sxtK+ygKOsPutQ8Sl7uc6/HbAbQYe
         EUmFg6LiBNRZn73Vu+uJ5WKB2xJY/A4cb9gvtrKUhVP3bskHythk07DhdwJ7I6hAczVD
         BOlOSaMMb8FbAqqfWmVsZ0ONhYNYvLihnKvlSx0cIUAqmULxXW0ylHUoegs1zXrJiTmJ
         A2y4Vr6fC+SkOxOhjSHvz1Nj3tfzcGdJm5xHbHQycAFAZl27jqe2DhKLEG125brW/wlt
         AZ6g==
X-Gm-Message-State: APjAAAWtfzbOU8vrHNmFTtbhKGJkNDK7K0fe6Hig50T3Bwz8UQ2KPAv3
        pOj5ZUDri2WreA1EOFmuMwBXw1vk
X-Google-Smtp-Source: APXvYqzX0S6vxuk1wo0C02S1wS6N1KQA6MeU4h/q98iJaEaS+pTfh5hBIILQRONK0eDnHs0hBjOesA==
X-Received: by 2002:a62:1548:: with SMTP id 69mr19001240pfv.239.1576879509927;
        Fri, 20 Dec 2019 14:05:09 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id u5sm13410174pfm.115.2019.12.20.14.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 14:05:09 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CB7B840CB9; Fri, 20 Dec 2019 19:05:06 -0300 (-03)
Date:   Fri, 20 Dec 2019 19:05:06 -0300
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libbpf: Fix build on read-only filesystems
Message-ID: <20191220220506.GC9076@kernel.org>
References: <20191220032558.3259098-1-namhyung@kernel.org>
 <CAEf4BzaZBSRK2M4LD-c12_2-QLa8+jpPs1E4nA9BNeUDskOMBQ@mail.gmail.com>
 <20191220204748.GA9076@kernel.org>
 <CAEf4BzZW+bDxkdmXBJrrCHqBP5UT1NLJJ7mXLNqc6eypRCib6Q@mail.gmail.com>
 <20191220215328.GB9076@kernel.org>
 <CAEf4BzZBnY0neQJQ=opaGTO5yMKWhqBB_YRE4QTTBNYBD-RF9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZBnY0neQJQ=opaGTO5yMKWhqBB_YRE4QTTBNYBD-RF9g@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Dec 20, 2019 at 02:00:48PM -0800, Andrii Nakryiko escreveu:
> On Fri, Dec 20, 2019 at 1:53 PM Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > Em Fri, Dec 20, 2019 at 01:45:52PM -0800, Andrii Nakryiko escreveu:
> > > On Fri, Dec 20, 2019 at 12:47 PM Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > > > Shouldn't this be applied to the current merge window since a behaviour
> > > > that people relied, i.e. using O= to generate the build in a separate
> > > > directory, since its not possible to use the source dir tree as it is
> > > > read-only is now broken, i.e. isn't this a regression?

> > > Sure, it can be applied against bpf as well, but selftests still need
> > > to be fixed first.

> > I guess this can be done on a separate patch? I.e. if the user doesn't
> > use selftests the only regression it will see is when trying to build
> > tools/perf using O=.

> > I think two patches is best, better granularity, do you see a strict
> > need for both to be in the same patch?
 
> Sure, it can be two separate patches, but they should go in together,
> otherwise selftests will be broken.

Sure, both have to be fixed :-)

- Arnaldo
