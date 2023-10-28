Return-Path: <bpf+bounces-13535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5317DA4C4
	for <lists+bpf@lfdr.de>; Sat, 28 Oct 2023 04:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D832B282797
	for <lists+bpf@lfdr.de>; Sat, 28 Oct 2023 02:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A337F5;
	Sat, 28 Oct 2023 02:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vLXeaubW"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135D5644
	for <bpf@vger.kernel.org>; Sat, 28 Oct 2023 02:06:14 +0000 (UTC)
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82EBB8
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 19:06:12 -0700 (PDT)
Message-ID: <06ff963d-6d75-43dc-bb95-b1a5e977c6e6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698458770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tnRi1Re5DxWH4/yXd45aVAYaSsY0RO1OuhUcefz3FCY=;
	b=vLXeaubWteckKUjJZ4TDGSkGRSx0YHZdz15lmLQYChNyYFnG7x/MmOpPsRXYoiDnpJDAcc
	nSYBzunSkl5PrFD/M3qttTfdapNszFyyArliUjjLaGzHBoVNalKf4NuR5FWjiXoWJ0bjhz
	1NHKbMNqS5wswiyUzyC35Xx4nTWd5bI=
Date: Fri, 27 Oct 2023 19:06:01 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: fix test_bpffs
Content-Language: en-GB
To: Manu Bretelle <chantr4@gmail.com>, bpf@vger.kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 mykolal@fb.com, shuah@kernel.org
References: <20231027223006.2062967-1-chantr4@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231027223006.2062967-1-chantr4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 10/27/23 3:30 PM, Manu Bretelle wrote:
> Currently this tests tries to umount /sys/kernel/debug (TDIR) but the
> system it is running on may have mounts below.
>
> For example, danobi/vmtest [0] VMs have
>      mount -t tracefs tracefs /sys/kernel/debug/tracing
> as part of their init.
>
> This change instead creates a "random" directory under /tmp and uses this
> as TDIR.
> If the directory already exists, ignore the error and keep moving on.
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
>      [    2.119236] bpf_testmod: loading out-of-tree module taints kernel.
>      [    2.121768] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
>      bpf_testmod.ko is already unloaded.
>      Loading bpf_testmod.ko...
>      Successfully loaded bpf_testmod.ko.
>      test_test_bpffs:PASS:clone 0 nsec
>      fn:PASS:unshare 0 nsec
>      fn:PASS:mount / 0 nsec
>      fn:PASS:mount tmpfs 0 nsec
>      fn:PASS:mkdir /tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs1 0 nsec
>      fn:PASS:mkdir /tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs2 0 nsec
>      fn:PASS:mount bpffs /tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs1 0 nsec
>      fn:PASS:mount bpffs /tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs2 0 nsec
>      fn:PASS:reading /tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs1/maps.debug 0 nsec
>      fn:PASS:reading /tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs2/progs.debug 0 nsec
>      fn:PASS:creating /tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs1/a 0 nsec
>      fn:PASS:creating /tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs1/a/1 0 nsec
>      fn:PASS:creating /tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs1/b 0 nsec
>      fn:PASS:create_map(ARRAY) 0 nsec
>      fn:PASS:pin map 0 nsec
>      fn:PASS:stat(/tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs1/a) 0 nsec
>      fn:PASS:renameat2(/fs1/a, /fs1/b, RENAME_EXCHANGE) 0 nsec
>      fn:PASS:stat(/tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs1/b) 0 nsec
>      fn:PASS:b should have a's inode 0 nsec
>      fn:PASS:access(/tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs1/b/1) 0 nsec
>      fn:PASS:stat(/tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs1/map) 0 nsec
>      fn:PASS:renameat2(/fs1/c, /fs1/b, RENAME_EXCHANGE) 0 nsec
>      fn:PASS:stat(/tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs1/b) 0 nsec
>      fn:PASS:b should have c's inode 0 nsec
>      fn:PASS:access(/tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs1/c/1) 0 nsec
>      fn:PASS:renameat2(RENAME_NOREPLACE) 0 nsec
>      fn:PASS:access(/tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs1/b) 0 nsec
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
> This is a follow-up of https://lore.kernel.org/bpf/20231024201852.1512720-1-chantr4@gmail.com/T/
>
> Signed-off-by: Manu Bretelle <chantr4@gmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


