Return-Path: <bpf+bounces-37733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7192295A258
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 18:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A41CE1C2196A
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 16:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F791C687;
	Wed, 21 Aug 2024 16:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gywv/6H0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8519B1369AE;
	Wed, 21 Aug 2024 16:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724256274; cv=none; b=ACEX7OnvVPOrDBWIItLRkZQpgoFSygRlpKOS55DCBovjjMqIt0QjqufyKUz5HpojJ4pWk0vVFyEpOr9CbPJQtPuf5n6Z3iyQB66xuGQB48mg5tR9QY5kbev9L4IhmDNRJXLbBPnD+IOU+ogtjCV9pgmXnUeaW0RUOdBSg8spkis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724256274; c=relaxed/simple;
	bh=0+ktvaMb9+xdI3BvRNEJgnY+N0roVpt98Vg//lch6Cs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WbQIe4HtxXyLqd0040QNgC+qPxS99hyNl8QuFIujZb6wzUWi8v5uI6zp0KF+f/M/ANGllEV6m5cdlJwpt4rLvl0u4dEcTvpgdRY4Ny6FL0/eoKEfI1Pfnqz7+hhkVp5esfh+62srlywhGdd9erUGlNCAJC70rboV8NWurN47+JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gywv/6H0; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-714287e4083so599831b3a.2;
        Wed, 21 Aug 2024 09:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724256272; x=1724861072; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0+ktvaMb9+xdI3BvRNEJgnY+N0roVpt98Vg//lch6Cs=;
        b=Gywv/6H0H+8bitsdwFZqA/FM6SyepzRCmXArwABanZZZR1HSncmL3BjE78gr6vfGEQ
         7FbYA0ds4vhLVTngqJbZXSY+7GTk6jCS2wKrIgxC9pnFt1S7hWvOvGQKJAmnkWYZNWst
         706bDzrcnnssl9+qsFkNaVVTwfXxGSyxQsv5WT/gZkOL8xOmqjYdG9QXlegBzYubt9V9
         cVT0faLVLldl6dDZC0rnIWSPQ0y66/csMC9ZCtdV94Fi9KqKL3pt26ER1GDLak8snXrc
         78/viZcMioMWXsRYt7PTwnA2Td2AvpUlS28yNPH8gbyEvgvBn4iG/zHDfmwgGh71cIjM
         w4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724256272; x=1724861072;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0+ktvaMb9+xdI3BvRNEJgnY+N0roVpt98Vg//lch6Cs=;
        b=GV8YSiSklC3U8F951QoGrdGmlcdcsirHF/MfreTgTHGmW2dPzW+4ontzBw/a+RpYvt
         a7Nb7acNq1cEJbLRAowOZ0rrE91X+AYrxj58YPKUNcCmFyAHSBH46vPmav2rG8mikA6I
         CZWcVNcYLn509EH4HUcExzhw5t9xx6Y5uh9OYeCeUNFqiKrwJ2Nq2kK444dEWtkPASjl
         4U5VvpEpIf19Csu9MJHWoDgHWCUPY4vRx/6OmxOGTOcQAWgu7m3GJvf4UsaGJ5kiW7a+
         M051CvJfctvy9GmUoI8NO/mkX0vLyNa9jmOrl+on+H9xT24MngWNhiVpvBlxZVEJ5txw
         V/Xw==
X-Forwarded-Encrypted: i=1; AJvYcCV2wIcZN/XSInY8al37UjsPrSdoV05IfmcTflYE1qEeRibyQ5vb8z2uEyDlqtCEVKNwEd1tjBSd@vger.kernel.org, AJvYcCWtehCwa2kU0tgv18JdKbrjaQa/Ed34mthDDws/ij+6Kdu7Nwxo8ebTaH4/VZ1vU1WqU4E=@vger.kernel.org, AJvYcCXEJeIOck7P9ZH1qpkUSg34JJmLykqBkxHYcNSsp6VnNGK+OyDImTwrGArCTNFBn/Jd8+A9CkzQBU1VLy2B@vger.kernel.org
X-Gm-Message-State: AOJu0YwafXYKFIBkZi5i+EBLhNtSHXFFouJ1qMvwLDQ4GxN2gbIosXz3
	KNOlixGOA8q+S/xkGn10R6hVvwSa+fuq/o2uXTKb2sPs5uhNIVucyR6kvfba
X-Google-Smtp-Source: AGHT+IG/rbFlFVuwrw+YDsQyuuBns2vfsbiCf6DnPSaDf3Ohl3baq7iQSNHITEkd1eaXENVMWU6SNw==
X-Received: by 2002:a05:6a20:cfa4:b0:1c8:b145:29cd with SMTP id adf61e73a8af0-1cad7fc7118mr3702775637.24.1724256271557;
        Wed, 21 Aug 2024 09:04:31 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b6365afcsm11222944a12.87.2024.08.21.09.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 09:04:30 -0700 (PDT)
Message-ID: <2449825072217d392b5b631e8fd394e91b22a256.camel@gmail.com>
Subject: Re: KASAN: null-ptr-deref in bpf_core_calc_relo_insn
From: Eduard Zingerman <eddyz87@gmail.com>
To: Liu RuiTong <cnitlrt@gmail.com>, stable@vger.kernel.org
Cc: regressions@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 21 Aug 2024 09:04:24 -0700
In-Reply-To: <188a0d1310609fddc29524a64fa3c470fc7c4c94.camel@gmail.com>
References: 
	<CAK55_s6do7C+DVwbwY_7nKfUz0YLDoiA1v6X3Y9+p0sWzipFSA@mail.gmail.com>
	 <badd583d09868ffdd48a97c727680ca6f5699727.camel@gmail.com>
	 <188a0d1310609fddc29524a64fa3c470fc7c4c94.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-21 at 04:46 -0700, Eduard Zingerman wrote:

[...]

> will post a fix to bpf mailing list shortly.

Status update:
apologies for the delay, the fix is trivial but I have some problems
with test case not printing expected log on BPF CI, need some time to debug=
.

Link to wip patch:
https://github.com/eddyz87/bpf/tree/relo-core-bad-local-id


