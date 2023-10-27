Return-Path: <bpf+bounces-13401-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 737667D8E74
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 08:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C48A5B21373
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 06:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C338C12;
	Fri, 27 Oct 2023 06:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WCc7Yv70"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681B58BFB
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 06:08:51 +0000 (UTC)
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE33D1AD
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 23:08:49 -0700 (PDT)
Message-ID: <6e4e46a2-77de-45d0-a1ec-b5622e1d75e0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698386928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qg+TtUC4ZIyGyUu7Sh70Xkk2yNumDl3u4A3ebUc+4TE=;
	b=WCc7Yv70JmjDer8JR5oxdrdep/j9aBPcsdgOyuyGL3ZNLLIjeyRkLSlcvL6Bq9EbyMA7rI
	0d6VK2nODoZCNWcCXIjIhtkVD7f9CFZnHsPpagIDy6e0QP2cyof/KuiXuU3H1xQp3EsfAn
	Ie88xyRPL7lGipqal5TYuBg8yCgvdPQ=
Date: Thu, 26 Oct 2023 23:08:35 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: umount children of TDIR in
 test_bpffs
Content-Language: en-GB
To: Manu Bretelle <chantr4@gmail.com>, Kui-Feng Lee <sinquersw@gmail.com>,
 ast@kernel.org
Cc: bpf@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 mykolal@fb.com, shuah@kernel.org
References: <20231024201852.1512720-1-chantr4@gmail.com>
 <041a3ea2-8cc6-4f0f-8ed9-6ca459e5bbb7@gmail.com> <ZTiqp7URqNjqrSEk@surya>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <ZTiqp7URqNjqrSEk@surya>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 10/24/23 10:41 PM, Manu Bretelle wrote:
> On Tue, Oct 24, 2023 at 02:29:19PM -0700, Kui-Feng Lee wrote:
>>
>> On 10/24/23 13:18, Manu Bretelle wrote:
>>> Currently this tests tries to umount /sys/kernel/debug (TDIR) but the
>>> system it is running on may have mounts below.
>>>
>>> For example, danobi/vmtest [0] VMs have
>>>       mount -t tracefs tracefs /sys/kernel/debug/tracing
>>> as part of their init.
>>>
>>> This change list mounts and will umount any mounts below TDIR before
>>> umounting TDIR itself.
>>>
>>> Note that it is not umounting recursively, so in the case of a sub-mount
>>> of TDIR  having another sub-mount, this will fail as mtab is ordered.
>> Should we move TID to a random path likes "/sys/kernel/debug-<pid>/"?
>>
> Fair point, I suppose we would want to keep TDIR a defined string as it does
> simplify the gymnastic involved through the rest of the script, but yeah
> looking at the original commit:
> edb65ee5aa25 (selftests/bpf: Add bpffs preload test)
>
> I don't see any reason to use an alternate directory and rather mkdir it vs
> umounting the original one.
> so something like
>
>      #define TDIR "/sys/kernel/test_bpffs"
>
> Would probably do.
>
> Alexei could confirm his original intent probably.


Maybe/sys/kernel/tracing should work too? Not sure whether it is universally 
available or not.


