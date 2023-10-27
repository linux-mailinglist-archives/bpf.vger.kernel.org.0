Return-Path: <bpf+bounces-13497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F10457DA22C
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 23:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A775028258D
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 21:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDAA3E01C;
	Fri, 27 Oct 2023 21:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5UJywM9"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829853C084
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 21:09:52 +0000 (UTC)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03F31AA
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 14:09:50 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-581edcde26cso1554155eaf.1
        for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 14:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698440990; x=1699045790; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9N7p32ZgabG26Y4G9iEEkKhkpmV+fD14DvV+yVoNdVs=;
        b=T5UJywM9iuBfNKgCaernBKQpR3pEX56N7W2NZO0R8X7/NS6xgnWAornG/Bix2sAXUm
         Qj3kR6dcRj8bKw0i7kYqXqoxTbvdNzikjnoksz2oGWoHhCOfggeqWZ/JHHSQsmZwrmGa
         HLSO5VXEnMtyAg2IWZgWsnHVL6yQmbsLRtmlEfTFfy3y3e0dGNASPxqb4zPZHM2Z8RKU
         cw6RirqfgoGYmk4T5z9rBV/FQcWcx0s4sXb1+7LxDGozz2A3Xp7fX8v4jC4rduFN35r3
         nj6DBWnNoHbpq6DrZXUvPJomMM1Ig+vvFiLXlzxdUMiBpNlBB7mvP4cv3ieSc2UCh9+O
         tInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698440990; x=1699045790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9N7p32ZgabG26Y4G9iEEkKhkpmV+fD14DvV+yVoNdVs=;
        b=WIU3HciYOglxbvkzcXbp3zuUDqoJEIJ0ZyEsztmhTtD0JU8AwS4JRokV4rYJSIVrkA
         P211nwx1nz3IxShY7VGOW00WSZF55s4A/6tjARGjKYf03vFAScx4qs15k02JbnTyLUcY
         XyquwelLJcu9NtZolYxqLikUTzOY+JuoHKfkJtR9Fr6h6K0dfuVOQ9sZurBCyBSA20Ho
         N3vl3aS8sfDlZfQ31Olk90uj5OMHWfQvMnJL7m8ImhU+nbIQazJqK1sW497YyaQW+E/W
         94TUNyh7B6fhmYZd3zs/Aioy9KaGB6yIEq/mbs4slR2DLaBSbwHGzUsIYufmEoxiZkYM
         sH8w==
X-Gm-Message-State: AOJu0YylnhbjMl9vCUcRsgR6JOM8N5PvpQf9x4GHBj9b5GWZdlpDvKx6
	XNnet+Q3k5eZRWhjpEgRfLc=
X-Google-Smtp-Source: AGHT+IHta7cF5Mo3LpeicWWgSHWajZ3iJfEe2ejaEI2F6xVmZ+E6pHws4IqaCdUtjOm/2GhAdLRV7A==
X-Received: by 2002:a05:6358:7252:b0:168:f55d:4ef9 with SMTP id i18-20020a056358725200b00168f55d4ef9mr5057899rwa.28.1698440989776;
        Fri, 27 Oct 2023 14:09:49 -0700 (PDT)
Received: from surya ([2600:1700:3ec2:2011:3ef3:bbdb:b46b:4676])
        by smtp.gmail.com with ESMTPSA id q25-20020a638c59000000b005ab281d0777sm1434463pgn.20.2023.10.27.14.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 14:09:49 -0700 (PDT)
Date: Fri, 27 Oct 2023 14:09:46 -0700
From: Manu Bretelle <chantr4@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Kui-Feng Lee <sinquersw@gmail.com>, ast@kernel.org, bpf@vger.kernel.org,
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
	sdf@google.com, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
	shuah@kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: umount children of TDIR in
 test_bpffs
Message-ID: <ZTwnGrDL9vwWlXJ7@surya>
References: <20231024201852.1512720-1-chantr4@gmail.com>
 <041a3ea2-8cc6-4f0f-8ed9-6ca459e5bbb7@gmail.com>
 <ZTiqp7URqNjqrSEk@surya>
 <6e4e46a2-77de-45d0-a1ec-b5622e1d75e0@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e4e46a2-77de-45d0-a1ec-b5622e1d75e0@linux.dev>

