Return-Path: <bpf+bounces-31982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F63905EA7
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 00:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1FF7282A9D
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 22:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A5312C46D;
	Wed, 12 Jun 2024 22:41:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3230B55C08
	for <bpf@vger.kernel.org>; Wed, 12 Jun 2024 22:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718232086; cv=none; b=OqtmG5Mo2oIFWfKu+u8usNkGpgm41ntCJt5iaacS/DlPx3uesifc2fc0kZA/gpgJJ/iQNV/jqlyXeBZNlzhoJL4uz37yuwAjfcRa+EQjJR3ZyXW2aT7EJofGCqSTKVPgsUOjjHNB38WXO5GxXemu4TEuNI7Gw/lDRvYs24bXjnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718232086; c=relaxed/simple;
	bh=K5YyxLA11PLGZeCHK78EvOq9cPOFvcvbwQR+YdwCToQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fGFwOgBDmC+ix2O49jKZ0pYd/T3ZvPH0s0cv0u6SJlb1YLMvLDAhIEzACCItj5uR3ofPwFf8gEPg4e+EryQlsxn0La4UFG1MQRD1IIwQj4CHXBTXcubnebz7H+QiknpF5h4GVBekMmP7e2pEC1NqVW26ib99Xq5mAVu37BCwYc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7eb6fd69f7cso29958539f.2
        for <bpf@vger.kernel.org>; Wed, 12 Jun 2024 15:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718232084; x=1718836884;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mufdid0kgCdbIFQobNxZ/g3ngSfNEOwaNWumRTzbMmU=;
        b=DshLQrpfHVtDWai03KSBGeH1wH/9qOt2X5xibwxK8jRoW1z6xB1bnV5zI7hjrjMo6I
         HT/55puZPmAnZbSjFd49Un6aeQ+ojrQliEAOVqufqyHBAv9M/P8lMgHW+mHCt4+dmV4D
         c/WS5pJsJvpr8OSEUjAdzk28aoXwWxpN+cfl2vuWgYWkQZi+NsSDhk+S1mzUeqnhbgDn
         24GUmXLGTT61E/aZMCDtYIfadE0dgKbVqPqM0aM1iMq0yeyAruoypc6VNnvY9ZeZ92sN
         M+wNDr+HS1wTkzW2evI7og9DJCmx11gbvn38f67UzsQRvF98VURrxsVKRxzWY4znTDd6
         ei7Q==
X-Forwarded-Encrypted: i=1; AJvYcCX7rKCILCWlM7fXrTMYRW0pI+bRR2CPxks2K24/PZXl4LV79Ib6mvraT8S1tqa0bC0zELUPk+JCqrNGjaNZ0uIYonJy
X-Gm-Message-State: AOJu0YzvkDGqJU+ito5P6q/TtyPNPmlrnwiRmASBeGeWLHuoPgp33r+F
	DUxLq2CSXoCLDct/AD9aHyVtXPEaFRLlSt81+loiJAH6ASzjrEVXQhG/jzAtBzWai6cewkQD/cy
	TpRwF/6EYrsI3Ba6kIfW+fJY3+wq3676PddXOWvjnuKzcT2wxHuYID40=
X-Google-Smtp-Source: AGHT+IFgpLRRkr2wzJHWMlnK27XuzjJnL09Ay4Thz8yHDVR8sRNFRo/3Lm1ePX560qyFI0J/dEcZUeNph6CSKJoX53M041Ww+eiI
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:641f:b0:7eb:b36f:b4de with SMTP id
 ca18e2360f4ac-7ebcd189081mr13866939f.3.1718232084315; Wed, 12 Jun 2024
 15:41:24 -0700 (PDT)
Date: Wed, 12 Jun 2024 15:41:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000072aaa061ab9153c@google.com>
Subject: [syzbot] Monthly bpf report (Jun 2024)
From: syzbot <syzbot+list6bc05ebaf8f2eae6ce86@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bpf maintainers/developers,

This is a 31-day syzbot report for the bpf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bpf

During the period, 11 new issues were detected and 4 were fixed.
In total, 53 issues are still open and 252 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  8630    Yes   possible deadlock in task_fork_fair
                   https://syzkaller.appspot.com/bug?extid=1a93ee5d329e97cfbaff
<2>  8113    Yes   KASAN: slab-out-of-bounds Read in btf_datasec_check_meta
                   https://syzkaller.appspot.com/bug?extid=cc32304f6487ebff9b70
<3>  869     Yes   possible deadlock in sock_map_delete_elem
                   https://syzkaller.appspot.com/bug?extid=4ac2fe2b496abca8fa4b
<4>  733     Yes   WARNING in bpf_map_lookup_percpu_elem
                   https://syzkaller.appspot.com/bug?extid=dce5aae19ae4d6399986
<5>  385     Yes   possible deadlock in __bpf_ringbuf_reserve
                   https://syzkaller.appspot.com/bug?extid=850aaf14624dc0c6d366
<6>  165     Yes   KMSAN: uninit-value in ___bpf_prog_run (4)
                   https://syzkaller.appspot.com/bug?extid=853242d9c9917165d791
<7>  153     Yes   general protection fault in dev_map_enqueue (2)
                   https://syzkaller.appspot.com/bug?extid=cca39e6e84a367a7e6f6
<8>  136     Yes   possible deadlock in __queue_map_get
                   https://syzkaller.appspot.com/bug?extid=8bdfc2c53fb2b63e1871
<9>  89      Yes   WARNING in __xdp_reg_mem_model
                   https://syzkaller.appspot.com/bug?extid=f534bd500d914e34b59e
<10> 88      Yes   BUG: unable to handle kernel NULL pointer dereference in sk_msg_recvmsg
                   https://syzkaller.appspot.com/bug?extid=84f695756ed0c4bb3aba

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

