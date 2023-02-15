Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882806981DB
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 18:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjBORXX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 12:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjBORXV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 12:23:21 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81ED1EC4B
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 09:23:17 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id a2so19928423wrd.6
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 09:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqtBdN+1ppp8e/CSn0vupSzwChby4224H0BfpXodQLA=;
        b=KUjhCHq/IyaBxJIaBshTwK5EQy/ynz7jLapyf7e2pN9XEQE1moQhCOl/Mj+qbRrfSy
         3q+6cXGQF/jwUKdmo8XEUZ4a+Eho+aCAZT0nMGYMZVwCmsArr96yhUZfmXcjOqgInGRt
         eLPd7AuccY2D8L6b90YVy5eIQAO1JxPA82NVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QqtBdN+1ppp8e/CSn0vupSzwChby4224H0BfpXodQLA=;
        b=oJ5Ne1x7qJuLywkOjO/WFsxmm1dRmg+k6FPhP8HG0Sc+fJewU6CamgjW2w3wnSTjc9
         p6MrEfkslc+6IzeOeKvJAeZSwhLVLemGos5j55IM3FPpv1SEjvMBDQMgqmAia7s1JCs4
         Q4ggNEHrald+J30uUy+ZoUOkpMy5u/C9T9VA0rXgdjk66BKcvuKQWwvmJFcH5y7lpYo5
         +ewnzlhEuOhavSG6SQrQTC/WiP+czQBbckUUA/MQeNlQwLD3/CgkVXxGn46qmn1H8bxG
         4r7V/oObjrdpNTe39abkAF+HlysMg6nydICS9SX96kyAPoOFAngM81T1FFj9kRkfl7Fw
         lksg==
X-Gm-Message-State: AO0yUKVdsbOQj1gvW7cSusZjl1ZBa3zSozcm8PHt9yHb2SVdFWx60ndL
        ncce/QdFCwdBNW9hS14ywsUrakLs9ibh/Y/j
X-Google-Smtp-Source: AK7set9OHudQqPkdfMrIhN61SvMXrhUrNNXk+iAP3BJDjiL/w2O5ZVFfBlp2c3m/PeRCYgaHEFmw1w==
X-Received: by 2002:adf:f30d:0:b0:2c5:4cf1:a57b with SMTP id i13-20020adff30d000000b002c54cf1a57bmr2257952wro.35.1676481795981;
        Wed, 15 Feb 2023 09:23:15 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::4:270c])
        by smtp.gmail.com with ESMTPSA id n27-20020a05600c3b9b00b003e206cc7237sm1211706wms.24.2023.02.15.09.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 09:23:15 -0800 (PST)
Date:   Wed, 15 Feb 2023 17:23:14 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, mcgrof@kernel.org,
        ndesaulniers@google.com, trix@redhat.com,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev,
        Abaci Robot <abaci@linux.alibaba.com>,
        Song Liu <song@kernel.org>
Subject: Re: [PATCH] module: Remove the unused function within
Message-ID: <Y+0VAr21hlIdrxyp@chrisdown.name>
References: <20230210064243.116335-1-jiapeng.chong@linux.alibaba.com>
 <Y+0MsMomkcDBdjNI@chrisdown.name>
 <Y+0PzlA0LijhfD8R@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Y+0PzlA0LijhfD8R@dev-arch.thelio-3990X>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

+Cc: Song

Nathan Chancellor writes:
>On Wed, Feb 15, 2023 at 04:47:44PM +0000, Chris Down wrote:
>> Jiapeng Chong writes:
>> > The function within is defined in the main.c file, but not called
>> > elsewhere, so remove this unused function.
>>
>> Huh? It's used by __module_text_address(), no?
>
>Not after commit 2ece476a2346 ("module: replace module_layout with
>module_memory") in -next. This patch should have a fixes tag, even if
>the warning is currently hidden behind W=1.

Huh, I thought I had checked out latest -next, but must have not done so 
somehow :-) Mea culpa.

If it's only in -next then no Fixes needed, since there's no stable rev yet.

Jiapeng, in future, please make sure to cc the author of related commits when 
reporting stuff like this :-) It helps people to update their patches.

Song, you probably want to update your patch.
