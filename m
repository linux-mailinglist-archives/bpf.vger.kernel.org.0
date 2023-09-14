Return-Path: <bpf+bounces-9978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3E179FD8F
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 09:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22A2A1C20B58
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 07:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE8DCA49;
	Thu, 14 Sep 2023 07:56:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F4663B
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 07:56:09 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A561BF6
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 00:56:08 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9a645e54806so86009366b.0
        for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 00:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694678167; x=1695282967; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FgidRbiLjZXtMwFOAEuWtoMgs455ycqJMqd8DqI9IVc=;
        b=MWKxCUAPnxGy58tbDAzeAEwsGHACmz67h7yYxxB+JLVpAi2XFZKdu2FFJfx6fvWF3Y
         fG3LFjMNTQdRNDDWJtgRJNjpwgeVZGbkbDt4QEmoTjMqPzKu190Jx1Yx6whTKUgAoPvp
         I6OllIaB3ndIaHESwqB/2GelvEX4moWXy15DF3a2hirVhCk6SBFHMdIoXIaWsu3SRlwD
         VIC/z6b48D2bpi6dHbtAUUvigbY7W405tksoc5+JO9aePf/IFi/Tw9doQaS5sNOsWsj8
         NbA5T1+7RutzYgAJOaEO5ikYh+yF1z0DEEgaCLrXTmTNASz5RgHDUwcKgbrGGA+uW7z+
         KLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694678167; x=1695282967;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FgidRbiLjZXtMwFOAEuWtoMgs455ycqJMqd8DqI9IVc=;
        b=rAGAf3ZKgasb9+pQrXla6EOtZ84jgQA7nTvsZTX8l7Q/LBteHmVZfSpJteitTQPKH3
         qBBQmdlTzkmmkIhAiHUnLzov7TE8wluhkWNiGuUlVBrUQOb16CSjXbhBQkqSeD5GUR0j
         LR7XIc4fManNWjxxn0ELG9ilis24P9U0i0vexul+jdmggVPLy/VmriYppor/5+jiPV8I
         iMEglK0bBfdeT7XVeJ3bvSTuAo1awSdF3OntizyLJaGn92hF/7OZNdfYGrDLhJC9LS9N
         DELwWfjdnBtCsRYLKLzo+psGFDfWde2sF4nPTSYCoVeW7Hdb72kDcBuV6ytcNArDN9Yx
         rTzg==
X-Gm-Message-State: AOJu0YxxGC9GMNJenuiDTF5AotDcSS+6Rn6vWojT44oykICPAZa3Rlap
	QlvsBJ+JyGzWwcl5xSnLCRs=
X-Google-Smtp-Source: AGHT+IGn4LHwcnRViqO9HCknElDCVE0Jy5DT26sjVssgMoDO7vVLvTE+8O96nSqgtmRDhidzdMLoxg==
X-Received: by 2002:a17:907:7894:b0:9a1:edb0:2a89 with SMTP id ku20-20020a170907789400b009a1edb02a89mr3956404ejc.9.1694678166540;
        Thu, 14 Sep 2023 00:56:06 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id x8-20020a170906298800b0099bcb44493fsm623126eje.147.2023.09.14.00.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 00:56:06 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 14 Sep 2023 09:56:03 +0200
To: Song Liu <song@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, Hou Tao <houtao1@huawei.com>,
	bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Daniel Xu <dxu@dxuuu.xyz>
Subject: Re: [PATCHv2 bpf-next 8/9] selftests/bpf: Add test for recursion
 counts of perf event link kprobe
Message-ID: <ZQK8k9zi43J/v5aa@krava>
References: <20230907071311.254313-1-jolsa@kernel.org>
 <20230907071311.254313-9-jolsa@kernel.org>
 <CAPhsuW5uG9rAdnUCnMUy6EJhh8xU+2ARe-_bQApSD9_XekNvFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW5uG9rAdnUCnMUy6EJhh8xU+2ARe-_bQApSD9_XekNvFg@mail.gmail.com>

On Thu, Sep 07, 2023 at 11:55:27AM -0700, Song Liu wrote:
> On Thu, Sep 7, 2023 at 12:14 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding selftest that puts kprobe.multi on bpf_fentry_test1 that
> > calls bpf_kfunc_common_test kfunc which has 3 perf event kprobes
> > and 1 kprobe.multi attached.
> >
> > Because fprobe (kprobe.multi attach layear) does not have strict
> > recursion check the kprobe's bpf_prog_active check is hit for test2-5.
> >
> > Disabling this test for arm64, because there's no fprobe support yet.
> >
> > Acked-by: Hou Tao <houtao1@huawei.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Reviewed-and-tested-by: Song Liu <song@kernel.org>
> 
> With on nitpick below.
> 
> > ---
> >  tools/testing/selftests/bpf/DENYLIST.aarch64  |  1 +
> >  .../testing/selftests/bpf/prog_tests/missed.c | 51 +++++++++++++++++++
> >  .../bpf/progs/missed_kprobe_recursion.c       | 48 +++++++++++++++++
> >  3 files changed, 100 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/progs/missed_kprobe_recursion.c
> >
> > diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
> > index 7f768d335698..3f2187c049db 100644
> > --- a/tools/testing/selftests/bpf/DENYLIST.aarch64
> > +++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
> > @@ -15,3 +15,4 @@ fexit_test/fexit_many_args                       # fexit_many_args:FAIL:fexit_ma
> >  fill_link_info/kprobe_multi_link_info            # bpf_program__attach_kprobe_multi_opts unexpected error: -95
> >  fill_link_info/kretprobe_multi_link_info         # bpf_program__attach_kprobe_multi_opts unexpected error: -95
> >  fill_link_info/kprobe_multi_invalid_ubuff        # bpf_program__attach_kprobe_multi_opts unexpected error: -95
> > +missed/kprobe_recursion                          # missed_kprobe_recursion__attach unexpected error: -95 (errno 95)
> > diff --git a/tools/testing/selftests/bpf/prog_tests/missed.c b/tools/testing/selftests/bpf/prog_tests/missed.c
> > index fc674258c81f..f10dc9232b3f 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/missed.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/missed.c
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <test_progs.h>
> >  #include "missed_kprobe.skel.h"
> > +#include "missed_kprobe_recursion.skel.h"
> >
> >  /*
> >   * Putting kprobe on bpf_fentry_test1 that calls bpf_kfunc_common_test
> > @@ -40,8 +41,58 @@ static void test_missed_perf_kprobe(void)
> >         missed_kprobe__destroy(skel);
> >  }
> >
> > +static __u64 get_count(int fd)
> 
> nit: Probably rename it as get_missed_count() or get_missed().

right, I was thinking of that ;-) will change

thanks,
jirka

> 
> > +{
> > +       struct bpf_prog_info info = {};
> > +       __u32 len = sizeof(info);
> > +       int err;
> > +
> > +       err = bpf_prog_get_info_by_fd(fd, &info, &len);
> > +       if (!ASSERT_OK(err, "bpf_prog_get_info_by_fd"))
> > +               return (__u64) -1;
> > +       return info.recursion_misses;
> > +}
> [...]

