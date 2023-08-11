Return-Path: <bpf+bounces-7564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC31779405
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 18:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CB921C21723
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 16:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53B563B6;
	Fri, 11 Aug 2023 16:12:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F66111701
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 16:12:08 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3102683
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 09:12:07 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5231410ab27so2746385a12.0
        for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 09:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691770325; x=1692375125;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6Kp2AyvAF439VDIEzSBfHykDM22jyaQ3gWVnOvpSgkE=;
        b=Tz/MGJEr4/oS4XOA8w408hoKK0sPIWxaY2TRuR1VVT7yUpB1ZWx6oBHmGsWek3PRBh
         dU07LDk4ZUKprDbbasqgyFSSsJrzBhXWGYaXihrVBh9Q5+7UI3BRGlO25mo5OmWbk+YI
         gL375ssfiMPZDuDFqVYk0lXgiM8xfIe1oqWvLyHiBwLk6MZCSTyCWUgduwY40xW8mzlE
         1i/m6dF+UIFZFB+l90QQGajQ8fy4bvMbOanTT7j5fzoAWR95m4GORb4Yd48dgZDyymrT
         qgkgdTYl4GgyvqdWPPbYW2Pbr2fBeihQDf/g9A291ry1V+I89DMcoGa/6fp5//YybvP/
         y2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691770325; x=1692375125;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Kp2AyvAF439VDIEzSBfHykDM22jyaQ3gWVnOvpSgkE=;
        b=f/0BvpID5tlfNhxtlSvXY5Qlp41iZtqqbbHh47XgyTC6W5A+f8CI91b/3XIoMOtUOc
         kBXUOzML9qW9IjuRevJnkxrpWhrFuB1Yr7Vtf8uPVqqYAoAXs8gEsNrkfnDoYpRfmGgX
         nTP+aTs3fwhwbFkQ2kAicD9VhgXajZzorUr2IgdnRf+ZpiLZwX3AUgHyhZmlhvQLwXjE
         gmg2FrZYgnpr3x74ij/6rgh1Obe5sxVvDOAxS2e3eRN4QqNjkX7bQUWuJfU04XFpLBgx
         66QrcudQKPNMUo7cr8xed/LP8n7Uu5qT02LeTK0P610itiS2Y08KyYyEt482GnfCO0nc
         vY4g==
X-Gm-Message-State: AOJu0YwXbv/YKM9az3g9TVq6qwuE+2zgKiAeGD8zBPfAcAyW4KV6cwT3
	LrvVa3rdO94C2RHdXrcNtVs=
X-Google-Smtp-Source: AGHT+IF77s7ZLcKnyTPb6zPAtMTXO+Wj/KOVgs0iOc3W7xDuBWj3JBzVAbRWay8CJ1WtXzNg/Oyi3g==
X-Received: by 2002:a17:906:7395:b0:99b:4908:1a6d with SMTP id f21-20020a170906739500b0099b49081a6dmr1944754ejl.52.1691770325205;
        Fri, 11 Aug 2023 09:12:05 -0700 (PDT)
Received: from [192.168.1.95] (grateful-telephoner.volia.net. [93.74.79.183])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906059100b0098963eb0c3dsm2412112ejn.26.2023.08.11.09.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 09:12:04 -0700 (PDT)
Message-ID: <83b2fb306e34a76b07c4625df1ab2d00a183043f.camel@gmail.com>
Subject: Re: Usage of "p" constraint in BPF inline asm
From: Eduard Zingerman <eddyz87@gmail.com>
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: yonghong.song@linux.dev, bpf@vger.kernel.org, Nick Desaulniers
	 <ndesaulniers@google.com>
Date: Fri, 11 Aug 2023 19:12:03 +0300
In-Reply-To: <87sf8pfz5v.fsf@oracle.com>
References: <87edkbnq14.fsf@oracle.com>
	 <a4c550e4-1d65-aace-d9ba-820b89390f54@linux.dev>
	 <87a5uyiyp1.fsf@oracle.com>
	 <223ef785-8f8a-14bf-58e4-f9ed02b21482@linux.dev>
	 <37b9680f074a871041c3dd61d22e6a6c9fd02fb0.camel@gmail.com>
	 <87v8dmhfwg.fsf@oracle.com>
	 <7ae83d1248b649a8765a3e01e7a526c86b956ef3.camel@gmail.com>
	 <87y1ihg53e.fsf@oracle.com>
	 <48b24b86e221a9559a13d51df57b72d0da5d0c7f.camel@gmail.com>
	 <87sf8pfz5v.fsf@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 2023-08-11 at 16:10 +0200, Jose E. Marchesi wrote:
> > Do you need any help with the environment itself?
> > (I can describe my setup if you need that).
>=20
> That would be useful yes, thank you.

There are several things needed:
- bpf-next source code:
  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
- Specific kernel configuration
- QEMU to run selftests in
- Root file system for QEMU to boot
- Means to kickstart tests execution inside the VM.

