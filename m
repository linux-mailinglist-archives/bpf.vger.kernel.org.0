Return-Path: <bpf+bounces-39727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEEF976C4D
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 16:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E4091C237FF
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 14:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3F51B982B;
	Thu, 12 Sep 2024 14:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bg0+aSFx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF581B9821
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 14:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726152030; cv=none; b=cNMiI8nbQUw7G1cS8OUPzfGisPo/Wb2FduqIrtPYsbiDy/MmBZ9kte4uyXNJyHbzF1tA+cjavhoCZdJU7eB3Qb22ZmNnMjiK0hSjDnoWT8eEsDhUocAcnIYw0LngHeTnDy6Fn+BMXVkv4A5XU7/lTY/W0avpdfmMFGBN/S2cgXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726152030; c=relaxed/simple;
	bh=2GAMA2wga5q83MIxaFeUhTVeystc4aIJZXNdVreotSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sLrlQZUhb0tPwaByd1xrj9J/WyfH1Xa496Cl96DaSxyMNpDCxRAcQRbKx2cQCbW4yOHZleytm0RWsB3uNVHf4SWIeNgXZXBbWvuHd9bRhutnoxfiCqv4RZ1HfXS0KluBlqP/Z1zFBDRxZRfkvqm2y7y2iZRq7B3N6vNvqLEHloE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bg0+aSFx; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c3c3b63135so1077621a12.3
        for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 07:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726152027; x=1726756827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HCOSxLBQO0ZNj9zMDpIm//SGoaox3LS+lXNzO9wMv4=;
        b=Bg0+aSFxkcD0tLwUhViqrvOqAoTfdmXsJE804ecUui6jhpDtwVhBx0qC+EZazUyrYH
         u4JBq80tHl+B/067Jo2pzHIwuZhRm4EE84eCg9xU60fBc83Tgyb5vZvfDpD7zdxBPxcu
         MrwKiAH2bdswUO1eWulq6kDsYljyJNg6/MF+6eh25yW03VUQxxclLJKNqNcu0b06n/Z/
         2YuttJAYx4FHhx6tXR9rbmHSj1nEc/Uk6ugWboOEeDSOOUOUj38Plksgh8ypbe7IRm0j
         bQHXSVQKwN43PRPdWeoexpLTO5OHWbGqBwZP9RhyAjXSLeYywGeD7EYfupHujb65TUTA
         S/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726152027; x=1726756827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5HCOSxLBQO0ZNj9zMDpIm//SGoaox3LS+lXNzO9wMv4=;
        b=BeEGWiTnR+OWmvkgvC5kUVcTyNQJWX7XZV5EsSbALTEXI9ucURHRYuLmw45SJAp2ZW
         H4jApF5No8pZQ1ZzJTCyEZ2/OWyacnHoifAV9woT8Vz+sXmwdbS3R6Hg/XboxeSXi+34
         d8TjVQcCwtINM+uaixlIkXNSM23aYPBWeKjmzTtACIzrbD8ICdqR1QO2y2ADB7K5sKSp
         4EaMsWtGkI+1Z0G0U7ITnerC/B/benlCC3TJ4pIfXjPnoXmSsx6Wo8Otb1KfHz8dYY6a
         dESKuFikWOasZAMU/yIhOEVXm2zMB8UcgnwMjchUYG/QEcl4dOz5hALSzqWeQGbPojK4
         ohVw==
X-Gm-Message-State: AOJu0Yx76ZbQ9JGWaXZ1Nv7ugY1oaGs2gr9uhg7d5DntsOrAs9FBLOBV
	fgLfCDb36EQk66oM/gNPZOKEMWc1rpYJQWzA5X0p+gvZFx25WHnVmWZYBJR4YAw2FeYMTuUpheI
	RqcpJYUh2kH74/B1GTPyk0lEjvciJWEmu0b4=
X-Google-Smtp-Source: AGHT+IEcacQg1tcjEt61Sv2UwL8S2KDGhYN50F3arAvL+x3r4k8z3mX3vo9SDvXSZtJ8hip2f/QBYx08RNuL5yAXTfU=
X-Received: by 2002:a05:6402:1d53:b0:5c2:7570:3a2a with SMTP id
 4fb4d7f45d1cf-5c413e1ee8cmr2438566a12.17.1726152026666; Thu, 12 Sep 2024
 07:40:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1726037521-18232-1-git-send-email-kongln9170@gmail.com>
 <67451140439fafa1bae3e3b010d2c6b9969696a1.camel@gmail.com>
 <CAH6SPwj6=zu8fLNLwZ06fTso9634GV6ku21xpyzN+bwvrOevFg@mail.gmail.com>
 <62b54401510477eebdb6e1272ba4308ee121c215.camel@gmail.com> <CAH6SPwjoACNcNBWCjYauSMYCFOUAys10uH-xM6mF8_Q79D0Yow@mail.gmail.com>
In-Reply-To: <CAH6SPwjoACNcNBWCjYauSMYCFOUAys10uH-xM6mF8_Q79D0Yow@mail.gmail.com>
From: lonial con <kongln9170@gmail.com>
Date: Thu, 12 Sep 2024 22:40:15 +0800
Message-ID: <CAH6SPwhUnn9-nNz9fpX3YGeA9WHT_BA5UzNgS5wYMqO=+8Ly_A@mail.gmail.com>
Subject: Re: [PATCH] Fix a bug in ebpf verifier
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I tried to build this environment, but it seems that it needs kvm
support. For me, it is very troublesome to prepare a kvm environment.
So could you please write this selftest?

Thanks,
Lonial Con


