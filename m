Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9041686B51
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 17:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjBAQNy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 11:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbjBAQNm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 11:13:42 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033816DFCC
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 08:13:13 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id n13so6061268wmr.4
        for <bpf@vger.kernel.org>; Wed, 01 Feb 2023 08:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pKG+9AAgyZVP8oX4ZVJPsfRSyZddxvUkaSIxFn81U1I=;
        b=lolPWmeAWcItvT7Ke10z7wA2JNPjRwwpRsFEvz28E51fI4vV0kxV88gdg9PjsWT6W+
         h/3GWaBblFm8w7tIq50V4vqHmId/8EIwEP3qPT4lzY8YApwf86Q8hECVd0n7paVmR5vi
         0WhFIqmPEhf9q5xJ2IznrI5U6whmzufLyn7kj4PrWgXWPFVAmiYM3seqjDNqjub5NM4W
         hyB9JzaJw6VoNks6AgWqTCM2+F69yhm0GeIde0xRNE0LXNNFX2iSkT80IS+lPgC9B6T4
         J11erh95AhxFg5ubs1/MCipRAcSz6h2bOxMB58ZmqVF0rzR7d/Be+hQGpRRtPSrmCJLb
         fA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pKG+9AAgyZVP8oX4ZVJPsfRSyZddxvUkaSIxFn81U1I=;
        b=xu3zCPGFAhNVn1V6ksc+kJVJFn+HElq4UXqJ5AZ1WVaTbOMNkTpAS4bzh/AttdoJfb
         o6gcOtJcIgM7IP6jf8PQji9FOtPj2AL+oZjoP7H1W/OTGdlgsNWNe5hEBm8BzIQuQrTC
         +zYmHlAcItKsYnP8VtiuFNOqjv8d4d32Whf2oZwZvFkatGSthKy8pV2BBHwYqRYAsEkB
         XqZOvbG09tuNCrMowz1sfomAxDL9mMxTk2NBkwmkCSPxYawhkIY/3kf4P1F8WRfYem7J
         K1xbfLw9MlD18wq4ap1QgqLqR1iqA/aF8RNbAIK+SjZayC9wc8LRhYrUYH289nUIzZQq
         9M4g==
X-Gm-Message-State: AO0yUKV4GxEJhxetrSX2Bj7Q8tVh+iJKjZzpL9LxjwXM0+wsdc5sQChV
        0P3IPpWSOW/smdh99Qszrss=
X-Google-Smtp-Source: AK7set9Dxy/WvGA2jPP+UC1W8yDTyhFqjqcY40qwU9RjzaQyRkksxxGgnivs/8wdPkFLzSkrNsTqqQ==
X-Received: by 2002:a05:600c:3b1c:b0:3dc:443e:420e with SMTP id m28-20020a05600c3b1c00b003dc443e420emr2682552wms.2.1675267988202;
        Wed, 01 Feb 2023 08:13:08 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id bd16-20020a05600c1f1000b003db0ee277b2sm2281172wmb.5.2023.02.01.08.13.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 08:13:07 -0800 (PST)
Subject: Re: [PATCH bpf-next v3 1/1] docs/bpf: Add description of register
 liveness tracking algorithm
To:     Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com
References: <20230131181118.733845-1-eddyz87@gmail.com>
 <20230131181118.733845-2-eddyz87@gmail.com>
 <99a2eaa9-aebb-f0c8-1d13-62e1533631e7@gmail.com>
 <48f840c1b879728bda69e059f19c2cea642c1e97.camel@gmail.com>
From:   Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <c26d4287-6603-d44f-58fc-ed4c698ea5b3@gmail.com>
Date:   Wed, 1 Feb 2023 16:13:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <48f840c1b879728bda69e059f19c2cea642c1e97.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 01/02/2023 15:14, Eduard Zingerman wrote:
> I can update this remark as follows:
> 
> ---- 8< ---------------------------
> 
>   Current    +-------------------------------+
>   state      | r0 | r1-r5 | r6-r9 | fp-8 ... |
>              +-------------------------------+
>                              \
>                                r6 read mark is propagated via these links
>                                all the way up to checkpoint #1.
>                                The checkpoint #1 contains a write mark for r6
>                                because of instruction (1), thus read propagation
>                                does not reach checkpoint #0 (see section below).
Yep, that's good.

> TBH, I'm a bit hesitant to put such note on the diagram because
> liveness tracking algorithm is not yet discussed. I've updated the
> next section a bit to reflect this, please see below.
Yeah I didn't mean put that bit on the diagram.  Just 'somewhere'.

> I intentionally avoided description of this mechanics to keep some
> balance between clarity and level of details. Added a note that there
> is some additional logic.
Makes sense.

> All in all here is updated start of the section:
> 
> ---- 8< ---------------------------
> 
> The principle of the algorithm is that read marks propagate back along the state
> parentage chain until they hit a write mark, which 'screens off' earlier states
> from the read. The information about reads is propagated by function
> ``mark_reg_read()`` which could be summarized as follows::
Hmm, I think you want to still also have the bit about "For each
 processed instruction..."; otherwise the reader seeing "The
 principle of the algorithm" will wonder "*what* algorithm?"
Don't have an immediate suggestion of how to wordsmith the two
 together though, sorry.

> Notes:
> * The read marks are applied to the **parent** state while write marks are
>   applied to the **current** state. The write mark on a register or stack slot
>   means that it is updated by some instruction verified within current state.
"Within current state" is blurry and doesn't emphasise the key
 point imho.  How about:
The write mark on a register or stack slot means that it is
 updated by some instruction in the straight-line code (/basic
 block?) leading from the parent state to the current state.

> * Details about REG_LIVE_READ32 are omitted.
> * Function ``propagate_liveness()`` (see section :ref:`Read marks propagation
>   for cache hits`) might override the first parent link, please refer to the
>   comments in the source code for further details.
"comments on that function's source code" perhaps, so they know
 where to find it.  If they have to look all the way through
 verifier.c's 15,000 lines for a relevant comment it could take
 them quite a while ;)

> Thanks a lot for commenting!
> wdyt about my updates?
I think we're getting pretty close and I look forward to giving
 you a Reviewed-by on v4 :)
(But make sure to Cc me as I'm not subscribed to bpf@vger.)

-ed
