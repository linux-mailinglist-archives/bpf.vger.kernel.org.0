Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BB068DC13
	for <lists+bpf@lfdr.de>; Tue,  7 Feb 2023 15:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjBGOuZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Feb 2023 09:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjBGOuY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Feb 2023 09:50:24 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11F61BD3
        for <bpf@vger.kernel.org>; Tue,  7 Feb 2023 06:50:22 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id d2-20020a056e021c4200b00313bdffad9aso5122237ilg.1
        for <bpf@vger.kernel.org>; Tue, 07 Feb 2023 06:50:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T3BVpFeHZ4lGXaf3B9wqQOSFxEjUFqOh7/UypgMatbI=;
        b=2xSHcWW06PnpLUJhRL/sGCWdLXIdIqxhQ478SWKLUw28WJVlKo7pVGSOkZEMq/CvOn
         NhN+LfrlBUxlQntOg5vH7xxoEDMfdfmuO4hJTXxc5HFJ+VBZi9M/KxYVY61yJBpXFfbL
         1mMvNW5B6Xi/B7R6yW2ClOVC3hawAwixy4+5yZI/Ch0nJ1vncoFLPiFVlzxwdEMWVyYl
         lke901FQ8S0jq4/CP+d+Ga+nzdbHFv04JH2nSaawGYUay0FvJ8Up57jlgwQ/tCPk1FQB
         UeNe4RcnCV/Yzf8tsLk3nP2mYwgTQCBYwje3RHAyRWGb3u8Tx408v5AgeBfRHAhEmQYV
         Mt/Q==
X-Gm-Message-State: AO0yUKWWPFc26gD1VYnw/cjNSAPrO2Co8mtnmVgjVBSdcZNZv45a+FWu
        NjqIFVm1kKxKNDX0GN9OiVDGC3lfBDgIuGglkpC7SkETwbVE
X-Google-Smtp-Source: AK7set8pvWEhKgCAbGbH6gZM/EsmYg8BlGseGJ+RzL9CS0ajuddu+7+EUE4zu40NEaK6+tsBcKGO2IvIgNwqkmaLOCbuRIkcNeWA
MIME-Version: 1.0
X-Received: by 2002:a02:8815:0:b0:3be:9943:54f5 with SMTP id
 r21-20020a028815000000b003be994354f5mr2385849jai.84.1675781422218; Tue, 07
 Feb 2023 06:50:22 -0800 (PST)
Date:   Tue, 07 Feb 2023 06:50:22 -0800
In-Reply-To: <3151684.1675779419@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000064832d05f41d44e4@google.com>
Subject: Re: [syzbot] kernel BUG in process_one_work
From:   syzbot <syzbot+c0998868487c1f7e05e5@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        bpf@vger.kernel.org, davem@davemloft.net, dhowells@redhat.com,
        edumazet@google.com, hch@lst.de, jhubbard@nvidia.com,
        kuba@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        netdev@vger.kernel.org, npiggin@gmail.com, pabeni@redhat.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        will@kernel.org
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

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c0998868487c1f7e05e5@syzkaller.appspotmail.com

Tested on:

commit:         fab9eebf iov_iter: Kill ITER_PIPE
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/ iov-fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=1529647b480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=facc234423e66dc6
dashboard link: https://syzkaller.appspot.com/bug?extid=c0998868487c1f7e05e5
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
