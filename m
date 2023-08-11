Return-Path: <bpf+bounces-7512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B19E2778586
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 04:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A14C8281F9E
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 02:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C454CEA5;
	Fri, 11 Aug 2023 02:36:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E16DA56
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 02:36:53 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C4C171D
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 19:36:52 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bc73a2b0easo12202055ad.0
        for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 19:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691721412; x=1692326212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAkB65ONeLsMWB23KHwLn60dL+jIuhAkmjChTCR+Vjg=;
        b=i558YXIcAN5tpSNbhZU+v56V5h5KiWAkglcv+rEyLXB5FjKHAioL/cGc30wgsapWuZ
         eZoLCj49e6Xi9E2tvp/YHrkit6r8smHcIntAq0pMhaVCpmdQ+w/YDY5A44GD8319GOzv
         PufUinG3mr54Ku0vB1rvPY3uBqnWTv/0yIOfZ6+MTYDgvxNQU0RzA1mcWuSO7SJxfHc1
         UD1BgVsSVaE7IEgb/m36CZUQQAz+ZDqkTPwAOzehaxwlrVsz/hGVRvkDNyWSzCT28FEl
         1v1fuXq52U9NRh74KhQAe6X/G88Erk2B+Fzronr7pt7WZZyufzUIeErUxoeptPV40iHs
         dUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691721412; x=1692326212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aAkB65ONeLsMWB23KHwLn60dL+jIuhAkmjChTCR+Vjg=;
        b=WkugsOQGBqwyrCepCNWT2kBjYVx5i9uUF98i10YyUN4nPqG8OjNP+KRkudTObC5ZpG
         TDvAAA1GIaiNtL4D3+c5QfVxVdVSEJmujjOlw/zBTAlF+rk4Zs/1fjnUMjMUTvRKI7IU
         tr60L+Ya0TrlZDXs5mjdVKwIKL4PiuUFpaG4F+slAwMryK8rUblrvwYJ2QKpaiVD2uf2
         bKuw6qSEB+9zggeBJHOrfDrxewH1ugc/L6h9FxycsGt0wx6H2goE24ej/L6QExWI3QbD
         6Fcn5m9rjKFgHL+GCZzNZvRe9K4kUXdVptMlqHWXYCXJq6y1vRb3AnlpI8pjmrz/ri/m
         M+6Q==
X-Gm-Message-State: AOJu0Ywoj9fS+5Rnp8JmcN/J6BXol6TGCEvoKT3QgNOCunaHO4Pky7rZ
	pfa6iz2x8muGgZmNGTZQ6Fb9XFw5KXADWA==
X-Google-Smtp-Source: AGHT+IG9R2lSpVPvHVHkJsvsGSBGYFUYtPfBToK9qCm5EEyOPDJtrwxZX7pECTxeM0wbyQC9CUBoDg==
X-Received: by 2002:a17:902:b58f:b0:1bb:c7e1:b43 with SMTP id a15-20020a170902b58f00b001bbc7e10b43mr532233pls.14.1691721412223;
        Thu, 10 Aug 2023 19:36:52 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac02:925:5400:4ff:fe89:58d6])
        by smtp.gmail.com with ESMTPSA id ju17-20020a170903429100b001bdb0483e65sm1038304plb.265.2023.08.10.19.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 19:36:51 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH bpf-next v5 1/2] bpf: Fix uninitialized symbol in bpf_perf_link_fill_kprobe()
Date: Fri, 11 Aug 2023 02:36:46 +0000
Message-Id: <20230811023647.3711-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230811023647.3711-1-laoar.shao@gmail.com>
References: <20230811023647.3711-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The patch 1b715e1b0ec5: "bpf: Support ->fill_link_info for
perf_event" from Jul 9, 2023, leads to the following Smatch static
checker warning:

    kernel/bpf/syscall.c:3416 bpf_perf_link_fill_kprobe()
    error: uninitialized symbol 'type'.

That can happens when uname is NULL. So fix it by verifying the uname
when we really need to fill it.

Fixes: 1b715e1b0ec5 ("bpf: Support ->fill_link_info for perf_event")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/bpf/85697a7e-f897-4f74-8b43-82721bebc462@kili.mountain/
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 7f4e8c3..166390f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3378,14 +3378,14 @@ static int bpf_perf_link_fill_common(const struct perf_event *event,
 
 	if (!ulen ^ !uname)
 		return -EINVAL;
-	if (!uname)
-		return 0;
 
 	err = bpf_get_perf_event_info(event, &prog_id, fd_type, &buf,
 				      probe_offset, probe_addr);
 	if (err)
 		return err;
 
+	if (!uname)
+		return 0;
 	if (buf) {
 		len = strlen(buf);
 		err = bpf_copy_to_user(uname, buf, ulen, len);
-- 
1.8.3.1