On Thu, Oct 26, 2023 at 11:08:35PM -0700, Yonghong Song wrote:
> 
> On 10/24/23 10:41 PM, Manu Bretelle wrote:
> > On Tue, Oct 24, 2023 at 02:29:19PM -0700, Kui-Feng Lee wrote:
> > > 
> > > On 10/24/23 13:18, Manu Bretelle wrote:
> > > > Currently this tests tries to umount /sys/kernel/debug (TDIR) but the
> > > > system it is running on may have mounts below.
> > > > 
> > > > For example, danobi/vmtest [0] VMs have
> > > >       mount -t tracefs tracefs /sys/kernel/debug/tracing
> > > > as part of their init.
> > > > 
> > > > This change list mounts and will umount any mounts below TDIR before
> > > > umounting TDIR itself.
> > > > 
> > > > Note that it is not umounting recursively, so in the case of a sub-mount
> > > > of TDIR  having another sub-mount, this will fail as mtab is ordered.
> > > Should we move TID to a random path likes "/sys/kernel/debug-<pid>/"?
> > > 
> > Fair point, I suppose we would want to keep TDIR a defined string as it does
> > simplify the gymnastic involved through the rest of the script, but yeah
> > looking at the original commit:
> > edb65ee5aa25 (selftests/bpf: Add bpffs preload test)
> > 
> > I don't see any reason to use an alternate directory and rather mkdir it vs
> > umounting the original one.
> > so something like
> > 
> >      #define TDIR "/sys/kernel/test_bpffs"
> > 
> > Would probably do.
> > 
> > Alexei could confirm his original intent probably.
> 
> 
> Maybe/sys/kernel/tracing should work too? Not sure whether it is universally
> available or not.
> 
> 

I think we just need an existing directory (whichever) to mount tmpfs on, and Alexei previous
comment seems to confirm that. But importantly, nothing that has sub-mounts
if we don't want to get into the business of recursively umounting sub-mounts.

I will just pick up a name which is random enough to not realistically exist on
a system, mkdir it instead of the existing umount(TDIR) and we should be good.


