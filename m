Return-Path: <bpf+bounces-47850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 755C2A00BD7
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 17:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6B313A332B
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 16:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19B11FBCB3;
	Fri,  3 Jan 2025 16:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKVLijLh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA921FBCAD
	for <bpf@vger.kernel.org>; Fri,  3 Jan 2025 16:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735920316; cv=none; b=BZD2WwtWfxl+WrPJx8cfETRJVMzSN5BeaaZYd05jkxQSxYOmuGUlRLD+ysu+qP14Mj8BeCh7EDufB/IjVc+mRv3xPXPbIIT0uTmSfBsrvX2CMncL9B4Ll1fUH26W28+TdVDbatW8cyY4vXLoBqEnM/u4qUtBGUCP5h8r4JlAIlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735920316; c=relaxed/simple;
	bh=UO4lhbdj1GD/m/y+fpTO9v6Op8hq/vjivEVy8UwgpEY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=MfV/rXUY+nwQg3cVFE0YUSOPRMdCJAHDxWsYQrHVdEUSqZES1pCPF6XXQfXaHVzAQCOloM3UNe6JYTkDfJxveCy8eShjiJYDRFKyQfgN9q38OMBp0UZ6wBYIOrAwrViVIMArScLQ+YBpVc60XKAyC6C6pPvyMDRzUARPApeAcI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKVLijLh; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-467a17055e6so137412231cf.3
        for <bpf@vger.kernel.org>; Fri, 03 Jan 2025 08:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735920313; x=1736525113; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RQ/ed21MHOAlRtacBDc3QMZYhDKkcHDFus8mlGjwh+E=;
        b=PKVLijLh4C3NsI5Y3WaJMssyjtSzZ8oA/S7uEAvyr4e0zbppMTxA6etdcsRpSg2mBy
         Dkz+yNFN64615UPLhyd0/A3etzYt5F3kPnAa0Cqm0hcBOSizTxd5N95EFkSAaoHULI40
         +u5N9dvAARcfhuj9TMoN+ryRzhQd6faUoVdluHKyxlqzsH8TyTgsTftf2hJxYtfBxXQp
         afCRJko53o5/JSmng4egMmwj/GQsK2KI4Iqh3liPG7QmOgTW1iiTwfVyOE+tMxeGTZeG
         hQ0yr5DI/8dTC4A8AKyNtl9FsYYEjdtKfXHEMOxCOEZ0WpFF4yZhBI/bF5ofe5j97cs1
         ZfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735920313; x=1736525113;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RQ/ed21MHOAlRtacBDc3QMZYhDKkcHDFus8mlGjwh+E=;
        b=JMNhkemI2WVlE64YYiIhpgcvJl3zCwMo2Q762XLTtZOYn8PBBmMhvJfAqRv6TXYzh6
         z1hgONfC3iTp59AfGWFpgWMSouRhTwSUxf/4cC71c8CYRZjvFnB4jcMX0mc5OS2Tz20X
         I3QpTVx6Uyv+rf8GNht49KfD8LFsupOrMKqtJUkNAN2PkX8Q+eUvp8bFagd7TDLZ911A
         aW3nCKJYX0W/12Dhn2zkl9KFQ5w3rdK4mpFTLqA4U1NJGup3CWETYUnGL0sa9btckZmj
         liSMo6MuYA0SmnhTfF1LOjcZKlpc4AnW6886tBgcW/a5I/8268ZY4HroGO7CsP7pyLCk
         6pXQ==
X-Gm-Message-State: AOJu0YyKdI/6CQ5Bqv1ih7M3Oi6uQPqJiVenkHpOi+6OQXPLcFc713sR
	Luzdp2D1bVVdLH5ZfT/eDLjSr2LA7+ymMEQX1JivcXKaDvm0eCtIjp4KZ4zIFvfmOITonyMKKyH
	GAED2aT3HbdkJz88QF8xolpLiTNBQuDjT
X-Gm-Gg: ASbGncuXz1pdwMeLKtprp515gCZlWCbeAFoDmHVU4QQkRnHcq9SVbNq/n/f7pKQhbA9
	ujvz+W8XLn7XSEAMZukkfR53CvoEJK3TA4XAtjg==
X-Google-Smtp-Source: AGHT+IEiw1n6GC+kyUvEQSdHxZ2c45hW/wL0yUwXkjPiht2T/0eruKbUBuBmSkfJXTcimfVLZTIaTq9cc3rcYJ/oELU=
X-Received: by 2002:ac8:5a48:0:b0:467:6692:c189 with SMTP id
 d75a77b69052e-46a4a8cdda7mr845846911cf.13.1735920313365; Fri, 03 Jan 2025
 08:05:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Fri, 3 Jan 2025 08:05:02 -0800
Message-ID: <CAK3+h2zhbg-9kf+CMFdvP75j+js-azmofnZLAbdnzx87hYsHeg@mail.gmail.com>
Subject: bpf loongarch64: XDP program cause loongson 3A6000 mini PC CPU stall
To: bpf <bpf@vger.kernel.org>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Tiezhu

After running the xdp-loader load XDP program on a loongson 3A6000
mini PC running an open source firewall LoonFire - port of IPFire on
Loongson CPU,  the mini PC is auto rebooted, and hard lockup when
trying Fedora loongarch OS release, I have to press the power button
to reboot the PC.

here is part of the kernel message from IPFire:

Jan  2 11:13:19 loongfire kernel: [ 6668.795062] rcu: INFO:
rcu_preempt self-detected stall on CPU
Jan  2 11:13:19 loongfire kernel: [ 6668.795067] rcu: ^I0-....: (1 GPs
behind) idle=220c/0/0x3 softirq=22456/22459 fqs=2376
Jan  2 11:13:19 loongfire kernel: [ 6668.795072] rcu: ^I(t=5250
jiffies g=67605 q=771 ncpus=8)
Jan  2 11:13:19 loongfire kernel: [ 6668.795077] CPU: 0 UID: 0 PID: 0
Comm: swapper/0 Tainted: G           O       6.12.5-ipfire #1
Jan  2 11:13:19 loongfire kernel: [ 6668.795080] Tainted: [O]=OOT_MODULE
Jan  2 11:13:19 loongfire kernel: [ 6668.795081] Hardware name:
Loongson Loongson-3A6000-7A2000-NUC/Loongson-3A6000-7A2000-NUC, BIOS
Loongson-UDK2018-V4.0.05759-stable202405 07/12/24 15:49:14

Huacai suggested disabling jit and disable jit worked around the
issue. I tried kernel 6.12 and the most recent upstream kernel, same
issue. it should be reproducible on Fedora loongarch release by
running xdp-loader load the XDP program. [0]  has the kernel config
and XDP program link.

[0]: https://github.com/vincentmli/BPFire/issues/70

Thanks!

Vincent

