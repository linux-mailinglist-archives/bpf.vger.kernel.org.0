Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5FE61761E
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 06:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiKCF0X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 01:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiKCF0T (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 01:26:19 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C8E18B05
        for <bpf@vger.kernel.org>; Wed,  2 Nov 2022 22:26:18 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id y5-20020a056602120500b006cf628c14ddso456954iot.15
        for <bpf@vger.kernel.org>; Wed, 02 Nov 2022 22:26:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hubE5cXRc9JuQCcqWhxOGTFZ206SuvXNuCleiqfj7l0=;
        b=GPpe1r2UhXjN6Cds9dEXKBj3e3zj/baoH0GvaQBxov94biQispvpDVLq7boXE/NB06
         qYMqDQztzeibewYKAzJMJN9vFO99jpsuNiz90kIXfpLgb8ZXmnQKjNRJoMJB5Erao6Lt
         +ZC7/0sP5M4etVpFUgqgT7yZQNUxhJ8AGQdrd6HnOE5nelMDlBpn6zEW95rNeS5U7pGW
         2P3o1gEul6/lxu+O4Mw1qc6roSnKYsLn2QpJvB0ZvGHwN/DrGxzRqqjp+DOg1z0+mqRW
         bJTpTCyjQpPcGkpYD+OmF9SeePvsbOKnpfULS5eu5N7vezq71j+3D9++FUT7BKXGNMTT
         BeTA==
X-Gm-Message-State: ACrzQf35ewCrvyLsSd9yxVMgX+60YaXdP/wD3Rw5Q5RF3gH3gyz1/bbA
        3OW1KX36UMEuygqVgEP9wxcPfWlqjHu8HR+tLX0Vn6sQir9P
X-Google-Smtp-Source: AMsMyM7M+gbJ9p2WjkZ9tsLPHEN9g++/Bo3XU4yPT5uBfhfhLwrxINRWSCpGkuwwLFqDERYuy5PPDkBauLfSwc6aEbOSjHRRHa64
MIME-Version: 1.0
X-Received: by 2002:a92:cc49:0:b0:300:d9d7:fe36 with SMTP id
 t9-20020a92cc49000000b00300d9d7fe36mr860359ilq.225.1667453177891; Wed, 02 Nov
 2022 22:26:17 -0700 (PDT)
Date:   Wed, 02 Nov 2022 22:26:17 -0700
In-Reply-To: <000000000000e9df4305ec7a3fc7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005912d405ec8a329c@google.com>
Subject: Re: [syzbot] WARNING in __perf_event_overflow
From:   syzbot <syzbot+589d998651a580e6135d@syzkaller.appspotmail.com>
To:     acme@kernel.org, alex.williamson@redhat.com,
        alexander.shishkin@linux.intel.com, bpf@vger.kernel.org,
        cohuck@redhat.com, dvyukov@google.com, elver@google.com,
        jgg@ziepe.ca, jolsa@kernel.org, kevin.tian@intel.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mingo@redhat.com, namhyung@kernel.org, netdev@vger.kernel.org,
        peterz@infradead.org, shameerali.kolothum.thodi@huawei.com,
        syzkaller-bugs@googlegroups.com, yishaih@nvidia.com
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

syzbot has bisected this issue to:

commit c1d050b0d169fd60c8acef157db53bd4e3141799
Author: Yishai Hadas <yishaih@nvidia.com>
Date:   Thu Sep 8 18:34:45 2022 +0000

    vfio/mlx5: Create and destroy page tracker object

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=136eb2da880000
start commit:   88619e77b33d net: stmmac: rk3588: Allow multiple gmac cont..
git tree:       bpf
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10eeb2da880000
console output: https://syzkaller.appspot.com/x/log.txt?x=176eb2da880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a66c6c673fb555e8
dashboard link: https://syzkaller.appspot.com/bug?extid=589d998651a580e6135d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11eabcea880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10f7e632880000

Reported-by: syzbot+589d998651a580e6135d@syzkaller.appspotmail.com
Fixes: c1d050b0d169 ("vfio/mlx5: Create and destroy page tracker object")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
