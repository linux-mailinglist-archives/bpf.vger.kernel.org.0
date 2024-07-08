Return-Path: <bpf+bounces-34171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F92992ACA6
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 01:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB2E6282DAE
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 23:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011EB153593;
	Mon,  8 Jul 2024 23:49:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C75C14F118
	for <bpf@vger.kernel.org>; Mon,  8 Jul 2024 23:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720482546; cv=none; b=qDeHge7VG/4xt4atx5duCyrDF57RMdBSTW0MGf3Nvyr1g0XvGZAau15MzjsAzZCNTwWZuUAMrRXMl24wBlq9YAM6BFxqx6tdLtZjRokUeEcvQnO2a4X0mu5x8WaJMSfkOGS/H+Zw9wKQz1G+5hLMUj8cmLGq2FHbnHRkGaO/e00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720482546; c=relaxed/simple;
	bh=585OTXLduml4b44q7SgXj9FJO/8XEJO2jUdcjWdYPno=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XW9Ejj1kRRXPmWfO4r2mXph27G7lgj6UNbsI11yR32s4FIoyLc12rxx4sOI+04DozG2Ut3GgQxfFPc7vjeSH6fO+SB8QPyx/C31tsqtzsuPdgJMgVo1H4i8vW9WMbaiYS9zvon9Q92DVrHF1/a2ZIu7VH3WQMWYgDQg01HR3LfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=baylibre.com; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2c9a10728abso2433417a91.0
        for <bpf@vger.kernel.org>; Mon, 08 Jul 2024 16:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720482543; x=1721087343;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KTCvURDHt1Ehhy2ogJ4G2eNRAbN+TU2XGb1d5J/SBYc=;
        b=LQOQpafbGsTSwAQOoDJe8uN/5tmcJCkT/e+4sRHXGHJ4lGJ4JB57l39hMB/2mlV2oc
         MoUbJVhXdpy/N37Z8mwF49uAayaunYpM3X3/RwRyfwsRrESdU6YxyIZATtcPekpSESxM
         dDNTUAVNWTY7wmx2MpPTXf7KE+iJm+Z8DDvfuQqi/+vVDTuuPJq2R2lNZ/vcE6INpr45
         n0JcuK1x/rvq0mxAqQMxwDmRavtKXSyA5SOzK0DkpPxgua4+/DOrN6bslCqfPFGW14HQ
         mXs6HUFIuGWkUUBACMhoPVB9NcAMtaE4DaWjUmtTxdyKyH0eqd2k7JGT1YJl84x49MN1
         Gkow==
X-Forwarded-Encrypted: i=1; AJvYcCXZ0rMnF4PDCeaqxkh0nl7eBoRsQYaSfHzfbV06W0UB0kONPG5Xz9NEaRbugjJ9HS4dEF6wiOxi9AeCZZgr9t6Grkj9
X-Gm-Message-State: AOJu0YwJD2kwk6T09pW31/6ASwoP6DkEqjGiLUgXYFjsWe4kWqC5zJ23
	9zkhYTY6b6VLiXicXuIZpMMgEJUl5M55zRtox/FTGQ4/AGkCYZ/8SeR33v/OQiE=
X-Google-Smtp-Source: AGHT+IF2sRCcp1Qt2ncA7/dcBS7eQVYhbuVP4CESqTDlDqz8AWSIBYQ0ftySS6HXoODFEfyN2bXeTQ==
X-Received: by 2002:a17:90a:a10d:b0:2c4:dfa6:df00 with SMTP id 98e67ed59e1d1-2ca35be0661mr981011a91.8.1720482542878;
        Mon, 08 Jul 2024 16:49:02 -0700 (PDT)
Received: from localhost (97-126-77-189.tukw.qwest.net. [97.126.77.189])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ca344c399csm596679a91.5.2024.07.08.16.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 16:49:02 -0700 (PDT)
From: Kevin Hilman <khilman@kernel.org>
To: Celeste Liu <coelacanthushex@gmail.com>, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>, Anup Patel <anup@brainfault.org>, Guo
 Ren <guoren@kernel.org>, Palmer Dabbelt <palmer@rivosinc.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, Vladimir Kondratiev
 <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, =?utf-8?Q?Th=C3=A9o?= Lebrun
 <theo.lebrun@bootlin.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>, Sven Joachim
 <svenjoac@gmx.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich
 Felker <dalias@libc.org>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, Russell King <linux@armlinux.org.uk>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Tony
 Lindgren <tony@atomide.com>, Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
 Mykola Lysenko <mykolal@fb.com>, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
 linux-tegra@vger.kernel.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-sh@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lennart Poettering <lennart@poettering.net>,
 Icenowy Zheng <uwu@icenowy.me>, Celeste Liu <CoelacanthusHex@gmail.com>
Subject: Re: [PATCH 6/6] arm: defconfig: drop RT_GROUP_SCHED=y from
 bcm2855/tegra/omap2plus
In-Reply-To: <20240530111947.549474-14-CoelacanthusHex@gmail.com>
References: <20240530111947.549474-8-CoelacanthusHex@gmail.com>
 <20240530111947.549474-14-CoelacanthusHex@gmail.com>
Date: Mon, 08 Jul 2024 16:49:01 -0700
Message-ID: <7hv81f78cy.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Celeste Liu <coelacanthushex@gmail.com> writes:

> Commit 673ce00c5d6c ("ARM: omap2plus_defconfig: Add support for distros
> with systemd") said it's because of recommendation from systemd. But
> systemd changed their recommendation later.[1]
>
> For cgroup v1, if turned on, and there's any cgroup in the "cpu" hierarchy it
> needs an RT budget assigned, otherwise the processes in it will not be able to
> get RT at all. The problem with RT group scheduling is that it requires the
> budget assigned but there's no way we could assign a default budget, since the
> values to assign are both upper and lower time limits, are absolute, and need to
> be sum up to < 1 for each individal cgroup. That means we cannot really come up
> with values that would work by default in the general case.[2]
>
> For cgroup v2, it's almost unusable as well. If it turned on, the cpu controller
> can only be enabled when all RT processes are in the root cgroup. But it will
> lose the benefits of cgroup v2 if all RT process were placed in the same cgroup.
>
> Red Hat, Gentoo, Arch Linux and Debian all disable it. systemd also doesn't
> support it.
>
> [1]: https://github.com/systemd/systemd/commit/f4e74be1856b3ac058acbf1be321c31d5299f69f
> [2]: https://bugzilla.redhat.com/show_bug.cgi?id=1229700
>
> Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
> ---
>  arch/arm/configs/bcm2835_defconfig   | 1 -
>  arch/arm/configs/omap2plus_defconfig | 1 -
>  arch/arm/configs/tegra_defconfig     | 1 -

For omap2plus_defconfig:

Acked-by: Kevin Hilman <khilman@baylibre.com>


