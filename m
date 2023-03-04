Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6562E6AAD7E
	for <lists+bpf@lfdr.de>; Sun,  5 Mar 2023 00:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjCDX3m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Mar 2023 18:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCDX3l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 4 Mar 2023 18:29:41 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E177EB78
        for <bpf@vger.kernel.org>; Sat,  4 Mar 2023 15:29:40 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id u9so24457470edd.2
        for <bpf@vger.kernel.org>; Sat, 04 Mar 2023 15:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677972578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LpkIBjnr5/EwkhBIsfRsW3u5DuM68JXv11lM0LChGI=;
        b=Ohd1eZa6NfPDnVkXhRKKBZ7+AxlJuRAFvFYD/FucCNeaUMxIE6CYLWzNKdAxQ1rn0i
         KAjnWf2eVktAJYIo480dHToaXhUdyYtwj7Mx5M+Cyw6NGmh2tQYilQYpbp58QOu8y1rK
         5WUzLJFRBztXA+lVf2MFs3/dEusN1MNvUoWtEZssbySGm+OL35jSFSEMpGDD4e6w8/bL
         E50yiDCWf5naOczIJPCwU37ZHOi4jD9QwyZVXIzzPZCmt8juCA7TBAu9vh9Xx1vg0LEc
         AHIyEmcKh9soDm800YUqc7yB5O5cG1jzyxk53wFknBH3StAI9Gp3lJ1QNUIwkr+MEdAK
         qGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677972578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/LpkIBjnr5/EwkhBIsfRsW3u5DuM68JXv11lM0LChGI=;
        b=EQEsTCQitBSfDZELjy09FeSWskcgKQdO1v7YM3PVGyLD9wauQRQJdT4vmR/rO4Pmp8
         d6Eo0dGimmvrgYRc3uqWhUJYray7rKRnMbi5jof9QD+bIBHDXK7auaUsfk7dOU3ii8NE
         jiS8XknupIE5oLH9pwHIKpW3Rbv5DQ4WHCAYrFAQ+NcpYpTK2Jykm/KzNoQJM/rkA/Oh
         +Zor+QtK6uE8cnQj2DPVv8yeYBqor2ppW08kcm2lqH/mq/3lgsC3GoT6mwuEpXaTPhOy
         hwlOkWXo4emwuaFPFqyKu+4p7Ubtt2w6Jub9GnUgG91i88ANBUezsx9xB1cggTr2MH65
         /uOQ==
X-Gm-Message-State: AO0yUKUV6CSHHg0WuOEToSvx/qS90XPhZgSjNRrvkEwAlMshcY9jG/MH
        Juj8Srk2y0jdELXkTJpdlPylwLx3QpPqDBII7n0=
X-Google-Smtp-Source: AK7set8lrYLyy3QOVkLcNaNO69JhE+Ru7tK1G73ttQd4hPB0pJgIoljgpb6q5NkGGHzWBhXiM4IAGxFgAvPFRU3ZnU4=
X-Received: by 2002:a50:cd15:0:b0:4c1:1555:152f with SMTP id
 z21-20020a50cd15000000b004c11555152fmr3392536edi.5.1677972578114; Sat, 04 Mar
 2023 15:29:38 -0800 (PST)
MIME-Version: 1.0
References: <20230302235015.2044271-1-andrii@kernel.org> <20230302235015.2044271-17-andrii@kernel.org>
 <ZAOzjzkV0Rg1F810@krava>
In-Reply-To: <ZAOzjzkV0Rg1F810@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 4 Mar 2023 15:29:25 -0800
Message-ID: <CAEf4BzbpgV3PN4yX-BVLrq0HNXL_Ziyj12k2jYompsPyTKJqSg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 16/17] selftests/bpf: add iterators tests
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 4, 2023 at 1:09=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Thu, Mar 02, 2023 at 03:50:14PM -0800, Andrii Nakryiko wrote:
>
> SNIP
>
> > +
> > +SEC("raw_tp")
> > +__success
> > +int iter_pass_iter_ptr_to_subprog(const void *ctx)
> > +{
> > +     int arr1[16], arr2[32];
> > +     struct bpf_iter it;
> > +     int n, sum1, sum2;
> > +
> > +     MY_PID_GUARD();
> > +
> > +     /* fill arr1 */
> > +     n =3D ARRAY_SIZE(arr1);
> > +     bpf_iter_num_new(&it, 0, n);
> > +     fill(&it, arr1, n, 2);
> > +     bpf_iter_num_destroy(&it);
> > +
> > +     /* fill arr2 */
> > +     n =3D ARRAY_SIZE(arr2);
> > +     bpf_iter_num_new(&it, 0, n);
> > +     fill(&it, arr2, n, 10);
> > +     bpf_iter_num_destroy(&it);
> > +
> > +     /* sum arr1 */
> > +     n =3D ARRAY_SIZE(arr1);
> > +     bpf_iter_num_new(&it, 0, n);
> > +     sum1 =3D sum(&it, arr1, n);
> > +     bpf_iter_num_destroy(&it);
> > +
> > +     /* sum arr2 */
> > +     n =3D ARRAY_SIZE(arr2);
> > +     bpf_iter_num_new(&it, 0, n);
> > +     sum1 =3D sum(&it, arr2, n);

this should have been sum2, not sum1, mechanical mistake

> > +     bpf_iter_num_destroy(&it);
> > +
> > +     bpf_printk("sum1=3D%d, sum2=3D%d", sum1, sum2);
>
> got to remove this to compile it, debug leftover?

nope, sum1->sum2 typo, which wasn't caught because Dave's patch to
error out on uninitialized variable reads landed a bit later

I'll fix this in v2, of course.


>
> jirka
>
> > +
> > +     return 0;
> > +}
> > +
> > +char _license[] SEC("license") =3D "GPL";
>
> SNIP
