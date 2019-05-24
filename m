Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A09AF29F7D
	for <lists+bpf@lfdr.de>; Fri, 24 May 2019 21:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391781AbfEXT7Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 May 2019 15:59:16 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33696 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391692AbfEXT7P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 May 2019 15:59:15 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so1919691wmh.0
        for <bpf@vger.kernel.org>; Fri, 24 May 2019 12:59:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=98qLq1YzqvDS+bZlxBEFPwpmLRmsqB49UdX6CSq6WFg=;
        b=KURKZSzNJ3xtg6nJ0EVUUsKg1Wct7JMCS7XKw5RywPx4xZcXe/eYN4jjUkLqBWlHwk
         2KaAbV1H+8NsmfmuV/VrK9V6nP+iX1az5V21XL9dAY9MDcJTIz5jq5RwzYBnh/Zu2uoL
         UHs3NLM0aPwDUwA+F72LpmGPtci2TbQdaFlU5w5gHoVrPD2NK+qFXpgwokAg6KqlGYun
         HCS8+9UCLbpQIbdNWmxt2cOSb11nWOc3ZlGOJ3exDSk3lb/IldQmNEWQjEm8lofOYYHU
         XCkU7Ez0uQwFupcccTm1qEWcyy1KXc+EJ7FlV5U1CyZwHPAOaUw4EsJdVJVKZNLisN98
         GMQg==
X-Gm-Message-State: APjAAAUHsBYQ6HkYSiTnyH3x5Xa1JVwGOmh4QuVKjqmjk7dQG0Cb7kC/
        qVNazIlaON5tCOGjyL3CEMxJAQ==
X-Google-Smtp-Source: APXvYqyRh3OV8dYox0YJl0PBxmCKnOVq+8z+KmDG88Sc4V+O4CxoZp1+fYgDvmYHhZdzy2v+WUx83w==
X-Received: by 2002:a05:600c:230a:: with SMTP id 10mr16603602wmo.13.1558727954156;
        Fri, 24 May 2019 12:59:14 -0700 (PDT)
Received: from raver.teknoraver.net (net-47-53-225-211.cust.vodafonedsl.it. [47.53.225.211])
        by smtp.gmail.com with ESMTPSA id b2sm3237140wrt.20.2019.05.24.12.59.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 12:59:13 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     xdp-newbies@vger.kernel.org, bpf@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf] samples: bpf: add ibumad sample to .gitignore
Date:   Fri, 24 May 2019 21:59:12 +0200
Message-Id: <20190524195912.4966-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This commit adds ibumad to .gitignore which is
currently ommited from the ignore file.

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 samples/bpf/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/samples/bpf/.gitignore b/samples/bpf/.gitignore
index c7498457595a..74d31fd3c99c 100644
--- a/samples/bpf/.gitignore
+++ b/samples/bpf/.gitignore
@@ -1,6 +1,7 @@
 cpustat
 fds_example
 hbm
+ibumad
 lathist
 lwt_len_hist
 map_perf_test
-- 
2.21.0

