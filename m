Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F965F3CD0
	for <lists+bpf@lfdr.de>; Tue,  4 Oct 2022 08:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiJDGi3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Oct 2022 02:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiJDGi2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Oct 2022 02:38:28 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C942A96D
        for <bpf@vger.kernel.org>; Mon,  3 Oct 2022 23:38:27 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id iv17so8275149wmb.4
        for <bpf@vger.kernel.org>; Mon, 03 Oct 2022 23:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LGb3mHW7/8+coat4lZzlyNJAEvJrpj5ZeVBtzi56Qo8=;
        b=A5fQrb3AAiETAO68s6rb8SROBGsPq2ENPpaHzm0GKJVryhxXFKBbl0xM67SdT7WDvl
         W4zNlEj0RnNGPiLrhyuITo47lnimqo1MGiCMIOJEKJDYpNxGQS3nsc8Jp9PPcQE4rQqX
         OdCQR95uFOyNs+mDfOYw1R3NFElesbZYh+nKYQINUcECs1Yf2LjOKV41Y/vVBmPsW0d8
         WQt5kE6VPQjlruAQNVGEdY6ouANCESfuUZsl6SV0RpvmuWIJXwtbv39YPMxtGfPf902F
         /FF/uQRNRGZ3jFDTZn7lvqhlYQAr5Ot4Sz0xRWCTqDtOD9wkfoAv2dlWgZ0ym02iN1yr
         W/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGb3mHW7/8+coat4lZzlyNJAEvJrpj5ZeVBtzi56Qo8=;
        b=PL7HLuss2IuXtgTq8Oqmrz4mQbaC1iGLiQdMZC0OQe3NPeao8Tzou/ZRIiwwQ3Hxdn
         90aokAF5kUjx3wHitpL/RBT4z5zGDN2aLIB7dmfAafnsvs8VwM6wA4g+MQZTR6U/mqyJ
         /pdZtu6IrctWAR4I2t5reMD59LCBjcBOzd0T8gY93S8RIvsg0OwWcVEZN3lbyV+YZQse
         LrHGz3+k6Pp6wpQOuPnTczpQa7L9kugd9K5AnZ4/EoY6Ef57yx4qkka50zRDczFtjBSq
         AldPTrF4lqte9jIiKNMAbQ+9oabp4wW+AVUac+lJ+oZbkKnll4x+WyRUNCa7tGb062Wa
         SKCw==
X-Gm-Message-State: ACrzQf1xo0riOXtzoviVfVT071Q6BcTj3b2EhDSsucb8Bf15WDtxwzRF
        zvEADsR/RQalObx5oqNddqU=
X-Google-Smtp-Source: AMsMyM7pn6bb1MX7PbY77KmBaryydw29qANU4jm8TYxrIU7hg/z7L+SK8QvSf6NrDT+6zT3R6dYWdA==
X-Received: by 2002:a05:600c:3543:b0:3b4:ba45:9945 with SMTP id i3-20020a05600c354300b003b4ba459945mr8919213wmq.58.1664865505944;
        Mon, 03 Oct 2022 23:38:25 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id f11-20020a05600c154b00b003a3442f1229sm19722566wmg.29.2022.10.03.23.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 23:38:25 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 4 Oct 2022 08:38:23 +0200
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Kui-Feng Lee <kuifeng@fb.com>, bpf@vger.kernel.org,
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
Message-ID: <YzvU3/rwCnbWQM8P@krava>
References: <20221002151141.1074196-1-jolsa@kernel.org>
 <49aa0aec-a009-c0c3-cf47-11a6734aae36@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49aa0aec-a009-c0c3-cf47-11a6734aae36@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 03, 2022 at 05:12:44PM -0700, Martin KaFai Lau wrote:
> On 10/2/22 8:11 AM, Jiri Olsa wrote:
> > Adding missing bpf_iter_vma_offset__destroy call to
> > test_task_vma_offset_common function and related goto jumps.
> > 
> > Fixes: b3e1331eb925 ("selftests/bpf: Test parameterized task BPF iterators.")
> > Cc: Kui-Feng Lee <kuifeng@fb.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >   tools/testing/selftests/bpf/prog_tests/bpf_iter.c | 8 +++++---
> >   1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> > index 3369c5ec3a17..462fe92e0736 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> > @@ -1515,11 +1515,11 @@ static void test_task_vma_offset_common(struct bpf_iter_attach_opts *opts, bool
> >   	link = bpf_program__attach_iter(skel->progs.get_vma_offset, opts);
> 
> Thanks for the fix.
> 
> A nit.  Instead of adding a new goto label.  How about doing
> 
> 	skel->links.get_vma_offset = bpf_program_attach_iter(...)
> 
> and bpf_iter_vma_offset__destroy(skel) will take care of the link destroy.
> The earlier test_task_vma_common() is doing that also.

right, I forgot destroy would do that.. it'll be simpler change

thanks,
jirka

> 
> Kui-Feng, please also take a look.
> 
> >   	if (!ASSERT_OK_PTR(link, "attach_iter"))
> > -		return;
> > +		goto exit_skel;
> >   	iter_fd = bpf_iter_create(bpf_link__fd(link));
> >   	if (!ASSERT_GT(iter_fd, 0, "create_iter"))
> > -		goto exit;
> > +		goto exit_link;
> >   	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
> >   		;
> > @@ -1534,8 +1534,10 @@ static void test_task_vma_offset_common(struct bpf_iter_attach_opts *opts, bool
> >   	close(iter_fd);
> > -exit:
> > +exit_link:
> >   	bpf_link__destroy(link);
> > +exit_skel:
> > +	bpf_iter_vma_offset__destroy(skel);
> >   }
> >   static void test_task_vma_offset(void)
> 
