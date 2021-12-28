Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701CB480B0A
	for <lists+bpf@lfdr.de>; Tue, 28 Dec 2021 17:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbhL1QCl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Dec 2021 11:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbhL1QCk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Dec 2021 11:02:40 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E43C061574
        for <bpf@vger.kernel.org>; Tue, 28 Dec 2021 08:02:40 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id e25so11817852qkl.12
        for <bpf@vger.kernel.org>; Tue, 28 Dec 2021 08:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=LdJbTsYE2VlEdMQ3nKoisYvCn4Ffs0ZzaWiEyEYi640=;
        b=WlUB01jDwCBL3saCYlQLLo1tw9NlZ7v2nZ614q4sOZOnE13kHNw7jPB3cQfu+r2MCD
         B5e5xuezqDCVGE4NdBDg5/CzDEwBwx5euyigMYwmXMCnWbvfjT+g2VNql6DvUhItA+uN
         M3SqdljLfCVzHHov1BfCUg2VcB6K1TznMVf4x3L1Z8wkuk9N3Zm855kUbDPvA4nGHgff
         uIAo/R5bbQvTu/A8X1ROI2d4VBA4OyTDv7XRj/HgSxX/ENP+XVvajbhVQIAyT+HNSrQt
         PmiOqPdre4BsDnpP/Q78vAZQNrbws3lL9ee3yLmsCQNON+3r/WFei9z0bkyses0S4LwZ
         J1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=LdJbTsYE2VlEdMQ3nKoisYvCn4Ffs0ZzaWiEyEYi640=;
        b=rDm3tqDIHegaCa0oVUjaKuso+lRsyVb5S9z74730D7RninzGN7peCGUgXmg1BMfNwG
         JB5vfTRIZXq3/xIK4hPo1eeNC+YUvkiTiKFPcVpxRxfBXWucM132zVJyKHXpUY7gbMFU
         xuyulBSozMXeyugZ/QX2onwDelsOkROMOFAuLEnhLazvGWSeTqcemGDeSf9btj/9v94o
         Ty6kpIDibfDVNOwt/5OMkDIe+QfE32rMewtmv0NE6ZgYHeeBRUigwr1Ya+G6eE+84jJR
         WCEWR+xBW8YkA8CbBwRA6yP+OJy0Mx/PDJuXTRKa6m4wGC1jrPQHzJIAcjssx5B8pwKi
         WoJw==
X-Gm-Message-State: AOAM532/+oIGkhdkBbNN4lW9lqJjZ1TN3mDpKbTd8MUTDA1gkUxbbJr3
        DYb8QZfOyA8gFBghx2sTOk2RwgvLDGfPsGVSuZu4BOMWErc=
X-Google-Smtp-Source: ABdhPJz+tYg+7WmOYG4I2xBLknAL2C/CjZ/4TVlozrCPMPY8nW5+fsLORx96eRIEtByE5pPByD3YhcuKY/jMKm0PV6g=
X-Received: by 2002:a37:668a:: with SMTP id a132mr15625278qkc.460.1640707359243;
 Tue, 28 Dec 2021 08:02:39 -0800 (PST)
MIME-Version: 1.0
From:   Huichun Feng <foxhoundsk.tw@gmail.com>
Date:   Wed, 29 Dec 2021 00:02:28 +0800
Message-ID: <CAFbkdV3Bj=gM0dd6LBaXyc-V79Y0Ewy7xKF5TQT_6H0sCpxE6A@mail.gmail.com>
Subject: Adding arch_prepare_bpf_trampoline support for aarch64?
To:     bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jean-philippe@linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Jean and the list,

Attaching BPF to fentry/fexit hooks requires
arch_prepare_bpf_trampoline(), which
AFAIK has only been implemented on x86. Is there any related ongoing patch for
aarch64?

I've found a discussion [0] on this, and seems there has no further discussion.

Any thoughts?

Thanks!
Huichun

[0] https://www.spinics.net/lists/bpf/msg35573.html
