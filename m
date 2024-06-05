Return-Path: <bpf+bounces-31428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB118FC8DC
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 12:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3D3B1C225DF
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 10:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B1D191470;
	Wed,  5 Jun 2024 10:21:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E59190071
	for <bpf@vger.kernel.org>; Wed,  5 Jun 2024 10:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717582863; cv=none; b=gcMt5tCo/Gipd6cgAit/g8WY9fM8sU/HW0lWkA5wEH2gptpxsijGUCvVrLfJakhxt8aLZQot82G28XexXDZCvxFNkXOpRAnZ0U4FrkNdzvDRJXru2w0z8jefO8FTRJGJ0lD8zVfxixfz8qg5s4QAsvQsei5n0GpKXDL7tSytr10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717582863; c=relaxed/simple;
	bh=mKZu2TsVWfel24gk5GGVXlpaHk53VCdi2sv9+kicIa0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pkGtn14WP/QpmC7CEK0IjrIrcKrzqsOwsayp2VCb0uVfoCGJhX/wnleWInc/CnvWXONDvcW9lZwje9yXF0WHdX5CYRmvS/tvPLZg2T4mWeV9pr8yxtuPQoqCnEBmGbqw+qctrN8kqt6GoyQskdAyQpb4FV77XO8H6gIz6EY5tzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-374b5078c77so2776405ab.2
        for <bpf@vger.kernel.org>; Wed, 05 Jun 2024 03:21:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717582862; x=1718187662;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fH+Zetcf0TrdH6Eg/Hbnzc/0iC4RotiHhcppjlwNKMw=;
        b=m1/A896e6ydAvsarPlG8K6iV3rVbsFEzHE8zD8dueM4lZ3p9nA6TwphtpiNRLvrMDi
         0y4Bnw3o8Wy1A2DKBOM65nGv2aqkbibN7SMex4LhpwzMEaAhb3vXgUpgoaVeByJnLJ3l
         bup8Ldswloa0P58Yn+8etDu6tp3D/cyu36IGIHSWa68E5uygH24fjO/OFFrwuVgGNR8t
         fRF3dDMVCtA+YnGuAW7kgeSRCfQIYf5udc2hfJRrPwgB8OlduQ8Y7K1Ez6E5q8fEZPFN
         GNiCLLnvL1WKqDVQ8V3hyPy1YJEx/DXunWXv0VtK1vjIHDo0Ex7ONvmqKadoykXzJ9Yu
         eUQg==
X-Forwarded-Encrypted: i=1; AJvYcCV4+6QnZ0YX9atMjpguICNgOsJdWEMTGwKLfItJSBm0H+k49+yn7xolIdryVh3A2YrI+BPL3e+SNNHmWhie4OcMV8j/
X-Gm-Message-State: AOJu0Yx2tRlzHcg+TjHTeYAxLCg8NNomlKZRgtBIw+qkp1X3CoOcTKsW
	yKoVGtGQf548yePnpMjhDAGYwr4/5icx+A/pnLfn+MOU6+1BlUgzSozkGvetyzh/0/RkhEhGiIt
	GqCzYN0zntoA+NEzwik3WU5U4KXPmwN79Dup43Qstzce1KYKxFy5kTb4=
X-Google-Smtp-Source: AGHT+IG3vMdJkUy72bl6FiyEjn1C/RymPUEXO6Zdu0OIGN1VuBMTk/OUf7CaCqmwocVKMjUvFAhy/WV+kU6PuPQentk8vT+NJLLq
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26a:0:b0:374:a840:e5be with SMTP id
 e9e14a558f8ab-374b1e16d27mr1108305ab.0.1717582861831; Wed, 05 Jun 2024
 03:21:01 -0700 (PDT)
Date: Wed, 05 Jun 2024 03:21:01 -0700
In-Reply-To: <00000000000091ad3106157b63e6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005a260c061a21ec0f@google.com>
Subject: Re: [syzbot] [bpf?] BUG: unable to handle kernel paging request in jhash
From: syzbot <syzbot+6592955f6080eeb2160f@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	joannekoong@fb.com, john.fastabend@gmail.com, jolsa@kernel.org, kafai@fb.com, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	mattbobrowski@google.com, netdev@vger.kernel.org, sdf@google.com, 
	song@kernel.org, songliubraving@fb.com, syzkaller-bugs@googlegroups.com, 
	yhs@fb.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 4dd651076ef0e5f09940f763a1b4e8a209dab7ab
Author: Matt Bobrowski <mattbobrowski@google.com>
Date:   Tue Mar 26 19:50:19 2024 +0000

    bpf: update BPF LSM designated reviewer list

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=142f8d64980000
start commit:   14bb1e8c8d4a selftests/bpf: Fix flaky test btf_map_in_map/..
git tree:       bpf-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=6592955f6080eeb2160f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f7a1d3180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b28b3d180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bpf: update BPF LSM designated reviewer list

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

