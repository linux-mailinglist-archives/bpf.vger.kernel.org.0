Return-Path: <bpf+bounces-11746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9687BE77B
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 19:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 205FC281A4C
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 17:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894B436AE2;
	Mon,  9 Oct 2023 17:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hB0h+e6T"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F72A3589C
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 17:13:36 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DE29D
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 10:13:34 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-5068b69f4aeso8467e87.0
        for <bpf@vger.kernel.org>; Mon, 09 Oct 2023 10:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696871612; x=1697476412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USZw0GHNuB175V2YHfKKNgurGef2WdvOjtdu3+1mZgo=;
        b=hB0h+e6T/0tE/OklbzBSaz3eVMxScbU2bH9nnAqrVgEbgeJdJiUGqbLFuHdOcQrGAO
         Q/oBOkqso6LTPd+6K4wnOC6X6oaJC5TdYVzmxDeA142cYiqSD6Sx3NGY2qaeZLRsdJ5X
         cfcJzatyBdDSkgEXwENGnSFvnsT5Rt1HA5xZLpidWc4Js5XAp+SFXW3R8bMwqU8D8wJ1
         8tfAoCgysxMx51d9UB6zwYr57NF0a1KYPU3pzOPCbCz0b+JNbFQEynt2ug9AJRFrQWe4
         9eWdRcgClUtZjRjELB9thN7VLvH8LkeBJxEi0kpQzwxs1XZL3tp0SIJ/IkdBFlLEVDmQ
         Kbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696871612; x=1697476412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=USZw0GHNuB175V2YHfKKNgurGef2WdvOjtdu3+1mZgo=;
        b=W+1lNxBXFi9DK2btuqsnk9DejfY+Q4nT+tOGhQQrGuYFqyndVw2+Mfgx2xRwUDP3KM
         hsieE+I6ET4JOhIQixXU29dRJkUkeOV4NrIADGXodOYYq5b+KnUlNHVHNio6X8qDbG/9
         aTABaRjgHLJSHQe6S+UigaFmb+9//+jhAeiDmbr8oe0Ze3l8mKfOWyvEr56lSpPt0WZb
         9T17NG6edMrwkx8PKzV+HyatIfcbHzUvaclW8QY00OuKvfSZTmCEpjmU21Aj0XHM3Qqd
         BWLa87xsIcGV/CM1cumJj0sq6V3KwLZOhl7NQUhikq2JfmO2rzPW3XqajjV72zqOqGx8
         Ynpw==
X-Gm-Message-State: AOJu0Yyi64TJxJEQ12tPv+0jeBghihrsH2TmpVm4VjxhZYadrH28Bu2i
	I29jt3rsdqaKHNFjjkg2LCm1zZfujI1O7TZOmntDag==
X-Google-Smtp-Source: AGHT+IGVsX4xfHStmDL+x1OifbyOceUXKJcxj4/NHb1DoOc5oXAK1xokifhDJ9++bokH9VsHXchQtCdyLgMwzO6fTxs=
X-Received: by 2002:ac2:558c:0:b0:502:cdb6:f316 with SMTP id
 v12-20020ac2558c000000b00502cdb6f316mr231818lfg.3.1696871612180; Mon, 09 Oct
 2023 10:13:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com> <20231005230851.3666908-18-irogers@google.com>
 <CAM9d7cj=au3DVNqA0OYU_9eu=R9kTz6SQrtfKuSGnrm=FAY=CA@mail.gmail.com>
