Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4EB85E605A
	for <lists+bpf@lfdr.de>; Thu, 22 Sep 2022 13:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiIVLDQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Sep 2022 07:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiIVLDP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Sep 2022 07:03:15 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4EBCF4BE
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 04:03:14 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id y82so12222058yby.6
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 04:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=Vj8lq5bktnIWqbJPOgXgNS7QYaeDegR+MXBvl/0VE+c=;
        b=DoZMq5Hy6wZ8bK/SP2Qkpvu7wE+Ise+vL5tbUr2uQoc/P/eMondlDWmTXKBghenTtY
         alOCF5zkScWZtqUGDw8elUb2Q05m1I3AciFioCUyvmn1ayMOuO/rp+7LR6Xv+MbFO629
         WHgXNjb+xAgyMJpfTZ18KLciqqTViCpnXW8TDnqHRgrrK37lhhQado6Onf0ZQRE41sJ2
         TKZk1Vgzdf1JJMz0UAxmyNfYHVWQcDBf2WmFwN2LiwBvNrBd7yKmHSRCEqR8Lj9tiWR0
         KrmOb7uEFEtr3Zdze1oSDasZtD+Ud7ukr0sJnAjBEK/Swa1MeD/IeMdOTULPoo3fdvo9
         dB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Vj8lq5bktnIWqbJPOgXgNS7QYaeDegR+MXBvl/0VE+c=;
        b=5hJzTcJNYRlIJ5xIwQvVyRoWvghu+afRopKQA2Hn+1sq+zvl5u7Fj3RyzQwNbptGtA
         3fRxpHDpRnaMKjbPNjlyVaCZ3qltWUzA3t81hrdXJTS8weuIvWdSzmBgbreCC3GS1PEr
         DjE/twEsitiu2IyPsT6391UMAA8Wtv4+edAP+Z+tQ6/G9J90TzYzyeHAPffSuKtZCFcy
         N+EtqBKKlkHboNJDu/uWTZapHLVjG2Upc0XoIjFxObNTzfO40CjDE4tp94eXTgGXesBm
         gP7w2pfvhjRPwRNZ78ONf4UuyDorq4dTzRYkds6WnW8myeNr0izmkLXBOzdZ9UUDuTsv
         bcfA==
X-Gm-Message-State: ACrzQf3BMVjjyVVYxIsLDyERECR/0P7fQHH98w7KpjAOZXCRCw7m073G
        QnlH4Ue6dETMBF0SFL30SSexIRQfz8IC1ASi014=
X-Google-Smtp-Source: AMsMyM5lUsYdLxwjbHDwgDqwbcJl22Eoqh7vz4QWBks6pZqRwy8xbZuBnJoSK6RrR6c3P3+8byiF3QQB3LBOqAjBdjw=
X-Received: by 2002:a25:1b56:0:b0:6b3:369f:745b with SMTP id
 b83-20020a251b56000000b006b3369f745bmr2963446ybb.346.1663844593261; Thu, 22
 Sep 2022 04:03:13 -0700 (PDT)
MIME-Version: 1.0
Sender: novnovigno12@gmail.com
Received: by 2002:a05:6918:1f0d:b0:dc:879a:2dec with HTTP; Thu, 22 Sep 2022
 04:03:12 -0700 (PDT)
From:   Jessica Daniel <jessicadaniel7833@gmail.com>
Date:   Thu, 22 Sep 2022 11:03:12 +0000
X-Google-Sender-Auth: hQ6MyEM7b3GzTydQG98JheJw4LI
Message-ID: <CADVVueVNuDMETEq7LXtg6=6KQySqy8_FjDO2BMPpKVjVGaveYg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
Hi??
