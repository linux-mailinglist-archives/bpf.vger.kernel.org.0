Return-Path: <bpf+bounces-34959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C2F9341BC
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 19:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7AF5283086
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 17:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864FF183076;
	Wed, 17 Jul 2024 17:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWo+NXr7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C763C183060;
	Wed, 17 Jul 2024 17:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721238943; cv=none; b=k9vg+LINPcYeEScLjd2rAKdQTCK5XrC12H7zzxvs2hTHIVTEuz+FKsXCCPqRgbuGIKyCC6mtGZYxVj10RohW9lXi94fc94aZlzabyVHgIeCVKk2R9dmpu9doGPCdufYJt5HfPi+ADL/tkVynPmRIvOMgMDM3ZYaaX08CiirzoUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721238943; c=relaxed/simple;
	bh=M9OsTrgIij8MNnlp4KGeXx1ahLgmNYh0GN+taKPlyWc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sLxIc6hYUvlQID4VdkoG9CfU9uCckeD8T5Szq0twYiOUJ2PIv8bUpRfe1PcAKsOllMWXqZxD3h43vrx8VIYK+KJ3tpou55GFLPf8lzAjXwHVPYjCSP8z3zMpHFONDD71pXgwgD7xcG1FaAT0h1gryuEbEYbQbb5y8jo1Nl4w1DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWo+NXr7; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-793a3a79a83so2432617a12.3;
        Wed, 17 Jul 2024 10:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721238941; x=1721843741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9355sAQbA+Cma2PeN44/4qCQn2hLsRjzFaO5Nrb9YNg=;
        b=LWo+NXr7dNIdEEvwTtMQNvfz0V6JdxcYhDA2GakPM6Pqr1moCpRO2z6t/VYEWt3apn
         2N9MoGb4iJ/Z4+Doo0K2sV8jFugK+rizKPknyI/OlEhKRgo7l0DtPJAtRhp/l6FWGNld
         aJgz7x9jpuL9/yTQMIgZ4Di0zGb/awuTUv7HPVuzfux6tstlpqxSdltvFeb1G6hcVunp
         3f+9xld7ccdpLdDTehkqfVMo+kDmBmNDiX6nZWvFdvl/LJTBJeWCU5mDvQD2b0pOlzsX
         +9RIGC+zUavrf5z4h+RCOTCJZKutBLQS+5ArTWqmxiAzwN5Ewl0+M0JhXQ3K2kZY6GFU
         saQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721238941; x=1721843741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9355sAQbA+Cma2PeN44/4qCQn2hLsRjzFaO5Nrb9YNg=;
        b=KG/z4FwTJ353i5cAehTtGmk0vLILfVK2fZHCSZKNtXAFe6fUjDYSsBDXm0GDKVZaTf
         ISPktHXF9LerOxQQ/2QGyXvqmbGeH6zj9b1pbv5hq+uC86FctihauiqmpmqjAtm1Dtfy
         fNUZc6XG4nR2Uv7WjYz+fjfLMusofgZyQ/lWnSyhwdEEDhaLdRFOakev3uA/IfX3jTQj
         I6DfqKB1U8vHRBeZA1RCRB9ZkA6MacblykPjWc8MFJM2Pvc0ld5u51jcmUSrA5an5u1S
         l+KpqYEowengYIW4UIa8K3GWDr20xOzIfC7ODsY0lzZZaSZbtEawPS7betPu4jDtal2u
         87mw==
X-Forwarded-Encrypted: i=1; AJvYcCUqoYmN0InKqjiIEvF6niONkSYx04cyGbPzNATKIsr2IwACK3toIn1+Fg6J/FQwvcClrPzFHZrWA6bPSE3uhJ2wrv+EelY/DEhYfAHIzmIhQ9cqcpOWqK6mzqyw165vwJp/
X-Gm-Message-State: AOJu0YxNoceZAXkaZ8NbWXWmTVi18bXTmK3BN0naftE+kESBwgtF+Vrd
	thdiYi2RJ1m8Bx9cJexW3UyTMBMx5oqqoqmDuTY+Y8hpVMAwslxkzqL33PN6
X-Google-Smtp-Source: AGHT+IEVd779bNMnUtx1/OMIvo5qp3aoCngTN8uY1OR91wFQY/7+POeCcsMRP7dHdGcrpABgC1jugw==
X-Received: by 2002:a05:6a20:a10f:b0:1c2:9487:ee90 with SMTP id adf61e73a8af0-1c3fdd6b4aamr3336113637.44.1721238940775;
        Wed, 17 Jul 2024 10:55:40 -0700 (PDT)
Received: from localhost ([116.198.225.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ebb69e6sm8429664b3a.74.2024.07.17.10.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 10:55:40 -0700 (PDT)
From: Tao Chen <chen.dylane@gmail.com>
To: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	chen.dylane@gmail.com
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [v2 PATCH bpf-next 3/4] bpftool: add bash-completion for tcx subcommand
Date: Thu, 18 Jul 2024 01:55:35 +0800
Message-Id: <20240717175535.1512054-1-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds bash-completion for attaching tcx program on interface.

Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 tools/bpf/bpftool/bash-completion/bpftool | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index be99d49b8714..0c541498c301 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -1079,7 +1079,7 @@ _bpftool()
             esac
             ;;
         net)
-            local ATTACH_TYPES='xdp xdpgeneric xdpdrv xdpoffload'
+            local ATTACH_TYPES='xdp xdpgeneric xdpdrv xdpoffload tcx_ingress tcx_egress'
             case $command in
                 show|list)
                     [[ $prev != "$command" ]] && return 0
-- 
2.34.1


