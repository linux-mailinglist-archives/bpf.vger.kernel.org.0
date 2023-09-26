Return-Path: <bpf+bounces-10908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5674D7AF5C3
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 23:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C4D2F284018
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 21:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDA64A559;
	Tue, 26 Sep 2023 21:38:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A2B4A538
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 21:38:33 +0000 (UTC)
Received: from mail-oi1-x246.google.com (mail-oi1-x246.google.com [IPv6:2607:f8b0:4864:20::246])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47EF17EB5
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 14:38:29 -0700 (PDT)
Received: by mail-oi1-x246.google.com with SMTP id 5614622812f47-3ae5ac8de14so4340823b6e.2
        for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 14:38:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695764307; x=1696369107;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MrujW9fuUJnGCukcO08Sc48BocArkHwApSrdDVAkMsU=;
        b=qD7a7shB3IGQhuv+NMyBUd+Kwd6FRcKa0JTol8JJOScJhUer0qV20W9Rs3Wijiv2B4
         ljaSVbaHCU5On1xfNjQoyhzoAtG4ceobgT1LbJVrUKZeWGoL5lh9Sv3XZD6LcT93MuqG
         YaimW0dTn953Agm7LTNUld/OV0TnAXmWkpYlsDjJh3kZzn7En2XrDiW4NObyCl4N+iAM
         8ahcxexLntAaugqVPSofMy90xzS2CI9AlRsXAmm89OsrEb4aYBDwejyUx0MscewoGMSw
         V5xGdpC5t58bSGm+pMOvxUjoEWLyeNJcZ0RzRF5S38zC4N4wlkH59ekdzUAs8J3x9Frn
         U4Lw==
X-Gm-Message-State: AOJu0Ywqa1D6J2BG8aNQkh431m3aUEB06VK/pXvEd8Brx8zqSke8V5yV
	GbFqbpyKTPMt/kAyhmhS4fI8MNCAZypSBg4l8NjW+DPJhNdo
X-Google-Smtp-Source: AGHT+IHqUNvgj8r/sXHE/1psfIuTkefZXsSeZ3RVACSIBoFlYFfchd4gvfMw4G4oZMJnX1y+ZSBluLCG4GwUpEjncSbmx9hI9CeO
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2018:b0:3ae:1e08:41e7 with SMTP id
 q24-20020a056808201800b003ae1e0841e7mr90974oiw.9.1695764306911; Tue, 26 Sep
 2023 14:38:26 -0700 (PDT)
Date: Tue, 26 Sep 2023 14:38:26 -0700
In-Reply-To: <0000000000002c6cf80606492f14@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000022eedd060649e522@google.com>
Subject: Re: [syzbot] [bpf?] WARNING in bpf_mprog_pos_before
From: syzbot <syzbot+b97d20ed568ce0951a06@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, yhs@fb.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot has bisected this issue to:

commit e420bed025071a623d2720a92bc2245c84757ecb
Author: Daniel Borkmann <daniel@iogearbox.net>
Date:   Wed Jul 19 14:08:52 2023 +0000

    bpf: Add fd-based tcx multi-prog infra with link support

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=116ab4b6680000
start commit:   a59addacf899 drivers/net: process the result of hdlc_open(..
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=136ab4b6680000
console output: https://syzkaller.appspot.com/x/log.txt?x=156ab4b6680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d594086f139d167
dashboard link: https://syzkaller.appspot.com/bug?extid=b97d20ed568ce0951a06
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10dc3946680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=107f4e1e680000

Reported-by: syzbot+b97d20ed568ce0951a06@syzkaller.appspotmail.com
Fixes: e420bed02507 ("bpf: Add fd-based tcx multi-prog infra with link support")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

