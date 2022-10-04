Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E435F4598
	for <lists+bpf@lfdr.de>; Tue,  4 Oct 2022 16:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiJDOhB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Oct 2022 10:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiJDOg7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Oct 2022 10:36:59 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9609E61706
        for <bpf@vger.kernel.org>; Tue,  4 Oct 2022 07:36:58 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id x32-20020a17090a38a300b00209dced49cfso10723109pjb.0
        for <bpf@vger.kernel.org>; Tue, 04 Oct 2022 07:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date;
        bh=G8HC/qdsdkCz+7nlQ+/5nMVixHm7s58AKwQk+/RzHE8=;
        b=LYQKdrQ0Jqy6tX7oRGZ9vSrT2Jm0TF3Jh5uqOznz4wYL4XHGchcbWu2fBwM+kZPqsI
         Dckj5FmcQO5rTtjuVrGv6TIVY6QSRvBRDxQdUGedBkj8JWyfo8VRldN3Few/qfYgSrZU
         48a20g1oNbkllVVfCO4inz6cg8RObiLO/Us+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=G8HC/qdsdkCz+7nlQ+/5nMVixHm7s58AKwQk+/RzHE8=;
        b=Xg5XETNSdhdcAYJVJnJdYlsfPf093mVCrdkw/uGMADc1r+7Liu60o3kGuCuzP1ar2E
         aqwezdBrlSQJWXMgoRbi5KbQlCmWLkA7E5ih2X5kzBidzbP08DvewfBKDDUJP8aJmHJk
         L3/qJViCwqLtz3but+6bhoOcBpj/Kv75Sm1YV5QZCyqMt+/8wlLjMb+CMbX8rV4soE2s
         V6hLBlmgXNRIosAUIqa8Pcd9zB0rP9z8Dfn/vi7z5L0yZHc6nbAuK+cs3Ki1LN5p8pyj
         jMmuyKyms64DDeuM1R5heifTnO9fqq2+3xPK2iSHnStO9FbzEo+Kk1KcWHAt0ihn4wUP
         uvAQ==
X-Gm-Message-State: ACrzQf18WhIjZ1TM8PHlM6J70IrFuFo+2DWglsx+pSVkHrh3uGU904HF
        X6MtPGhCK7Ml16Hr8dltTLa8Uw==
X-Google-Smtp-Source: AMsMyM4wbJ+ie7ot867nR4SuDtNWyvqfBc+uKwrli/A4yP9ItGLF1K7sJhlc9+CMWYcwmUfspjVLqQ==
X-Received: by 2002:a17:902:768c:b0:17a:ec9:51da with SMTP id m12-20020a170902768c00b0017a0ec951damr27738002pll.159.1664894218120;
        Tue, 04 Oct 2022 07:36:58 -0700 (PDT)
Received: from [127.0.0.1] (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i7-20020a63b307000000b0042aca53b4cesm8646731pgf.70.2022.10.04.07.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 07:36:57 -0700 (PDT)
Date:   Tue, 04 Oct 2022 07:36:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+3a080099974c271cd7e9@syzkaller.appspotmail.com>
CC:     bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        fw@strlen.de, harshit.m.mogalapalli@oracle.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
        linux-hardening@vger.kernel.org
Subject: Re: [syzbot] upstream boot error: WARNING in netlink_ack
User-Agent: K-9 Mail for Android
In-Reply-To: <CACT4Y+a8b-knajrXWs8OnF1ijCansRxEicU=YJz6PRk-JuSKvg@mail.gmail.com>
References: <000000000000a793cc05ea313b87@google.com> <CACT4Y+a8b-knajrXWs8OnF1ijCansRxEicU=YJz6PRk-JuSKvg@mail.gmail.com>
Message-ID: <F58E0701-8F53-46FE-8324-4DEA7A806C20@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On October 4, 2022 1:33:30 AM PDT, Dmitry Vyukov <dvyukov@google=2Ecom> wr=
ote:
>On Tue, 4 Oct 2022 at 10:27, syzbot
><syzbot+3a080099974c271cd7e9@syzkaller=2Eappspotmail=2Ecom> wrote:
>>
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    725737e7c21d Merge tag 'statx-dioalign-for-linus' of gi=
t:/=2E=2E
>> git tree:       upstream
>> console output: https://syzkaller=2Eappspot=2Ecom/x/log=2Etxt?x=3D10257=
034880000
>> kernel config:  https://syzkaller=2Eappspot=2Ecom/x/=2Econfig?x=3D486af=
5e221f55835
>> dashboard link: https://syzkaller=2Eappspot=2Ecom/bug?extid=3D3a0800999=
74c271cd7e9
>> compiler:       gcc (Debian 10=2E2=2E1-6) 10=2E2=2E1 20210110, GNU ld (=
GNU Binutils for Debian) 2=2E35=2E2
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
>> Reported-by: syzbot+3a080099974c271cd7e9@syzkaller=2Eappspotmail=2Ecom
>
>+linux-hardening
>
>> ------------[ cut here ]------------
>> memcpy: detected field-spanning write (size 28) of single field "&errms=
g->msg" at net/netlink/af_netlink=2Ec:2447 (size 16)

This is fixed in the pending netdev tree coming for the merge window=2E

--=20
Kees Cook
