Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1AD9427D79
	for <lists+bpf@lfdr.de>; Sat,  9 Oct 2021 23:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhJIVFu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 Oct 2021 17:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhJIVFt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 Oct 2021 17:05:49 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621DAC061762
        for <bpf@vger.kernel.org>; Sat,  9 Oct 2021 14:03:52 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r7so41304028wrc.10
        for <bpf@vger.kernel.org>; Sat, 09 Oct 2021 14:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LAOJ1AHRRDLL6eWsA55YUP3f8oGWJZG8+6FBDsGizCM=;
        b=YNPLzvje/y5/DaKdnlX+fiIqU3kJ3mDVTkb9UADsDzWNAxy+8ChrjXLEO2hDBIhZsK
         tLAKNIDV1wHJejJAXBivcRsyB2HoUGUcrKRuNk6ir6rhTU0e++UQ4wXM/ZJ6TojZG1uo
         Uh1Jb2/iZG/EffoLPtldtdZjBHCbePnfqyi3Fhib5K6B6aTR9Vl4xbAch1b9lTwXf7XL
         hNLoX8BBWVv9iWpjxvirvSD/Lc1o9a0a6Coyif/FGcvei+kUy4w9WK+UrBqBUYMCBkg4
         We9HeeXDXQdZg80A8YRbGaxlMXtEAQsWOLxcc7mOG2ltIptOmxgm3V/9Ct0SPJx+FO7A
         q0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LAOJ1AHRRDLL6eWsA55YUP3f8oGWJZG8+6FBDsGizCM=;
        b=PwhLvODUmVRIRv7dCR6bvGg+sJq5mrWCv6paINuI+91MNCJTtauI7r4HQ5FeJnMLMJ
         b6np54rYcVsKL3ODPX+sWhjP1rWP4tvPPsdHYJCBYDfKeW4aouSWVIFRQ2/v+t/Z2igq
         McFO0mlRPBBmSmiBKl/Lkv8ifXi3mUbK8MNIRaYOVy7ARzspUUfEAoAUYrP/GxZ6uLYf
         xD9VrQYh/Nk+sTyrtSbJ5Sycivl1MnaKRC/cSJ/Xm3eHXN1opDPSoTD1NRk0G7mqIX50
         /6aT+XPMnNlmxs9IUmTzPlRxOiX1lc+wNAM4pExKms2lAI9gIiVV9CZ8v7P0vVBclxm0
         uacg==
X-Gm-Message-State: AOAM530lJM6xywf9PheiejXydJHXNvNXgKZ0QtlgWvpJ2N6wILolBLpF
        gNnMdFiz+ChAZkBAeyYh/AzAgw==
X-Google-Smtp-Source: ABdhPJziGg4/yjS+Gb+WWI3Mrd9lsuMMYjhiNuDBNhgOFxZsyCTH2bXS4/3WesCSAGD0d38grEzaZg==
X-Received: by 2002:a7b:cb8c:: with SMTP id m12mr11456342wmi.77.1633813430437;
        Sat, 09 Oct 2021 14:03:50 -0700 (PDT)
Received: from localhost.localdomain ([149.86.83.130])
        by smtp.gmail.com with ESMTPSA id k128sm3102516wme.41.2021.10.09.14.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Oct 2021 14:03:50 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 0/3] fixes for bpftool's Makefile
Date:   Sat,  9 Oct 2021 22:03:38 +0100
Message-Id: <20211009210341.6291-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This set contains one fix for bpftool's Makefile, to make sure that the
headers internal to libbpf are installed properly even if we add more
headers to the relevant Makefile variable in the future (although we'd like
to avoid that if possible).

The other patches aim at cleaning up the output from the Makefile, in
particular when running the command "make" another time after bpftool is
built.

Quentin Monnet (3):
  bpftool: fix install for libbpf's internal header(s)
  bpftool: do not FORCE-build libbpf
  bpftool: turn check on zlib from a phony target into a conditional
    error

 tools/bpf/bpftool/Makefile | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

-- 
2.30.2

