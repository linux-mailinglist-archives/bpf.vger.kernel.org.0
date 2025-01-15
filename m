Return-Path: <bpf+bounces-48925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9270EA122FC
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 12:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EE683A456B
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 11:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437A622FE0F;
	Wed, 15 Jan 2025 11:47:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCD720CCC9
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 11:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736941625; cv=none; b=FHabYwCk/ZsVurF25IfHxYweqQJ45PtZ2lRV13PWJ3nfPOzqf0KfcTkUAonbEdsV7Y8ZgmRo2HQhQXez1FeLCM4hPh45RykSwQhNk9fv0kh9Kti1N/DcamiMLHCIdyXpoOUUk/UGbSpUY1gffY733+zw593TZJ8WuKZCxoe3uUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736941625; c=relaxed/simple;
	bh=/1uFD+772lAt1hJfYVdZ7oeg/thMmcYi5G7yE5q11iU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SY15jcrr+CgvSMdoKWw3ICfnHWCH45sidewPqhlcRUx8YQGAuAi3+CUl1cAmnZHtMv95hAWY/u0ciAiUYuf7IG4JAEI98Usm6Q7xmr9UQ14t7fgyHzcy7XU2JD3x2gMToNOiQzccLE4OEs3FE70R8yAUWK67XyCvS5HEXFGWfIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-849d26dd331so63634439f.1
        for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 03:47:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736941622; x=1737546422;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7CD8/bky+uBTitY/VMmrxb7nNioNYcVEol6ONXDjRus=;
        b=qAl/k0cHo+Cj/84cesha3fiajt5pOS9XfrqePulJ3TsCdchzMU+RN9RUNxyHn16j/k
         JUImdrcD4O+OKLU9jxjn4SIijCPz1DzJthZIxFsKTKha1HzbGNnVn2dRJH3HtkyXqfo1
         DbKmobm1X1XCGuyoK1VXXWSXB6GgYg+h2JsDi2CULCXgSl2lnzkdC5EYlpo6lFsFwi/+
         +kJ+2b4QZm+lA65RBQTiDtrRjRE/uIBaHNoTKQUunophXT7LW2bsSK5YBs0htKuGG9kR
         T5z+EVMnqkimDh4GC8aJeChgXFN36B4fpe6MCpwZtkkOzgx1vh+Jgd7ny6DPI+KhcMZJ
         mcqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvvKrItr6GRf4IkN8Uco6sUTJmusMrHoSztc1KWk6nGI8Kb0ICA/kB54DdaB5avuf4dN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHHQA035fRzlEgWubldwdkizWSKltmL7L65U5nd+tWJJS2i1mv
	8mmCfuauBVhCcA4vSgVBeoMC6j4DrMjokZMs6R55DtmfpsPwwULY417SXYjIoksnjkyqX/dhT/g
	VzWZ7zHQHEhGnL0TI+76lwX+p9ZCQimzRtgnISydSOcTTA+Vg3b06bzg=
X-Google-Smtp-Source: AGHT+IESRd48rHGhudr/W5hTp4VTLrRNTk1+2Ra6errEaQt8aLT30h/PAr+bUUEcI7mPJrigCPSOnyk0dxCyxgomNR6tKHtcwEEf
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e3:b0:3ce:7cc9:9f46 with SMTP id
 e9e14a558f8ab-3ce84a25bf6mr18998895ab.9.1736941622558; Wed, 15 Jan 2025
 03:47:02 -0800 (PST)
Date: Wed, 15 Jan 2025 03:47:02 -0800
In-Reply-To: <mb61p5xmgicov.fsf@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6787a036.050a0220.20d369.0012.GAE@google.com>
Subject: Re: [syzbot] [bpf?] [trace?] WARNING: locking bug in __lock_task_sighand
From: syzbot <syzbot+97da3d7e0112d59971de@syzkaller.appspotmail.com>
To: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, martin.lau@linux.dev, 
	mathieu.desnoyers@efficios.com, mattbobrowski@google.com, mhiramat@kernel.org, 
	puranjay@kernel.org, rostedt@goodmis.org, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
lost connection to test machine



Tested on:

commit:         c547a7b6 bpf: trace: send signals asynchronously if !p..
git tree:       https://github.com/puranjaymohan/bpf.git bpf_preemt_fix
console output: https://syzkaller.appspot.com/x/log.txt?x=178257c4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aadf89e2f6db86cc
dashboard link: https://syzkaller.appspot.com/bug?extid=97da3d7e0112d59971de
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

