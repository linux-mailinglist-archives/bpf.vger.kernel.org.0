Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50BD440516
	for <lists+bpf@lfdr.de>; Fri, 29 Oct 2021 23:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhJ2Vxb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Oct 2021 17:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbhJ2Vxa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Oct 2021 17:53:30 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE24C061714
        for <bpf@vger.kernel.org>; Fri, 29 Oct 2021 14:51:01 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id a129so14464327yba.10
        for <bpf@vger.kernel.org>; Fri, 29 Oct 2021 14:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=f45ca7gZsYUq9gSRTvBzdUMqmFEDIrmlxlYEV3iWKMI=;
        b=KZUJSA1CzuqSmitLBKlG6oGOrQKiX8PJhsL9l5+cjYRwL2rsRn2qXGXqhYX4GberDq
         g5fVDpXTHWmv2Dqv429DHY4Lv7iFFFEFDUYmDDNel7VKWT+K2I+HYMHczCWcBAJ6nbmg
         UiDKQq3gFucePW1ZpMQcSDGKhafry2xauRY4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=f45ca7gZsYUq9gSRTvBzdUMqmFEDIrmlxlYEV3iWKMI=;
        b=8LIq1/maRDGhud8neOZH7B18WDeC7IK8fpMycOlnhpeN7g36fg3HC1OJnTt6ms9Kqy
         GTMhxVGDTb/m4kftS8U1jaKRTE2CqFf1PTKtRYuZRIe5bhgF8v3doMu26pEU0tsS59c0
         OmbeWErxfT3v4dqnE1c9uiyWJDEDTmYEPZslMWUF4K8epcFa28QnsZnZrZMvY18l/r+J
         uD+PQDOLV+N1LU51JFwmQQ/lw+PTSRWTHNiHm6FoWIgAXbOxG/K7GMmhN+62K8xZVW0Z
         f6UlX9VteRn4uARxhtO5q3kxDeWhkkVEgvDtw+KAPxulKIuZSd/IWeKbIF+RoSY7KjVm
         Ia5A==
X-Gm-Message-State: AOAM532an0bj/ECx08TT0a/8roc8lqwJFH7uSWf/gWey+4iN5SGZLUIv
        VmBrc9vOFweyxIpZN/J5dbYN8ig3kYHpasfHZp+maw==
X-Google-Smtp-Source: ABdhPJyw9Z7BARzXvRT+zclB1btIUWYPoyEPcAyeHcSKWNYtIqPHF9UeecN4n/XIYTPNo4W8ptaIzgTdvSx2ATugPTU=
X-Received: by 2002:a25:8882:: with SMTP id d2mr15187283ybl.68.1635544261081;
 Fri, 29 Oct 2021 14:51:01 -0700 (PDT)
MIME-Version: 1.0
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Fri, 29 Oct 2021 14:50:50 -0700
Message-ID: <CABWYdi1XNPbCHfR7-8NiSnjNG4cCy=KTHPKcHiDYp5E-0F2g0A@mail.gmail.com>
Subject: bpf, cgroups: Fix cgroup v2 fallback on v1/v2 mixed mode [backport]
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     kernel-team <kernel-team@cloudflare.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Stanislav Fomichev <sdf@google.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

We have re-discovered the issue fixed by the following commit in v5.15:

* https://github.com/torvalds/linux/commit/8520e224f54

Is it possible to also backport the fix to 5.10 series, where the
issue is also present?

Thanks!
