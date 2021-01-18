Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520602FA580
	for <lists+bpf@lfdr.de>; Mon, 18 Jan 2021 17:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406297AbhARQCg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jan 2021 11:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405872AbhARQC1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Jan 2021 11:02:27 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F76C061574
        for <bpf@vger.kernel.org>; Mon, 18 Jan 2021 08:01:46 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id bp20so16955060qvb.20
        for <bpf@vger.kernel.org>; Mon, 18 Jan 2021 08:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=6AJvxUC3f3ekjGpx4m23PwJ8eHqdXCq0waSkIBAPiPQ=;
        b=KWWIFsI9l/jL3bzBh7CupqwdsM1/X+KzBf5mSfkx+eRTjQV8lMGyl+7xIxvuPzq38Q
         aP2nHdXI9MCZkU8iVj1l3iF+oYfgs5OKkD7mpz5xyV9qOkBFDqTM7hlSYt9M+kMuj6Ag
         USmpKNEqmTeoVgpfZmNRfcBSanBEeNKSWviNpnIjFO5WgkP6zsMcllgrdOvDZOp4+Whc
         oRKVl0A1d9o1dFSuy8luz1Ku6ZR3GgNdkiVjMaBqriAQhq+EJSHdKeqMvY1kaCtwbdFc
         izE2yuPkuDi4+Vswn+yp8v2INA0WHvlHtVv84dCpSPJG9fZs/K6frAzgg+A3/EHp3e/Q
         o4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=6AJvxUC3f3ekjGpx4m23PwJ8eHqdXCq0waSkIBAPiPQ=;
        b=SN9yRU4pmr+xM0elhCcuPx3x2lPavuPANmBMjRNRq6d8RvoZcnvte4kSuEXR/G06Vm
         PZKy2lmMAOB5RUiZHKtVM+ajfJ/ZbirvmiFAitp9qItxERn8YRZDX9P58UcG0hhCEnkX
         7ARng592LPMMfH/qOxKG07n4TALRSUR5GHYVMioNrwWbomaS5D+Aeb7Nw1oF3+mZuBhx
         +DE3PSmZGaaApqbtQMxgI+D764DGgreyzUvTXLjmGIkF9Ny+DNCQbU2u6zU4ijESmFxy
         EVtfIgxk6q2M7dpPYd1eANohQmfwTFy1grn5jhTewYt811npEUTfn0FCxQa9V0d0YP3C
         7jnw==
X-Gm-Message-State: AOAM5314D2TKzE51iQD73oFT2pQ/IsKYY1nU6/4J/83s8x5MS0zgIcGZ
        7gNDvgFgAxjADCPjcr788RPnxpYajsnBsw==
X-Google-Smtp-Source: ABdhPJxffSUGa2Hbs60JFbgCvuZmykbNTsluerNpq7/eVhA5V+FJfBEImm6isKbCN/7v6pvNh5sOaEQzwy0udQ==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:110:a6ae:11ff:fe11:4f04])
 (user=gprocida job=sendgmr) by 2002:a05:6214:504:: with SMTP id
 v4mr71159qvw.54.1610985705891; Mon, 18 Jan 2021 08:01:45 -0800 (PST)
Date:   Mon, 18 Jan 2021 16:01:36 +0000
Message-Id: <20210118160139.1971039-1-gprocida@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 0/3] Small fixes and improvements
From:   Giuliano Procida <gprocida@google.com>
To:     dwarves@vger.kernel.org
Cc:     kernel-team@android.com, maennich@google.com, ast@kernel.org,
        andrii@kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        Giuliano Procida <gprocida@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi.

1 is a bug fix affecting restrict qualifiers.
2 avoids leaving debris if objcopy fails.
3 aligns the BTF section to 16 bytes to avoid misaligned access.

Regards.

Giuliano Procida (3):
  btf_encoder: Fix handling of restrict qualifier
  btf_encoder: Improve error-handling around objcopy
  btf_encoder: Set .BTF section alignment to 16

 libbtf.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

-- 
2.30.0.284.gd98b1dd5eaa7-goog

