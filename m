Return-Path: <bpf+bounces-75802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C428EC973CB
	for <lists+bpf@lfdr.de>; Mon, 01 Dec 2025 13:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B81544E13D6
	for <lists+bpf@lfdr.de>; Mon,  1 Dec 2025 12:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C63D30DD1C;
	Mon,  1 Dec 2025 12:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="WuGj7dC9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5AE30BF6D
	for <bpf@vger.kernel.org>; Mon,  1 Dec 2025 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764591868; cv=none; b=WsUIjH8KwYQYMrUhSqkMbAizA6DBY0wscPlH/E46ryviNZBhDMrHaNaUyTaexygVqeQKJO7udAfXGtp0S3WovH9S846zNzstSIJWO8v9fVWbPONy/DxCYxMupqoxr2vUdL59s+fbQjrLMIJc0DfTJUWXoV41GshypaBZL3E6euk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764591868; c=relaxed/simple;
	bh=LDa7ML3adGpxpPCTqvCDaPukE8yIEq5yWlVwR4BK1VE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zh5kA7H4dA2/Mm1f1OYGvo7oy3IhgvmIYnfNbchdZy0RSy01gK6i0eh2HYWIqygKIam6VI7txabXinQ+TyC6vcJtVHZ8My7bwRPDRw46xLlKNg+2aYsBCOIsCrL50oU3NCpXO1DGtESAGxzSomxf2HXFSG8JGuEe+nIfN0/6q3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=WuGj7dC9; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4E28D3F325
	for <bpf@vger.kernel.org>; Mon,  1 Dec 2025 12:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1764591865;
	bh=KA/oQzzw7fbsbaclnGEMw4B3gBpT6DYefmjDeMh6oB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=WuGj7dC93U15sAwkEIje6niN7NDpaAxCcxY//SCoC4hcwlpQJvRwLkRpRrPv1Gscj
	 vhbje3wERkgIzmBGZ2Ko53EELcLs6Aq1rIdaYaFCZKAx3BJKlG25SPbXXwAV4nlnqr
	 s43ewwMyXLb7dE6LbYVjkFZ+U+USlTVyDYQ95UJ1CC+pTF+YzxkFk1J+ZlakxVXYAQ
	 4lSmsVVmuC4tjzOC8JrjULp7gRO3nMqiaWj7z1YnTvjk/v/85ZY/ebA1XCsOt7ykOH
	 e4kFluQqZhjbYx8plpSFk1pMBjea1yaNjl2R9kDoFm+9M7EBdSOe4px+dI2lTpmzqY
	 tzztWNokXF5JJqUmBoyVKsMOFMrWgLLb+KEJwMzTsxA6fqCFKosPt0JRe9os0+m4MC
	 yIqolUGjFxFprR+KHi7r1HIOHSGtjir6VQN5eVeVb74//hGjOi/xIYBS9u2+Vw1z85
	 3k1aiiWku+s884CEiXg1qFFQiZY44mAp6E0u8zeCYwlG7rrh7IGJ+KZO5McpYpJM0h
	 vlFhGrGNksKJaMQveZRmiQ2YEXZJuWqR1KRQQ2FkfyhYj3XMAop7ASK2cpGoyUvLEe
	 yAWsGDAvT5J+jeQBfdOzpZ04i6jAYg0UsGAvY/tQFzu8jo32aWwj2bv3PibPljfcR2
	 pXm1z9Xri+ZnN3BDiYubBEuc=
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-640b06fa998so3721535a12.2
        for <bpf@vger.kernel.org>; Mon, 01 Dec 2025 04:24:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764591863; x=1765196663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KA/oQzzw7fbsbaclnGEMw4B3gBpT6DYefmjDeMh6oB0=;
        b=lna4GnJV83z5plGEB4F/roW7FkW4y0vs6XAbIkf1NyhfxroDt+hDumkAJxEWgkK+Lc
         ITAvMdkV2BzlaALsEXotnMiXtnyDCIP+NNpVpZJUBSSxultbcfCOykkZAoeCLHyEOous
         BzV4RltTr9Y9oxQeKePLVRCcKV4XFF40ZfbqEeCPZQ1GHmqW4M4DjJ3FQeCxVVA/jCOn
         ZB1zX9V+OjbRmS4ZyHYeciWvKqNleK6gLmz1V8nWM8s7dg6Eazx0kKeaukscH0L60hpm
         K/4ZbDhK3Yxt/kna85x2oaIFDF6RodUERI8/Fz2agrU9a5wvrjPLMIJSVZLTR+ktcKO5
         ijag==
