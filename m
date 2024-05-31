Return-Path: <bpf+bounces-30996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A47CB8D591A
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 05:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A5511F25547
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 03:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1D078C88;
	Fri, 31 May 2024 03:41:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D21182DB
	for <bpf@vger.kernel.org>; Fri, 31 May 2024 03:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717126866; cv=none; b=hfUJiEE8GRh7UIa6RAWBUZcnDTRMs0OouNsQ2Vhp1rLlca725NV4dOqZRzlnqYGnNlaHInZMWzo/kfp7n/Vu3VCCaHrJp34lYz/02JRVIJaWjqNfvm1X3JYbD0bPPiwCFJ+oNFuO1thnL46bFJdc9L4fiqQU7isusxR9JwpzbQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717126866; c=relaxed/simple;
	bh=1rC0NKAONkLy0Oylwnzz5uBXjuFKNURyJe5NXU6R/yQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=H3ftyUlYlUnnQhlHSSwOc8NmCSMt6Gy5QmPgwY7dVG1F6Pqas1zUpvwWbC7oPInwWXRAVEcfwHra9vYNFI25WgWayvrep6kWJs7IDMyUfwD6ZcgJzJ4wc+zjCZ5yGzq6VBU9ccdeDSIGyBlp6rDRabY4tYQrZEmIwoK9sRWpklA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3744edd84b1so17022565ab.0
        for <bpf@vger.kernel.org>; Thu, 30 May 2024 20:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717126864; x=1717731664;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=87j8o62HbkkhT6SZnt8wHJxPfsDOYjfW8V8a3wMHqjk=;
        b=VlfY3CJLGk+QEMyeLHqX8L+ITYHQTl4k4cakHwvW91ZSug7vP5uuqr5epDvmjZM/Yp
         DwX50+93+kj0HHJ0CrsNi/8VHWTRED/jfe0ywnw9FZFxR5dZXaeIfbFqTCa636AV3HxO
         YD+w8y156bCxAGX9z+USfCaDInlf69ZUl5eTByoXQ4z/HilFtBZWoF4H7Jrsv0sQDP0o
         X6WUuElCeSIeE6OYR3ISLzka4YxTJFgjQFIIvkNDkhyFOQLuAeAcM/miCxbzgnGgQNpD
         XpWUWQ2rgIh0FqLPxqBYGKgc2IRxwMrVGa3+H6eFGvqBO5GWhy98pibIoV8pSf2A256G
         6JzA==
X-Forwarded-Encrypted: i=1; AJvYcCWFh801NnPAy8d7MHmd9nLkLJoGjS8uTKFFMmMZVy6SuWOHv2yZ4eQHlHKP3T6/gOXqdsXh7B4czEQrmQ2JWQRbkBUB
X-Gm-Message-State: AOJu0Yxd0bnsGh9byeEIN3JlWRV84poYESfCHPIwLlQovwu9e7Q52ia6
	BLqggOKQQyoREZthGIK8h1friTULvl3+MXyz5yHoG7Jldl3bonAcBffqdiGJWGu8DstD6CLCTFQ
	3GcuRRlUK7/Q+aca5aJ9bom+iVRYj5qM2uRpgQ7s3tAQPIfbNAO/mfCA=
X-Google-Smtp-Source: AGHT+IGCsBUAVeOUsq1Bd0MSppgJvFf3Y3DrIaiDcrLOlhPfacoqnuTlaSqh8WRL67WxbHmUn3DdOa1DZgLuDjt1aCDR7Qa0FR43
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6b:b0:373:89cf:c491 with SMTP id
 e9e14a558f8ab-3748b8f3693mr101875ab.0.1717126864795; Thu, 30 May 2024
 20:41:04 -0700 (PDT)
Date: Thu, 30 May 2024 20:41:04 -0700
In-Reply-To: <0000000000007628d60614449e5d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cf8dba0619b7c0db@google.com>
Subject: Re: [syzbot] [bpf?] general protection fault in bpf_check (2)
From: syzbot <syzbot+ba82760c63ba37799f70@syzkaller.appspotmail.com>
To: andrii@kernel.org, aou@eecs.berkeley.edu, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	olsajiri@gmail.com, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	puranjay12@gmail.com, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 122fdbd2a030a95128737fc77e47df15a8f170c3
Author: Puranjay Mohan <puranjay12@gmail.com>
Date:   Fri Mar 22 15:35:18 2024 +0000

    bpf: verifier: reject addr_space_cast insn without arena

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14e17d3c980000
start commit:   4c2a26fc80bc bpf-next: Avoid goto in regs_refine_cond_op()
git tree:       bpf-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=ba82760c63ba37799f70
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e6bbb9180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12941291180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bpf: verifier: reject addr_space_cast insn without arena

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

