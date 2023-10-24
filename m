Return-Path: <bpf+bounces-13162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E397D5D38
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 23:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E900B2113F
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 21:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61EA3FB06;
	Tue, 24 Oct 2023 21:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmTX4DVA"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B103CD06
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 21:29:24 +0000 (UTC)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DF5A6
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 14:29:23 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-da043b5b6c9so965182276.2
        for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 14:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698182962; x=1698787762; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l92rQ76HobRkm7FnVIOgX18pEo5/pUc349OtpLhkFZo=;
        b=TmTX4DVAT8OT6+K60jMY8grEevnbp0HvvEbPLtGTicuhtrwqE+KnhnJRGHKM0g+yEK
         In1Kb6E2JmsnJqUS5TNU0j2w9XtaTMPZ9vY3Sm13nxkGVJsCldCV7Ckv0Clr/nwsDpd2
         lOyYyc2Imdp+bwqHmvYriAnN/3LZacfyJLr22ba+/LcPT9yp6t54xOFtlx0jhGSrmJ89
         B4T5orjM8/Kb2Bwg8iLNHMgiN+w4xzdps6IICRwM8R21R4Jwxj42W6UTGxzdHfMLoadH
         o/D9jyZ+Hm6yrlczb7j4ZPd4k5fC9OAFPygv2Hg8T0xvMSlT+BFGNq41LrRyJ2OZkr0p
         60FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698182962; x=1698787762;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l92rQ76HobRkm7FnVIOgX18pEo5/pUc349OtpLhkFZo=;
        b=JgMlH7va4bWd9rMOQsnwIvUHX0Pgcrs1L/hErgttgPGT3Ggfgpl8V2GZdLB4n6Z440
         Ag/XkLMnjF878sQkO5b+wozb4Ed+ewJizM59xFJ4yragS+47C7Ig/9yCk/2DSh9LBbCm
         kB605JoiKxvvEefZ04NwX/xNaXfOtXZdUrQZ2B1eFJKj08nm0Fa+Ke1PEzvy3HVpP9u4
         uXpG14TLVxpLGVFRsIzOshuXB0FAId8gYzz8w7JHEdCpXmLzQdJnXwT/GJn8ufcrODrG
         cUhmnRMJNjZX7SVEQXQb41LagWQe/wPDfGdRC38njf0yrPHPAkq4gINRYNtB1lR9/u6X
         zrGA==
X-Gm-Message-State: AOJu0YxZtMZON7YVerFtD+21I5B8X4xHkmSBh35RFMa48fLZOLkflxFp
	l+HIOflNoDA/OqTF09HYKkE=
X-Google-Smtp-Source: AGHT+IEo8Dow7/eyM/VTLsqJih7wwcvO/uKAN9GKITRRuyTyUavsXlwfkugc13+JOohIRe5SxlYfMw==
X-Received: by 2002:a25:fe0b:0:b0:d9d:39af:2feb with SMTP id k11-20020a25fe0b000000b00d9d39af2febmr8595912ybe.50.1698182962299;
        Tue, 24 Oct 2023 14:29:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:89d2:1af8:8439:b81? ([2600:1700:6cf8:1240:89d2:1af8:8439:b81])
        by smtp.gmail.com with ESMTPSA id c15-20020a25c00f000000b00d9a43500f1dsm3860785ybf.28.2023.10.24.14.29.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 14:29:21 -0700 (PDT)
Message-ID: <041a3ea2-8cc6-4f0f-8ed9-6ca459e5bbb7@gmail.com>
Date: Tue, 24 Oct 2023 14:29:19 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftests/bpf: umount children of TDIR in
 test_bpffs
Content-Language: en-US
To: Manu Bretelle <chantr4@gmail.com>, bpf@vger.kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org
References: <20231024201852.1512720-1-chantr4@gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20231024201852.1512720-1-chantr4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/24/23 13:18, Manu Bretelle wrote:
> Currently this tests tries to umount /sys/kernel/debug (TDIR) but the
> system it is running on may have mounts below.
> 
> For example, danobi/vmtest [0] VMs have
>      mount -t tracefs tracefs /sys/kernel/debug/tracing
> as part of their init.
> 
> This change list mounts and will umount any mounts below TDIR before
> umounting TDIR itself.
> 
> Note that it is not umounting recursively, so in the case of a sub-mount
> of TDIR  having another sub-mount, this will fail as mtab is ordered.

Should we move TID to a random path likes "/sys/kernel/debug-<pid>/"?

