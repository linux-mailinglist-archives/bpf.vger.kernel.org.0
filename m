Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F776D3F56
	for <lists+bpf@lfdr.de>; Mon,  3 Apr 2023 10:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjDCIpR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Apr 2023 04:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjDCIpM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Apr 2023 04:45:12 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608F640F7
        for <bpf@vger.kernel.org>; Mon,  3 Apr 2023 01:45:08 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id r11so114177755edd.5
        for <bpf@vger.kernel.org>; Mon, 03 Apr 2023 01:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1680511507;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=gls3PzAYkrjqLecU7D6fK2kYJv7shqoopRvlQDPgL3E=;
        b=pHtBhCqR6ULW6wB+dbwdre+EP14JapbRBJyoy1SWol6oyWNlm3jpd3Tm3AoVi/z4gl
         K5q6vI0TWGBqadYNSuQ3pkwxGBjRdyOqn4vF/VPHjhLA5leUdiqA9NuttL8Nv8h3aFu2
         /mU/UeqgO8sPecCkL/BGXxXNcI5xJOek54JQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680511507;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gls3PzAYkrjqLecU7D6fK2kYJv7shqoopRvlQDPgL3E=;
        b=eoa2UyatkjhVYM9g38TuhG0TzTsIumXUMwPQcj0ai/Cxpt9Mtedy6BNBA5qYnKGRXg
         eJt35DJ3kCZ+VpT14p9NpfbWgas9mFoM45j7o2tgyMZ+G/NVikiD/c8ptLBh5hIGC30R
         UjmsfYWL8y54JU9ZVHaaT+drLu4cBz0631LqoI0MFNZpfYNHndgy+CGGsfr48TkfQ3C7
         yME7rzYeTWUcy6WIpB1rZUgMWU0hsliGuM/TlmofabogATxPYbJluU4ju3bIUrJaPQ7d
         RaUMOwjHOmLw0XXXTCC5BfKrI9pKrIIxTt2wYOKBsahMdMT1KREUwBBK4Y+3UtZSprgJ
         MtYw==
X-Gm-Message-State: AAQBX9fXAq2Szk0o17pJGbTwsky1r/b0PiZF+pev/n7JMdSFMLfqu/f7
        LekyXSbuzcc4ANvxhz2Rugbi9A==
X-Google-Smtp-Source: AKy350bFHkDO2VkvPa70FYS4i3I6JoMsXr3EW5Bxu9gfdRI2FSKC3rLrjdGd+X0wCXTUIPnfIEjQUw==
X-Received: by 2002:aa7:d74b:0:b0:4fb:5607:6a24 with SMTP id a11-20020aa7d74b000000b004fb56076a24mr33712857eds.8.1680511506914;
        Mon, 03 Apr 2023 01:45:06 -0700 (PDT)
Received: from cloudflare.com (79.184.147.137.ipv4.supernova.orange.pl. [79.184.147.137])
        by smtp.gmail.com with ESMTPSA id z21-20020a056402275500b00501d73cfc86sm4223679edd.9.2023.04.03.01.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 01:45:06 -0700 (PDT)
References: <20230327175446.98151-1-john.fastabend@gmail.com>
 <20230327175446.98151-4-john.fastabend@gmail.com>
 <87zg7vbu60.fsf@cloudflare.com> <642782044cf76_c503a208d5@john.notmuch>
User-agent: mu4e 1.6.10; emacs 28.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     cong.wang@bytedance.com, daniel@iogearbox.net, lmb@isovalent.com,
        edumazet@google.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, will@isovalent.com
Subject: Re: [PATCH bpf v2 03/12] bpf: sockmap, improved check for empty queue
Date:   Mon, 03 Apr 2023 10:42:32 +0200
In-reply-to: <642782044cf76_c503a208d5@john.notmuch>
Message-ID: <87edp1e4mm.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 31, 2023 at 05:59 PM -07, John Fastabend wrote:
> Jakub Sitnicki wrote:

[...]

>> It's just an idea and I don't want to block a tested fix that LGTM so
>> consider this:
>
> Did you get a chance to try this? Otherwise I can also give the idea
> a try next week.

No. By all means, feel free. You caught me at a busy time. That's also
why the review has been going so slow.
