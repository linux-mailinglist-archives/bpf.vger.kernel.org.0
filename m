Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE39C651385
	for <lists+bpf@lfdr.de>; Mon, 19 Dec 2022 20:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbiLST40 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Dec 2022 14:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbiLST4R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Dec 2022 14:56:17 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AF613F4C
        for <bpf@vger.kernel.org>; Mon, 19 Dec 2022 11:56:17 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id b77-20020a6bb250000000b006e4ec8b2364so4567278iof.20
        for <bpf@vger.kernel.org>; Mon, 19 Dec 2022 11:56:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cj5G7w7wrnXTjWG4Lf9C2ODteMMiP5v7wAraEGH3U0k=;
        b=yRJ4EHVpLWg8F8l/kt9rhpv6JpZJsW08HxZc8P2dWDz4Z64q3mnq4W5XYsiUbehXB2
         p76Q+uuwusT0+yDiOM4N2jUbnVXzUgg+4I94oO/+SZ4OpR4HiO0PQbvvpaXHzYwbdDIF
         TerTk2iWB8OsNthYV9bEEZdlzgXoR3zj2EgGR99AhXZhIQ4tyIY/rj+7yataNH6JdhLa
         sJBiw/lmprrSll1eAKsenQxxuFCXIiBnG96H5T/o4eHDDR/YzDUjywJo3IJg1r8PDBjN
         qVNQXgNNkhwyw+uMG6/fiaQvhn7sTMHhK6tLZxAyRanm1pb9UwvtAyZ0wif+m47ADT2E
         vQSw==
X-Gm-Message-State: ANoB5pk4bNFLsXV6+d3jL9ow3RhHVfeIMCFUCyMJtmHXuuy+ma4GOhex
        GyFjgKXLDvMHRTxT3P5TdCNkl63S3pAfTsN52jB73n3GBtoa
X-Google-Smtp-Source: AA0mqf7eE0GC/Cb+W5QzJIxt46Tbcb3KvugY9SCOhpmm/M5g7dQmZkOk8OKjjh9bxyYHJeuaULjQLcDPviCk4OX2G41hWkxQ25I2
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13c1:b0:303:7f25:72c with SMTP id
 v1-20020a056e0213c100b003037f25072cmr7289815ilj.221.1671479776357; Mon, 19
 Dec 2022 11:56:16 -0800 (PST)
Date:   Mon, 19 Dec 2022 11:56:16 -0800
In-Reply-To: <Y6C8iQGENUk/XY/A@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000051b79a05f033b6e5@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in put_pmu_ctx
From:   syzbot <syzbot+b8e8c01c8ade4fe6e48f@syzkaller.appspotmail.com>
To:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        bpf@vger.kernel.org, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
        netdev@vger.kernel.org, peterz@infradead.org, sdf@google.com,
        syzkaller-bugs@googlegroups.com
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

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file kernel/events/core.c
patch: **** unexpected end of file in patch



Tested on:

commit:         13e3c779 Merge tag 'for-netdev' of https://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
dashboard link: https://syzkaller.appspot.com/bug?extid=b8e8c01c8ade4fe6e48f
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15861a9f880000

