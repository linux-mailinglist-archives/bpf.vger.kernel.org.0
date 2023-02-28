Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23DA6A621E
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 23:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjB1WHW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 17:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjB1WHV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 17:07:21 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D762F7BF
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 14:07:19 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id i3so12002269plg.6
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 14:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YRCOA+ylhY8BYizlMsPJIRnUep7ueVrntpLfbub6Ho8=;
        b=mEiI40fNyimk2yi3utKlVT4Y6/XfiZzMjf8IL7rx8OZsMKma/44lGsAnfhQMTGCIOg
         XwvFvk+ZnJmZe9+sdLNWPkH1TdM+I4pNgrG1evG8lyp0RSNhFvrtiSo6iMPFR5Acpwfy
         Gq9DjLyDHgC0vFM4FAJfYVG+okzSshZtjiOJSUFJJZMUJbnLm8ZnikUj0L5RaPwWgSMG
         uvZmyfdN0NiOFEtzPa+f8Wx053NjMRjhE1YFf8eOyqQTPSMHobAOoSptMdDuJvuJm2Ek
         fCsUiKusB2DxBsB5dssZ2d7zDkIjFa6Epeo3CDsDMsfBdVQ2wwKx4rzUqmq5HEg//qc5
         wJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRCOA+ylhY8BYizlMsPJIRnUep7ueVrntpLfbub6Ho8=;
        b=d7s2zjhnuAoO4eBuUb6Y/DotcXzq8NoducYIsWZ3KE4g1gZl29TWxG754EjjtQaP3h
         g6ukufJ5mb1Y4yhNKFsCaT7Oqdhom1EGwAReYjaD0SoyuH0PkADB3Zq5vQIbbSJ+l3gf
         ToIHJ5idja0Iojk3TOJaafgJ+h9b7+9W0ktM082dsrOQVMYfVqd6tb1VsYIGeEG152Sm
         Yt6rV2ZOKMSxKYXXGJQDAU2OamG5IjZ/R5QfqVYwkeZGSMehAUOrAZb4VjbY3H8ukTIN
         evL1NDQlSAxgy3TRCqanGINjoHSuWN25Ny+QCnvA+FDLx5yE7nIMyGqJuko7p8wlZ74q
         afNg==
X-Gm-Message-State: AO0yUKUD3DfZtjP40mf6sDyghVhGrJdcnstKboKJ4894Hg9eqyJT0gQh
        WPHs7Pofl/XABAtmjdgtYG4JQg==
X-Google-Smtp-Source: AK7set/jYgli/Hpbv8aT03CHshIOUH7bFyfP1JcTprKwyvrob0wmRB9dc55aO9ppjsNzZUynNOiyPQ==
X-Received: by 2002:a17:903:1ce:b0:19d:1f42:b018 with SMTP id e14-20020a17090301ce00b0019d1f42b018mr8426976plh.27.1677622038760;
        Tue, 28 Feb 2023 14:07:18 -0800 (PST)
Received: from dread.disaster.area (pa49-186-4-237.pa.vic.optusnet.com.au. [49.186.4.237])
        by smtp.gmail.com with ESMTPSA id bc7-20020a170902930700b0019aaccb665bsm6957404plb.245.2023.02.28.14.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 14:07:18 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pX87u-003HvY-Hh; Wed, 01 Mar 2023 09:07:14 +1100
Date:   Wed, 1 Mar 2023 09:07:14 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, bpf@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Namhyung Kim <namhyung@gmail.com>
Subject: Re: [RFC v2 bpf-next 0/9] mm/bpf/perf: Store build id in inode object
Message-ID: <20230228220714.GJ2825702@dread.disaster.area>
References: <20230228093206.821563-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228093206.821563-1-jolsa@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 28, 2023 at 10:31:57AM +0100, Jiri Olsa wrote:
> hi,
> this is RFC patchset for adding build id under inode's object.
> 
> The main change to previous post [1] is to use inode object instead of file
> object for build id data.

Please explain what a "build id" is, the use case for it, why we
need to store it in VFS objects, what threat model it is protecting
the system against, etc.

> 
> However.. ;-) while using inode as build id storage place saves some memory
> by keeping just one copy of the build id for all file instances, there seems
> to be another problem.

Yes, the problem being that we can cache hundreds of millions of
inodes in memory, and only a very small subset of them are going to
have open files associated with them. And an even smaller subset are
going to be mmapped.

So, in reality, this proposal won't save any memory at all - it
costs memory for every inode that is not currently being used as
a mmapped elf executable, right?

> The problem is that we read the build id when the file is mmap-ed.

Why? I'm completely clueless as to what this thing does or how it's
used....

> Which is fine for our use case,

Which is?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
