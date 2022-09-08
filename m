Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309095B27D2
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 22:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiIHUij (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 16:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiIHUii (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 16:38:38 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB3B10C9AB
        for <bpf@vger.kernel.org>; Thu,  8 Sep 2022 13:38:37 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id r17so13420691ejy.9
        for <bpf@vger.kernel.org>; Thu, 08 Sep 2022 13:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Ds2ecgQatjzbaina9lRRYWFpJ2NdlS1nnyMse662bn8=;
        b=M3tH0ctAang7byhuKARJPXIjHOmtQN5r7nge2bZsalg7seAkW9AxBrIzxzEqilbbxZ
         02EphY0xbuYFOOxSbGFZ/5uKF+sWtX+D8Xlp9N9qsbVkmBy5XXWGV0WBRDbaQLI+Sk/V
         NjCjfhro1ZnJv8+w73pg3wuH43b5WWGGy4UyJg0Mhbs6nOHRsf2vuebQrQyRTc02ijHg
         x1o+4qDKfUfxdaMLQmy4g1AuSN5Ij4UGw7UhPPkLVizSJdXEIUxOtqAGdyKP7SRnNerv
         UqnGCr6Z9WsRzq0n3oHvQ4wX8guG81WzI6YcBLjhPwutMl+g/WrMQ5ExbhRPquViXRB4
         Prlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Ds2ecgQatjzbaina9lRRYWFpJ2NdlS1nnyMse662bn8=;
        b=lMZdYhS8Zqy/BMt6YbrLUVWRrsmT5XuPRX0FQIFOwAHxuadXEV+545w/Qzzu4APO2i
         8KFQG2p56fNKerZqvEC2yen0nrnkZUxnUlviTqpWqjmh6TG3R3/bTHcNcDSJ19jyNEhf
         zIMIgxC/1O1GSyek2Qj/3VFOD8Bm4mqrDY47lNxCve5c2E/jzmJF5VAk+wDOdGsRxzfP
         MoX6P4H+jqlp4710VswNkHtJ5K01zeo0ceXKyQwKn8ZOBaaXU5TbqotjpsV9XiY0yNYt
         QFn7CW0Um0r1xU7rq+zEvRm7ylt+tCk7LzdyayHop3Blau3Eb11WMAhLre0dUw81fsH1
         Ib9w==
X-Gm-Message-State: ACgBeo0nJfN5dxAUKhjpph6/t4/1OmoImrIS3mhbs/25f+6PTjOUnW0R
        7qdR9V3idShvk55BULLlv9Fd5OHARbO1zXRujyA=
X-Google-Smtp-Source: AA6agR7Sg9mIYfCPEZfpsnwqUM0YelAIT2/Rj4A4vgCST0gWhybij+jUIAGwY/SfI8+wExrJFEPUcCn+0mXnaeV7mNY=
X-Received: by 2002:a17:907:3f15:b0:741:7ab9:1c5a with SMTP id
 hq21-20020a1709073f1500b007417ab91c5amr7043847ejc.369.1662669516262; Thu, 08
 Sep 2022 13:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220831233615.2288256-1-harshmodi@google.com>
 <CAJnrk1ZVbczXnJrd7NH-q6CV10eu5FytTgrGX_3SC_+G59P73Q@mail.gmail.com> <CAO5Vyb_gHECvaJLhO-4V9Uov8GMkbUxyJ383dyWdP5QJFhdJnw@mail.gmail.com>
In-Reply-To: <CAO5Vyb_gHECvaJLhO-4V9Uov8GMkbUxyJ383dyWdP5QJFhdJnw@mail.gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Thu, 8 Sep 2022 13:38:25 -0700
Message-ID: <CAJnrk1abnH9tbERT-4a6adSe+qCBD=ngeBOdkmxjUfsOptSPPg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add bpf_[skb|xdp]_packet_hash.
To:     Harsh Modi <harshmodi@google.com>
Cc:     bpf@vger.kernel.org, sdf@google.com, ast@kernel.org,
        haoluo@google.com, quentin@isovalent.com, joe@cilium.io
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 8, 2022 at 8:54 AM Harsh Modi <harshmodi@google.com> wrote:
>
> > What are your thoughts on having a more generic hashing helper?
>
> I didn't make the connection that dynptrs could also reference packet data... Would dynptrs also handle multi buffer support in both skb and xdp or would we have to pull all the data into a contiguous location first?

skb and xdp dynptrs haven't been merged in yet, the latest thread on
this is here: https://lore.kernel.org/bpf/20220907183129.745846-1-joannelkoong@gmail.com/

Dynptrs can handle multibuffer support in skb and xdp for the program,
it will pull in non-linear data as part of bpf_dynptr_write() if the
write is to a frag in the skb
