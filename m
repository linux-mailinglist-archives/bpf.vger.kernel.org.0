Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9569A486A8A
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 20:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbiAFTew (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 14:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiAFTev (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jan 2022 14:34:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB951C061245;
        Thu,  6 Jan 2022 11:34:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2A92B82354;
        Thu,  6 Jan 2022 19:34:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE9EC36AE3;
        Thu,  6 Jan 2022 19:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641497688;
        bh=7Go2vgeGYWubnF+82VhrywldXz4Xvt6wmXlJuZcLP5k=;
        h=Date:From:To:Cc:Subject:From;
        b=uUgcB6kp1S6wPwOPmN/OgWmvBByQt5QLnNiae0S/B9SRr9IA+Q21BOW/bVyBllhPI
         rWrtp6hVH/WMiatRHXy7kVE9Dhjc2Uqj/36kS0ohLquFnkhrOxPHfe+vHh4hAYo8Qg
         A6ADJq+ycNHXu2gLc/1Yq8ba5X5vIkeHHtI4N5TBaO8z8LKhsie91uTgPsdBbS7wml
         FUvJG3myCjTQIOdnL611pwv4efYEqABmURpcrQvOYZ3W6otnZ1yqp4rjQXn4j9HN7v
         uhbKXj2+p96GNlb0RQqADTGHgbZDI0aCzcJZL6Tw/ezl53smz3d593OnmNOQ25Wlfl
         B0M02F6IBQYsA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 677E240B92; Thu,  6 Jan 2022 16:34:46 -0300 (-03)
Date:   Thu, 6 Jan 2022 16:34:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Song Liu <songliubraving@fb.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: perf build broken seemingly due to libbpf changes, checking...
Message-ID: <YddEVgNKBJiqcV6Y@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

After merging torvalds/master to perf/urgent I'm getting this:

util/bpf-event.c:25:21: error: no previous prototype for ‘btf__load_from_kernel_by_id’ [-Werror=missing-prototypes]
   25 | struct btf * __weak btf__load_from_kernel_by_id(__u32 id)
      |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
util/bpf-event.c:37:1: error: no previous prototype for ‘bpf_object__next_program’ [-Werror=missing-prototypes]
   37 | bpf_object__next_program(const struct bpf_object *obj, struct bpf_program *prev)
      | ^~~~~~~~~~~~~~~~~~~~~~~~
util/bpf-event.c:46:1: error: no previous prototype for ‘bpf_object__next_map’ [-Werror=missing-prototypes]
   46 | bpf_object__next_map(const struct bpf_object *obj, const struct bpf_map *prev)
      | ^~~~~~~~~~~~~~~~~~~~
util/bpf-event.c:55:1: error: no previous prototype for ‘btf__raw_data’ [-Werror=missing-prototypes]
   55 | btf__raw_data(const struct btf *btf_ro, __u32 *size)
      | ^~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/util/bpf-event.o] Error 1
make[4]: *** Waiting for unfinished jobs....
util/bpf_counter.c: In function ‘bpf_target_prog_name’:
util/bpf_counter.c:82:15: error: implicit declaration of function ‘btf__load_from_kernel_by_id’ [-Werror=implicit-function-declaration]
   82 |         btf = btf__load_from_kernel_by_id(info_linear->info.btf_id);
      |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
util/bpf_counter.c:82:13: error: assignment to ‘struct btf *’ from ‘int’ makes pointer from integer without a cast [-Werror=int-conversion]
   82 |         btf = btf__load_from_kernel_by_id(info_linear->info.btf_id);
      |             ^
cc1: all warnings being treated as errors
make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/util/bpf_counter.o] Error 1

I'm checking now...

BTW I test perf builds with:

make -k BUILD_BPF_SKEL=1 CORESIGHT=1 PYTHON=python3 O=/tmp/build/perf -C tools/perf install-bin && git status && perf test python


-- 

- Arnaldo
