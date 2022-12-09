Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF05D647F6D
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 09:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiLIIl3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Dec 2022 03:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiLIIl2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Dec 2022 03:41:28 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26274D5FA;
        Fri,  9 Dec 2022 00:41:26 -0800 (PST)
Received: from dggpeml500010.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NT4Ch072kzJp7F;
        Fri,  9 Dec 2022 16:37:52 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500010.china.huawei.com
 (7.185.36.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 9 Dec
 2022 16:40:50 +0800
From:   Xin Liu <liuxin350@huawei.com>
To:     <andrii.nakryiko@gmail.com>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <haoluo@google.com>,
        <john.fastabend@gmail.com>, <jolsa@kernel.org>,
        <kongweibin2@huawei.com>, <kpsingh@kernel.org>,
        <linux-kernel@vger.kernel.org>, <liuxin350@huawei.com>,
        <martin.lau@linux.dev>, <sdf@google.com>, <song@kernel.org>,
        <wuchangye@huawei.com>, <xiesongyang@huawei.com>,
        <yanan@huawei.com>, <yhs@fb.com>, <zhangmingyi5@huawei.com>
Subject: Re: [PATCH bpf-next] libbpf: Optimized return value in libbpf_strerror when errno is libbpf errno
Date:   Fri, 9 Dec 2022 16:40:47 +0800
Message-ID: <20221209084047.229525-1-liuxin350@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <CAEf4BzYV=tCDMOO8xYwNgpogyEo6dbfnAHyYKnf59rUeG5TNSw@mail.gmail.com>
References: <CAEf4BzYV=tCDMOO8xYwNgpogyEo6dbfnAHyYKnf59rUeG5TNSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500010.china.huawei.com (7.185.36.155)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed,  7 Dec 2022 6:31:34 PM Andrii Nakryiko wrote:
> On Wed, Dec 7, 2022 at 1:09 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> >
> > On 12/7/22 1:00 AM, Andrii Nakryiko wrote:
> > > On Mon, Dec 5, 2022 at 1:11 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
> > >>
> > >> On 12/3/22 10:37 AM, Xin Liu wrote:
> > >>> This is a small improvement in libbpf_strerror. When libbpf_strerror
> > >>> is used to obtain the system error description, if the length of the
> > >>> buf is insufficient, libbpf_sterror returns ERANGE and sets errno to
> > >>> ERANGE.
> > >>>
> > >>> However, this processing is not performed when the error code
> > >>> customized by libbpf is obtained. Make some minor improvements here,
> > >>> return -ERANGE and set errno to ERANGE when buf is not enough for
> > >>> custom description.
> > >>>
> > >>> Signed-off-by: Xin Liu <liuxin350@huawei.com>
> > >>> ---
> > >>>    tools/lib/bpf/libbpf_errno.c | 6 ++++++
> > >>>    1 file changed, 6 insertions(+)
> > >>>
> > >>> diff --git a/tools/lib/bpf/libbpf_errno.c b/tools/lib/bpf/libbpf_errno.c
> > >>> index 96f67a772a1b..48ce7d5b5bf9 100644
> > >>> --- a/tools/lib/bpf/libbpf_errno.c
> > >>> +++ b/tools/lib/bpf/libbpf_errno.c
> > >>> @@ -54,10 +54,16 @@ int libbpf_strerror(int err, char *buf, size_t size)
> > >>>
> > >>>        if (err < __LIBBPF_ERRNO__END) {
> > >>>                const char *msg;
> > >>> +             size_t msg_size;
> > >>>
> > >>>                msg = libbpf_strerror_table[ERRNO_OFFSET(err)];
> > >>>                snprintf(buf, size, "%s", msg);
> > >>>                buf[size - 1] = '\0';
> > >>> +
> > >>> +             msg_size = strlen(msg);
> > >>> +             if (msg_size >= size)
> > >>> +                     return libbpf_err(-ERANGE);
> > >>
> > >> Given this is related to libbpf_strerror_table[] where the error strings are known
> > >> lets do compile-time error instead. All callers should pass in a buffer of STRERR_BUFSIZE
> > >> size in libbpf.
> > >
> > > That sounds a bit too pessimistic?.. If the actual error message fits
> > > in the buffer, why return -ERANGE just because theoretically some
> > > error descriptions might fit?
> > >
> > > But I don't think we need to calculate strlen(). snprintf above
> > > returns the number of bytes required to print a full string, even if
> > > it was truncated. So just comparing snprintf's result to size should
> > > be enough.
> >
> > I meant sth like below. For example if we were to shrink STRERR_BUFSIZE down
> > to 32 for testing, you'd then get:
> 
> Sure, but I'm not sure why do we need to do this? Array of pointers to
> string will overall use less memory, as each string will take as much
> space as needed and no more.
> 
> I guess I'm missing which problem you are trying to solve. I believe
> Xin was addressing a concern of extern (to libbpf) callers not getting
> -ERANGE in cases when they provide too small a buffer, which is just a
> simple snprintf() use adjustment to be a proper fix.
> 
> >
> > # make libbpf_errno.o
> > gcc -g -O2 -std=gnu89 -Wbad-function-cast -Wdeclaration-after-statement -Wformat-security -Wformat-y2k -Winit-self -Wmissing-declarations -Wmissing-prototypes -Wnested-externs -Wno-system-headers -Wold-style-definition -Wpacked -Wredundant-decls -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wundef -Wwrite-strings -Wformat -Wno-type-limits -Wstrict-aliasing=3 -Wshadow -Wno-switch-enum -Werror -Wall -I. -I/home/darkstar/trees/bpf-next/tools/include -I/home/darkstar/trees/bpf-next/tools/include/uapi -fvisibility=hidden -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64    -c -o libbpf_errno.o libbpf_errno.c
> > libbpf_errno.c:27:31: error: initializer-string for array of chars is too long [-Werror]
> >     27 |  [ERRCODE_OFFSET(KVERSION)] = "'version' section incorrect or lost",
> >        |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > libbpf_errno.c:27:31: note: (near initialization for ‘libbpf_strerror_table[2]’)
> > libbpf_errno.c:31:29: error: initializer-string for array of chars is too long [-Werror]
> >     31 |  [ERRCODE_OFFSET(VERIFY)] = "Kernel verifier blocks program loading",
> >        |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > libbpf_errno.c:31:29: note: (near initialization for ‘libbpf_strerror_table[7]’)
> > libbpf_errno.c:34:31: error: initializer-string for array of chars is too long [-Werror]
> >     34 |  [ERRCODE_OFFSET(PROGTYPE)] = "Kernel doesn't support this program type",
> >        |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > libbpf_errno.c:34:31: note: (near initialization for ‘libbpf_strerror_table[10]’)
> > libbpf_errno.c:37:30: error: initializer-string for array of chars is too long [-Werror]
> >     37 |  [ERRCODE_OFFSET(NLPARSE)] = "Incorrect netlink message parsing",
> >        |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > libbpf_errno.c:37:30: note: (near initialization for ‘libbpf_strerror_table[13]’)
> > cc1: all warnings being treated as errors
> > make: *** [<builtin>: libbpf_errno.o] Error 1
> >
> >
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 2a82f49ce16f..2e5df1624f79 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -265,8 +265,6 @@ static void pr_perm_msg(int err)
> >                 buf);
> >   }
> >
> > -#define STRERR_BUFSIZE  128
> > -
> >   /* Copied from tools/perf/util/util.h */
> >   #ifndef zfree
> >   # define zfree(ptr) ({ free(*ptr); *ptr = NULL; })
> > diff --git a/tools/lib/bpf/libbpf_errno.c b/tools/lib/bpf/libbpf_errno.c
> > index 96f67a772a1b..2f03f861b8b6 100644
> > --- a/tools/lib/bpf/libbpf_errno.c
> > +++ b/tools/lib/bpf/libbpf_errno.c
> > @@ -21,7 +21,7 @@
> >   #define ERRCODE_OFFSET(c)     ERRNO_OFFSET(LIBBPF_ERRNO__##c)
> >   #define NR_ERRNO      (__LIBBPF_ERRNO__END - __LIBBPF_ERRNO__START)
> >
> > -static const char *libbpf_strerror_table[NR_ERRNO] = {
> > +static const char libbpf_strerror_table[NR_ERRNO][STRERR_BUFSIZE] = {
> >         [ERRCODE_OFFSET(LIBELF)]        = "Something wrong in libelf",
> >         [ERRCODE_OFFSET(FORMAT)]        = "BPF object format invalid",
> >         [ERRCODE_OFFSET(KVERSION)]      = "'version' section incorrect or lost",
> > diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> > index 377642ff51fc..d4dc4fe945a6 100644
> > --- a/tools/lib/bpf/libbpf_internal.h
> > +++ b/tools/lib/bpf/libbpf_internal.h
> > @@ -57,6 +57,8 @@
> >   #define ELF64_ST_VISIBILITY(o) ((o) & 0x03)
> >   #endif
> >
> > +#define STRERR_BUFSIZE 128
> > +
> >   #define BTF_INFO_ENC(kind, kind_flag, vlen) \
> >         ((!!(kind_flag) << 31) | ((kind) << 24) | ((vlen) & BTF_MAX_VLEN))
> >   #define BTF_TYPE_ENC(name, info, size_or_type) (name), (info), (size_or_type)

I also think it would be more appropriate to modify snprintf slightly
here to keep memory usage as low as possible, and I will submit an
optimized version of v2, thanks to Daniel and Andrii for their
suggestions.
