Return-Path: <bpf+bounces-75875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBABC9B60C
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 12:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6BAB1348728
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 11:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29544313534;
	Tue,  2 Dec 2025 11:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="SxSAyNzx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB653126C9
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 11:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764676350; cv=none; b=fQzn+fvfMWcIN3oCwKddABJBlx2U7foqVpvmxmWlixMraj6Ayhk5qNvp9l8yW6Nz9WaZ4Z3zr8qxlMWTUC+mkXe0OBWM3MsujcbUu1btCuxEfLklocFjprCiCm520ylq/utTYwXuzuuz3Y+sbjcxd4veLJS7aLFMMFYIAJohw4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764676350; c=relaxed/simple;
	bh=Awb3M6B2IIzp+0fpByqGQgvW0nRaeWjjbsKoKCOjrl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B/HV1++5F6W09JwE5ltz0uAVFBXdZojJJS6GSKAMuw3a5TamirRWDm0z4XwnW8l/0LPHVv7OPHcDeNtGF5ZoG/SkGFTaQO0fvLub4pBaIbvTdMxltJ7TObmCsiPqKmV+fe25pRZPMH8ehJGKg7oajHBPUeNXn/W4n1I2WsRYqBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=SxSAyNzx; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9C656400DF
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 11:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1764676344;
	bh=onmmMNhG8kq+R/JLtIWS2e4PsMTEDMPomEnnX1Q/J4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=SxSAyNzxMKDYYOgYvUoobYwaWjFM13lXT1zgUKpjSsZohikLDIcpIRQQexkQL/bg4
	 Zq1cMWjW0mc15/hvNigCA8HkMwDCx7XrJWhrmi2VkCeSgw7QVWzoQsbXYkTBCW0djV
	 wvzcgkuSFvIZ4EFGlpyoMNdn63cR2jHSjGoe6Wam9b6ef4Rd5H/X/DFoYg+SaSJc1R
	 V4V0KDGC5zdlnBO1Y+t/gpAmrCgTsYz+27AVijYOtH1MteGkQOdn2tHZdCMl9PnvZK
	 hJHywYCB67VtUWRtUIMvJ1lTZMSF7XDd8haL1fvaQufW8ZtbukNaDafWHixnNXaGSz
	 zprDpXfWj6kauTgf14qQmhcYeYySPYYP49bAl0TocvPVzwnFawEIBzaQkI8cgDbhky
	 fTP/eZXqTaZCf8T+SB6wVKcjqAXws5JvGdrLSADneHvDf5phzGqK3dQ7TUuuE/TBQ4
	 wQPMbeMUQjYBJs2a8Cr6vCW2ZjGJ3kRH10keQSbqEs/1MSZtA0tDoFyy9ATiqhxmuh
	 +xONHAwMMh55xrEDGzbTagiDD+Wr8hxKgivqIVJ1jLxyi4KmaCnsxyMFVdwb8iPF8K
	 gcYde8wLoxJRQV7U//sQ6xJegH9Urh+5Y5/DV4rtnOsnDgx1yyNl2xopCQbR3ceAI0
	 tNLvZwcKiIEqHOapBtO5dRro=
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6409849320cso10813988a12.0
        for <bpf@vger.kernel.org>; Tue, 02 Dec 2025 03:52:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764676338; x=1765281138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=onmmMNhG8kq+R/JLtIWS2e4PsMTEDMPomEnnX1Q/J4Y=;
        b=WKPy1sNucqnVJidZQwXB/hYRBEObpU70B5tZMkZsYpmI46HBZCJhGZJAGwaamujD4u
         yz/QwpX98gaXgzlGgMKDCFlz4K7woQET88fY5ILWT7FCojcmjhizVZwvcMZHZWlshjUu
         c+4t2P1UGJanA0glIKykpTVfd+Ugj6E0SZ7Ac2k2HP7qXAq5OejQym7NvGEgfYO++8gn
         YpaQb3OOyPMAeSOE0pc6kYhhUH7Ji+1ZlQ0F2opHzNvzHkcUAFXqGxwVMYyPjUgiKECN
         eB8cGGDaMf56kVAsDTSiYVqYvENZS7D2cpopsH7dWDKPXbEqtBKzH3xDXd59LAorJX1W
         Km8g==
X-Forwarded-Encrypted: i=1; AJvYcCUdp0MA1eRNsWBMt+fiAco/KRbogRYlMqr3PSjoSLfa6wMXHeXUaQhfiRB3+dG6iOEw7E8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX5A0RBJ6IfTxmboNkfpIeaad0v96VjyUSatZ8VR6Ta0UKVCa4
	kjhY8T/6TOnMt/T56x9wUUw0q1JBzeE4U4Z8LMW5gct7kUkriRgi2gwl/eCfnSEic147ObdMUnt
	toitbpk3nc6BNNdc+I4HAoHwntAnI9KKWcYMd+IyRGXdbimvdSn7eDF4IGfWrWgK0C2DGDg==
