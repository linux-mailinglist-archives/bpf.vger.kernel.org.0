Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBCE67DE5D
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 08:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjA0HRA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 02:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjA0HQ7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 02:16:59 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9792B3B0F7
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 23:16:57 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id y19so4586673ljq.7
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 23:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p/1HaY6cthK1vQQ48tCz0Z/+F1RdeA2eZsyA0pu5Rrc=;
        b=nFBHWnctzE4RyFTDzOxVL54T35H3g46h2doiDo3860Sx3bKgVnAdN/Vmhu5MQSD/Lw
         JA+JLP7qGA64en8ZA0ln4KTkaf/holt3FY+JQN1jW0Kr7FE+GLUiDWztLXi61qOmTwkf
         PqzHyh+GzBYsElh1ixRhekZ4u6Ro9ZdmFIbBcM7053JiwdAg3SttwZLyDoycSJbJ6viR
         CO/liJ5g1m4wPbFeNqzW9ydeUZKzPfVvJwrwJacU6VQpIaQdP/iBCleBzeIP66vMD/li
         ZB2PlmRJaj3VwlGsFSOi+uMiN/bA+KvZMyFCBjlwtzuj5AeqvildrafUdj+jBLWa9l4M
         ARjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p/1HaY6cthK1vQQ48tCz0Z/+F1RdeA2eZsyA0pu5Rrc=;
        b=UNbrYl3/Zr5aU8LLNBaCDnl1E9WMwMr0JlRf7vAE0KzfibQCQcVBdoUQ7KP0x/AbLy
         O4m7LazGNthnHHtcMtL36gIgHg05OZ2wheU6ux6LDibTb9mMj7m9JlJnsxnMpNai9Wf0
         Q3Ceo2v+TBWre3rleGoDQFwpcgqigF7huQiFKp+l5tUlV07/9qgSHXPz6JXTYv50UtIq
         RAJMRVy+h8uhqbj5rxP8JCwjKbnv1Yj0obp/dAa+eL6X9jnxW+SvBaiGZYwZzdf934iH
         bAgKvr90vfmZdI8oCw+gJPAQBF3SdY8DFQHZpyqH/dDhWnM9wEFi+G2hPdvGE6ZpF4+V
         xzLw==
X-Gm-Message-State: AFqh2krZYg+wXiRLp8Odd1bwCm+Sg5ohpgq44RVLK8M0NNEhix9iKZwg
        xQLxXTt2bU2ez9SOxDZNBDBNCwx5jlfopBELqScAcg==
X-Google-Smtp-Source: AMrXdXsp0qRLnIaaj18tnlZo9mCkg2IA+9EPeg4iLvNYFx/K3CSzQIuclZtKc0LZHaoKpokZIRVR64gJvSLWhx39Qos=
X-Received: by 2002:a05:651c:10ad:b0:28b:7a60:946d with SMTP id
 k13-20020a05651c10ad00b0028b7a60946dmr3525897ljn.233.1674803815662; Thu, 26
 Jan 2023 23:16:55 -0800 (PST)
MIME-Version: 1.0
References: <0000000000005d4f3205b9ab95f4@google.com> <000000000000ea5ad205f31852e8@google.com>
In-Reply-To: <000000000000ea5ad205f31852e8@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 27 Jan 2023 08:16:42 +0100
Message-ID: <CACT4Y+b_JkNCPOgx=xdUNTZqwwmoaxOSC9obsZnuPa3rZnWKag@mail.gmail.com>
Subject: Re: [syzbot] WARNING in pskb_expand_head
To:     syzbot <syzbot+a1c17e56a8a62294c714@syzkaller.appspotmail.com>
Cc:     alexanderduyck@fb.com, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        edumazet@google.com, hawk@kernel.org, john.fastabend@gmail.com,
        kafai@fb.com, kpsingh@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, mst@redhat.com,
        netdev@vger.kernel.org, pabeni@redhat.com, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, willemb@google.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 25 Jan 2023 at 16:31, syzbot
<syzbot+a1c17e56a8a62294c714@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit dbae2b062824fc2d35ae2d5df2f500626c758e80
> Author: Paolo Abeni <pabeni@redhat.com>
> Date:   Wed Sep 28 08:43:09 2022 +0000
>
>     net: skb: introduce and use a single page frag cache
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16a58035480000
> start commit:   bf682942cd26 Merge tag 'scsi-fixes' of git://git.kernel.or..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b68d4454cd7c7d91
> dashboard link: https://syzkaller.appspot.com/bug?extid=a1c17e56a8a62294c714
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b18438880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=120c9038880000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: net: skb: introduce and use a single page frag cache
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Looks reasonable. Let's close the bug report:

#syz fix: net: skb: introduce and use a single page frag cache
