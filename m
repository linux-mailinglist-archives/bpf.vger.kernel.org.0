Return-Path: <bpf+bounces-39688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7289975FFE
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 06:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668EF2840EB
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 04:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FC91422A2;
	Thu, 12 Sep 2024 04:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXsNu/hr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1E037703
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 04:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726115503; cv=none; b=XPJGzXFMRQp2wgsvyB1sSvVvmfhsc33+v3YkBH1c8qEQvaAcv0sRC/R+f4SuaD6c1xCRGgWocqf+QkgAzbjQDbPHuahT3dW8Mw0qWBu7uL7a6aLS6ob9FABQhwXzDtaRwB+R6IP/tvvfMQYao3HPCa5naqqv1xxdu9NKP+TGEYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726115503; c=relaxed/simple;
	bh=bgVnL/mK+sDIBz/EoGeD/CDMtiXfup/MzlddBvQF4GM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fkQUg7r6aYXBB5aa4JbUnJZ5UcrEJki3L6mfJWAd0Kq1SNsjPHO0EDH6q6zzKBVH8x4Q2HEwLqkUWhAnIQ9RJZug9Q9+FbJnZh5dZe3XK04mbHfxRb0qNij4Iyz/ymvkac6ImYd4XxTzRgHx0Kff9LYieh9DjLKLrQC/fxlFUso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXsNu/hr; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7cf5e179b68so397238a12.1
        for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 21:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726115501; x=1726720301; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NJUXgRy3QokrLze4qwsZ5oNd9oaWcnpYtlwZ1WvJO2o=;
        b=mXsNu/hrhCL5yWnMLFbhJf0m8+TK2WNmd7T+yKGAhd0aUtcjx858a3TnNw9H6b/EU8
         lH/kUxttnFYzU8vlvm7++RaTNZt0RWeJnLi2TYuUwslxuTM67IXrPj+r7XCCahpHS3N+
         YlTN0c8hCdEdwvPwTtbMsttfTy7gdVJrgFzO+xzAZ1BUV6DOvgWt/q/WNg2yBjMW8M9+
         /rhKCcyxhSU9bStzy23rYHDsq0NKmX244E+htYJZF0h9gjhb68M4agv2Vmy/IPC1hUVB
         xqeNIC2jaCL7bdSYurUZOV70L5o1xHQYRrq8irNhve5t3Pu5nD+885xYF70Ah4pBd4yH
         injw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726115501; x=1726720301;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NJUXgRy3QokrLze4qwsZ5oNd9oaWcnpYtlwZ1WvJO2o=;
        b=S+mey8LGwlYFP5Uew17zP/njzaVj1uDFae3zkwHB14UawtwlqelLJiuO/6e1jG2FvH
         LOv9pswrZVAvahPH8MUVQU3RzYrYkEuUlZDGL5TGU6DqRBjPHse4fUN7pe1pKPU5LuaJ
         lmIYB+2SUV7iYe4CY9DHnJ0rpr3xKfHgIhZ93f1G3BIM7T9eU8e6s90SqtUH4zxGJGVj
         lIu2gMXNiCuIFJ5U7pf8JdeF7zK6PXuDE4dn4kejbk5j+PTZiIYOgQjtTaKAPwdrV1f1
         mWlzJcewEtCq6ZiX7+qWBtVTNoud+acW0tYOed0pt3vIwTR9OQEZA8V8lfBnZUbrjT3X
         veOA==
X-Gm-Message-State: AOJu0YxOBehy8wOlBmTDpWxiPfVLTY26aKxTO9Osuxy3B+1Y119wB0h7
	B7tiJ37Ig/IE7nIbT4MM6mWYdTn9ZYX9l1X0GvhXFS1qWlZZQm/4IF2+CQ==
X-Google-Smtp-Source: AGHT+IFKHkcjzJF0RFTlWs3sAAnaP1Wn78i3Vx/zTbskGXFqG7KrfhmhCmZujdcZIiFyWT6D+RUh+Q==
X-Received: by 2002:a05:6a21:6481:b0:1cf:4596:d481 with SMTP id adf61e73a8af0-1cf755c6e8fmr2069420637.7.1726115500928;
        Wed, 11 Sep 2024 21:31:40 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71908fe52ecsm3748887b3a.53.2024.09.11.21.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 21:31:40 -0700 (PDT)
