Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F0F65E111
	for <lists+bpf@lfdr.de>; Thu,  5 Jan 2023 00:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbjADXoP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 18:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjADXoO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 18:44:14 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7521742E0B
        for <bpf@vger.kernel.org>; Wed,  4 Jan 2023 15:44:13 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d3so37655653plr.10
        for <bpf@vger.kernel.org>; Wed, 04 Jan 2023 15:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o0s4bhIBs/CDqaIR6RfsZp4JL26iEUXvjVACRUOFPVs=;
        b=je6zfK5bxvu075mTuO8IxZaYVLFmx2JnwZxmWlYx2ixZpffJaR1vTD08cli7naYa3w
         j11eXjPdkpECdJ/4J10T0NBRFYU1Dd0Az8S0L8O7uMr/7CGuP9Le7Jn2MDStQmUEfnrL
         o3Al2Nwi1XGa1c8OEsSkis/JaPm06PvKixzQLI5kTN71Xdx4p33gnf6zbol/+ZwvVhfK
         4wouZFEIVEuqCzcuKmC1XqLtDiqkCwTgFSPBMuNdQAkSHMVuW9v+KL3Pw6kaxmbjHJE2
         9LjbaXLEcaH4D49zuONuJvREn1jebX61Dae6P26XU0gVQC/RaTwVP+aOuQqECHXOgadZ
         mjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o0s4bhIBs/CDqaIR6RfsZp4JL26iEUXvjVACRUOFPVs=;
        b=vYJ2uclsj2eM/D8WpQURUYrCGW7awkyjwQbMYvTAvbfm1uFfnQ43Gx4MCbe/gh9u6G
         DpLzxAml7Yz568mCqzHV4sP+K2GP7huBDiijmDQSyoVJDwh3xFGe3MhPot7qi5/eXGrU
         nSxTGaXGHQhHofSTRd1Vn+8AURU1U3stDovfFZ5hgWth9rN6rdwh+Rw65BIg584qugUy
         l5bzok0aekV4cR7F6VDhWG3x7APbPECkLyiPaICa8B6ibmlTt5ki7Zc+Sqojq/ZEX+A3
         nGkNg4QDgLVzAGSI1bsSKBudzj1uWbdloDt9/izTYtIzJSFPnkHzur7pW+YMGp1WiR9U
         WciQ==
X-Gm-Message-State: AFqh2kpg3hvsGMfiN/v87Hcmw8C1Z7z+ECe0ex5LYQH7a3lu7FQZ9FVq
        ybASnHiqBXCy4uuwjr6L9TtYhFT+7fEd4MQ6Bt31LQ==
X-Google-Smtp-Source: AMrXdXvBKnpZSJMpkb0XgAtEU+25Pn1NI2AAUaQ5amPHI3uWJ+dPFHjAd6q4/alrZdOd6Qw/y6iyWHTWMIoAY8IWrZ0=
X-Received: by 2002:a17:902:b20d:b0:191:283d:612e with SMTP id
 t13-20020a170902b20d00b00191283d612emr2429644plr.88.1672875852798; Wed, 04
 Jan 2023 15:44:12 -0800 (PST)
MIME-Version: 1.0
References: <20230104121744.2820-1-magnus.karlsson@gmail.com>
 <20230104121744.2820-12-magnus.karlsson@gmail.com> <CAEf4BzYawc4dgjMsUQYKPEECm=qtytktGzzSnrECz56FSVgcRg@mail.gmail.com>
In-Reply-To: <CAEf4BzYawc4dgjMsUQYKPEECm=qtytktGzzSnrECz56FSVgcRg@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 4 Jan 2023 15:44:01 -0800
Message-ID: <CAKH8qBvhnYLA5FpKtZ5JPp3LdJ5oCc=hA=4uD=yaDQ761ZRPpg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 11/15] selftests/xsk: get rid of built-in XDP program
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Magnus Karlsson <magnus.karlsson@gmail.com>,
        magnus.karlsson@intel.com, bjorn@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org,
        maciej.fijalkowski@intel.com, bpf@vger.kernel.org, yhs@fb.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
        jolsa@kernel.org, tirthendu.sarkar@intel.com,
        jonathan.lemon@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 4, 2023 at 3:15 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Jan 4, 2023 at 4:19 AM Magnus Karlsson
> <magnus.karlsson@gmail.com> wrote:
> >
> > From: Magnus Karlsson <magnus.karlsson@intel.com>
> >
> > Get rid of the built-in XDP program that was part of the old libbpf
> > code in xsk.c and replace it with an eBPF program build using the
> > framework by all the other bpf selftests. This will form the base for
> > adding more programs in later commits.
> >
> > Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > ---
> >  tools/testing/selftests/bpf/Makefile          |  2 +-
> >  .../selftests/bpf/progs/xsk_xdp_progs.c       | 19 ++++
> >  tools/testing/selftests/bpf/xsk.c             | 88 ++++---------------
> >  tools/testing/selftests/bpf/xsk.h             |  6 +-
> >  tools/testing/selftests/bpf/xskxceiver.c      | 72 ++++++++-------
> >  tools/testing/selftests/bpf/xskxceiver.h      |  7 +-
> >  6 files changed, 88 insertions(+), 106 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
> >
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > index 205e8c3c346a..a0193a8f9da6 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -240,7 +240,7 @@ $(OUTPUT)/flow_dissector_load: $(TESTING_HELPERS)
> >  $(OUTPUT)/test_maps: $(TESTING_HELPERS)
> >  $(OUTPUT)/test_verifier: $(TESTING_HELPERS) $(CAP_HELPERS)
> >  $(OUTPUT)/xsk.o: $(BPFOBJ)
>
> shouldn't $(OUTPUT)/xsk_xdp_progs.skel.h be added as a dependency
> here, at .o file?

Not sure we can:
xsk.o is a 'generic' library and xsk_xdp_progs.skel.h is xskxceiver-specific.

I was trying to see how it works for the other cases where we depend
on the headers and saw the following:

$(OUTPUT)/test_verifier: test_verifier.c verifier/tests.h $(BPFOBJ) | $(OUTPUT)
        $(call msg,BINARY,,$@)
        $(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@

So at least for test_verifier, we explicitly filter out anything
non-.[aoc]. Presumably because of the same issue?
Should we do the same for xskxceiver? I've sent similar changes for my
xdp_hw_metadata binary about an hour ago..

> > -$(OUTPUT)/xskxceiver: $(OUTPUT)/xsk.o
> > +$(OUTPUT)/xskxceiver: $(OUTPUT)/xsk.o $(OUTPUT)/xsk_xdp_progs.skel.h
>
> and not here. Is that why we have this clang compilation failure?
>
> >
> >  BPFTOOL ?= $(DEFAULT_BPFTOOL)
> >  $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
>
> [...]