In-Reply-To: <CAM9d7cj=au3DVNqA0OYU_9eu=R9kTz6SQrtfKuSGnrm=FAY=CA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Oct 2023 10:13:20 -0700
Message-ID: <CAP-5=fWtYPzGw0zvPd1VJc8RWi9cRQDg=ZF3Wjxf9yyY1QuPGA@mail.gmail.com>
Subject: Re: [PATCH v2 17/18] perf header: Fix various error path memory leaks
To: Namhyung Kim <namhyung@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Tom Rix <trix@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ming Wang <wangming01@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Yuan Can <yuancan@huawei.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	James Clark <james.clark@arm.com>, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Oct 8, 2023 at 11:57=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Oct 5, 2023 at 4:09=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > Memory leaks were detected by clang-tidy.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/header.c | 63 ++++++++++++++++++++++++----------------
> >  1 file changed, 38 insertions(+), 25 deletions(-)
> >
> > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > index d812e1e371a7..41b78e40b22b 100644
> > --- a/tools/perf/util/header.c
> > +++ b/tools/perf/util/header.c
> > @@ -2598,8 +2598,10 @@ static int process_cpu_topology(struct feat_fd *=
ff, void *data __maybe_unused)
> >                         goto error;
> >
> >                 /* include a NULL character at the end */
> > -               if (strbuf_add(&sb, str, strlen(str) + 1) < 0)
> > +               if (strbuf_add(&sb, str, strlen(str) + 1) < 0) {
> > +                       free(str);
> >                         goto error;
> > +               }
> >                 size +=3D string_size(str);
> >                 free(str);
> >         }
> > @@ -2617,8 +2619,10 @@ static int process_cpu_topology(struct feat_fd *=
ff, void *data __maybe_unused)
> >                         goto error;
> >
> >                 /* include a NULL character at the end */
> > -               if (strbuf_add(&sb, str, strlen(str) + 1) < 0)
> > +               if (strbuf_add(&sb, str, strlen(str) + 1) < 0) {
> > +                       free(str);
> >                         goto error;
> > +               }
> >                 size +=3D string_size(str);
> >                 free(str);
> >         }
> > @@ -2681,8 +2685,10 @@ static int process_cpu_topology(struct feat_fd *=
ff, void *data __maybe_unused)
> >                         goto error;
> >
> >                 /* include a NULL character at the end */
> > -               if (strbuf_add(&sb, str, strlen(str) + 1) < 0)
> > +               if (strbuf_add(&sb, str, strlen(str) + 1) < 0) {
> > +                       free(str);
> >                         goto error;
> > +               }
> >                 size +=3D string_size(str);
> >                 free(str);
> >         }
>
> For these cases, it'd be simpler to free it in the error path.

It was a slightly larger change to do it that way, but I'll alter it.
The issue is not getting a double free on str, which is most easily
handled by switching frees to zfrees.