>
>>> Test:
>>>
>>> Originally:
>>>
>>>       $ vmtest -k $KERNEL_REPO/arch/x86_64/boot/bzImage "./test_progs -vv -a test_bpffs"
>>>       => bzImage
>>>       ===> Booting
>>>       ===> Setting up VM
>>>       ===> Running command
>>>       [    2.138818] bpf_testmod: loading out-of-tree module taints kernel.
>>>       [    2.140913] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
>>>       bpf_testmod.ko is already unloaded.
>>>       Loading bpf_testmod.ko...
>>>       Successfully loaded bpf_testmod.ko.
>>>       test_test_bpffs:PASS:clone 0 nsec
>>>       fn:PASS:unshare 0 nsec
>>>       fn:PASS:mount / 0 nsec
>>>       fn:FAIL:umount /sys/kernel/debug unexpected error: -1 (errno 16)
>>>       bpf_testmod.ko is already unloaded.
>>>       Loading bpf_testmod.ko...
>>>       Successfully loaded bpf_testmod.ko.
>>>       test_test_bpffs:PASS:clone 0 nsec
>>>       test_test_bpffs:PASS:waitpid 0 nsec
>>>       test_test_bpffs:FAIL:bpffs test  failed 255#282     test_bpffs:FAIL
>>>       Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED
>>>       Successfully unloaded bpf_testmod.ko.
>>>       Command failed with exit code: 1
>>>
>>> After this change:
>>>
>>>       $ vmtest -k $KERNEL_REPO/arch/x86_64/boot/bzImage "./test_progs -vv -a test_bpffs"
>>>       => bzImage
>>>       ===> Booting
>>>       ===> Setting up VM
>>>       ===> Running command
>>>       [    2.035210] bpf_testmod: loading out-of-tree module taints kernel.
>>>       [    2.036510] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
>>>       bpf_testmod.ko is already unloaded.
>>>       Loading bpf_testmod.ko...
>>>       Successfully loaded bpf_testmod.ko.
>>>       test_test_bpffs:PASS:clone 0 nsec
>>>       fn:PASS:unshare 0 nsec
>>>       fn:PASS:mount / 0 nsec
>>>       fn:PASS:accessing /etc/mtab 0 nsec
>>>       fn:PASS:umount /sys/kernel/debug/tracing 0 nsec
>>>       fn:PASS:umount /sys/kernel/debug 0 nsec
>>>       fn:PASS:mount tmpfs 0 nsec
>>>       fn:PASS:mkdir /sys/kernel/debug/fs1 0 nsec
>>>       fn:PASS:mkdir /sys/kernel/debug/fs2 0 nsec
>>>       fn:PASS:mount bpffs /sys/kernel/debug/fs1 0 nsec
>>>       fn:PASS:mount bpffs /sys/kernel/debug/fs2 0 nsec
>>>       fn:PASS:reading /sys/kernel/debug/fs1/maps.debug 0 nsec
>>>       fn:PASS:reading /sys/kernel/debug/fs2/progs.debug 0 nsec
>>>       fn:PASS:creating /sys/kernel/debug/fs1/a 0 nsec
>>>       fn:PASS:creating /sys/kernel/debug/fs1/a/1 0 nsec
>>>       fn:PASS:creating /sys/kernel/debug/fs1/b 0 nsec
>>>       fn:PASS:create_map(ARRAY) 0 nsec
>>>       fn:PASS:pin map 0 nsec
>>>       fn:PASS:stat(/sys/kernel/debug/fs1/a) 0 nsec
>>>       fn:PASS:renameat2(/fs1/a, /fs1/b, RENAME_EXCHANGE) 0 nsec
>>>       fn:PASS:stat(/sys/kernel/debug/fs1/b) 0 nsec
>>>       fn:PASS:b should have a's inode 0 nsec
>>>       fn:PASS:access(/sys/kernel/debug/fs1/b/1) 0 nsec
>>>       fn:PASS:stat(/sys/kernel/debug/fs1/map) 0 nsec
>>>       fn:PASS:renameat2(/fs1/c, /fs1/b, RENAME_EXCHANGE) 0 nsec
>>>       fn:PASS:stat(/sys/kernel/debug/fs1/b) 0 nsec
>>>       fn:PASS:b should have c's inode 0 nsec
>>>       fn:PASS:access(/sys/kernel/debug/fs1/c/1) 0 nsec
>>>       fn:PASS:renameat2(RENAME_NOREPLACE) 0 nsec
>>>       fn:PASS:access(/sys/kernel/debug/fs1/b) 0 nsec
>>>       bpf_testmod.ko is already unloaded.
>>>       Loading bpf_testmod.ko...
>>>       Successfully loaded bpf_testmod.ko.
>>>       test_test_bpffs:PASS:clone 0 nsec
>>>       test_test_bpffs:PASS:waitpid 0 nsec
>>>       test_test_bpffs:PASS:bpffs test  0 nsec
>>>       #282     test_bpffs:OK
>>>       Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
>>>       Successfully unloaded bpf_testmod.ko.
>>>
>>> [0] https://github.com/danobi/vmtest
>>>
>>> Signed-off-by: Manu Bretelle <chantr4@gmail.com>
>>> ---
>>>    .../selftests/bpf/prog_tests/test_bpffs.c     | 28 +++++++++++++++++++
>>>    1 file changed, 28 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpffs.c b/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
>>> index 214d9f4a94a5..001bf694c269 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
>>> @@ -3,12 +3,14 @@
>>>    #define _GNU_SOURCE
>>>    #include <stdio.h>
>>>    #include <sched.h>
>>> +#include <mntent.h>
>>>    #include <sys/mount.h>
>>>    #include <sys/stat.h>
>>>    #include <sys/types.h>
>>>    #include <test_progs.h>
>>>    #define TDIR "/sys/kernel/debug"
>>> +#define MTAB "/etc/mtab"
>>>    static int read_iter(char *file)
>>>    {
>>> @@ -32,6 +34,8 @@ static int read_iter(char *file)
>>>    static int fn(void)
>>>    {
>>> +	/* A buffer to store logging messages */
>>> +	char buf[1024];
>>>    	struct stat a, b, c;
>>>    	int err, map;
>>> @@ -43,6 +47,30 @@ static int fn(void)
>>>    	if (!ASSERT_OK(err, "mount /"))
>>>    		goto out;
>>> +	/* TDIR may have mounts below. unount them first */
>>> +	FILE *mtab = setmntent(MTAB, "r");
>>> +
>>> +	if (!ASSERT_TRUE(mtab != NULL, "accessing " MTAB)) {
>>> +		err = errno;
>>> +		goto out;
>>> +	}
>>> +
>>> +	struct mntent *mnt = NULL;
>>> +
>>> +	while ((mnt = getmntent(mtab)) != NULL) {
>>> +		if (strlen(mnt->mnt_dir) > strlen(TDIR) &&
>>> +			strncmp(TDIR, mnt->mnt_dir, strlen(TDIR)) == 0) {
>>> +			snprintf(buf, sizeof(buf) - 1, "umount %s", mnt->mnt_dir);
>>> +			err = umount(mnt->mnt_dir);
>>> +			if (!ASSERT_OK(err, buf)) {
>>> +				endmntent(mtab);
>>> +				goto out;
>>> +			}
>>> +		}
>>> +	}
>>> +	// Ignore any error here
>>> +	endmntent(mtab);
>>> +
>>>    	err = umount(TDIR);
>>>    	if (!ASSERT_OK(err, "umount " TDIR))
>>>    		goto out;

