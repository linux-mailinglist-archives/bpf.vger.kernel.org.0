Return-Path: <bpf+bounces-58024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00261AB3BFD
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 17:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 208E0178F6F
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 15:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C4A23BCF7;
	Mon, 12 May 2025 15:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="kq7xXPUs"
X-Original-To: bpf@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAD322A4D5;
	Mon, 12 May 2025 15:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747063499; cv=pass; b=GdD70DM7Fc5ahrVxyw1j/I9q6KzMZUZ8g2TULdLSLmie9LQoeoCmqT1EATqcx/rjWXyGZy4+lRwa6jtmN4ZQNRDBcVzfjvv/xisL8AMsGmQdvC2UXToTi4ThaXMmwW6e7n55iJuhsyauzMtu8reBe2R4trtzbmgBOIpzI8lxUQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747063499; c=relaxed/simple;
	bh=Yk3qJ7PnVPpZB1RAu7pjQcpCRQODDLh8HcYjB68thjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QtU7ReZ1l14hfJoktR1AG0lotSWzatPVQKKPw4BumS+HydBXI2hpNeAbqGyNGiVT/Fgdh3qtFCMmj4r462DYKMzTk8r94iu9abaJDh00I3Mpl+sTkxIHpRjjMcbsGAP5ypxeAhtuEhXlVpCWnInyO6hRyNw8zcd1dDragh1Ov7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=kq7xXPUs; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1747063475; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=V2TDe44GeupcJaJTGSpJqvn74SV7zM6rLpnYXZQPWFXs8j2xEHipcXXcgIQEf2fFBnHdDjm64IAJ24LeyZdmbz0oMr3De1w3DjE/Ft5KCuyvnzHt+NSu5KezVZsPS8wE83/l2uhwqGYbD3oMRhunCgvvGVlbq43mgl04wRxCVPY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1747063475; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=LZIb4+PuBDi6Nw5meAJqz13pmghmwcuZWfBrl23htBg=; 
	b=Jd6LOtyy9FlI5UeEzzUsfI/joX2gV95ZjDw+O+RjdJ1KFBcq6jJ131fWSqB7W5glL2tpJKRexAIaBez5RO45FWqPZ5xk1c/K//vtIgyRz1MNdITfu6ks/6Pupv57HmZMpYSsVcq6lRmHlv4Tsdn/AugjtgGwDPU6cGeAtU1hf2Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1747063475;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=LZIb4+PuBDi6Nw5meAJqz13pmghmwcuZWfBrl23htBg=;
	b=kq7xXPUs5CPHqaplJ2VgXIEgeE4EEQzU638FiwIGWQ6EhocyoXEFdxAC0Wa759B5
	MeU5uBVLd9CTDdDwVcc+xkLea5TLMKaQhsRYl179/3JNF5qUBP4JqC5necBUrBco/YX
	/u+eecHvcJqGLmmQWSu9HIIjPaEBQHOuGlZVWL14=
Received: by mx.zohomail.com with SMTPS id 1747063472884519.2506243817122;
	Mon, 12 May 2025 08:24:32 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Rong Zhang <i@rong.moe>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Brian Gerst <brgerst@gmail.com>,
	Borislav Petkov <bp@alien8.de>,
	=?UTF-8?q?Petr=20Tesa=C5=99=C3=ADk?= <petr@tesarici.cz>,
	bugzilla-daemon@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] HID: bpf: abort dispatch if device destroyed
Date: Mon, 12 May 2025 23:24:19 +0800
Message-ID: <20250512152420.87441-1-i@rong.moe>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506145548.GGaBoi9Jzp3aeJizTR@fat_crate.local>
References: <20250506145548.GGaBoi9Jzp3aeJizTR@fat_crate.local>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The current HID bpf implementation assumes no output report/request will
go through it after hid_bpf_destroy_device() has been called. This leads
to a bug that unplugging certain types of HID devices causes a cleaned-
up SRCU to be accessed. The bug was previously a hidden failure until a
recent x86 percpu change [1] made it access not-present pages.

The bug will be triggered if the conditions below are met:

A) a device under the driver has some LEDs on
B) hid_ll_driver->request() is uninplemented (e.g., logitech-djreceiver)

If condition A is met, hidinput_led_worker() is always scheduled *after*
hid_bpf_destroy_device().

