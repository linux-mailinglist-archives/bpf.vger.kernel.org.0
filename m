Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3915F6DD2
	for <lists+bpf@lfdr.de>; Thu,  6 Oct 2022 21:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbiJFTFE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Oct 2022 15:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbiJFTEw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Oct 2022 15:04:52 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB7625DA
        for <bpf@vger.kernel.org>; Thu,  6 Oct 2022 12:04:46 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z97so4151309ede.8
        for <bpf@vger.kernel.org>; Thu, 06 Oct 2022 12:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wMTk2qopNqLVn26YtaMYjpJUuA8JWYJIf+Cjeh4vu5I=;
        b=Eii67kz2Lcm3EdX4F8K1KhUvi+FItungoSGfVZImFnZyrnVp9zVBRwxpPBgn6vCLRq
         okBPsT7htQ+Erd6nF4hWw+1/XzRLOdRX/devu47yNxw1DNJHRTqE2Xtso5wGbQK57HvX
         cJ3iSXIQJ7pBhRdu/yCHPxTh6zXRu7zq3t7AUiMxhXONWGjp1YFK26b0ulcpc6fEnzcL
         62yBBjVm+ybm+qp08dS6vxGtwIUy5oAo8o3trVRoa1yffLqWGcUn0HpSegnSDC5FIzSk
         n97nUee0m3hVJqKmB08P7L2QiDTnMhN+cwVoIbwORYpEIeAheMA9S+nkaV2h4nq4XBNG
         VdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMTk2qopNqLVn26YtaMYjpJUuA8JWYJIf+Cjeh4vu5I=;
        b=6R2AZbwg82qaX1Zz2tk+Go21vcd1WdLkfZoMbDiMlsr90lF5aFbPUwAIWpsKNY1GEE
         XzUhWO275Eta52kkn1fNOKBTLYcT94zNUOvExe56sLC+ooRmTT9VLpmnQhOE5jf91wTY
         xX/hh+M5LbXZNz/yIlZVdBqH+vrJuYjFLpyaP6jwNy+tnUhGTXd9FL3+QlFEF83zM//N
         eRH7RWIZ9NI+uBgDQrW0/inpPxri473VyNFB/HXGh+TaJDfM8lOgIgP84FSkYPwxFAHY
         9MBU5fwuF7tGsWGJ6DE/hherEcl9+dtGvwt4sSGYrT4lrSMAMwM/7TjuB3qUK1bUUzr9
         SUNw==
X-Gm-Message-State: ACrzQf2cu5rlywa+4YkVy9undOwqg06p4qmvlxNYyqyJYvnkRLfjeDgP
        hU27+CvpXaX0dstThWoZbmc=
X-Google-Smtp-Source: AMsMyM6Kd5A12L0CW7/AKnHrBRFJmKvMfrP/dXruDNnVGpyIWdyKsyAPBG7gwbl0Hi8FBQZePbnd/g==
X-Received: by 2002:a05:6402:51cb:b0:459:f3f9:2a20 with SMTP id r11-20020a05640251cb00b00459f3f92a20mr1214338edd.74.1665083085197;
        Thu, 06 Oct 2022 12:04:45 -0700 (PDT)
Received: from krava ([83.240.62.156])
        by smtp.gmail.com with ESMTPSA id lb10-20020a170907784a00b0078ae0fb3d11sm108578ejc.54.2022.10.06.12.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 12:04:44 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 6 Oct 2022 21:04:42 +0200
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Kui-Feng Lee <kuifeng@fb.com>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCHv2 bpf-next] selftests/bpf: Add missing
 bpf_iter_vma_offset__destroy call
Message-ID: <Yz8myqU6xXtyFzv+@krava>
References: <20221006083106.117987-1-jolsa@kernel.org>
 <a9e767e6-b8ce-ec1e-47dc-74abfe828713@linux.dev>
 <CAEf4BzahD0UwnoRRMZYUQ+n1oGXd6Bwcm5mp2sAUG7SAokEHWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzahD0UwnoRRMZYUQ+n1oGXd6Bwcm5mp2sAUG7SAokEHWQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 06, 2022 at 10:36:08AM -0700, Andrii Nakryiko wrote:
> On Thu, Oct 6, 2022 at 10:21 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
> >
> > On 10/6/22 1:31 AM, Jiri Olsa wrote:
> > > Adding missing bpf_iter_vma_offset__destroy call and using in-skeletin
> > > link pointer so we don't need extra bpf_link__destroy call.
> > >
> > > Fixes: b3e1331eb925 ("selftests/bpf: Test parameterized task BPF iterators.")
> > > Cc: Kui-Feng Lee <kuifeng@fb.com>
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >   v2 changes:
> > >   - use in-skeletin link pointer and destroy call [Martin]
> > >
> > >   tools/testing/selftests/bpf/prog_tests/bpf_iter.c | 13 +++++++------
> > >   1 file changed, 7 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> > > index 3369c5ec3a17..d4437a2bba28 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> > > @@ -1498,7 +1498,6 @@ static noinline int trigger_func(int arg)
> > >   static void test_task_vma_offset_common(struct bpf_iter_attach_opts *opts, bool one_proc)
> > >   {
> > >       struct bpf_iter_vma_offset *skel;
> > > -     struct bpf_link *link;
> > >       char buf[16] = {};
> > >       int iter_fd, len;
> > >       int pgsz, shift;
> > > @@ -1513,11 +1512,13 @@ static void test_task_vma_offset_common(struct bpf_iter_attach_opts *opts, bool
> > >               ;
> > >       skel->bss->page_shift = shift;
> > >
> > > -     link = bpf_program__attach_iter(skel->progs.get_vma_offset, opts);
> > > -     if (!ASSERT_OK_PTR(link, "attach_iter"))
> > > -             return;
> > > +     skel->links.get_vma_offset = bpf_program__attach_iter(skel->progs.get_vma_offset, opts);
> > > +     if (!ASSERT_OK_PTR(skel->links.get_vma_offset, "attach_iter")) {
> > > +             skel->links.get_vma_offset = NULL;
> >
> > Applied with this NULL assignment removed.  bpf_link__destroy() can handle err
> > ptr.  Thanks.
> >
> 
> It's even better, with libbpf 1.0 there is no err ptr, it's NULL on
> error. So good call for removing this!

great, thanks :)

jirka

> 
> >
> > > +             goto exit;
> > > +     }
> > >
> > > -     iter_fd = bpf_iter_create(bpf_link__fd(link));
> > > +     iter_fd = bpf_iter_create(bpf_link__fd(skel->links.get_vma_offset));
> > >       if (!ASSERT_GT(iter_fd, 0, "create_iter"))
> > >               goto exit;
> > >
> > > @@ -1535,7 +1536,7 @@ static void test_task_vma_offset_common(struct bpf_iter_attach_opts *opts, bool
> > >       close(iter_fd);
> > >
> > >   exit:
> > > -     bpf_link__destroy(link);
> > > +     bpf_iter_vma_offset__destroy(skel);
> > >   }
> > >
> > >   static void test_task_vma_offset(void)
> >
