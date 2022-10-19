Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C149960463C
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 15:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiJSNDK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 09:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiJSNCt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 09:02:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435D427DC8
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 05:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666183501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q8LPpnYpysqGSiJUPWry3p0iYpcsy7FD/788/f3PsSg=;
        b=Qf8MOAN0dm4EBewezJ84Y9Q2bN8zUdMLOPTjIghsb2gtUjaC6ycbVO53DMP5THNibY0W9z
        WHfPh2gJbjaTITne25g0fsi1sCgTl25KBRGeOk/k2pnEDyNI9KCF1yHXg8bMiKXEz8xx7Z
        sg0UJLf7ZyXb3K9RnWruo1+7jjXv8xc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-148-5EO_4TfcOPmwIFGowP_BHQ-1; Wed, 19 Oct 2022 08:41:31 -0400
X-MC-Unique: 5EO_4TfcOPmwIFGowP_BHQ-1
Received: by mail-ed1-f71.google.com with SMTP id b13-20020a056402350d00b0045d0fe2004eso12163548edd.18
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 05:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8LPpnYpysqGSiJUPWry3p0iYpcsy7FD/788/f3PsSg=;
        b=2RCCDqSaxHfAwJ7gKK/Hc2d6v1OweCDsn9U8gKKjR1d0sgLltu17w0N93rLCS9RX4V
         mLVxSwOGQzgx/HRdGy5U9kfQ0Bs8BCxONFAQlIKo1H1GCaAu/nmYnXRLAbCjR9i2DlOy
         aWXKFEwlURfU+OwRXyGjM7ebR9M9MxJ3q5eeMxtV39hi7fzIVqoyNOA1/116K2sdarPc
         xeB6grig8qrHYdA2qyE4ZxhwD7Z8Giji3A78XsTX0DIViWPW4haYaVXxXiaNr39oEXWu
         acyktxIh1h7ifyYMUhoBWNVXcFuQnlzX+s/aDgvnyVghHcMUvMK5+zuejfa59d2lWqoQ
         oc/A==
X-Gm-Message-State: ACrzQf3x28YidwSmBUBWv2VjzKCpt/UW5UAKloKgvs9bNbXIP6TYnNmZ
        Ax69KKoHHahi/0YAglqe6fTDcp2Pf4TweiKKYrxalZBtTS7qeUE637/omPUgKSfca1So3GuESsJ
        Vw8guwQnqo1nj
X-Received: by 2002:a17:906:5a4b:b0:78d:8790:d4a1 with SMTP id my11-20020a1709065a4b00b0078d8790d4a1mr6561278ejc.329.1666183287303;
        Wed, 19 Oct 2022 05:41:27 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6sWe0zylQfRJULRKTF9A5wU7VQf2KsdTVq4NOZsdUmfUsJ4OCFQfVUDSsqaTfCq+dVr7yOIg==
X-Received: by 2002:a17:906:5a4b:b0:78d:8790:d4a1 with SMTP id my11-20020a1709065a4b00b0078d8790d4a1mr6561225ejc.329.1666183286337;
        Wed, 19 Oct 2022 05:41:26 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id k15-20020a17090632cf00b0078d38cda2b1sm8818709ejk.202.2022.10.19.05.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 05:41:25 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9D7306C25B2; Wed, 19 Oct 2022 14:41:24 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Florian Westphal <fw@strlen.de>, bpf@vger.kernel.org
Cc:     netfilter-devel <netfilter-devel@vger.kernel.org>
Subject: Re: netfilter+bpf road ahead
In-Reply-To: <20221018182637.GA4631@breakpoint.cc>
References: <20221018182637.GA4631@breakpoint.cc>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 19 Oct 2022 14:41:24 +0200
Message-ID: <87a65shtor.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Florian Westphal <fw@strlen.de> writes:

> - lots of details to be figured out, but if netfilter core folks
> agree to this plan it will be one of the most exciting
> projects in the linux networking. iptables will see significant
> performance boost and major feature addition.
> Blending bpf and netfilter worlds would be fantastic.

+1 on this; sounds like great news, and I look forward to seeing this
effort come to fruition. Thank you both for taking time to hash this
out! :)

-Toke

