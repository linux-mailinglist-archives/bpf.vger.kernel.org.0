Return-Path: <bpf+bounces-54970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2880A767D6
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 16:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA3B23A5C6F
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 14:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9066A21421B;
	Mon, 31 Mar 2025 14:28:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA011D89FD;
	Mon, 31 Mar 2025 14:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431300; cv=none; b=WUKT+eVQNdDPrmOvIiFr6qw035Tle+0fjHvM8dxPL7PPPtFktOwfRpcAUdd3Kd5aCKV1G3V1AVEycvQ/Oluq8jEx1CZME0yXakv3yOscd5/nWOoIqGogCIUK8lOjnq7vzViBWkvpkwByFganEGt8IF/llus2cAB7xvxwV2bGssw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431300; c=relaxed/simple;
	bh=rdp+7SmbHx2MDpmjbmMeQvz1BzYF8QNfJzE3RtZF8Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u5TsueEadcY8UEeeE2aU0t4UZY+qLWCX9DTuetwt9886+PyBKCaqy/AzOcTQHgwFlq75UZFvzpO0t30VjvTSuZl7LX/16yKRZCpSAmKiK2eB1/KH2J9oWutVh/FkOLOo+DghsBugtvG03KtvZTAzh24BA+HVGgkuCU2DS3nQ8Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2260c91576aso71868365ad.3;
        Mon, 31 Mar 2025 07:28:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743431296; x=1744036096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7pIThaHs+FLtjAGsieixrT5JLF7IdEj6iYw9YHCNduo=;
        b=CO/TjkTDyQVq5kFuIccHZ9HrcgrI8OpJi3cFRh7nfTL7x4FIoQ+SrWwXT0ar1cVS0h
         nsTFZgYsw/955yMEVSVjH07UiP4oudeS/YyOZJnsnoSg1vpIrb9U7eq0CnFf4mmP6TSN
         qEnsqk+vpOQ+U2uLzA3/LdRITFjY1IzbkKavWya167hij/jhPdp4tnsYVmcpF4siGwP5
         cuaYqIHmAHMElOwDqYz8X74k/R13PlX/6sW+9zFj7K+j5VF6puqv68TUTY3ZOxIu5hKb
         Zi/9V25PuWdYNDh7rNywboOFay3qRa38gzNACNdqauKGgqcFnUypyrp8Sw0esptmlhh+
         Vwvg==
X-Forwarded-Encrypted: i=1; AJvYcCUSBSNoCK7b8GGx5tcFpFLwOIl7S2NdapkdfG8B9zQdiOOPNHPNhdlKq0a8vxGO2QebyWRnh0WB@vger.kernel.org, AJvYcCWNzq38rLtseWkS58E6Sh/FOmvMzidK0ggpiJJs6D7+APpsbECUh+mvEQicGBF8Bm/AQuMHLicVgz2JVGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+4DN/Uo5LEZSCHjM/RQFWVZSjtsc39gparl5qUE48kdjxAeRA
	gUAS/9RRrmK/+viSKvHHl1Au0MIk18+xFBsTA7oGd2u0R6CqfRZ1xM26
X-Gm-Gg: ASbGnctk+lgi7TH7q72J4jVPO90Hq5i1nCNWwxCsV9Tztlo7kHrGz9rShzdChb1G8yo
	kNI1S47QAfZs7qmmbmDHD5hn9lbGeTvbSeI/ERqVYdx1GWOOvYPZmponCGWLqE1/llwjeFO3u8X
	a/15aNCSUQDtH/X7rS8oNgDwPlXFhQG0cgJdTZYdKHiZ35+/CBLyVSbYTb0VkiFpOD2N1bb+/BZ
	6vPhcKzZTSCb5K2Sr9DuvYTzdY12abQNUcvmVsAiql+Q6F///4I/50H/Ic32xr4DitvpYvdH9gu
	qj4RCvViXGSkEydI78yZYo4NvUv1Nnb0X1PsXlfGhmhj
X-Google-Smtp-Source: AGHT+IEwykwTGdoKzzKD5abl3GEKIsWHwwiPxmvoLbNPIptX+CQYaKwHTKORDO7eWuymmETq2FYuHA==
X-Received: by 2002:a17:902:f54a:b0:216:53fa:634f with SMTP id d9443c01a7336-2292f9ef20emr146929925ad.48.1743431296207;
        Mon, 31 Mar 2025 07:28:16 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2291eee377esm69891775ad.97.2025.03.31.07.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 07:28:15 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	haoluo@google.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	hawk@kernel.org,
	sdf@fomichev.me,
	syzbot+08936936fe8132f91f1a@syzkaller.appspotmail.com
Subject: [PATCH bpf] bpf: add missing ops lock around dev_xdp_attach_link
Date: Mon, 31 Mar 2025 07:28:14 -0700
Message-ID: <20250331142814.1887506-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzkaller points out that create_link path doesn't grab ops lock,
add it.

Cc: Jakub Kicinski <kuba@kernel.org>
Reported-by: syzbot+08936936fe8132f91f1a@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/bpf/67e6b3e8.050a0220.2f068f.0079.GAE@google.com/
Fixes: 97246d6d21c2 ("net: hold netdev instance lock during ndo_bpf")
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/core/dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index be17e0660144..5d20ff226d5e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10284,7 +10284,9 @@ int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 		goto unlock;
 	}
 
+	netdev_lock_ops(dev);
 	err = dev_xdp_attach_link(dev, &extack, link);
+	netdev_unlock_ops(dev);
 	rtnl_unlock();
 
 	if (err) {
-- 
2.48.1


