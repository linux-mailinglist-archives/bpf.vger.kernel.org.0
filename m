Return-Path: <bpf+bounces-44822-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B9D9C80BA
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 03:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23805B26A5F
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 02:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA571E909D;
	Thu, 14 Nov 2024 02:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="e5Kvu0KQ"
X-Original-To: bpf@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962E91E6DCD;
	Thu, 14 Nov 2024 02:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731551063; cv=none; b=SJuOPp3npSK96/aF4+yzXHVlf57Qs2zEgIihphyIi+mdh2YyMKmSEthk5i2AVILIIechrAQcLifg8wEzG3xW79Ma7rebqo1NZ1XuxbzKehxLiSR7lWpMAT3gpM/uQ0FmTl7D6Flo+t/tp//1rHAJ0MIIzS18qhaaZ6wW8omkqIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731551063; c=relaxed/simple;
	bh=mCICf81dt3uL+/+2oj9rk+upY91qfIpIpK3vgdAqLtw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QH5d7f4RL3CJSzYXCs0Wn3Xv8S0XBY8aar1eUNKcXma4V5xL3m53mIEe/pwV9UDBk2Ra/CgsgvGcOjWiEUD8dITsKg+bHpgeWkrLxVt7ioorZ8cswXTkx1SUZFN2ps8EWBruW9qrl5MmAmnI9REZJT0p6Hw3SQXhIfd610ni9+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=e5Kvu0KQ; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=elYOEh8bST1xh+h/BSCExzA1DU/JHRGkiRdtqf1kFLw=; b=e5Kvu0KQpfC93wCh
	7k0fgtrHSSouhd6Lwh+4i6ZpDbtRgylXf6EvDlSbBcuIDr31/7Vk3XXzVRTSsgjijFv7PGuhKulSj
	Lxzjeaexxqr2iFLa+t2i8g5CjXmTqgoKqz8i+ShVb4biJf9kcWfAmUy/RfI+s58P/64R4/7VnBofH
	7rqJAUjlSoV7caeK8sJUjX1PjRwpOSCxeLkqmIzBSijP6sqxA4Eauj0ib20m9HnCStbig1GnOYJuS
	TAvcInR1O5x6+wjd8cBvYk6S9+PZxgFMPIBbBuLM9HZ912QeoeKWxdoXeRq+1mRnpbA1ZaGOdGIl8
	nyYOwkzCR4ki0zlyiQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tBPWe-00HPvO-1p;
	Thu, 14 Nov 2024 02:24:04 +0000
From: linux@treblig.org
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	roberto.sassu@huaweicloud.com,
	bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 0/2] bpf/umd possible deadcode
Date: Thu, 14 Nov 2024 02:23:58 +0000
Message-ID: <20241114022400.301175-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>


Hi,
  I'm not 100% sure about these, since I'm not quite
sure how to test it properly.

  As far as I can tell the UMD isn't needed by bpf itself
any more; so I've got one patch that just removes that select.
But then that leaves no users of umd itself; and I split that
separately since I saw there was still some discussion this year
on other uses.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Dave

Dr. David Alan Gilbert (2):
  bpf: Don't select USERMODE_DRIVER
  umd: Remove

 include/linux/usermode_driver.h |  19 ----
 kernel/Makefile                 |   1 -
 kernel/bpf/preload/Kconfig      |   5 -
 kernel/usermode_driver.c        | 191 --------------------------------
 4 files changed, 216 deletions(-)
 delete mode 100644 include/linux/usermode_driver.h
 delete mode 100644 kernel/usermode_driver.c

-- 
2.47.0


