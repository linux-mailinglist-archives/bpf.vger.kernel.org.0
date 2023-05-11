Return-Path: <bpf+bounces-362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB82A6FF847
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 19:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC6A51C20FD3
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 17:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0802E8F6B;
	Thu, 11 May 2023 17:21:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05DF8F55
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 17:21:02 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E1A269E
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 10:21:01 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba6388fb324so4818355276.0
        for <bpf@vger.kernel.org>; Thu, 11 May 2023 10:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683825660; x=1686417660;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3bx8GPX1nLWoIzF04MYA/SB+fKjrXorgzwkWrTrBNPs=;
        b=gmo6Y3G7D/tTmL9Zlbq/HgpIovOpPZQV9qb4zec60DtcpCnTsjZOukhdS1tGPL3wat
         QzN+ajErTUGs1DfvpjXFi6qyZh+zPP5Pfl1YGnHjt3ffs8a4Rv5seb/j7kcvKVG94XsB
         DAzhgamFR7R58CZDuZNr1zu2DER0nHk3u4P5UBzRui9qQ62mk0MaXgxz/BoYT73lWaca
         2v24UdEyO+hQSAaE18N3T5UqjDb/X0A0ppesEq+O2UEjzgWcGBRrESYuh72rlOLsN3ec
         CcYebSglMJ8X8y5+LgBFRLhGoPlbvKnDiSejYpf2miSzbzyyXWgAv4T0iAh5u5P5XZ6J
         FdFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683825660; x=1686417660;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3bx8GPX1nLWoIzF04MYA/SB+fKjrXorgzwkWrTrBNPs=;
        b=UsUo3oVxKeSsUhJ5Wd6QoxbHLO7joGXfHmS4WN7Z/SpNhBL6mhoyhnTmSsok2L00q1
         cv/uuXAoFtz5HchD9cjhc+9gAv1TiJ1/r2NPPmi4QLOkj5etk3W1OXwdlYBHCzlCzifR
         j5acSdMS5vNE8LDXxU3XdyxUyPKELkWqwFjikAhhddBI5UNGxTXGdVvVLPFt38eJK9WD
         D5ASAunagiuTFPRpf+izVtw5nDWAPJrlUQRLb3Fxt47WM+peh77itu0xnAzOOQZKTt9o
         uTCR2421uicuwoL/L/K7zpEMxKIbME0/KaOPks08nN1+2mTxvh/5awLJ2eb5pK4t4pPy
         GFMA==
X-Gm-Message-State: AC+VfDxLcusyKiL2NAirkfVZHk2PbeLsCs25WIit2IdnXTTqWU72rU+I
	yyNfoWVNMhqoaSAfWRXRunsjgp6GCS/+XCQ3LekziRufDcclIFTNrcctqK/3P7lFhFtCZWWsCQL
	zlfDAr1p+6FkQwr+0VHS2zLqHFnu52MY0LwqV0E7kAW5bPU51hg==
X-Google-Smtp-Source: ACHHUZ6OdQRdsAKkaMmlX7aclOx9s0idEIILKCM9wElEiI4xpeOTGCUZYw+bnzZ6PufspfT0hAge53o=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:5b84:0:b0:ba2:da66:3d37 with SMTP id
 p126-20020a255b84000000b00ba2da663d37mr6304491ybb.10.1683825660397; Thu, 11
 May 2023 10:21:00 -0700 (PDT)
Date: Thu, 11 May 2023 10:20:52 -0700
In-Reply-To: <20230511172054.1892665-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230511172054.1892665-1-sdf@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230511172054.1892665-3-sdf@google.com>
Subject: [PATCH bpf-next 2/4] rculist: add hlist_for_each_rcu
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Same as __hlist_for_each_rcu but uses rcu_dereference_raw
to suppress the warning from the update path (which is enforced
by extra cond expression).

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/rculist.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index d29740be4833..7b0a73139b21 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -690,6 +690,12 @@ static inline void hlist_add_behind_rcu(struct hlist_node *n,
 	     pos;						\
 	     pos = rcu_dereference(hlist_next_rcu(pos)))
 
+#define hlist_for_each_rcu(pos, head, cond...)			\
+	for (__list_check_rcu(dummy, ## cond, 0),		\
+	     pos = rcu_dereference_raw(hlist_first_rcu(head));	\
+	     pos;						\
+	     pos = rcu_dereference_raw(hlist_next_rcu(pos)))
+
 /**
  * hlist_for_each_entry_rcu - iterate over rcu list of given type
  * @pos:	the type * to use as a loop cursor.
-- 
2.40.1.521.gf1e218fcd8-goog


