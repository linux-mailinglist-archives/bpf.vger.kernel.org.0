Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79D08566FA
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2019 12:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfFZKip (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Jun 2019 06:38:45 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:47059 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfFZKim (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Jun 2019 06:38:42 -0400
Received: by mail-lj1-f194.google.com with SMTP id v24so1625712ljg.13
        for <bpf@vger.kernel.org>; Wed, 26 Jun 2019 03:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=7/7ThqJsHZEC1k6/iKremUj3hn4/MicnKE4/aT1gNsA=;
        b=jwIaGN1WLQvvoZpKTt5omB84aC8rELXROrOqHTju1pFE/gX3muJ+LvqaoL8c2seXb/
         vegxwJh3qQD8GK50OyLjQOu4/kkWbzlPkvEQmLBZU1Y+eEDjNKsIg785Ld/Q/ONf4sN3
         yyzJWMZeOqe9JKH+t76WHopIaSweZ6sJuNq8vZNPeuFnKkIEHPKDBzeDMqr6jOjw2R3Y
         FXs5yQ9UdU463EB3n5hJFH/Kke6R6KK38+DFpNJ/MJU1ArsCYdYXorNDBP3poUP/o/HH
         AlNFR7BbFfgyAgaEETNNRA5/ED9Yaz58fYEQrH7M4E1uSFr3HUdDV9nV+ynJy/cYsPxX
         x40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7/7ThqJsHZEC1k6/iKremUj3hn4/MicnKE4/aT1gNsA=;
        b=LPdZhNS9y0EH6CCqeTV/T1QFgKp3E4uc7kJ1+VkPDctA5TIeF4oYvo166X+CYivp88
         QIBW3tAJa/pxqJOzIfcoTu+BNYuZdrpj3vNQxg0m+AsPSFwMfHjmJZy6AT2oc1oWh0/g
         FPx09RcYKyREitaw2j9yNajviy6IqK05NLCqkT5NJst3rimuJ8EYOxv//Fh9J4kOdUw+
         yaDKIrMb11NrpmOGs5qOW43tDXd08MWu/HKZthRV4f8iAESDfn3d1Td9cwsejRQEdu0Z
         5/9b7KJmAdt6+s/tqDywttSXXckgKf9z0sceuHQqdjq2Qx+Eu6A/3Uvi7hpsMThbaAWH
         5oww==
X-Gm-Message-State: APjAAAVEBvXs8bGxRphwrGlHCKumeSLzc5c08FrmRV1RYpvisnSlCMcY
        IuaQUqnAVjyFsOQ8ro+ashsf6w==
X-Google-Smtp-Source: APXvYqzIqruQr8skHJ7Cy/6zMhRHvz6kDHzz29lP7IOisG1D63w3LH9uBcrRddtDh9BzphIUEDvbYg==
X-Received: by 2002:a2e:730d:: with SMTP id o13mr2317536ljc.81.1561545520323;
        Wed, 26 Jun 2019 03:38:40 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id 80sm2372230lfz.56.2019.06.26.03.38.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 03:38:39 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, netdev@vger.kernel.org
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v2 bpf-next] libbpf: fix max() type mismatch for 32bit
Date:   Wed, 26 Jun 2019 13:38:37 +0300
Message-Id: <20190626103837.6455-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It fixes build error for 32bit caused by type mismatch
size_t/unsigned long.

Fixes: bf82927125dd ("libbpf: refactor map initialization")
Acked-by: Song Liu <songliubraving@fb.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 68f45a96769f..5186b7710430 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -778,7 +778,7 @@ static struct bpf_map *bpf_object__add_map(struct bpf_object *obj)
 	if (obj->nr_maps < obj->maps_cap)
 		return &obj->maps[obj->nr_maps++];
 
-	new_cap = max(4ul, obj->maps_cap * 3 / 2);
+	new_cap = max((size_t)4, obj->maps_cap * 3 / 2);
 	new_maps = realloc(obj->maps, new_cap * sizeof(*obj->maps));
 	if (!new_maps) {
 		pr_warning("alloc maps for object failed\n");
-- 
2.17.1

