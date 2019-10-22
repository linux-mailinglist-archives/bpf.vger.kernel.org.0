Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70C61E0308
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2019 13:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731061AbfJVLhf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Oct 2019 07:37:35 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39535 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730749AbfJVLhf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Oct 2019 07:37:35 -0400
Received: by mail-lj1-f195.google.com with SMTP id y3so16812870ljj.6
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2019 04:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XwpTSQZj56OSYomc9KDBVc5uyUVwcduu9tcaPzQMlu4=;
        b=L9mD9u1NtrWM8xoDfW9KBEBAjbwYr/XNsM9Nw4rsdtB4K+DpJdibES7k+VbjRKCc5M
         jiLN4EugX0slnPe0d05Y36kGeRG8sWw2cIsPaimvFA4Dbc8v8ForgV+se1tDBOymyZXj
         +nREmzhFJYp+gOE6cf9yB8X3sZu+0J20GrkzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XwpTSQZj56OSYomc9KDBVc5uyUVwcduu9tcaPzQMlu4=;
        b=nXAI37W1e7iM7aipRrWYZgKRTMBimd7NL2BjwxH1rSnix/eJjKB6RRATr9BOCbjvOG
         WQRowte8gq0C3Fl3sriCNjC9RnYssGJCSUhmORVGBTQjvQcmiy9mntkLfERWH2DfvqcH
         7JR5RBi4vDeHswNzMiD/UDZuCUjwnvnBx9JUvO//i9NPkdVytVYEYVoS+2uvJGnuo+Hv
         3ifdfo1oHfio5XLlgcuICMEDa1TU2bEx7kpAXASG+mpy4/L77VFtgbptK2NiJgKvUUa8
         r8guW1UAC0gxrJ4fHVHh9hJc3t/uwHb83hAR6/5uUYfSfg8Bdk8mOM8U/8YU5EXShxHB
         qQGg==
X-Gm-Message-State: APjAAAXR6PXrMor+lC5096iSzx/L8xb+P5gjFmz19t340lW/2vSCESa1
        IGiOS8zosZ386uRFxzF0p4A5JMDMb2wgcA==
X-Google-Smtp-Source: APXvYqzmjfWIVuqz2e1ZdmrW+JohGhmSgP9fCvJZKAk9rUck9ZRuA0qxpcq+Gr2vjJnrtkO8Y4vAGQ==
X-Received: by 2002:a2e:85cf:: with SMTP id h15mr18966379ljj.141.1571744253522;
        Tue, 22 Oct 2019 04:37:33 -0700 (PDT)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id t135sm9396057lff.70.2019.10.22.04.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 04:37:33 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>, netdev@vger.kernel.org,
        kernel-team@cloudflare.com
Subject: [RFC bpf-next 1/5] bpf, sockmap: Let BPF helpers use lookup operation on SOCKMAP
Date:   Tue, 22 Oct 2019 13:37:26 +0200
Message-Id: <20191022113730.29303-2-jakub@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022113730.29303-1-jakub@cloudflare.com>
References: <20191022113730.29303-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Don't require the BPF helpers that need to access SOCKMAP maps to live in
the sock_map module. Expose SOCKMAP lookup to all kernel-land.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/sock_map.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index eb114ee419b6..facacc296e6c 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -271,7 +271,9 @@ static struct sock *__sock_map_lookup_elem(struct bpf_map *map, u32 key)
 
 static void *sock_map_lookup(struct bpf_map *map, void *key)
 {
-	return ERR_PTR(-EOPNOTSUPP);
+	u32 index = *(u32 *)key;
+
+	return __sock_map_lookup_elem(map, index);
 }
 
 static int __sock_map_delete(struct bpf_stab *stab, struct sock *sk_test,
-- 
2.20.1

