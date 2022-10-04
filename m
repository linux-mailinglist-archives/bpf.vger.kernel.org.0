Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834665F42C9
	for <lists+bpf@lfdr.de>; Tue,  4 Oct 2022 14:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJDMQb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Oct 2022 08:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiJDMQ3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Oct 2022 08:16:29 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8321514D39
        for <bpf@vger.kernel.org>; Tue,  4 Oct 2022 05:16:28 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b4so14070052wrs.1
        for <bpf@vger.kernel.org>; Tue, 04 Oct 2022 05:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7BHyjWM2QrD+zmkIkqRu0I1BWlN+BArbBH2UhhYDsU4=;
        b=heSgCq2BNN/mQPQzUlmRHvTBUPwegSAvXz5tGIfe+Zqtse9mHj+EO8bDSmg1D30pc7
         2efdGJX84r+7XUSKsi7LMefnqISw3iDgCJAN78VUt5Jwfzdorh7tSTuCRjmk/mxuPt1L
         jfOMJZTCohg7g6uSzz5cUsT+oH4p7fa8DcJP8q/yeUdRGe6qy0IW5xV/iF7VtgJVNcT/
         ArjjsWYYzXb11D/NC/MOUWrSqkbBsomwnrPgWUb20ksAUzCLa+GZpFeqdVPdqqMEEywW
         lD8OvwtPDTXkh84RphQX9rygd3I84Q3ta4R9K9y6LGt2zZwgweAl1g/jIAN+FyWFOz+s
         fHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BHyjWM2QrD+zmkIkqRu0I1BWlN+BArbBH2UhhYDsU4=;
        b=mrUs1nzHU6T66SRB+a28N9d3Rwjv5xc6RKod659shQ6F96DA9RQz6josVmYILlLQlu
         0rPqPhtx7LxQEzgPTOyIeeEq1uX1+XUPMYI/vfq193iLPIpeG7Nntv13bMuJR4Ruiwgr
         E/s8ZKYc9wNCcIUZuDRpJ3YJQmf5POFMdTH5BVQfb9bUiZm6AdtaY2S5XheoYWke5mLe
         XOeHKHpMOzIqoWU6C8gp64tICdu3ttnFYo7PJ8ReKYWZBMolBEm+ourpFFQtcvfB60I9
         qtC4EFSHQTBJoOjzo/8urXLcfEIPgUDoC9Kn/KQPGTvMWjcLYxkjVYY/quTiMWUzeYd8
         VVsA==
X-Gm-Message-State: ACrzQf03kJ3rgruYIJ/+oCtm/AhXgSvppf8PiUZSqhNL6MHDmSgqxRlr
        jRiQKkZlIm3qlj/ay2LCSAA=
X-Google-Smtp-Source: AMsMyM6RNdseKJmEPUU/XKxHAraG2DZj04hrlJa8lfHu8tAiw0Ife4LuxpBoxtkqTzEM1ydI6tJmnA==
X-Received: by 2002:a5d:598a:0:b0:22e:5503:9c42 with SMTP id n10-20020a5d598a000000b0022e55039c42mr1259008wri.551.1664885786920;
        Tue, 04 Oct 2022 05:16:26 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id q5-20020a05600c2e4500b003b50428cf66sm13940068wmf.33.2022.10.04.05.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 05:16:26 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 4 Oct 2022 14:16:24 +0200
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
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
Message-ID: <YzwjQJurtyF6f0W1@krava>
References: <20221002151141.1074196-1-jolsa@kernel.org>
 <49aa0aec-a009-c0c3-cf47-11a6734aae36@linux.dev>
 <YzvU3/rwCnbWQM8P@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzvU3/rwCnbWQM8P@krava>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 04, 2022 at 08:38:23AM +0200, Jiri Olsa wrote:
> On Mon, Oct 03, 2022 at 05:12:44PM -0700, Martin KaFai Lau wrote:
> > On 10/2/22 8:11 AM, Jiri Olsa wrote:
> > > Adding missing bpf_iter_vma_offset__destroy call to
> > > test_task_vma_offset_common function and related goto jumps.
> > > 
> > > Fixes: b3e1331eb925 ("selftests/bpf: Test parameterized task BPF iterators.")
> > > Cc: Kui-Feng Lee <kuifeng@fb.com>
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >   tools/testing/selftests/bpf/prog_tests/bpf_iter.c | 8 +++++---
> > >   1 file changed, 5 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> > > index 3369c5ec3a17..462fe92e0736 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> > > @@ -1515,11 +1515,11 @@ static void test_task_vma_offset_common(struct bpf_iter_attach_opts *opts, bool
> > >   	link = bpf_program__attach_iter(skel->progs.get_vma_offset, opts);
> > 
> > Thanks for the fix.
> > 
> > A nit.  Instead of adding a new goto label.  How about doing
> > 
> > 	skel->links.get_vma_offset = bpf_program_attach_iter(...)
> > 
> > and bpf_iter_vma_offset__destroy(skel) will take care of the link destroy.
> > The earlier test_task_vma_common() is doing that also.
> 
> right, I forgot destroy would do that.. it'll be simpler change

ugh actually no ;-) it's outside (of skeleton) link,
so it won't get closed in bpf_iter_vma_offset__destroy

the earlier test_task_vma_common does not create such link

jirka

> 
> thanks,
> jirka
> 
> > 
> > Kui-Feng, please also take a look.
> > 
> > >   	if (!ASSERT_OK_PTR(link, "attach_iter"))
> > > -		return;
> > > +		goto exit_skel;
> > >   	iter_fd = bpf_iter_create(bpf_link__fd(link));
> > >   	if (!ASSERT_GT(iter_fd, 0, "create_iter"))
> > > -		goto exit;
> > > +		goto exit_link;
> > >   	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
> > >   		;
> > > @@ -1534,8 +1534,10 @@ static void test_task_vma_offset_common(struct bpf_iter_attach_opts *opts, bool
> > >   	close(iter_fd);
> > > -exit:
> > > +exit_link:
> > >   	bpf_link__destroy(link);
> > > +exit_skel:
> > > +	bpf_iter_vma_offset__destroy(skel);
> > >   }
> > >   static void test_task_vma_offset(void)
> > 
