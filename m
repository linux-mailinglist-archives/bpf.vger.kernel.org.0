Return-Path: <bpf+bounces-26711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2D98A3EA1
	for <lists+bpf@lfdr.de>; Sat, 13 Apr 2024 23:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E09FB1F213A6
	for <lists+bpf@lfdr.de>; Sat, 13 Apr 2024 21:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4662957310;
	Sat, 13 Apr 2024 21:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b="E9arffBQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R92ttszp"
X-Original-To: bpf@vger.kernel.org
Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE34756B7A;
	Sat, 13 Apr 2024 21:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713042799; cv=none; b=D4VK8kg57m9AKqR7qMwIiXxGQ/8sbfdImhGyJKfH4TdqKisbG+W5FwzJJIlcON/SutF5ehXHfzPIohAmtcLyalcOIWw7z+KMwz6G+C2roKC/yXBLpfyVspT5Hzh4vz2NjidfNurFMduyX3SHpQuMok/tZGUYam6tSA+iC5k+BDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713042799; c=relaxed/simple;
	bh=XLox6UtpxNNViuhE/NDra0lioJOlzF3C0YrXvofTdgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DmgYoZ5bpEmFf6ExrxvrqWMCtUsgNiSIsEC33Zan1b6SIaQ/lSOzA94LK5NkkstDo8YXWjaxYUDqqP/CoAmHQ7fjF2WEDkrw+akdpRehAbUwK6VRuos4uFc5rO7i1rLZTSQ83+Fqmuf7sJg54hIQf7gSirhKRdTMovl0qYBNjlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de; spf=pass smtp.mailfrom=naccy.de; dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b=E9arffBQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R92ttszp; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naccy.de
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 6919E1C000F3;
	Sat, 13 Apr 2024 17:13:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 13 Apr 2024 17:13:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=naccy.de; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1713042794; x=
	1713129194; bh=x9bMflE1VBqipkYwFyM5kAoaLsmNkwYcPLOiqTA4+lc=; b=E
	9arffBQkErqwyEZdWFovtua/5raeNnSZ1xWOsGubC98lFyJcqm3hwtjG1Q6n8K5L
	TtS+5Abds7t6VNGxUBn2jvZ30mJtSvSMZtFFh5bsrAeuUio5NZ50O0qvZrboq4+v
	hGJ7BlO4+TwO+f8v1x2hPPGl43NSXkU/kHlFq9jpa5WL0o8oU3ypMCzeQS6418b0
	JTy8ZlFL3jqGUtfBKs9jzj9St3R81hxnPsJjnrV0MBWwvWePVYfKLhUJdJ9iZ6qt
	OkYjuhdVbEEYvCjmNJrshpZ6SVy4NctFGLTHGFPtWfNHB8ezeliwaembksnIfSNw
	gCbHazQ5PdibDH4Nzo81w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1713042794; x=
	1713129194; bh=x9bMflE1VBqipkYwFyM5kAoaLsmNkwYcPLOiqTA4+lc=; b=R
	92ttszpXK6uq685UbSmsEqJpJquDBFoz4llvPrc5NB6x1iuycHgz8UQxcsXnO3EQ
	NEAoWY0eDGqZZtVL8jM8HNRlaseWRNKisUAbvHYr6xkI+JPnTVXlRica/0WmHkq9
	a61ZjqZC0qZNcbUXxYT74u81/leAoAB3DNjgoq8czeII8npuuCNmnl216t2fUaPQ
	f8RNx0b/dmyCWZkTUJ/dP7f2Ypz62s3emCmslofnrtLNtJYwGF1rqmbiTQ5h5RL8
	uQAUvBD+u0s+PelncJhGLtuwPCpPRVGQa2dEJ+AGz0uuB+tMYiDo+Wm0x82MSiM9
	OH3ir0EvZYvIp4TXqVekg==
X-ME-Sender: <xms:avUaZhahJJ49ijkL0hzlrd-klRlRsRwcd3Z-UFz4YdLOud94SGUOzg>
    <xme:avUaZoZ2kBqAArO5L6mMd5q69TCigX4y-sHk0Cw6_RqGMA-G48VGC-D1g0zHMWTuo
    P-e4ZHKCLaY_ithfFc>
