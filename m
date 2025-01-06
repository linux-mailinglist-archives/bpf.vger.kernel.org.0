Return-Path: <bpf+bounces-47954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C344A02849
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 15:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98DBA188264C
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 14:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865141DE2DC;
	Mon,  6 Jan 2025 14:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODaqakRi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A99A35973
	for <bpf@vger.kernel.org>; Mon,  6 Jan 2025 14:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736174618; cv=none; b=WoOUDzxMav2pLcXsWj1dpKvVrdCUJZPhaiTEKVj0TT5Whx33soA3Isrm7AFui9jP9w/DfLCuhx4A56Imv457TqoK3lVw77PJgJ0jgU/w7wTa5+/LfAukHNwaU8MqkfJZg/JHyVIOykpTQtGwijX3W0EDsD8567gLO6GwPiWRV2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736174618; c=relaxed/simple;
	bh=fhxRVkKaLi6vJMrJWooX3P9mszkb1UY4LOi96XBKcRM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JuBzXDfbNj1nW8QmAz5tPZ/v6zZGo6rjCA2Czww1mEMGpAe4l895+2s0ifhaQECx/xnvibbJrvJ9v2wvPju8hAkcRQMc8P+KPDvnAEKkWHIAHIKDI7eo6CWLDZN6hOru3m0DWwqMnuBotqTQjCPcjnjGhCat6LvZgaZxOCXmmEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODaqakRi; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa67333f7d2so2103760766b.0
        for <bpf@vger.kernel.org>; Mon, 06 Jan 2025 06:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736174615; x=1736779415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jR/AhtMkkd7DABOzMJrtbBUj5GSfH171sYOWGbiRYIU=;
        b=ODaqakRieidkFnw72bh9k9NUp4o48PMPHmjqNPUVrdF+F8RJvUhhDo3MAfQ5DIe1mc
         spWC+8o2j6DVsNaaCGekPreh0IL4ly5EcfNQQtlVy8dqt6OTJsbzg0cfGvGyXYiG/ILx
         OYg0O2BBvpwgELJHmdrhPxDFT2Qt2bVEfaIwVV+Fh18i1Wb3VAmpf8Gv+BHq297/yhEC
         jny7Ro7CRcRm9tnXBfeupsfju2PNF1DLkr6Sibj7dCLqICOgGAW0ddrBiAsec0/wChIM
         SFROpZaxP18yNVWpQtSDtd2Rv+38y5diKC+52NIZCzadRjUuTVUqQzxsCRu63+/D38f3
         7QWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736174615; x=1736779415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jR/AhtMkkd7DABOzMJrtbBUj5GSfH171sYOWGbiRYIU=;
        b=XadGiAIouyx02HH/l826xT/IhTVOu6NeZHtetu5xCnKZDXCIxuEGU46lNYW0BjrCae
         OnAt2vVfewrXxR+jv5NDt/d3Zm42zVrUj3gEFUl+xeDFIqD6knHUv8l0lmMm+NXvkWYG
         ZVWykymVNVBfr0d9xdT69NIwg1zYjeMkcJjIq+farc+pMrvPwM5wm0dBw3pVgE7AvsAF
         Gi5y61GyLG/VgcrNy6JunOzL6sNzhywhOzVFtAjBTUyPq/OOBGEk8OJtELWJFGB+A9KI
         hEZrSfVQIuQ39FepS4gV0zJ350ciCmkkz2DyqSMhLvpKvq7wk9wE3zgkETO0DATZyLON
         7GmA==
X-Gm-Message-State: AOJu0Yy7qkwfynkbc9g/ETLxAyuoQYifHcOtlYOrLtdR1g3yHdQWBrHP
	ygoZMXOKlpS0NqgWuFbRe4UnmwP1sBrm0NgJJpJksdED5tGpWpEmuF7ZxA==
X-Gm-Gg: ASbGncsFxb75VA2wI1KYX80N5cjUk98l+5zOLwipckjPfJz/cYXK3bXcTpdmzF5qHNk
	PM0Q01AQEif/sTXlLaRzdt1DG7ZE+hCzksHEncUz09z3TqIm8xSEh949xKv7bdtSsoNXBNXeD+4
	DYWMiEajz0YsJ0+/pCWvRHCT5LluuVCuqqWxlJYnsW3iJJ+qjN5TwNtl6daK6LwpXStjd0DzUy7
	p4zrlgDUrfKzRHLAL7FvrnAWzWNFg9BuXPXN0McbY7hdAXTCl7ZjF0q2K/3jUKys4sPJXo=
X-Google-Smtp-Source: AGHT+IGEi+iyeOJ/G2/ZuL78wlKahoV8Eh9o/oPLwhxDRF2WG3T/YNqUbOWuMPVRMC0p20zPePQCDA==
X-Received: by 2002:a17:906:dc91:b0:aaf:300b:d1f7 with SMTP id a640c23a62f3a-aaf300bd28fmr2323888766b.13.1736174614425;
        Mon, 06 Jan 2025 06:43:34 -0800 (PST)
Received: from msi-laptop.thefacebook.com ([2620:10d:c092:500::6:4227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80701cfdcsm23147171a12.89.2025.01.06.06.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 06:43:34 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next] selftests/bpf: handle prog/attach type comparison in veristat
Date: Mon,  6 Jan 2025 14:43:21 +0000
Message-ID: <20250106144321.32337-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Implemented handling of prog type and attach type stats comparison in
veristat.
To test this change:
```
./veristat pyperf600.bpf.o -o csv > base1.csv
./veristat pyperf600.bpf.o -o csv > base2.csv
./veristat -C base2.csv base1.csv -o csv
...,raw_tracepoint,raw_tracepoint,MATCH,
...,cgroup_inet_ingress,cgroup_inet_ingress,MATCH
```
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/veristat.c | 37 ++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 476bf95cf684..974c808f9321 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -1688,9 +1688,42 @@ static int parse_stat_value(const char *str, enum stat_id id, struct verif_stats
 		st->stats[id] = val;
 		break;
 	}
-	case PROG_TYPE:
-	case ATTACH_TYPE:
+	case PROG_TYPE: {
+		enum bpf_prog_type prog_type = 0;
+		const char *type;
+
+		while ((type = libbpf_bpf_prog_type_str(prog_type)))  {
+			if (strcmp(type, str) == 0) {
+				st->stats[id] = prog_type;
+				break;
+			}
+			prog_type++;
+		}
+
+		if (!type) {
+			fprintf(stderr, "Unrecognized prog type %s\n", str);
+			return -EINVAL;
+		}
 		break;
+	}
+	case ATTACH_TYPE: {
+		enum bpf_attach_type attach_type = 0;
+		const char *type;
+
+		while ((type = libbpf_bpf_attach_type_str(attach_type)))  {
+			if (strcmp(type, str) == 0) {
+				st->stats[id] = attach_type;
+				break;
+			}
+			attach_type++;
+		}
+
+		if (!type) {
+			fprintf(stderr, "Unrecognized attach type %s\n", str);
+			return -EINVAL;
+		}
+		break;
+	}
 	default:
 		fprintf(stderr, "Unrecognized stat #%d\n", id);
 		return -EINVAL;
-- 
2.47.1


