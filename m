Return-Path: <bpf+bounces-12913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 168977D2099
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 03:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D46F2817FC
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 01:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEA6A48;
	Sun, 22 Oct 2023 01:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZB0+WeG"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85373A51
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 01:08:55 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D48AD61
	for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 18:08:54 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53e07db272cso3075078a12.3
        for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 18:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697936932; x=1698541732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2T8DRYCYJ9NfWBvEpn83wkwdWCM1ihlFXzEqV5B2B0=;
        b=aZB0+WeGDf6rnZbfy55ddW8dJ6TGGK0D9FygPcEsdHGlc6iqs3SThb4bK+MO7FP6nK
         xVwJ3D56KpGkjIHxIGPtlOf4hZeoPw4PoOIFSRbuUhz7q0Xo8o0+63wgNX5eL3iABF1+
         p8BSXa98Bfz6StflnbwlD0idZuhha7LBKxGsico1mjmfWbGt16isNo/qCjXVNqQSZ64M
         hvD+pAShQGUn1wdiU58S2VO+pfPNZ/FxW9m22JtHDCum9dpZ6bYsNCHD9ypZXyQ1brd9
         kjki3HQETXXEff/dgb7LiGHPKX+8D/fsPTuFGVcKprzYkjmfR4YK43VWYz0ZE12LqHPH
         1r+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697936932; x=1698541732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2T8DRYCYJ9NfWBvEpn83wkwdWCM1ihlFXzEqV5B2B0=;
        b=HI1C/0jPz0CM2tV4T2mIJqjMreEvWivbdvCuVOulpxLBtOzsW2jFtVvVw9hhR4+D80
         x5no2vRitqhNw6sAqvyd5DXF2rBoIkUsU+QjuZ0wnS3LQlB9LcQv4uOrmQ9aZrDZfhKm
         f2OYN8QP0Vbs5QlGBGFdY2PkNZ7RcVZGJR5P5dlTghBcOktW+d1D0Ye801Bo2O/Tgjxw
         7KOvC6DLrmMUsLNsgZqLxDB+PQjkz+sn80MKxDUmFNJD8Yd51rFrzYBnZU8aPFqEscMW
         plXJSKA9l74QdDRJ0FupHAAwLFI41eaIVSH9KS72IQT5t6vpF+4J2N/XeeZBZZ6mOY9F
         z84Q==
X-Gm-Message-State: AOJu0YwsLnVj3s9ztBCrJKcSqU4Egi5wBF4Rzx+SHJhyI3hZrcLFanZO
	xs/Eka3kGpjXXgajJ/5SNUs0k7tVrPz5sY9W
X-Google-Smtp-Source: AGHT+IFbjJggMs9pahr+3MnsfL1WdOGOY86zEPn0PiVJBvat+JnjE3ZKb3CWOkpMlfoA9i5+74yqaA==
X-Received: by 2002:a17:906:d552:b0:9bf:990f:ea11 with SMTP id cr18-20020a170906d55200b009bf990fea11mr3747350ejc.19.1697936932506;
        Sat, 21 Oct 2023 18:08:52 -0700 (PDT)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id u16-20020a170906655000b009c3f1b3e988sm4276143ejn.90.2023.10.21.18.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 18:08:52 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	memxor@gmail.com,
	awerner32@gmail.com,
	john.fastabend@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 7/7] bpf: print full verifier states on infinite loop detection
Date: Sun, 22 Oct 2023 04:08:12 +0300
Message-ID: <20231022010812.9201-8-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231022010812.9201-1-eddyz87@gmail.com>
References: <20231022010812.9201-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Additional logging in is_state_visited(): if infinite loop is detected
print full verifier state for both current and equivalent states.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index baf31b61b3ff..a91aa8638dba 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16927,6 +16927,10 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			    !iter_active_depths_differ(&sl->state, cur)) {
 				verbose_linfo(env, insn_idx, "; ");
 				verbose(env, "infinite loop detected at insn %d\n", insn_idx);
+				verbose(env, "cur state:");
+				print_verifier_state(env, cur->frame[cur->curframe], true);
+				verbose(env, "old state:");
+				print_verifier_state(env, sl->state.frame[cur->curframe], true);
 				return -EINVAL;
 			}
 			/* if the verifier is processing a loop, avoid adding new state
-- 
2.42.0


