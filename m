Return-Path: <bpf+bounces-18354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F92F819666
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 02:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D46B91F26585
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 01:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32D5BE65;
	Wed, 20 Dec 2023 01:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2gZPl3C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9893CBE4E;
	Wed, 20 Dec 2023 01:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33666fb9318so3120676f8f.2;
        Tue, 19 Dec 2023 17:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703036065; x=1703640865; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oWmavVkI7EEMaO28reqdQwqx9OWZaDcK9JROIB+bbN0=;
        b=m2gZPl3CqEM9Wg7a5p61+7M+5qdyjAjC105BOE4fPq31x2oK+u1anqbL+PD1JtKAkY
         nZtJWNrLN0iof2a9ywW9UIatrir7gSWqtwDHBjFCNi5m2njh6ghEYJZlExkxq9F3hon9
         n/di4jrmO35yIRVyJGQS3FVXlgOFBnxhxzT5LCspi3RUVE3IAkgnJ2yBMvDkyP8NOAKN
         I5g5dcuCq2YMc/ZCwleOVr2b4qBGjooDAG6lQNA0YzlNJvuvdw87WiBZsRr+gyGku9jc
         lpws+70nu9qOFWnNYTBopMmrHxkeiIECOlSpelTGPffwdl+NxtGIZvFcTaDXxIOjZuoi
         l+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703036065; x=1703640865;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oWmavVkI7EEMaO28reqdQwqx9OWZaDcK9JROIB+bbN0=;
        b=X5odA1UmCRZL7hHupEt5NqQpAvpdNYgmVz+tJIijccI+i10axXehKG3yahK0I0Un0k
         yDNzXsHxAH4FZFsdU73ZvREJ2wkQn1CCFP1pV4GS/6Su/Hc5NZoURjkjt7FsyNfiiDJ8
         Z7Xxx4vJe2gvBO6wiUWLYTLmxpPQ5T97eONVXIsL3ziylwrC9oG3pKRQpCKgHQmrB0Rx
         6g7Wvs0vHChJ/5hu4cc/0I5OvjTUdPygo6I2LbtaWO3LYKMVdtK8tgjAl0cTgUD8nZEj
         P1I3grOEiOerEAfMwzX9h/OjqCoSh7BMpqVByZtCDXKES4NutINXes1iiSbCfRKm5j37
         4LVg==
X-Gm-Message-State: AOJu0YwAZI0nVGRdW0AzGKzJIkO/346YgLd0GsXUarxAoS7olFpRQNUi
	qmq7OGWOwPuYhS9s6qWpPZsqZHDoIBI8ZQOhf5FBphq762A=
X-Google-Smtp-Source: AGHT+IHOoYBpGqBAKmhevOvTOhyr4vge/09Bn4hEDFcElu9D7XLwnRhdQygWNq8N2OumlkocMnF8U70q8MFuqSJQCBY=
X-Received: by 2002:a5d:6801:0:b0:336:6e12:7c62 with SMTP id
 w1-20020a5d6801000000b003366e127c62mr1482788wru.110.1703036065419; Tue, 19
 Dec 2023 17:34:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 19 Dec 2023 17:34:13 -0800
Message-ID: <CAADnVQ+vEstw90A-Urt-SgrdNNhuXO_VmWuojOJ=3zKReFWY2g@mail.gmail.com>
Subject: [bug] splat in perf event
To: bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

after rebasing bpf-next to the latest net-next.
I consistently see the following while running
test_progs -t attach_probe/manual-default

[   28.638654] WARNING: CPU: 1 PID: 2135 at kernel/events/core.c:1950
__do_sys_perf_event_open+0x14e0/0x15b0
[   28.639329] Modules linked in: bpf_testmod(O)
[   28.639632] CPU: 1 PID: 2135 Comm: test_progs Tainted: G
O       6.7.0-rc5-01520-gc337f237291b #5281
[   28.640299] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
[   28.641062] RIP: 0010:__do_sys_perf_event_open+0x14e0/0x15b0
[   28.647751] Call Trace:
[   28.647919]  <TASK>
[   28.648082]  ? __warn+0xa1/0x1f0
[   28.648311]  ? __do_sys_perf_event_open+0x14e0/0x15b0
[   28.648641]  ? report_bug+0x1fa/0x230
[   28.648902]  ? handle_bug+0x3c/0x70
[   28.649164]  ? exc_invalid_op+0x17/0x40
[   28.649416]  ? asm_exc_invalid_op+0x1a/0x20
[   28.649699]  ? entry_SYSCALL_64_after_hwframe+0x46/0x4e
[   28.650062]  ? __do_sys_perf_event_open+0x14e0/0x15b0
[   28.650406]  ? perf_event_set_output+0x2a0/0x2a0
[   28.650727]  ? __audit_syscall_entry+0x4f/0x200
[   28.651063]  do_syscall_64+0x2f/0xa0
[   28.651306]  entry_SYSCALL_64_after_hwframe+0x46/0x4e
[   28.651635] RIP: 0033:0x7fc0846f752d
[   28.656060]  </TASK>
[   28.656219] irq event stamp: 413681
[   28.656461] hardirqs last  enabled at (413689):
[<ffffffff81193e67>] console_unlock+0x137/0x140
[   28.657083] hardirqs last disabled at (413698):
[<ffffffff81193e4c>] console_unlock+0x11c/0x140
[   28.657663] softirqs last  enabled at (413368):
[<ffffffff810c0e89>] irq_exit_rcu+0x99/0xf0
[   28.658215] softirqs last disabled at (413351):
[<ffffffff810c0e89>] irq_exit_rcu+0x99/0xf0

Line 1950 is
        for_each_sibling_event(sibling, group_leader) {
                if (__perf_event_read_size(sibling->attr.read_format,
                                           group_leader->nr_siblings +
1) > 16*1024)
                        return false;
        }


Probably a known issue?

