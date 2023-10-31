Return-Path: <bpf+bounces-13692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E72E27DC68D
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 07:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0B871C20B2C
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 06:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CB010790;
	Tue, 31 Oct 2023 06:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNAzYiak"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3AD10780
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 06:29:58 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C910A2
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 23:29:56 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9c603e2354fso1079019866b.1
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 23:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698733794; x=1699338594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjxbZIH/RJ+zw4P1twblI5Q8opl+YL2IWL18np/wfsg=;
        b=PNAzYiakFnwqSjZidX+seTPDK7nd/r17bzL60rXazB4/VF3IGbhM5bbeaj2ooJRsvb
         BzqfV+4hV3cA1PZPu7X0FsCrGa2VXDeoYUMyLmOYjXCe4m3OsDwHdufXmMAop0kk+5vD
         veokZmDrOwYvixwSUlvsEghghtThSZUzf9na/mQDaSni/hATcI6uR+IAqnYce2D2T2bE
         9ZFE6sS8DBjeRZ3mt23zjH/6XoPVTr78QJ6i4wXDE+TH0qXmj5sl/2h3XhEJuH7hDAZv
         9YzAeUfmgMDVGQ0XprxGl11vVNXjkmQ8dWclsS0pABe2HUShDcidHx9PmBR6t19kHyRL
         tARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698733794; x=1699338594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DjxbZIH/RJ+zw4P1twblI5Q8opl+YL2IWL18np/wfsg=;
        b=Y3yi9QjeSVBt2N5EoA8byvrVWCapgAe1ItgPlVNGpJSfXr0tHiAXEzl+vMdmBK6SEu
         N88VKWuy2BnjXE6E8XiamiGrtwRgAqnUTdd1GAiCXpi8B2JAfdyujLGspDPrvYn42Yuk
         +V6Em8ASuHZDy9OzPvpirVGnGozexijENMHGZv71gNXk0oOkPAx0NkbHJWN3H9P2sdsv
         d5Ta87fwAGbdyO0AYwrKyPjDogONSVwYLRz+3/qGZMWPBENMUnPJ2ltAOi3Cwcjm/1oY
         gOJLn+XIsOQsqcmKFBUhvdBBkCEuzdewTKSRgFMOJw3GBskIrWanVKAANNgFPS8dsqSo
         0GKQ==
X-Gm-Message-State: AOJu0YxSaQEPxusB8LG9zqz8jyHoa3rv30peds1CrcV+ryiX1TanxYXi
	82E3MGw//bTyf6Ew+UGzxuq+x5f4v7lyIohbb7A=
X-Google-Smtp-Source: AGHT+IFijXeIYJUf7S93hKWof0gmImQtKypzP2Aofj/RUP6Re/nvedlE+2meN8uYUE55Ll0z71fpD7a+/BzCqsjUxYU=
X-Received: by 2002:a17:906:bcd7:b0:9ad:8641:e91b with SMTP id
 lw23-20020a170906bcd700b009ad8641e91bmr1531816ejb.11.1698733794540; Mon, 30
 Oct 2023 23:29:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027223006.2062967-1-chantr4@gmail.com>
In-Reply-To: <20231027223006.2062967-1-chantr4@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 30 Oct 2023 23:29:43 -0700
Message-ID: <CAEf4BzbpvwJiuxfn9pE6_hg-7pY_353d-iBx+9-3qnwHY4yBpQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix test_bpffs
To: Manu Bretelle <chantr4@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	ast@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, 
	shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 3:30=E2=80=AFPM Manu Bretelle <chantr4@gmail.com> w=