There is a script vmtest.sh located in the kernel repository:

    tools/testing/selftests/bpf/vmtest.sh
   =20
Which takes care of kernel configuration, compilation, selftests
compilation, qemu rootfs image download and test execution.

This is not exactly what I use but I tested in right now and it works
with a few caveats. Explaining my setup would take longer so I'll
start with this one. I will submit patches with fixes for caveats.

## Caveat #1: libc version

The script downloads rootfs image from predefined location on github
(aws?) and that image is based on debian bullseye. libc version on my
system is newer, so there is an error when test binaries built on my
system are executed inside VM. So, I have to prepare my own rootfs
image and point vmtest.sh to it. It might not be a problem in your
case, if so -- skip the rest of the section.

Unfortunately, there is no option to override rootfs via command line
of that script, so the following patch is needed:

```diff
diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftest=
s/bpf/vmtest.sh
index 685034528018..3d0c7e7c0135 100755
--- a/tools/testing/selftests/bpf/vmtest.sh
+++ b/tools/testing/selftests/bpf/vmtest.sh
@@ -124,6 +124,15 @@ download_rootfs()
                exit 1
        fi
=20
+        echo "download_rootfs: $ROOTFS_OVERRIDE"
+        if [[ "$ROOTFS_OVERRIDE" !=3D "" ]]; then
+            if [[ ! -e $ROOTFS_OVERRIDE ]]; then
+               echo "Can't find rootfs image referred to by ROOTFS_OVERRID=
E: $ROOTFS_OVERRIDE"
+               exit 1
+            fi
+            cat $ROOTFS_OVERRIDE | zstd -d | sudo tar -C "$dir" -x
+            exit
+        fi
        download "${ARCH}/libbpf-vmtest-rootfs-$rootfsversion.tar.zst" |
                zstd -d | sudo tar -C "$dir" -x
 }
```

Here is how to prepare the disk image for bookworm:

    $ git clone https://github.com/libbpf/ci libbpf-ci
    $ cd libbpf-ci
    $ sudo ./rootfs/mkrootfs_debian.sh -d bookworm
      # !! eddy -- is my user name locally, update accordingly
    $ sudo chown eddy libbpf-vmtest-rootfs-2023.08.11-bookworm-amd64.tar.zs=
t
    $ export ROOTFS_OVERRIDE=3D$(realpath libbpf-vmtest-rootfs-2023.08.11-b=
ookworm-amd64.tar.zst)

Script stores Qemu disk image in ~/.bpf_selftests/root.img .
We need to prepare/update that image using the following command:

      # !! make sure ROOTFS_OVERRIDE is set
    $ cd <kernel-sources>
    $ cd tools/testing/selftests/bpf
    $ ./vmtest.sh -i

(Note: script uses sudo internally, so it might ask for password).

## Caveat #2: make headers

Kernel compilation command requires the following patch:

```diff
diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftest=
s/bpf/vmtest.sh
index 685034528018..3d0c7e7c0135 100755
--- a/tools/testing/selftests/bpf/vmtest.sh
+++ b/tools/testing/selftests/bpf/vmtest.sh
@@ -137,6 +146,7 @@ recompile_kernel()
=20
        ${make_command} olddefconfig
        ${make_command}
+        ${make_command} headers
 }
=20
 mount_image()
```

## Running tests

Running tests is simple:

    $ cd <kernel-sources>
    $ cd tools/testing/selftests/bpf
    $ ./vmtest.sh -- ./test_verifier

The script will rebuild both kernel and selftests if necessary.
The log should look as follows:

    $ ./vmtest.sh -- ./test_verifier
    Output directory: /home/eddy/.bpf_selftests
    ... build log ....
    [    0.000000] Linux version 6.5.0-rc4-g2adbb7637fd1-dirty ...
    ... boot log ...
    + /etc/rcS.d/S50-startup
    ./test_verifier
    #0/u BPF_ATOMIC_AND without fetch OK
    #0/p BPF_ATOMIC_AND without fetch OK
    #1/u BPF_ATOMIC_AND with fetch OK
    ... test_verifier log ...
    #524/p wide load from bpf_sock_addr.msg_src_ip6[3] OK
    Summary: 790 PASSED, 0 SKIPPED, 0 FAILED
    [    3.724015] ACPI: PM: Preparing to enter system sleep state S5
    [    3.725169] reboot: Power down
    Logs saved in /home/eddy/.bpf_selftests/bpf_selftests.2023-08-11_18-53-=
05.log

## Selecting individual tests

For test_verifier individual tests could be selected using command:

    $ ./vmtest.sh -- ./test_verifier -vv 42

(-vv forces detailed logging).

For test_progs/test_progs-no_alu32/test_progs-cpuv4 using the
following command:

    $ ./vmtest.sh -- ./test_progs-cpuv4 -vvv -a verifier_ldsx

(-a stands for allow and filters tests by names).

`test_maps` do not take any options AFAIK.

---

Hope this helps.
Feel free to ask about any issues, or we can have a call in zoom.

