Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CCA5F6D12
	for <lists+bpf@lfdr.de>; Thu,  6 Oct 2022 19:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbiJFRgp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Oct 2022 13:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbiJFRgZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Oct 2022 13:36:25 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8DAC34CE
        for <bpf@vger.kernel.org>; Thu,  6 Oct 2022 10:36:22 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a26so6189077ejc.4
        for <bpf@vger.kernel.org>; Thu, 06 Oct 2022 10:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ut/Xh3SB7u9oQh7dgUTEVyWr1UGV7BDzCuk5D7TUOxU=;
        b=LexChy/H8CdTpwiI0zpnOmlC3YOhgrzzfUgxP1aus8HJkWdtrWHGTx1NZfGe7bl4U7
         nV9aLPPOY7MOxWNp/dxQz2S7gb76ll+jQHksLyK/JfM442M0aqVGz2NY1KDJpmvSpbw7
         g4OBF7aMAVb9HFN2Awpgva9hZkosJgZ9UWb9ADflN3ypV0oDrLCb4sV7CmfYkuWAUasg
         yacFfEWOAfrA9LeV4uisN1HV6z8MnFlAtwbFXwactqRgGEtrc/J1Ngl+ZI2PJQ/H4Mj9
         SjF3U4vxHT0jjAYuliqY1s8B93yPQ+40iAMA196KVX5bZJl5eqWdWJC2BDJNWN4i8TtC
         kDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ut/Xh3SB7u9oQh7dgUTEVyWr1UGV7BDzCuk5D7TUOxU=;
        b=Ni5aoNTCLk6dCEXLUxFdXNFA+v006zzL6CoIU8HTMU4AO2lneyagllGHfwTQsUhnFt
         z5cx/fnvdvirKd9AM2vEX3KNUR2Zn1KMJfiUoNqCEeJJVYuuaww0ohbRd1N45VpMCrew
         vT93FrXksSQtc5mpFzSNSMKoVerrPSdKxsbsTrdgVx+KlEqXgtDrhGNawyroBQH80cP9
         rcLUIcWZirLGgAsK0LItIVjph5FdnN1xapPU1UxUa3SnXIVMJAzfRmQtayIJbN93IuW9
         j/8pcolqxep+kSdzp3VhvNv5OE5yuqeIotnRwnhUlAzbejHv9/JQC0Pkp36ZumFZUdT4
         VVrw==
X-Gm-Message-State: ACrzQf2LGxzbvNOwc1jZ3jfi2oA8DibpLfZP9q8akCaGUT95Rp9GT4zg
        FAv30fxUJ/F6ojmE6tYHN3BD4y+k01/H7TdAwH8=
X-Google-Smtp-Source: AMsMyM47zuNdUWuOQpMcWc+91YHK85OvgjObXnjZyXo6D0/KhqlAu/fJTs3Su8anAtY6zEYQRGaPLwdx8b6lAmbbNss=
X-Received: by 2002:a17:906:5a4c:b0:78c:c893:74e6 with SMTP id
 my12-20020a1709065a4c00b0078cc89374e6mr786980ejc.545.1665077780650; Thu, 06
 Oct 2022 10:36:20 -0700 (PDT)
MIME-Version: 1.0
References: <20221006083106.117987-1-jolsa@kernel.org> <a9e767e6-b8ce-ec1e-47dc-74abfe828713@linux.dev>
In-Reply-To: <a9e767e6-b8ce-ec1e-47dc-74abfe828713@linux.dev>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 6 Oct 2022 10:36:08 -0700
Message-ID: <CAEf4BzahD0UwnoRRMZYUQ+n1oGXd6Bwcm5mp2sAUG7SAokEHWQ@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next] selftests/bpf: Add missing bpf_iter_vma_offset__destroy
 call
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Jiri Olsa <jolsa@kernel.org>, Kui-Feng Lee <kuifeng@fb.com>,
        bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 6, 2022 at 10:21 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> On 10/6/22 1:31 AM, Jiri Olsa wrote:
> > Adding missing bpf_iter_vma_offset__destroy call and using in-skeletin
> > link pointer so we don't need extra bpf_link__destroy call.
> >
> > Fixes: b3e1331eb925 ("selftests/bpf: Test parameterized task BPF iterators.")
> > Cc: Kui-Feng Lee <kuifeng@fb.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >   v2 changes:
> >   - use in-skeletin link pointer and destroy call [Martin]
> >
> >   tools/testing/selftests/bpf/prog_tests/bpf_iter.c | 13 +++++++------
> >   1 file changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> > index 3369c5ec3a17..d4437a2bba28 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> > @@ -1498,7 +1498,6 @@ static noinline int trigger_func(int arg)
> >   static void test_task_vma_offset_common(struct bpf_iter_attach_opts *opts, bool one_proc)
> >   {
> >       struct bpf_iter_vma_offset *skel;
> > -     struct bpf_link *link;
> >       char buf[16] = {};
> >       int iter_fd, len;
> >       int pgsz, shift;
> > @@ -1513,11 +1512,13 @@ static void test_task_vma_offset_common(struct bpf_iter_attach_opts *opts, bool
> >               ;
> >       skel->bss->page_shift = shift;
> >
> > -     link = bpf_program__attach_iter(skel->progs.get_vma_offset, opts);
> > -     if (!ASSERT_OK_PTR(link, "attach_iter"))
> > -             return;
> > +     skel->links.get_vma_offset = bpf_program__attach_iter(skel->progs.get_vma_offset, opts);
> > +     if (!ASSERT_OK_PTR(skel->links.get_vma_offset, "attach_iter")) {
> > +             skel->links.get_vma_offset = NULL;
>
> Applied with this NULL assignment removed.  bpf_link__destroy() can handle err
> ptr.  Thanks.
>

It's even better, with libbpf 1.0 there is no err ptr, it's NULL on
error. So good call for removing this!

>
> > +             goto exit;
> > +     }
> >
> > -     iter_fd = bpf_iter_create(bpf_link__fd(link));
> > +     iter_fd = bpf_iter_create(bpf_link__fd(skel->links.get_vma_offset));
> >       if (!ASSERT_GT(iter_fd, 0, "create_iter"))
> >               goto exit;
> >
> > @@ -1535,7 +1536,7 @@ static void test_task_vma_offset_common(struct bpf_iter_attach_opts *opts, bool
> >       close(iter_fd);
> >
> >   exit:
> > -     bpf_link__destroy(link);
> > +     bpf_iter_vma_offset__destroy(skel);
> >   }
> >
> >   static void test_task_vma_offset(void)
>
