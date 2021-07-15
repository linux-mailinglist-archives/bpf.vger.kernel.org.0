Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBBE83CAE88
	for <lists+bpf@lfdr.de>; Thu, 15 Jul 2021 23:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhGOVeR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Jul 2021 17:34:17 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34422 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhGOVeR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Jul 2021 17:34:17 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DFB1C1FE67;
        Thu, 15 Jul 2021 21:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626384681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cUZtmIRUhRXL4ZC3IEZvDFbgGC5uJU4F1xXHT7dE/hM=;
        b=VXBZDfJ1QUYv+tCshjxauzGHRqeHTSDTm4wiu0NFyr1hugbLdda+b3Y82ZabuSldvnFj4P
        JMljTyMQYEP0Ot8Tde4SQz4kqtC9KlIQcA+HvzmRpq4xIJFXuLUt3ggGi1k863eoDN8QwU
        vzJWF2sW5x64NScnd3qYLSPU6SEdZew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626384681;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cUZtmIRUhRXL4ZC3IEZvDFbgGC5uJU4F1xXHT7dE/hM=;
        b=XPIYGTv7/zJgP3aZ21crRRP5sCr3xffRiCfCyDNGG5Qc1pW0TZTjiKT2qg0F3AmZb+UUcO
        ZmrlXSHgx1fahPBw==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C8976A3B9C;
        Thu, 15 Jul 2021 21:31:21 +0000 (UTC)
Date:   Thu, 15 Jul 2021 23:31:20 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        dwarves@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [RFT] Testing 1.22
Message-ID: <20210715213120.GJ24916@kitsune.suse.cz>
References: <YK+41f972j25Z1QQ@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK+41f972j25Z1QQ@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

when building with system libbpf I get:

[   40s] make[1]: Nothing to be done for 'preinstall'.
[   40s] make[1]: Leaving directory '/home/abuild/rpmbuild/BUILD/dwarves-1.21+git175.1ef87b2/build'
[   40s] Install the project...
[   40s] /usr/bin/cmake -P cmake_install.cmake
[   40s] -- Install configuration: "RelWithDebInfo"
[   40s] -- Installing: /home/abuild/rpmbuild/BUILDROOT/dwarves-1.21+git175.1ef87b2-15.1.ppc64le/usr/bin/codiff
[   40s] CMake Error at cmake_install.cmake:63 (file):
[   40s]   file RPATH_CHANGE could not write new RPATH:
[   40s] 
[   40s]     
[   40s] 
[   40s]   to the file:
[   40s] 
[   40s]     /home/abuild/rpmbuild/BUILDROOT/dwarves-1.21+git175.1ef87b2-15.1.ppc64le/usr/bin/codiff
[   40s] 
[   40s]   The current RUNPATH is:
[   40s] 
[   40s]     /home/abuild/rpmbuild/BUILD/dwarves-1.21+git175.1ef87b2/build:
[   40s] 
[   40s]   which does not contain:
[   40s] 
[   40s]     /usr/local/lib64:/home/abuild/rpmbuild/BUILD/dwarves-1.21+git175.1ef87b2/build:
[   40s] 
[   40s]   as was expected.
[   40s] 
[   40s] 
[   40s] make: *** [Makefile:74: install] Error 1
[   40s] make: Leaving directory '/home/abuild/rpmbuild/BUILD/dwarves-1.21+git175.1ef87b2/build'
[   40s] error: Bad exit status from /var/tmp/rpm-tmp.OaGNX4 (%install)

This is not a problem with embedded libbpf.

Using system libbpf seems to be new in 1.22

Thanks

Michal

On Thu, May 27, 2021 at 12:20:53PM -0300, Arnaldo Carvalho de Melo wrote:
> Hi guys,
> 
> 	Its important to have 1.22 out of the door ASAP, so please clone
> what is in tmp.master and report your results.
> 
> 	To make it super easy:
> 
> [acme@quaco pahole]$ cd /tmp
> [acme@quaco tmp]$ git clone git://git.kernel.org/pub/scm/devel/pahole/pahole.git
> Cloning into 'pahole'...
> remote: Enumerating objects: 6510, done.
> remote: Total 6510 (delta 0), reused 0 (delta 0), pack-reused 6510
> Receiving objects: 100% (6510/6510), 1.63 MiB | 296.00 KiB/s, done.
> Resolving deltas: 100% (4550/4550), done.
> [acme@quaco tmp]$ cd pahole/
> [acme@quaco pahole]$ git checkout origin/tmp.master
> Note: switching to 'origin/tmp.master'.
> 
> You are in 'detached HEAD' state. You can look around, make experimental
> changes and commit them, and you can discard any commits you make in this
> state without impacting any branches by switching back to a branch.
> 
> If you want to create a new branch to retain commits you create, you may
> do so (now or later) by using -c with the switch command. Example:
> 
>   git switch -c <new-branch-name>
> 
> Or undo this operation with:
> 
>   git switch -
> 
> Turn off this advice by setting config variable advice.detachedHead to false
> 
> HEAD is now at 0d17503db0580a66 btf_encoder: fix and complete filtering out zero-sized per-CPU variables
> [acme@quaco pahole]$ git log --oneline -5
> 0d17503db0580a66 (HEAD, origin/tmp.master) btf_encoder: fix and complete filtering out zero-sized per-CPU variables
> fb418f9d8384d3a9 dwarves: Make handling of NULL by destructos consistent
> f049fe9ebf7aa9c2 dutil: Make handling of NULL by destructos consistent
> 1512ab8ab6fe76a9 pahole: Make handling of NULL by destructos consistent
> 1105b7dad2d0978b elf_symtab: Use zfree() where applicable
> [acme@quaco pahole]$ mkdir build
> [acme@quaco pahole]$ cd build
> [acme@quaco build]$ cmake ..
> <SNIP>
> -- Build files have been written to: /tmp/pahole/build
> [acme@quaco build]$ cd ..
> [acme@quaco pahole]$ make -j8 -C build
> make: Entering directory '/tmp/pahole/build'
> <SNIP>
> [100%] Built target pahole
> make[1]: Leaving directory '/tmp/pahole/build'
> make: Leaving directory '/tmp/pahole/build'
> [acme@quaco pahole]$
> 
> Then make sure build/pahole is in your path and try your workloads.
> 
> Jiri, Michael, if you could run your tests with this, that would be awesome,
> 
> Thanks in advance!
> 
> - Arnaldo
