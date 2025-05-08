Return-Path: <bpf+bounces-57729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F0DAAF189
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 05:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DC404E3518
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 03:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785B620012B;
	Thu,  8 May 2025 03:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePiVQvlg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6A11FF1C8
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 03:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746674724; cv=none; b=an31+gdJES1dxTNIcWCwCtqWcV7dah7XLiUBsACH6Z31M7gs/aPxkWAzYdPirGoo2dHiB3waQPUdrBODwNJKIBf8P0TEK7dUUl9vJYq8mXLNAgjBrPrFuOQA6KDOeIg52XQwMEy+B+uUQvdqrB0FzvRtlbwjQDcsmPBRz7aoF3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746674724; c=relaxed/simple;
	bh=6t4kMAuA/MCcoGOtSadiO2lwzqA0u+DRxYR067NVouw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=jyOPf1VNf+qShLYZ8kmknWywO9z2mSOTz1ZqpX9wTVFJP5By26M9hp8zLgd6CLfIzmkmlUyvcwRTPvTnFFXm/Xpq9ODYZP9gD6lxDjCRFwNZOPeisgiw/QNMyY66U+ppW1ivv5OwL8TGeDcueU+ccIsXjueTf3ICmAp9amCcKaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePiVQvlg; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6f0c30a1ca3so7567476d6.1
        for <bpf@vger.kernel.org>; Wed, 07 May 2025 20:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746674721; x=1747279521; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rre5ckzThRIEX2Y4k0t9sFBd2X/5w7PaP8ifjeyp2NA=;
        b=ePiVQvlgyRd4hyRGbztSuk0OKgvGVVLwD+p+NwKfrUVGzcgmFib8/V1JxiVsk0DvAu
         64ZHWHUjKgQbwSxB4NVRKpw9BCzV+Nhd9AeL2NtNa29Q0BIZWVTiSeqtKN+JUJyVOQn/
         mxIgKxTDRE6x6s1PcjRmLZQ2YKPEqXc9doaQh2g9PN4WpxvcrhQa2oTfb4o7DLJBac7E
         wpieWXRDRuCRcDCeDwDIoxZDFXYdYUB1IdNwwNPqtgooO2TORpnhFqZLUbpxjliLH+ln
         jtXjmcVXF4lynZxucrLbsHU0h7Bc6e8dmiIykPHxm1GoLpXHjXlzNTA7Xmt9SWiJAE/Z
         uoKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746674721; x=1747279521;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rre5ckzThRIEX2Y4k0t9sFBd2X/5w7PaP8ifjeyp2NA=;
        b=KSbQtRQelrZTh4g/eaXPSEWxXbf04uDXcYlGHVuobqgjkQeKqn1r/Ek2wIhck8nmwC
         P0suzvmLJeHq7iHeVUK2pl5HvUFtH8YNKltK4bO7ysjOG+FhLWarHmvTJhAIf4IagaA2
         oWDdQnlXw3oNrhrezCpYXIDjM/k7SLAEiv2rBSQrvbzCN3vUn4QGfjjW7WO9TNaXOknB
         3Oap1K2ZE4lkhnmifpnNvSDxP1le1TP28tSYLluVQW4VGLnCoDXp9m+OGzW4BsZJpx1E
         STMJTNTDu9QWjX+VFdiKr2AgQ/0KHTpbkukAqnDSwXdBJ97U9dXcP1TyMH1HKeQlK4DD
         VluQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYKH/UsuTwQfspVtyKZmqlqx29h8A1MGDf074jaRwNIr+UxtuGCPaWVdzYmfJdGhhlEzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyywEdicXMqlklJ+4ltfFTQjADW/foegBsZvjrlJCmU7OYxIeI+
	4PaDNppjaHh2yb7e7E+qMqpPWH2LEolCW7+++nG6EJZ/LNVFUNoeTVd/URv6zqNzTIGimm6/x2D
	V1x3Rdv2TwoUWPe/yody5COait24=
