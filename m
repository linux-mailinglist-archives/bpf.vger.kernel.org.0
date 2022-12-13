Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56ED964B7CD
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 15:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbiLMOwD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 09:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235708AbiLMOvy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 09:51:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729CC2705;
        Tue, 13 Dec 2022 06:51:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 190F9B81222;
        Tue, 13 Dec 2022 14:51:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FAC2C433D2;
        Tue, 13 Dec 2022 14:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670943110;
        bh=kpTlpA1QYWlRwaIHR7kjD5pTRluo4sFhECHUASNMQWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QILKHO92403BZ17MGkSlZGffwf7kYnNYU5lbkIB6l+f1ZLkBTygapOP1O0dCE8tyH
         SXH5qTddzA3e+0Gct/XYrDPrwb7Vim08IHP6CjfN1+KWlmT7t4EeWkmHLP2VUIon12
         h7BJgtu4Vrc2vxctpMO7NvorYOCk3iB9yLo+oMKJdhshpiQWpXKOMXQjnGWGe6ZPpf
         8PbRnVS1FjYxJCPoordYnPKhkW0MsOCTzAcUR3Jr1z9fb0/46EU5Xep5Vs4Jg/IiAN
         DotiIbhQYtESFZjlwlHXBxxtoAJwsLNbKoOTRH15pnQ93hYHUPiQP8ovOIrsW1A3St
         WfymDc3Il/83w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4744040367; Tue, 13 Dec 2022 11:51:48 -0300 (-03)
Date:   Tue, 13 Dec 2022 11:51:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Add VG register attr test with kernel version and
 feature detection
Message-ID: <Y5iRhKrIb5pXOaKk@kernel.org>
References: <20221213114739.2312862-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213114739.2312862-1-james.clark@arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Dec 13, 2022 at 11:47:35AM +0000, James Clark escreveu:
> I didn't get any feedback on the RFC version of this that I posted a
> while back [1]. I'd still like to add the test, especially now that
> 6.1 has been released with this new feature, so I've rebased it onto
> perf/core and double checked that it's still working.
> 
> Applies to perf/core (0c3852adae83)

I'm applying this locally, would this be testable on a Firefly (roc-rk3399-pc):

acme@roc-rk3399-pc:~$ head /proc/cpuinfo
processor	: 0
BogoMIPS	: 48.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
CPU implementer	: 0x41
CPU architecture: 8
CPU variant	: 0x0
CPU part	: 0xd03
CPU revision	: 4

processor	: 1
acme@roc-rk3399-pc:~$

- Arnaldo
 
> Thanks
> James
> 
> [1]: https://lore.kernel.org/bpf/20220927154104.869029-1-james.clark@arm.com/
> 
> James Clark (4):
>   perf test: Add ability to test exit code for attr tests
>   perf test: Add mechanism for skipping attr tests on auxiliary vector
>     values
>   perf test: Add mechanism for skipping attr tests on kernel versions
>   perf test arm64: Add attr tests for new VG register
> 
>  tools/perf/tests/attr.py                      | 71 +++++++++++++++++--
>  .../attr/test-record-user-regs-no-sve-aarch64 |  9 +++
>  .../test-record-user-regs-old-sve-aarch64     | 10 +++
>  .../attr/test-record-user-regs-sve-aarch64    | 14 ++++
>  4 files changed, 99 insertions(+), 5 deletions(-)
>  create mode 100644 tools/perf/tests/attr/test-record-user-regs-no-sve-aarch64
>  create mode 100644 tools/perf/tests/attr/test-record-user-regs-old-sve-aarch64
>  create mode 100644 tools/perf/tests/attr/test-record-user-regs-sve-aarch64
> 
> -- 
> 2.25.1

-- 

- Arnaldo
