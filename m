Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281DE578BCB
	for <lists+bpf@lfdr.de>; Mon, 18 Jul 2022 22:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbiGRUcD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jul 2022 16:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbiGRUcC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Jul 2022 16:32:02 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67ADF2E9FE
        for <bpf@vger.kernel.org>; Mon, 18 Jul 2022 13:32:02 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id y129so4895828vkg.5
        for <bpf@vger.kernel.org>; Mon, 18 Jul 2022 13:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=2X8HXtEcU/ZehxuPCgIPz4aOGr6MXTRGr5kvCe3jveI=;
        b=BAWevL1oTFqeL4HBmDnDjgUHKu5kU2mpbjNfRo2QhXoNXfzZRT2z3Mxu/HyWm5WSJb
         zfhW61QNOmcDV7Q4S5oSn0M2AWn1o5P2GVV7yJuX3ETMcA1HRJAy49tMRjYpeFK8yoO6
         SIqzErmNqmzWsiQmbjqUf3fewrpDUmSE60rfqviZwA35DlQAMFZ1P9vHPWao9f6abXuw
         4t/TVnGSds+nMSR6wxjd3IzWishO+CsKGna3O2hoAkj/TZyrBtIslzqp5jE8LKEzME9f
         0mjIDrYzG5VIvpXaV14CeeR/DBYHRVVybcUqsI80+KTcCvHCvULwtkNSdEH8tDoxdbMT
         F77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=2X8HXtEcU/ZehxuPCgIPz4aOGr6MXTRGr5kvCe3jveI=;
        b=U/7N0tYEGCy6wJMJcKd1/Xxs242r+ddxUh7B5GI/ULK0ljx2CJqovq8GX0B0r/t+sj
         ncRmZpj0jOUF9R2EpmhMthncsl9roGHywSxfT7K/X435oKMkaMEJlJJv/DEvljSnH2Uh
         COqiAOQh9NEhwRDbBYAJZeLQQYYVqcIsXA+CCRh8dUvFAJzvKN6sOZwIjLVDsDFabhw8
         CHIS93DRLOu+EcOLvNyts0NXj6qJ3GSFdjmWWEYn3DYFUucYg8u/Cw8hxeU5Kf42NSog
         ES6BzVTAEPhIqACcAqZTSWaxuy6DQ1RMco08s1Bp3ZDZVw+NlfkpXR8K1SjTqhrJ2aF6
         ytPw==
X-Gm-Message-State: AJIora8JZVLD3dJi6PAQaUq2cTpO8n+w+GjYL15ooHlyeZL2ZI011F0/
        jJw/sn4BecHWRtAdYXg8yOIEIu3/KWrYn+3Wg+k=
X-Google-Smtp-Source: AGRyM1uncRbLH9veVTew+F3XCdk2zJY4dlcPeE7iFWE1O7PPOdrt47H2FX4XP+VS9cS7/YySdecVdPrZegv1XrHDEd0=
X-Received: by 2002:ac5:c9a2:0:b0:375:6e4c:f2d5 with SMTP id
 f2-20020ac5c9a2000000b003756e4cf2d5mr4110338vkm.30.1658176321592; Mon, 18 Jul
 2022 13:32:01 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sgtkaylama@gmail.com
Sender: ouromachi@gmail.com
Received: by 2002:a59:b68b:0:b0:2d1:45b0:2ea5 with HTTP; Mon, 18 Jul 2022
 13:32:01 -0700 (PDT)
From:   sgtkaylama <sgtkaylama@gmail.com>
Date:   Mon, 18 Jul 2022 20:32:01 +0000
X-Google-Sender-Auth: rGZL_SPdlA7xsUlbAc6-ds88K50
Message-ID: <CAJHYYr1SYyCBf7x=SaUQeq4twhpyv8MwSTdRAdAYFd6FT4E4_w@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

5L2g5aW977yM5L2g5pS25Yiw5oiR5LmL5YmN55qE5Lik5p2h5raI5oGv5LqG5ZCX77yfDQo=
