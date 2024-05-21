Return-Path: <bpf+bounces-30162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E7B8CB4F7
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 22:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94D11285756
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 20:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1338F149C7C;
	Tue, 21 May 2024 20:55:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACD614901B
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 20:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716324907; cv=none; b=k7pOrqtddEm4A6rgSH6uixltABbRoUVtMX4bf2WTguueAceo4Mduwz3UYg6g9KIHaJgXmcOh92o1WNGqv/DC9N2KZoGj2D1Z8j0Tntqyieh0VIiXiTnn4fckiKa6oHzaZq7zH8KFD6I7ZWnvJBR0Ot1i/mYmK1Mzo5oVc9GZbA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716324907; c=relaxed/simple;
	bh=R3fCvTgotTxLXsi65QkeFqLB7siU1DAP4itw793zAbc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GW6aGodPCVvNLKMPvRE3N563Gu/Vm5J35ripVldID903+PTKEUB9Vtn37/PQbUngiVJpOMRgCSOfkiIZ187gBGDNEMeUNIPSNSnC7IFHcA+bToBNpPm45IurJkH7NaTib9ywhHUE7OCwdJdzEr77sLwiTQXKR47sxmdD7ZEZICU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36c96503424so685665ab.2
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 13:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716324905; x=1716929705;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oEiS+NAbk5RMjDOg7D+8NkoQTQW7Txc26tuIznMSR5s=;
        b=nTRd/qlGFqVs7OJE7QGbXVpJ5GAkIBJC7IiLoWbS2re3ADmNGGjP7riug41u+uShpd
         19BzFBMlEphBH+8Iv0if1geHT5GPsHufLpMYRI1K82Ck/6Tz/R1qD2PBk20lMJy6Ydzz
         7MngCK4c0HNvkKIgFpIIu/2atl16p/qhWofU1VA9B2ZgF5TkID35LeEo437Tu4S1MHCU
         Js3VWrbffP77pEcvVl5FYaW468IxyMK7xEkQ/d5q7hAErCLLPUVXJ/hSie9UQoTA27SD
         OQcKJ45oCu/vpwLpM8+naSEk8KjLlhwLroy7lnXlVELUqRLKBtw7oFL3wflz9xn3VGMz
         o0fA==
X-Forwarded-Encrypted: i=1; AJvYcCWoH9Fr/jTP0gITXK0TFitHBsLk12TxiqVLZQ8VzMkXgRh4CEJbQvqUsFnlYEv/k/yXpYB5Urjkt5cSlWDsod0/GE/h
X-Gm-Message-State: AOJu0Yx+tfnX6zGz0+QcjdlJecz+Tash37eb2awqy52SgEjGzLtPtKcD
	o1EwmyOQi+f9nWT7+BYEdVFYi34sZWhlAYKqhn9KYuLIkPbh9B+ljKaNwvNY2p7zTLqUVUQPLIc
	JMcxlfrx3Kx/PMY1DOeCpzVwWis0xHNQOZedowwl37nGGOEIDtk/rtkg=
X-Google-Smtp-Source: AGHT+IF7myKplMlP2iRDvN1xabnHS0FA63h1KOBMghTZeFYqaElRBXr7o65M7k9nw8WSfPfwjJ6wDj86smTt4N+eBmVJhPMRD2fe
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20eb:b0:36b:f8:e87e with SMTP id
 e9e14a558f8ab-371f6e0e1d4mr205215ab.1.1716324905771; Tue, 21 May 2024
 13:55:05 -0700 (PDT)
Date: Tue, 21 May 2024 13:55:05 -0700
In-Reply-To: <87jzjnxaqf.fsf@cloudflare.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000053f7c10618fd0878@google.com>
Subject: Re: [syzbot] [net?] [bpf?] possible deadlock in sock_hash_delete_elem (2)
From: syzbot <syzbot+ec941d6e24f633a59172@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, xrivendell7@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+ec941d6e24f633a59172@syzkaller.appspotmail.com

Tested on:

commit:         8d00547e MAINTAINERS: Add myself as reviewer of ARM64 ..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=133dc97c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=17ffd15f654c98ba
dashboard link: https://syzkaller.appspot.com/bug?extid=ec941d6e24f633a59172
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11caabe0980000

Note: testing is done by a robot and is best-effort only.

