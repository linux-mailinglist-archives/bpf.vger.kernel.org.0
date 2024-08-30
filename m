Return-Path: <bpf+bounces-38519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 030489657E2
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 08:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AFC9B20E49
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 06:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F69C1531F0;
	Fri, 30 Aug 2024 06:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmbhLHZ2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A261531D9;
	Fri, 30 Aug 2024 06:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725001029; cv=none; b=UUa3hz05aq0JuptoariY8gBeFDgQY17pHY6nc87eYw+qAEiF41XuNB67XpQ9Zwqk9tyFVWwi5Yv/stJPpZmgMMkXxY22QTESDlyOS1C58TrCLyUGBDTVcPNdFdlmtHOnGtLYhGKMfDCjRGMH5EkgtiMScr/duROvi88h5Y+ucUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725001029; c=relaxed/simple;
	bh=CpPHNRNtxisJy+lUWii7cEzfIWne5pvQYvKzW9L/DJA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OtWhF9Q2kVa2n0JDk8b5/mmlrJ7R2cfi3pMTwbmCiLITrY5idk8qsyKkoL0+M3C2sprGvwUZwIJuVwDB3xhho0t0RB8zcgV1n3vXzIeT72ESxWzS/i2zo+76MtjRGSydRhxyZtiYnf3aidUKzmzo8PqQ0yLYWTsEXzykRa5gO6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmbhLHZ2; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-201e52ca0caso10364135ad.3;
        Thu, 29 Aug 2024 23:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725001027; x=1725605827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uf5WQBbGhtcMdmAAhfh4QLOMYg1avLVnP5vKvJa1cVE=;
        b=ZmbhLHZ2+gTRwLVi6OpafEwUld/zn0TMfyHJQ+kWAaJp0yNBmwg9kInTQodJBvk/1R
         dEysjLKmWy3b+ldaW4bh+N/t7C72sgtmVqI/dXbdjiIn/yRrCVrAE5tCqDosdSYRAVfn
         YOYk2a2hRFos9uj5gkR5QudeyVZ9tp0qzPJAATuO2hZtYK4+ASUGWzxbRIDQL1tHFND9
         S4V74KZ3LJw1V4p0fbPV08ip8delGJ8DGvEiRwN9UQDfMnggDdQ6FAey16sGbajHFGyh
         XAvWi6I6LxepsTLsaYACF0cskv5ByuKZB84hfQ//AnCA/xb+2JUt0OZZRJfvCfytESVc
         hUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725001027; x=1725605827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uf5WQBbGhtcMdmAAhfh4QLOMYg1avLVnP5vKvJa1cVE=;
        b=tAdlzPPITPI3P6XS5Q/gaW8ZD0fOMplWh/NfPH4D5QHohx5wCwdpKM4ZDJhqikQFwa
         9VLY8U+YyDesoFFA88cKvYz8BtcBEW7J3hffY9K1IED+B53h0aPvBfalR7jP/kfU9VsV
         tnanWDldHMAli6a5YvFd+XvVYjwbuQtbF6AMOwxOxc44k0shXgcC67DqPT15f0lbAvrE
         yPDRjuyCD8tEmhApcN7KA5sDj63vHphY7EX91FB77scayCMsjX4KlCR798UbGULADh8z
         xKolNUjPZgjl3dBnn/DvrClUKJSPNzsFY3E6uyuhRi8GJG7KadSzvLSWQ0UvpK8oWYpo
         7o7g==
X-Forwarded-Encrypted: i=1; AJvYcCU2bb2VCcg9Lw2sJUx2nDTUxDcEWEq4davaC8RsAjEp9QV2Pz3oNaxNgaqJYYCNGHXAGOFveLTMqg==@vger.kernel.org, AJvYcCUi0PM+hsz0z5L4z00OFkTtwMCjBhnGWJ07rDSsPjzaprkSGHVg6N6SsGom9nizS+pokbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDH1t1jpUd4jbnHBr5+QtXERGbnVVtcEPVhJJg6d4LzG03YUP2
	1BB9rJCf5EJFmsIsHGQiUiar8PlLZ4fD6rbKRTv6wjcBhxgZMaff
X-Google-Smtp-Source: AGHT+IHDZhQKjBBrTaUDsYTi42OznfsKIf+0PlRV16E6KBgi/7K/LTWKpgAziyt9hpwkzVbrxkdgmQ==
X-Received: by 2002:a17:902:ea0a:b0:203:a0cb:39cf with SMTP id d9443c01a7336-2050c21570fmr64577945ad.11.1725001027380;
        Thu, 29 Aug 2024 23:57:07 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515534618sm21036655ad.175.2024.08.29.23.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 23:57:07 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Thu, 29 Aug 2024 23:57:05 -0700
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, alan.maguire@oracle.com,
	dwarves@vger.kernel.org, bpf@vger.kernel.org, andrii@kernel.org,
	martin.lau@linux.dev, songliubraving@meta.com
