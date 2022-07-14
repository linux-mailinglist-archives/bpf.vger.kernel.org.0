Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030C0575567
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 20:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239595AbiGNSwA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 14:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240857AbiGNSvy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 14:51:54 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B6E5B064
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 11:51:53 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id l23so5036508ejr.5
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 11:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zkW/II/SrYuu0Vg8kqursnxmTsIfNkh3ckGBLaqMHac=;
        b=f4QRtPHVRj6Q+eWBjstnZ+xiFe9fkmvi6pDab0ueia/NmVHBAVrlWG+KdG5qWdgFPV
         xnmmfKcOsgSWnaHz9WaGtFmifG46t2ddRVDBwxpRiGXGDxc/hLIvc3ADZ2A9YvqlQ7Ml
         uKwzQAGh7yzOaZt3sov/XKr+ao8uxNNVgGQm6GcZzHdcYmgL8Qhs6KxIoOn4ztyiXkT0
         Ur9OpLTtGQGnpnNvDNn/hAYyHabwAc7ZE9d6e52eLzhdiaPl8RfT6FcIoJvA+x7XmTz0
         pRoct53W87R/X0IuR9k77+aUAeJBWeRZD47g0CWVVhxxt6nxB4AY9Bvw2jPCDX8RoLhd
         r8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zkW/II/SrYuu0Vg8kqursnxmTsIfNkh3ckGBLaqMHac=;
        b=iT4k69TFxPdqMU6L1K/Yxif4AFnF/HVflKT0yGw4tHzIlx1oP88t6oc+Z9MU03azy0
         mH2cmDF7QK5g+XdUOElrEOjSzl/mylflup6I42Jwo06V0KvvQKqTl1JlYm37Onb/RdxN
         TbvOo/9VN1bj87+PIprRV+KLZr/B9F5bvGfwPJz2qRslj10yRhvPnna6FWClmzDs8HF3
         tWIscedzV34geFYbvTl7xT9TxTjoj4gKwKEyjjM331T11GIXZcU6goFaH07MKdjxRolF
         T4ViI6lbSr4lu/Rr76ZPGst8qSKpdvIVcAi+bbNdapIEvVDyl6cNCPxpO2+hHasBN9A5
         4nNA==
X-Gm-Message-State: AJIora9U8VJxYhn8I9CK+nLAZLIJDRJzSYE6E1xaxWe8lpKcdaWyszM6
        o6Ihub4OTNb1IYyqkR+mqLoNXvkhHHoWfdmBaLo=
X-Google-Smtp-Source: AGRyM1vyAR7d+MD5ZTIfko+xUwseiXBoY1E2zwK/8z61kWnzyLQV6632dWQBgo+JYnwohSE7UpmZIn/gtIv1PaOK5ZI=
X-Received: by 2002:a17:906:3f51:b0:712:3945:8c0d with SMTP id
 f17-20020a1709063f5100b0071239458c0dmr10004225ejj.302.1657824712023; Thu, 14
 Jul 2022 11:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220712212124.3180314-1-deso@posteo.net> <20220712212124.3180314-3-deso@posteo.net>
 <CAEf4BzaK0H8MPSUQY-VLHuqMJtO1EE-4RpLAh=hRMCXN=dZBVw@mail.gmail.com> <20220714140410.ccvmj2ib5reamdmg@nuc>
