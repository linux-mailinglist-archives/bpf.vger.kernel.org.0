Return-Path: <bpf+bounces-7199-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D057732D6
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 00:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C73A21C20BFA
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 22:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593DD17AAC;
	Mon,  7 Aug 2023 22:12:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3915E13AE6
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 22:12:20 +0000 (UTC)
Received: from mail-ot1-x347.google.com (mail-ot1-x347.google.com [IPv6:2607:f8b0:4864:20::347])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F472697
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 15:11:48 -0700 (PDT)
Received: by mail-ot1-x347.google.com with SMTP id 46e09a7af769-6bc7b12ee26so9026553a34.0
        for <bpf@vger.kernel.org>; Mon, 07 Aug 2023 15:11:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691446186; x=1692050986;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IbpbMWxtwQHfKpcdmTM26gLkMYaV2V50D6axm5j5Juw=;
        b=ci62T9wj10OhINm+J6xKGWpUMlNo9l5Hn0si3N+bpky8uGV2TaLXuzA3bkqxzQkVJo
         G88cN9KakVvHwQSXeLBYx29iRePVHrSXRpS9LBeK+A9zgQGesejHeg6ce0lW0UPGpwHl
         fXi4aCzKh0I8xKKRDco7oID8anHmkMaLEw3SbstHDOjnrNIJLh6PWT5qmpVOMY3PrcqA
         oa4kiK5HBWLMqES2R7YgyU1vr2Pw6Qry/XZIdPR6SV79jJTrdDccNhRHof+BG1wafZcZ
         0ZQmeUfPwmQ+n+Sm7OmtpE4iUIbXV7dQm2mOfaP02/sYCG2YkD+e5RnuqL1s3VWbKHLv
         4gJw==
X-Gm-Message-State: AOJu0YyAuA03vOzLFfF13Q6yWfyOlZBcLy2V11yzB/0E6xnD9maZ8Zdh
	UeGeUGeZVP/JJnElZyILnRhcIaMSPKXlsrfhFRiala6b2VNF6/o=
X-Google-Smtp-Source: AGHT+IEduFwtdxrh+dLlyzbh5NbikP80BVHQF2BeYV5I9pFjtdMLw1auLZ7MNsAr6GJ8o7Xm4UJOf0qu7vj4mp34E3NWMDrQCIWQ
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6830:148c:b0:6b8:c631:5c5a with SMTP id
 s12-20020a056830148c00b006b8c6315c5amr12630266otq.4.1691446186238; Mon, 07
 Aug 2023 15:09:46 -0700 (PDT)
Date: Mon, 07 Aug 2023 15:09:46 -0700
In-Reply-To: <0000000000000e4cc105ff68937b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000166f9e06025c8139@google.com>
Subject: Re: [syzbot] [modules?] KASAN: invalid-access Read in init_module_from_file
From: syzbot <syzbot+e3705186451a87fd93b8@syzkaller.appspotmail.com>
To: bpf@vger.kernel.org, chris@chrisdown.name, linan122@huawei.com, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	llvm@lists.linux.dev, mcgrof@kernel.org, nathan@kernel.org, 
	ndesaulniers@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot suspects this issue was fixed by commit:

commit 125bfc7cd750e68c99f1d446e2c22abea08c237f
Author: Li Nan <linan122@huawei.com>
Date:   Fri Jun 9 09:43:20 2023 +0000

    md/raid10: fix the condition to call bio_end_io_acct()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15c26ba9a80000
start commit:   a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5e1158c5b2f83bb
dashboard link: https://syzkaller.appspot.com/bug?extid=e3705186451a87fd93b8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12518548a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=124ccf70a80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: md/raid10: fix the condition to call bio_end_io_acct()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

