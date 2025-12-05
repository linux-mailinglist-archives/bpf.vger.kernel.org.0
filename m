Return-Path: <bpf+bounces-76143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A00CCA897C
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 18:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7D2B305D9A4
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 17:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C94234B198;
	Fri,  5 Dec 2025 17:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltgsSjVp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F4D347BD9
	for <bpf@vger.kernel.org>; Fri,  5 Dec 2025 17:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954756; cv=none; b=PMxbLh0Vd4D/ny8hfcxc++fXjssYJhlrDs4YW1yEH8NlLj1j8vsCg4GoAQ3IAEwZR/qaPmlktvdJYTWef4yvnX5+wgP2BoBBQT3rW80SqYcSjSpdvWuqENqdGRdJ0Ih3n138uOCo6iQe+DZTwErb21yLKIk8Fu6F5tcrEswRHVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954756; c=relaxed/simple;
	bh=YtYoTmiGxnOh5dtDECL3sKhDmcIdC9O9DzDnMbMxrZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BhV1RvLpl2p9Uvbtqx+gW0MthgNWm9v1Nr2ALwkWUGex6SlnknXfQOv7WIbDSoBoCr7aIvzksHjc8lOlD/WhDAHXsyf/ETA1Tlx8QU3oEPSoImpJ//e6v8UEmNBXLKiRLptGSWT8WL/l7MwSKekcFSJwlYu+cZQAwm5P1xjMJqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltgsSjVp; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b9a5b5b47bfso2057596a12.1
        for <bpf@vger.kernel.org>; Fri, 05 Dec 2025 09:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764954742; x=1765559542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47vuMKXmBnhdjf53+B1B8/LaD2EktMN0NOXdUnTfNOk=;
        b=ltgsSjVp9ysDRlyKerXQDlumgJHsv8QOUwqmqbFHUJlFY9PFQQl4RxJVkc7D4TdXrP
         NgNT3zJVmv+y//SUoCdaVemBWaTX0RZnfb2NlMh9fmRr6NVT0D7zQU20jncF+jGv8ir2
         5yoM5I0A70Zcp1B7XkjOHGbfFDyvULGsFBzM8vwk07XRU+vZutb2XyQO5eFNqywQ0NlG
         MJGuhjDbjzoRbROY7l0sCYU2CAS+62wIuDKT0UHR03Dc5Lbx+jRUSiPGpSI61swp5ole
         lW7jDxxotS2fO6dj761HvoifHLNZdeWS7OwEBO7FDMMuKquEqtvCRkmOry8LQ8i3WYGc
         Hw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764954742; x=1765559542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47vuMKXmBnhdjf53+B1B8/LaD2EktMN0NOXdUnTfNOk=;
        b=nlH3/9xq4EGZgz0PPtuHw1zDeIEqxqWdu1UBclYd30rwXNYOIqk7M+vxZ3tYXydZ1C
         hElJ0+kecq127dHZVY1EECmrpFsZFL8WxgW2lHryG32ihCgYWGJKDOhGorVEa4YunMg/
         ov4pZVW69xrpDKBo0Fdw3fvixzdnaqSInPUvFfu9SdpXDAAo9pYFP447Y4XYN14QNYq6
         VgtnB1cVwnVEMBO6zkDC9MaLYvyM/Dzuh/fgEFqD5vrBXAgAi0NlcJsTD7Dzg0FBAuwT
         jPeyNHoECCb6+MWg0mGHYDhbWJPNtfOZemPHmooFS5MB/OCXHe8TV3VmIfjfzRGheCPN
         Td/w==
X-Forwarded-Encrypted: i=1; AJvYcCVHQUcQDorE7rta05YFH6Z3tGFfeoJe/0qes0HJWDyoirgvFuHuzx03w/9BGheXymLUt/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHwmtguKhvyNaRF5wPgHUsk20CshaxSd3W+owUeD3TcJkLpCt7
	T/lTrzYVO1wDDxYQoWIXU0DHNUoAnmfwPOxfHhAndYOy+K6SnY3WkLRx
X-Gm-Gg: ASbGncsjk7CKkqPPXNl8YEpd3ONHUFpDTGfCZrwkVmJXQMRzoo0QrEvIlIGpNTWS+hj
	3mlZohfgctlrniqd+Fp3Hv0wbbfM8q2JRY4wrPNrXkQnwrXfHzSIgz4CEXGf7M63sQx531Ll9Bf
	H2KreYjOCQszQq+b9Vvoc2NhyCQTjbKXiXkiakULxFZTnvPVIYKLFs8wJ6u07cam5txJmCKKbPK
	Oa1grVN2StJxnz0WGq+yjAXSBETg/gpFyPVK7RbzfScOWPdZbg7BAHq3LhVhqmcMNzHU6j3nEzn
	Xf+LONn6vWIcY5pdjW5XBaygVJ8OM/b4rSi7Sa8P7DBjDTssbN7EDW/zt6F+GZJiNpFDbHjDZ0f
	mAKClf/K7urEWHNcAHwzQfSMZKW2ZOIcuQtoJyOfWmkJZwCaibe8I8vq7BifQslXfVNR1h/hMBb
	ugJQE3hP2u+Clp30Rru63/YZA=
X-Google-Smtp-Source: AGHT+IEk22OUEE7gdeZwhTjpvbdAQz+kolwi6WKygGxoM1AqKfc3siF5IPSsP8KEFJASWzEJYAwOyg==
X-Received: by 2002:a05:693c:2d86:b0:2a4:664e:a5af with SMTP id 5a478bee46e88-2ab92e88ab7mr9468546eec.28.1764954742216;
        Fri, 05 Dec 2025 09:12:22 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2aba8816ae9sm15102636eec.5.2025.12.05.09.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:12:21 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Shuah Khan <shuah@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	wine-devel@winehq.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 09/13] selftests/seccomp: Fix build warning
Date: Fri,  5 Dec 2025 09:10:03 -0800
Message-ID: <20251205171010.515236-10-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251205171010.515236-1-linux@roeck-us.net>
References: <20251205171010.515236-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix:

seccomp_bpf.c: In function ‘UPROBE_setup’:
seccomp_bpf.c:5175:74: warning: pointer type mismatch in conditional expression

by type casting the argument to get_uprobe_offset().

Fixes: 9ffc7a635c35a ("selftests/seccomp: validate uprobe syscall passes through seccomp")
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Update subject and description to reflect that the patch fixes a build
    warning. 

 tools/testing/selftests/seccomp/seccomp_bpf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 874f17763536..2584f4f5c062 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -5172,7 +5172,8 @@ FIXTURE_SETUP(UPROBE)
 		ASSERT_GE(bit, 0);
 	}
 
-	offset = get_uprobe_offset(variant->uretprobe ? probed_uretprobe : probed_uprobe);
+	offset = get_uprobe_offset(variant->uretprobe ?
+				   (void *)probed_uretprobe : (void *)probed_uprobe);
 	ASSERT_GE(offset, 0);
 
 	if (variant->uretprobe)
-- 
2.45.2