In-Reply-To: <20220714140410.ccvmj2ib5reamdmg@nuc>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 14 Jul 2022 11:51:40 -0700
Message-ID: <CAEf4BzYkHYH+=XUBGQ42kPCv8onTYa_MLKz4kMgJiMZTWpreWQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: Integrate vmtest configs
To:     =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Mykola Lysenko <mykolal@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 14, 2022 at 7:04 AM Daniel M=C3=BCller <deso@posteo.net> wrote:
>
> On Wed, Jul 13, 2022 at 10:07:02PM -0700, Andrii Nakryiko wrote:
> > On Tue, Jul 12, 2022 at 2:21 PM Daniel M=C3=BCller <deso@posteo.net> wr=
ote:
> > >
> > > This change integrates the configuration from the vmtest repository [=
0],
> > > where it is currently used for testing kernel patches into the existi=
ng
> > > configuration pulled in with an earlier patch. The result is a super =
set
> > > of the configs from the two repositories.
> > >
> > > [0]: https://github.com/kernel-patches/vmtest/tree/831ee8eb72ddb7e03b=
abb8f7e050d52a451237aa/travis-ci/vmtest/configs
> > >
> > > Signed-off-by: Daniel M=C3=BCller <deso@posteo.net>
> > > ---
> > >  tools/testing/selftests/bpf/configs/denylist/DENYLIST-latest | 5 +++=
++
> > >  .../selftests/bpf/configs/denylist/DENYLIST-latest.s390x     | 1 +
> > >  2 files changed, 6 insertions(+)
> > >
> > > diff --git a/tools/testing/selftests/bpf/configs/denylist/DENYLIST-la=
test b/tools/testing/selftests/bpf/configs/denylist/DENYLIST-latest
> > > index 939de574..ddf8a0c5 100644
> > > --- a/tools/testing/selftests/bpf/configs/denylist/DENYLIST-latest
> > > +++ b/tools/testing/selftests/bpf/configs/denylist/DENYLIST-latest
> > > @@ -4,3 +4,8 @@ stacktrace_build_id_nmi
> > >  stacktrace_build_id
> > >  task_fd_query_rawtp
> > >  varlen
> > > +btf_dump/btf_dump: syntax
> > > +kprobe_multi_test/bench_attach
> > > +core_reloc/enum64val
> > > +core_reloc/size___diff_sz
> > > +core_reloc/type_based___diff_sz
> >
> > I don't think any of these are necessary anymore. Some of them were
> > due to nightly Clang was stale.
> >
> > > diff --git a/tools/testing/selftests/bpf/configs/denylist/DENYLIST-la=
test.s390x b/tools/testing/selftests/bpf/configs/denylist/DENYLIST-latest.s=
390x
> > > index e33cab..36574b0 100644
> > > --- a/tools/testing/selftests/bpf/configs/denylist/DENYLIST-latest.s3=
90x
> > > +++ b/tools/testing/selftests/bpf/configs/denylist/DENYLIST-latest.s3=
90x
> > > @@ -63,5 +63,6 @@ bpf_cookie                               # failed t=
o open_and_load program: -524
> > >  xdp_do_redirect                          # prog_run_max_size unexpec=
ted error: -22 (errno 22)
> > >  send_signal                              # intermittently fails to r=
eceive signal
> > >  select_reuseport                         # intermittently fails on n=
ew s390x setup
> > > +tc_redirect/tc_redirect_dtime            # very flaky
> >
> > same for this, yes it's flaky, but this shouldn't be in this list (I'd
> > rather people actually fix the flakiness, of course). These configs
> > should be "known not working" test cases (e.g., like BPF
> > trampoline-based for s390x, that feature is just not implemented). But
> > flaky tests should go here, they should be ideally fixed and not be
> > blessed officially to be ignored.
>
> I can remove this change from the set. But really from my perspective
> the entire patch set's concern is not with cleaning up any of the lists
> -- it is about merging and integrating existing configuration from two
> others repositories into this one, while preserving what has been done
> and why in a way that can be followed when looking back at repository
> histories.
> My observation has been that at least on x86_64, none of the denied
> tests caused actual failures when run. And yet, that is best cleaned up
> subsequently if it were for me.

My point is that we shouldn't add them to selftests/bpf first just to
clean up later. We can leave those custom additions as is in CI repos
(either way we need to allow repos to augment "default" configs/lists)
and clean that up there.

Generally, allow/deny lists in selftests/bpf should be "authoritative"
in the sense that we know that those tests are not supposed to work
(right now or at all), we can even teach test_progs to ignore those by
default (now that denylist is collocated with test_progs). Anything
that's flaky shouldn't be added there, flakiness should be eliminated.
With those flaky tests I added in libbpf CI I was the only one
suffering from them, so sometimes I opted to just blacklist them for
my own sanity.

But now we should all share this pain and work together on improving tests!=
 ;)

>
> Thanks,
> Daniel
