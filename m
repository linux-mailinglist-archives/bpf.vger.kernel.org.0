Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9343C6A0A5D
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 14:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbjBWNUX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Feb 2023 08:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbjBWNUW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Feb 2023 08:20:22 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FD855050
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 05:20:21 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id o12so42414587edb.9
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 05:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=iSjnrafhPf2fV2dernAngBYS4Gggay/mJLZl6aCWzRw=;
        b=hZ2cWoLhw7vZdo3a8jZjRplebOgEK4dMYh8sTq41UW/1pFaZmvBXEqAZM3ksDsLouN
         QBsDou/MgRov9xaiFRFGwyRGskP40ebtzBt5dt/Q5q0IiX0DLmGnMPctRVg2LN+9ONp+
         E2VFlwiqgYAJLmyp4SmjoYg2LV+oDPY1qIfkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSjnrafhPf2fV2dernAngBYS4Gggay/mJLZl6aCWzRw=;
        b=424a2ciUnAwR1qAiQObYa0DP/J88Of98rTyD083FEiXp5giZqbm8+uFJqBIKsNaDr1
         jbiXOmPeHy1+mGGOWHnpcpqOvf2vsgVO4uMTCBgJmIbkUMjjnlwnt13S5nQJHQqxA/3C
         O2rDlXEg9+XIznIvgQVHhS+oOil9rfK6pRP5Hg5Ams2sATmVPnt0ApsbAW/3iogZQjkj
         aEwABhJaHwPMHPtUjZFe27glSAFY0QVRlRZDYuXhtYZ7DACBFD1/7XD/ptjt9lywFRKc
         dBzt6rDterQAYPzjJjKfsW4ucZnhr2RydkrrC2Ew+vTDLzD6PXkB4/vAF5QW9/lph1XT
         bSRg==
X-Gm-Message-State: AO0yUKXvlLpamr7MO45cfd3Ro11kqo3h54tzP9JFbq7k75CEFlHBLxps
        DUFzAvaz4S+IkBTdOAQOWNZWjw==
X-Google-Smtp-Source: AK7set8YyYFogMSPl3OmEGg1NZPemZOCHQm2M6jX3eCL9OUurVpCatyIeHw/Rf7BFUTXkbnPqyK7rg==
X-Received: by 2002:a17:906:eca1:b0:87d:eff1:acc8 with SMTP id qh1-20020a170906eca100b0087deff1acc8mr19267418ejb.48.1677158419722;
        Thu, 23 Feb 2023 05:20:19 -0800 (PST)
Received: from cloudflare.com ([2a09:bac1:5bc0:40::49:12a])
        by smtp.gmail.com with ESMTPSA id w7-20020a50d787000000b004aad0a9144fsm5322345edi.51.2023.02.23.05.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 05:20:19 -0800 (PST)
References: <CABcoxUayum5oOqFMMqAeWuS8+EzojquSOSyDA3J_2omY=2EeAg@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 28.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Hsin-Wei Hung <hsinweih@uci.edu>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: A potential deadlock in sockhash map
Date:   Thu, 23 Feb 2023 14:17:54 +0100
In-reply-to: <CABcoxUayum5oOqFMMqAeWuS8+EzojquSOSyDA3J_2omY=2EeAg@mail.gmail.com>
Message-ID: <87a614h62a.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On Mon, Feb 20, 2023 at 07:39 AM -06, Hsin-Wei Hung wrote:
> I think my previous report got blocked since it contained HTML
> subparts so I am sending it again. Our bpf runtime fuzzer (a
> customized syzkaller) triggered a lockdep warning in the bpf subsystem
> indicating a potential deadlock. We are able to trigger this bug on
> v5.15.25 and v5.19. The following code is a BPF PoC, and the lockdep
> warning is attached at the end.

Not sure if you've seen John's reply to the previous report:

https://lore.kernel.org/all/63dddcc92fc31_6bb15208e9@john.notmuch/

Are you also fuzzing any newer kernel versions? Or was v5.19 the latest?

Did syzkaller find a reproducer?

Thanks,
Jakub
