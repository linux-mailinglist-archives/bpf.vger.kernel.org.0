Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7320159C5BB
	for <lists+bpf@lfdr.de>; Mon, 22 Aug 2022 20:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbiHVSGp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Aug 2022 14:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbiHVSGo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Aug 2022 14:06:44 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C134623A
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 11:06:43 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-334dc616f86so316119187b3.8
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 11:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=YTWbcXYi1Ivxq8tw9BzCtn+27aJiaxq7nO4GSE1LQRk=;
        b=U3Q3daqYDPrYxkKM4G2B+ONAfcgacSkm8o1fQbbSS8DcyUqgxl2H7MpAgHb17RbrQQ
         1dOCakYpEkkCn4zvgt0zuZWAdKbf64J5bxEN6O6p5cF1LWN5+aj+zjOac/38BL77UUIt
         xbRy8aimAGxn8sTa0aRMj+sTi6/7z/j9Eo0A+Q+q5VG9Br7Alhr89JUqZebCRVQrPP7i
         E80XXWtHWmg6Qd802NqsnAwHsQ3FTsGuc0NuXdauCkAOJ7Wos55ahffzo4KaIalnmF0Y
         fqlkrS7F3uZPIFe3C1pL6cu/Zs7SYu3xW2Yest9ppUgVU1koW5UCICEj1mS2qYVkO2qo
         RR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=YTWbcXYi1Ivxq8tw9BzCtn+27aJiaxq7nO4GSE1LQRk=;
        b=zTZAr3qWzb9qe3SIuQub5vQwxqGrcRtp1kkvjt7jnKr7Un9goLNDLtAqDN87BcUQrA
         RtwRfwlt5gDUVt4+Ikp66ZkC18hPCXXiLnQyVget0WGyekg4dlNhwSZqLeylpT7DAJeU
         lcfiIbRxssOI0guf7OW8J1qYr1bTrom+s69lZT29E2I/fjaBzK/VCTF+iGe5pOhLjsm4
         V436shbcT9IXidQe8NVbG7DcxWz/puLhJAJUwoHz1rvMhUcaJkERTX8GG0dSxtLkSPpb
         7py3hicV6raSsrCRbjh3jqr1Yum2uG9dT/ZYfAqbkX7jnOMsf1A8XTzR780GsIFQNdbt
         0/rw==
X-Gm-Message-State: ACgBeo292ZaX3ZW/5cKfUf9Ev3OwCM4g7i+hH3V7S3C7X6dabvsIo/CD
        2EGhz80Qlru9cY5cJ8eZTP46BQ32nKuPXnxeQ591kA==
X-Google-Smtp-Source: AA6agR4zamVoYcxmTF1BhqlhJ5MxSDk9bey2P8tFEh9WrOwffY51HPwOzrBN/QkB0n2OwmmQZ6WWeC9pRngA+vsh/wk=
X-Received: by 2002:a5b:98b:0:b0:695:8398:9f1e with SMTP id
 c11-20020a5b098b000000b0069583989f1emr10339188ybq.620.1661191601941; Mon, 22
 Aug 2022 11:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220821113519.116765-1-shmulik.ladkani@gmail.com>
In-Reply-To: <20220821113519.116765-1-shmulik.ladkani@gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Mon, 22 Aug 2022 11:06:31 -0700
Message-ID: <CAKH8qBtFkU1CoHx+eC+fHz+VdDvua-Se3_uAVU1bKQEZcCvr6g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/4] flow_dissector: Allow bpf flow-dissector
 progs to request fallback to normal dissection
To:     Shmulik Ladkani <shmulik@metanetworks.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Aug 21, 2022 at 4:35 AM Shmulik Ladkani
<shmulik@metanetworks.com> wrote:
>
> Currently, attaching BPF_PROG_TYPE_FLOW_DISSECTOR programs completely
> replaces the flow-dissector logic with custom dissection logic.
> This forces implementors to write programs that handle dissection for
> any flows expected in the namespace.
>
> It makes sense for flow-dissector bpf programs to just augment the
> dissector with custom logic (e.g. dissecting certain flows or custom
> protocols), while enjoying the broad capabilities of the standard
> dissector for any other traffic.
>
> v2:
> - Extend selftests/bpf/progs/bpf_flow.c to exercise new ret code

The series looks good to me, thank you!

Reviewed-by: Stanislav Fomichev <sdf@google.com>
