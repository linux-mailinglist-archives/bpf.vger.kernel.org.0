Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E056D64CC75
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 15:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238258AbiLNOie (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 09:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238574AbiLNOid (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 09:38:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FA123BEA;
        Wed, 14 Dec 2022 06:38:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1DF4AB81617;
        Wed, 14 Dec 2022 14:38:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA26C433F0;
        Wed, 14 Dec 2022 14:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671028708;
        bh=WZ4H5X5BGlrRi+BAryxaHjIfLiqZU+/G2SVOjk9+Hqc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gmf0+v5RvBULBu1Unid7MsChJ+rUURZXsNbEC8/kfCEuavAbK0lx4FEFvaP1dr0hX
         Cz34jHkmTDHBowxuwRmFER/7bc0EPYWz3u6Nl/ujyIfgE33SSkLL7vEK9rIrVrbqc4
         E+n4IxgQwo688a7aXUez7I5xKjK6b0HHOU1h74pubG7JDXfXrjFjG1R1TodqxJzlEy
         5sp7zNzgLyRNAEBZuuaahddV2gbMyPURI10PYZ4ZPSo0/2L0eDjL8JEtrFx7WDhnzE
         Gstpw/2a6elsg9x4I65CY23kdt6UH0mb2aPwaSLxXbwC9D0a56L4UdN65YV3xKTDOH
         osdVoXEYODxEA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5CE7B40367; Wed, 14 Dec 2022 11:38:26 -0300 (-03)
Date:   Wed, 14 Dec 2022 11:38:26 -0300
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
Message-ID: <Y5nf4pIkqVeYd5Hg@kernel.org>
References: <20221213114739.2312862-1-james.clark@arm.com>
 <Y5iRhKrIb5pXOaKk@kernel.org>
 <634087f2-1a7a-0f61-51e8-9e6068d59e9d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <634087f2-1a7a-0f61-51e8-9e6068d59e9d@arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Dec 13, 2022 at 03:30:37PM +0000, James Clark escreveu:
> 
> 
> On 13/12/2022 14:51, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Dec 13, 2022 at 11:47:35AM +0000, James Clark escreveu:
> >> I didn't get any feedback on the RFC version of this that I posted a
> >> while back [1]. I'd still like to add the test, especially now that
> >> 6.1 has been released with this new feature, so I've rebased it onto
> >> perf/core and double checked that it's still working.
> >>
> >> Applies to perf/core (0c3852adae83)
> > 
> > I'm applying this locally, would this be testable on a Firefly (roc-rk3399-pc):
> 
> Thanks Arnaldo. It doesn't look like rk3399 has SVE, so
> test-record-user-regs-no-sve-aarch64 will run to check that the kernel
> won't give you the new register. So I suppose the answer to the question
> is partially.
> 
> For test-record-user-regs-sve-aarch64, I've been running it on a
> Graviton 3 on AWS which has SVE:
> 
>   ubuntu@ip-10-252-130-213:~/linux$ head /proc/cpuinfo
>   processor	: 0
>   BogoMIPS	: 2100.00
>   Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp
> asimdhp cpuid asimdrdm jscvt fcma lrcpc dcpop sha3 sm3 sm4 asimddp
> sha512 sve asimdfhm dit uscat ilrcpc flagm ssbs paca pacg dcpodp svei8mm
> svebf16 i8mm bf16 dgh rng
>   CPU implementer	: 0x41
>   CPU architecture: 8
>   CPU variant	: 0x1
>   CPU part	: 0xd40
>   CPU revision	: 1
> 
>   processor	: 1

Indeed:

root@roc-rk3399-pc:~# perf test -v _attr
 17: Setup struct perf_event_attr                                    :
--- start ---
test child forked, pid 30139
Using CPUID 0x00000000410fd080
/home/acme/libexec/perf-core/tests/attr.py:155: DeprecationWarning: The SafeConfigParser class has been renamed to ConfigParser in Python 3.2. This alias will be removed in Python 3.12. Use ConfigParser directly instead.
  parser = configparser.SafeConfigParser()
running '/home/acme/libexec/perf-core/tests/attr/test-record-C0'
/home/acme/libexec/perf-core/tests/attr.py:250: DeprecationWarning: The SafeConfigParser class has been renamed to ConfigParser in Python 3.2. This alias will be removed in Python 3.12. Use ConfigParser directly instead.
  parser_event = configparser.SafeConfigParser()
/home/acme/libexec/perf-core/tests/attr.py:264: DeprecationWarning: The SafeConfigParser class has been renamed to ConfigParser in Python 3.2. This alias will be removed in Python 3.12. Use ConfigParser directly instead.
  parser_base = configparser.SafeConfigParser()
running '/home/acme/libexec/perf-core/tests/attr/test-record-basic'
running '/home/acme/libexec/perf-core/tests/attr/test-record-branch-any'
unsupp  '/home/acme/libexec/perf-core/tests/attr/test-record-branch-any'
running '/home/acme/libexec/perf-core/tests/attr/test-record-branch-filter-any'
unsupp  '/home/acme/libexec/perf-core/tests/attr/test-record-branch-filter-any'
running '/home/acme/libexec/perf-core/tests/attr/test-record-branch-filter-any_call'
unsupp  '/home/acme/libexec/perf-core/tests/attr/test-record-branch-filter-any_call'
running '/home/acme/libexec/perf-core/tests/attr/test-record-branch-filter-any_ret'
unsupp  '/home/acme/libexec/perf-core/tests/attr/test-record-branch-filter-any_ret'
running '/home/acme/libexec/perf-core/tests/attr/test-record-branch-filter-hv'
unsupp  '/home/acme/libexec/perf-core/tests/attr/test-record-branch-filter-hv'
running '/home/acme/libexec/perf-core/tests/attr/test-record-branch-filter-ind_call'
unsupp  '/home/acme/libexec/perf-core/tests/attr/test-record-branch-filter-ind_call'
running '/home/acme/libexec/perf-core/tests/attr/test-record-branch-filter-k'
unsupp  '/home/acme/libexec/perf-core/tests/attr/test-record-branch-filter-k'
running '/home/acme/libexec/perf-core/tests/attr/test-record-branch-filter-u'
unsupp  '/home/acme/libexec/perf-core/tests/attr/test-record-branch-filter-u'
running '/home/acme/libexec/perf-core/tests/attr/test-record-count'
running '/home/acme/libexec/perf-core/tests/attr/test-record-data'
running '/home/acme/libexec/perf-core/tests/attr/test-record-freq'
running '/home/acme/libexec/perf-core/tests/attr/test-record-graph-default'
test limitation '!aarch64'
excluded architecture list ['aarch64']
skipped [aarch64] '/home/acme/libexec/perf-core/tests/attr/test-record-graph-default'
running '/home/acme/libexec/perf-core/tests/attr/test-record-graph-default-aarch64'
test limitation 'aarch64'
running '/home/acme/libexec/perf-core/tests/attr/test-record-graph-dwarf'
running '/home/acme/libexec/perf-core/tests/attr/test-record-graph-fp'
test limitation '!aarch64'
excluded architecture list ['aarch64']
skipped [aarch64] '/home/acme/libexec/perf-core/tests/attr/test-record-graph-fp'
running '/home/acme/libexec/perf-core/tests/attr/test-record-graph-fp-aarch64'
test limitation 'aarch64'
running '/home/acme/libexec/perf-core/tests/attr/test-record-group'
running '/home/acme/libexec/perf-core/tests/attr/test-record-group-sampling'
running '/home/acme/libexec/perf-core/tests/attr/test-record-group1'
running '/home/acme/libexec/perf-core/tests/attr/test-record-group2'
running '/home/acme/libexec/perf-core/tests/attr/test-record-no-buffering'
running '/home/acme/libexec/perf-core/tests/attr/test-record-no-inherit'
running '/home/acme/libexec/perf-core/tests/attr/test-record-no-samples'
running '/home/acme/libexec/perf-core/tests/attr/test-record-period'
running '/home/acme/libexec/perf-core/tests/attr/test-record-pfm-period'
unsupp  '/home/acme/libexec/perf-core/tests/attr/test-record-pfm-period'
running '/home/acme/libexec/perf-core/tests/attr/test-record-raw'
running '/home/acme/libexec/perf-core/tests/attr/test-record-spe-period'
test limitation 'aarch64'
unsupp  '/home/acme/libexec/perf-core/tests/attr/test-record-spe-period'
running '/home/acme/libexec/perf-core/tests/attr/test-record-spe-period-term'
test limitation 'aarch64'
unsupp  '/home/acme/libexec/perf-core/tests/attr/test-record-spe-period-term'
running '/home/acme/libexec/perf-core/tests/attr/test-record-spe-physical-address'
test limitation 'aarch64'
unsupp  '/home/acme/libexec/perf-core/tests/attr/test-record-spe-physical-address'
running '/home/acme/libexec/perf-core/tests/attr/test-record-user-regs-no-sve-aarch64'
test limitation 'aarch64'
running '/home/acme/libexec/perf-core/tests/attr/test-record-user-regs-old-sve-aarch64'
test limitation 'aarch64'
skipped [new kernel skip] '/home/acme/libexec/perf-core/tests/attr/test-record-user-regs-old-sve-aarch64'
running '/home/acme/libexec/perf-core/tests/attr/test-record-user-regs-sve-aarch64'
test limitation 'aarch64'
skipped [auxv skip] '/home/acme/libexec/perf-core/tests/attr/test-record-user-regs-sve-aarch64'
running '/home/acme/libexec/perf-core/tests/attr/test-stat-C0'
running '/home/acme/libexec/perf-core/tests/attr/test-stat-basic'
running '/home/acme/libexec/perf-core/tests/attr/test-stat-default'
running '/home/acme/libexec/perf-core/tests/attr/test-stat-detailed-1'
running '/home/acme/libexec/perf-core/tests/attr/test-stat-detailed-2'
running '/home/acme/libexec/perf-core/tests/attr/test-stat-detailed-3'
running '/home/acme/libexec/perf-core/tests/attr/test-stat-group'
running '/home/acme/libexec/perf-core/tests/attr/test-stat-group1'
running '/home/acme/libexec/perf-core/tests/attr/test-stat-no-inherit'
test child finished with 0
---- end ----
Setup struct perf_event_attr: Ok
root@roc-rk3399-pc:~#
