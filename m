Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F6245052F
	for <lists+bpf@lfdr.de>; Mon, 15 Nov 2021 14:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhKONSM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Nov 2021 08:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbhKONSE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Nov 2021 08:18:04 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98849C061202
        for <bpf@vger.kernel.org>; Mon, 15 Nov 2021 05:14:53 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id w15so16587531ill.2
        for <bpf@vger.kernel.org>; Mon, 15 Nov 2021 05:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=//STD+Hi45tkJE/Eu99jFcYzb4/fqeBDW/5cmJOU9SE=;
        b=jEGVNa/IIpye26C/dh4uWjP+xy4+atqNnOGZfF91/aqPJWPn4O/DvbudlzsCSpKQoD
         /UIYi8pj08sqRQ1E2tfZMgbMqNC44EtLx3FMH8XNBpznZ6Q/Q4FMI6xPgp11Rys3z6e6
         1KwgucYZe8qKx/AfT4EawOu3i0u2PBmrNetORzPoKApDOaSfET6QSQfw+awWKcW2kh1S
         u2q1huwzIrU6MglJpiSQ0CUM1wOtwVgAOdBFWmag3MSTTEyJwEDKIb1DqcaI9V8zxLEh
         QRR3clsQvwQz1y/rC9tMWhKHnySZJHxz6dz2bQY+DZ5DmkJGo+YDIOg5IiftvoFdcisH
         pUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=//STD+Hi45tkJE/Eu99jFcYzb4/fqeBDW/5cmJOU9SE=;
        b=RhoqfHMpSj6dDeCQkzJjiXW80CkZVqG4KoeKinLjQ60Uk0HhOVVVtrtCELinwZTRCn
         vw+AzVvMf76xQaDRNbVcPcodFG26d6BzvstxGgrp+WYL0jM4OYfzDdmqQylJ/XJ/UVQ6
         yVFMg1tD0dhS22P/MfFaX6keRhlZlmN44KkJC9rqxO7iwyzhkMkyN8yq1iC4Uqqx9+po
         3ARe+74SrJoUZFkocBxVvLkaWqELeI4Sqq1cGLtdmyQnnl68cgvOmWgOnxcYR+HUNvt5
         kXXyZv/yYfDx/5VnWTkJX3zN70nz3yHpAZtNnWxkAJD8jVw9to6QYr/V8ca0wBvoozT3
         Lx8Q==
X-Gm-Message-State: AOAM530g2UoNLvd8bst29Vfy7tCpVpNXa4o7utQ3G4IFgtgcfxJYU2JR
        8+ixemxgPNBTlfRK9sXPnuOIOw==
X-Google-Smtp-Source: ABdhPJz+yzLzoWjlkv4bgfL18UMTUmIY5dAS+NPg7QzpDWEI8eGAXCxsbto0lNKnHYH4qbuSe6wOXQ==
X-Received: by 2002:a92:7413:: with SMTP id p19mr21348666ilc.134.1636982092859;
        Mon, 15 Nov 2021 05:14:52 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id c11sm8788401ilm.74.2021.11.15.05.14.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 05:14:52 -0800 (PST)
Subject: Re: [syzbot] INFO: task can't die in __bio_queue_enter
To:     syzbot <syzbot+7ab022485f6761927d68@syzkaller.appspotmail.com>,
        andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, john.fastabend@gmail.com, kafai@fb.com,
        kpsingh@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com
References: <00000000000007948005d0d1214b@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <10fc0905-b166-ac20-560c-68f32bcccdad@kernel.dk>
Date:   Mon, 15 Nov 2021 06:14:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <00000000000007948005d0d1214b@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/15/21 3:18 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    ad8be4fa6e81 Add linux-next specific files for 20211111
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=17026efab00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ba9c83199208e103
> dashboard link: https://syzkaller.appspot.com/bug?extid=7ab022485f6761927d68
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

#syz fix blk-mq: don't grab ->q_usage_counter in blk_mq_sched_bio_merge

-- 
Jens Axboe

