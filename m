Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54AEF3FD7E9
	for <lists+bpf@lfdr.de>; Wed,  1 Sep 2021 12:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237192AbhIAKoj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Sep 2021 06:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237132AbhIAKoi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Sep 2021 06:44:38 -0400
X-Greylist: delayed 417 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Sep 2021 03:43:41 PDT
Received: from forward107j.mail.yandex.net (forward107j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB45C061575;
        Wed,  1 Sep 2021 03:43:41 -0700 (PDT)
Received: from myt6-ecec3fffc7db.qloud-c.yandex.net (myt6-ecec3fffc7db.qloud-c.yandex.net [IPv6:2a02:6b8:c12:4681:0:640:ecec:3fff])
        by forward107j.mail.yandex.net (Yandex) with ESMTP id AE866886488;
        Wed,  1 Sep 2021 13:36:40 +0300 (MSK)
Received: from myt3-5a0d70690205.qloud-c.yandex.net (myt3-5a0d70690205.qloud-c.yandex.net [2a02:6b8:c12:4f2b:0:640:5a0d:7069])
        by myt6-ecec3fffc7db.qloud-c.yandex.net (mxback/Yandex) with ESMTP id 1fZrkdnbPm-adH4Jkep;
        Wed, 01 Sep 2021 13:36:40 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1630492600;
        bh=bJRqLiOEp8JXTGlpq3+JJAn5wnhGgMPYEfxoudaUc8g=;
        h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
        b=DwvxWzy8/FIiSbgtrncqM9p7Q32h5dWjPq1krdFgsqH/bnpE/scvmCLeuVHPVscxQ
         sGsDwCTvss2J0yq2kkjk2TMtVqWLK5+rtiiC56H31xhJ/ZQ0rT50fnjGPgKTx3YzLm
         Hu/880HcH/uUoaFfHCg9GdodZhTtlR/omQ1vnMMg=
Authentication-Results: myt6-ecec3fffc7db.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by myt3-5a0d70690205.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id Z5XXDbYXRx-acB8hfbS;
        Wed, 01 Sep 2021 13:36:38 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     atish.patra@wdc.com
Cc:     alankao@andestech.com, anup.patel@wdc.com, bpf@vger.kernel.org,
        daniel.lezcano@linaro.org, guoren@linux.alibaba.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        mick@ics.forth.gr, nickhu@andestech.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, vincent.chen@sifive.com,
        wangkefeng.wang@huawei.com, xypron.glpk@gmx.de
Subject: Not compiling with CONFIG_BPF_SYSCALL enabled
Date:   Wed,  1 Sep 2021 13:36:34 +0300
Message-Id: <20210901103634.26558-1-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528184405.1793783-2-atish.patra@wdc.com>
References: <20210528184405.1793783-2-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello, Atish.

The above series won't compile with CONFIG_BPF_SYSCALL set:

linux/kernel/events/core.c:9912:18: error: assignment to 
'bpf_user_pt_regs_t *' {aka 'struct user_regs_struct *'} 
from incompatible pointer type 'struct pt_regs *' 
[-Werror=incompatible-pointer-types]
 9912 |         ctx.regs = perf_arch_bpf_user_pt_regs(regs);

Just informing you - hope this is helpful.

Yours,
Nikita Shubin

