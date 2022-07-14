Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E177575048
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 16:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238604AbiGNOEs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 10:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239536AbiGNOEX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 10:04:23 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB8EF52
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 07:04:19 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 85A09240029
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 16:04:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1657807457; bh=+Iejk6zjmyB7Ku3EdMoEpviBalwkdZ4QP9iOgvS2wQU=;
        h=Date:From:To:Cc:Subject:From;
        b=BBP7MlKRclt6yts2/bEmie/epccrZtX8uL9qZxxDSbAOcW0OKNW7XFZMYn3HFPhO0
         3TgPS8HquoRDPPwYOhR2y+eNAQPF7pRfdjdXM1hHtOy0pa/IMwXWqhe+WfVAiD5MFQ
         fXdkYMxlbOqb6DR8/nTovMiP1RVe8tRibtbm2DHMj/Hr3jbLKoA/xSHl7i9LI0cfhN
         llJQkT7LURUF2wTh+4MoU7ygtCtOa1OXhUGs40TwZ+n+LiafWxGc+GLXEyiBc41aZZ
         9qbIC7/rr0pHMdHdo0OKoVnVwf+b7tRtVzcZblC5dGtMrZhKtrhmpQrQaJ4tIFKiLh
         bpfZ4okzo54nw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LkGSZ1hQPz9rxT;
        Thu, 14 Jul 2022 16:04:14 +0200 (CEST)
Date:   Thu, 14 Jul 2022 14:04:10 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Mykola Lysenko <mykolal@fb.com>
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: Integrate vmtest configs
Message-ID: <20220714140410.ccvmj2ib5reamdmg@nuc>
References: <20220712212124.3180314-1-deso@posteo.net>
 <20220712212124.3180314-3-deso@posteo.net>
 <CAEf4BzaK0H8MPSUQY-VLHuqMJtO1EE-4RpLAh=hRMCXN=dZBVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaK0H8MPSUQY-VLHuqMJtO1EE-4RpLAh=hRMCXN=dZBVw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 13, 2022 at 10:07:02PM -0700, Andrii Nakryiko wrote:
> On Tue, Jul 12, 2022 at 2:21 PM Daniel Müller <deso@posteo.net> wrote:
> >
> > This change integrates the configuration from the vmtest repository [0],
> > where it is currently used for testing kernel patches into the existing
> > configuration pulled in with an earlier patch. The result is a super set
> > of the configs from the two repositories.
> >
> > [0]: https://github.com/kernel-patches/vmtest/tree/831ee8eb72ddb7e03babb8f7e050d52a451237aa/travis-ci/vmtest/configs
> >
> > Signed-off-by: Daniel Müller <deso@posteo.net>
> > ---
> >  tools/testing/selftests/bpf/configs/denylist/DENYLIST-latest | 5 +++++
> >  .../selftests/bpf/configs/denylist/DENYLIST-latest.s390x     | 1 +
> >  2 files changed, 6 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/configs/denylist/DENYLIST-latest b/tools/testing/selftests/bpf/configs/denylist/DENYLIST-latest
> > index 939de574..ddf8a0c5 100644
> > --- a/tools/testing/selftests/bpf/configs/denylist/DENYLIST-latest
> > +++ b/tools/testing/selftests/bpf/configs/denylist/DENYLIST-latest
> > @@ -4,3 +4,8 @@ stacktrace_build_id_nmi
> >  stacktrace_build_id
> >  task_fd_query_rawtp
> >  varlen
> > +btf_dump/btf_dump: syntax
> > +kprobe_multi_test/bench_attach
> > +core_reloc/enum64val
> > +core_reloc/size___diff_sz
> > +core_reloc/type_based___diff_sz
> 
> I don't think any of these are necessary anymore. Some of them were
> due to nightly Clang was stale.
> 
> > diff --git a/tools/testing/selftests/bpf/configs/denylist/DENYLIST-latest.s390x b/tools/testing/selftests/bpf/configs/denylist/DENYLIST-latest.s390x
> > index e33cab..36574b0 100644
> > --- a/tools/testing/selftests/bpf/configs/denylist/DENYLIST-latest.s390x
> > +++ b/tools/testing/selftests/bpf/configs/denylist/DENYLIST-latest.s390x
> > @@ -63,5 +63,6 @@ bpf_cookie                               # failed to open_and_load program: -524
> >  xdp_do_redirect                          # prog_run_max_size unexpected error: -22 (errno 22)
> >  send_signal                              # intermittently fails to receive signal
> >  select_reuseport                         # intermittently fails on new s390x setup
> > +tc_redirect/tc_redirect_dtime            # very flaky
> 
> same for this, yes it's flaky, but this shouldn't be in this list (I'd
> rather people actually fix the flakiness, of course). These configs
> should be "known not working" test cases (e.g., like BPF
> trampoline-based for s390x, that feature is just not implemented). But
> flaky tests should go here, they should be ideally fixed and not be
> blessed officially to be ignored.

I can remove this change from the set. But really from my perspective
the entire patch set's concern is not with cleaning up any of the lists
-- it is about merging and integrating existing configuration from two
others repositories into this one, while preserving what has been done
and why in a way that can be followed when looking back at repository
histories.
My observation has been that at least on x86_64, none of the denied
tests caused actual failures when run. And yet, that is best cleaned up
subsequently if it were for me.

Thanks,
Daniel