Subject: Re: FYI: CI regression on big-endian arch (s390) after recent pahole
 changes
Message-ID: <ZtFtQRzg/LQOm7+r@kodidev-ubuntu>
References: <6358db36c5f68b07873a0a5be2d062b1af5ea5f8.camel@gmail.com>
 <ZtEgG6XJGIGn0z35@kodidev-ubuntu>
 <e524ae6265bb34ebd2f68fc5c246b9c43235c15b.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e524ae6265bb34ebd2f68fc5c246b9c43235c15b.camel@gmail.com>

On Thu, Aug 29, 2024 at 06:40:59PM -0700, Eduard Zingerman wrote:
> On Thu, 2024-08-29 at 18:27 -0700, Tony Ambardar wrote:
> 
> 
> > Thanks for looking at this. I ran into the CI failure while using s390x
> > to test a series adding libbpf bi-endian support. Since I'm deep into
> > endianness issues right now, I thought to try the fix you suggested just
> > to make some progress but noticed the CI failure has disappeared.[0]
> 
> Hi Tony,
> 
> There is no fix yet, sorry :)
> I think that something like below should do the trick:
> 
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -5394,6 +5394,7 @@ int btf__distill_base(const struct btf *src_btf, struct btf **new_base_btf,
>         new_base = btf__new_empty();
>         if (!new_base)
>                 return libbpf_err(-ENOMEM);
> +       btf__set_endianness(new_base, btf__endianness(src_btf));
>         dist.id_map = calloc(n, sizeof(*dist.id_map));
>         if (!dist.id_map) {
>                 err = -ENOMEM;
> 
> as far as I understand btf__raw_data() should do all conversions after this.
> But I have not tested it yet and would be AFK for a few hours.
> 

Hi Eduard,

Yes, btf__raw_data() will work as expected.

I updated my local pahole and managed to reproduce the problem after
cross-compiling to s390x. Looking at lib/bpf/btf.c, I see one more spot
that needs to preserve source endianness compared to patch above, and
local testing under QEMU now works for me:

    root@(none):/usr/libexec/kselftests-bpf# insmod bpf_testmod.ko
    bpf_testmod: loading out-of-tree module taints kernel.
    bpf_testmod: module verification failed: signature and/or required key
    missing - tainting kernel

    root@(none):/usr/libexec/kselftests-bpf# ./test_progs -a map_ptr
    #166     map_ptr:OK
    Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
 
and:

    $ llvm-readelf -x .BTF
    bpf_testmod.ko | head -5
    Hex dump of section '.BTF':
    0x00000000 eb9f0100 00000018 00000000 00001a30 ...............0
    0x00000010 00001a30 00001180 00000000 0a000000 ...0............
    0x00000020 00000022 00000000 03000000 00000000 ..."............
    0x00000030 00000028 00000006 0000002b 00000000 ...(.......+....
    
    $ llvm-readelf -x .BTF.base
    bpf_testmod.ko | head -5
    Hex dump of section '.BTF.base':
    0x00000000 eb9f0100 00000018 00000000 000001fc ................
    0x00000010 000001fc 000001ea 00000001 01000000 ................
    0x00000020 00000008 00000040 00000013 01000000 .......@........
    0x00000030 00000001 00000008 00000018 01000000 ................

Please try with the patch below, or I can just send a proper one to the
list with some added "Co-developed-by:" if easier?

--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -996,6 +996,7 @@ static struct btf *btf_new_empty(struct btf *base_btf)
                btf->base_btf = base_btf;
                btf->start_id = btf__type_cnt(base_btf);
                btf->start_str_off = base_btf->hdr->str_len;
+               btf->swapped_endian = base_btf->swapped_endian;
        }

        /* +1 for empty string at offset 0 */
@@ -5554,6 +5555,7 @@ int btf__distill_base(const struct btf *src_btf,
struct btf **new_base_btf,
        new_base = btf__new_empty();
        if (!new_base)
                return libbpf_err(-ENOMEM);
+       btf__set_endianness(new_base, btf__endianness(src_btf));
        dist.id_map = calloc(n, sizeof(*dist.id_map));
        if (!dist.id_map) {
                err = -ENOMEM;


> > Did something get fixed already? I can't seem to find the change.
> 
> pahole version w/o support for distilled base was pinned on CI:
> https://github.com/kernel-patches/vmtest/pull/285/commits/d3eff26fc978ca8fb3bce3f93421f7425aef0f55
> 

Ah, got it! That makes more sense now. Thanks for the extra details.

Take care,
Tony

> 
> Thanks,
> Eduard

