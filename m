Return-Path: <bpf+bounces-27103-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 564EB8A914C
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 04:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CE8C1F21BEC
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 02:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09565339A;
	Thu, 18 Apr 2024 02:51:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE0D50A73
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 02:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713408666; cv=none; b=FrM1Ud3cxks5tfOn9jkRTjOklQt2QhjwGaNnD7p6KLgJrS7HUaMj+8TBoCbw4dRNt6ToCOSaz3c0AbGOTnog2yV3aJKa8dhBj5LsWuYS2Y+UR1yo9tGFNUWfyIJCNwS2ROKLk6h/LS0eezj8/8f5DxDCkWeLivvQj+xR/mbH8lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713408666; c=relaxed/simple;
	bh=kemaksdsrlIR1S57gG0m03aOcevlas0sdvRbHQ9Py28=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=R5AWx8aXkDE/BU7RsF/ej2kRaJH3MwU06W5iDpgqFl42OKuU5YEWpk5n66sX0rLEYbnfM2+W7kOwJcTUqbsf35oYaXRmTQuxeAA8ky4tYZRPQXdCwZwkcylaWmqUAnFcG46EguS7iP5diuE+dq0jADeHQDG60qmq04fiTf75YYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7d6c32ef13bso40337439f.0
        for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 19:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713408664; x=1714013464;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ikh/8IxQiRxUmOZmfpOtSXJ4MJQsJVrq/VyspE2r/6Y=;
        b=qvu7rnmMEjOixODzAMdqeqoz1fjz3gmXFC3aYZxvbFCP1c7XOT38LPuSZoiNVPQomO
         0mDJgVzCJ7x+mDWGJRphsgoPEyaPds0tNXo9kL/YCeUiOyDL+aMxOGETLu12SQYSm8tN
         WMqBoOypDf0wOcL1YtWYsWw3DGxTrUd1Pur9G7oGPYjaw9eEfqmKizAcbop/0tFHY6pO
         OdRx/jum7+Yu8anEJXlrbwH4666U0ocr3c9PsAd8GR3F9T8c6luiEAFvczJlnep8tZU5
         M5p2o1lJxtZi9KR4+P773TmgsstoGEEtUfIohQhbEWhNkGgywkGcJ7FYSCZRPuo/cvMu
         9MUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWP+8WHxKiLWxlC+NZ/+qmqE5Z9Ra7iXHe9FTDlXYs4+WHmwzPQ28hzCuk3EFJwz8imZsQhQNVaM27dYyjZUHmd9/eJ
X-Gm-Message-State: AOJu0YzlHEmUWBxxZPMFAg43rhFqsszw9Vci69OuDV5FOaYzrkCQTGj0
	zfjjdgfq3l3oqD14v6/ZNDklueqF3dtg0FYLftnIEzHzt2soCNevQ6EgzXO1csnxXoMgU3PR9YM
	XnqLj3OJnVp2DJAVhCYgL4lK95lGYhO+iK8OVi268uCDmGlzPTSNgRgM=
X-Google-Smtp-Source: AGHT+IEH7hcoKAZspDMi2dP3VJIZw+p013dekRsehXW/X7ylh3IrZDuqB98iGe7Y8ncILxLfuz6GLvx/hTAlufONhdsfcuPNRCmR
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:378e:b0:482:f06b:70d5 with SMTP id
 w14-20020a056638378e00b00482f06b70d5mr77102jal.5.1713408664122; Wed, 17 Apr
 2024 19:51:04 -0700 (PDT)
Date: Wed, 17 Apr 2024 19:51:04 -0700
In-Reply-To: <871q73vlvj.fsf@toke.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c7cac10616560a93@google.com>
Subject: Re: [syzbot] [bpf?] [net?] general protection fault in dev_map_enqueue
From: syzbot <syzbot+af9492708df9797198d6@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, eadavis@qq.com, eddyz87@gmail.com, 
	haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	toke@kernel.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+af9492708df9797198d6@syzkaller.appspotmail.com

Tested on:

commit:         443574b0 riscv, bpf: Fix kfunc parameters incompatibil..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15d5b33b180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=af9492708df9797198d6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12bfa653180000

Note: testing is done by a robot and is best-effort only.

