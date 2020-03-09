Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2D2217DE59
	for <lists+bpf@lfdr.de>; Mon,  9 Mar 2020 12:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgCILNd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Mar 2020 07:13:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42146 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbgCILNc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Mar 2020 07:13:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id v11so10496123wrm.9
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2020 04:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vzahiIr6twtVt6VsSfZyuBvY9ZwGAcuWVXdLGiISKKI=;
        b=vL188LnzEsS+MsKXijsoJluXMPgIutt8/sArmz7u8w2jTAIn9HLd5FDsnv9iuhYX+p
         avQyieMf2HVcYZunpIGMh/orN7X6vV5YORoDbtlRuDfBwP8c+ODaShEJbzTHssWOsUG3
         iK44quOq9mHpXIO71HTFbLiU+TQBM1XuzFBjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vzahiIr6twtVt6VsSfZyuBvY9ZwGAcuWVXdLGiISKKI=;
        b=qRGXE4woCnjf6Va8F1lhcjF/1bSBRpc3tp5+3mWOqIv0RdR3mSQQY1AhJoqaJnjoIT
         5JTH3D6qYYcswsq3xFPIESr4MSU7Crbq0OjldFRBe1Llz0GGG+deH4FjgfsCelPUv9Po
         T9IVZ3ODTQ4auObdezkgJfHLYJ9+biJRVB+BeVJ1M9yc4xKK1rjV8+JOMzsycZKoaVnr
         xnW/02X0VQptEbUuVruRSzkYKqz5sGayWUcEORCH5TYgW/m/cgf0d/zdk/nL1eQM+hLB
         apv7iFJl414Wd7SoBqE4UVOXDUdqsXrlSiac/wuv44FIZunsuLkzltVuQf2GdidAeMzs
         dqqg==
X-Gm-Message-State: ANhLgQ2AYKL61F/hUm72hgmXihJJQSD/nAowRqIpcWLgFGnWaBlNM4UY
        fQ5y4j5r5Ta8clhyppuw7tQuuN3JjPhWjg==
X-Google-Smtp-Source: ADFU+vsNhSDq+4c6qa3NLLHn3/xIV3phZyRLu07jB2TtZmct8F2GzqbRAyf6VGtqPNUqtLII7mdYEA==
X-Received: by 2002:adf:f0c6:: with SMTP id x6mr19533874wro.273.1583752409755;
        Mon, 09 Mar 2020 04:13:29 -0700 (PDT)
Received: from localhost.localdomain ([2a06:98c0:1000:8250:3dcc:c1d:7f05:4873])
        by smtp.gmail.com with ESMTPSA id a5sm25732846wmb.37.2020.03.09.04.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 04:13:29 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH bpf-next v4 12/12] bpf, doc: update maintainers for L7 BPF
Date:   Mon,  9 Mar 2020 11:12:43 +0000
Message-Id: <20200309111243.6982-13-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200309111243.6982-1-lmb@cloudflare.com>
References: <20200309111243.6982-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add Jakub and myself as maintainers for sockmap related code.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 14554bde1c06..adc7fa8e5880 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9363,6 +9363,8 @@ F:	include/net/l3mdev.h
 L7 BPF FRAMEWORK
 M:	John Fastabend <john.fastabend@gmail.com>
 M:	Daniel Borkmann <daniel@iogearbox.net>
+M:	Jakub Sitnicki <jakub@cloudflare.com>
+M:	Lorenz Bauer <lmb@cloudflare.com>
 L:	netdev@vger.kernel.org
 L:	bpf@vger.kernel.org
 S:	Maintained
-- 
2.20.1

