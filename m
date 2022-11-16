Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032AE62B142
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 03:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiKPC1Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 21:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiKPC1P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 21:27:15 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C82F27CDB
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 18:27:14 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so1087202pji.0
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 18:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ahZz9AJmzGlJIQIWPIPRIoLfIVWlXjpHEZJmoMH+xOc=;
        b=gGDZf0rtUePdblahow2E25VxQTPgN7jbIs+awl+TPpQNdPWanNp680Xf0nzQ7ZL+Ot
         pavAPVefaCJKXta+Y2M8VoiD75BMMdqL/nc6y3Yqu8UwQA1u6qmGuuFK0fY+nLsSH8Lv
         4roikcbwV07w5YhUXsWDMXrCohpJH7hktpUdLVjXRv7d5HQGPloCu2jKkH/ynM3gk50w
         h8zf6xWphdiQfuoWFN4iMPRILF10kWYXSXI11LOTIWcFzwHeIcSv1L8dXgpqEKnCy0x6
         7F+DA+dujgDJl1VAuzCRA5O4PpI8PiHDtP+PbEAhCa2VYjLRh7PxPQ5GU2Ty5bSEaJQ5
         EriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ahZz9AJmzGlJIQIWPIPRIoLfIVWlXjpHEZJmoMH+xOc=;
        b=Nie/Rl93U4pJlyCqiWMhp4dfYOGiSk+6RjIESMDWqzcZ12/GC3FaORwBps9Ok+/6bt
         9wybL0M7QtfPIfKjQJjjnWJOPvcR8aSNJViUtBL8iZ+9hKqMMpqhb+xfa+KyAOguHXtn
         nKVW9K7ZE0WX5b4RcsOwJ6caZutVeqyQIQTqm+zSbwZ7BysPOQ3GEbXBxX8OJPD4qRiY
         udLCxHdEamO3EXdN/HcT87v//4Cbt04e8YJuNrYIocFNeiujGAWvqwYZOpii8qoCTSx4
         zB0XBvxrdeHLHGGiwcHFFVD3k+PUhXS6FD/qUMc7/nGi64YhCqv7SJNdiB8VuBUd5Qji
         838A==
X-Gm-Message-State: ANoB5pmcEYLW5Nk7nXVtxFiMuRNbzmkd/67YEELq4zrzLE3qppP4tvdy
        sx1A0lWBlcgYMK5izkPBWDE8LIf3BKJBargsYEr2
X-Google-Smtp-Source: AA0mqf4YV8pgzBiL96jyU49MeQd2r/aiOKiYHCrbMrG+E2Fkmtbk+xgzRFLez6ziTJjdzAaOlAYcvbYh3pAWRbHWEqM=
X-Received: by 2002:a17:90a:2b8c:b0:212:f4f1:96ee with SMTP id
 u12-20020a17090a2b8c00b00212f4f196eemr1447232pjd.72.1668565634126; Tue, 15
 Nov 2022 18:27:14 -0800 (PST)
MIME-Version: 1.0
References: <20221115175652.3836811-1-roberto.sassu@huaweicloud.com> <20221115175652.3836811-4-roberto.sassu@huaweicloud.com>
In-Reply-To: <20221115175652.3836811-4-roberto.sassu@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 15 Nov 2022 21:27:02 -0500
Message-ID: <CAHC9VhTA7SgFnTFGNxOGW38WSkWu7GSizBmNz=TuazUR4R_jUg@mail.gmail.com>
Subject: Re: [RFC][PATCH 3/4] lsm: Redefine LSM_HOOK() macro to add return
 value flags as argument
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, revest@chromium.org,
        jackmanb@chromium.org, jmorris@namei.org, serge@hallyn.com,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 15, 2022 at 12:58 PM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Define four return value flags (LSM_RET_NEG, LSM_RET_ZERO, LSM_RET_ONE,
> LSM_RET_GT_ONE), one for each interval of interest (< 0, = 0, = 1, > 1).
>
> Redefine the LSM_HOOK() macro to add return value flags as argument, and
> set the correct flags for each LSM hook.
>
> Implementors of new LSM hooks should do the same as well.
>
> Cc: stable@vger.kernel.org # 5.7.x
> Fixes: 9d3fdea789c8 ("bpf: lsm: Provide attachment points for BPF LSM programs")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  include/linux/bpf_lsm.h       |   2 +-
>  include/linux/lsm_hook_defs.h | 779 ++++++++++++++++++++--------------
>  include/linux/lsm_hooks.h     |   9 +-
>  kernel/bpf/bpf_lsm.c          |   5 +-
>  security/bpf/hooks.c          |   2 +-
>  security/security.c           |   4 +-
>  6 files changed, 466 insertions(+), 335 deletions(-)

Just a quick note here that even if we wanted to do something like
this, it is absolutely not -stable kernel material.  No way.

-- 
paul-moore.com
