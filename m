Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D1D4DE547
	for <lists+bpf@lfdr.de>; Sat, 19 Mar 2022 04:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241875AbiCSDHT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Mar 2022 23:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241856AbiCSDHS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Mar 2022 23:07:18 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39C62A4FAB
        for <bpf@vger.kernel.org>; Fri, 18 Mar 2022 20:05:58 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id q19so6324475pgm.6
        for <bpf@vger.kernel.org>; Fri, 18 Mar 2022 20:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q3ia6wCbpVQWit3xdQJewn3rY3869SZEpU5RAz2gTQ8=;
        b=HUdH8e84Erzu4o1lWmUmtvhVgnB/4x4fKWMp1cUdUSnN/rLw/JhOaOPk16hKpbqnHV
         eVJ54SZ2tt/HqUUVUwVyrYJxFq2Sok1TqZvpYwSI/JcdYUcaRjvBfNzWTmRG6rOZV2R4
         Z5PG6JrcF12cdc7lE5G/EGZsm7BHoWu1GdjNwd10tlOaUNNVrfYsv2BijJsgHPynjXH2
         gY1mZ/6Tgkcv6bhWXGCnWUvRL6oGyanQ+q0NlOwLjKcHOOj5m7Y0cwMZKkfDV5jV+jZC
         r1To6R6+JhfGGDkY7kqR35CbiQpILFc4kHzXUibqhOz0iZu2skriULMEvRiEnB1fllLg
         6KEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q3ia6wCbpVQWit3xdQJewn3rY3869SZEpU5RAz2gTQ8=;
        b=I7akXPTM3SnF/xNYMi8Ln5Xuhd1SeiUuafx9VLQANzF3TArikkb3dO8rxm5J2k6SuL
         +H7rG/NTEnYBTyGfnVXR95zs5cltsA02aRiqZRIW55ix4/2U9kIPpMSDKxlO71no+Xut
         /FTKCoJr6RyapgINtpyCxXNimB2bb8Gdg8wuxf685oRJA8vf3DJsQt1oPNG6AsUXm2+f
         ccz19xdQhBAtwqyC+oS6BxpyRvu/UIrKj1+X2TGLY1SXY4OVBsnKfUrQ2qwUtyQDiaGN
         a97TC87i+ZwimyccZVqVb8MZTi5Qu/I4nEmBKJMurLmbc5EiCiBjTjtLph+L1egQkNew
         YCFQ==
X-Gm-Message-State: AOAM5304Vf9ZCERy72OWH4vb8JfkbHLEqwlnZ5YOKV26JNUZhLH5PkhX
        2ZR8T1x5m1WU3k8xINtBALXz7WtZ8EI=
X-Google-Smtp-Source: ABdhPJxfFU5KufeIofIaUjrEQGMErPw/hOVWvIuB+MRKL7q03lQO+rNzTOtgBJ1z30Qy8VOSB03ytQ==
X-Received: by 2002:a63:c50:0:b0:381:5118:62d6 with SMTP id 16-20020a630c50000000b00381511862d6mr10041300pgm.420.1647659158329;
        Fri, 18 Mar 2022 20:05:58 -0700 (PDT)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id s12-20020a056a00194c00b004f7c1da7dd5sm11322449pfk.1.2022.03.18.20.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 20:05:58 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     hengqi.chen@gmail.com
Subject: [PATCH v2 bpf-next] libbpf: Close fd in bpf_object__reuse_map
Date:   Sat, 19 Mar 2022 11:05:33 +0800
Message-Id: <20220319030533.3132250-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

pin_fd is dup-ed and assigned in bpf_map__reuse_fd. Close it
in bpf_object__reuse_map after reuse.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 43161fdd44bb..843389c24dd1 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4800,8 +4800,8 @@ bpf_object__reuse_map(struct bpf_map *map)
 	}

 	err = bpf_map__reuse_fd(map, pin_fd);
+	close(pin_fd);
 	if (err) {
-		close(pin_fd);
 		return err;
 	}
 	map->pinned = true;
--
2.25.1
