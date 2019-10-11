Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C27ED4547
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2019 18:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbfJKQVc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Oct 2019 12:21:32 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:56083 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728213AbfJKQVc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Oct 2019 12:21:32 -0400
Received: by mail-pl1-f202.google.com with SMTP id g11so6304289plm.22
        for <bpf@vger.kernel.org>; Fri, 11 Oct 2019 09:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KYr+rZ9xpD3o3WNhn/gciNYekX7hP9ynebQ52QiejRo=;
        b=wC6D6xz1F3pXdU5fm+Fa7rKJFgfFJrU3cmp2OHi9kcDjxmTlc9RjjUFQ0n3ijsQZz7
         5yXHnk7+4JdRs6wjO487kGoWS2ba6nnXn294PD93cGCp1WYEK3Y03zTDeL1F+iQS9fCU
         S4hZX9ODKfQzvYX6RiSBzaU80PJunSnasVMzBzfp7jZkJma4ja+RpN1OMAXVrvpLUuhT
         vzz9Q7PUN7RHfQBEodIExP3iNVIU8dTPNWxyc41He8itTrqEJLiW2PLoK/WRzCSgLwhJ
         DAyziwVTHgwTMv5PDwaPx4P1iGt8s39Ya1moPaLE4nWCdobyDodE0tC+ZVABG5xEipHJ
         pzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KYr+rZ9xpD3o3WNhn/gciNYekX7hP9ynebQ52QiejRo=;
        b=hbMFg/N1UY73WrEbawcFsdYOadjuTEnydS2t7lwrN7sQj5vBcONiMjZoEUOQ3HLYM/
         130M8FzREvx5Nrl1HuvVDcNXBkZZ8cUmA1u1QjVUQSWlLtkJ019RuKeLuE0K18vr8+Ys
         p7htsKOKxjn+CyQsx45n6QE+HA6IgXWNGegmRJetzVlhmYZMpf6HJ86l3W7aLS0cEp9l
         EGKO3uYiVWyP1sbhdq+M8In4gPWnTLPuXPQ0MG8jyZCt6+Z3tuldK818BZsvgloG3nAR
         Qn4bvc2pKfGmh17j6Bt/hmKOKo4pBlAuQrwWU/Lv9MsR0/du5WkvoJBuNdvAO1hz6al8
         t5UA==
X-Gm-Message-State: APjAAAVlsN6rOn+GOY4s6unIYZ83hnCIBJ6v/FB7UVtjge5dsSABAMW6
        J4lpjyngCDbtAgqVaVVLQxmTGZA=
X-Google-Smtp-Source: APXvYqxsYkX0433RFOTsuJprN7/ECWj7UzFP5CAUzdmAbfFG6m/ov91wU+dSgmV9fEWR2qQlEVRj9c8=
X-Received: by 2002:a63:394:: with SMTP id 142mr17611833pgd.375.1570810891220;
 Fri, 11 Oct 2019 09:21:31 -0700 (PDT)
Date:   Fri, 11 Oct 2019 09:21:24 -0700
In-Reply-To: <20191011162124.52982-1-sdf@google.com>
Message-Id: <20191011162124.52982-3-sdf@google.com>
Mime-Version: 1.0
References: <20191011162124.52982-1-sdf@google.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH bpf-next 3/3] bpftool: print the comm of the process that
 loaded the program
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Print recently added created_by_comm along the existing created_by_uid.

Example with loop1.o (loaded via bpftool):
4: raw_tracepoint  name nested_loops  tag b9472b3ff5753ef2  gpl
        loaded_at 2019-10-10T13:38:18-0700  uid 0  comm bpftool
        xlated 264B  jited 152B  memlock 4096B
        btf_id 3

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/bpf/bpftool/prog.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 27da96a797ab..400771a942d7 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -296,7 +296,9 @@ static void print_prog_plain(struct bpf_prog_info *info, int fd)
 		print_boot_time(info->load_time, buf, sizeof(buf));
 
 		/* Piggy back on load_time, since 0 uid is a valid one */
-		printf("\tloaded_at %s  uid %u\n", buf, info->created_by_uid);
+		printf("\tloaded_at %s  uid %u  comm %s\n", buf,
+		       info->created_by_uid,
+		       info->created_by_comm);
 	}
 
 	printf("\txlated %uB", info->xlated_prog_len);
-- 
2.23.0.700.g56cf767bdb-goog

