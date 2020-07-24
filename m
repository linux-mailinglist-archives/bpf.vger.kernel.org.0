Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B7C22C1A3
	for <lists+bpf@lfdr.de>; Fri, 24 Jul 2020 11:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgGXJGq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jul 2020 05:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbgGXJGk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jul 2020 05:06:40 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A5DC0619E6
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2020 02:06:40 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r4so4648292wrx.9
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2020 02:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YflWa3w8Y5oTGYdnHuXIQRIDPp5Y24q+DCQaGq5dkSE=;
        b=Nxk5OLgH64H9CUtnJ45wu53Lo/7RCf6rr9KOe+69FciFgJ58b63821VXdUe9oHmBL4
         8xgOG3ajI2YzN7pAOQ+GqeXr6mSpeZxIxG7qZWqYVLbIBxS5r01LzVI+nW5fmAtpullx
         6w3trNFMcLEoV63gJsjxR50Sm9+jqksW82cI5vX3fIFdV3WVW8X5SmlL1jVmaePhtXoj
         bTAGl+JkY2gTcUDY0vxzc539Wd/h4wF/C6IggnM0k9UeAmsYcM4nhGFxxZe0J3sHz7zv
         AT4wXGa1asoSyMuTsJh5bD4TOpnwyfVCPIX9GTB6SkUeJaWqNluIxv1L3rN76LDNBDXj
         uylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YflWa3w8Y5oTGYdnHuXIQRIDPp5Y24q+DCQaGq5dkSE=;
        b=KeBScaltcHxrHF3PiRE6diT+Spckw+lZrVuNhLlB4g4i/p2OI08MLCqQv8B42OWLBu
         4l4e39PJ39jKptLNQ5u6Mz0JWWg1F6CtmzDaDFQ/NEAgnFDv18/tQES5t0UUfR5ZY2rT
         GlmSAQ+QwHqcYCzUhbTYVr5Qjhml5YZojL0CokAysa3RZbjYpoO63QiHXOi9WVceJuzZ
         7DUrNzk31TKmnVSVpbmFVmqMZE1d67eNdms+y6R7DtnronBxtBvq4htzlQRsU97AOfo2
         rAcb8AqbEKgnenx122bK5ClRGQAX6P1qJGr074lbEotzeNf7zSwXJTBF6UPFrLn4N1we
         EKug==
X-Gm-Message-State: AOAM533t9mEbzOtL0AQ/RR5utDj91i6DhCQNUFBR7WPOx1j3FfC4Fa0g
        271tmwz7SmuufnwlrVY1EzmCUA==
X-Google-Smtp-Source: ABdhPJwPKGwW+3QETZQ5Fsamse3ZXXCaPUYKm9kxsDR4+7dL+3LiJcgbhr31IfZ7Zv30HV7gKRMkfA==
X-Received: by 2002:a5d:4fc2:: with SMTP id h2mr7265176wrw.333.1595581597792;
        Fri, 24 Jul 2020 02:06:37 -0700 (PDT)
Received: from localhost.localdomain ([194.35.117.75])
        by smtp.gmail.com with ESMTPSA id t11sm527915wrs.66.2020.07.24.02.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 02:06:37 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Paul Chaignon <paul@cilium.io>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 0/2] tools: bpftool: update prog names list and fix segfault
Date:   Fri, 24 Jul 2020 10:06:16 +0100
Message-Id: <20200724090618.16378-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Although probing features with bpftool works fine if bpftool's array of
program and map type names lack the latest kernel additions, it can crash
if there are some types missing _in the middle_ of the arrays. The case
recently occurred with the addition of the "sk_lookup" name, which skipped
the "lsm" in the list.

Let's update the list, and let's make sure it does not crash bpftool again
if we omit other types again in the future.

Quentin Monnet (2):
  tools: bpftool: skip type probe if name is not found
  tools: bpftool: add LSM type to array of prog names

 tools/bpf/bpftool/feature.c | 8 ++++++++
 tools/bpf/bpftool/prog.c    | 1 +
 2 files changed, 9 insertions(+)

-- 
2.20.1

