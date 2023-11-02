Return-Path: <bpf+bounces-13862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B99417DE935
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 01:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7631728182E
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 00:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038C9EDB;
	Thu,  2 Nov 2023 00:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A12195
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 00:14:09 +0000 (UTC)
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0780011C
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 17:14:04 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b2e6189e6aso623948b6e.3
        for <bpf@vger.kernel.org>; Wed, 01 Nov 2023 17:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698884043; x=1699488843;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3o8M4olUhxGuYhfUSjcCSpJU5SY7A9yJ4TSgZavfZUU=;
        b=nLBfAGwwqj2o4vmQSgzfrlXaQrbnaNRaENsE4f9ymN5/qYRpCJ2AreTWwObKKmKCsy
         Tk1eXZjZ9KjBFhKaIszedhWe/A/8QvN8+cGhIh94D6sziPLnu3aFSDez+VsKDWVLHP2D
         +meCxo1pNUNWsDWpiis3LIle1MdZoSzOp05Teo5tkm/Xnrqvd4sZYrkVgEvx7yD2zywI
         pWl964q7rAKCV/R72XePwUckaVTC6VzKnHLFVEC0iHG1jwUzv939tiMxGkNbYtHtrlNZ
         XsYozMJZ75vuReuF4QLMt1GFTCT5iOVlDmpw9i9lbpvvGuj6wrypJ+k7KpjWT8afwVyS
         hxpg==
X-Gm-Message-State: AOJu0YyaSv0T0pV1seDpFXWWhIRQ1oEKFn1niVLVQx63ShOSF1NTZgPQ
	ceKMPm4WDetEBcPchJQM5iOEZGtzE8miv4hZ7O9Iml8gRJ+a
X-Google-Smtp-Source: AGHT+IGXujbYdoaOwMiOFafFIW9sSBBYTm1Pp7ERXnBxyhbhAcfk6UQLTv/cxWX2Xmxo1xLz6z1fbF2B0KrsJKybb/11d1grAeua
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1304:b0:3ae:15b6:3292 with SMTP id
 y4-20020a056808130400b003ae15b63292mr6713187oiv.4.1698884043406; Wed, 01 Nov
 2023 17:14:03 -0700 (PDT)
Date: Wed, 01 Nov 2023 17:14:03 -0700
In-Reply-To: <0000000000003495bf060724994a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ec03e20609204362@google.com>
Subject: Re: [syzbot] [net?] [usb?] INFO: rcu detected stall in worker_thread (9)
From: syzbot <syzbot+225bfad78b079744fd5e@syzkaller.appspotmail.com>
To: admini@syzkaller.appspotmail.com, bpf@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, gregkh@linuxfoundation.org, hdanton@sina.com, 
	horms@kernel.org, jiri@nvidia.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, rafael@kernel.org, 
	syzkaller-bugs@googlegroups.com, twuufnxlz@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit c2368b19807affd7621f7c4638cd2e17fec13021
Author: Jiri Pirko <jiri@nvidia.com>
Date:   Fri Jul 29 07:10:35 2022 +0000

    net: devlink: introduce "unregistering" mark and use it during devlinks iteration

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1758e1e3680000
start commit:   1c8b86a3799f Merge tag 'xsa441-6.6-tag' of git://git.kerne..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14d8e1e3680000
console output: https://syzkaller.appspot.com/x/log.txt?x=10d8e1e3680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=11e478e28144788c
dashboard link: https://syzkaller.appspot.com/bug?extid=225bfad78b079744fd5e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155614de680000

Reported-by: syzbot+225bfad78b079744fd5e@syzkaller.appspotmail.com
Fixes: c2368b19807a ("net: devlink: introduce "unregistering" mark and use it during devlinks iteration")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

