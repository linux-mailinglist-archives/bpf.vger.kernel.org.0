Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225ED63BB9A
	for <lists+bpf@lfdr.de>; Tue, 29 Nov 2022 09:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiK2Iai (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 03:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiK2I3v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 03:29:51 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A933654B24
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 00:29:35 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id bs21so20845731wrb.4
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 00:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+8COySKZpQAvzS/lyewaIOf440tgTZqOib36puKtDvQ=;
        b=huV7ApZYr05PgU3I3IiA5RuwzbRN0sfFTFMdBxV1TOj2kk6gHQ9YI64HuBH3aHCymn
         gJ2PFiImDBwIlDPbZoCU+ggKj3PM9zbXN3p2EiewKRov/Bj3Kzdm9RlFjiXOqjMbPP2Y
         vBnL0+fOCytIwQT/Oj3ALfIoIVw3bLOvWF9JmRSns7EBECLEVylxkC6JDFbJgZw1vkgz
         WQk4jVkqfi5+3jJxoutcC1OiQK9nubVxE4Ws7tZMIDUzcaW4UAJnaE0k05hu4ME05jhz
         UyXrOkhyvF4nLP5b0z0Cd+VGz20knCDzl7VWZW88+jX3L5OZxThniGHfoQHw/BK66T0x
         YJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8COySKZpQAvzS/lyewaIOf440tgTZqOib36puKtDvQ=;
        b=kN33UXir0oNhfXyxuJSCY9knBBRdTCBSPuyrjdK/kysX58DoR+BFpli+m5SgzenkEu
         WAh38vfn+YrkHFBDp/HbRYCz2x76uP90BogT7aqwBjLiWNk0i1zshuTB7qYbSIcTTpPQ
         FumOpC05yHy763LPOTPlprwjqknT40Mg/2xhz0UIK7k+ma5O/1QLOPdGgutrD8GS4+8p
         jv64Yr82UmUODucCok41Ekebfx9jGmoLyLNZD/cEiM5axR7bsydn/eyJhII52ByYGMvo
         Fr1k0+wDudBMBrJgGaSEcGrQI5/bV+xjWbCYWQ4xstbx5U4X/AYKDQSymyyqe18hYX83
         xXWw==
X-Gm-Message-State: ANoB5plmvXIgZBD1ZRVdPd8iKcfFx/SAIdylEbRti4n3tFnkapB9GCAQ
        SP5GY2UIMQIPj3W3uo7Etac=
X-Google-Smtp-Source: AA0mqf6VVjAd7bqqAhU9piXmeljX5xcCBd8+2x4J2+47f4gervY/QbKHSaG56OVnCbK9vXNomAcctw==
X-Received: by 2002:a5d:6e84:0:b0:22d:6ad5:bc0f with SMTP id k4-20020a5d6e84000000b0022d6ad5bc0fmr34870214wrz.115.1669710574041;
        Tue, 29 Nov 2022 00:29:34 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id he10-20020a05600c540a00b003cfa80443a0sm1169837wmb.35.2022.11.29.00.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 00:29:33 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 29 Nov 2022 09:29:31 +0100
To:     Hao Luo <haoluo@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCHv4 bpf-next 4/4] selftests/bpf: Add bpf_vma_build_id_parse
 task vma iterator test
Message-ID: <Y4XC6wxSflQUz9/p@krava>
References: <20221128132915.141211-1-jolsa@kernel.org>
 <20221128132915.141211-5-jolsa@kernel.org>
 <CA+khW7h_4GGGsyszYVfSKtbv0nnUSKc-_oCqXgsj=JQ9RaVy7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+khW7h_4GGGsyszYVfSKtbv0nnUSKc-_oCqXgsj=JQ9RaVy7A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 28, 2022 at 11:21:30AM -0800, Hao Luo wrote:
> On Mon, Nov 28, 2022 at 5:30 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding tests for using new bpf_vma_build_id_parse kfunc in task_vma
> > iterator program.
> >
> > On bpf program side the iterator filters test proccess and proper
> > vma by provided function pointer and reads its build id with the
> > new kfunc.
> >
> > On user side the test uses readelf to get test_progs build id and
> > compares it with the one read from iterator.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  .../selftests/bpf/prog_tests/bpf_iter.c       | 44 +++++++++++++++++++
> >  .../selftests/bpf/progs/bpf_iter_build_id.c   | 41 +++++++++++++++++
> >  2 files changed, 85 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_build_id.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> > index 6f8ed61fc4b4..b2cad9f70b32 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> > @@ -33,6 +33,9 @@
> <...>
> >
> > +static void test_task_vma_build_id(void)
> > +{
> > +       struct bpf_iter_build_id *skel;
> > +       char buf[BUILDID_STR_SIZE] = {};
> 
> Jiri, do you mean buf[BUILDID_STR_SIZE + 1]? I see you have
> buf[BUILDID_STR_SIZE] = 0; below.

ugh, that plus one ended up in the BUILDID_STR_SIZE define, will fix

> 
> > +       int iter_fd, len;
> > +       char *build_id;
> <...>
> > +
> > +       while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
> > +               ;
> 
> I think you need to pass 'buf + len' to read(), otherwise the last
> iteration will overwrite the content read from the previous
> iterations.

ok

> 
> > +       buf[BUILDID_STR_SIZE] = 0;
> > +
> > +       /* Read build_id via readelf to compare with iterator buf. */
> > +       if (!ASSERT_OK(read_self_buildid(&build_id), "read_buildid"))
> > +               goto exit;
> 
> We need to close iter_fd before going to exit.

right, will fix

thanks,
jirka

> 
> > +
> > +       ASSERT_STREQ(buf, build_id, "build_id_match");
> > +       ASSERT_GT(skel->data->size, 0, "size");
> > +
> > +       free(build_id);
> > +       close(iter_fd);
> > +exit:
> > +       bpf_iter_build_id__destroy(skel);
> > +}
> > +
> <...>
> > --
> > 2.38.1
> >