lonial con <kongln9170@gmail.com> =E4=BA=8E2024=E5=B9=B49=E6=9C=8812=E6=97=
=A5=E5=91=A8=E5=9B=9B 21:31=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> I tried to build this environment, but it seems that it needs kvm support=
. For me, it is very troublesome to prepare a kvm environment. So could you=
 please write this selftest?
>
> Thanks,
> Lonial Con
>
> Eduard Zingerman <eddyz87@gmail.com> =E4=BA=8E2024=E5=B9=B49=E6=9C=8812=
=E6=97=A5=E5=91=A8=E5=9B=9B 12:31=E5=86=99=E9=81=93=EF=BC=9A
>>
>> On Thu, 2024-09-12 at 10:53 +0800, lonial con wrote:
>>
>> > I have never written a selftest before. I wrote a simple POC to
>> > demonstrate this bug. This POC can crash the Linux kernel 6.6.50. I
>> > think the ebpf code in the POC will be helpful for writing a
>> > selftest.
>>
>> Well all depends on how familiar you want to get with selftests
>> infrastructure :) Here is a promised intro. If you don't want to
>> bother, please let me know, I can write the selftest.
>> If you do want to bother, feel free to ask any questions.
>>
>>  ***
>>
>> Please find a minimal recipe allowing to compile and run selftests in
>> a chroot at the bottom of this email. You would probably want to
>> adjust it, e.g. setup a user matching your local user inside chroot
>> and do a bind mount for sources directory etc.
>>
>> After setting up the environment you will have to write the test.
>>
>> BPF selftests reside in the following directory:
>> - tools/testing/selftests/bpf/
>>
>> Nowadays we mostly add selftests to test_progs executable and use
>> bpftool skeletons / libbpf to simplify maps and programs creation.
>>
>> The files located under prog_tests/ directory are compiled as host
>> programs, the files located under progs/ are compiled as BPF programs
>> (and libbpf skeletons are generated for these programs).
>> Skeletons generated for files from progs/ are used in tests declared
>> in prog_tests/.
>>
>> Your POC structure:
>> - sets up a few maps
>> - sets up data for ringbuf
>> - loads and runs BPF program
>>
>> You can look at a selftests that have similar structure, e.g.:
>> - tools/testing/selftests/bpf/prog_tests/ringbuf.c
>> - tools/testing/selftests/bpf/progs/test_ringbuf.c
>>
>> Interesting parts of the 'prog_tests/ringbuf.c':
>>
>>     // this includes skeleton generated by bpftool
>>     #include "test_ringbuf.lskel.h"
>>
>>     static void ringbuf_subtest(void)
>>     {
>>         ...
>>         // use generated methods to setup maps and programs
>>         skel =3D test_ringbuf_lskel__open();
>>         ...
>>         err =3D test_ringbuf_lskel__load(skel);
>>
>>         // you can do bpf_prog_run here as well
>>     }
>>
>>     // build system automatically wires up functions
>>     // void test_*(void) as entry points for tests
>>     // executed by test_progs binary
>>     void test_ringbuf(void)
>>     {
>>         // needed for tests filtering, e.g. -t option for test_progs
>>         if (test__start_subtest("ringbuf"))
>>                 ringbuf_subtest();
>>         ...
>>     }
>>
>>
>>  *** chroot selftests build/run recipe follows ***
>>
>> # First, setup the bullseye chroot
>> sudo /usr/sbin/debootstrap --variant=3Dbuildd --arch=3Damd64 bullseye bu=
llseye-chroot/ http://deb.debian.org/debian
>>
>> # provide {dev,proc} for chroot
>> sudo mount --rbind /dev ./bullseye-chroot/dev/
>> sudo mount --make-rslave ./bullseye-chroot/dev/
>> sudo mount -t proc proc ./bullseye-chroot/proc/
>>
>> # enter chroot
>> sudo chroot ./bullseye-chroot
>>
>> # Install build tools
>> apt install build-essential bc flex bison git libelf-dev libssl-dev \
>>     docutils-common rsync curl zstd qemu-system-x86 sudo cmake \
>>     libdw-dev lsb-release wget software-properties-common gnupg e2fsprog=
s
>>
>> # Install fresh clang-18 snapshot, the llvm.sh sets up some repos
>> curl https://apt.llvm.org/llvm.sh --output /tmp/llvm.sh
>> bash /tmp/llvm.sh 18
>> apt install clang-tools-18
>> ln -s /usr/bin/clang-18 /usr/bin/clang
>> ln -s /usr/bin/llvm-strip-18 /usr/bin/llvm-strip
>>
>> # that would be /root inside chroot
>> cd $HOME
>>
>> # Get and compile pahole, use instructions from:
>> # https://git.kernel.org/pub/scm/devel/pahole/pahole.git/about/
>> git clone https://git.kernel.org/pub/scm/devel/pahole/pahole.git
>> cd pahole
>> git submodule update --init --recursive
>> mkdir build
>> cd build
>> cmake -D__LIB=3Dlib ..
>> make -j
>> # make it available system-wide
>> ln -s $(realpath pahole) /usr/local/bin/
>>
>> cd $HOME
>> git clone --depth=3D1 https://git.kernel.org/pub/scm/linux/kernel/git/bp=
f/bpf-next.git
>>
>> # Run vmtests, this should download rootfs, build kernel and tests, run =
test_verifier
>> # vmtest.sh would ask for root password to mount rootfs image
>> cd bpf-next/tools/testing/selftests/bpf
>> ./vmtest.sh -- ./test_verifier
>>
>> # And now run test_progs
>> ./vmtest.sh -- ./test_progs
>>
>> # One can filter tests too
>> ./vmtest.sh -- ./test_progs -t ringbuf
>>

