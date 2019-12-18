Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2D3D1245C3
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2019 12:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfLRL2z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Dec 2019 06:28:55 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52971 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726551AbfLRL2y (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 18 Dec 2019 06:28:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576668533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=QRJr/B2m1bfY4zcvmbafbqc9YbAmCQuMSeK/uvTtGL0=;
        b=JZTxgnlW0gkCrqb7mrLZaJ0k4tWt6T2Y3Wh3Iz+/T4P6M2MQd5Av9FuY7jQ6G/7P9W4dQd
        E7ucoMwjGXoyojJUNB0Jj8kU5fD42KOLZ/zuAeIa9Bg9PCJ+dFmnigY3Cf+JowSGi9sSBT
        71XI6Rza548suIJr/1Pe/kjcfloNvn4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-jTFIh4dGMDqJX8q1wXNhHg-1; Wed, 18 Dec 2019 06:28:52 -0500
X-MC-Unique: jTFIh4dGMDqJX8q1wXNhHg-1
Received: by mail-lj1-f200.google.com with SMTP id y24so589469ljc.19
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2019 03:28:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QRJr/B2m1bfY4zcvmbafbqc9YbAmCQuMSeK/uvTtGL0=;
        b=nsDy57PTTzTTYH6pLieOgG7ZoXKTS15NDAMuRoYeqr6Dd2yHkPSk0xB1iep5DsxrLA
         dFLW4ryqdUCMrY4PFfVQFq7qR8HshkUHLs1y9QUQjSu+OXOj+ujKh8ikrd8ZdM3xzNWh
         2gxLBJec6VRtbcXsFB1OVM/xuQL3sLSC56Pvpv/NDDDB57xunvVpbHkB8c+hkLKg1DR/
         UHtdKDDXFWWcUYsVdJVVqd7XOCzJXFjNLowHqrBMyzowYuXv2KJ7Fa3RO4uqvBWNCGqT
         hyLMexdTD60CVRCWxaZTWtE0Dxfpk0hu1AwUHHk6FzWvRZ9yPF62d4VeOD29ShwSkJ5b
         iSGA==
X-Gm-Message-State: APjAAAXgV2vSizln1grdpib6911urNCYA22V5czQrLZcNCABuQUE9X0Z
        29rO6i3zk1Ls1Q9rWeOaFm91FKsYbOE2VUwkdQ3sG3zMVDXSB7quWfQVG3kKyQw+BYJwOGHC10a
        ksyKtjCREP7eQ
X-Received: by 2002:a2e:3005:: with SMTP id w5mr1406726ljw.184.1576668530191;
        Wed, 18 Dec 2019 03:28:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqxkpBeh7QUQZE6okZj6Fj+1Ja1B30srut8El8dHeCsO+xLWCsDc3RQXDsLaFhO0W4yJNgTnWw==
X-Received: by 2002:a2e:3005:: with SMTP id w5mr1406720ljw.184.1576668530046;
        Wed, 18 Dec 2019 03:28:50 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id w17sm968212lfn.22.2019.12.18.03.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 03:28:49 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 97EAB180969; Wed, 18 Dec 2019 12:28:48 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH bpf-next] libbpf: Use PRIu64 when printing ulimit value
Date:   Wed, 18 Dec 2019 12:28:40 +0100
Message-Id: <20191218112840.871338-1-toke@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Naresh pointed out that libbpf builds fail on 32-bit architectures because
rlimit.rlim_cur is defined as 'unsigned long long' on those architectures.
Fix this by using the PRIu64 definition in printf.

Fixes: dc3a2d254782 ("libbpf: Print hint about ulimit when getting permission denied error")
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 3fe42d6b0c2f..ba31083998ce 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -117,7 +117,7 @@ static void pr_perm_msg(int err)
 		return;
 
 	if (limit.rlim_cur < 1024)
-		snprintf(buf, sizeof(buf), "%lu bytes", limit.rlim_cur);
+		snprintf(buf, sizeof(buf), "%"PRIu64" bytes", limit.rlim_cur);
 	else if (limit.rlim_cur < 1024*1024)
 		snprintf(buf, sizeof(buf), "%.1f KiB", (double)limit.rlim_cur / 1024);
 	else
-- 
2.24.1

