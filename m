Return-Path: <bpf+bounces-66375-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD40B3320D
	for <lists+bpf@lfdr.de>; Sun, 24 Aug 2025 20:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE28B20470A
	for <lists+bpf@lfdr.de>; Sun, 24 Aug 2025 18:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDA014AD2D;
	Sun, 24 Aug 2025 18:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+KN1brJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF370220F49
	for <bpf@vger.kernel.org>; Sun, 24 Aug 2025 18:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756060013; cv=none; b=TRh5F9gKvaBbxdFpZXe+/IJCaliHxt6gqZhhO583mm7xTgjTwFqLbMqFPsY+HuM9C8TVw18KNvXjC3HLxycQP4uHlgCCfO+gzVX96p5DfYdC3QU5UDfOEYr0DBgXMLDFDRDPZKAmdm7Wtw8m0s+IWEZmY4Ul6L6i9WUXhtwB4DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756060013; c=relaxed/simple;
	bh=QFEe9kr6hAgm1aLSumExWmXbmZ/gKzqSsucZN9wSA+g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=W4mKW9wA1HRMtuHFd/C0GPyr1UM2mgH67QEBK/adxuIPZfRnMLnVXI7LB3FfLUhDZczAtRCz4IcW+IuTm0edVu6g/TVFC/j28L5FfEsO/Gdk+wz+DedKRBBAZDlQHqyN51k4NcTjfwdWDvN8do9Qopr4dCcXsAgy8B1bjZ5aTw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+KN1brJ; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b0faa6601cso61629181cf.1
        for <bpf@vger.kernel.org>; Sun, 24 Aug 2025 11:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756060010; x=1756664810; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oYKpS/OVLHtlw1SEhy49/yxULbAc472ZRbOq5epfbUY=;
        b=K+KN1brJ2888DdqK8zbaHB4pBVHWs2TnU12MCw2FCwJY/5ohr2SNBNay118KdGMJFX
         0MNTqcRm5B6YF4JhmfU2dWNr+cVf+Gr8SgJlxLuvP+iHOK5p+7wzlMk+iClsu+6HsMah
         5slBH56NutAS+DKd+5sTFBLO6f7RdEnUoNA/SdOwHYcCTQmfJMwZuzQv32ZvtGoVdzA3
         Ni/SXauIq8vjvEHDFe0fLZa9Bj8kqxDlTR8abvgLyXCBp/f5g+4Y4JFnWgUMcyqEojk1
         rfKj6RDtLHx8kguFZaYsgC/gqvnomQ58QIHC0CajvcxMpxAJlodZsVDCXW/8/9AUBdz6
         AV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756060010; x=1756664810;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oYKpS/OVLHtlw1SEhy49/yxULbAc472ZRbOq5epfbUY=;
        b=M/1xo1ta/3kEYIQs1SsGncEKTXX2BVE6hXXbTCck3BB25U7TSsgiVvMen6k7eDZBjx
         Qavzy3soU1KbDIHAOr1GPHnd9GmH3xEx7zNdCpVQxIdlfmiZG+9fKdB3ccY4lO0jSKKQ
         0RhjW84+wSzwhL+M0KSVxg9c/b1ZHnkiHpKchRGaYjcZHKnpiFpIJTmVJycSVSFz9EGI
         Ti+Q0qEguDXyQacy0GT940MFXYe6xFyPhvFV9AeZFnlMUKFJpFGtO8Tvlt/FnaZRvk2q
         N1hbxy8n5jNPZDoIvzYX2DWOPSr7g6RlELO49lqLSuaHrFETTE1rxlpNsaLUk0l9soP6
         6ahg==
X-Gm-Message-State: AOJu0YxUzZqRblCuoooJuc03mupGuWuYKfoLYRZbuKgS6mhi4+ky8Fev
	/JurdwYOv7WimDA8F02mGoyJEkYQNbLPlZH9DJu9b3v4J1tzfrjjoOUe4B7uZaXydXd2nkespe4
	CvRQDU2lbecjRpOa5FfxY9xR5lAiQInI2qY9E
