Return-Path: <bpf+bounces-13208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B06797D6142
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 07:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F832B21158
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 05:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EBF11188;
	Wed, 25 Oct 2023 05:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V67brfH4"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95B911702
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 05:42:04 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1094912A
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 22:42:03 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6be840283ceso4364044b3a.3
        for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 22:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698212522; x=1698817322; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/4I6K4dn8jNN6gYXvsKkaB5Cz2wUpBzr4i6+0y5JHBs=;
        b=V67brfH4axm1VYI8Rvys6ni5ZKUMHczSpX+Q+yzx3uZqtSePRkNRQWSTbOS2H4TI/k
         xrZiNtors0N/vJP2FHJbwYeptWo1hjUO/ZnzxR0onkV3dFejGlIPZwEG2uI3SA62g69x
         p6sKdPLxpEwWCAXHDXQyZKJdBoGHqLL+ZhcIEezQ3nilKNK3nH8UopywH9pwK4OSnXK3
         7cqtjTVb3d6MC0mMqggkb3KDeR3oSHBxisHzw8zgOCmrdKt+5334x7fpaqqtfK/XoAf0
         LESWcqGqEswqwQ1ZirOia3TqlahTnKkyu5DQHOlV1NGHbHYBQbKrENN+J6lmSnPZ0w9q
         /iqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698212522; x=1698817322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4I6K4dn8jNN6gYXvsKkaB5Cz2wUpBzr4i6+0y5JHBs=;
        b=jfQH8MjkxwK87yBHiH0U39BJTqcfKdr1umEZf7SE7qM0mqyTXeoj+M4fqaW4d957j/
         VpenCJsqtHQxRCMC2MJSOFeLBJbNiXfpGsEyJhL0Mcjl4ZV1C3/RY4FyXsGMPljW1WXD
         pbuT/EwDmvwxduUjEyg7XD/lv+thx6WY72C2yrWkL/05uZYbBliycWh67hCEykL/kOE9
         TW1aTXy4jaa+23jLfJ6Wub/ShZn++nk1WLdnY0wX51/XrTdOx6Xcamq3iXRYXXEgXlYi
         GhJ+o5R3upRhQG5rx37PO7MYCMPuCQQ4Cegrwqp1fEMNSMRYGaPD7FWlKMYAPXn68Fi/
         sPPg==
X-Gm-Message-State: AOJu0YyLwOBdtdDtAnVyAfx0Fh9U9NpNwuOkPvDqJhQVCt+3IzUioW2X
	4xR2sm8jmzumAUVo9daQmM4=
X-Google-Smtp-Source: AGHT+IG23vHmmq5dt8Yji4Qi7S1XudTIkyWu+mxKHTirLdpb/eamQgSuYMZOb9/O24SwLcbnvoAZUA==
X-Received: by 2002:a05:6a00:1142:b0:6be:23dd:d612 with SMTP id b2-20020a056a00114200b006be23ddd612mr13346578pfm.16.1698212522333;
        Tue, 24 Oct 2023 22:42:02 -0700 (PDT)
Received: from surya ([2600:1700:3ec2:2011:3ef3:bbdb:b46b:4676])
        by smtp.gmail.com with ESMTPSA id v189-20020a6261c6000000b006be0b0fc83asm8925549pfb.125.2023.10.24.22.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 22:42:01 -0700 (PDT)
Date: Tue, 24 Oct 2023 22:41:59 -0700
From: Manu Bretelle <chantr4@gmail.com>
To: Kui-Feng Lee <sinquersw@gmail.com>, ast@kernel.org
Cc: bpf@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
	shuah@kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: umount children of TDIR in
 test_bpffs
Message-ID: <ZTiqp7URqNjqrSEk@surya>
References: <20231024201852.1512720-1-chantr4@gmail.com>
 <041a3ea2-8cc6-4f0f-8ed9-6ca459e5bbb7@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <041a3ea2-8cc6-4f0f-8ed9-6ca459e5bbb7@gmail.com>

