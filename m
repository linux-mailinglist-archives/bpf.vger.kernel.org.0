Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0E062C68B
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 18:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbiKPRlq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 12:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234218AbiKPRlo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 12:41:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29219D137;
        Wed, 16 Nov 2022 09:41:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC2E6B81E31;
        Wed, 16 Nov 2022 17:41:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E00C433D6;
        Wed, 16 Nov 2022 17:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668620500;
        bh=ze6lrws1PcLEoJV4hUYYFp/aoWa0Afbnhm9vvHmIuA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hDhUQ5OgrJUWUV60LKsv4XdeShIdcDJGo42XW7WehX1q3JJj7E9BFx250SS4Hruk0
         orAWet0r0LHwJT/1r4kyPr1HoWy2mZvmir08kp80/dCX7uz0yHADdQlBDr0l/Rdp4P
         YCFaC5virxzOpwrsRD2XwiFwxTwIkFyq7/mOJjCvVmJ/7GHnoHJbQYU0kdDcK6TSiH
         U4FUeC1VI70B3nTUkCVDCpETP535Oqxc0SmpolpD3xdqAufR6pPCOwi1NAXjLJEhIg
         SS/xCa2KAPgNGjydkwkDCvf4MoQTc1Ed/NmGpEY3VNB2YiWIO/xxut0GjAmJ0w4rQP
         T0HA9k71LGbFQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C0BE24034E; Wed, 16 Nov 2022 14:41:37 -0300 (-03)
Date:   Wed, 16 Nov 2022 14:41:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 0/1] Fix perf tools/lib includes
Message-ID: <Y3Ug0c01n2tFzVlK@kernel.org>
References: <20221116072211.2837834-1-irogers@google.com>
 <Y3T/fxPOvZgePIEz@kernel.org>
 <Y3UAX3U/cpszMFE7@kernel.org>
 <CAP-5=fWu2Ywz9rC3fq9GSnASbJu4hyiF4bqyrSDi34Rz6A8y+A@mail.gmail.com>
 <CAP-5=fX5X8=-jbj7wo7LZpNhgYzJqPJ1duJbdf2zH3HtPhcdsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fX5X8=-jbj7wo7LZpNhgYzJqPJ1duJbdf2zH3HtPhcdsA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NUMERIC_HTTP_ADDR,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Nov 16, 2022 at 08:47:51AM -0800, Ian Rogers escreveu:
> On Wed, Nov 16, 2022 at 8:45 AM Ian Rogers <irogers@google.com> wrote:
> > Looks like the GTK part of the build isn't depending on the prepare
> > step. I'll take a look.

> Yep. The target:
 
> $(GTK_IN): FORCE
 
> should be:
 
> $(GTK_IN): FORCE prepare
 
> Could you try this, or do you want me to resend?

Trying it, so far so good:

[perfbuilder@five ~]$ export BUILD_TARBALL=http://192.168.86.14/perf/perf-6.1.0-rc5.tar.xz
[perfbuilder@five ~]$ time dm
   1   197.40 almalinux:8                   : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4) , clang version 12.0.1 (Red Hat 12.0.1-4.module_el8.5.0+1025+93159d6c)
   2   195.05 almalinux:9                   : Ok   gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9) , clang version 13.0.1 (Red Hat 13.0.1-1.el9)
   3   160.09 alpine:3.12                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 10.0.0 (https://gitlab.alpinelinux.org/alpine/aports.git 7445adce501f8473efdb93b17b5eaf2f1445ed4c)
   4   151.66 alpine:3.13                   : Ok   gcc (Alpine 10.2.1_pre1) 10.2.1 20201203 , Alpine clang version 10.0.1
   5   151.66 alpine:3.14                   : Ok   gcc (Alpine 10.3.1_git20210424) 10.3.1 20210424 , Alpine clang version 11.1.0

[perfbuilder@pumpkin ~]$ export BUILD_TARBALL=http://192.168.86.14/perf/perf-6.1.0-rc5.tar.xz
[perfbuilder@pumpkin ~]$ time dm from fedora:24
  22    40.30 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1) 
  23     2.64 fedora:24-x-ARC-uClibc        : FAIL gcc version 7.1.1 20170710 (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 
    libbpf.c:46:10: fatal error: libelf.h: No such file or directory
     #include <libelf.h>
              ^~~~~~~~~~
    compilation terminated.
  24    40.29 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1) 
  25    42.61 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2) 
  26    41.70 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6) 
  27    44.11 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) 
  28    46.22 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) 
  29    45.02 fedora:30                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) 
  30   178.98 fedora:31                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 9.0.1 (Fedora 9.0.1-4.fc31)
  31   159.04 fedora:32                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 10.0.1 (Fedora 10.0.1-3.fc32)
  32   178.60 fedora:33                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 11.0.0 (Fedora 11.0.0-3.fc33)
  33: fedora:34
