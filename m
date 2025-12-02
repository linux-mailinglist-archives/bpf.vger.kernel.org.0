Return-Path: <bpf+bounces-75874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEFBC9B60B
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 12:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 94D7E4E3C41
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 11:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D617F313540;
	Tue,  2 Dec 2025 11:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="Wzp8t92u"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F7C313526
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 11:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764676349; cv=none; b=YyoZrXWrnu/S1SDgBSxV8kuvs8uoW9Y/cYobFehMVp4xpwTOV2FfVaWHho3aMUFSVDWmW4QF+kBaj9snNfdNccGexHu5FVDqFr3Wcdl9MgxCrXEpwV10MOa5RI7bTgJKsB1JSLnF9CTOchMrs5SYFzUlDkC96FGywHEuGOgt/OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764676349; c=relaxed/simple;
	bh=WHNHmF8hIKZpzmu+nrdrjtELRB6j+VLgb2GCwkat2Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tej32S1ITWLSGNbsh0KPo7OVjnq8L9u9EMeOpZkwthlGaePLRbXHY9EaifHgx9kbu5SsyS1MKMxc/KTuK3CI2ej1dNgEG7lpj0vh7WkFhE4EY9nV3CoUi/DiQHQGJsjvwrcRF4N1EKr+vAFzmrHNgMJvigYhKF5EH8Ep91oURO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=Wzp8t92u; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6DEA73F592
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 11:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1764676340;
	bh=Ao9gzuH4BGTjv5LjAckU+RfPM0upQZdwIhj7zaaLSko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=Wzp8t92uFrSlsaXrlEn83iy4n4pnppYBOf5STM3X57kVFvFl23iRIoP46QvYU2uTN
	 tFyDxmfSsb3cTeMHZYlk1HYaMYLsJJJSt0q9CtXpzQNTwNj2f23basosHP8plURlMi
	 yqGwt8hS/HlU3NrHtj2LrSwtXcjYXeLgogXdrK+0j2u1KJhTAEzHxsOV+vp7sUo3G8
	 nKMRc7zqHh4tIrIr3Yu738ZqAFQOZ84aTYLXHRL6kFm2/feUoTyNlhbdSuDDHg0Z84
	 ZR4eM0Y6F+DDmNUOVK+FsyrEHpxPwHfbvGDdIiOdTgft35v/w6jlNihq38aMSgUVG5
	 V1OV5CrCwVtQ+XLLWztdgIu4iYiZtZCmbDWSmzEYBrvoLang0gd2YLqmW+Vz36/OMY
	 OZ3yp/Z+Ju/58c+cRtDWQsg6PfTSdZCMEmAggd+vT2vj0NMMRc/ZLFlgNlLp/vz2i7
	 VWk8X6fBxYoksEdstaSR7ZW+IfgRumn+u6lXkFFs7/eis592xmWCv5RcgQVAWNYpxk
	 G9kR/AIedmD4igFBtSKWb77I3VAWmDBIlrcjbdIvGDhM57owu7sqfEA7w6fxCfo0VZ
	 ABEDsf2isHh4Qd8glYYAPnu5CXcQdhABPi3xDoX9OG1wsBhb1GD6tDM7KFZAVus/BL
	 MpxeaeJpU5TnBsiwmKJtk9EM=
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-640b8087663so2351506a12.3
        for <bpf@vger.kernel.org>; Tue, 02 Dec 2025 03:52:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764676336; x=1765281136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ao9gzuH4BGTjv5LjAckU+RfPM0upQZdwIhj7zaaLSko=;
        b=dErhrQBo9cAaRumsXxpQO6mluXTwdM3/VL+gogKkboCxfnCCXgDtlCcQyojsTqfizw
         U9DwkApMhCqBZsggBX2s1mDJ6rSlgs2p9vw4+VDCPzzT+xtKxEfZvgGi/+DpjhpFnSEW
         iwixeDcZ4+b64HVNS5EXoFab7bskROsUBhbGUm1DVmHl6l1lb/+m2AG5gWcXQRgJis/S
         p5GpJ1FwVCs3EN1TCprhW6hf5/GX7gniG6VBI/Mr4prpBLkoWMFGwpcrHBBn3vOSVpf9
         03M9WUOu3i1Zcbvs3mKy0VnjYShr1glCGgb2HeczgdXp98o+N6RDqacosroLsO/1PBtE
         7kFg==
