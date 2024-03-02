Return-Path: <bpf+bounces-23242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9A486EEF2
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 07:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95364B23F30
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 06:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D26A111B2;
	Sat,  2 Mar 2024 06:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFJ4jRvn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4AC10A23
	for <bpf@vger.kernel.org>; Sat,  2 Mar 2024 06:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709360543; cv=none; b=f9T+1dfRoLXSfLcGFUV3gRPmZrK58BeEsE9cengDpKaxqaPWwM7flhDvqciS2I+SII0Vnsa05GD8ARuAax9BAKBIeAaW4pIdh3yrJ9qiAQT+NevMCknlh2sWALocxJWg+U0Y2FL0XwYksYT3FQIJ/x6QJJmlrMDKxE7atr6PfWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709360543; c=relaxed/simple;
	bh=AWFsGvqFUWp61lQsRONoKK2KutrvPIa91jknYVrA7Eg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zfkicjl3taLbqRVfDXLOE7JWuaQa1TBNqP+gcC0VlrWpjUTfH9l8dy7OXNHJbk3c4LxsOsPmZjpuT702FH35mgz+DGxKz7NI4e9Gdp+HiytZQ5EaJPrnRk2/er40zAJoe8D4ff1ZeJiQWDyaHSmycqGSzrPyh8ZzIGoniykIWFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFJ4jRvn; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7880ea7e2b0so30962085a.0
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 22:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709360540; x=1709965340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F0WOEi86kugaOMIWdsmQhIS90t4LZZQ/Eh9R8D8VZBI=;
        b=RFJ4jRvnU07Mt1VQwiKP4CC+zpcH5KcUWzqp1ZUs+IHgx0C4i9ClbDMmBCuEplnSQf
         OB/DnQ6/KaK0B3/REk8eEvWQotSfcI6L622fJKOMkUYQHMhIykxYLmkjf5jdiSjTxC8Y
         b9zGF1SUS8UCr4A3987j4W4Fr6BullOOKh2jXYxS0ikV2yZ+/GLKkrArH7gPIaGMQeEU
         4TQUXsth3ZihhTzRjCd+fmqWvkfYQSjTBWk7UPJ61iNwKJvz3lwA9j4sAsKsYquOAs7Q
         RSywHOmfOmRRsam199tqC7vAl0UYE+3Fep8ICDvvWbokxcqYTvLi5GiK7F8ulx3HKnUf
         CNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709360540; x=1709965340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F0WOEi86kugaOMIWdsmQhIS90t4LZZQ/Eh9R8D8VZBI=;
        b=f1dcF5HGnY4KAQ8DPJxmVLecogIUiWO+cXR+eI5s8IUIcmK96/6gEssgf80UzUvZO8
         6Qqj6BDwHtfOneVSdiV2D68+6DMSxVYt3DsIaCOhza6GWwUQo4HFPnXzMWeorlvgOIIr
         dS8RfXBN/9Z5835eMkdhzQ8hI13frKQSt1nhJ69sjrIdpN0LcX+KM3Oq0711Eza6sYBY
         4rbYVSKBpUxSWylGzusSkla2KXlSpoFeIGTJ8VPtzrv7wKu9J+r6nX9Da9Rrzj0mvoUS
         Hp+MJZ1QSwupODBD2mCc6XhVhhd7GtCgzUaBd2D6UlRjjsW0QOtvkxQ1WFnFNnro7qZs
         Mg6w==
X-Gm-Message-State: AOJu0YwA137QwwMnyDKvT6IP/W78ayGkOU6jDpmXh8kdQ+SiUF+AAFHo
	GIwCBzCgcJjW4VkOZbxQ7Ih9Z/olnnZmdDhGv8o4kOkxuw44Uj+a8+fod2kP3w==
X-Google-Smtp-Source: AGHT+IEHn7OHLTYlNRxwLJ+EiigF/4KzunDgLO+eWwLuBTK/xNpwt232u0zUHL1tfj+eB7/kLoUqFA==
X-Received: by 2002:a05:620a:462c:b0:788:1556:58e6 with SMTP id br44-20020a05620a462c00b00788155658e6mr2221507qkb.41.1709360540447;
        Fri, 01 Mar 2024 22:22:20 -0800 (PST)
Received: from localhost.localdomain (74.121.150.105.16clouds.com. [74.121.150.105])
        by smtp.gmail.com with ESMTPSA id ol17-20020a0562143d1100b006904e2c9e36sm2188488qvb.116.2024.03.01.22.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 22:22:20 -0800 (PST)
From: Chen Shen <peterchenshen@gmail.com>
To: eddyz87@gmail.com,
	andrii@kernel.org
Cc: bpf@vger.kernel.org,
	Chen Shen <peterchenshen@gmail.com>
Subject: [PATCH] libbpf: Correct debug message in btf__load_vmlinux_btf
Date: Sat,  2 Mar 2024 14:22:18 +0800
Message-Id: <20240302062218.3587-1-peterchenshen@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the function btf__load_vmlinux_btf, the debug message incorrectly
refers to 'path' instead of 'sysfs_btf_path'.

Signed-off-by: Chen Shen <peterchenshen@gmail.com>
---
 tools/lib/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index a17b4c9c4..2d0840ef5 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -4968,7 +4968,7 @@ struct btf *btf__load_vmlinux_btf(void)
 			pr_warn("failed to read kernel BTF from '%s': %d\n", sysfs_btf_path, err);
 			return libbpf_err_ptr(err);
 		}
-		pr_debug("loaded kernel BTF from '%s'\n", path);
+		pr_debug("loaded kernel BTF from '%s'\n", sysfs_btf_path);
 		return btf;
 	}
 
-- 
2.25.1


