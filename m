Return-Path: <bpf+bounces-68291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D949CB56249
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 19:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DA747ADF3B
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 16:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD621F5852;
	Sat, 13 Sep 2025 17:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dvjll8GJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915A31D79A5
	for <bpf@vger.kernel.org>; Sat, 13 Sep 2025 17:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757782874; cv=none; b=me86SkUPuVV4+IzSz7axH5QmvBP8IPY4myErquLIHcOkDXlH9ShE2r4oVk4AolUuHQQL61VcULJzB7CzHRv4nzGVZeZj0i86CU2TZ62fQruPJSXHvk0H8p9dM9V2tybOPSfCbLDT+m1qEpuDzYM3eos1I9H56gz/BBpeAezi/Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757782874; c=relaxed/simple;
	bh=fAl811+LJx+57xhD3ZDBRMsx59Zi632qqhWlpTaXmmQ=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=bUFJRMZ2DA0x3MLYO4C5/z1M5zlrIr1vnMs7l/2Uwz37DxGdQlt2tJypu3zUxIEkiGjmlI0yPL6A0SgdtB+I0V9qKkZk4yUAsjjFERO+/3aMiCw4r6m5HKosCgjw0bT5zUOrhlG4AHhS2Trn8uS/eb2KcS10wQas8y3HgYZ3qls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dvjll8GJ; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3e8ef75b146so289939f8f.0
        for <bpf@vger.kernel.org>; Sat, 13 Sep 2025 10:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757782871; x=1758387671; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8jVrbxVggAGGjVPECN0iWVqlzdgucYLKcpcWurPyD3c=;
        b=Dvjll8GJ0wnD0ppxn4LNP6U8prNscBJo1opMdLj3djyH6IZZ9qgnwIhswWC6Ij937R
         N7HU3rDW05qtyUGzK2CUDClWIUiTUrmSQJQ64I03lv8uPdUs0iTf906qEYpLQP90er7h
         QF0VoK2n1mvjPCmj7wx0J8xwenYCXEvkGAxKgsHXWAgVG2TNN4kXRcvyt2PdAeruftEe
         yqrqi/SGPGgoyRj27+nRrwCDK53ZcfQ/n7lmq2uSTho6XJx/GbmRrjvgAN9EBT5pwFoI
         FxGiHXQIxR1y9BJ2AK4nnfsh3tU/vTjg6+HEnyt6CBOQrscbTuYzZ4KZwTBK+R87IYSN
         QkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757782871; x=1758387671;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8jVrbxVggAGGjVPECN0iWVqlzdgucYLKcpcWurPyD3c=;
        b=L504pplLIZqeOP1uDt+ey2J0EhuhFpE6g7Qg+HlmfRwd75eWE/KGmKuW2xukKqKwj1
         TXJocB0hUs5U4ePCcuClgyrVLAPPfdsYOnwcDcFoUHsAnVNKTEwxmSefQaTRh8+PqB3S
         52XIDoUMEgyoqj5gAsXuZ+4TdEfLlXQtRUeXsC1JdHqCDIXFAkXHHEUoB6+cwk1rBlKR
         C51nQQ1mOL3XYl7pwRsfc3h1Eqkmx494aaOQEmzHyeJMJOM4zsijeGMOg9g7TdVCbDW5
         NII9oyApSP1YaFWuWwE7lXLIfPZj7ferll+GfBCUC2IcD7g4b2tgeg5MPxOQl0v9CV+P
         8bxA==
X-Gm-Message-State: AOJu0YyobHYR99AXxeUCgiv2YQwR4Z+hVOxxHcW8A6RVeS1Cu0lSOyoY
	KNgJUUL2jMVaGgF9MyQMu1T3NiaR/8Z52Jiikn94hPwt7P67hwYl3Kw9
X-Gm-Gg: ASbGncssntVgUpsQPkV0+W3DR0jkAMy1dh9OS+bt09AvMxIex2uQsaUJYdQna0n2V5K
	4u4fPoZKp6pcjhA1/d2DmYYFB+J1sYYQ9AJdLWQtztClxHEeQ5BI4auT+BJChPiM++kJH9++gfx
	qv+iJ+rJmhczv7PIXR4TEI1zl6aNWEv3tse4pXaeu2tNvyFegEoDOaAf1lI0tRgiFALxbgN+p8X
	k8h+n3GoLZateMqo4qOOPl99spPdYO9Q51QTOyBETppsQ01bkccEuejCqEvICg9eFkJfoSoJ86y
	QvyT1KUMMFpw7Y84TX9SECr3oLwn9qMlyjNSCyQCP1nDk/FSvlehdoZPYgVZYTMerNjggNiIXSF
	VMPukEwD2KVHrUhFd5V9KupYMyjwmCmXngG0jaEiX8OiphdUPOYelNzBAjFQF6tooUu7XjAeH7Y
	BLxkM=
X-Google-Smtp-Source: AGHT+IHxuiEOQg1v7lYGNdadask14TKYGQh97aQt2avC5UpjAiAMPfP2BgCYtn/tTDqWMXPMlc9qqA==
X-Received: by 2002:a05:6000:2510:b0:3e4:ea11:f7df with SMTP id ffacd0b85a97d-3e7659db441mr6402177f8f.40.1757782870686;
        Sat, 13 Sep 2025 10:01:10 -0700 (PDT)
Received: from [10.33.80.40] (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e80da7f335sm4379634f8f.8.2025.09.13.10.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 10:01:09 -0700 (PDT)
Message-ID: <e5d594d0aee93da67a22a42d0e2b4e6e463ab894.camel@gmail.com>
Subject: [bug report] [regression?] bpf lsm breaks /proc/*/attr/current with
 security= on commandline
From: Filip Hejsek <filip.hejsek@gmail.com>
To: linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
  James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev
Date: Sat, 13 Sep 2025 19:01:08 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello,

TLDR: because of bpf lsm, putting security=3Dselinux on commandline
      results in /proc/*/attr/current returning errors.

When the legacy security=3D commandline option is used, the specified lsm
is added to the end of the lsm list. For example, security=3Dapparmor
results in the following order of security modules:

   capability,landlock,lockdown,yama,bpf,apparmor

In particular, the bpf lsm will be ordered before the chosen major lsm.

This causes reads and writes of /proc/*/attr/current to fail, because
the bpf hook overrides the apparmor/selinux hook.

As you can see in the code below, only the first registered hook is
called (when reading attr/current, lsmid is 0):

int security_getprocattr(struct task_struct *p, int lsmid, const char *name=
,
			 char **value)
{
	struct lsm_static_call *scall;

	lsm_for_each_hook(scall, getprocattr) {
		if (lsmid !=3D 0 && lsmid !=3D scall->hl->lsmid->id)
			continue;
		return scall->hl->hook.getprocattr(p, name, value);
	}
	return LSM_RET_DEFAULT(getprocattr);
}

Even though the bpf lsm doesn't allow attaching bpf programs to this
hook, it still prevents the other hooks from being called.

This is maybe a regression, because with the same commandline, reading
from /proc/*/attr/current probably worked before the introduction of
bpf lsm.

Regards,
Filip Hejsek

