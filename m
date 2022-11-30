Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04AF363CD46
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 03:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiK3CWG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 21:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiK3CWE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 21:22:04 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFA631ECE
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 18:22:03 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id l127so17372773oia.8
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 18:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=juRVfNyoIGQSlG8so4jgNAO1W81kdptvIxICH3rKQwQ=;
        b=Wdz5pW+faPR9XZZjOlZNYbiJwXxSYanq3GyNPoJOapHNvv0AR33BQ+jrrMCv8m0T8S
         0zgbOshXgbSdJPI0+mh+3RlRSKGZ92p+36wkqdUrch+pPE22fW1uat13hub/3Ju7bz/d
         lNQt/aWI1m6tBA8NEgnrtMkKxu30dkwHOsuTnGOa0ogmhdw0FmzuKtiOr1vXMt57W/od
         6SyJTunaicXTs3NUTCNaBgQ2UsRGHlZs/CSIlgcnXQLdT7pE0K4OSgpB5/4BUDLhSDCT
         X/yRboZSO9dl4TJn1OB6I3IO4meZh8a2ZDpivxUclqEIMeM5ad84mkRk5KJ8z+Jq9gxf
         u3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=juRVfNyoIGQSlG8so4jgNAO1W81kdptvIxICH3rKQwQ=;
        b=asH9lpmuNnL8KNOxNkgoJgQMHanG5q3XcfkUY4G9AzMOHxmM+lApUo9mz4XSeqPBsm
         b3qYduDIbDDniDfrhJ/HjDO+braIJiaG9lmuP7ExKBoIYM1KWhnjFRCV0UVuHzwEWI98
         w96+ENSnMHLfrL4TLJK3IxE+w3MyFFgHgPhsop7PUsl9/W0srZB8gff5I2sp4UmHrt3p
         EJGgyl4QvEWyhSp4t7mcsmYgQ388x37iItulY1XDHqiECgk9c5f/MBdq99U0/1XMlLWN
         9er3urRVGeUgLYl4KVgQYAc7B1/mokkvlaNLgxQCh0kHXbjBTcrwTlA7XY6HVOCWFyJI
         abcg==
X-Gm-Message-State: ANoB5pmWYIOHu/cXErblsMcGb4Rb4Q3gQfVfhsjf+ZUZghjST9PehIGI
        tbxC0i0HFax53J4ESf38u3TGLkQenlDg+qah1J8=
X-Google-Smtp-Source: AA0mqf4+H0NhKA0L/0MsUhfpLrW3MHQMqxCxlkIYa7Q0dRvSwnBaxHmognbEKIgUGTPCJCglE4X9pUy3y4R2N1cs8lg=
X-Received: by 2002:aca:3355:0:b0:351:3e70:3a41 with SMTP id
 z82-20020aca3355000000b003513e703a41mr19319167oiz.211.1669774923025; Tue, 29
 Nov 2022 18:22:03 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6358:9102:b0:df:7b12:45c4 with HTTP; Tue, 29 Nov 2022
 18:22:02 -0800 (PST)
Reply-To: thajxoa@gmail.com
From:   Thaj Xoa <ayanounodo@gmail.com>
Date:   Wed, 30 Nov 2022 02:22:02 +0000
Message-ID: <CAGHdffOYHQGYrGV0HzPqmiWtEY1hDqAS1otR=csCNbO==QEoTw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
Hello,

You have an important message get back to me for more information.

Sincerely

Mrs Thaj Xoa