X-Gm-Gg: ASbGncvytPyIxqLFj0L49lc4B5i0cWJEt+VB9F3pf30NZhIY42zkj4fDuag67IzI0iO
	8vt0frCz0lHsK8o1gx3MZ0FGRI5yheN8RJqr60Eolc1/CKUshZlv6um4Q3dygH0OHZPp67fgjOG
	Ds6QERHDBUCYmUZ5+5XEVhPQg=
X-Google-Smtp-Source: AGHT+IH+mo3lnzE6vHFEbICaA1ZQ9eEZETqSaseFYe/4znFEYHF0h/oFiminTeG4ToO9k3kImsVhtm6Z2anFNIm0oH8=
X-Received: by 2002:a05:6214:d8b:b0:6f2:a537:f472 with SMTP id
 6a1803df08f44-6f542aa9d12mr94128666d6.34.1746674721206; Wed, 07 May 2025
 20:25:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK3+h2wo3KidH9yrGSNsV522BSkUJyn2TUp==tSv62937xPDMw@mail.gmail.com>
In-Reply-To: <CAK3+h2wo3KidH9yrGSNsV522BSkUJyn2TUp==tSv62937xPDMw@mail.gmail.com>
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Wed, 7 May 2025 20:25:10 -0700
X-Gm-Features: ATxdqUGqDQ8r2J-EpbAHlet-DJ-9kAiLh1WzdKqgqOGi723PvAzjlbckwDPd8io
Message-ID: <CAK3+h2xKaFHTq=Hi6Fdf28aBT2tB-hw4Xc0zt+670CPThw_d+w@mail.gmail.com>
Subject: Re: [QUESTION] Loongarch bpf selftest liburandom_read.so build error
To: loongarch@lists.linux.dev, bpf <bpf@vger.kernel.org>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Hengqi Chen <hengqi.chen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 2:30=E2=80=AFPM Vincent Li <vincent.mc.li@gmail.com>=
 wrote:
>
> Hi,
>
> I tried to build kernel 6.15-rc5 bpf selftests on Loongarch machine
> running Fedora, the bpf test programs seems built ok, but I got
> liburandom_read.so build error below:
>
>   LIB      liburandom_read.so
>
> /usr/bin/ld: cannot find crtbeginS.o: No such file or directory
>
> /usr/bin/ld: cannot find -lstdc++: No such file or directory
>
> /usr/bin/ld: cannot find -lgcc: No such file or directory
>
> /usr/bin/ld: cannot find -lgcc_s: No such file or directory
>
> clang: error: linker command failed with exit code 1 (use -v to see invoc=
ation)
>
> make: *** [Makefile:253:
> /usr/src/linux/tools/testing/selftests/bpf/liburandom_read.so] Error 1
>
> Am I missing  gcc tools for Fedora loongarch?

I installed gcc-c++-loongarch64-linux-gnu.loongarch64, now the error
is reduced to

  LIB      liburandom_read.so

/usr/bin/ld: cannot find -lstdc++: No such file or directory

/usr/bin/ld: cannot find -lgcc_s: No such file or directory

Why is it looking for lstdc++ that seems to be c++ library while
urandom_read_lib1.c urandom_read_lib2.c are not c++ code?

$(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c
liburandom_read.map

        $(call msg,LIB,,$@)

        $(Q)$(CLANG) $(CLANG_TARGET_ARCH) \

                     $(filter-out -static,$(CFLAGS) $(LDFLAGS)) \

                     $(filter %.c,$^) $(filter-out -static,$(LDLIBS)) \

                     -Wno-unused-command-line-argument \

                     -fuse-ld=3D$(LLD) -Wl,-znoseparate-code -Wl,--build-id=
=3Dsha1 \

                     -Wl,--version-script=3Dliburandom_read.map \

                     -fPIC -shared -o $@