X-Gm-Gg: ASbGncvl4dAJ/8x9DJJ4oIiZDrwb/uxnGRyCg/Lq0YacOyfEuMdGL8lF6UHaVL0kVK/
	GB2rKHij6BjOCwzBOCWMA1N87LoPTdJIPu7DSLbVWXZcAmcAW2JwV6YwO+4RtdnpdmskccvTlzj
	zFE3Q5sG47nnvAGdc9bBdfipTQPVlxLkzdM6FQAbFNisyY5GavUXQ8iTjGVOoDiYXL5c75f5f6R
	ZBjoSkSe8MhXnk3hYEsTgDQyj6EPKqlO0sxB31HhdYPA2drj281dyMJKDBtmPppnd1D6QZYtwU5
	bWtOJ5GXwfEtXulQ1elxzWFou5h0lZeiqOdR0RoGHgx1dmkTv+d21n5nwKH/KlNh9RFaw9H5jWa
	tnIJvpKD0HzgxyOd5NWGruJEhYw05k+UMmhVOiNcRml1ht/GvTdx8J+Gq9JnmuzwOt8d5tnocRV
	T+pmbMM8rBhntKSy3WuoyLzhI=
X-Received: by 2002:a05:6402:1e94:b0:645:d07:8924 with SMTP id 4fb4d7f45d1cf-647897aceffmr2310534a12.16.1764676338235;
        Tue, 02 Dec 2025 03:52:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEca/7GZ5CQrNL3nM3OXTnppoQy+Aj3EXI9b3jTl/xGwssUT9yknoaPt4StNpF0RTzyq9tBFg==
X-Received: by 2002:a05:6402:1e94:b0:645:d07:8924 with SMTP id 4fb4d7f45d1cf-647897aceffmr2310505a12.16.1764676337726;
        Tue, 02 Dec 2025 03:52:17 -0800 (PST)
Received: from amikhalitsyn.lan (p200300cf5702200011ee99ed0f378a51.dip0.t-ipconnect.de. [2003:cf:5702:2000:11ee:99ed:f37:8a51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647510519efsm15206765a12.29.2025.12.02.03.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 03:52:17 -0800 (PST)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: kees@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Tycho Andersen <tycho@tycho.pizza>,
	Andrei Vagin <avagin@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
	Tycho Andersen <tycho@kernel.org>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Subject: [PATCH v2 4/6] seccomp: handle multiple listeners case
Date: Tue,  2 Dec 2025 12:51:56 +0100
Message-ID: <20251202115200.110646-5-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251202115200.110646-1-aleksandr.mikhalitsyn@canonical.com>
References: <20251202115200.110646-1-aleksandr.mikhalitsyn@canonical.com>
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
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Tycho Andersen <tycho@tycho.pizza>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Stéphane Graber <stgraber@stgraber.org>
Reviewed-by: Tycho Andersen (AMD) <tycho@kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 kernel/seccomp.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index ded3f6a6430b..262390451ff1 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -448,8 +448,21 @@ static u32 seccomp_run_filters(const struct seccomp_data *sd,
 
 		if (ACTION_ONLY(cur_ret) < ACTION_ONLY(ret)) {
 			ret = cur_ret;
+			/*
+			 * No matter what we had before in matches->filters[],
+			 * we need to overwrite it, because current action is more
+			 * restrictive than any previous one.
+			 */
 			matches->n = 1;
 			matches->filters[0] = f;
+		} else if ((ACTION_ONLY(cur_ret) == ACTION_ONLY(ret)) &&
+			    ACTION_ONLY(cur_ret) == SECCOMP_RET_USER_NOTIF) {
+			/*
+			 * For multiple SECCOMP_RET_USER_NOTIF results, we need to
+			 * track all filters that resulted in the same action, because
+			 * we might need to notify a few of them to get a final decision.
+			 */
+			matches->filters[matches->n++] = f;
 		}
 	}
 	return ret;
@@ -1362,8 +1375,24 @@ static int __seccomp_filter(int this_syscall, const bool recheck_after_trace)
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
+			 *
+			 * Note, that if there are multiple filters returned
+			 * SECCOMP_RET_USER_NOTIF, and final result is
+			 * SECCOMP_RET_USER_NOTIF too, then seccomp_run_filters()
+			 * has populated matches.filters[] array with all of them
+			 * in order from the lowest-level (closest to a
+			 * current->seccomp.filter) to the highest-level.
+			 */
+			if (seccomp_do_user_notification(match, &sd))
+				goto skip;
+		}
 
 		return 0;
 
-- 
2.43.0