hid_destroy_device
` hid_bpf_destroy_device
  ` cleanup_srcu_struct(&hdev->bpf.srcu)
` hid_remove_device
  ` ...
    ` led_classdev_unregister
      ` led_trigger_set(led_cdev, NULL)
        ` led_set_brightness(led_cdev, LED_OFF)
          ` ...
            ` input_inject_event
              ` input_event_dispose
                ` hidinput_input_event
                  ` schedule_work(&hid->led_work) [hidinput_led_worker]

This is fine when condition B is not met, where hidinput_led_worker()
calls hid_ll_driver->request(). This is the case for most HID drivers,
which implement it or use the generic one from usbhid. The driver itself
or an underlying driver will then abort processing the request.

Otherwise, hidinput_led_worker() tries hid_hw_output_report() and leads
to the bug.

hidinput_led_worker
` hid_hw_output_report
  ` dispatch_hid_bpf_output_report
    ` srcu_read_lock(&hdev->bpf.srcu)
    ` srcu_read_unlock(&hdev->bpf.srcu, idx)

The bug has existed since the introduction [2] of
dispatch_hid_bpf_output_report(). However, the same bug also exists in
dispatch_hid_bpf_raw_requests(), and I've reproduced (no visible effect
because of the lack of [1], but confirmed bpf.destroyed == 1) the bug
against the commit (i.e., the Fixes:) introducing the function. This is
because hidinput_led_worker() falls back to hid_hw_raw_request() when
hid_ll_driver->output_report() is uninplemented (e.g., logitech-
djreceiver).

hidinput_led_worker
` hid_hw_output_report: -ENOSYS
` hid_hw_raw_request
  ` dispatch_hid_bpf_raw_requests
    ` srcu_read_lock(&hdev->bpf.srcu)
    ` srcu_read_unlock(&hdev->bpf.srcu, idx)

Fix the issue by returning early in the two mentioned functions if
hid_bpf has been marked as destroyed. Though
dispatch_hid_bpf_device_event() handles input events, and there is no
evidence that it may be called after the destruction, the same check, as
a safety net, is also added to it to maintain the consistency among all
dispatch functions.

The impact of the bug on other architectures is unclear. Even if it acts
as a hidden failure, this is still dangerous because it corrupts
whatever is on the address calculated by SRCU. Thus, CC'ing the stable
list.

[1]: commit 9d7de2aa8b41 ("x86/percpu/64: Use relative percpu offsets")
[2]: commit 9286675a2aed ("HID: bpf: add HID-BPF hooks for
hid_hw_output_report")

Closes: https://lore.kernel.org/all/20250506145548.GGaBoi9Jzp3aeJizTR@fat_crate.local/
Fixes: 8bd0488b5ea5 ("HID: bpf: add HID-BPF hooks for hid_hw_raw_requests")
Cc: stable@vger.kernel.org
Signed-off-by: Rong Zhang <i@rong.moe>
---
 drivers/hid/bpf/hid_bpf_dispatch.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index 2e96ec6a3073..9a06f9b0e4ef 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -38,6 +38,9 @@ dispatch_hid_bpf_device_event(struct hid_device *hdev, enum hid_report_type type
 	struct hid_bpf_ops *e;
 	int ret;
 
+	if (unlikely(hdev->bpf.destroyed))
+		return ERR_PTR(-ENODEV);
+
 	if (type >= HID_REPORT_TYPES)
 		return ERR_PTR(-EINVAL);
 
@@ -93,6 +96,9 @@ int dispatch_hid_bpf_raw_requests(struct hid_device *hdev,
 	struct hid_bpf_ops *e;
 	int ret, idx;
 
+	if (unlikely(hdev->bpf.destroyed))
+		return -ENODEV;
+
 	if (rtype >= HID_REPORT_TYPES)
 		return -EINVAL;
 
@@ -130,6 +136,9 @@ int dispatch_hid_bpf_output_report(struct hid_device *hdev,
 	struct hid_bpf_ops *e;
 	int ret, idx;
 
+	if (unlikely(hdev->bpf.destroyed))
+		return -ENODEV;
+
 	idx = srcu_read_lock(&hdev->bpf.srcu);
 	list_for_each_entry_srcu(e, &hdev->bpf.prog_list, list,
 				 srcu_read_lock_held(&hdev->bpf.srcu)) {

base-commit: 82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3
-- 
2.49.0