> 
> Test:
> 
> Originally:
> 
>      $ vmtest -k $KERNEL_REPO/arch/x86_64/boot/bzImage "./test_progs -vv -a test_bpffs"
>      => bzImage
>      ===> Booting
>      ===> Setting up VM
>      ===> Running command
>      [    2.138818] bpf_testmod: loading out-of-tree module taints kernel.
>      [    2.140913] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
>      bpf_testmod.ko is already unloaded.
>      Loading bpf_testmod.ko...
>      Successfully loaded bpf_testmod.ko.
>      test_test_bpffs:PASS:clone 0 nsec
>      fn:PASS:unshare 0 nsec
>      fn:PASS:mount / 0 nsec
>      fn:FAIL:umount /sys/kernel/debug unexpected error: -1 (errno 16)
>      bpf_testmod.ko is already unloaded.
>      Loading bpf_testmod.ko...
>      Successfully loaded bpf_testmod.ko.
>      test_test_bpffs:PASS:clone 0 nsec
>      test_test_bpffs:PASS:waitpid 0 nsec
>      test_test_bpffs:FAIL:bpffs test  failed 255#282     test_bpffs:FAIL
>      Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED
>      Successfully unloaded bpf_testmod.ko.
>      Command failed with exit code: 1
> 
> After this change:
> 
>      $ vmtest -k $KERNEL_REPO/arch/x86_64/boot/bzImage "./test_progs -vv -a test_bpffs"
>      => bzImage
>      ===> Booting
>      ===> Setting up VM
>      ===> Running command
>      [    2.035210] bpf_testmod: loading out-of-tree module taints kernel.
>      [    2.036510] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
>      bpf_testmod.ko is already unloaded.
>      Loading bpf_testmod.ko...
>      Successfully loaded bpf_testmod.ko.
>      test_test_bpffs:PASS:clone 0 nsec
>      fn:PASS:unshare 0 nsec
>      fn:PASS:mount / 0 nsec
>      fn:PASS:accessing /etc/mtab 0 nsec
>      fn:PASS:umount /sys/kernel/debug/tracing 0 nsec
>      fn:PASS:umount /sys/kernel/debug 0 nsec
>      fn:PASS:mount tmpfs 0 nsec
>      fn:PASS:mkdir /sys/kernel/debug/fs1 0 nsec
>      fn:PASS:mkdir /sys/kernel/debug/fs2 0 nsec
>      fn:PASS:mount bpffs /sys/kernel/debug/fs1 0 nsec
>      fn:PASS:mount bpffs /sys/kernel/debug/fs2 0 nsec
>      fn:PASS:reading /sys/kernel/debug/fs1/maps.debug 0 nsec
>      fn:PASS:reading /sys/kernel/debug/fs2/progs.debug 0 nsec
>      fn:PASS:creating /sys/kernel/debug/fs1/a 0 nsec
>      fn:PASS:creating /sys/kernel/debug/fs1/a/1 0 nsec
>      fn:PASS:creating /sys/kernel/debug/fs1/b 0 nsec
>      fn:PASS:create_map(ARRAY) 0 nsec
>      fn:PASS:pin map 0 nsec
>      fn:PASS:stat(/sys/kernel/debug/fs1/a) 0 nsec
>      fn:PASS:renameat2(/fs1/a, /fs1/b, RENAME_EXCHANGE) 0 nsec
>      fn:PASS:stat(/sys/kernel/debug/fs1/b) 0 nsec
>      fn:PASS:b should have a's inode 0 nsec
>      fn:PASS:access(/sys/kernel/debug/fs1/b/1) 0 nsec
>      fn:PASS:stat(/sys/kernel/debug/fs1/map) 0 nsec
>      fn:PASS:renameat2(/fs1/c, /fs1/b, RENAME_EXCHANGE) 0 nsec
>      fn:PASS:stat(/sys/kernel/debug/fs1/b) 0 nsec
>      fn:PASS:b should have c's inode 0 nsec
>      fn:PASS:access(/sys/kernel/debug/fs1/c/1) 0 nsec
>      fn:PASS:renameat2(RENAME_NOREPLACE) 0 nsec
>      fn:PASS:access(/sys/kernel/debug/fs1/b) 0 nsec
>      bpf_testmod.ko is already unloaded.
>      Loading bpf_testmod.ko...
>      Successfully loaded bpf_testmod.ko.
>      test_test_bpffs:PASS:clone 0 nsec
>      test_test_bpffs:PASS:waitpid 0 nsec
>      test_test_bpffs:PASS:bpffs test  0 nsec
>      #282     test_bpffs:OK
>      Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
>      Successfully unloaded bpf_testmod.ko.
> 
> [0] https://github.com/danobi/vmtest
> 
> Signed-off-by: Manu Bretelle <chantr4@gmail.com>
> ---
>   .../selftests/bpf/prog_tests/test_bpffs.c     | 28 +++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpffs.c b/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
> index 214d9f4a94a5..001bf694c269 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
> @@ -3,12 +3,14 @@
>   #define _GNU_SOURCE
>   #include <stdio.h>
>   #include <sched.h>
> +#include <mntent.h>
>   #include <sys/mount.h>
>   #include <sys/stat.h>
>   #include <sys/types.h>
>   #include <test_progs.h>
>   
>   #define TDIR "/sys/kernel/debug"
> +#define MTAB "/etc/mtab"
>   
>   static int read_iter(char *file)
>   {
> @@ -32,6 +34,8 @@ static int read_iter(char *file)
>   
>   static int fn(void)
>   {
> +	/* A buffer to store logging messages */
> +	char buf[1024];
>   	struct stat a, b, c;
>   	int err, map;
>   
> @@ -43,6 +47,30 @@ static int fn(void)
>   	if (!ASSERT_OK(err, "mount /"))
>   		goto out;
>   
> +	/* TDIR may have mounts below. unount them first */
> +	FILE *mtab = setmntent(MTAB, "r");
> +
> +	if (!ASSERT_TRUE(mtab != NULL, "accessing " MTAB)) {
> +		err = errno;
> +		goto out;
> +	}
> +
> +	struct mntent *mnt = NULL;
> +
> +	while ((mnt = getmntent(mtab)) != NULL) {
> +		if (strlen(mnt->mnt_dir) > strlen(TDIR) &&
> +			strncmp(TDIR, mnt->mnt_dir, strlen(TDIR)) == 0) {
> +			snprintf(buf, sizeof(buf) - 1, "umount %s", mnt->mnt_dir);
> +			err = umount(mnt->mnt_dir);
> +			if (!ASSERT_OK(err, buf)) {
> +				endmntent(mtab);
> +				goto out;
> +			}
> +		}
> +	}
> +	// Ignore any error here
> +	endmntent(mtab);
> +
>   	err = umount(TDIR);
>   	if (!ASSERT_OK(err, "umount " TDIR))
>   		goto out;

