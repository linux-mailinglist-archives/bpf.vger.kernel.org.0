Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2DF1022C9
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2019 12:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbfKSLRO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Nov 2019 06:17:14 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37258 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfKSLRN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Nov 2019 06:17:13 -0500
Received: by mail-wr1-f67.google.com with SMTP id t1so23335666wrv.4
        for <bpf@vger.kernel.org>; Tue, 19 Nov 2019 03:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=cBujejvLbogHyKUgSVV47tgGhkIi0WjoqREpr5RAh/o=;
        b=UhmBiZ2gPYI1zjRB8+eZCnXyYaJb0jiPrJJ58XuyuqnSWH6LktQ+dmaBSqQxBLCR/i
         FQ0Hsk1sq2An2ZP8pZQElvLXZ4AJKy366NJuL9WVqufJYqLdaQmmJJHr3h7QsLxX0dYj
         iB1IgY9YOxIF0EJRpUCR+fiDG/yXXnFpbc0Lz+JXgNPrKiaxkgayZIY/Vp2EnMS+vIlR
         eFrnjWcWXA7cVfWP05apEXT0E/HKumZ++Fm2sIQ1kp2ClYSw8VVBfOtfqayeDMYuSDuz
         i9zk677wnNUeGs/1Eog7BgYcbKjuXWdUv4Gyeq3sMymfKcHXdCqCHLfVWQgbFWWQSs2J
         9/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cBujejvLbogHyKUgSVV47tgGhkIi0WjoqREpr5RAh/o=;
        b=AS46sFReicVdLT63ZHdxLc+G9WkLUgb8/vFLUrA9+N6F5+Q/+uv+NmtrWE7YWEDoZY
         raO/mLwfFYkorHiOS1t46tvMX4xRbA3wDmZdRavOIGd6TqRGc7rSlvIvjbX+Xsmyoe6v
         R1LWgPXJCvE9JenDs7hYn39CT30rjDHC2eMdI4Trc8YUJzLv+aZzt+xmKuUhv5Q7yR+V
         pFxlSiqnlhtMxmOmmPBxFONhH/1I3RDQ8Jbr8ISE22PPj5z7h5KaSFJ0nXDg6AB/nL32
         hutPudnMDyk/OIpkBJrhMG+pPeewgsE5AlfkYtLbgfqbtw6PD/LHb0AvXVjD3b1Sf1u2
         yXNA==
X-Gm-Message-State: APjAAAWInnU4qVgN/r+PgCWP0QBgE9ekXlGZtgkheJhJ4a1/pvljFMEF
        RGRaA66ZR4aJqrtFx5FDy1g3gg==
X-Google-Smtp-Source: APXvYqy3plPyqq8sO9voVlbt6Q+u3Nm6NsMF9x0bcim7+HFG/9WZyHDdSVJYPTemHZfwMa5JdbcjCg==
X-Received: by 2002:adf:fe89:: with SMTP id l9mr15003280wrr.368.1574162231769;
        Tue, 19 Nov 2019 03:17:11 -0800 (PST)
Received: from cbtest32.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id b3sm2602611wmj.44.2019.11.19.03.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 03:17:11 -0800 (PST)
From:   Quentin Monnet <quentin.monnet@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH bpf-next] tools: bpftool: fix warning on ignored return value for 'read'
Date:   Tue, 19 Nov 2019 11:17:06 +0000
Message-Id: <20191119111706.22440-1-quentin.monnet@netronome.com>
X-Mailer: git-send-email 2.17.1
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When building bpftool, a warning was introduced by commit a94364603610
("bpftool: Allow to read btf as raw data"), because the return value
from a call to 'read()' is ignored. Let's address it.

Cc: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Quentin Monnet <quentin.monnet@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 tools/bpf/bpftool/btf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index a7b8bf233cf5..e5bc97b71ceb 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -428,15 +428,15 @@ static struct btf *btf__parse_raw(const char *file)
 static bool is_btf_raw(const char *file)
 {
 	__u16 magic = 0;
-	int fd;
+	int fd, nb_read;
 
 	fd = open(file, O_RDONLY);
 	if (fd < 0)
 		return false;
 
-	read(fd, &magic, sizeof(magic));
+	nb_read = read(fd, &magic, sizeof(magic));
 	close(fd);
-	return magic == BTF_MAGIC;
+	return nb_read == sizeof(magic) && magic == BTF_MAGIC;
 }
 
 static int do_dump(int argc, char **argv)
-- 
2.17.1

