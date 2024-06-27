Return-Path: <bpf+bounces-33245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3211F91A314
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 11:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638E21C20D70
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 09:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5104713B5B8;
	Thu, 27 Jun 2024 09:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNJt4Uny"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B1A7D3E3;
	Thu, 27 Jun 2024 09:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719482064; cv=none; b=t+fyJJHi3j/9IXLeG6ezyNoyWENt69DupE5nqmw8dPMNnK17QAKuKY9kn4OJNz/nAMRL0jnt4H1OmwaYSClmuV5vsnE17a+/Iv/TgcVv8l7qBV0RuGI3tUI+uwPz1s/5LrlyhoMz5ZOCZp1pm6tUuc7/Ya0F11YSwLGowlwJmJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719482064; c=relaxed/simple;
	bh=xjtzYnqKG36+sIlL6ZglMNN0MTUtrgNF5PIFt7d6ks0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FH+/GdZ6y9to4kE81ovR0MbE5Ql71GHbMuO85gfW+W2mMyO4dg5W7i8jbpDd/VH7vHO5nK0f0KOzuRL5jNE7GOLCI0vlRD6fNUxq4yelXa9beUDegpS1uphpgBjpsyKiw6vJFpS1w8jJLl9iG3wHQKf7UcJrgqY2z9ebHH6PvZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNJt4Uny; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8256C2BBFC;
	Thu, 27 Jun 2024 09:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719482064;
	bh=xjtzYnqKG36+sIlL6ZglMNN0MTUtrgNF5PIFt7d6ks0=;
	h=From:Subject:Date:To:Cc:From;
	b=RNJt4UnyIzGtbLspfcLWqceihZvervEv67qhw/r7/wYT/whRp77Jhtj34JCgc1P0L
	 YtN1l/vKgOhRrMhaNXP98RBs9hM1cIayfga1jAC1XsjQCGRFBlZzgGIpGmnsOOI696
	 5j2I78FYkZUisQ0qsXN50md5oGu0ckprTxhT9NrGHF4tPsT6unX2zgqGvitYHpt55u
	 wATXgoe1SXVI7XOSuhOHzf9jVYxtR8HPutjcJ67QBHUxkN6E2+TqSJZXa2R0KrXM8B
	 N9acy10LWAT+qYkCfXpWpkjEl6AV8gbgc36RCisdPJKyixh/iTrzqacXbqr8eDlPgd
	 oXBHuZscEx/Aw==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH 0/6] HID: bpf: import some more fixes from udev-hid-bpf
Date: Thu, 27 Jun 2024 11:54:16 +0200
Message-Id: <20240627-import-bpf-v1-0-0dbcda4a5b1f@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMk2fWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMyNz3czcgvyiEt2kgjTdNGPTtMRES9Mkc8MUJaCGgqLUtMwKsGHRsbW
 1ALYa28pcAAAA
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 bpf@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>, 
 =?utf-8?q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>, 
 K S Iyer <kumar.s.iyer65@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719482062; l=1778;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=xjtzYnqKG36+sIlL6ZglMNN0MTUtrgNF5PIFt7d6ks0=;
 b=847TuePgVrbLAJhH6/xFhKEe+7jc1GuFCTM8wxb9tL20x+GgdmUH3fpGWUE7K4dBKE5I+3F1w
 bsws6APG3x2DeUPnqcpl0rpujEktjuRLV8uZ22MbHSRElnFOqkFjJME
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

This is a batch update to sync up the testing directory of udev-hid-bpf
and the kernel. The development happens there, and once we are happy,
we merge the bpf there, and then sync up with the kernel.

I've added all of the signed-off by from the various authors, as we
require them there as well.

Currently I don't have full testing for those new bpfs, but the current
test_tablets.py that I'm using for the 2 Artist 16 and 24 are not really
testing the correct bits, as we are more fixing buttons and plain stylus
reports than interactions between stylus and buttons.

Cheers,
Benjamin

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
Benjamin Tissoires (6):
      HID: bpf: Add a HID report composition helper macros
      HID: bpf: add a driver for the Huion Inspiroy 2S (H641P)
      HID: bpf: move the BIT() macro to hid_bpf_helpers.h
      HID: bpf: Add support for the XP-PEN Deco Mini 4
      HID: bpf: Add Huion Dial 2 bpf fixup
      HID: bpf: Thrustmaster TCA Yoke Boeing joystick fix

 drivers/hid/bpf/progs/Huion__Dial-2.bpf.c          |  614 ++++
 drivers/hid/bpf/progs/Huion__Inspiroy-2-S.bpf.c    |  534 ++++
 .../bpf/progs/Thrustmaster__TCA-Yoke-Boeing.bpf.c  |  144 +
 drivers/hid/bpf/progs/XPPen__Artist24.bpf.c        |    2 -
 drivers/hid/bpf/progs/XPPen__DecoMini4.bpf.c       |  231 ++
 drivers/hid/bpf/progs/hid_bpf.h                    |    1 +
 drivers/hid/bpf/progs/hid_bpf_helpers.h            |    1 +
 drivers/hid/bpf/progs/hid_report_helpers.h         | 2960 ++++++++++++++++++++
 8 files changed, 4485 insertions(+), 2 deletions(-)
---
base-commit: d3e15189bfd4d0a9d3a7ad8bd0e6ebb1c0419f93
change-id: 20240627-import-bpf-f35faa95b71d

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


