Return-Path: <bpf+bounces-30142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E286D8CB31D
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 19:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E184282B11
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 17:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A971487D4;
	Tue, 21 May 2024 17:55:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5732142E60
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 17:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716314105; cv=none; b=irUNIzoQa5pUgbeYOUcmICUJpO/7BkiJc1nLlbkaUK8STOV3Ybn4l+zTiwp6F1C4w6FnbbAj9EGwtKRpGXtaHwlhj4ODh/Wf7nAy4QGEMjYy5W9By2PERAyQJThK+K8UmAAFq9T6a3Sq9MzK9Ms2RrK5dFL80ULTU8gEC9copYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716314105; c=relaxed/simple;
	bh=zoIdtgb34NADuLjc3tV+N7aGplUZrQnoZrFXqAvUrMw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YE4pJYQ0cRDQ6/zpeRvXoFKkSAtqb3q61Lxkcg1k1bWZDV9t1LBxzIFNGlzHGunVF45W3VXQLU1xqWKui71ek4hDjN3XCMgtyJ/qmHPT2FrJmM9qt531q3BHmQ/qPOtGGmbQJ5xVwHf0XUeexWGC+B71vTMP2RtLxJ+uksC0O1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7da52a99cbdso1466304839f.1
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 10:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716314103; x=1716918903;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pWWQLx0u45d0F/7cndUkioBv+DcKIil18vzCB0kWDY0=;
        b=i+hMROqhKM1ym+fakQl73Cjulcafh2yxhCcRDNRI+/oR7k4IHetL91t6QtoO0/GGdL
         tEPavNfBTwfIp2rtCA/zHvWAE4SXsU+q8Gb+qoGWrTMVXTfV43/65iKVwq/MhulMmH2C
         Ifu2oQdLbkzte9zDydY06mTxEKBf86OcO8ETg43OQyZyfK3UBUzUv+eRK69yZlS/xEGF
         CH6dxm67l9IxQ0tzlTdrVaetwJeFC96rrXCoafik5Y3bpcfOAlWJIbPcfwbIdass56iL
         A5m1weeqiao1COR7vPYm/zEqapTqtns/pQggjKZ5v/gsXyk4smkVhfUjpIKrRwA2nDi4
         bwNw==
X-Forwarded-Encrypted: i=1; AJvYcCV348a0uPmPix3IMRMvE5S+RE8XFFmu3FiowN1rPPN5pIPC7n/BYbMMUK2HYtD3LtGwULF8Z6PxwRrPKbgOnFHl4Zej
X-Gm-Message-State: AOJu0YwoW47ihMRtQAN2fWKwMGc3iX8+4AY1rSneRmPuZN+DIwTq5otz
	1ufOKUy2aQjBeTqyblGHz3RbwMmv4UBKs7AJZf0ykVwys0u6FRLd3FpQRxVABXExr5ZBj3bZS4K
	vUbIeZUTphe8roll7Vx6G0vxN4HRwTH9wyKjc0itDYoBnN1/NhZwQWBw=
X-Google-Smtp-Source: AGHT+IG8Ql4z9HzJhkI0jOEQuDwYKu1tx4wtIVtXYjZPGYlAVV52rq2rg+5tujQGh1Dx5VbozJX4mR6bvWCsHCXQtZv6kZaztANH
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8725:b0:488:5e26:ffb5 with SMTP id
 8926c6da1cb9f-48958694bafmr2302849173.2.1716314102929; Tue, 21 May 2024
 10:55:02 -0700 (PDT)
Date: Tue, 21 May 2024 10:55:02 -0700
In-Reply-To: <87o78zxgvq.fsf@cloudflare.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006dab5b0618fa8405@google.com>
Subject: Re: [syzbot] [net?] [bpf?] possible deadlock in sock_hash_delete_elem (2)
From: syzbot <syzbot+ec941d6e24f633a59172@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, xrivendell7@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/main: failed to run ["git" "fetch" "--force" "9bf55af7188d6db60300eb8cc78d9b6572cad83d" "main"]: exit status 128
fatal: couldn't find remote ref main



Tested on:

commit:         [unknown 
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git main
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d14c12b661fb43
dashboard link: https://syzkaller.appspot.com/bug?extid=ec941d6e24f633a59172
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1136a5cc980000


