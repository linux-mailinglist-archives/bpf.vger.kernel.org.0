Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D00767B5F9
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 16:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236072AbjAYPbh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 10:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235873AbjAYPbW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 10:31:22 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA3259E6D
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 07:31:20 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id b26-20020a056602331a00b00704cb50e151so10835357ioz.13
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 07:31:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=udHQk+LlTsImsgasQumCY8J2ntYLpL4el7t+VlKTCIE=;
        b=lnqHRiaCRpdqmG+9Z72JBB9mNArP2YIZvYBNsK/qffJ3sk/n2jsBXTioIhji7jEo+9
         N9eURY3Z5RZjWONZkiBZnw437k5YFQdUudbDvBO2Mn9jAH98a2X04te0T+oklz3TaI+g
         Y6RH7Ns9fh3i+zgnBS4YxvdddEvRO+yYgSwskqd9l4hJDhozyj5B8xpMIc9afeSpWaTX
         Q2ifp/zKRiiaKYA5oAD9w/IDlObluOWPFDKuejP71cXckii40MIhWFmRdpV59utTuAfM
         NMrCRUzD2+NQ94zTIAbWE68YRytIvaDN0lZY37vlahIPbj6ekpPvHxFK7AoBvUECFDsf
         qMMg==
X-Gm-Message-State: AFqh2kpJrwQNwZyNIRsGqXp9g2MZYAypte2V6Ed4YVIX1cLuaEdMzBu6
        tBv04xyzercjQr0hgfwcbZ3QN7/pepmgnHrBjyKtvMWmob6g
X-Google-Smtp-Source: AMrXdXvYuyCeKloGvGCiyTGOeSFAIYlP8RvM+qa/Pn+pUN3KSGjpHp6QfR1gEUZNgdL27egar00ZoXEcvv5hg5cc0eOGQiRY5LDo
MIME-Version: 1.0
X-Received: by 2002:a02:c88d:0:b0:3a3:2315:cb3b with SMTP id
 m13-20020a02c88d000000b003a32315cb3bmr3706135jao.206.1674660679405; Wed, 25
 Jan 2023 07:31:19 -0800 (PST)
Date:   Wed, 25 Jan 2023 07:31:19 -0800
In-Reply-To: <0000000000005d4f3205b9ab95f4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ea5ad205f31852e8@google.com>
Subject: Re: [syzbot] WARNING in pskb_expand_head
From:   syzbot <syzbot+a1c17e56a8a62294c714@syzkaller.appspotmail.com>
To:     alexanderduyck@fb.com, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        edumazet@google.com, hawk@kernel.org, john.fastabend@gmail.com,
        kafai@fb.com, kpsingh@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, mst@redhat.com,
        netdev@vger.kernel.org, pabeni@redhat.com, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, willemb@google.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit dbae2b062824fc2d35ae2d5df2f500626c758e80
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Wed Sep 28 08:43:09 2022 +0000

    net: skb: introduce and use a single page frag cache

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16a58035480000
start commit:   bf682942cd26 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=b68d4454cd7c7d91
dashboard link: https://syzkaller.appspot.com/bug?extid=a1c17e56a8a62294c714
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b18438880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=120c9038880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net: skb: introduce and use a single page frag cache

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