>
>
> > @@ -2736,10 +2742,9 @@ static int process_numa_topology(struct feat_fd =
*ff, void *data __maybe_unused)
> >                         goto error;
> >
> >                 n->map =3D perf_cpu_map__new(str);
> > +               free(str);
> >                 if (!n->map)
> >                         goto error;
> > -
> > -               free(str);
> >         }
> >         ff->ph->env.nr_numa_nodes =3D nr;
> >         ff->ph->env.numa_nodes =3D nodes;
> > @@ -2913,10 +2918,10 @@ static int process_cache(struct feat_fd *ff, vo=
id *data __maybe_unused)
> >                 return -1;
> >
> >         for (i =3D 0; i < cnt; i++) {
> > -               struct cpu_cache_level c;
> > +               struct cpu_cache_level *c =3D &caches[i];
> >
> >                 #define _R(v)                                          =
 \
> > -                       if (do_read_u32(ff, &c.v))\
> > +                       if (do_read_u32(ff, &c->v))                    =
 \
> >                                 goto out_free_caches;                  =
 \
> >
> >                 _R(level)
> > @@ -2926,22 +2931,25 @@ static int process_cache(struct feat_fd *ff, vo=
id *data __maybe_unused)
> >                 #undef _R
> >
> >                 #define _R(v)                                   \
> > -                       c.v =3D do_read_string(ff);               \
> > -                       if (!c.v)                               \
> > -                               goto out_free_caches;
> > +                       c->v =3D do_read_string(ff);              \
> > +                       if (!c->v)                              \
> > +                               goto out_free_caches;           \
> >
> >                 _R(type)
> >                 _R(size)
> >                 _R(map)
> >                 #undef _R
> > -
> > -               caches[i] =3D c;
> >         }
> >
> >         ff->ph->env.caches =3D caches;
> >         ff->ph->env.caches_cnt =3D cnt;
> >         return 0;
> >  out_free_caches:
> > +       for (i =3D 0; i < cnt; i++) {
> > +               free(caches[i].type);
> > +               free(caches[i].size);
> > +               free(caches[i].map);
> > +       }
> >         free(caches);
> >         return -1;
> >  }
>
> Looks ok.
>
>
> > @@ -3585,18 +3593,16 @@ static int perf_header__adds_write(struct perf_=
header *header,
> >                                    struct feat_copier *fc)
> >  {
> >         int nr_sections;
> > -       struct feat_fd ff;
> > +       struct feat_fd ff =3D {
> > +               .fd  =3D fd,
> > +               .ph =3D header,
> > +       };
>
> I'm fine with this change.
>
>
> >         struct perf_file_section *feat_sec, *p;
> >         int sec_size;
> >         u64 sec_start;
> >         int feat;
> >         int err;
> >
> > -       ff =3D (struct feat_fd){
> > -               .fd  =3D fd,
> > -               .ph =3D header,
> > -       };
> > -
> >         nr_sections =3D bitmap_weight(header->adds_features, HEADER_FEA=
T_BITS);
> >         if (!nr_sections)
> >                 return 0;
> > @@ -3623,6 +3629,7 @@ static int perf_header__adds_write(struct perf_he=
ader *header,
> >         err =3D do_write(&ff, feat_sec, sec_size);
> >         if (err < 0)
> >                 pr_debug("failed to write feature section\n");
> > +       free(ff.buf);
>
> But it looks like false alarams.  Since the feat_fd has fd
> and no buf, it won't allocate the buffer in do_write() and
> just use __do_write_fd().  So no need to free the buf.

This code looks like it has had a half-done optimization applied to it
- why have >1 buffer? why are we making the code's life hard? In
__do_write_buf there is a test that can be true even when a buf is
provided:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/header.c?h=3Dperf-tools-next#n125
```
if (ff->size < new_size) {
        addr =3D realloc(ff->buf, new_size);
        if (!addr)
                return -ENOMEM;
        ff->buf =3D addr;
```
In the case clang-tidy (I'll put the analysis below) has determined
that new_size may be greater than size (I believe the intent in the
code is they both evaluate to 0) and this causes the memory leak being
fixed here. I'll add a TODO comment in v3 but things like 'buf' are
opaque and not intention revealing in the code, which makes any kind
of interpretation hard.

I think again this is a good signal that there is worthwhile
simplification/cleanup in this code.

Thanks,
Ian

```
tools/perf/util/header.c:3628:6: warning: Potential leak of memory
pointed to by 'ff.buf' [clang-analyzer-unix.Malloc]
        err =3D do_write(&ff, feat_sec, sec_size);
            ^
tools/perf/util/header.c:3778:9: note: Calling 'perf_session__do_write_head=
er'
        return perf_session__do_write_header(session, evlist, fd, true, fc)=
;
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/perf/util/header.c:3675:2: note: Loop condition is false.
Execution continues on line 3685
        evlist__for_each_entry(session->evlist, evsel) {
        ^
tools/perf/util/evlist.h:276:2: note: expanded from macro
'evlist__for_each_entry'
        __evlist__for_each_entry(&(evlist)->core.entries, evsel)
        ^
tools/perf/util/evlist.h:268:9: note: expanded from macro
'__evlist__for_each_entry'
        list_for_each_entry(evsel, list, core.node)
        ^
tools/include/linux/list.h:458:2: note: expanded from macro
'list_for_each_entry'
        for (pos =3D list_first_entry(head, typeof(*pos), member);        \
        ^
tools/perf/util/header.c:3687:2: note: Loop condition is false.
Execution continues on line 3711
        evlist__for_each_entry(evlist, evsel) {
        ^
tools/perf/util/evlist.h:276:2: note: expanded from macro
'evlist__for_each_entry'
        __evlist__for_each_entry(&(evlist)->core.entries, evsel)
        ^
tools/perf/util/evlist.h:268:9: note: expanded from macro
'__evlist__for_each_entry'
        list_for_each_entry(evsel, list, core.node)
        ^
tools/include/linux/list.h:458:2: note: expanded from macro
'list_for_each_entry'
        for (pos =3D list_first_entry(head, typeof(*pos), member);        \
        ^
tools/perf/util/header.c:3711:6: note: Assuming field 'data_offset' is
not equal to 0
        if (!header->data_offset)
            ^~~~~~~~~~~~~~~~~~~~
tools/perf/util/header.c:3711:2: note: Taking false branch
        if (!header->data_offset)
        ^
tools/perf/util/header.c:3715:6: note: 'at_exit' is true
        if (at_exit) {
            ^~~~~~~
tools/perf/util/header.c:3715:2: note: Taking true branch
        if (at_exit) {
        ^
tools/perf/util/header.c:3716:9: note: Calling 'perf_header__adds_write'
                err =3D perf_header__adds_write(header, evlist, fd, fc);
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/perf/util/header.c:3606:6: note: Assuming 'nr_sections' is not equal
 to 0
        if (!nr_sections)
            ^~~~~~~~~~~~
tools/perf/util/header.c:3606:2: note: Taking false branch
        if (!nr_sections)
        ^
tools/perf/util/header.c:3610:6: note: Assuming 'feat_sec' is not equal to
 NULL
        if (feat_sec =3D=3D NULL)
            ^~~~~~~~~~~~~~~~
tools/perf/util/header.c:3610:2: note: Taking false branch
        if (feat_sec =3D=3D NULL)
        ^
tools/perf/util/header.c:3618:2: note: Assuming 'feat' is < HEADER_FEAT_BIT=
S
        for_each_set_bit(feat, header->adds_features, HEADER_FEAT_BITS) {
        ^
tools/include/linux/bitops.h:54:7: note: expanded from macro 'for_each_set_=
bit'
             (bit) < (size);                                    \
             ^~~~~~~~~~~~~~
tools/perf/util/header.c:3618:2: note: Loop condition is true.
Entering loop body
        for_each_set_bit(feat, header->adds_features, HEADER_FEAT_BITS) {
        ^
tools/include/linux/bitops.h:53:2: note: expanded from macro 'for_each_set_=
bit'
        for ((bit) =3D find_first_bit((addr), (size));            \
        ^
tools/perf/util/header.c:3619:3: note: Taking true branch
                if (do_write_feat(&ff, feat, &p, evlist, fc))
                ^
tools/perf/util/header.c:3618:2: note: Assuming 'feat' is >=3D HEADER_FEAT_=
BITS
        for_each_set_bit(feat, header->adds_features, HEADER_FEAT_BITS) {
tools/include/linux/bitops.h:54:7: note: expanded from macro 'for_each_set_=
bit'
             (bit) < (size);                                    \
             ^~~~~~~~~~~~~~
tools/perf/util/header.c:3618:2: note: Loop condition is false.
Execution continues on line 3623
        for_each_set_bit(feat, header->adds_features, HEADER_FEAT_BITS) {
        ^
tools/include/linux/bitops.h:53:2: note: expanded from macro 'for_each_set_=
bit'
        for ((bit) =3D find_first_bit((addr), (size));            \
        ^
tools/perf/util/header.c:3628:8: note: Calling 'do_write'
        err =3D do_write(&ff, feat_sec, sec_size);
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/perf/util/header.c:141:6: note: Assuming field 'buf' is non-null
        if (!ff->buf)
            ^~~~~~~~
tools/perf/util/header.c:141:2: note: Taking false branch
        if (!ff->buf)
        ^
tools/perf/util/header.c:143:9: note: Calling '__do_write_buf'
        return __do_write_buf(ff, buf, size);
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/perf/util/header.c:117:6: note: Assuming the condition is false
        if (size + ff->offset > max_size)
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/perf/util/header.c:117:2: note: Taking false branch
        if (size + ff->offset > max_size)
        ^
tools/perf/util/header.c:120:9: note: Assuming the condition is true
        while (size > (new_size - ff->offset))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/perf/util/header.c:120:2: note: Loop condition is true.
Entering loop body
        while (size > (new_size - ff->offset))
        ^
tools/perf/util/header.c:120:9: note: Assuming the condition is false
        while (size > (new_size - ff->offset))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/perf/util/header.c:120:2: note: Loop condition is false.
Execution continues on line 122
        while (size > (new_size - ff->offset))
        ^
tools/perf/util/header.c:122:13: note: Assuming '_min1' is >=3D '_min2'
        new_size =3D min(max_size, new_size);
                   ^
tools/include/linux/kernel.h:53:2: note: expanded from macro 'min'
        _min1 < _min2 ? _min1 : _min2; })
        ^~~~~~~~~~~~~
tools/perf/util/header.c:122:13: note: '?' condition is false
        new_size =3D min(max_size, new_size);
                   ^
tools/include/linux/kernel.h:53:2: note: expanded from macro 'min'
        _min1 < _min2 ? _min1 : _min2; })
        ^
tools/perf/util/header.c:124:6: note: Assuming 'new_size' is > field 'size'
        if (ff->size < new_size) {
            ^~~~~~~~~~~~~~~~~~~
tools/perf/util/header.c:124:2: note: Taking true branch
        if (ff->size < new_size) {
        ^
tools/perf/util/header.c:125:10: note: Memory is allocated
                addr =3D realloc(ff->buf, new_size);
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
tools/perf/util/header.c:126:7: note: Assuming 'addr' is non-null
                if (!addr)
                    ^~~~~
tools/perf/util/header.c:126:3: note: Taking false branch
                if (!addr)
                ^
tools/perf/util/header.c:143:9: note: Returned allocated memory
        return __do_write_buf(ff, buf, size);
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/perf/util/header.c:3628:8: note: Returned allocated memory
        err =3D do_write(&ff, feat_sec, sec_size);
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/perf/util/header.c:3628:6: note: Potential leak of memory
pointed to by 'ff.buf'
        err =3D do_write(&ff, feat_sec, sec_size);
```


> Thanks,
> Namhyung
>
>
> >         free(feat_sec);
> >         return err;
> >  }
> > @@ -3630,11 +3637,11 @@ static int perf_header__adds_write(struct perf_=
header *header,
> >  int perf_header__write_pipe(int fd)
> >  {
> >         struct perf_pipe_file_header f_header;
> > -       struct feat_fd ff;
> > +       struct feat_fd ff =3D {
> > +               .fd =3D fd,
> > +       };
> >         int err;
> >
> > -       ff =3D (struct feat_fd){ .fd =3D fd };
> > -
> >         f_header =3D (struct perf_pipe_file_header){
> >                 .magic     =3D PERF_MAGIC,
> >                 .size      =3D sizeof(f_header),
> > @@ -3645,7 +3652,7 @@ int perf_header__write_pipe(int fd)
> >                 pr_debug("failed to write perf pipe header\n");
> >                 return err;
> >         }
> > -
> > +       free(ff.buf);
> >         return 0;
> >  }
> >
> > @@ -3658,11 +3665,12 @@ static int perf_session__do_write_header(struct=
 perf_session *session,
> >         struct perf_file_attr   f_attr;
> >         struct perf_header *header =3D &session->header;
> >         struct evsel *evsel;
> > -       struct feat_fd ff;
> > +       struct feat_fd ff =3D {
> > +               .fd =3D fd,
> > +       };
> >         u64 attr_offset;
> >         int err;
> >
> > -       ff =3D (struct feat_fd){ .fd =3D fd};
> >         lseek(fd, sizeof(f_header), SEEK_SET);
> >
> >         evlist__for_each_entry(session->evlist, evsel) {
> > @@ -3670,6 +3678,7 @@ static int perf_session__do_write_header(struct p=
erf_session *session,
> >                 err =3D do_write(&ff, evsel->core.id, evsel->core.ids *=
 sizeof(u64));
> >                 if (err < 0) {
> >                         pr_debug("failed to write perf header\n");
> > +                       free(ff.buf);
> >                         return err;
> >                 }
> >         }
> > @@ -3695,6 +3704,7 @@ static int perf_session__do_write_header(struct p=
erf_session *session,
> >                 err =3D do_write(&ff, &f_attr, sizeof(f_attr));
> >                 if (err < 0) {
> >                         pr_debug("failed to write perf header attribute=
\n");
> > +                       free(ff.buf);
> >                         return err;
> >                 }
> >         }
> > @@ -3705,8 +3715,10 @@ static int perf_session__do_write_header(struct =
perf_session *session,
> >
> >         if (at_exit) {
> >                 err =3D perf_header__adds_write(header, evlist, fd, fc)=
;
> > -               if (err < 0)
> > +               if (err < 0) {
> > +                       free(ff.buf);
> >                         return err;
> > +               }
> >         }
> >
> >         f_header =3D (struct perf_file_header){
> > @@ -3728,6 +3740,7 @@ static int perf_session__do_write_header(struct p=
erf_session *session,
> >
> >         lseek(fd, 0, SEEK_SET);
> >         err =3D do_write(&ff, &f_header, sizeof(f_header));
> > +       free(ff.buf);
> >         if (err < 0) {
> >                 pr_debug("failed to write perf header\n");
> >                 return err;
> > --
> > 2.42.0.609.gbb76f46606-goog
> >

