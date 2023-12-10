Return-Path: <bpf+bounces-17344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A415380BC58
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 18:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 470331F20F75
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 17:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988CE18B1A;
	Sun, 10 Dec 2023 17:31:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67962FD
	for <bpf@vger.kernel.org>; Sun, 10 Dec 2023 09:31:07 -0800 (PST)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1faa81282d1so8010920fac.3
        for <bpf@vger.kernel.org>; Sun, 10 Dec 2023 09:31:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702229466; x=1702834266;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=48caGdxEgGoMogiZb+MQIv4KaPHTLZZi09kYsBIRD2s=;
        b=KKGLSLoQLUIySP+MreuQaJxmHgaWC5UKgX499XquZH/Xm2rEnatY6zTf+AvU0DnZTk
         7nhQWvZCnREGXPZtkqoDcXHDCwOUuaiPh07fLZ0bz4w7nfPDYZo3goT4T7T5F6uuam4Z
         +AlZv1iLB6MR4wGTBevc5d0b+LUJI2pHg/zDiMIRDmOzKAYTcfVepz6HsvuVMMsKaVnr
         adkglvXjHLaB93v5nrqHHV85fDLstw9jHpPo3qVNdfLCKYo2WkDZ2522yIQKA0vqjXiL
         HspCKOaVvfhfblHN0PvE7bz9wNjGDTP1/BTglokji0EsnsWqgpb4OOGJ06dhxr7FzhgE
         anWA==
X-Gm-Message-State: AOJu0YzKAlKmpVcDcEsaTw0SyqCw5upUlnmoO6/L3+RxD38aHRPJE2HT
	goRd6irigzugZVPF+OiesjXulODm/0+N3Vz7xMzgbQou+1F6
X-Google-Smtp-Source: AGHT+IFzTYha5Fy7rkEwGm2gSLPN3+3yoF0+BLJOPHJJftO639+rO7O+NY4c6tbHIqbrQB+ry6rRb61J9KzKdM6RMhM+TOk3AvY1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6871:5b16:b0:1fb:1a88:a05b with SMTP id
 op22-20020a0568715b1600b001fb1a88a05bmr3340614oac.8.1702229466736; Sun, 10
 Dec 2023 09:31:06 -0800 (PST)
Date: Sun, 10 Dec 2023 09:31:06 -0800
In-Reply-To: <CAEf4BzbRzb0B-Wy-fZ05bUHn5UXXoiL5yO2yP_CKyciCFf9yWA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b0ef46060c2b2e04@google.com>
Subject: Re: [syzbot] [bpf?] WARNING in __mark_chain_precision (3)
From: syzbot <syzbot+4d6330e14407721955eb@syzkaller.appspotmail.com>
To: andrii.nakryiko@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Level: **

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+4d6330e14407721955eb@syzkaller.appspotmail.com

Tested on:

commit:         482d548d bpf: handle fake register spill to stack with..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16064fcae80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8715b6ede5c4b90
dashboard link: https://syzkaller.appspot.com/bug?extid=4d6330e14407721955eb
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

