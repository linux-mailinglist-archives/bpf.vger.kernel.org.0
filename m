Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16FA585408
	for <lists+bpf@lfdr.de>; Fri, 29 Jul 2022 18:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236366AbiG2Q5y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 12:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbiG2Q5x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 12:57:53 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817C189A56
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 09:57:52 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id os14so9567306ejb.4
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 09:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=p3gwaw+yRgVs/xs7YGkV+wHBuOXSG/Usf3le2gkqf5Y=;
        b=AxZuV3NYr0CgpambIUeuSN9CXf8TWYtddh9XBpeVYcbMlCuSOZPA+vhEoJDz2b60JQ
         9QqjvGGZdn1p58S9wm3o6QdVD4sC4DisTWlYJkgMt+DHlWSAeu7nU+dokya0X9PRFNGa
         LhnGGIJE9D/9n2ADrOlHt6vy39twS73SqB0hYZvrOWZng9JRGiM6cKzBSAsfvRcJ3GCN
         nTsjyKBb2MxEWpG/yPYELtytE2viTQT4UJdEVm2OCNU2CAxPbJ+EfK/OtlFaK7j3/xnb
         aMjTruxnK/2SicLvsfcjGSftVgmFKmLiC7UqPYBFGvdVK+YxnAxUkqxgEM+4HdhyiRpS
         h6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=p3gwaw+yRgVs/xs7YGkV+wHBuOXSG/Usf3le2gkqf5Y=;
        b=grKNW9ilCQg7focoGBJ/CVRpOgQQVNjc9NZqVTpxTvrP/FqkcXEqW9hqLgt9Vjnp1q
         G6CLv8UezNAsQFH5UGaxk5dwAU6AGgpyhT5NrTPyWaO3NUIZxu46B8rrdV63MkSgHfS+
         HwI5KciGzvo6UQGTsvm1Yz5tsY88gG2W2gYGsD0bKyVLYaLGIkbWaiQH+8x2dlhv1TQ+
         iuPJqt0JCRD3qw65cMlBMri4uegDwGHl6yLSshWMW3j2TwxnoV5c3q9af3nePaBlj2LJ
         Lj93bcK3W5yXE6kpjvobjaB271DohEB7+GRmughfgRUurjHIsh/94Mh87fRijwG2/Qik
         Bg5w==
X-Gm-Message-State: AJIora8LiIQKhcEE93U+sRCN54G1q4knOoKX074luZTd87bXceJbYAYJ
        q0HouRNzl1r5f0nGZI+EEj2gGsabKLok51dvNIo=
X-Google-Smtp-Source: AGRyM1s3t2ScvDLw4m/MVP8CFEP4C1BKBaV0MTXa7JipwL/Y9jSLIw+zKszrtViOuwcoOkvWWP377N5BvPIZQot+XEQ=
X-Received: by 2002:a17:907:75ef:b0:72b:2fd:1a92 with SMTP id
 jz15-20020a17090775ef00b0072b02fd1a92mr3575961ejc.745.1659113870744; Fri, 29
 Jul 2022 09:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <1658734261-4951-1-git-send-email-alan.maguire@oracle.com> <Yt/gmWx6gMIxLI5F@krava>
In-Reply-To: <Yt/gmWx6gMIxLI5F@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 29 Jul 2022 09:57:39 -0700
Message-ID: <CAEf4BzZbD2Kp5eQmRBKvoyS08TY0FCBFrBzrfdP+2oXrmBJHtw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: augment snprintf_btf tests with
 string overflow tests
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Fedor Tokarev <ftokarev@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, bpf <bpf@vger.kernel.org>
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

On Tue, Jul 26, 2022 at 5:40 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Mon, Jul 25, 2022 at 08:31:01AM +0100, Alan Maguire wrote:
> > add tests that verify bpf_snprintf_btf() behaviour with strings that
> >
> > - exactly fit the buffer (string size + null terminator == buffer_size)
> > - overrun the buffer (string size + null terminator == buffer size + 1)
> > - overrun the buffer (string size + null terminator == buffer size + 2)
> >
> > These tests require [1] ("bpf: btf: Fix vsnprintf return value check")
> >
> > ...which has not landed yet.
>
> patch looks good, but I have the test passing even without [1],
> it should fail, right?
>
>   #151     snprintf_btf:OK
>

The way that test is structured it's essentially impossible to
communicate a test failure back, as each subsequent test case
overrides common ret variable, if I understand it correctly.

Alan, can you please update the test to store results for each
individual test case separately, e.g., in an array?

Meanwhile I've applied that trivial fix from Fedor anyway.

> jirka
>
> >
> > [1] https://lore.kernel.org/bpf/20220711211317.GA1143610@laptop/
> >
> > Suggested-by: Jiri Olsa <jolsa@redhat.com>
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > ---
> >  .../selftests/bpf/progs/netif_receive_skb.c        | 41 ++++++++++++++++++++--
> >  1 file changed, 38 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/netif_receive_skb.c b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> > index 1d8918d..9fc48e4 100644
> > --- a/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> > +++ b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> > @@ -49,7 +49,7 @@ static int __strncmp(const void *m1, const void *m2, size_t len)
> >  }
> >

[...]