On Tue, Oct 24, 2023 at 02:29:19PM -0700, Kui-Feng Lee wrote:
> 
> 
> On 10/24/23 13:18, Manu Bretelle wrote:
> > Currently this tests tries to umount /sys/kernel/debug (TDIR) but the
> > system it is running on may have mounts below.
> > 
> > For example, danobi/vmtest [0] VMs have
> >      mount -t tracefs tracefs /sys/kernel/debug/tracing
> > as part of their init.
> > 
> > This change list mounts and will umount any mounts below TDIR before
> > umounting TDIR itself.
> > 
> > Note that it is not umounting recursively, so in the case of a sub-mount
> > of TDIR  having another sub-mount, this will fail as mtab is ordered.
> 
> Should we move TID to a random path likes "/sys/kernel/debug-<pid>/"?
> 

Fair point, I suppose we would want to keep TDIR a defined string as it does
simplify the gymnastic involved through the rest of the script, but yeah
looking at the original commit:
edb65ee5aa25 (selftests/bpf: Add bpffs preload test)

I don't see any reason to use an alternate directory and rather mkdir it vs
umounting the original one.
so something like

    #define TDIR "/sys/kernel/test_bpffs"

Would probably do.

Alexei could confirm his original intent probably.

> > 
> > Test:
> > 
> > Originally:
> > 
> >      $ vmtest -k $KERNEL_REPO/arch/x86_64/boot/bzImage "./test_progs -vv -a test_bpffs"
> >      => bzImage
> >      ===> Booting
> >      ===> Setting up VM
> >      ===> Running command
> >      [    2.138818] bpf_testmod: loading out-of-tree module taints kernel.
> >      [    2.140913] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
> >      bpf_testmod.ko is already unloaded.
> >      Loading bpf_testmod.ko...
> >      Successfully loaded bpf_testmod.ko.
> >      test_test_bpffs:PASS:clone 0 nsec
> >      fn:PASS:unshare 0 nsec
> >      fn:PASS:mount / 0 nsec
> >      fn:FAIL:umount /sys/kernel/debug unexpected error: -1 (errno 16)
> >      bpf_testmod.ko is already unloaded.
> >      Loading bpf_testmod.ko...
> >      Successfully loaded bpf_testmod.ko.
> >      test_test_bpffs:PASS:clone 0 nsec
> >      test_test_bpffs:PASS:waitpid 0 nsec
> >      test_test_bpffs:FAIL:bpffs test  failed 255#282     test_bpffs:FAIL
> >      Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED
> >      Successfully unloaded bpf_testmod.ko.
> >      Command failed with exit code: 1
> > 
> > After this change:
> > 
> >      $ vmtest -k $KERNEL_REPO/arch/x86_64/boot/bzImage "./test_progs -vv -a test_bpffs"
> >      => bzImage
> >      ===> Booting
> >      ===> Setting up VM
> >      ===> Running command
> >      [    2.035210] bpf_testmod: loading out-of-tree module taints kernel.
> >      [    2.036510] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
> >      bpf_testmod.ko is already unloaded.
> >      Loading bpf_testmod.ko...
> >      Successfully loaded bpf_testmod.ko.
> >      test_test_bpffs:PASS:clone 0 nsec
> >      fn:PASS:unshare 0 nsec
> >      fn:PASS:mount / 0 nsec
> >      fn:PASS:accessing /etc/mtab 0 nsec
> >      fn:PASS:umount /sys/kernel/debug/tracing 0 nsec
> >      fn:PASS:umount /sys/kernel/debug 0 nsec
> >      fn:PASS:mount tmpfs 0 nsec
> >      fn:PASS:mkdir /sys/kernel/debug/fs1 0 nsec
> >      fn:PASS:mkdir /sys/kernel/debug/fs2 0 nsec
> >      fn:PASS:mount bpffs /sys/kernel/debug/fs1 0 nsec
> >      fn:PASS:mount bpffs /sys/kernel/debug/fs2 0 nsec
> >      fn:PASS:reading /sys/kernel/debug/fs1/maps.debug 0 nsec
> >      fn:PASS:reading /sys/kernel/debug/fs2/progs.debug 0 nsec
> >      fn:PASS:creating /sys/kernel/debug/fs1/a 0 nsec
> >      fn:PASS:creating /sys/kernel/debug/fs1/a/1 0 nsec
> >      fn:PASS:creating /sys/kernel/debug/fs1/b 0 nsec
> >      fn:PASS:create_map(ARRAY) 0 nsec
> >      fn:PASS:pin map 0 nsec
> >      fn:PASS:stat(/sys/kernel/debug/fs1/a) 0 nsec
> >      fn:PASS:renameat2(/fs1/a, /fs1/b, RENAME_EXCHANGE) 0 nsec
> >      fn:PASS:stat(/sys/kernel/debug/fs1/b) 0 nsec
> >      fn:PASS:b should have a's inode 0 nsec
> >      fn:PASS:access(/sys/kernel/debug/fs1/b/1) 0 nsec
> >      fn:PASS:stat(/sys/kernel/debug/fs1/map) 0 nsec
> >      fn:PASS:renameat2(/fs1/c, /fs1/b, RENAME_EXCHANGE) 0 nsec
> >      fn:PASS:stat(/sys/kernel/debug/fs1/b) 0 nsec
> >      fn:PASS:b should have c's inode 0 nsec
> >      fn:PASS:access(/sys/kernel/debug/fs1/c/1) 0 nsec
> >      fn:PASS:renameat2(RENAME_NOREPLACE) 0 nsec
> >      fn:PASS:access(/sys/kernel/debug/fs1/b) 0 nsec
> >      bpf_testmod.ko is already unloaded.
> >      Loading bpf_testmod.ko...
> >      Successfully loaded bpf_testmod.ko.
> >      test_test_bpffs:PASS:clone 0 nsec
> >      test_test_bpffs:PASS:waitpid 0 nsec
> >      test_test_bpffs:PASS:bpffs test  0 nsec
> >      #282     test_bpffs:OK
> >      Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> >      Successfully unloaded bpf_testmod.ko.
> > 
> > [0] https://github.com/danobi/vmtest
> > 
> > Signed-off-by: Manu Bretelle <chantr4@gmail.com>
> > ---
> >   .../selftests/bpf/prog_tests/test_bpffs.c     | 28 +++++++++++++++++++
> >   1 file changed, 28 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpffs.c b/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
> > index 214d9f4a94a5..001bf694c269 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
> > @@ -3,12 +3,14 @@
> >   #define _GNU_SOURCE
> >   #include <stdio.h>
> >   #include <sched.h>
> > +#include <mntent.h>
> >   #include <sys/mount.h>
> >   #include <sys/stat.h>
> >   #include <sys/types.h>
> >   #include <test_progs.h>
> >   #define TDIR "/sys/kernel/debug"
> > +#define MTAB "/etc/mtab"
> >   static int read_iter(char *file)
> >   {
> > @@ -32,6 +34,8 @@ static int read_iter(char *file)
> >   static int fn(void)
> >   {
> > +	/* A buffer to store logging messages */
> > +	char buf[1024];
> >   	struct stat a, b, c;
> >   	int err, map;
> > @@ -43,6 +47,30 @@ static int fn(void)
> >   	if (!ASSERT_OK(err, "mount /"))
> >   		goto out;
> > +	/* TDIR may have mounts below. unount them first */
> > +	FILE *mtab = setmntent(MTAB, "r");
> > +
> > +	if (!ASSERT_TRUE(mtab != NULL, "accessing " MTAB)) {
> > +		err = errno;
> > +		goto out;
> > +	}
> > +
> > +	struct mntent *mnt = NULL;
> > +
> > +	while ((mnt = getmntent(mtab)) != NULL) {
> > +		if (strlen(mnt->mnt_dir) > strlen(TDIR) &&
> > +			strncmp(TDIR, mnt->mnt_dir, strlen(TDIR)) == 0) {
> > +			snprintf(buf, sizeof(buf) - 1, "umount %s", mnt->mnt_dir);
> > +			err = umount(mnt->mnt_dir);
> > +			if (!ASSERT_OK(err, buf)) {
> > +				endmntent(mtab);
> > +				goto out;
> > +			}
> > +		}
> > +	}
> > +	// Ignore any error here
> > +	endmntent(mtab);
> > +
> >   	err = umount(TDIR);
> >   	if (!ASSERT_OK(err, "umount " TDIR))
> >   		goto out;

