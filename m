Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70B7613F5C
	for <lists+bpf@lfdr.de>; Mon, 31 Oct 2022 21:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJaU6Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 31 Oct 2022 16:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiJaU6S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 31 Oct 2022 16:58:18 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD55D12762
        for <bpf@vger.kernel.org>; Mon, 31 Oct 2022 13:58:17 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id f5so10964696ejc.5
        for <bpf@vger.kernel.org>; Mon, 31 Oct 2022 13:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQx//nIMTXIuGES5wdU306SDyqo/9GYHWGhMmpKB5Ag=;
        b=e5272JioVc8AX9ah4Vm+c6IajPduF5tBa7LS3reBHR9atOCrYHL/QcTZcDFzG83ZNF
         158QLDZOd22Zhr0q1pULMz625ldVs5aAGUNzMNf6luYaCgyOLh96vUWg9fUprVhqism2
         9dzsmSnMg/WX6+2VTUNqBdG04TxEjj7bNFmhG11uk33rsJdTH0grthLL62bSW/8l0QbP
         RXa2BpAcni1bP0rb/dD9JNB0Ol49h76gXd62JTq/ZImD/hJTmcvuBmGWtN96orEEl+z2
         P/K+yGbTQqNXImC7a++pJoVt4JCwMc69LE/NzDdm2QS33zD5lyJi434Aag9dJXjloIeh
         8bBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OQx//nIMTXIuGES5wdU306SDyqo/9GYHWGhMmpKB5Ag=;
        b=SJPWO1s2WB3OeToFrOPfLsXoz9Ktqll0DeRQv7anVsmojIVzf0NB762msRGZgvOh4J
         JeIEjKNxw1ANoFbpQpfSmL0U3b6eMXWtEA9YqnodayJN1pde1d1eqeVx03hxW+a/p1a+
         EOpLtpFMXAe0rbZAFF9ZMrUWgsTdIFAZJjiUvL7SbD5u8LT8dnM34L/nHhRfVjDjxPhy
         pv5Vq5M7eCxvrYkVtqhdmzTgSB11L80p2la7bvnsIOFEtxVcRZOl/9JYPegQw10aI3mq
         he8TherVuJ/3hlaaUkeuFb3gu+9dolZGZ1hlwhp6K3qtf3UMlfuo7x0Cfc/wAHOlqx6W
         Ubtw==
X-Gm-Message-State: ACrzQf1+zzC1rkVwqgUfSDdjFW8Px9XqgJb8PZrR0hlPPr49e7BSm2ab
        scwiov3opMsJVlFqPL73vSuqwv3hQlRyFxa1fo4=
X-Google-Smtp-Source: AMsMyM6Qy8ubU8j6CJWeGNuf/oxhUxbKHsWIdh8bubIiHz9BkbmU0gt0T8eMSpyVVWdQdwC8P+KAi1vGLAmrHeVuJQM=
X-Received: by 2002:a17:907:8a07:b0:7ad:e111:9f1f with SMTP id
 sc7-20020a1709078a0700b007ade1119f1fmr3969209ejc.748.1667249895997; Mon, 31
 Oct 2022 13:58:15 -0700 (PDT)
MIME-Version: 1.0
Sender: samiratou7105@gmail.com
Received: by 2002:a05:7208:8330:b0:5c:e834:9e68 with HTTP; Mon, 31 Oct 2022
 13:58:15 -0700 (PDT)
From:   H mimi m <mimih6474@gmail.com>
Date:   Mon, 31 Oct 2022 20:58:15 +0000
X-Google-Sender-Auth: bz3mspPxuuDXuZP7RevsCwktXGw
Message-ID: <CAH+LWNMTosTZE0QKp+PrOQapbuRBhF08uhMM+mZjXEOEhwLt0w@mail.gmail.com>
Subject: I NEED REPLY FROM YOU
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

i am Mrs Mimi Hassan Abdul Muhammad, and i was diagnosed with  cancer
about 2 years ago,before i go for my surgery i  have to do this by helping the
Less-privileged, with this fund so If you are interested to use the
sum of US17.3Million that is in  a Finance house) in  OUAGADOUGOU
BURKINA FASO to help them, kindly get back to me for more information.
Warm Regards,
Mrs Mimi Hassan Abdul Muhammad
