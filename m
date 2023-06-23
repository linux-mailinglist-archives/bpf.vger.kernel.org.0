Return-Path: <bpf+bounces-3272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E2B73B9C0
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 16:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D58EA1C20F75
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 14:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9A2C151;
	Fri, 23 Jun 2023 14:16:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498619441
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 14:16:30 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF9A2133;
	Fri, 23 Jun 2023 07:16:28 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-666e64e97e2so383965b3a.1;
        Fri, 23 Jun 2023 07:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687529788; x=1690121788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85X6KQWnSdNZoA/Rwsv1xnmZmalDiEqK88cz5kJKV98=;
        b=MrdTVZyjilVoB+3VqpPfbeQHN0JudOYuw5cRBU38ssk7QxLwBGmGx8Rhex4oP94etP
         sn4C5pfwZ+w+qr6cjdC9W5wLDHv00KcZRx9CPVycxnAITTjQur8Hc7qdIwuYMf5RSSSd
         SFekaXl0wUCh24IvcRI56kqenXBAKFfA06ePXZVOvmGycXIZMXCo0nKtKZruwh2dR38y
         s62k/fTk8osiJYWYoO/odYfvAqgYddsRNRI6eqoqofWELSUzG5f+kGekFsEVyjskhcAC
         a9GOjZwXQ5I3IOa1fUS15nqbo2foglbVbZ+6uakNxVRpSfPzhGERF1ZzuSLkN8MlMtoN
         JvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687529788; x=1690121788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=85X6KQWnSdNZoA/Rwsv1xnmZmalDiEqK88cz5kJKV98=;
        b=bmFEj/+i0c2MAt4PQU9S8fAUP8j++U/1f6dp74Kr6g9xsRNrDNip23e0NS2Qmn2YBH
         3Vi7azHd8Y9QbI5FFyLBKtGHVP+efoqwtSSMJ8fq3Hka8WboLMd1YitWIWConu17KScw
         +LrmRsLGdBJvCF0VOGlRjQJfnLlLgfog0vLaegLx8T7nQ8P3VdNqxApmxqUyRWeJPlCi
         41L8vrWnkC9mUCzb7xIbwrEBYK+ihf/WuGNhuYyZoIFCXLRjqpV45nnTZhSmmncm/gLU
         We2qHjZydeCJyx2uY9ew8GKeRYEeGp3K2ao8hOK4H4sdhhewCqlkqzo0hR1kMf5yG6VP
         MLsw==
X-Gm-Message-State: AC+VfDxRYXSr5INarJf/rJkoCV2yjQ1ucB7umsqRRSw6eQyhPNqEDPWN
	ZxwfCPZIcFYY+sK5G/yuqE4=
X-Google-Smtp-Source: ACHHUZ4LCd/8ayM9s6bHAwLApOEWnaDLX7aNc8RZfJbO8you44CgH+g8BLlMkKd5XoVqBeMeJWKDrQ==
X-Received: by 2002:a05:6a00:2291:b0:668:7fb2:d9a9 with SMTP id f17-20020a056a00229100b006687fb2d9a9mr14511080pfe.17.1687529788464;
        Fri, 23 Jun 2023 07:16:28 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:1058:5400:4ff:fe7c:972])
        by smtp.gmail.com with ESMTPSA id p14-20020a63e64e000000b005533c53f550sm6505942pgj.45.2023.06.23.07.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:16:28 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	quentin@isovalent.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v5 bpf-next 08/11] bpf: Add bpf_perf_link_fill_common()
Date: Fri, 23 Jun 2023 14:15:43 +0000
Message-Id: <20230623141546.3751-9-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230623141546.3751-1-laoar.shao@gmail.com>
References: <20230623141546.3751-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a new helper bpf_perf_link_fill_common(), which will be used by
perf_link based tracepoint, kprobe and uprobe.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/syscall.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index f3e2d4e..c863d39 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3360,6 +3360,40 @@ static void bpf_perf_link_dealloc(struct bpf_link *link)
 	kfree(perf_link);
 }
 
+static int bpf_perf_link_fill_common(const struct perf_event *event,
+				     char __user *uname, u32 ulen,
+				     u64 *probe_offset, u64 *probe_addr,
+				     u32 *fd_type)
+{
+	const char *buf;
+	u32 prog_id;
+	size_t len;
+	int err;
+
+	if (!ulen ^ !uname)
+		return -EINVAL;
+	if (!uname)
+		return 0;
+
+	err = bpf_get_perf_event_info(event, &prog_id, fd_type, &buf,
+				      probe_offset, probe_addr);
+	if (err)
+		return err;
+
+	len = strlen(buf);
+	if (buf) {
+		err = bpf_copy_to_user(uname, buf, ulen, len);
+		if (err)
+			return err;
+	} else {
+		char zero = '\0';
+
+		if (put_user(zero, uname))
+			return -EFAULT;
+	}
+	return 0;
+}
+
 static const struct bpf_link_ops bpf_perf_link_lops = {
 	.release = bpf_perf_link_release,
 	.dealloc = bpf_perf_link_dealloc,
-- 
1.8.3.1


