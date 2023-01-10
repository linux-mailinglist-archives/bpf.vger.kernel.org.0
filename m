Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CE4664389
	for <lists+bpf@lfdr.de>; Tue, 10 Jan 2023 15:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbjAJOqa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Jan 2023 09:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjAJOqT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Jan 2023 09:46:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946434FCED;
        Tue, 10 Jan 2023 06:46:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38F5F61759;
        Tue, 10 Jan 2023 14:46:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67327C433F0;
        Tue, 10 Jan 2023 14:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673361977;
        bh=Jd8jGSPIFdj2DgSDZN8XQd2dUL3NZySQqoBtiIgILT8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LuPtIDLfHpPZOrBg2x3WkyoPCEG86KhTQLNGMS/w2biIGsXveRpQ61QSBHUKTzHzz
         +L60t5aJatwFjL+IDHRug4xxIJPiywQsMMzJ3YzxUCqLsXKCdVSICZTIfb1UdmHIit
         UqgGoqrx1Znla5Tg6S21Gc/XBHB1arP149+7Dxkv8TYmTaHiP9716uM8134lUx+DGv
         H2eMUiVROFTeqCF/12jpAxXQyJ5cqPxhNOedYWL889dGut2vGACAWDvk+oMRZQ3qdn
         tez0z3ZLbYL29RJaesPoFF3wW2qRt/JHC01cN6vBhmx1bV6JQfPDbEMU7LPTrsvvgl
         npbhgKKl+r+oA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C53CC40468; Tue, 10 Jan 2023 11:46:14 -0300 (-03)
Date:   Tue, 10 Jan 2023 11:46:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Subject: Re: [PATCH v3 1/2] perf build: Properly guard libbpf includes
Message-ID: <Y716Nt3c/Lc0Z4P5@kernel.org>
References: <CAJ9a7ViGE3UJX02oA42A9TSTKsOozPzdHjyL+OSP4J-9dZFqrg@mail.gmail.com>
 <Y7hZccgOiueB31a+@kernel.org>
 <Y7hgKMDGzQlankL1@kernel.org>
 <Y7hgoVKBoulCbA4l@kernel.org>
 <CAP-5=fXPPSHvN6VYc=8tzBz4xtKg4Ofa17zV4pAk0ycorXje8w@mail.gmail.com>
 <Y7wuz6EOggZ8Wysb@kernel.org>
 <Y7xYimp0h4YT72/N@krava>
 <CAP-5=fXwO5_kK=pMV09jdAVw386CB0JwArD0BZd=B=xCyWSP1g@mail.gmail.com>
 <CAP-5=fVa51_URGsdDFVTzpyGmdDRj_Dj2EKPuDHNQ0BYgMSzUA@mail.gmail.com>
 <Y712sCnYBJobe2eY@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y712sCnYBJobe2eY@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Jan 10, 2023 at 11:31:12AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Jan 09, 2023 at 11:29:51AM -0800, Ian Rogers escreveu:
> > On Mon, Jan 9, 2023 at 10:37 AM Ian Rogers <irogers@google.com> wrote:
> > > -int libbpf_register_prog_handler(const char *sec __maybe_unused,
> > > -                                 enum bpf_prog_type prog_type __maybe_unused,
> > > -                                 enum bpf_attach_type exp_attach_type
> > > __maybe_unused,
> > > -                                 const struct
> > > libbpf_prog_handler_opts *opts __maybe_unused)
> > > +static int libbpf_register_prog_handler(const char *sec __maybe_unused,
> > > +                                       enum bpf_prog_type prog_type
> > > __maybe_unused,
> > > +                                       enum bpf_attach_type
> > > exp_attach_type __maybe_unused,
> > > +                                       const void *opts __maybe_unused)
> > > {
> > >        pr_err("%s: not support, update libbpf\n", __func__);
> > >        return -ENOTSUP;
> > > ```
> > >
> > > There are some other fixes necessary too. I'll try to write the fuller
> > > patch but I have no means for testing except for undefining
> > > HAVE_LIBBPF_BPF_PROGRAM__SET_INSNS.
> > 
> > So libbpf_prog_handler_opts is missing in the failing build, this
> > points to a libbpf before 0.8. I'm somewhat concerned that to work
> > around these linkage problems we're adding runtime errors - we may
> > build but the functionality is totally crippled. Is it worth
> > maintaining these broken builds or to just upfront fail the feature
> > test?
 
> Probably better to make the feature test disable bpf support while
> emitting a warning that features such as a, b, and c won't we available.

This would be the one-liner I think is appropriate for v6.2, ok?

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 9962ae23ab8c5868..5b87846759036f6f 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -589,6 +589,8 @@ ifndef NO_LIBELF
           $(call feature_check,libbpf-bpf_program__set_insns)
           ifeq ($(feature-libbpf-bpf_program__set_insns), 1)
             CFLAGS += -DHAVE_LIBBPF_BPF_PROGRAM__SET_INSNS
+          else
+            dummy := $(error Error: libbpf devel library needs to be >= 0.8.0 to build with LIBBPF_DYNAMIC, update or build statically with the version that comes with the kernel sources);
           endif
           $(call feature_check,libbpf-btf__raw_data)
           ifeq ($(feature-libbpf-btf__raw_data), 1)
