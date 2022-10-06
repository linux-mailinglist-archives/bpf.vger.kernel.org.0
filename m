Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9555F6157
	for <lists+bpf@lfdr.de>; Thu,  6 Oct 2022 09:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiJFHED (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Oct 2022 03:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiJFHEC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Oct 2022 03:04:02 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6998C478
        for <bpf@vger.kernel.org>; Thu,  6 Oct 2022 00:04:01 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id bg9-20020a05600c3c8900b003bf249616b0so400668wmb.3
        for <bpf@vger.kernel.org>; Thu, 06 Oct 2022 00:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NaaTbn1CR2YEnP+89f+c8EBKUBi7C4IyXLH7hSx1Ybk=;
        b=RGNELKueNHofJYO+aXloecLn08i6ZkA0kxZ8VzTIJA9hKvZ/DMHFE+zau5nqWBMPU3
         CbtI91qa6VHCrJLWwY7rYUwo3kbWCrHRX6HRmrB1lsI/bI+hDfeTHnvnRdfDNsNyPjco
         LxbEfZph5ZEJaHsLu1M49LxEG7YKORb6uFBO8gPoRevXTJNlkMY6cpAeU/9LUeNJIGYv
         hKU0tsDuT7506b4P6d4ZjuqQbEhP1+bFDu/bsU8zN51cNsT8FENj4eUIptJf3CFTqbnE
         XPeUFGnoKnFajpTp8mSk00q7xXyem2dqyisYj4/TdINC2yBuZLbIrz1NytXo+/pqzVzd
         ErVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NaaTbn1CR2YEnP+89f+c8EBKUBi7C4IyXLH7hSx1Ybk=;
        b=5Y2mDpRI1gFvVMBogmCV00pi34LGyUsA8rhiDn3d95zKoeSK+rcWYplZm0CAHSS7Xn
         AXJfFFAoLu1fdYvWqY22cnMmBLKrq9bECFsptprQvgbFeOQtO0LddGwIfBxdpypLfCh8
         RJ2KnA1K9C0wFWQW2xH8fLuaWAGV9POcEVH4KQnISIq7k4SHgOA9zNFwZeDnuViF/siA
         7F2pLbQ5zv0eerX0XOSG2oOAKICu12uaNDsTSNt8Y8aHXZMImbuJOTL7pMNPZoS8e60I
         OaUYAggYhV6h/OIjFkJFebe7kePo0bvGDZ0jsxVCqfZk/5y+Cahb6ac6OavO3ztYzPhW
         DTcw==
X-Gm-Message-State: ACrzQf1hurCDzmF/Pw1peXbYDwSUfahwVpZeDvpIIZZrGSBZT3NQ6S3Q
        665HpTpeKzoW2/MAOYxoKPc=
X-Google-Smtp-Source: AMsMyM67ywMGOy/uDb3k4/XGxiU9QM/Nioa/MpkPnoWPFnHOy3HigGvOyixCNc58f6bBT9x9jTpJRw==
X-Received: by 2002:a05:600c:548b:b0:3b5:95b:57d3 with SMTP id iv11-20020a05600c548b00b003b5095b57d3mr5839779wmb.153.1665039839844;
        Thu, 06 Oct 2022 00:03:59 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id k16-20020a5d5250000000b0022ca921dc67sm17169741wrc.88.2022.10.06.00.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 00:03:59 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 6 Oct 2022 09:03:56 +0200
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Kui-Feng Lee <kuifeng@fb.com>, bpf@vger.kernel.org,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add missing
 bpf_iter_vma_offset__destroy call
Message-ID: <Yz593OOQ+M91ERo5@krava>
References: <20221002151141.1074196-1-jolsa@kernel.org>
 <49aa0aec-a009-c0c3-cf47-11a6734aae36@linux.dev>
 <YzvU3/rwCnbWQM8P@krava>
 <YzwjQJurtyF6f0W1@krava>
 <CAEf4BzZay5mLX04C7Hk0xawpTvMMX+JXoRvh4_Z19DBoOnmFaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZay5mLX04C7Hk0xawpTvMMX+JXoRvh4_Z19DBoOnmFaw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 05, 2022 at 03:58:45PM -0700, Andrii Nakryiko wrote:
> On Tue, Oct 4, 2022 at 5:16 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Tue, Oct 04, 2022 at 08:38:23AM +0200, Jiri Olsa wrote:
> > > On Mon, Oct 03, 2022 at 05:12:44PM -0700, Martin KaFai Lau wrote:
> > > > On 10/2/22 8:11 AM, Jiri Olsa wrote:
> > > > > Adding missing bpf_iter_vma_offset__destroy call to
> > > > > test_task_vma_offset_common function and related goto jumps.
> > > > >
> > > > > Fixes: b3e1331eb925 ("selftests/bpf: Test parameterized task BPF iterators.")
> > > > > Cc: Kui-Feng Lee <kuifeng@fb.com>
> > > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > > ---
> > > > >   tools/testing/selftests/bpf/prog_tests/bpf_iter.c | 8 +++++---
> > > > >   1 file changed, 5 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> > > > > index 3369c5ec3a17..462fe92e0736 100644
> > > > > --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> > > > > +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> > > > > @@ -1515,11 +1515,11 @@ static void test_task_vma_offset_common(struct bpf_iter_attach_opts *opts, bool
> > > > >           link = bpf_program__attach_iter(skel->progs.get_vma_offset, opts);
> > > >
> > > > Thanks for the fix.
> > > >
> > > > A nit.  Instead of adding a new goto label.  How about doing
> > > >
> > > >     skel->links.get_vma_offset = bpf_program_attach_iter(...)
> > > >
> > > > and bpf_iter_vma_offset__destroy(skel) will take care of the link destroy.
> > > > The earlier test_task_vma_common() is doing that also.
> > >
> > > right, I forgot destroy would do that.. it'll be simpler change
> >
> > ugh actually no ;-) it's outside (of skeleton) link,
> > so it won't get closed in bpf_iter_vma_offset__destroy
> 
> Martin's point was that if you assign it to skel->links.get_vma_offset
> it will be closed by skeleton's destroy method. So let's do that?

ah ok, will send new version

thanks,
jirka
