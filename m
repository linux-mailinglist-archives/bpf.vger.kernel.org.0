Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F63268F9EF
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 22:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjBHVzr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 16:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjBHVzq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 16:55:46 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B6B768B;
        Wed,  8 Feb 2023 13:55:46 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id be8so570088plb.7;
        Wed, 08 Feb 2023 13:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=59h5IHjIaUS+E55TiZEMLK19J71U+UpvxA6hhpa4vl8=;
        b=bhAx6gQPPQNrNY3su1i0gXjEpuf7bREfrZoX0LZ5DJpX47ggdzIIN+3mTKUPCAl0mM
         AJFyPRXFxqhaUzLtYrKp35sfZ/gB13jjLJGqchqlWl32pB6Kr5OtBg6ZKwwhn6EMvMKs
         +6MMpqJ3IBCKJkOCv17H9OTPP9yBCbZNwBnTsJXOy9O6AljciakmBV+9b3ykZvregFXo
         9Eb4Opf0N6pnUgx59kSH6wE2N6Oj9aI19d72MBOOYwi6Lb9ovlqpKW4h8ab/x8P1Xi/Z
         VaXefm2sAYuzznxltUiTLyQXg9y5ID1lm8mVShtYZlk+9eeL+nOKtisIs9kHs3Dy9z5W
         CqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=59h5IHjIaUS+E55TiZEMLK19J71U+UpvxA6hhpa4vl8=;
        b=bW8bzUwuXE93KosE5dOBiOUzVRo8ZNySqsOSHaaggH6UUEw28lxwVWHNDbJKrQ2Z3x
         ZoSkWmR9EgdMR5Dvv0am1jz/p2H3gTjqaW81CsemZQ9l095gV+31//e2J/Gy70e5lx0P
         ZXHoyyaDrzavKQFHsDTYQc/Mj7sFPlkiu8+oyEKDDuEimxxEexId076Graa3wnFh4xMc
         JcLJSewIl9rQ7eIVZtO5OlfXNQesbumWLBZDCOL/eQbFFKVykn6Ev22YDqqVLJJ+MgN9
         nLS0zJseI+EBRqjUXNzcH+VIN6Y91dOXQeyZ/2KX8uY4KFxFhdT6T0Vnix3qwyeRmIiF
         /9Fw==
X-Gm-Message-State: AO0yUKVGOoCGb3CRnkwuUgkNhy24+04dCZX14LeRjveXq9KW+yvzdo5W
        DObQ7cR46HkrWKX6HM+eKEx2vFMxHNI=
X-Google-Smtp-Source: AK7set8c/QjQytLCXqrl5eNts6rvnqXSQUoTZ1j5igDqtQHSvjEVbkYhDI45uXMXeZrLGvHNnJqZaw==
X-Received: by 2002:a17:90a:191e:b0:22c:19a6:1c07 with SMTP id 30-20020a17090a191e00b0022c19a61c07mr10782949pjg.16.1675893345542;
        Wed, 08 Feb 2023 13:55:45 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:b288])
        by smtp.gmail.com with ESMTPSA id a8-20020a17090a688800b00229f74a4323sm2051169pjd.34.2023.02.08.13.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 13:55:44 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 8 Feb 2023 11:55:43 -1000
From:   Tejun Heo <tj@kernel.org>
To:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCHSET v2] sched: Implement BPF extensible scheduler class
Message-ID: <Y+QaX/QfnLrAfYJN@slm.duckdns.org>
References: <20230128001639.3510083-1-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230128001639.3510083-1-tj@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

Ping. Peter, do you have any comments on the updated parts? Also, I'd really
appreciate if other scheduler folks can share their thoughts.

Thank you so much.

-- 
tejun
