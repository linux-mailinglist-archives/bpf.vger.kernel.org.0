Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4AD5258CD
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 01:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359682AbiELX5v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 19:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359683AbiELX5v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 19:57:51 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF545AA67
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 16:57:48 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso6305036pjg.0
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 16:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c9svqcbssJcny2tvvFYGGOPVW1dmIGXy1RjFa/y8bxo=;
        b=fwul8VeM5XSeu1uAQxAlvP3iUU+AU0kCvhxqo4bcL16SQ8tc3UCLZvQlvk+awAbWDU
         fAkzTf5Cuwiv2Pkd/RtSxHzeKV2WjF+NCyxb0uzWHNxHGR8t+JqlKtZaTN1xnh7AbbDt
         hxsmqyL/OGG4FOd2SUZetZQxJ+vUduSOMk+1O7cRealytf6AXkHDhTRIvC+V59HSJcLG
         gOaOtTkHm4NUtRBmG3op2EqMZbH8PJxA+84SzNLEJOpguAn6Zv0cQuRNLl3RfOn1yKay
         fe/IFYBCIMkqfQuCXiOQuRN5czDdkxtSchwUjXMpIiRTOEChYi+xvQYmxkRPl8k/Wilj
         0Z6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c9svqcbssJcny2tvvFYGGOPVW1dmIGXy1RjFa/y8bxo=;
        b=oHxb+qvfLJ2MQWqRwJWdQuVKTgdPWz211jRxNVtsECMKj3WASDm1qBRDrVBDK6dlkY
         W4chVkJNwO3rWx2VDlq8scEMIGCJufffQrOWGIHG3MvYEwhZFHpJzepQu1g9Z3WSKuS6
         kKweuVEq2V+q+3pKFAi4Br8YMbT26rcxhLU4TMVY25ZN6/xOFMB7sroaFhOsqytHkEKO
         MoJck2uoVSwDEIowkX/rds23lX0eNf68h5LT8F0CO1N5d9kQFxKkLdoxrjRkajDdgi0c
         MDOmqwzULyPYnfbbfsFN+j4PWHJkFLwE9Xc4bXeHvROgcRbxKJ2OW7RoD6CBMwdkA/NJ
         fK0g==
X-Gm-Message-State: AOAM533K6adlOWEatwimpnAeNkZ7e5/wzZfOMXEEEwWeqEHL3PWJA1NM
        EbJVdTWi8nHen3QIlRPWN2Y=
X-Google-Smtp-Source: ABdhPJyD0uZfQ9BnoR2I+zhNYY0fSSQe0JGgb0JGx9zN87c0J20424oCoSgdNZgayImZbUH+eUTMXA==
X-Received: by 2002:a17:902:e742:b0:15e:9a7b:24c3 with SMTP id p2-20020a170902e74200b0015e9a7b24c3mr2173234plf.17.1652399868150;
        Thu, 12 May 2022 16:57:48 -0700 (PDT)
Received: from localhost ([157.51.2.229])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902a3c600b0015e8d4eb231sm454535plb.123.2022.05.12.16.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 16:57:47 -0700 (PDT)
Date:   Fri, 13 May 2022 05:28:28 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v2 3/4] selftests/bpf: Add negative C tests for
 kptrs
Message-ID: <20220512235828.pmzwufm7wzmqss42@apollo.legion>
References: <20220511194654.765705-1-memxor@gmail.com>
 <20220511194654.765705-4-memxor@gmail.com>
 <CAEf4BzZm2rVt3Xxahah4cDur3o1LtUU399KYe5+ZzOaDck+cGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZm2rVt3Xxahah4cDur3o1LtUU399KYe5+ZzOaDck+cGA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 12, 2022 at 08:38:16AM IST, Andrii Nakryiko wrote:
> On Wed, May 11, 2022 at 12:46 PM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > This uses the newly added SEC("?foo") naming to disable autoload of
> > programs, and then loads them one by one for the object and verifies
> > that loading fails and matches the returned error string from verifier.
> > This is similar to already existing verifier tests but provides coverage
> > for BPF C.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  .../selftests/bpf/prog_tests/map_kptr.c       |  87 +++-
> >  .../selftests/bpf/progs/map_kptr_fail.c       | 418 ++++++++++++++++++
> >  2 files changed, 504 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/testing/selftests/bpf/progs/map_kptr_fail.c
> >
>
> [...]
>
> > +
> > +static void test_map_kptr_success(void)
> >  {
> >         struct map_kptr *skel;
> >         int key = 0, ret;
> > @@ -35,3 +113,10 @@ void test_map_kptr(void)
> >
> >         map_kptr__destroy(skel);
> >  }
> > +
> > +void test_map_kptr(void)
> > +{
> > +       if (test__start_subtest("success"))
> > +               test_map_kptr_success();
> > +       test_map_kptr_fail();
>
> I think the intent for this was to be another subtest, right? Worth
> fixing in a follow up?
>

No, instead I am calling test__start_subtest inside it for each program name
that is failing, to make them the subtest. In that case, it should be alright?

> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/map_kptr_fail.c b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
> > new file mode 100644
> > index 000000000000..05e209b1b12a
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
> > @@ -0,0 +1,418 @@
>
> [...]

--
Kartikeya
