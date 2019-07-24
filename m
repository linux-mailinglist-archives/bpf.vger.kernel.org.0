Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B285723CC
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2019 03:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbfGXBkC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Jul 2019 21:40:02 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:45017 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728376AbfGXBkB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Jul 2019 21:40:01 -0400
Received: by mail-io1-f72.google.com with SMTP id s9so49292596iob.11
        for <bpf@vger.kernel.org>; Tue, 23 Jul 2019 18:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=w92/D4APly1S0dijjuo/84NrUKS2JIroIh/+k83Y0Yg=;
        b=JrhO+T7fMJZhPEjwVWifI8JkIjQlisefxquxmwRX7SWUJnp6M35NaZzTaVj+9Kq/Ly
         6hxXOwmWuyylOv/jCAv77u0sIYj2pNRc92zNKlA0IAweOGwPhUw5HG5prBxnk/mg7kk+
         I4S5utxx7EyAMutJhn/xGjleca8InfuR1bYHGg9R4HArXLolMD+kcwUVUNVpzKOnj748
         48oN1O91FM0AxM7YrZKUGzsgDlbpFTJBzPUxfNFP817ygTn4fcHlipzIokRYBeD9QGIX
         9S2fu0zw4fGE+D3OlCqAnfM6lKLJV0L5H0uszIGF1zYm1On27+DgwyuBP8JiBG9ams+e
         RcZA==
X-Gm-Message-State: APjAAAX7JFw1RePJaA2F2gXCdLKnGxOWHVTbsT1i0mDqJ3IkahK8rXK+
        QAqPUfetlqH4+Z53Q+9ZIugSOiWF161sw4Cj2cm5nbY9Y6Zq
X-Google-Smtp-Source: APXvYqxZV7f2M7mWAmPB7Zk6w2/BTeh9n6/BKLJgP5HdF+ftj8Txa1VpP1wlpVLNOViX/+n9pFrEH7CBKE5ifAlRW9n+RxMquc0l
MIME-Version: 1.0
X-Received: by 2002:a05:6638:691:: with SMTP id i17mr82704018jab.70.1563932401090;
 Tue, 23 Jul 2019 18:40:01 -0700 (PDT)
Date:   Tue, 23 Jul 2019 18:40:01 -0700
In-Reply-To: <5d3744ff777cc_436d2adb6bf105c41c@john-XPS-13-9370.notmuch>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000384ae4058e636360@google.com>
Subject: Re: kernel panic: stack is corrupted in pointer
From:   syzbot <syzbot+79f5f028005a77ecb6bb@syzkaller.appspotmail.com>
To:     airlied@linux.ie, alexander.deucher@amd.com,
        amd-gfx@lists.freedesktop.org, ast@kernel.org, bpf@vger.kernel.org,
        christian.koenig@amd.com, daniel@iogearbox.net,
        david1.zhou@amd.com, dri-devel@lists.freedesktop.org,
        dvyukov@google.com, john.fastabend@gmail.com, leo.liu@amd.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+79f5f028005a77ecb6bb@syzkaller.appspotmail.com

Tested on:

commit:         decb705e libbpf: fix using uninitialized ioctl results
git tree:       bpf
kernel config:  https://syzkaller.appspot.com/x/.config?x=87305c3ca9c25c70
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Note: testing is done by a robot and is best-effort only.