> > 
> > > > Test:
> > > > 
> > > > Originally:
> > > > 
> > > >       $ vmtest -k $KERNEL_REPO/arch/x86_64/boot/bzImage "./test_progs -vv -a test_bpffs"
> > > >       => bzImage
> > > >       ===> Booting
> > > >       ===> Setting up VM
> > > >       ===> Running command
> > > >       [    2.138818] bpf_testmod: loading out-of-tree module taints kernel.
> > > >       [    2.140913] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
> > > >       bpf_testmod.ko is already unloaded.
> > > >       Loading bpf_testmod.ko...
> > > >       Successfully loaded bpf_testmod.ko.
> > > >       test_test_bpffs:PASS:clone 0 nsec
> > > >       fn:PASS:unshare 0 nsec
> > > >       fn:PASS:mount / 0 nsec
> > > >       fn:FAIL:umount /sys/kernel/debug unexpected error: -1 (errno 16)
> > > >       bpf_testmod.ko is already unloaded.
> > > >       Loading bpf_testmod.ko...
> > > >       Successfully loaded bpf_testmod.ko.
> > > >       test_test_bpffs:PASS:clone 0 nsec
> > > >       test_test_bpffs:PASS:waitpid 0 nsec
> > > >       test_test_bpffs:FAIL:bpffs test  failed 255#282     test_bpffs:FAIL
> > > >       Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED
> > > >       Successfully unloaded bpf_testmod.ko.
> > > >       Command failed with exit code: 1
> > > > 
> > > > After this change:
> > > > 
> > > >       $ vmtest -k $KERNEL_REPO/arch/x86_64/boot/bzImage "./test_progs -vv -a test_bpffs"
> > > >       => bzImage
> > > >       ===> Booting
> > > >       ===> Setting up VM
> > > >       ===> Running command
> > > >       [    2.035210] bpf_testmod: loading out-of-tree module taints kernel.
> > > >       [    2.036510] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
> > > >       bpf_testmod.ko is already unloaded.
> > > >       Loading bpf_testmod.ko...
> > > >       Successfully loaded bpf_testmod.ko.
> > > >       test_test_bpffs:PASS:clone 0 nsec
> > > >       fn:PASS:unshare 0 nsec
> > > >       fn:PASS:mount / 0 nsec
> > > >       fn:PASS:accessing /etc/mtab 0 nsec
> > > >       fn:PASS:umount /sys/kernel/debug/tracing 0 nsec
> > > >       fn:PASS:umount /sys/kernel/debug 0 nsec
> > > >       fn:PASS:mount tmpfs 0 nsec
> > > >       fn:PASS:mkdir /sys/kernel/debug/fs1 0 nsec
> > > >       fn:PASS:mkdir /sys/kernel/debug/fs2 0 nsec
> > > >       fn:PASS:mount bpffs /sys/kernel/debug/fs1 0 nsec
> > > >       fn:PASS:mount bpffs /sys/kernel/debug/fs2 0 nsec
> > > >       fn:PASS:reading /sys/kernel/debug/fs1/maps.debug 0 nsec
> > > >       fn:PASS:reading /sys/kernel/debug/fs2/progs.debug 0 nsec
> > > >       fn:PASS:creating /sys/kernel/debug/fs1/a 0 nsec
> > > >       fn:PASS:creating /sys/kernel/debug/fs1/a/1 0 nsec
> > > >       fn:PASS:creating /sys/kernel/debug/fs1/b 0 nsec
> > > >       fn:PASS:create_map(ARRAY) 0 nsec
> > > >       fn:PASS:pin map 0 nsec
> > > >       fn:PASS:stat(/sys/kernel/debug/fs1/a) 0 nsec
> > > >       fn:PASS:renameat2(/fs1/a, /fs1/b, RENAME_EXCHANGE) 0 nsec
> > > >       fn:PASS:stat(/sys/kernel/debug/fs1/b) 0 nsec
> > > >       fn:PASS:b should have a's inode 0 nsec
> > > >       fn:PASS:access(/sys/kernel/debug/fs1/b/1) 0 nsec
> > > >       fn:PASS:stat(/sys/kernel/debug/fs1/map) 0 nsec
> > > >       fn:PASS:renameat2(/fs1/c, /fs1/b, RENAME_EXCHANGE) 0 nsec
> > > >       fn:PASS:stat(/sys/kernel/debug/fs1/b) 0 nsec
> > > >       fn:PASS:b should have c's inode 0 nsec
> > > >       fn:PASS:access(/sys/kernel/debug/fs1/c/1) 0 nsec
> > > >       fn:PASS:renameat2(RENAME_NOREPLACE) 0 nsec
> > > >       fn:PASS:access(/sys/kernel/debug/fs1/b) 0 nsec
> > > >       bpf_testmod.ko is already unloaded.
> > > >       Loading bpf_testmod.ko...
> > > >       Successfully loaded bpf_testmod.ko.
> > > >       test_test_bpffs:PASS:clone 0 nsec
> > > >       test_test_bpffs:PASS:waitpid 0 nsec
> > > >       test_test_bpffs:PASS:bpffs test  0 nsec
> > > >       #282     test_bpffs:OK
> > > >       Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> > > >       Successfully unloaded bpf_testmod.ko.
> > > > 
> > > > [0] https://github.com/danobi/vmtest
> > > > 
> > > > Signed-off-by: Manu Bretelle <chantr4@gmail.com>
> > > > ---
> > > >    .../selftests/bpf/prog_tests/test_bpffs.c     | 28 +++++++++++++++++++
> > > >    1 file changed, 28 insertions(+)
> > > > 
> > > > diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpffs.c b/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
> > > > index 214d9f4a94a5..001bf694c269 100644
> > > > --- a/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
> > > > +++ b/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
> > > > @@ -3,12 +3,14 @@
> > > >    #define _GNU_SOURCE
> > > >    #include <stdio.h>
> > > >    #include <sched.h>
> > > > +#include <mntent.h>
> > > >    #include <sys/mount.h>
> > > >    #include <sys/stat.h>
> > > >    #include <sys/types.h>
> > > >    #include <test_progs.h>
> > > >    #define TDIR "/sys/kernel/debug"
> > > > +#define MTAB "/etc/mtab"
> > > >    static int read_iter(char *file)
> > > >    {
> > > > @@ -32,6 +34,8 @@ static int read_iter(char *file)
> > > >    static int fn(void)
> > > >    {
> > > > +	/* A buffer to store logging messages */
> > > > +	char buf[1024];
> > > >    	struct stat a, b, c;
> > > >    	int err, map;
> > > > @@ -43,6 +47,30 @@ static int fn(void)
> > > >    	if (!ASSERT_OK(err, "mount /"))
> > > >    		goto out;
> > > > +	/* TDIR may have mounts below. unount them first */
> > > > +	FILE *mtab = setmntent(MTAB, "r");
> > > > +
> > > > +	if (!ASSERT_TRUE(mtab != NULL, "accessing " MTAB)) {
> > > > +		err = errno;
> > > > +		goto out;
> > > > +	}
> > > > +
> > > > +	struct mntent *mnt = NULL;
> > > > +
> > > > +	while ((mnt = getmntent(mtab)) != NULL) {
> > > > +		if (strlen(mnt->mnt_dir) > strlen(TDIR) &&
> > > > +			strncmp(TDIR, mnt->mnt_dir, strlen(TDIR)) == 0) {
> > > > +			snprintf(buf, sizeof(buf) - 1, "umount %s", mnt->mnt_dir);
> > > > +			err = umount(mnt->mnt_dir);
> > > > +			if (!ASSERT_OK(err, buf)) {
> > > > +				endmntent(mtab);
> > > > +				goto out;
> > > > +			}
> > > > +		}
> > > > +	}
> > > > +	// Ignore any error here
> > > > +	endmntent(mtab);
> > > > +
> > > >    	err = umount(TDIR);
> > > >    	if (!ASSERT_OK(err, "umount " TDIR))
> > > >    		goto out;

