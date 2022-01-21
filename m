Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B5549597D
	for <lists+bpf@lfdr.de>; Fri, 21 Jan 2022 06:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348647AbiAUFgP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Jan 2022 00:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348639AbiAUFgO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Jan 2022 00:36:14 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B436C061574;
        Thu, 20 Jan 2022 21:36:14 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id i65so7893776pfc.9;
        Thu, 20 Jan 2022 21:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GE5TNu2f8uh1KqkgXFLXfRojZen3EAFTuFBKFaAEDmI=;
        b=O4HndrDB2hRWx29Z1BfOyNHzNOSAer2GSHwD8YLsxLgWdcJO/8EC77Y5/GWMoQ5aoR
         LGsy6IROTHYiLeM9O8ah47QWa0aFcDhaTVBNdmV6E1q4Y0dOZdrSYFtXDuteUPjctsRn
         ctaKhBUjZjnuqJK+vS5fogMmfLGxEtM7IshmtugoxMSFJMJvkp7vwCMBy7IJfzlysuXK
         i3EQFOXfd8RSLvjHV2bZAjmapoo4IfY1Lh8xAfQXHxxJelW13tAIJdFLWVF2kLSkk/m3
         5Cf8I0BQO83WAd9Crk79xHCU1CPVsd1OlN3HXNTchWqEdxrvzJldnE8rk0Bby1No9YLZ
         DO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GE5TNu2f8uh1KqkgXFLXfRojZen3EAFTuFBKFaAEDmI=;
        b=K821G0YyAps5/QgQj3R4whYFYjkFInL/3nG34gViNBUj47YYkSR95e6miDadBcjXr1
         p2gI2D2KXe+JoIosaURPo6HG0FAnqGW2m1/R5FwGDBfDTx11pxEPe35A8jS750d4gYTl
         ghDRvW01/drCkfi3Zg04fHDtf/CzSMs7qPggxZ9xoy5smG7ZGl2RM1Bu1yMo62kgWRHp
         iZmbeFL67RZAlVbUzMRkybQpYkdHESh7ROrgkGr8Jj/nw53vNXJLgvMwwvm9A3Mce+cH
         me5xEqSwU67wr0G679xd53XeTh6/cYshTc7SUNGq6ySiHWzlDZx6yp+4J3OupBr3X7mk
         gWoA==
X-Gm-Message-State: AOAM530s5aRYTBMQC1CdqQTKh9qiKLXM/G4m7jXGtsqBAxLSrU9IA/y/
        Ki4l/N9v0pVXv8P8HPnARum3BAS7Xkafia6jXjI=
X-Google-Smtp-Source: ABdhPJxeDwRZUVtWmv43Xg6rNL+1ItURx0ccupAgt2b22xmvS+nbHgzV1tha6ZKAFhZCzm0rJU2z5VyoMRw9kOzW4R0=
X-Received: by 2002:aa7:888d:0:b0:4c2:7965:950d with SMTP id
 z13-20020aa7888d000000b004c27965950dmr2598484pfe.46.1642743373935; Thu, 20
 Jan 2022 21:36:13 -0800 (PST)
MIME-Version: 1.0
References: <20220119014005.1209-1-zhudi2@huawei.com> <20220119014005.1209-2-zhudi2@huawei.com>
In-Reply-To: <20220119014005.1209-2-zhudi2@huawei.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 20 Jan 2022 21:36:02 -0800
Message-ID: <CAADnVQK7PphgAd_f0Z9=u8c9YztB2XO5gpyrB46xQG-P6Aipyg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 2/2] selftests: bpf: test BPF_PROG_QUERY for
 progs attached to sockmap
To:     Di Zhu <zhudi2@huawei.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        luzhihao@huawei.com, rose.chen@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 18, 2022 at 5:40 PM Di Zhu <zhudi2@huawei.com> wrote:
>
> Add test for querying progs attached to sockmap. we use an existing
> libbpf query interface to query prog cnt before and after progs
> attaching to sockmap and check whether the queried prog id is right.
>
> Signed-off-by: Di Zhu <zhudi2@huawei.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> ---
>  .../selftests/bpf/prog_tests/sockmap_basic.c  | 66 +++++++++++++++++++
>  .../bpf/progs/test_sockmap_progs_query.c      | 24 +++++++
>  2 files changed, 90 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_progs_query.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> index 85db0f4cdd95..1ab57cdc4ae4 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> @@ -8,6 +8,7 @@
>  #include "test_sockmap_update.skel.h"
>  #include "test_sockmap_invalid_update.skel.h"
>  #include "test_sockmap_skb_verdict_attach.skel.h"
> +#include "test_sockmap_progs_query.skel.h"
>  #include "bpf_iter_sockmap.skel.h"
>
>  #define TCP_REPAIR             19      /* TCP sock is under repair right now */
> @@ -315,6 +316,63 @@ static void test_sockmap_skb_verdict_attach(enum bpf_attach_type first,
>         test_sockmap_skb_verdict_attach__destroy(skel);
>  }
>
> +static __u32 query_prog_id(int prog_fd)
> +{
> +       struct bpf_prog_info info = {};
> +       __u32 info_len = sizeof(info);
> +       int err;
> +
> +       err = bpf_obj_get_info_by_fd(prog_fd, &info, &info_len);
> +       if (!ASSERT_OK(err, "bpf_obj_get_info_by_fd") ||
> +           !ASSERT_EQ(info_len, sizeof(info), "bpf_obj_get_info_by_fd"))
> +               return 0;
> +
> +       return info.id;
> +}
> +
> +static void test_sockmap_progs_query(enum bpf_attach_type attach_type)
> +{
> +       struct test_sockmap_progs_query *skel;
> +       int err, map_fd, verdict_fd, duration = 0;

The 'duration' is unused.
You should have seen a warning while compiling the selftests?

Anyway. I've fixed it while applying.
