Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C0E2FA5BD
	for <lists+bpf@lfdr.de>; Mon, 18 Jan 2021 17:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406228AbhARQMm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jan 2021 11:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406076AbhARQCd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Jan 2021 11:02:33 -0500
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53B8C0613C1
        for <bpf@vger.kernel.org>; Mon, 18 Jan 2021 08:01:51 -0800 (PST)
Received: by mail-ej1-x64a.google.com with SMTP id h18so1965087ejx.17
        for <bpf@vger.kernel.org>; Mon, 18 Jan 2021 08:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=cw3dvRGpX/nSIs+bFZRctQhooB6vy9IbCBqwEdoTFOc=;
        b=cFOm+rUnyAKi8JkpTd+HdgTPNG7OBrrUy9ionHXZamrgDP7xbIEWfp9EUbzohDY9y6
         8qNpc4Vzo/seVzuMT0dsBell02MySEo1pPEUdKXad3LF9pnA1+DTFHDS9m6D1LssnzpH
         4YmHa2u6fG0zS5rfw3rmIXNn/KkQWm5lsvDgm6aduXPuRo9RFfnZJ9TrbeFSVcT0mSkj
         i4Go/JwqFw6K/rVIAvgBUjnoYt0bcRS1ozHeRtl0rrDWbw21d+HMNHKL8Wbr3qt+PUzY
         QpGrw2t2FBEQNW/2jz73AjECpQVnOorM+I0m2JONBasQq4zXEaZo5yXqcIqUP09k5QNT
         U0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cw3dvRGpX/nSIs+bFZRctQhooB6vy9IbCBqwEdoTFOc=;
        b=SPmAM36T7bi8ApsOqsUJxQOxcVfFW93mDVCwoKcerfhBbHtqjIKZ11PBTapbEvrjyu
         yZYO8KFWQCxR7rorDOaYqu2KuJnklD0932B3Byc+sHbOvBm8AjO8QDWcvSvf568EhkyN
         2diazciKjSgkMeadG5qtglQUFIR+5E5xaQqahpMfUpo2SuHrKSkhNkBIDpJVG+YbYdPK
         rU/eaiD6Y6SmHEyyw6dH+H9GtaPqKw7qh9BeC6EVRrhqQ7Q3fCWlztDx6t4ZJyC3qwqN
         /kHGb3Qsq4rgIQ5P5P2qXu5RUSFlkjCDDrPszo6MQUFP3mBg8j1+apg0U37Quy3IBs9Q
         oXSA==
X-Gm-Message-State: AOAM5306Rrx/BANHdbnNVF3RkfmS+s0kiVCP5ZOw9BbNU5xNL7PLHNtW
        7DECJiAnMq2xq8VxfUemvJhkZp2Gn4k5Zw==
X-Google-Smtp-Source: ABdhPJw+SvlnDKL5tE8q7bmDcvaaf08OQSqdIUpo3tCtpAC6m5QMFbp1u2chxyy6bFqmUFfKLlt+Tpu886Tm3Q==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:110:a6ae:11ff:fe11:4f04])
 (user=gprocida job=sendgmr) by 2002:a17:906:15ca:: with SMTP id
 l10mr242893ejd.402.1610985710175; Mon, 18 Jan 2021 08:01:50 -0800 (PST)
Date:   Mon, 18 Jan 2021 16:01:37 +0000
In-Reply-To: <20210118160139.1971039-1-gprocida@google.com>
Message-Id: <20210118160139.1971039-2-gprocida@google.com>
Mime-Version: 1.0
References: <20210118160139.1971039-1-gprocida@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 1/3] btf_encoder: Fix handling of restrict qualifier
From:   Giuliano Procida <gprocida@google.com>
To:     dwarves@vger.kernel.org
Cc:     kernel-team@android.com, maennich@google.com, ast@kernel.org,
        andrii@kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        Giuliano Procida <gprocida@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fixes: 48efa92933e8 ("btf_encoder: Use libbpf APIs to encode BTF type info")

Signed-off-by: Giuliano Procida <gprocida@google.com>
---
 libbtf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libbtf.c b/libbtf.c
index 16e1d45..3709087 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -417,7 +417,7 @@ int32_t btf_elf__add_ref_type(struct btf_elf *btfe, uint16_t kind, uint32_t type
 		id = btf__add_const(btf, type);
 		break;
 	case BTF_KIND_RESTRICT:
-		id = btf__add_const(btf, type);
+		id = btf__add_restrict(btf, type);
 		break;
 	case BTF_KIND_TYPEDEF:
 		id = btf__add_typedef(btf, name, type);
-- 
2.30.0.284.gd98b1dd5eaa7-goog

