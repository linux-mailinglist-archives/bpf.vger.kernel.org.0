Return-Path: <bpf+bounces-13805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE6E7DE26D
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 15:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3A2A2817A7
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 14:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65402107BC;
	Wed,  1 Nov 2023 14:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpjChWNq"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB1B63D7
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 14:40:44 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C59119
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 07:40:42 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53e751aeb3cso11254258a12.2
        for <bpf@vger.kernel.org>; Wed, 01 Nov 2023 07:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698849640; x=1699454440; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8CuvmJJxzYp2d4cJnmQI6LdEfuRAU53+pSRlViwIyqM=;
        b=ZpjChWNqkXimz8dWfCCWihlLYckf3me+LHGomdH+J66/IX2I6Zm0c6m7cTpMWQvcqj
         4Cn3Bjm+19Ax5cKgKUlerUwW/1EOyWmDGdGhk8VDo5vGoryXcgGLy0Q/bEdSqakyQ1JX
         TyzpjIY1bRgpqYaEtT1GHhwKhdYQYhdBFJ64mVTvuVxgLde2AzGzL1D7rTXLikuWBGMV
         y3K093wN8SjJ5MLyptnZoPFsaTF8KVjcqLUqAwdoqrKtSuhHPKIGtn2J9f620ABfPPIg
         qmDMPJCwuzIzWdMcs5NiwQvR5zdGpNVZJQ9VVZyTxiGV+wRnavM0BAhPI+9M4+quZP1G
         PMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698849640; x=1699454440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8CuvmJJxzYp2d4cJnmQI6LdEfuRAU53+pSRlViwIyqM=;
        b=amvJ2Nzcj5A8rOKnx4y6xB6/FcjYIz6mZnTB8bn6MJphoLbTQBuTvCvFzLqtkwQSx/
         0YMYYxEa9TqM7TVJL759ldUK6Z3F5sHjwWxrhJW63XMn8AfxZ0fNOOvIxKur4VI3LZJ6
         VJBdAKS/lA+W2DEvsI7EUyHAa0/Oh/7Su3nq6+I6WDhh15az+Pd6JMd4v2hY8JQRAV0x
         /JYYdQOxztvBKMvfqFGjmHMwGWt0Yu5XOQ1rpPWU6xZ6t2ijoDtE31zG7VGlzCBZa1wj
         8al67+PYOcabm2RFfsVS5zZhNEYL7HI1l8eV5HG6wk9Zcl5AfTzd+uJI0kGyi5KuSGOM
         m2Qw==
X-Gm-Message-State: AOJu0Yw+Wej5WtMXa+i8/0mscpG2I23DrA/SwmQuhwOV4XOWWIi7hEyw
	ePoTySLF2RwTLH1OTxhHUSA=
X-Google-Smtp-Source: AGHT+IHIMLz+itjhSU1eMmyv4cXLIQMrTRvqbWhOGS9bRjvUoU/e7aAScxMOH9ifA7KI5fKibf0inA==
X-Received: by 2002:aa7:de15:0:b0:53d:eca9:742e with SMTP id h21-20020aa7de15000000b0053deca9742emr14759357edv.9.1698849640415;
        Wed, 01 Nov 2023 07:40:40 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id i2-20020a50d742000000b005333922efb0sm1169871edj.78.2023.11.01.07.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 07:40:39 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 1 Nov 2023 15:40:37 +0100
To: Manu Bretelle <chantr4@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net,
	ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	mykolal@fb.com, shuah@kernel.org
Subject: Re: [PATCH bpf-next v2] selftests/bpf: fix test_bpffs
Message-ID: <ZUJjZR6AHRdNYVHu@krava>
References: <20231031223606.2927976-1-chantr4@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031223606.2927976-1-chantr4@gmail.com>

On Tue, Oct 31, 2023 at 03:36:06PM -0700, Manu Bretelle wrote:

SNIP

