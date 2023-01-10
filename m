Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8A06641FF
	for <lists+bpf@lfdr.de>; Tue, 10 Jan 2023 14:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjAJNfm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Jan 2023 08:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238608AbjAJNf0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Jan 2023 08:35:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F845A89C;
        Tue, 10 Jan 2023 05:35:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1AF3B81662;
        Tue, 10 Jan 2023 13:35:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C4DC433F1;
        Tue, 10 Jan 2023 13:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673357721;
        bh=tulrPFJM/ETZv6f0hflSo/kFA5Xwm+nKDldQCfULQvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c0t07xChFq6u9hvIhMUWdWsRHiBoJkhcsi02AfYkV4d3Gz1V946LKhAt4pNU0YncH
         J7PrHG1t6Vyp88rLe55LW86lJB3dIEnnXXD8tRodrrP7YYBvfsAiHkf542eDVytk3W
         v5CN0RzVH8I+8jG/TaGuTH/eQjgFVmvQw8EqG+5+gVasjlbzasUUnaZmKEfK4/2rLh
         f8Y0HibH09L4XIyfFHJmgMNS2lYAIYOt0E481UdGGvuM1/F7htHa8+gQT12yZCIh2j
         zrrLIUhi2LUlUVkGMHfcqlvqJB6VckvawkFQdt5m9qk/wyCHhMnPdnci074uN+HhwV
         W8ZqlclfEDAOg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4CB1340468; Tue, 10 Jan 2023 10:35:19 -0300 (-03)
Date:   Tue, 10 Jan 2023 10:35:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Subject: Re: [PATCH v3 1/2] perf build: Properly guard libbpf includes
Message-ID: <Y71pl/6yrhIWjYOe@kernel.org>
References: <Y7hZccgOiueB31a+@kernel.org>
 <Y7hgKMDGzQlankL1@kernel.org>
 <Y7hgoVKBoulCbA4l@kernel.org>
 <CAP-5=fXPPSHvN6VYc=8tzBz4xtKg4Ofa17zV4pAk0ycorXje8w@mail.gmail.com>
 <Y7wuz6EOggZ8Wysb@kernel.org>
 <Y7xYimp0h4YT72/N@krava>
 <CAP-5=fXwO5_kK=pMV09jdAVw386CB0JwArD0BZd=B=xCyWSP1g@mail.gmail.com>
 <CAP-5=fVa51_URGsdDFVTzpyGmdDRj_Dj2EKPuDHNQ0BYgMSzUA@mail.gmail.com>
 <CAP-5=fVtMEahrPMJNVOqsZGj-GoTxUnWsdzK7M+9F2+DhG_STQ@mail.gmail.com>
 <Y71J2WpaMtked02+@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y71J2WpaMtked02+@krava>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Jan 10, 2023 at 12:19:53PM +0100, Jiri Olsa escreveu:
> On Mon, Jan 09, 2023 at 11:34:44AM -0800, Ian Rogers wrote:
> > Oh, just to note. While failing the feature test is disappointing for
> > a libbpf that isn't very old, we have the newer libbpf to statically
> > build in. Developers won't be impacted due to the static route. If you
> > are a distro maintainer, you should just update your libbpf. So we
> > could just bump the API assumption to 1.0 as I believe that'd have the
> > advantage of removing feature tests, workarounds, untested code (like
> > what broke here), etc.

> > What do you think?
 
> yes, seems good.. fedora has libbpf 1.0 already so should not be problem
> there at least ;-)

So, I already pushed 1/2 to perf/urgent, can I stick an Acked-by: jolsa
to the second?

- Arnaldo
