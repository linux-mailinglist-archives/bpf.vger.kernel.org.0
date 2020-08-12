Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75DF242D5D
	for <lists+bpf@lfdr.de>; Wed, 12 Aug 2020 18:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgHLQdT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Aug 2020 12:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgHLQdT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Aug 2020 12:33:19 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEC9C061383;
        Wed, 12 Aug 2020 09:33:18 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id j7so631999vkk.12;
        Wed, 12 Aug 2020 09:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yVWs6zbYAWogM7xh2rvQBTsIFOdnoXyUVimbGjZjhcc=;
        b=qxNmTwZs+xBcyZACYZc/yYvgSFNZdLmDOA/fEh3uH5bfUt8LTmIVy7krF9JDa8zlGK
         fyceeq3upQeAXsd2MZi1sQIT8YHhT49+4mfmYIAh0+u9wvsX/02vDzAVvxov51741Apd
         UOj+15g3DwULmI9Rq1247/Zk60NW448209ijDhej2lElfU7FMBBJ39QIV0oGY6j6Sn8r
         U5iwX05R4laFjVr2rS7WpzOO2Mv5R4MFwZCHh8xWqspZoeX2emAWm62aeKsZqsWR/Xhc
         XoXDRj19rmLYPtkC3W+3sfDKlInDo8tJLF0HD6Fd+mOe1qTOlhIJLQtF7sxdYihYUW1z
         QN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yVWs6zbYAWogM7xh2rvQBTsIFOdnoXyUVimbGjZjhcc=;
        b=BGsrwKaa1yh9XQ7nw4fLSLzfnvZUM6NVuLNnOQT0mgSsCShkRN88tXIjVYNuypQPnc
         gvTEVAwKlV1dGj/cl2b9bkeTRu9dJ03nwBqQhEph0sRBwd7b1xtPthZd4Q4xw+HO/KUM
         K20EdeeT9Qce8px3Xl3ByOtA5Bec0u2ijFg34w3k/RIDW1iSGUChF7LHfxk+tX1TuwHd
         6VuEcFchTOTRxkb6asXyAtcWAtchKPQy92ZRQwH10MPwmyYGllQn/D/LG66IJDb8urYi
         lUFNvJV89LI5gDZnbi/NIGGiz4wXI9Sge158vGLPgZDnrYY+NsGiaUuUxdmJH0UlLa+M
         t6eQ==
X-Gm-Message-State: AOAM533nPLbHVPTqj6iGrdgnPNLrSoqrOGMNIWoHk+u6ne3tCdzmboBR
        GEApsO01uuyKCNBa6DElDYmGtKn39eI=
X-Google-Smtp-Source: ABdhPJwdAcFz2xvNbU1VKmOz/HNyXm7InfYeTXgJI5oFXAC4cFVRsjvdql/P1DsR+IZQgtrzoQkgaw==
X-Received: by 2002:a1f:230f:: with SMTP id j15mr180827vkj.83.1597249996956;
        Wed, 12 Aug 2020 09:33:16 -0700 (PDT)
Received: from ebpf-cloudtop.c.googlers.com.com (39.119.74.34.bc.googleusercontent.com. [34.74.119.39])
        by smtp.googlemail.com with ESMTPSA id e8sm245374uar.11.2020.08.12.09.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 09:33:16 -0700 (PDT)
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     bpf@vger.kernel.org, linux-block@vger.kernel.org
Cc:     leah.rumancik@gmail.com, orbekk@google.com, harshads@google.com,
        jasiu@google.com, saranyamohan@google.com, tytso@google.com,
        bvanassche@google.com
Subject: [RFC PATCH 4/4] bpf: add BPF_PROG_TYPE_LSM to bpftool name array
Date:   Wed, 12 Aug 2020 16:33:05 +0000
Message-Id: <20200812163305.545447-5-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
In-Reply-To: <20200812163305.545447-1-leah.rumancik@gmail.com>
References: <20200812163305.545447-1-leah.rumancik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Update prog_type_name[] to include missing entry for BPF_PROG_TYPE_LSM

Signed-off-by: Kjetil Ørbekk <orbekk@google.com>
Signed-off-by: Harshad Shirwadkar <harshads@google.com>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
---
 tools/bpf/bpftool/main.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 0607ae6f6d90..ccc6ac9f82c2 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -86,6 +86,7 @@ static const char * const prog_type_name[] = {
 	[BPF_PROG_TYPE_TRACING]			= "tracing",
 	[BPF_PROG_TYPE_STRUCT_OPS]		= "struct_ops",
 	[BPF_PROG_TYPE_EXT]			= "ext",
+	[BPF_PROG_TYPE_LSM]			= "lsm",
 	[BPF_PROG_TYPE_IO_FILTER]		= "io_filter",
 };
 
-- 
2.28.0.236.gb10cc79966-goog

