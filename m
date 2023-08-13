Return-Path: <bpf+bounces-7677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 798DB77A6D9
	for <lists+bpf@lfdr.de>; Sun, 13 Aug 2023 16:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1F31C2094B
	for <lists+bpf@lfdr.de>; Sun, 13 Aug 2023 14:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCB579EB;
	Sun, 13 Aug 2023 14:19:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1774479DF
	for <bpf@vger.kernel.org>; Sun, 13 Aug 2023 14:19:08 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D243171D
	for <bpf@vger.kernel.org>; Sun, 13 Aug 2023 07:19:06 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bbff6b2679so22839215ad.1
        for <bpf@vger.kernel.org>; Sun, 13 Aug 2023 07:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691936346; x=1692541146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAkB65ONeLsMWB23KHwLn60dL+jIuhAkmjChTCR+Vjg=;
        b=hbCOHozZy79MZEmTwFpY07IPq3eBZvZYDgUSTAz1SUiWpx/Vib7sd+cIZjyGyoT9uv
         kgDbPfYntM1YScbD/MYK1aH5fgq6/OqkZaX9LTayKYEyYlhPmcUED9EfDM01mRDaOhuI
         JUT+JuNHW8a68g48SJwvclnv4xSH27pWhZp3e/Sz+b52rYmj0BGPcE7tqhCL16NEYiJ/
         FMLPcQHsJ6+X7uXL460kJ2KgQpISoXA5A4EvlukqMIvkeh0cC1R973vrJkEwzJDz5cZz
         IA/3ODjSbEyuvuEzXUQw5rFP0vTIhNsc0mkW6k0oS8gVe+EfSdKR8kZ4yYA2u23y03YD
         H5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691936346; x=1692541146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aAkB65ONeLsMWB23KHwLn60dL+jIuhAkmjChTCR+Vjg=;
        b=S1zRF3a+sFYGnpY+M6cUPDPtbFKq7G+IPznrs1O9pEH/ofMKx0eoD2VNH8xwn/PfQg
         qK6WweR7rpWGQpaUVesxR+I3Rm/yVxDohzvZhHrScJVP7sb6p7SpGRrLabhkkbjTGGrf
         IulDgojiu1QGS0szem79vYNbDQDyVNt69CVxF5R2iGnlhZ0k6TTLT5e6Pt2BrTghM7QF
         K1UU0EfPdDXv4kln8AEzia8xEM8U3QKUm0KO6tYU3Fu1nqr85S0RuZv1zwzrZB0ZQc7O
         WaNJINC0GBwWfZTEuYFao0xBz8o0ZYT720KifSSvvGaf1BEY0l3reIIKj9riwTsc54mK
         uZSg==
X-Gm-Message-State: AOJu0YxI2ILqPlYRY891WteCBadsxwwi175tKozXELvU/6PL8yHKr5CX
	vdvN3qBwqbpSSY/dbZapF04=
X-Google-Smtp-Source: AGHT+IF/2qS0GODKImo0YiLxgHhk0XdAagrfqQZvL81QngcF8QQh0t83cTFWnDH2HtIe+c5CUyBACg==
X-Received: by 2002:a17:902:7789:b0:1b9:ea60:cd91 with SMTP id o9-20020a170902778900b001b9ea60cd91mr5588896pll.7.1691936345820;
        Sun, 13 Aug 2023 07:19:05 -0700 (PDT)
Received: from vultr.guest ([149.28.193.116])
        by smtp.gmail.com with ESMTPSA id je22-20020a170903265600b001bba7aab822sm7506461plb.5.2023.08.13.07.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 07:19:05 -0700 (PDT)
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
Subject: [PATCH v6 bpf-next 1/2] bpf: Fix uninitialized symbol in bpf_perf_link_fill_kprobe()
Date: Sun, 13 Aug 2023 14:18:59 +0000
Message-Id: <20230813141900.1268-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230813141900.1268-1-laoar.shao@gmail.com>
References: <20230813141900.1268-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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


