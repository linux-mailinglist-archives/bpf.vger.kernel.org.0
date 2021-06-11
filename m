Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B133A4B53
	for <lists+bpf@lfdr.de>; Sat, 12 Jun 2021 01:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbhFKXo1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Jun 2021 19:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhFKXoZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Jun 2021 19:44:25 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB078C061574
        for <bpf@vger.kernel.org>; Fri, 11 Jun 2021 16:42:24 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id g20so6942280ejt.0
        for <bpf@vger.kernel.org>; Fri, 11 Jun 2021 16:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=nTnvZhkYBPXv7koUhSfqYSHID4duNnZcEkm3JR/7EIg=;
        b=TCkyqFMWlWkh9QGouEAaKmC822Qg2eJOvw3miWXpi4yNe2Mrk+rwH7n/bZEs1inYuI
         vNa9oFdBOwBoIdhiR2lue8YFL8XxjSkS14XMO9tody2w6Kt8L8YJnT+f0najk1NAvjUS
         VVm/OWWVHV1/TN14xx+w4sT0bOkY5Skava7J3MHPax4S314q2h0Pr56YuMBo/WPTkEos
         oqATCc3+9FsYIDo96DPm64jcuN/5WRvg0JCl3ObSkGDri9wWxcnEC0ZTM5ZjxyEX+oYL
         DqtKhFxyih8hHqu2kjmqFewLd3U+JB2MdWkmIZMNSLNYvYz6RhNOrAPaRYaoXfSVGK0M
         uITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=nTnvZhkYBPXv7koUhSfqYSHID4duNnZcEkm3JR/7EIg=;
        b=F2uIwsvlvJmqxUgOQQICpkKlXVMHWmCNBP53bO1KI+NkT1ar4YR1cVVQoYkwGiXgg5
         umOjg4RXLMVnB/GS4UAEEFi8kqC/74z5zLzT1xMbVG7zBs1Vnsw4yFIzL96zGPxSguba
         WPAEcNff78Y2BIBH0adQ/tjltvONloEbYRESdyGyFQnDrGjWCroGVR976zqar37oH3pd
         pZxhJE6uGG+VKV1uiy3yQwdh6uAXfn3KGYD3nJfrCxxOuOzSQ61yucSXRmHE6eCXKaKH
         p25B6KN3m5UlPOvtV/l7/37N+yzHXyMHJ8cBiFS3wS/PeTj5c/K1bVLg5W0quZV3RxU2
         qGVw==
X-Gm-Message-State: AOAM531oArLtItfo0N7n/GI7LVmm7T08ImYdx/ujvCFOpxpcwvJH5eWv
        0KSWxpqq+otVFDtasTGcqyKnrmOqbeJScfoXYxt/XuUXxhA=
X-Google-Smtp-Source: ABdhPJzSmW6AbKonhta8Ze5AuailVnLqvchWVsDfxe60lAfFIArok8phxcOa/oHsY9rVaeAqK01iPXHXGQRT2NwUMDc=
X-Received: by 2002:a17:906:2bcc:: with SMTP id n12mr5467006ejg.430.1623454942912;
 Fri, 11 Jun 2021 16:42:22 -0700 (PDT)
MIME-Version: 1.0
From:   Vincent Li <vincent.mc.li@gmail.com>
Date:   Fri, 11 Jun 2021 16:42:12 -0700
Message-ID: <CAK3+h2xbezoB_8tCo7zytxpZYDcS9AoNi1q3cLHsMyAdbgxi=A@mail.gmail.com>
Subject: bpf helper to set skb src/dst MAC?
To:     bpf@vger.kernel.org
Cc:     Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I am completely newbie to bpf, I am trying to change skb destination
MAC for cilium https://github.com/cilium/cilium/issues/16503#issue-918040655,
the bpf build went fine but appears having problem to pass the
verifier at bpf load time, it is beyond my skill level to trouble
shoot bpf load issue, so I am wondering if a bpf helper to help set
skb src/dst MAC would make life easier for newbie like me :)

Regards,

Vincent
