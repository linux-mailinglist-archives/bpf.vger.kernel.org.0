Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0EC46E2859
	for <lists+bpf@lfdr.de>; Fri, 14 Apr 2023 18:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjDNQb6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Apr 2023 12:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjDNQb5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Apr 2023 12:31:57 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7B1B460
        for <bpf@vger.kernel.org>; Fri, 14 Apr 2023 09:31:25 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-94a35b0d130so436161466b.3
        for <bpf@vger.kernel.org>; Fri, 14 Apr 2023 09:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1681489881; x=1684081881;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5b/9r03boRV4UanYn1RNmzB2JpdCWtq18uHUNH61CVs=;
        b=pIQNUABRqfz5G9IJM9lizr0vPl0WgB7n4aWZwZUe/kF73YAamGDV377CeXdl3tawD9
         kq34tFZFPldbRMdqDikQFALSsSWfziPQZwMO6nLRKUytsmCwRnBk7q4JsWELm6ADvBrs
         wZwK5QNA4bcVQ9oZFNH1ueUmNoKf/StC9Cqds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681489881; x=1684081881;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5b/9r03boRV4UanYn1RNmzB2JpdCWtq18uHUNH61CVs=;
        b=Lj0dro1p8EdqftZjq8LGeSa5BBzAXk27RtnGD/OGYeTy9RfVujQmIXDIYbrF7tQTfE
         DWQy8wOzCaVMpJRJ6I9AY63v3rhRoOAKtgjpvkS1bLMhrNZcPU3/etdY7jeTzUkzTLt/
         KXYCS55IrYuv8ZqEQrWONQMMiIjy9zAkJhn18V4pQjaxBxJbJCrg5JIiSJbH4IIsJ+p7
         B3ir1xgEyL3/FXSAWxfmfmMg0GHBiQ+DgAbRCO6TA3eLr6KyAwdKyKiPEIkbaQfI/SDu
         IqoTD2/w1fJ+G/YsSyH8kU77KLgXitkjOAXVmqVBeO+uJsvdz+oem8t1259K2vHGQCgu
         Q47Q==
X-Gm-Message-State: AAQBX9cZWdxUSoo1nFGvAHwWvgF8kXBRh7hvP29W1nLP5NfOreeJL5eC
        4mHgI4JeZwxt12R7Q97KtKWs/buw1mzEd8e6NdqNZg==
X-Google-Smtp-Source: AKy350bUZ57++7VK4dP3v5BNCxqMSaz7hr9w88c5ysZKzOGWRszBmAlziDfG3+QYYunvZFtN+5iKSE1BeEKmHbt6GFA=
X-Received: by 2002:a50:8d43:0:b0:4fc:fc86:5f76 with SMTP id
 t3-20020a508d43000000b004fcfc865f76mr3343019edt.6.1681489880762; Fri, 14 Apr
 2023 09:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230406130205.49996-1-kal.conley@dectris.com>
 <20230406130205.49996-2-kal.conley@dectris.com> <87sfdckgaa.fsf@toke.dk>
 <ZDBEng1KEEG5lOA6@boxer> <CAHApi-nuD7iSY7fGPeMYiNf8YX3dG27tJx1=n8b_i=ZQdZGZbw@mail.gmail.com>
 <875ya12phx.fsf@toke.dk> <CAHApi-=rMHt7uR8Sw1Vw+MHDrtkyt=jSvTvwz8XKV7SEb01CmQ@mail.gmail.com>
 <87ile011kz.fsf@toke.dk>
In-Reply-To: <87ile011kz.fsf@toke.dk>
From:   Kal Cutter Conley <kal.conley@dectris.com>
Date:   Fri, 14 Apr 2023 18:36:04 +0200
Message-ID: <CAHApi-=ODe-WtJ=m6bycQhKoQxb+kk2Yk9Fx5SgBsWUuWT_u-A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] xsk: Support UMEM chunk_size > PAGE_SIZE
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> In addition, presumably when using this mode, the other XDP actions
> (XDP_PASS, XDP_REDIRECT to other targets) would stop working unless we
> add special handling for that in the kernel? We'll definitely need to
> handle that somehow...

I am not familiar with all the details here. Do you know a reason why
these cases would stop working / why special handling would be needed?
For example, if I have a UMEM that uses hugepages and XDP_PASS is
returned, then the data is just copied into an SKB right? SKBs can
also be created directly from hugepages AFAIK. So I don't understand
what the issue would be. Can someone explain this concern?