X-Forwarded-Encrypted: i=1; AJvYcCVDaD8H4WAlmti9y8D9CPOTzvEzfFCqIPLBPg1KZxMJ38cSnHZZfzND3aIVMVz3z/hYj0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdy2YszUj/7hVrr/N6WMkMmv9VqCDFluMKWnkZJ3PICdf2mCTY
	Cmpebsyvcvo/cvkVDrmtuxwBQklsHQf8zhe10vSUOTHteMwAJwmgQ03/q5GrFRT83mQ0frKY6y/
	1iU5yBR/GHtmyGaUe+YCM+ddyhqi2EwolwZINxr9JfoIty2u/pYUHt1lW/Cub2yMb5+xHMQ==
X-Gm-Gg: ASbGncsTuC4Fbxw/ZmUVrhBh6GUpkIv7lJ95XobENysG0L1Jq9Lv173LP/ijuoXKyu2
	ScOzpuAYx6H7br682lzBhfOeniqeQgJnyaQ6QOzUKCgVGAg/K8KDrmN8RUo+XWwFRUlJyt6pVtl
	rBKWnCo+DlIsiJE3Vs3wpA5+nZfHiwZwmQqwCTEAQtz7VANaqPvmDwhaxXWbgVedCYs7hJ8d12z
	8QUHLRnXog8zcLi0kK1OIk7hpV7JdQETPe89pEv8Vlst0EbdUNdc3BFciOHP0FMxefidYaeztrV
	p8tlqzWFGU+bQWmpbya1uF7LEbvjrXeFDThh3pmFF/+A/O+8EalQRzVW85amBMzv4M1ngd2QGX/
	fUFz5euTIQj8UxJ9tZzQUQkZ+RZWRtJON/QZlnKwbSynIEVJcGB7UXg1Tp6ZGwfzw0big+IhZLA
	pJq0PBneOxMhIBLqa2wIXZwLkg
X-Received: by 2002:a05:6402:26c7:b0:647:5e6c:3220 with SMTP id 4fb4d7f45d1cf-6475e6c327emr10813613a12.21.1764591863215;
        Mon, 01 Dec 2025 04:24:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWWFf3rv850wtlg8CTXlTZz3Khm2br09waaeWnLi9g1cJe/jdBlDbscwmV7NEJjypCoC8AZg==
X-Received: by 2002:a05:6402:26c7:b0:647:5e6c:3220 with SMTP id 4fb4d7f45d1cf-6475e6c327emr10813586a12.21.1764591862846;
        Mon, 01 Dec 2025 04:24:22 -0800 (PST)
Received: from amikhalitsyn.lan (p200300cf5749de007c66abd95f8bdeba.dip0.t-ipconnect.de. [2003:cf:5749:de00:7c66:abd9:5f8b:deba])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64750a6ea36sm12307884a12.2.2025.12.01.04.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 04:24:22 -0800 (PST)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: kees@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Tycho Andersen <tycho@tycho.pizza>,
	Andrei Vagin <avagin@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Subject: [PATCH v1 4/6] seccomp: handle multiple listeners case
Date: Mon,  1 Dec 2025 13:24:01 +0100
Message-ID: <20251201122406.105045-5-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251201122406.105045-1-aleksandr.mikhalitsyn@canonical.com>
References: <20251201122406.105045-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If we have more than one listener in the tree and lower listener
wants us to continue syscall (SECCOMP_USER_NOTIF_FLAG_CONTINUE)
we must consult with upper listeners first, otherwise it is a
clear seccomp restrictions bypass scenario.

Cc: linux-kernel@vger.kernel.org
Cc: bpf@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Tycho Andersen <tycho@tycho.pizza>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Stéphane Graber <stgraber@stgraber.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 kernel/seccomp.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index ded3f6a6430b..ad733f849e0f 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -450,6 +450,9 @@ static u32 seccomp_run_filters(const struct seccomp_data *sd,
 			ret = cur_ret;
 			matches->n = 1;
 			matches->filters[0] = f;
+		} else if ((ACTION_ONLY(cur_ret) == ACTION_ONLY(ret)) &&
+			    ACTION_ONLY(cur_ret) == SECCOMP_RET_USER_NOTIF) {
+			matches->filters[matches->n++] = f;
 		}
 	}
 	return ret;
@@ -1362,8 +1365,17 @@ static int __seccomp_filter(int this_syscall, const bool recheck_after_trace)
 		return 0;
 
 	case SECCOMP_RET_USER_NOTIF:
-		if (seccomp_do_user_notification(match, &sd))
-			goto skip;
+		for (unsigned char i = 0; i < matches.n; i++) {
+			match = matches.filters[i];
+			/*
+			 * If userspace wants us to skip this syscall, do so.
+			 * But if userspace wants to continue syscall, we
+			 * must consult with the upper-level filters listeners
+			 * and act accordingly.
+			 */
+			if (seccomp_do_user_notification(match, &sd))
+				goto skip;
+		}
 
 		return 0;
 
-- 
2.43.0


