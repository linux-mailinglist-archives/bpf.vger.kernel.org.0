Return-Path: <bpf+bounces-4744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FBD74E9D2
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 11:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4D2A1C20C49
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 09:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43CB1774C;
	Tue, 11 Jul 2023 09:05:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659EC17723
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 09:05:55 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE71094
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 02:05:53 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-992f15c36fcso713988266b.3
        for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 02:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689066352; x=1691658352;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tOwJqqcL3h//feAVyfKZnaXYULeVHhWKYN6enE9C2Kk=;
        b=GiV7Kk+FXjaM4CtcVKna+x+eEQPJwLUM/Z5R6H/8ZGMsGKsizcuYpccOBe9hKgZdoS
         stAhrvnFb8pfrzdEbULR11r42hb8b7tFAVmKkaGVTN0rix2aw1IHUYYLytzsmhFylMBE
         jfbncklJRFluplxm93eaoKHpCvuGGpaptQ0ypF47Sq1aZgv4V3IkZEzUwRBRY1C7P/4I
         xNMtZxesEw8pN/w/ofq+FS/73jrOI4uMNm9Kaeg29TdRLfyXCwc+X8x+fI63aJroMY2h
         EqVuTXkBhHf9QeSwNMfzIPSXX6jug7Vk72qSqj5uKwpg6FH5YjzQVl1Lbyj2HdvjlYUL
         zBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689066352; x=1691658352;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tOwJqqcL3h//feAVyfKZnaXYULeVHhWKYN6enE9C2Kk=;
        b=Q4Tuzc5I9SpGcH58x0UBQy2oB+lk7mAy7EzCm9u8HgWNBnAhoc6d31uEVIdyfj+0SR
         kHzEEn6J2ukr18Jp5KjLJCnhPD3BbRLchuTKhbzw3DzykGPeS5u3TQpLlLunw3eByEsY
         uyGcUgh7OZlDQeTCo+huqqkHVP9tzQBVKIDZezMUaDzy0/U3SZmcRHEFbaGBy7sL442y
         xa3oKbbIqc7g37jFCD+kxmYRe/i/w5PpRcB6u1ChgXhp/gbPR4vu8RFWtvEAgWphtVij
         XnlH6yT6FtqOzVwfvljlrpnePsq/9MaRgxFw9qW527WDE+EU+BuH1tZLKe0Yd/FTmFzw
         UoaA==
X-Gm-Message-State: ABy/qLbrOp+oW6uqiurOuNmK2aRCWJwrd6jJFdlISgSPGiZLt++R6iTA
	Lb/XLZ1yzZO45zVRHv8ZRe4=
X-Google-Smtp-Source: APBJJlHAuhydGR4W/K4uS8C5oSjZNtyQkm3rIARFe8vw2RfKFU0vZwaBM/dsBXXJsTghpFk4Zz1KJw==
X-Received: by 2002:a17:906:7046:b0:992:ba2c:2e0c with SMTP id r6-20020a170906704600b00992ba2c2e0cmr12849433ejj.36.1689066352141;
        Tue, 11 Jul 2023 02:05:52 -0700 (PDT)
Received: from krava (net-109-116-206-239.cust.vodafonedsl.it. [109.116.206.239])
        by smtp.gmail.com with ESMTPSA id c3-20020a17090603c300b009931baa0d44sm891912eja.140.2023.07.11.02.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 02:05:51 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 11 Jul 2023 11:05:47 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv3 bpf-next 07/26] libbpf: Move elf_find_func_offset*
 functions to elf object
Message-ID: <ZK0ba6m98n3pHAcO@krava>
References: <20230630083344.984305-1-jolsa@kernel.org>
 <20230630083344.984305-8-jolsa@kernel.org>
 <CAEf4BzYa+Mok-Bj2E+9EbWGPtGaMTsZ=1_VkkGzGw3yrdr+G+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYa+Mok-Bj2E+9EbWGPtGaMTsZ=1_VkkGzGw3yrdr+G+g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 06, 2023 at 04:03:22PM -0700, Andrii Nakryiko wrote:
> On Fri, Jun 30, 2023 at 1:35 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding new elf object that will contain elf related functions.
> > There's no functional change.
> >
> > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/lib/bpf/Build        |   2 +-
> >  tools/lib/bpf/elf.c        | 198 +++++++++++++++++++++++++++++++++++++
> >  tools/lib/bpf/libbpf.c     | 186 +---------------------------------
> >  tools/lib/bpf/libbpf_elf.h |  11 +++
> >  4 files changed, 211 insertions(+), 186 deletions(-)
> >  create mode 100644 tools/lib/bpf/elf.c
> >  create mode 100644 tools/lib/bpf/libbpf_elf.h
> >
> > diff --git a/tools/lib/bpf/Build b/tools/lib/bpf/Build
> > index b8b0a6369363..2d0c282c8588 100644
> > --- a/tools/lib/bpf/Build
> > +++ b/tools/lib/bpf/Build
> > @@ -1,4 +1,4 @@
> >  libbpf-y := libbpf.o bpf.o nlattr.o btf.o libbpf_errno.o str_error.o \
> >             netlink.o bpf_prog_linfo.o libbpf_probes.o hashmap.o \
> >             btf_dump.o ringbuf.o strset.o linker.o gen_loader.o relo_core.o \
> > -           usdt.o zip.o
> > +           usdt.o zip.o elf.o
> > diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
> > new file mode 100644
> > index 000000000000..2b62b4af28ce
> > --- /dev/null
> > +++ b/tools/lib/bpf/elf.c
> > @@ -0,0 +1,198 @@
> > +// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> > +
> > +#include <libelf.h>
> > +#include <gelf.h>
> > +#include <fcntl.h>
> > +#include <linux/kernel.h>
> 
> do you know why we need linux/kernel.h include? is it to get __u32 and
> other typedefs?

it's for the ARRAY_SIZE macro

jirka

> 
> > +
> > +#include "libbpf_elf.h"
> > +#include "libbpf_internal.h"
> > +#include "str_error.h"
> > +
> > +#define STRERR_BUFSIZE  128
> > +
> 
> [...]

