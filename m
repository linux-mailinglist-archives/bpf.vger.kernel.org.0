Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23CF2F5017
	for <lists+bpf@lfdr.de>; Wed, 13 Jan 2021 17:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbhAMQfd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jan 2021 11:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbhAMQfc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jan 2021 11:35:32 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDF8C061786
        for <bpf@vger.kernel.org>; Wed, 13 Jan 2021 08:34:52 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id t16so3909121ejf.13
        for <bpf@vger.kernel.org>; Wed, 13 Jan 2021 08:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vk0czB5fF0aB6nd/h40en79pLBBtFj9eodoYDBiXDAU=;
        b=WEtPRWKe9Uj7QzJ4cVmdQFMSqEbwCeAOl9nAb42BQC28kiPXzigZBsn5zdHCitm07Q
         Qh2LqIZ3zQ1mxKSfj4VgpiaHFFeUvDZBwlSrK5dIIPAoOib3c0k+zFLvwxH/GIEjDYeW
         cgOGViSNs1ikmv/+U3EkS3Q7L1fCi9g09m4J53cFyUzMOSjTtBn2n7mWS3d0W/YPClaC
         zIGT7R7rfV+cGOGeFwRSp41kXye7WUXynl2kPJcbeoHvp82iUMuH/7sGddBeamUYJT8z
         KDhiHG9zKtpo+/mzQFdXNZKv787fGTumVsy3XQYmquW0qt07OiwQhOIZobRRWhGKNOO/
         0vaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vk0czB5fF0aB6nd/h40en79pLBBtFj9eodoYDBiXDAU=;
        b=EmvxyEHtvPL5JPnabSVmvGw5FPuIvNA17tRsQebtY8V5+tXlx5urAWe8QjJNI/Prtm
         +Anjx1JnKXsOd8t/R3IW6YVmaGXaKsGNJ2MRowens0uQilDZE+cQjRTHfstlmckV7J0T
         LY60ttXDQeiWgv1/VRzJU6dLwrL7JpStr+sf461zDcG2Yj0FhjV2Ox9+bC+mBU53Xcms
         15maLUB90yzvqlX67wkJR+lJKKTHkCQbRhwItBeQ1xuLkYzlaidttK2F6rkNDc+NAP4h
         WHcFMAgNRG9myOUX9Vpi3iGZRiJZVzeBSCM08xWyGU0DJI0YwdrKJawuuGvKM7T2jQ/Q
         180g==
X-Gm-Message-State: AOAM533nQh2DcCJ8pMzlt+uVCSWRhr/5Bnez+Ai9jkI4bqzD+EhbyeXR
        2IyJ3Zcx/5iPfBFzRX9TzpHnSUBkk9uPWg==
X-Google-Smtp-Source: ABdhPJxpH/hWxv0jQcdwu5UOjAudNzu6DdzryR6pfeS0p69At5FoN1LBoIjEg4nbx4Qmzse3p/vAgQ==
X-Received: by 2002:a17:906:a3c7:: with SMTP id ca7mr2234196ejb.523.1610555690828;
        Wed, 13 Jan 2021 08:34:50 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id g25sm923943ejf.15.2021.01.13.08.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 08:34:49 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     bpf@vger.kernel.org
Cc:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        linux-kselftest@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next v2 0/5] selftests/bpf: Some build fixes
Date:   Wed, 13 Jan 2021 17:33:15 +0100
Message-Id: <20210113163319.1516382-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A few fixes for cross-building the sefltests out of tree. This will
enable wider automated testing on various Arm hardware.

Changes since v1 [1]:
* Use wildcard in patch 5
* Move the MAKE_DIRS declaration in patch 1

[1] https://lore.kernel.org/bpf/20210112135959.649075-1-jean-philippe@linaro.org/

Jean-Philippe Brucker (5):
  selftests/bpf: Enable cross-building
  selftests/bpf: Fix out-of-tree build
  selftests/bpf: Move generated test files to $(TEST_GEN_FILES)
  selftests/bpf: Fix installation of urandom_read
  selftests/bpf: Install btf_dump test cases

 tools/testing/selftests/bpf/Makefile | 58 ++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 17 deletions(-)

-- 
2.30.0

