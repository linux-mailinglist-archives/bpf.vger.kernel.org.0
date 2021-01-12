Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3339A2F3278
	for <lists+bpf@lfdr.de>; Tue, 12 Jan 2021 15:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730437AbhALOCI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jan 2021 09:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730124AbhALOCH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jan 2021 09:02:07 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461EAC061786
        for <bpf@vger.kernel.org>; Tue, 12 Jan 2021 06:01:27 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id b2so2424652edm.3
        for <bpf@vger.kernel.org>; Tue, 12 Jan 2021 06:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZiuFHB0WsN+gRbC8OTVe9py28UNmf6FiXJPro5M6bjE=;
        b=qFIiKr5oesh+IVtPeybtrNvfu6BP7U879JZvvxTT1RrVIhAQ2lsHckogDBFKa+UAwv
         dMyp6yk9roNcBA186JR0pLuDyUxP3rGxCvqTyJRDjvp1zj8e2WoAY+A9qE9OX0pXSCzn
         GnVbnXALtp9I+P5C9StGAezoOXhMuIy3SOki5JMuf9CF2lR4ek9ADQJlvVs72EOOPpka
         hNKUyyZcX0pO1aDQpLxocqoCCmbphp0ncrewGQmtaNrbgfmMKt44770GuewpiaSSi7a8
         JC/iqhra1AIJqlCb83XqUjmeEO1+1ZC0TzjfCWl7NxXavxz4zn/IN/VqlwwmNQtcdywr
         nSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZiuFHB0WsN+gRbC8OTVe9py28UNmf6FiXJPro5M6bjE=;
        b=j6CwGb3RJHogTPw1fQhey1YIHxm15T1hWsNN3mR88ssTKzmcXv73A4bFheOKt+uUrZ
         g7bLhpob2hctvi2liun64X5jspoGH4O60ywOp6ZQfDicmAz6lQRcJtO5OOLkRkm3jgdN
         dGHiA/nig06kFV/K9Emioh1cwHQg6ZMS8InzwEe2kWm/LoehpNr76NOGhGo2RDYLx6GG
         6f8ljEtVmWbGY0d1NBdTgn3bXNPPyuCqQvzSaiOxjsiVXqch08Ys4+AlUG2bqKmt8hAE
         cWAZfkGmzQZZz7HdUETjKroL4OY9iXaeULBwCRJy6C8+SMvoWOsZeEnYycmQyDpgN+i1
         PB0A==
X-Gm-Message-State: AOAM530tTvM2gGwB3AQhckO6CtpYmniYVAaqluvzSdQ9zvmclL0aQjOZ
        c0zKDDL0U66zb6Rbgxrbqsap6dud7Uzg9Q==
X-Google-Smtp-Source: ABdhPJxE8DxYmMrrRn9w4FKuoXGyJg1ojDZecw1ZcMFlHVMXoJnleDguzRfx4oKMjSuQW3ko5F2aLw==
X-Received: by 2002:aa7:dacf:: with SMTP id x15mr3479477eds.134.1610460085481;
        Tue, 12 Jan 2021 06:01:25 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id t19sm1227846ejc.62.2021.01.12.06.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 06:01:24 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     bpf@vger.kernel.org
Cc:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        linux-kselftest@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next 0/5] selftests/bpf: Some build fixes
Date:   Tue, 12 Jan 2021 14:59:55 +0100
Message-Id: <20210112135959.649075-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Following the build fixes for bpftool [1], here are a few fixes for
cross-building the sefltests out of tree. This will enable wider
automated testing on various Arm hardware.

[1] https://lore.kernel.org/bpf/20201110164310.2600671-1-jean-philippe@linaro.org/

Jean-Philippe Brucker (5):
  selftests/bpf: Enable cross-building
  selftests/bpf: Fix out-of-tree build
  selftests/bpf: Move generated test files to $(TEST_GEN_FILES)
  selftests/bpf: Fix installation of urandom_read
  selftests/bpf: Install btf_dump test cases

 tools/testing/selftests/bpf/Makefile | 61 +++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 15 deletions(-)

-- 
2.30.0

