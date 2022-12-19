Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE9C6514F6
	for <lists+bpf@lfdr.de>; Mon, 19 Dec 2022 22:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbiLSVdl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Dec 2022 16:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbiLSVdk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Dec 2022 16:33:40 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37B1F029
        for <bpf@vger.kernel.org>; Mon, 19 Dec 2022 13:33:38 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id k21-20020aa78215000000b00575ab46ca2cso5670702pfi.20
        for <bpf@vger.kernel.org>; Mon, 19 Dec 2022 13:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bpSyaw7IzzUwQ80GRIZq630SjWs043p2tlSn9Ge42Ig=;
        b=DhKrhwDhNxRtLQ4hD30ALjUurCc9f4RCZdls/fWZbnDkFGV2oPx4TdKcSwMlQzk3ie
         A7I9+3NMTLXU8+212DBa1vNyer4MFCX0jZTcRyy4J+tyFISFRojS0FyvlGug4OkYuC9A
         1+UZjithsMA150YT1fPGa9QahyU5h+XnRdZeLNEbw87WRYSBko7IVmUVxr/Oy2p5gWjh
         qovD/lWHY8atDnwTtnZ7FzcssbP2IOIZ9n0RpJ/lJOC6nLG80TULDg5f6WO7KUsw2fBT
         oGRQ7fxsCGKxCHrH13F1IIhB1x/ijKqOPM+WUJYfD7kTXGImxHm0vEQzdJYHUI0WPaqH
         j8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bpSyaw7IzzUwQ80GRIZq630SjWs043p2tlSn9Ge42Ig=;
        b=maiyPcG34oHteFl6z47NaIoTpszmPkY9tGT/TYbiI2N4YivLrKG7fK5Tdadaa1Pdn0
         6mdaUXY5qlA5He3X2/AnSKD3NKY1F0WVqqLePxY/lQaNhoosDWVqvoWkykYw+02qgIyI
         iFBlh9xLI/zMRIj23SveplHMxMQRn8Y8ui+N6ctnCK6G/g4qwo4FkZFoFy0y1QMjNMN4
         7le/laiRSabIANvuLiMxuR/OmB845PQDsBmD0QKQIkoVty0jD7Prok6W0hU15NkVZbiY
         u7XDyjgMQZg2TTp2aIPo6DQrfXM4Hwm8z4SuRYYXFhS831WbJaot2tJAM/W275aCypiE
         YocQ==
X-Gm-Message-State: ANoB5pnFLYlXPSRlJwrrqKQx50S62fBjOCm98v/nsLJINnaxcbBvgvri
        tglYMrp1v1wlDoMkcg8X/ix0s8k=
X-Google-Smtp-Source: AA0mqf6b+8RXnM1FmTTmyMFRRumZB4F9hR7A5n1+1yLtRhrbiaNTaN+QV0AdHzB523/1wMCm59zoDpc=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:aa7:85cb:0:b0:575:871f:2e7a with SMTP id
 z11-20020aa785cb000000b00575871f2e7amr5047278pfn.35.1671485618298; Mon, 19
 Dec 2022 13:33:38 -0800 (PST)
Date:   Mon, 19 Dec 2022 13:33:36 -0800
In-Reply-To: <00000000000051b79a05f033b6e5@google.com>
Mime-Version: 1.0
References: <Y6C8iQGENUk/XY/A@google.com> <00000000000051b79a05f033b6e5@google.com>
Message-ID: <Y6DYsN+G3mdKP/Bb@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in put_pmu_ctx
From:   sdf@google.com
To:     syzbot <syzbot+b8e8c01c8ade4fe6e48f@syzkaller.appspotmail.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        bpf@vger.kernel.org, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
        netdev@vger.kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/19, syzbot wrote:
> Hello,

> syzbot tried to test the proposed patch but the build/boot failed:

> failed to apply patch:
> checking file kernel/events/core.c
> patch: **** unexpected end of file in patch



> Tested on:

> commit:         13e3c779 Merge tag 'for-netdev' of https://git.kernel...
> git tree:        
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
> dashboard link:  
> https://syzkaller.appspot.com/bug?extid=b8e8c01c8ade4fe6e48f
> compiler:
> patch:           
> https://syzkaller.appspot.com/x/patch.diff?x=15861a9f880000


Let's try again with hopefully a better formatted patch..

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git  
13e3c7793e2f

diff --git a/kernel/events/core.c b/kernel/events/core.c
index e47914ac8732..bbff551783e1 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12689,7 +12689,8 @@ SYSCALL_DEFINE5(perf_event_open,
  	return event_fd;

  err_context:
-	/* event->pmu_ctx freed by free_event() */
+	put_pmu_ctx(event->pmu_ctx);
+	event->pmu_ctx = NULL; /* _free_event() */
  err_locked:
  	mutex_unlock(&ctx->mutex);
  	perf_unpin_context(ctx);
