Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6B16D44F2
	for <lists+bpf@lfdr.de>; Mon,  3 Apr 2023 14:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjDCMx6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Apr 2023 08:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbjDCMx5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Apr 2023 08:53:57 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A002910A8E;
        Mon,  3 Apr 2023 05:53:54 -0700 (PDT)
Received: from dggpemm500013.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PqrN45NjmznZyj;
        Mon,  3 Apr 2023 20:50:28 +0800 (CST)
Received: from [10.67.108.67] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 3 Apr
 2023 20:53:51 +0800
Message-ID: <7029502b-f048-88f8-5c6a-f3bc397b979c@huawei.com>
Date:   Mon, 3 Apr 2023 20:53:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Content-Language: en-US
From:   Chen Zhongjin <chenzhongjin@huawei.com>
Subject: Syzkaller reported fail of bpf_trampoline_unlink_prog
CC:     Xu Kuohai <xukuohai@huawei.com>,
        Zhangjinhao <zhangjinhao2@huawei.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>
To:     bpf <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Syzkaller reported follow WARNING:

WARNING: CPU: 0 PID: 17072 at bpf_tracing_link_release+0x88/0x90
Modules linked in:
CPU: 0 PID: 17072 Comm: syz-executor.1
RIP: 0010:bpf_tracing_link_release+0x88/0x90
Call Trace:
  bpf_link_free+0x98/0xe0
  bpf_link_put+0xd9/0xf0
  bpf_link_release+0x26/0x30
  __fput+0x219/0x560
  task_work_run+0xbb/0x120
  exit_to_user_mode_prepare+0x12f/0x140
  syscall_exit_to_user_mode+0x23/0x80
  entry_SYSCALL_64_after_hwframe+0x61/0xc6

This is simply caused by fault injection which makes memory allocation fail in
bpf_trampoline_unlink_prog->bpf_trampoline_update
Then bpf_trampoline_unlink_prog returns error and triggers WARN_ON in bpf_tracing_link_relaese.

At first I though it is a false positive report as bpf_trampoline_unlink_prog says
it should never fail. But actually it is possible.
When the bpf_trampoline_update is added at first, there is a "half page" optimization
to promise there is no memory allocation in the unlink path
But 88fd9e5352fe ("bpf: Refactor trampoline update code") added bpf_trampoline_get_progs,
which broke this.
Then the "half page" part was also removed in e21aa341785c ("bpf: Fix fexit trampoline.").
Besides, as I know the relied ftrace interface is not promised to success as well.

In bpf_trampoline_link_prog it will handle these error, but unlink_prog
just reports the warning once and continue to put tr_link->trampoline and link->prog.
Sorry for that I have not fully tested this but I guess this could cause some bad
consequence such as memory leak or null pointer reference.

Anyway, now the interface to detach bpf link is not 100% safe, and because of
the complex logic in bpf_trampoline_update, I think this can't be avoided.
Because now these release ops return void, we cannot just simply keep these resources
and have another try.

I just want to know does anyone has plan or advice to handle these error scenarios gracefully?

Thanks for your help!

Best,
Chen