Message-ID: <62b54401510477eebdb6e1272ba4308ee121c215.camel@gmail.com>
Subject: Re: [PATCH] Fix a bug in ebpf verifier
From: Eduard Zingerman <eddyz87@gmail.com>
To: lonial con <kongln9170@gmail.com>
Cc: bpf@vger.kernel.org
Date: Wed, 11 Sep 2024 21:31:35 -0700
In-Reply-To: <CAH6SPwj6=zu8fLNLwZ06fTso9634GV6ku21xpyzN+bwvrOevFg@mail.gmail.com>
References: <1726037521-18232-1-git-send-email-kongln9170@gmail.com>
	 <67451140439fafa1bae3e3b010d2c6b9969696a1.camel@gmail.com>
	 <CAH6SPwj6=zu8fLNLwZ06fTso9634GV6ku21xpyzN+bwvrOevFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-09-12 at 10:53 +0800, lonial con wrote:

> I have never written a selftest before. I wrote a simple POC to
> demonstrate this bug. This POC can crash the Linux kernel 6.6.50. I
> think the ebpf code in the POC will be helpful for writing a
> selftest.

Well all depends on how familiar you want to get with selftests
infrastructure :) Here is a promised intro. If you don't want to
bother, please let me know, I can write the selftest.
If you do want to bother, feel free to ask any questions.

 ***

Please find a minimal recipe allowing to compile and run selftests in
a chroot at the bottom of this email. You would probably want to
adjust it, e.g. setup a user matching your local user inside chroot
and do a bind mount for sources directory etc.

After setting up the environment you will have to write the test.

BPF selftests reside in the following directory:
- tools/testing/selftests/bpf/

Nowadays we mostly add selftests to test_progs executable and use
bpftool skeletons / libbpf to simplify maps and programs creation.

The files located under prog_tests/ directory are compiled as host
programs, the files located under progs/ are compiled as BPF programs
(and libbpf skeletons are generated for these programs).
Skeletons generated for files from progs/ are used in tests declared
in prog_tests/.

Your POC structure:
- sets up a few maps
- sets up data for ringbuf
- loads and runs BPF program

You can look at a selftests that have similar structure, e.g.:
- tools/testing/selftests/bpf/prog_tests/ringbuf.c
- tools/testing/selftests/bpf/progs/test_ringbuf.c

Interesting parts of the 'prog_tests/ringbuf.c':

    // this includes skeleton generated by bpftool
    #include "test_ringbuf.lskel.h"

    static void ringbuf_subtest(void)
    {
    	...
        // use generated methods to setup maps and programs
    	skel =3D test_ringbuf_lskel__open();
        ...
    	err =3D test_ringbuf_lskel__load(skel);
       =20
        // you can do bpf_prog_run here as well
    }

    // build system automatically wires up functions
    // void test_*(void) as entry points for tests
    // executed by test_progs binary
    void test_ringbuf(void)
    {
        // needed for tests filtering, e.g. -t option for test_progs
    	if (test__start_subtest("ringbuf"))
    		ringbuf_subtest();
        ...
    }


 *** chroot selftests build/run recipe follows ***

# First, setup the bullseye chroot
sudo /usr/sbin/debootstrap --variant=3Dbuildd --arch=3Damd64 bullseye bulls=
eye-chroot/ http://deb.debian.org/debian

# provide {dev,proc} for chroot
sudo mount --rbind /dev ./bullseye-chroot/dev/
sudo mount --make-rslave ./bullseye-chroot/dev/
sudo mount -t proc proc ./bullseye-chroot/proc/

# enter chroot
sudo chroot ./bullseye-chroot

# Install build tools
apt install build-essential bc flex bison git libelf-dev libssl-dev \
    docutils-common rsync curl zstd qemu-system-x86 sudo cmake \
    libdw-dev lsb-release wget software-properties-common gnupg e2fsprogs

# Install fresh clang-18 snapshot, the llvm.sh sets up some repos
curl https://apt.llvm.org/llvm.sh --output /tmp/llvm.sh
bash /tmp/llvm.sh 18
apt install clang-tools-18
ln -s /usr/bin/clang-18 /usr/bin/clang
ln -s /usr/bin/llvm-strip-18 /usr/bin/llvm-strip

# that would be /root inside chroot
cd $HOME

# Get and compile pahole, use instructions from:
# https://git.kernel.org/pub/scm/devel/pahole/pahole.git/about/
git clone https://git.kernel.org/pub/scm/devel/pahole/pahole.git
cd pahole
git submodule update --init --recursive
mkdir build
cd build
cmake -D__LIB=3Dlib ..
make -j
# make it available system-wide
ln -s $(realpath pahole) /usr/local/bin/

cd $HOME
git clone --depth=3D1 https://git.kernel.org/pub/scm/linux/kernel/git/bpf/b=
pf-next.git

# Run vmtests, this should download rootfs, build kernel and tests, run tes=
t_verifier
# vmtest.sh would ask for root password to mount rootfs image
cd bpf-next/tools/testing/selftests/bpf
./vmtest.sh -- ./test_verifier

# And now run test_progs
./vmtest.sh -- ./test_progs

# One can filter tests too
./vmtest.sh -- ./test_progs -t ringbuf


