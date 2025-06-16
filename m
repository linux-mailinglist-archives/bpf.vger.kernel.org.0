Return-Path: <bpf+bounces-60768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9E6ADBB6A
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 22:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CD50176604
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 20:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B272116F6;
	Mon, 16 Jun 2025 20:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCLQKVei"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BD11C860C;
	Mon, 16 Jun 2025 20:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750106610; cv=none; b=Ne7lqFdvugeU0lF9kLgeWj3ENyEEOsfnYrjNqkBfOQLPPkSmq2QOfBgoDH4eECvhtZT3PbjPPY8IU/OdR3b1IQYGZENY6R9Cbbqwx7CM4LmVGP16La5oCV5fqnOa2GFLmzz6Y2B+a3YWYkAsz795YqDgiHoJuME67iYqO9WYjSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750106610; c=relaxed/simple;
	bh=MPROsdRxArwhnjbtN9ZftmZMxHEmEvfOk5+/jeQ8KB8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eM00kzWJJCv1PpXoRLaLXemWLPiG9uXGMwmPitArglDTqR81GOKdVoBtNFvDKlTmvLYbV3MZPzydo8tZSWijkWNcxqbIaEJPyWw6asPZr7Yx4xpMK+Q8e/VjKTzhfth4SUmlyKAp+iMTyH5x89SkHw7c8PvCYCUt69jd1FqrxuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCLQKVei; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4a3db0666f2so112345681cf.1;
        Mon, 16 Jun 2025 13:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750106607; x=1750711407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRWSTZ0XbChoIlsy92a3twWjGeU8UCDzFEMehFMQRMw=;
        b=DCLQKVeijs9a7MDHZh0ZO1APAeggCjdfisQWGeTla5otMaEnuvrbRGV2YeUfa4HDyx
         4o+DaonMI3F8G+oWlqI6tNLyeGAZFdINf4ftqWEilw+Tvahbg2r9tlsw/ZFbBRZGxMwb
         O2yROIqHqjY9lt/m0OnzUB+UkJU7AovHdYh5CQfmUMXfr/s3uNFPDWu1p/D1gtNusxFt
         /Qss8znxrOP4fgOSielYVCmzhxgG97ddYdPcXMQ2ZGf9pKBghvUrncDFBEa/I8SMWJA+
         lImqhWvt7FE45hz9KNEgslCj45JZ5sk1mgDIf/UKzzjS3TvD7BhcaGZ1PKr2qOqWCdiG
         K5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750106607; x=1750711407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eRWSTZ0XbChoIlsy92a3twWjGeU8UCDzFEMehFMQRMw=;
        b=UGfYZN275IcY6PP8fcp9CUsm4TkPEHeWkkdDRIalCfiXzlf84M/xTKnM/lE2OEPoHd
         PVfonyM1FLZvQHzlk6gpqH6KVys0mSpLfs7kWF/x49MllcYIGQAhV/jAVhZUL91b5X7L
         HhXk9Alkt8qpAgLan3P2NRcFKnEb22DnZKU/dwNpYRj6jbzwHUzaZfjy8y/V19tfxlWM
         FtKGEtPV3z1neWf7bwAcCF+BkhNZZqcR/vUo0f+PAZNQMed4Yjp52gyco7zU7mAX2HuS
         y8avM1hu0VX43wWlNJy+1Q4d/BlkV7XcTIx2P0fqdsE2bLxGWRZzP5J1a7XgJENqlNoh
         hDQw==
X-Forwarded-Encrypted: i=1; AJvYcCWqGjhKVGMBZklzOn+5mSZuz1Yj0lViFqNM+AOlzBtcP86HMPJgD4hClD0cizvYzhOzJOWLWb+g@vger.kernel.org, AJvYcCX/I9dHKxKObPslfEQ9dwnDrU3zjDWHUmm+LDOWQbrCUu6ojZy2yWyFmy0p5JPeF71zBeG9X9x0shFfpBw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6V/EUdqwedkQDR4Y+BJDY8sluQTKVjqBagBqOdDF5aBPO7ZEy
	rYbfKRuL8daZLQIBD/NU3l7ZZ7ISwWqigvUiWHOy5WlXBjQXnIRKLLHc
X-Gm-Gg: ASbGncte25JCwsB8rnr4M8+crRUHQ/Iek56LI37zUCKiFjqa4OEY9aqThkeTnnMhxm3
	nnW7Tu4Fbw1K66+Jk8DWb5/OmeNegXn4U6jZ2aWQaZxwoehDnK8fKXsenmuYdaXbKvgmarw+asD
	idDbhOqhFFYlqa6jnQf65HAXLEeOB6TeDkF4EZO0dnoE1JgrZca+oAYlgNQftGwMJdRLs3qgK8C
	4Hg3KAxySPNChi0nvvKwVL4cjbpvjMKS4FXWEw4BX8iQFF10XuV5OdAPKnNhhcmM7tz//Fj2DtJ
	xDBSaPQIQLh6Gh2FZh+fDculf1XSRMeb/IdHgjaOYT3KS5BZ77VMIZ6X4FYU6acpN/YrzWLwJeu
	QrMvbzAO3ScNxc8qz6Jg5bQe6sCccnvbapPWjRpUT0Q==
X-Google-Smtp-Source: AGHT+IH7BnvrBt09eangwJrns+ePgz/UJrNeXwsBCjJZDAR2PEBxYpJLCZcb8nTbHvvK0S0/K2oXPw==
X-Received: by 2002:ac8:7d0e:0:b0:4a6:c5ea:6fc with SMTP id d75a77b69052e-4a73c5b0a8bmr146135721cf.42.1750106607313;
        Mon, 16 Jun 2025 13:43:27 -0700 (PDT)
Received: from localhost.localdomain (syn-184-074-055-142.biz.spectrum.com. [184.74.55.142])
        by smtp.googlemail.com with ESMTPSA id d75a77b69052e-4a72a52a1ddsm53655481cf.81.2025.06.16.13.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 13:43:26 -0700 (PDT)
From: Robert Cross <quantumcross@gmail.com>
To: andrew@lunn.ch
Cc: bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	olteanv@gmail.com,
	pabeni@redhat.com,
	quantumcross@gmail.com
Subject: Re: [PATCH v2] net: dsa: mv88e6xxx: fix external smi for mv88e6176
Date: Mon, 16 Jun 2025 16:43:24 -0400
Message-Id: <20250616204324.2542804-1-quantumcross@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <ad17b701-f260-473f-b96f-0668ce052e75@lunn.ch>
References: <ad17b701-f260-473f-b96f-0668ce052e75@lunn.ch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Imagine that, it just works when I set it up like that...


And now I don't get concerning watchdog event messages probably from
putting the chip and driver in an undefined state!

[  145.839142] mv88e6085 gpio-0:04: Watchdog event: 0x003b

Thank you again!