> After this change:
> 
>     $ vmtest -k $(make image_name) 'cd tools/testing/selftests/bpf && ./test_progs -vv -a test_bpffs'
>     => bzImage
>     ===> Booting
>     ===> Setting up VM
>     ===> Running command
>     [    2.295696] bpf_testmod: loading out-of-tree module taints kernel.
>     [    2.296468] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
>     bpf_testmod.ko is already unloaded.
>     Loading bpf_testmod.ko...
>     Successfully loaded bpf_testmod.ko.
>     test_test_bpffs:PASS:clone 0 nsec
>     fn:PASS:unshare 0 nsec
>     fn:PASS:mount / 0 nsec
>     fn:PASS:mount tmpfs 0 nsec
>     fn:PASS:mkdir /tmp/test_bpffs_testdir/fs1 0 nsec
>     fn:PASS:mkdir /tmp/test_bpffs_testdir/fs2 0 nsec
>     fn:PASS:mount bpffs /tmp/test_bpffs_testdir/fs1 0 nsec
>     fn:PASS:mount bpffs /tmp/test_bpffs_testdir/fs2 0 nsec
>     fn:PASS:reading /tmp/test_bpffs_testdir/fs1/maps.debug 0 nsec
>     fn:PASS:reading /tmp/test_bpffs_testdir/fs2/progs.debug 0 nsec
>     fn:PASS:creating /tmp/test_bpffs_testdir/fs1/a 0 nsec
>     fn:PASS:creating /tmp/test_bpffs_testdir/fs1/a/1 0 nsec
>     fn:PASS:creating /tmp/test_bpffs_testdir/fs1/b 0 nsec
>     fn:PASS:create_map(ARRAY) 0 nsec
>     fn:PASS:pin map 0 nsec
>     fn:PASS:stat(/tmp/test_bpffs_testdir/fs1/a) 0 nsec
>     fn:PASS:renameat2(/fs1/a, /fs1/b, RENAME_EXCHANGE) 0 nsec
>     fn:PASS:stat(/tmp/test_bpffs_testdir/fs1/b) 0 nsec
>     fn:PASS:b should have a's inode 0 nsec
>     fn:PASS:access(/tmp/test_bpffs_testdir/fs1/b/1) 0 nsec
>     fn:PASS:stat(/tmp/test_bpffs_testdir/fs1/map) 0 nsec
>     fn:PASS:renameat2(/fs1/c, /fs1/b, RENAME_EXCHANGE) 0 nsec
>     fn:PASS:stat(/tmp/test_bpffs_testdir/fs1/b) 0 nsec
>     fn:PASS:b should have c's inode 0 nsec
>     fn:PASS:access(/tmp/test_bpffs_testdir/fs1/c/1) 0 nsec
>     fn:PASS:renameat2(RENAME_NOREPLACE) 0 nsec
>     fn:PASS:access(/tmp/test_bpffs_testdir/fs1/b) 0 nsec
>     bpf_testmod.ko is already unloaded.
>     Loading bpf_testmod.ko...
>     Successfully loaded bpf_testmod.ko.
>     test_test_bpffs:PASS:clone 0 nsec
>     test_test_bpffs:PASS:waitpid 0 nsec
>     test_test_bpffs:PASS:bpffs test  0 nsec
>     #282     test_bpffs:OK
>     Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
>     Successfully unloaded bpf_testmod.ko.
> 
> [0] https://github.com/danobi/vmtest
> 
> This is a follow-up of https://lore.kernel.org/bpf/20231024201852.1512720-1-chantr4@gmail.com/T/
> 
> v1 -> v2:
>   - use a TDIR name that is related to test
>   - use C-style comments

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
> Signed-off-by: Manu Bretelle <chantr4@gmail.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/test_bpffs.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpffs.c b/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
> index 214d9f4a94a5..ea933fd151c3 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
> @@ -8,7 +8,8 @@
>  #include <sys/types.h>
>  #include <test_progs.h>
>  
> -#define TDIR "/sys/kernel/debug"
> +/* TDIR must be in a location we can create a directory in. */
> +#define TDIR "/tmp/test_bpffs_testdir"
>  
>  static int read_iter(char *file)
>  {
> @@ -43,8 +44,11 @@ static int fn(void)
>  	if (!ASSERT_OK(err, "mount /"))
>  		goto out;
>  
> -	err = umount(TDIR);
> -	if (!ASSERT_OK(err, "umount " TDIR))
> +	err =  mkdir(TDIR, 0777);
> +	/* If the directory already exists we can carry on. It may be left over
> +	 * from a previous run.
> +	 */
> +	if ((err && errno != EEXIST) && !ASSERT_OK(err, "mkdir " TDIR))
>  		goto out;
>  
>  	err = mount("none", TDIR, "tmpfs", 0, NULL);
> @@ -138,6 +142,7 @@ static int fn(void)
>  	rmdir(TDIR "/fs1");
>  	rmdir(TDIR "/fs2");
>  	umount(TDIR);
> +	rmdir(TDIR);
>  	exit(err);
>  }
>  
> -- 
> 2.40.1
> 