rote:
>
> Currently this tests tries to umount /sys/kernel/debug (TDIR) but the
> system it is running on may have mounts below.
>
> For example, danobi/vmtest [0] VMs have
>     mount -t tracefs tracefs /sys/kernel/debug/tracing
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
>     $ vmtest -k $KERNEL_REPO/arch/x86_64/boot/bzImage "./test_progs -vv -=
a test_bpffs"
>     =3D> bzImage
>     =3D=3D=3D> Booting
>     =3D=3D=3D> Setting up VM
>     =3D=3D=3D> Running command
>     [    2.138818] bpf_testmod: loading out-of-tree module taints kernel.
>     [    2.140913] bpf_testmod: module verification failed: signature and=
/or required key missing - tainting kernel
>     bpf_testmod.ko is already unloaded.
>     Loading bpf_testmod.ko...
>     Successfully loaded bpf_testmod.ko.
>     test_test_bpffs:PASS:clone 0 nsec
>     fn:PASS:unshare 0 nsec
>     fn:PASS:mount / 0 nsec
>     fn:FAIL:umount /sys/kernel/debug unexpected error: -1 (errno 16)
>     bpf_testmod.ko is already unloaded.
>     Loading bpf_testmod.ko...
>     Successfully loaded bpf_testmod.ko.
>     test_test_bpffs:PASS:clone 0 nsec
>     test_test_bpffs:PASS:waitpid 0 nsec
>     test_test_bpffs:FAIL:bpffs test  failed 255#282     test_bpffs:FAIL
>     Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED
>     Successfully unloaded bpf_testmod.ko.
>     Command failed with exit code: 1
>
> After this change:
>
>     $ vmtest -k $KERNEL_REPO/arch/x86_64/boot/bzImage "./test_progs -vv -=
a test_bpffs"
>     =3D> bzImage
>     =3D=3D=3D> Booting
>     =3D=3D=3D> Setting up VM
>     =3D=3D=3D> Running command
>     [    2.119236] bpf_testmod: loading out-of-tree module taints kernel.
>     [    2.121768] bpf_testmod: module verification failed: signature and=
/or required key missing - tainting kernel
>     bpf_testmod.ko is already unloaded.
>     Loading bpf_testmod.ko...
>     Successfully loaded bpf_testmod.ko.
>     test_test_bpffs:PASS:clone 0 nsec
>     fn:PASS:unshare 0 nsec
>     fn:PASS:mount / 0 nsec
>     fn:PASS:mount tmpfs 0 nsec
>     fn:PASS:mkdir /tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs1 0=
 nsec
>     fn:PASS:mkdir /tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs2 0=
 nsec
>     fn:PASS:mount bpffs /tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed=
/fs1 0 nsec
>     fn:PASS:mount bpffs /tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed=
/fs2 0 nsec
>     fn:PASS:reading /tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs1=
/maps.debug 0 nsec
>     fn:PASS:reading /tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs2=
/progs.debug 0 nsec
>     fn:PASS:creating /tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs=
1/a 0 nsec
>     fn:PASS:creating /tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs=
1/a/1 0 nsec
>     fn:PASS:creating /tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs=
1/b 0 nsec
>     fn:PASS:create_map(ARRAY) 0 nsec
>     fn:PASS:pin map 0 nsec
>     fn:PASS:stat(/tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs1/a)=
 0 nsec
>     fn:PASS:renameat2(/fs1/a, /fs1/b, RENAME_EXCHANGE) 0 nsec
>     fn:PASS:stat(/tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs1/b)=
 0 nsec
>     fn:PASS:b should have a's inode 0 nsec
>     fn:PASS:access(/tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs1/=
b/1) 0 nsec
>     fn:PASS:stat(/tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs1/ma=
p) 0 nsec
>     fn:PASS:renameat2(/fs1/c, /fs1/b, RENAME_EXCHANGE) 0 nsec
>     fn:PASS:stat(/tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs1/b)=
 0 nsec
>     fn:PASS:b should have c's inode 0 nsec
>     fn:PASS:access(/tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs1/=
c/1) 0 nsec
>     fn:PASS:renameat2(RENAME_NOREPLACE) 0 nsec
>     fn:PASS:access(/tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed/fs1/=
b) 0 nsec
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
> This is a follow-up of https://lore.kernel.org/bpf/20231024201852.1512720=
-1-chantr4@gmail.com/T/
>
> Signed-off-by: Manu Bretelle <chantr4@gmail.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/test_bpffs.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpffs.c b/tools/=
testing/selftests/bpf/prog_tests/test_bpffs.c
> index 214d9f4a94a5..80a1afb9589d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
> @@ -8,7 +8,8 @@
>  #include <sys/types.h>
>  #include <test_progs.h>
>
> -#define TDIR "/sys/kernel/debug"
> +// TDIR must be in a location we can create a directory in.
> +#define TDIR "/tmp/vvnlhrgunvkrfegnlrvnggcudfgdtrhbfelkebeurfed"

and "/tmp/test_bpffs_testdir" isn't unique enough? ;)

>
>  static int read_iter(char *file)
>  {
> @@ -43,8 +44,10 @@ static int fn(void)
>         if (!ASSERT_OK(err, "mount /"))
>                 goto out;
>
> -       err =3D umount(TDIR);
> -       if (!ASSERT_OK(err, "umount " TDIR))
> +       err =3D  mkdir(TDIR, 0777);
> +       // If the directory already exists we can carry on. It may be lef=
t over
> +       // from a previous run.

we don't use C++-style comments in kernel and selftests code, please
change to /* */

same above for TDIR comment

> +       if ((err && errno !=3D EEXIST) && !ASSERT_OK(err, "mkdir " TDIR))
>                 goto out;
>
>         err =3D mount("none", TDIR, "tmpfs", 0, NULL);
> @@ -138,6 +141,7 @@ static int fn(void)
>         rmdir(TDIR "/fs1");
>         rmdir(TDIR "/fs2");
>         umount(TDIR);
> +       rmdir(TDIR);
>         exit(err);
>  }
>
> --
> 2.40.1
>

