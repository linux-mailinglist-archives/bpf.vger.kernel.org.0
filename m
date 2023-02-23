Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970A96A0B9E
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 15:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbjBWOP3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Feb 2023 09:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbjBWOP3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Feb 2023 09:15:29 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4189E515DD
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 06:15:28 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id bp25so14066985lfb.0
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 06:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pyGjuWdasNRFusxjWdV0aphmyUtaLZ0gwqHWlHx6iAQ=;
        b=S9OZNs0VHjSIFqYSRN0YZnQGK8E7+NO9ncj94bLKSXv0Yu28ZFnK0dzWX/XW7NJMO6
         EoHgvWkharoXDVAAax2Wj+0+JNXH6kXkVFo5kf0q6YUsyaT9SMyy3mVOSwSFr6pF6BOc
         Wu7xy9OEfA3XKdJVwsrepVYhzh81RsAQXRzPRlecylONSBOGtRdBzMYhf+/X2kUdAwbO
         dxSQ82SYlt1QUEEOP0FW+TGQKx6kZvWCUlW7c2N5JwvykzNW2g/CzKbZchioihhatZku
         SX1ogDRwqo7Z4yEeoEM9SvWfsSxwS9sLBvc8j8gBadpqU/1U4Kza2xV/WzIk7xIxXYo2
         /ifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pyGjuWdasNRFusxjWdV0aphmyUtaLZ0gwqHWlHx6iAQ=;
        b=5FSvlzf6S9CJSWK6SwGk7LVl4OyETczewHdaeJ0T2lmOlWsj2bb8WWpzsw+sdovDbA
         kC0uzf/kX//KU3boP+4ipp6IIXKTzYSApAITiOd5LFHHMeQuy6BpicqJjbsU4SDV5k+B
         ZV16gr/DwRa84nanCDrtujVG+/Hly/uQzHik1W3NO410K7LTZkbtjNm/Ql56vyMS/oqz
         u5ynfDnTS/3UQdHMnRoHuuIQj9XJjwiy90TD5vowck/HMeK17nSI+xhfvGUcwF4KpQbm
         GV8n8pR43o6gkI1wc9QIqV2sRu6l+bmec5we2Ev7bfPN/gxNsvjueMOrdrj5L5k5MA7F
         XxRQ==
X-Gm-Message-State: AO0yUKWKi9GlpR1LY8YplIntK+78dPU4sboAhN8VfcemX0gjGEYaqnOs
        WBlKmb7EMUqleHgsLY5nLaY=
X-Google-Smtp-Source: AK7set/DqnMLvGCNvmjGFFggzpM0PKJR8MfolXsNS3YIbIT6ioJHBzHQ9vGLaH55VWwehmNvSGonTw==
X-Received: by 2002:ac2:4a64:0:b0:4db:3e56:55c8 with SMTP id q4-20020ac24a64000000b004db3e5655c8mr3808688lfp.59.1677161726334;
        Thu, 23 Feb 2023 06:15:26 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id o11-20020a2e90cb000000b002958c2a2380sm745278ljg.20.2023.02.23.06.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 06:15:25 -0800 (PST)
Message-ID: <52b1b8799f9cfa4ad1d0942d1ace89866dde08df.camel@gmail.com>
Subject: Re: bpf: Question about odd BPF verifier behaviour
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Matt Bobrowski <mattbobrowski@google.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, acme@redhat.com
Date:   Thu, 23 Feb 2023 16:15:24 +0200
In-Reply-To: <17833347f8cec0e44d856aeafbb1bbe203526237.camel@gmail.com>
References: <Y/P1yxAuV6Wj3A0K@google.com>
         <e9f7c86ff50b556e08362ebc0b6ce6729a2db7e7.camel@gmail.com>
         <Y/czygarUnMnDF9m@google.com>
         <17833347f8cec0e44d856aeafbb1bbe203526237.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2023-02-23 at 14:42 +0200, Eduard Zingerman wrote:
[...]
> - pahole:
>   git@github.com:acmel/dwarves.git
>   ef68019 ("pahole: Update man page for options also")
[...]
> - gcc (from my distro):
>   gcc version 11.3.0 (Ubuntu 11.3.0-1ubuntu1~22.04)

For the sake of completeness I tried pahole `master` instead of `next`:
  431df45 ("btfdiff: Exclude Rust CUs since those are not
            yet being converted to BTF on the Linux kernel")
And gcc 12 for kernel build (looks like its the gcc version for Debian 12).
The example still works.

=C2=AF\_(=E3=83=84)_/=C2=AF
