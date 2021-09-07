Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0BE4030E6
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 00:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347658AbhIGWZF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Sep 2021 18:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347663AbhIGWZA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Sep 2021 18:25:00 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681B3C0613C1
        for <bpf@vger.kernel.org>; Tue,  7 Sep 2021 15:23:51 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g8so62016edt.7
        for <bpf@vger.kernel.org>; Tue, 07 Sep 2021 15:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2vMJ3l66MA4Xk2XsGDPJ11b5ddQG+LbfDZ98V6KBPYQ=;
        b=t6wSvyqGm0TH8zdK/DXSlSWY8TgAvVRfYSUnQlkKnYRBW0eGXyTlXPmpvg3Ska129X
         Yxxpu1F2IHRgpN4lwpMlpRnatLwwORctnfLp2jxdNwT3vKSBoqZ1wPoguRUShH7IaDZH
         6U1MW8sBSt6RO9KYghNQifwh/fE7mEUT9beZgNb6MsWc+pC0LiCo73bGNU5dLPVTHeW2
         Yq5L7MGBBqLxY9JP3n4BG5l7Hk9QXQpteBwTgsMJoosSZ0qDajvWuZ5ujfPZ0CeuAgwr
         ndg8wtDSwo7XsoJuBO3P4DISNFANzAg2LnDktSNWZpu9nsF14ZHNsPgIkD3e1EsVu0pv
         GgAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2vMJ3l66MA4Xk2XsGDPJ11b5ddQG+LbfDZ98V6KBPYQ=;
        b=dzAHBQh6IHl43MydLhW+Z7nCmms9C+CwizW5RW2idrmdA1ZoxRCJW5GfiUgCwPujT2
         pqsYccnZTcnR0Gud47XHPMJosYyPPhzqvmdWhI8AR9g+fOeBbHkl95KSViSV+aRNkzp/
         KyLzjFNQmeYg0KOrRF4Q5MakTEEhLYI7DZkWDe23/q+V2RKZ4HSEFRzDFRqYbe3F2Nud
         WR75RHt4c7FbCAAbsaYiEXHd0FM7oJW6YnIXve4VEADOupfxz8XXzxJEHsCJ+S+XKDKB
         OyPVuJAYd3ETOD7r7TteWyRbIC4LVuTIeOjgoOvyuAlQ7ITr4606HqEGqJelG0F97K12
         QnFQ==
X-Gm-Message-State: AOAM530H8YE44t6rPK2CvRqquFipXfEL70uwHijDWn0VYjV9bge9+gHA
        RM1EncTaXtoGeW02dskbl37MqQ==
X-Google-Smtp-Source: ABdhPJwgG/puxsuG33LJpm369ZIEvvdH4LjSB0lkFALPWHzZ9W5rHFgvd6KvgkWYKwjgaeAZoZhGCA==
X-Received: by 2002:aa7:d0c3:: with SMTP id u3mr533835edo.158.1631053430002;
        Tue, 07 Sep 2021 15:23:50 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id gb24sm71772ejc.53.2021.09.07.15.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 15:23:49 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, iii@linux.ibm.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH bpf-next v2 01/13] bpf/tests: Allow different number of runs per test case
Date:   Wed,  8 Sep 2021 00:23:27 +0200
Message-Id: <20210907222339.4130924-2-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210907222339.4130924-1-johan.almbladh@anyfinetworks.com>
References: <20210907222339.4130924-1-johan.almbladh@anyfinetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch allows a test cast to specify the number of runs to use. For
compatibility with existing test case definitions, the default value 0
is interpreted as MAX_TESTRUNS.

A reduced number of runs is useful for complex test programs where 1000
runs may take a very long time. Instead of reducing what is tested, one
can instead reduce the number of times the test is run.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
---
 lib/test_bpf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index 830a18ecffc8..c8bd3e9ab10a 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -80,6 +80,7 @@ struct bpf_test {
 	int expected_errcode; /* used when FLAG_EXPECTED_FAIL is set in the aux */
 	__u8 frag_data[MAX_DATA];
 	int stack_depth; /* for eBPF only, since tests don't call verifier */
+	int nr_testruns; /* Custom run count, defaults to MAX_TESTRUNS if 0 */
 };
 
 /* Large test cases need separate allocation and fill handler. */
@@ -8631,6 +8632,9 @@ static int run_one(const struct bpf_prog *fp, struct bpf_test *test)
 {
 	int err_cnt = 0, i, runs = MAX_TESTRUNS;
 
+	if (test->nr_testruns)
+		runs = min(test->nr_testruns, MAX_TESTRUNS);
+
 	for (i = 0; i < MAX_SUBTESTS; i++) {
 		void *data;
 		u64 duration;
-- 
2.25.1

