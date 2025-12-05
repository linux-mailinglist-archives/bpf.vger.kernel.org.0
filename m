Return-Path: <bpf+bounces-76147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60504CA893D
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 18:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D96B1323FED6
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 17:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D1834CFA0;
	Fri,  5 Dec 2025 17:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eP3cAG4e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9193B33B6DC
	for <bpf@vger.kernel.org>; Fri,  5 Dec 2025 17:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954761; cv=none; b=cQ7k26Yggw4OZ6vHrI/4wZ9MDUefcShWBZN4mUo/BP+e4RwZCrdcRaWiGhjxURXJnOLmxd2ErKtD/geXqIFkNCCn85wlX8b4Sau7sSxRMOQQVdCJ1e4eFJw1CQu+BRoe3CE3h1Hspxe91pQVxtYfFpJ4dJtzEYq0a8bt2n9aDdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954761; c=relaxed/simple;
	bh=ThCJjVG5RVMfr+zdrGxXazrxZX2CekhpjLmMxCxTOIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qu76o4Fkc6FZsN2jKA9xEOTUZt+lU7nI6bki7QLc5gtxtGgtN8FOP6MlDU5MCFkEhhY8vWBTflaNa8A/gW50/qvD1G6g9h4+KPEOEmTAtjERktHBZY3aBOjxJvJoie30PpCfbrt9tx4PHOptXZO0XQZrbn9gj1eaDLNC8xs8bBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eP3cAG4e; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-297f35be2ffso35960075ad.2
        for <bpf@vger.kernel.org>; Fri, 05 Dec 2025 09:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764954746; x=1765559546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KthOHDXIygNvoKbYqyGnez1cqEGX3CMF/hwkpTkQzU=;
        b=eP3cAG4ezK1TsESvpI45ZoOcnw7xSCR3V/ZH08uto4kj8uVfS6myIq6k4a+yWYITwV
         MpKBhj2XDnKKPUUo0397EHk2lN/jaKzwXyo5QNb3A25HSpyS2vbHSA0Y7aJfDq0AEsEX
         YkRGBmih/vz/fghrwW+OJ3JFRCyv8A7WKlArZg3G9hSxMeQaZwzXxssG0b5xf3swXBKg
         wSpJ8m6KDusuVt3CN2T5MWwm8BJt95BPq1ra25XqrTHm7/2WfEubQaIBsz5V7hnKpOEz
         b9vsgmI7uBjDM6e84Bd7JgZHixFTHceBd3F9sI+c4zq9yZnQxNe7pEwL//jt7sPzQIFN
         ttdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764954746; x=1765559546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8KthOHDXIygNvoKbYqyGnez1cqEGX3CMF/hwkpTkQzU=;
        b=TpGiENOOApJDwjsZjk1N3vJvFPDry/z0jwc7kKRQTuA/HFTxAJm31alLzm25Oon8BC
         IBsL07l06ZCFqGkemXX2C9dtaWZyL4Zdi8L6UIsev/TSaD5dzqo36iVJcIWj5+PJ3CIV
         9Pvi/in2jIAXSiC/W+XYKc00jrksZquPibxPLfdkR0xY2DN+JBCRpCO3U4B52bxbn4Q4
         bKrZZoITNvU9AI1N95E2YBCH0IGiv0O+peDkGm8Upw6HzE5t4Sx8h6zJxB8w+SrzoPXO
         HUOg4MGtCaDyWwoB9FSrrWvWArkqBeCdYkAxsTJaygtAZ1esUUBXPIbvF8vw1Fh6+qg+
         248Q==
X-Forwarded-Encrypted: i=1; AJvYcCXO2LOKIl89gPNMrnL7Iz86kwTJVd1ro94xtDJS98ENzmtitpw1CQsXCeokv+ADlXMfpl8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0kZJBvpzzj9Q+XOTBfUjEZEIwE1h9vbcwhmo5WPcY7ex6E8Px
	j2j6z7PgJkuLLvtbqE08XnhvBZmqG4bUQNueEOtVS6P7ylU87mqGVSzc
X-Gm-Gg: ASbGncskMPk754v9mcM0RuRwZ2HVLfmmktuDy8dZLspo2J/ZQNVDckbyrFqm7Ze6RCc
	4aanA50oxpLF679ceK8vGamShfjPGjN+yQl84aRkjCE3MCbj0mhTGJcZcaF52CYcYAiE8HYDjsl
	IIhl02QBggTArWcP5R/4oPUpmTupvx9JqTT04u+EYgwvjGVaO8vGPGn4RSlFU1noIc8bM19cIDg
	ZNAbVvL/PA7aNcEioXMseZQaTeHp5iYyLYtoAlEQLsaSNVc7VufYxGyWaYM5iRTszDrK7NLnuHT
	TMpnqoXPAPPdAgU4ysJkXY2truHmIsBMuJE1S7gr0GQlhdT8D0z9WzdHKZCL5rK+gBVLs8F9r+t
	SUvCiEygb5i4JQEs+pt5B2hBG6xRN982aJZxi2fXoCzZ7rkX+fdHqCbhVjtf/tRi6V1FV0H+Axe
	ygUjtuSKhJLOFlKTL0CCfUa78=
X-Google-Smtp-Source: AGHT+IFGP5H8TS9l/ZWNTkIDFkoqd//BYSN576PH3VvQ3NUTIBZhXN9o4FjDBwMKRZAasheLBNdWLg==
X-Received: by 2002:a05:7022:ebc9:b0:11a:2f10:fa46 with SMTP id a92af1059eb24-11df0b44724mr9060052c88.0.1764954746240;
        Fri, 05 Dec 2025 09:12:26 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df7552defsm20339483c88.2.2025.12.05.09.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:12:25 -0800 (PST)
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
	Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v2 12/13] selftests/fs/mount-notify-ns: Fix build warning
Date: Fri,  5 Dec 2025 09:10:06 -0800
Message-ID: <20251205171010.515236-13-linux@roeck-us.net>
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

Fix

mount-notify_test_ns.c: In function ‘fanotify_rmdir’:
mount-notify_test_ns.c:494:17: warning:
	ignoring return value of ‘chdir’ declared with attribute ‘warn_unused_result’

by checking the return value of chdir() and displaying an error message
if it returns an error.

Fixes: 781091f3f5945 ("selftests/fs/mount-notify: add a test variant running inside userns")
Cc: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Update subject and description to reflect that the patch fixes a build
    warning.
    Use perror() to display an error message if chdir() returns an error.

 .../selftests/filesystems/mount-notify/mount-notify_test_ns.c  | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
index 9f57ca46e3af..90bec6faf64e 100644
--- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
+++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
@@ -491,7 +491,8 @@ TEST_F(fanotify, rmdir)
 	ASSERT_GE(ret, 0);
 
 	if (ret == 0) {
-		chdir("/");
+		if (chdir("/"))
+			perror("chdir()");
 		unshare(CLONE_NEWNS);
 		mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL);
 		umount2("/a", MNT_DETACH);
-- 
2.45.2