X-Forwarded-Encrypted: i=1; AJvYcCWNBUpRS5NecuFw4dGNOjlbPmfBZgpr680URhrtQ+1QHj2VBbCFN6NP2xNgYe7rPH9kWF0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3I2YWCYGRowOt14JG7GKD4i3wMgXFbkGT3thxnh6buYLTE5fd
	ZbILEi7z0Jujv4PX8xI5YxcCq6Y2EO0sV7oMs8twAAu6ksi9EeIWbk8tXLQiJEdKDkZJMhNfwdO
	LiL0NmUa4wIayc+BumQ3eqPvLG6My1ccBZAz5fEMhdCmsC0ShqzlV3EX75ns55SB/o1mbog==
X-Gm-Gg: ASbGncuYrXd0iz3ZjDHpq68+GXb50u14TuStTdQhohvo9Q8cZlQLfd8EA0fP3KuBJsp
	Y2Pb8ZZO9HRPz5TYllmCDlSK41Q6sOsF6eqfR7yigDC0BQ7eeTWUX5JOyz3SMwztPNz1wOUPSj3
	ESh02dnUDkAegzDDCQ+iJDANvZadLmsL16pxvnqBaj5FYPoKqdY+dG/5xq0K8hvlMcd9jwZuveF
	4CfI67sdRHC3/emrTEkn/jEz5OOuri0LaaAlzKxWhfvLggf2ZSrCLJ9ia2B+EKmIepbsMdZGfKb
	lPGaP6BF5A1a6hl+CSfsb8b9+IZ6JY10B479iLMHjUCNLcMc6oxFFzc6BHocw2E9AaJbRY+W9d3
	0B9JN6oBdLyF6KIvHFa+NxnSMeU3vmSeFE3G2uyh/i4N+utReHzdwutxCAUEtf3QOZQpcr3MQjJ
	C4r2CbXsUJ3gqWcj/Y6SPPf94=
X-Received: by 2002:a05:6402:5346:10b0:640:c9ff:c06a with SMTP id 4fb4d7f45d1cf-645eb2530camr26516062a12.15.1764676336433;
        Tue, 02 Dec 2025 03:52:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0dPM+LONfO5/1YrOnVnNAEeubJe6IeVmz26gJepHDWE6FmTwEDfIbV84I+xJ8HFdBhqNWBw==
X-Received: by 2002:a05:6402:5346:10b0:640:c9ff:c06a with SMTP id 4fb4d7f45d1cf-645eb2530camr26516030a12.15.1764676335989;
        Tue, 02 Dec 2025 03:52:15 -0800 (PST)
Received: from amikhalitsyn.lan (p200300cf5702200011ee99ed0f378a51.dip0.t-ipconnect.de. [2003:cf:5702:2000:11ee:99ed:f37:8a51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647510519efsm15206765a12.29.2025.12.02.03.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 03:52:15 -0800 (PST)
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
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Subject: [PATCH v2 3/6] seccomp: limit number of listeners in seccomp tree
Date: Tue,  2 Dec 2025 12:51:55 +0100
Message-ID: <20251202115200.110646-4-aleksandr.mikhalitsyn@canonical.com>
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

We need to limit number of listeners in seccomp tree to
MAX_LISTENERS_PER_PATH, because we don't want to use dynamic
memory allocations in a very hot __seccomp_filter() function
and we use preallocated static array on the stack.

Also, let's return ELOOP to userspace if it attempts to install
more than MAX_LISTENERS_PER_PATH listeners, instead of ENOMEM as
we do when userspace hits the limit of cBPF instructions.
This will make uAPI a bit more convenient.

Notice, that has_duplicate_listener() check is still in place, so this
change is a preparational.

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
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 kernel/seccomp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index c9a1062a53bd..ded3f6a6430b 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -931,17 +931,25 @@ static long seccomp_attach_filter(unsigned int flags,
 				  struct seccomp_filter *filter)
 {
 	unsigned long total_insns;
+	unsigned char total_listeners;
 	struct seccomp_filter *walker;
 
 	assert_spin_locked(&current->sighand->siglock);
 
-	/* Validate resulting filter length. */
+	/* Validate resulting filter length and number of nested listeners. */
 	total_insns = filter->prog->len;
-	for (walker = current->seccomp.filter; walker; walker = walker->prev)
+	total_listeners = filter->notif ? 1 : 0;
+	for (walker = current->seccomp.filter; walker; walker = walker->prev) {
 		total_insns += walker->prog->len + 4;  /* 4 instr penalty */
+		total_listeners += walker->notif ? 1 : 0;
+	}
+
 	if (total_insns > MAX_INSNS_PER_PATH)
 		return -ENOMEM;
 
+	if (total_listeners > MAX_LISTENERS_PER_PATH)
+		return -ELOOP;
+
 	/* If thread sync has been requested, check that it is possible. */
 	if (flags & SECCOMP_FILTER_FLAG_TSYNC) {
 		int ret;
-- 
2.43.0


