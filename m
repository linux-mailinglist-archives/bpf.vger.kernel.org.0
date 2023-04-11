Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B016DDAF7
	for <lists+bpf@lfdr.de>; Tue, 11 Apr 2023 14:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjDKMgx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Apr 2023 08:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjDKMgs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Apr 2023 08:36:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78BC3C2A;
        Tue, 11 Apr 2023 05:36:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6484061F16;
        Tue, 11 Apr 2023 12:36:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64DA8C433EF;
        Tue, 11 Apr 2023 12:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681216604;
        bh=AjCxCaXiBfBIIiYEZTEj1eySlj1ybIW13Hqi+EYrbqY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j/e3OLK+kwFI1mRpGIHMJAEVm1iJxFvGLrCDNX5U35e7Mq4eXFJNuvwi9gZCf+8qQ
         GBYDrSMysuGInpCiMQk2EuVbgWh9yTI0EVXUj3aNAjqx2l6qJLqTHdY2dzReWvbDKe
         t5cbTl5bsM20ABOy4bo1WeyhL7lIb8zavhj/ZYTcPUUjnODuwTy0C7QMTMP2RHokES
         dD57VUhDnyTlUlatSSFkQKPk7erT85AFrjosW0MI+9knLNh3rSRZBFWJT8R0Rhf9Ew
         s9MJb/LrTR7QUqCcOL+a+rHrOnbQZkVhd8rSd3OSaRiFtaFE8UzgnwJ/Ivc33n3bcv
         WiDU+dHPOf2ZQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3A70C40080; Tue, 11 Apr 2023 09:36:11 -0300 (-03)
Date:   Tue, 11 Apr 2023 09:36:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH] perf bperf: Avoid use after free via union
Message-ID: <ZDVUO/bg8WwnL8V+@kernel.org>
References: <20230411051718.267228-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411051718.267228-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Apr 10, 2023 at 10:17:18PM -0700, Ian Rogers escreveu:
> If bperf sets leader_skel or follower_skel then it appears bpf_skel is
> set and can trigger the following use-after-free:

<SNIP>
 
> Resolve by clearing bpf_skel as part of bpf_counter__destroy.
 
> Suggested-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied.

- Arnaldo
