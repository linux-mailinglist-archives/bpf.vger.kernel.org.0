Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 669B6393255
	for <lists+bpf@lfdr.de>; Thu, 27 May 2021 17:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235248AbhE0PWb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 May 2021 11:22:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:46648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235017AbhE0PW3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 May 2021 11:22:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F2CE610A0;
        Thu, 27 May 2021 15:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622128856;
        bh=FsdvMDMPoAWaRbjwN3oCzMKu1dnq9/XKUgPgzPttdTs=;
        h=Date:From:To:Cc:Subject:From;
        b=BUV3QKDf51tslVQ/4QAOI7Yk+rDfN5/bsET3soKaMWpLl2B/Kn6EPoUoDxCGw0Ex9
         v/N2BzWu7e931m7ANy9wPlKAcGEolUMQoEvKWriGZnyV+THohujc5FfR8qW/mJ5zlK
         nZLx+BJi/tATLL8Ey2JnJzUHIW7wjxqPxoxYqCpK716o4t6iNNHQ/eMy4k2Gi+IJf/
         O0niY+G6vPdtU+YpaRKepHOYmHaMUzR6KteuIBpeRANx8Pc/q6AlFfP3O9JVlecVyN
         Zav18QYWcatpTuvVqJ0Lj3z9BfjZKAQ2hzIv7IVZSXTRUAPvTNIHhCEBM/6k7xB1yu
         xMfjw3NclGAjg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B50354011C; Thu, 27 May 2021 12:20:53 -0300 (-03)
Date:   Thu, 27 May 2021 12:20:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Cc:     Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
        dwarves@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        Michael Petlan <mpetlan@redhat.com>
Subject: [RFT] Testing 1.22
Message-ID: <YK+41f972j25Z1QQ@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi guys,

	Its important to have 1.22 out of the door ASAP, so please clone
what is in tmp.master and report your results.

	To make it super easy:

[acme@quaco pahole]$ cd /tmp
[acme@quaco tmp]$ git clone git://git.kernel.org/pub/scm/devel/pahole/pahole.git
Cloning into 'pahole'...
remote: Enumerating objects: 6510, done.
remote: Total 6510 (delta 0), reused 0 (delta 0), pack-reused 6510
Receiving objects: 100% (6510/6510), 1.63 MiB | 296.00 KiB/s, done.
Resolving deltas: 100% (4550/4550), done.
[acme@quaco tmp]$ cd pahole/
[acme@quaco pahole]$ git checkout origin/tmp.master
Note: switching to 'origin/tmp.master'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by switching back to a branch.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -c with the switch command. Example:

  git switch -c <new-branch-name>

Or undo this operation with:

  git switch -

Turn off this advice by setting config variable advice.detachedHead to false

HEAD is now at 0d17503db0580a66 btf_encoder: fix and complete filtering out zero-sized per-CPU variables
[acme@quaco pahole]$ git log --oneline -5
0d17503db0580a66 (HEAD, origin/tmp.master) btf_encoder: fix and complete filtering out zero-sized per-CPU variables
fb418f9d8384d3a9 dwarves: Make handling of NULL by destructos consistent
f049fe9ebf7aa9c2 dutil: Make handling of NULL by destructos consistent
1512ab8ab6fe76a9 pahole: Make handling of NULL by destructos consistent
1105b7dad2d0978b elf_symtab: Use zfree() where applicable
[acme@quaco pahole]$ mkdir build
[acme@quaco pahole]$ cd build
[acme@quaco build]$ cmake ..
<SNIP>
-- Build files have been written to: /tmp/pahole/build
[acme@quaco build]$ cd ..
[acme@quaco pahole]$ make -j8 -C build
make: Entering directory '/tmp/pahole/build'
<SNIP>
[100%] Built target pahole
make[1]: Leaving directory '/tmp/pahole/build'
make: Leaving directory '/tmp/pahole/build'
[acme@quaco pahole]$

Then make sure build/pahole is in your path and try your workloads.

Jiri, Michael, if you could run your tests with this, that would be awesome,

Thanks in advance!

- Arnaldo