X-ME-Received: <xmr:avUaZj8z54ij4wFHwwXrTXDk-guXUHE6rxR6Vadpyz9IEAed6fnDBNlYPMqSpGfEUkPVKFsn8hZ0RkHUMRl3rU1AjLPf9RCLPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeiiedgudeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefsuhgv
    nhhtihhnucffvghslhgrnhguvghsuceoqhguvgesnhgrtggthidruggvqeenucggtffrrg
    htthgvrhhnpeevieehjedtveevueeujedtveehtddugfeukeeffeettddttddtleehudeh
    feetleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hquggvsehnrggttgihrdguvg
X-ME-Proxy: <xmx:avUaZvrXcid039Ant9Llg1Aw1aijiMlDV9Nbttpds7OgWLXoQnZOqw>
    <xmx:avUaZspVrBwTUgKooT304z_2o_PzijqFF30dOAY0tMorRb0loifq3Q>
    <xmx:avUaZlSfks0Ykr34Uw5XhZmNz29Pve4I-f_dH0Ms4cSH9-Zpef-2vQ>
    <xmx:avUaZkrgoG4BFiPmeVm4M2GDe726EwP8vUo9hdp-UptDYPoqDOIXog>
    <xmx:avUaZqbdtlMWdmsvZWIozwCx2FhMJFEnl2h9vsP3QVVWNJT5qvx3yAEi>
Feedback-ID: i14194934:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Apr 2024 17:13:12 -0400 (EDT)
From: Quentin Deslandes <qde@naccy.de>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Quentin Deslandes <qde@naccy.de>
Subject: [PATCH 2/2] libbpf: fix dump of subsequent char arrays
Date: Sat, 13 Apr 2024 23:12:58 +0200
Message-ID: <20240413211258.134421-3-qde@naccy.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240413211258.134421-1-qde@naccy.de>
References: <20240413211258.134421-1-qde@naccy.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When dumping a character array, libbpf will watch for a '\0' and set
is_array_terminated=true if found. This prevents libbpf from printing
the remaining characters of the array, treating it as a nul-terminated
string.

However, once this flag is set, it's never reset, leading to subsequent
characters array not being printed properly:

.str_multi = (__u8[2][16])[
    [
        'H',
        'e',
        'l',
    ],
],

This patch saves the is_array_terminated flag and restores its
default (false) value before looping over the elements of an array, then
restores it afterward. This way, libbpf's behavior is unchanged when
dumping the characters of an array, but subsequent arrays are printed
properly:

.str_multi = (__u8[2][16])[
    [
        'H',
        'e',
        'l',
    ],
    [
        'l',
        'o',
    ],
],

Signed-off-by: Quentin Deslandes <qde@naccy.de>
---
 tools/lib/bpf/btf_dump.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 6a37e8517435..5dbca76b953f 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -2032,6 +2032,7 @@ static int btf_dump_array_data(struct btf_dump *d,
 	__u32 i, elem_type_id;
 	__s64 elem_size;
 	bool is_array_member;
+	bool is_array_terminated;
 
 	elem_type_id = array->type;
 	elem_type = skip_mods_and_typedefs(d->btf, elem_type_id, NULL);
@@ -2067,12 +2068,15 @@ static int btf_dump_array_data(struct btf_dump *d,
 	 */
 	is_array_member = d->typed_dump->is_array_member;
 	d->typed_dump->is_array_member = true;
+	is_array_terminated = d->typed_dump->is_array_terminated;
+	d->typed_dump->is_array_terminated = false;
 	for (i = 0; i < array->nelems; i++, data += elem_size) {
 		if (d->typed_dump->is_array_terminated)
 			break;
 		btf_dump_dump_type_data(d, NULL, elem_type, elem_type_id, data, 0, 0);
 	}
 	d->typed_dump->is_array_member = is_array_member;
+	d->typed_dump->is_array_terminated = is_array_terminated;
 	d->typed_dump->depth--;
 	btf_dump_data_pfx(d);
 	btf_dump_type_values(d, "]");
-- 
2.44.0


