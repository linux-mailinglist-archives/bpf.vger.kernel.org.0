Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD25034DC54
	for <lists+bpf@lfdr.de>; Tue, 30 Mar 2021 01:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhC2XOd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Mar 2021 19:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbhC2XOZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Mar 2021 19:14:25 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085E3C061762
        for <bpf@vger.kernel.org>; Mon, 29 Mar 2021 16:14:25 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id k9so6246665pls.13
        for <bpf@vger.kernel.org>; Mon, 29 Mar 2021 16:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WbL6Dgfv19ESq2vhoguN8WYq0PGt7TcFwh49HZU1Vnk=;
        b=TOqTuyiHfp2Aqk7WL0/mNDmMzhSLqR57xlz0CAuGb59fOx4jh2t1vko3NDpvI1RLWJ
         zlDo/lCw91stJuMp9dwD+ilY8Cis/u/W42atyls7P9walbfMlZicdmKteVrDxC2ZRbhE
         knDOW+HGg9VqpXnaP6GrPrPPuDn88ECZhA1eLusbsRAcyMjFm58ryHcTaSYz0Ewe62PF
         TFjx/LVd8hBOrjQJqwirEwqSC0HfIqIkmOqJggh+RVM7P6cajq3GfSbPvBXTaHqWGtAi
         SFKk68Q5o7v4NBp8jKRG4OamYYdOvZ0lkNOwlvvL5zcza4uo7wFlm2pjN+rqL+jkRDTZ
         CO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WbL6Dgfv19ESq2vhoguN8WYq0PGt7TcFwh49HZU1Vnk=;
        b=ngDn0Sp30sIa2Ds3WPaPvz6EcuvlTl4oJ3EmKRMYWDyVe1LsGsf/qFRT7QiO7IijMX
         jDi5nuHNO9qY24/gZBaaM3HtVzdXgPq+BQXz2RMPWjuI2OmuJtFMqOIfV41pMI+EPeaZ
         BMCLNvc2PkPPAtshqI3iQbxs8LCXMgpYN6S6cCEvSuCq15W59v5ftpAT+iUssv/hDl7Y
         tAJnv22DvJy+0stmaPOENF0Tq7Sy6Yqv62zjcUmj8USr9mh91TTt3yAbWti7hbNSLYqJ
         VSRtSZhhVDrRmiIN6+3qOdb9vMS3pwboHm05Jnmx/bm6/aUWgCziTxcY6sA19dvqB74s
         oc3A==
X-Gm-Message-State: AOAM532HhHIwKYj9yyMEFvU91HU958h7DbrvjvPER12tMM/aQtMuHfg6
        JfwsyqsfRffenidDU79UX92rnB10eOJoLRBKuyA=
X-Google-Smtp-Source: ABdhPJwHfu5lvMjTOoU4epMJ9aoCz9WkzjdHbVwDMn+v7xRX0vlVTbYjEFG1KbexjwV+Wz4CcRMJLBV7xYUgntayCtk=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:c959:2751:3fb4:47b1])
 (user=ndesaulniers job=sendgmr) by 2002:a17:90a:4d81:: with SMTP id
 m1mr1356657pjh.143.1617059664444; Mon, 29 Mar 2021 16:14:24 -0700 (PDT)
Date:   Mon, 29 Mar 2021 16:14:13 -0700
In-Reply-To: <20210328201400.1426437-1-yhs@fb.com>
Message-Id: <20210329231413.1971368-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20210328201400.1426437-1-yhs@fb.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: Re: [PATCH dwarves v3 0/3] permit merging all dwarf cu's for clang
 lto built binary
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     yhs@fb.com
Cc:     andrii@kernel.org, arnaldo.melo@gmail.com, ast@kernel.org,
        bpf@vger.kernel.org, dwarves@vger.kernel.org, kernel-team@fb.com,
        morbo@google.com, clang-built-linux@googlegroups.com,
        sedat.dilek@gmail.com, Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

(replying manually to https://lore.kernel.org/dwarves/20210328201400.1426437-1-yhs@fb.com/)

I didn't validate or try to use the produced data, but with this and the
kernel patch
https://lore.kernel.org/bpf/20210328064121.2062927-1-yhs@fb.com/

I was able to build a x86_64 defconfig + CONFIG_LTO_CLANG_THIN +
CONFIG_DEBUG_INFO_BTF without further errors.  Thank you for the series! FWIW:

Tested-by: Nick Desaulniers <ndesaulniers@google.com>
