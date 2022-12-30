Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5941865982F
	for <lists+bpf@lfdr.de>; Fri, 30 Dec 2022 13:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbiL3M2e (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Dec 2022 07:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234992AbiL3M2b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Dec 2022 07:28:31 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8F2E0B9
        for <bpf@vger.kernel.org>; Fri, 30 Dec 2022 04:28:30 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id j8-20020a17090a3e0800b00225fdd5007fso11979005pjc.2
        for <bpf@vger.kernel.org>; Fri, 30 Dec 2022 04:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AmLp0HHgGWL7/8ThVO7qlzgQpdCgrc/e4BU39twwl5o=;
        b=YCjvDOWG+/INvJ696xZyzGkzht/0VZ0jxtVpzQQqvNnRKYKdrZRkmvM+arZLJjN3oA
         6CF6peywcvKZG4CNg1Vis34T4Z4Q8UqXw1Wb1cANHksjiv0C/Z8ehL/4gMnmWY6FtErO
         NLUSTyYZSaVakZ6+d9vNq4vpRifAOg795xhpzpcQedgian7cKysiRloHIP6gtWsyDGbo
         GBGALstptXKLT0acl5oOw48PKIt2yqeJjDHgmG30RImLNlczZcLGtBM5JdJSQQuprlgU
         a7wR83FuGfHTYxcO+5qX5lcyVeZdIqwfhIfIvZOsihrdGebj1ZRp5C3d804tn66BAwPk
         3feQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AmLp0HHgGWL7/8ThVO7qlzgQpdCgrc/e4BU39twwl5o=;
        b=ltEXFirkMRBYM7efyHKPxWSkl2lbkLYEW2w+NVS+1rLnun31XP5UeeniuS6oQAJT51
         FHNirlZodPrcwUuah+SqEl4q2ZGbG1YWG2ou4DYymT0tGgdrUzgUUDqNGlCq0czQEMaT
         6XTIdoYrB3KLOau/WVXhoLuOSMwDgefQTxnkujQNO+wxNyRJZ/2wueMvNT7Vf39Ad4/X
         WOd66pcIHYHiNdHnJroixHRQVsVCnoPsQeBkFFPb1EKhMNy6SPiyc8ivv+QZVGrttiK6
         LtjkFVJzTW7iFsplyQc+rPFFH04vGh3+BoRLiQcZZjlFzXg5Y89aZFZLtzc0y+gwNB+j
         2VHw==
X-Gm-Message-State: AFqh2kqJIoN58RJvI/D6Qz9XJLhqaNJVeh5QLFdZdoNg7J0bNU5wQYoF
        e8DWHlx9YVJ4pXYCiVEgKRrmXw==
X-Google-Smtp-Source: AMrXdXu+tAe2jvcpdwNLB+QyK+2fSUNtbpNccLnuKfZH+LC4mTsNn0AXn/9QS3BA7vDZ6YCNt4ffuQ==
X-Received: by 2002:a17:902:c942:b0:189:c93c:e5e6 with SMTP id i2-20020a170902c94200b00189c93ce5e6mr51604676pla.33.1672403309552;
        Fri, 30 Dec 2022 04:28:29 -0800 (PST)
Received: from leoy-yangtze.lan (n058152048149.netvigator.com. [58.152.48.149])
        by smtp.gmail.com with ESMTPSA id i6-20020a170902c94600b00189651e5c26sm14844203pla.236.2022.12.30.04.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 04:28:28 -0800 (PST)
Date:   Fri, 30 Dec 2022 20:28:21 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 1/2] libbpf: show error info about missing ".BTF"
 section
Message-ID: <Y67ZZT84OwjybzNM@leoy-yangtze.lan>
References: <20221217223509.88254-1-changbin.du@gmail.com>
 <20221217223509.88254-2-changbin.du@gmail.com>
 <Y5/eE+ds+e+k3VJO@leoy-yangtze.lan>
 <20221220013114.zkkxkqh7orahxbzh@mail.google.com>
 <Y6GdofET0gHQzRX6@leoy-yangtze.lan>
 <CAEf4Bzb_XOEoG9anNdzQVJRqd3G4yKJTSa9Dgc9xkMXqn-xdFg@mail.gmail.com>
 <Y6KDrELoIfPbh3VN@leoy-yangtze.lan>
 <20221230121020.boqhrujywruq3oi2@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221230121020.boqhrujywruq3oi2@mail.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 30, 2022 at 08:10:20PM +0800, Changbin Du wrote:
> On Wed, Dec 21, 2022 at 11:55:24AM +0800, Leo Yan wrote:
> > On Tue, Dec 20, 2022 at 04:13:13PM -0800, Andrii Nakryiko wrote:
> > 
> > [...]
> > 
> > > > > > > @@ -990,6 +990,7 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
> > > > > > >   err = 0;
> > > > > > >
> > > > > > >   if (!btf_data) {
> > > > > > > +         pr_warn("failed to find '%s' ELF section in %s\n", BTF_ELF_SEC, path);
> > > > > > >           err = -ENOENT;
> > > >
> > > > btf_parse_elf() returns -ENOENT when ELF file doesn't contain BTF
> > > > section, therefore, bpftool dumps error string "No such file or
> > > > directory".  It's confused that actually vmlinux is existed.
> > > >
> > > > I am wondering if we can use error -LIBBPF_ERRNO__FORMAT (or any
> > > > better choice?) to replace -ENOENT at here, this can avoid bpftool to
> > > > outputs "No such file or directory" in this case.
> > > 
> > > The only really meaningful error code would be -ESRCH, which
> > > strerror() will translate to "No such process", which is also
> > > completely confusing.
> > 
> > Or maybe -ENODATA (No data available) is a better choice?
> > 
> > Thanks,
> > Leo
> >
> Yan, will you have a patch for this suggestion?

You are welcome to send a patch, otherwise, I can cook one.

Thanks,
Leo