X-Gm-Gg: ASbGncscLjXiTsn+YyOVM0FRmD9PHnQYWQ/fVPbYNLNXPG1KqL9+aEo4c2UWVhfTJKF
	niRxKpwXIyPKts6RPq82QQX/J1GpZZIIh6VAi0Txfmfk+WDqyszqlByIK2W+asxtHAMAGtS+v3s
	oQNpF4OYzzLoQDqV9vf9dSfBC2RD/vRPGr3mUneMpLoIpVihhSO3a1OzKlqvgvKkUShrNV/PSo1
	+E5pUs=
X-Google-Smtp-Source: AGHT+IFJGyUqt33WNB4UCQgZ0UJ2Z/ZSspgv39DHBNDsrgKA63G9AUd2Zx0kdBgHEpAbjOPge5NFbYWTtoi1my3ETDw=
X-Received: by 2002:a05:622a:1492:b0:4b2:8ac4:f09d with SMTP id
 d75a77b69052e-4b2a0132c57mr167510561cf.39.1756060010522; Sun, 24 Aug 2025
 11:26:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Sun, 24 Aug 2025 11:26:39 -0700
X-Gm-Features: Ac12FXz_2IBrNZzobiwpVlsjzn9xyUXTMXl_5flQTdavloKbOu5OKS0I1fCzbT0
Message-ID: <CAK3+h2xOSEZUHhou7N2cRL-aGrZCNSm45g+P7thObMe+fpgYCA@mail.gmail.com>
Subject: bpf selftests timer_lockup intermittently locks up kernel
To: bpf <bpf@vger.kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi,

I am running bpf selftests on a Loonarch PC and observed intermittent
kernel lockup by timer_lockup, then I can repeat the lockup just by
running the timer_lockup in while loop every 5 seconds, I could not
find a good x86 machine to test, and I think this might be
architecture independent. I don't have a good way to capture any
kernel log messages for the PC after the kernel hangs, and I had to
power reset the PC.

[root@fedora ~]# uname -a
Linux fedora 6.17.0-rc2+ #20 SMP PREEMPT_DYNAMIC Thu Aug 21 13:08:01
PDT 2025 loongarch64 GNU/Linux

[root@fedora bpf]# while true ; do ./test_progs -t timer_lockup
--watchdog-timeout=120; sleep 5; done
#458     timer_lockup:OK
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

#458     timer_lockup:OK
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
WATCHDOG: test case timer_lockup executes for 10 seconds...
WATCHDOG: test case timer_lockup executes for 120 seconds, terminating
with SIGSEGV
test_timer_lockup:PASS:timer_lockup__open_and_load 0 nsec
test_timer_lockup:PASS:pthread_create thread1 0 nsec
test_timer_lockup:PASS:pthread_create thread2 0 nsec
timer_lockup_thread:PASS:cpu affinity 0 nsec
timer_lockup_thread:PASS:cpu affinity 0 nsec

#458     timer_lockup:FAIL
Caught signal #11!
Stack trace:
./test_progs(crash_handler+0x28)[0x120555b04]
linux-vdso.so.1(__vdso_rt_sigreturn+0x0)[0x7ffffee55084]
/lib64/libc.so.6(+0x7d900)[0x7fffef9b1900]
/lib64/libc.so.6(+0x82cc0)[0x7fffef9b6cc0]
./test_progs(test_timer_lockup+0x3fc)[0x1204bce28]
./test_progs[0x120556244]
./test_progs(main+0x684)[0x120558234]
/lib64/libc.so.6(+0x2882c)[0x7fffef95c82c]
/lib64/libc.so.6(__libc_start_main+0xa8)[0x7fffef95c918]
./test_progs(_start+0x48)[0x12010f2d0]

Thanks,

Vincent

