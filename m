Return-Path: <bpf+bounces-21361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D22884BBB1
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 18:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5936286078
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 17:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231796FB8;
	Tue,  6 Feb 2024 17:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="aVYZHwbK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0006FD9
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 17:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707239665; cv=none; b=cfKImlRkKskqCa03KV/lJ/2CcMxMen7/sqEXXluUmhOSc0KZ/R2jETt7nAxv6kqbB7fIg8WQbniOolCmcNL/5dYWybnFFkwjOrVHEDzyAkoQhNMD5xNDA3qLTmlLhTdv/ctcSFgSfLYuclWXn6QjTZDbfCWRMG1CrFQrvAtWhY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707239665; c=relaxed/simple;
	bh=LjfrJZmjtaAL5YynE67ccLa4T4eB+vForepUWip4ge4=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=TNBoHawtOwCDDkdprOT5xJk2iU/pKBP/ga6zwy0tyzzWytO6aiBd2UkU24qkF93TYi8c8QNOBtQc5qmY+H2b0EUoIBzXPXOkj/Jj1W90jaZc/elZ5TwZCacK/CLpQVgXwsW85jkeIcvusteQGPzgEAt629/G85+8EOdQw7figDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=aVYZHwbK; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e1352dd653so3731032a34.2
        for <bpf@vger.kernel.org>; Tue, 06 Feb 2024 09:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1707239663; x=1707844463; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LjfrJZmjtaAL5YynE67ccLa4T4eB+vForepUWip4ge4=;
        b=aVYZHwbKztajP2gHW+vWRgQwWrazfbQPG8BrYTDRO4zeLADbRwog/XWPjO5JwilBE3
         kd8v+xtXZdfWuA+9fCdUL1vhndmhcuVY14GEi76JQJdSN16ufMOTyVFdBqqxTFTFXwAA
         w/d7QtKHB7uIJLswz2UU4UTBc4aOJAMIboXeW3Sd5qKZdcAE3EtmJYC/kv8TAhOZ0GaN
         WvIvrPx6OSKd0Epo5BBLW/l2fsAZGFWZKgdec3vY36m4nLLUdyeEM9Nm3nxMp+mstY3b
         53GByyCX+/cckjjgzsBlODDjlTKvMUPusIUlIJJB0pBVj8t279l/RL2aqu462AOHud0d
         87gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707239663; x=1707844463;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LjfrJZmjtaAL5YynE67ccLa4T4eB+vForepUWip4ge4=;
        b=r1m802Zu28+I/x3AVaKAvDbGnSC8F7OhP45UCQCykkjG6I3eyjAXCKRGr87vChjsYF
         YkACkYURGm/WeWa16D3lJY5Wqqis6FEXXUsmve2WaTu2/juZPpGfHqX53B6xtl6yvac4
         jSvnnMc32T1gp9G/Yl2GdkF4k098QhEsqWo5qtR4S+tlip67ivfsyw1rCAg0q6jRi2UW
         d5zG7mWIqeJTIh38Jcu+kEZQr5WYIdZ2/M84LD245jQFR3QOvuoLkg+kF3C5+oQqfGl4
         X96mtFNmCw7P9kvKDzct8qfNb7QWOrllvlgzwx0P2ewQUibSyulE6yU5rrCsUQT2zFtR
         /rlQ==
X-Gm-Message-State: AOJu0YwuZxR1h19HV5jv3zwZgZwAuRaEubXwNh+lA/4FZwDC6BlURqmh
	gbRrtY9lyut1OSIqgG0ywLMInOeTxc8ZfLXR3J9wLShcZEOAA9hHrf0jY4yoM30=
X-Google-Smtp-Source: AGHT+IHD5ei8S8P+t8kRSpJL1YYhzIR8d3F+zNW9L3/VDzw5xh0m4kMFD1gzRyJy5trH44i4FDrtjQ==
X-Received: by 2002:a9d:75d1:0:b0:6e1:79a:fc8f with SMTP id c17-20020a9d75d1000000b006e1079afc8fmr3538637otl.35.1707239663004;
        Tue, 06 Feb 2024 09:14:23 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id e20-20020a9d5614000000b006dbaf72af27sm369199oti.1.2024.02.06.09.14.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Feb 2024 09:14:22 -0800 (PST)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: <lsf-pc@lists.linux-foundation.org>
Cc: <bpf@vger.kernel.org>
References: <0dd401da591f$a7d826f0$f78874d0$@gmail.com>
In-Reply-To: <0dd401da591f$a7d826f0$f78874d0$@gmail.com>
Subject: [LSF/MM/BPF TOPIC] Cross-platform BPF compiler issues
Date: Tue, 6 Feb 2024 09:14:21 -0800
Message-ID: <0de301da591f$ed978780$c8c69680$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIKzWl5LoyZhdxE1IDGbo2Z6oQybrCcpO5w
Content-Language: en-us

There are various BPF runtimes, including the Linux kernel, eBPF for
Windows, offload cards such as Netronome=92s, etc.
Each runtime may support a different set of ISA conformance groups, and
there are also different verifiers
that may be affected by various optimizations introduced by a =
compiler.=A0
This topic is to discuss some
issues observed with using common compilers to compile code for multiple
runtimes.

Dave


