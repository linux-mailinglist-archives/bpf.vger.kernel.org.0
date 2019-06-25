Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A45205513E
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2019 16:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbfFYOLt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jun 2019 10:11:49 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41113 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbfFYOLt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Jun 2019 10:11:49 -0400
Received: by mail-lf1-f65.google.com with SMTP id 136so12752194lfa.8
        for <bpf@vger.kernel.org>; Tue, 25 Jun 2019 07:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=gYuJuPOZBk4Y/I55Xfw4nMllA34HbJMTlhwO9fs6sKE=;
        b=RrGdRYr/3/VMp2ftn6ZpAtSc6E+i+LepBHyiDnqE/7RSQxXYyCk/+3N4RfHuaFPwBu
         tIT+EtcczTiCbyoETK9FM7l3NGlIumcG6DYtRf3yuUjQSV7eqRrigrh+UhqQXjwI/r3U
         bjZLIwU1ZHKJRXRetaNlUJOVk7rWnS43NZ62J+z3IbLnaZBQBMXcMAJ4C+ju6cBs/aTM
         I9q/W4hvLc3xIQrLRpTUM7BNPSTU6K6BwCmHP3JfUAuE48Etj+TfO8o6DoYAAdGyw3v9
         ZsUT2Xxnmc7jwRXmX6+6VY8PJcUE9q5Qg696QWBZkYlRbffGARZ+SgiXI8ceAwTc78bc
         Ouzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gYuJuPOZBk4Y/I55Xfw4nMllA34HbJMTlhwO9fs6sKE=;
        b=YtEAm6SUEHAsSE8mVyL7ER6eQHrWfkzMxmNBLrIF6++t4ygUPQzORUptpx6of5E85k
         42kV7mfIvY2PIdEjxVPO6inBqA7AL0+xH6G4izUyrO17IJD+HvFH4c8O5+yUfMNZGFk/
         aRLL0zoD+6wDHHzqPJvGz9iqutwEDVZioIM+1ZYYWOo4Ye1W/DlZ5QLkzef7MWSboLrA
         30q2e0GhEb4huJmxZCFRqEnfL0cH02SY2xpDn9ubCu9fIUEndS4uM5SnSduC6r4UcWZh
         HvxvVyVyn++2hNkSBRwXBB6Kr/oCdzwoOJ1DAEhjdfBupuu0CDzwaMphzt+wDAiYo0Gu
         /O0Q==
X-Gm-Message-State: APjAAAUGvLR/cPLRuWA1asBb6cL2/y+0FRjwHkRRY3DWLg8NbpT5ICdR
        M0AbWp1y/jL+dvrRcGrN6eZkVA==
X-Google-Smtp-Source: APXvYqymCGzBxYFBh6NDuxj2Z0bP9KTLDNIFnB0YdKzFofu+smjIUtjZXqAQj1DCj8d9p2R1wtj91w==
X-Received: by 2002:ac2:4901:: with SMTP id n1mr2442751lfi.153.1561471906859;
        Tue, 25 Jun 2019 07:11:46 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id z12sm1971522lfg.67.2019.06.25.07.11.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 07:11:46 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, netdev@vger.kernel.org
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next] tools: lib: bpf: libbpf: fix max() type mistmatch for 32bit
Date:   Tue, 25 Jun 2019 17:11:42 +0300
Message-Id: <20190625141142.2378-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It fixes build error for 32bit coused by type mistmatch
size_t/unsigned long.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---

Based on net-next/master

 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 4259c9f0cfe7..d03016a559e2 100644
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

