Return-Path: <bpf+bounces-12039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE907C731D
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 18:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 170A7282A97
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 16:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E521CF91;
	Thu, 12 Oct 2023 16:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wy1AYKlx"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D77D50F
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 16:34:45 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FA9C0
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 09:34:42 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50307acd445so1526274e87.0
        for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 09:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697128481; x=1697733281; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AG8Sjr/fsPYw0Q2lnlHH23IhUrMKJW6WVMG/Wjf6DSw=;
        b=Wy1AYKlx3EbRradRIgkixDeqgNMDztcTek2UI8cKnvBaIz2dhpkN0RoBxHGHDkXDXk
         QcjYHiwNcKnAFMKX6jTXIt4PiH0eMBa8GUSPLuFCvLb2M1TL15ShFUhvc2rcORtVnZeC
         SNmwWFeoWc/drx5J0FYgfZPpiTNzKZk/VEW+6K2wN49S5/txkG8hwA+Cot94PtTA9CYm
         FeoQuy3YRsB+sW8F1EAFDSs8Vpv4xQm9Qypdlt5d8i717bg7dXH2u1I4EIFqI5f9DGvN
         E1GwO9ZfTc8lHQGWyHGQ4/XhlMpffUipj2VORXNIGZ6fEKH75IIlnw08eYp2j9/tQ6lI
         uCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697128481; x=1697733281;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AG8Sjr/fsPYw0Q2lnlHH23IhUrMKJW6WVMG/Wjf6DSw=;
        b=h68h2Rl3kYQNIom+j5QWCUNHDzAl1r+GHPp5PX3Qi6cafrcN1yBZMH0abSjz+2EMlr
         5xLMe0xk3kIq20VFCfVF0rFxcKPurMRXb+HOtnqzb3jVe2myfPT5pVqclCIOOkNlHHQQ
         HW/cFWeBF0tiVxcWat+/gM1umAgDw2haqa9wFK0BEsLx3z6YfpdIl7UeCAaQgQa4Y7JL
         N+jzxwUZhjV7qAJBUqYdWyRQw0+yndCBBtxDRd5KH4NSglwa1lXTVvyoq2wbu7qzEU5x
         5Uj4Bj2HEvzKznpZteiZpcuJINX/+EpevzdxVaqmAlyAxMDz4n9vFNnt1JM1ycJI+Ad/
         vyig==
X-Gm-Message-State: AOJu0Yw5Ds5ILgt9Z2ltYu9s+iDzjLdb38mwZLpflMwUxv7ewAXW687n
	BCoLnOjMx8AqyzPfq1nouhKJDoQ90atO7w==
X-Google-Smtp-Source: AGHT+IFPYvxm1+segTzoDDFYm5C09UYOHbN7AI4/bl/Op3cQCEAfKVezswQOhy875pZUnpyEMi1XAw==
X-Received: by 2002:a05:6512:ea5:b0:4f8:77db:1d9e with SMTP id bi37-20020a0565120ea500b004f877db1d9emr29965463lfb.12.1697128480780;
        Thu, 12 Oct 2023 09:34:40 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id j7-20020a19f507000000b005057184ae5dsm2871654lfb.119.2023.10.12.09.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 09:34:39 -0700 (PDT)
Message-ID: <26b213505abeefba2728d238927ddd1907967786.camel@gmail.com>
Subject: Re: Is tools/testing/selftests/bpf/ maintained?
From: Eduard Zingerman <eddyz87@gmail.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, bpf
 <bpf@vger.kernel.org>,  KP Singh <kpsingh@kernel.org>
Date: Thu, 12 Oct 2023 19:34:38 +0300
In-Reply-To: <adfab6e8-b1de-4efc-a9ef-84e219c91833@I-love.SAKURA.ne.jp>
References: <adfab6e8-b1de-4efc-a9ef-84e219c91833@I-love.SAKURA.ne.jp>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-10-12 at 22:39 +0900, Tetsuo Handa wrote:
> Hello.
>=20
> I'm having problem with finding BPF LSM examples that work.
> I tried building tools/testing/selftests/bpf/progs/lsm.c and
> tools/testing/selftests/bpf/prog_tests/test_lsm.c explained at
> https://docs.kernel.org/bpf/prog_lsm.html , but got a lot of errors.

Hello,

> Is tools/testing/selftests/bpf/ maintained?

It pretty much is, build it every day :)
And we have a CI too: https://github.com/kernel-patches/bpf .

I tried setting up a minimal Debian chroot to showcase the build
and came up with the following list of commands:

# Use trixie to get llvm-16
sudo /usr/sbin/debootstrap --variant=3Dbuildd --arch=3Damd64 trixie trixie-=
chroot/ http://deb.debian.org/debian
# don't forget to umount with 'umount -R ...'
sudo mount --rbind /dev/pts trixie-chroot/dev/pts
sudo mount -t proc proc trixie-chroot/proc
sudo chroot trixie-chroot

# The reset of commands are from chroot itself, first as root
apt install build-essential llvm clang lld bc flex bison pahole git \
    libelf-dev libssl-dev docutils-common rsync
# Note: you might want to build pahole from source
useradd -d /home/eddy -s /bin/bash eddy
mkdir /home/eddy
chown eddy /home/eddy
su eddy

# Now as a user 'eddy':
cd /home/eddy
git clone https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds=
/linux.git
cd linux/
./scripts/kconfig/merge_config.sh tools/testing/selftests/bpf/config tools/=
testing/selftests/bpf/config.x86_64
# Note: kernel build is mandatory, as vmlinux.h is constructed from DWARF i=
n ./vmlinux
make -j14
make -j14 headers
make -j14 -C tools/testing/selftests/bpf/

Hope this helps,
Eduard


