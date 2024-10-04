Return-Path: <bpf+bounces-40999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDEE990DFB
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 21:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63762288E7C
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 19:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2534D219C99;
	Fri,  4 Oct 2024 18:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VaM22kAk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F729219C92;
	Fri,  4 Oct 2024 18:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066537; cv=none; b=XmxzPI697mxDIBFb6NXEHoUGIzLiGZnUrnPA5wq42Z+DFLJzvqW7XyXaSaNJt6x7QmuSGO1hW7Kg3LYw5UOu1OqX+eJ8KE0DEjKTje0M/k2NQdoVPC41VmyqmFoz/sbNJ6pfBlToPFo+GSgyO+26JXUtn+2Uo5TcQx9ShyuX4yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066537; c=relaxed/simple;
	bh=c3W13BTVp91ByV6gxJQYghmYoKQFhYCaW2S2Ach2PcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lJ9VT/rFregHeV/p1ag5iU3itYtKrBfZz8OQ5C61GrPbLiDHow6FY62tGs6YmNu5duOCY1V+Y8UkWykGDwdX4tzhm6q1HtgzX5Y+H+HilqGIGIOG1hJDhlRCrQx6jPuTodPS+8hFu0Ua8C5FA7hB45DzwBUJO+OtbmO4+6eLxdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VaM22kAk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0BFC4CEC6;
	Fri,  4 Oct 2024 18:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066537;
	bh=c3W13BTVp91ByV6gxJQYghmYoKQFhYCaW2S2Ach2PcY=;
	h=From:To:Cc:Subject:Date:From;
	b=VaM22kAkhwth/xjolzsL8fs/Nkcd+rADCQ877EVPTHK9nGV8h1lZYetGwvWNLJn7s
	 WPQpux+tnto7xaBAkaeUV2gDHhSZpf5OXaSy4pzSpkONbQzKwp4aGxhDCxU9hyxWT5
	 tcyeLlVyzKgHbqZ9jw41T5OOYni7XMIFTfK7Hvi91XouUDotJdfs9YVhL/mS7rOm29
	 DzkWPyLg1v8y8MNxJ3VZynuvSyfWUgp6b940U36SYVPou7BI4uDdNIXzmkUxCYaVbz
	 mi6hgTZIxsiYMtoWG0lb+UM/Lv5spXKm0Bf61SxjbYBMCNZz8ii/JknrpSuX7mG3Zg
	 c3vKX/MSpC0DA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tao Chen <chen.dylane@gmail.com>,
	Jinke Han <jinkehan@didiglobal.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 01/31] bpf: Check percpu map value size first
Date: Fri,  4 Oct 2024 14:28:09 -0400
Message-ID: <20241004182854.3674661-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.167
Content-Transfer-Encoding: 8bit

From: Tao Chen <chen.dylane@gmail.com>

[ Upstream commit 1d244784be6b01162b732a5a7d637dfc024c3203 ]

Percpu map is often used, but the map value size limit often ignored,
like issue: https://github.com/iovisor/bcc/issues/2519. Actually,
percpu map value size is bound by PCPU_MIN_UNIT_SIZE, so we
can check the value size whether it exceeds PCPU_MIN_UNIT_SIZE first,
like percpu map of local_storage. Maybe the error message seems clearer
compared with "cannot allocate memory".

Signed-off-by: Jinke Han <jinkehan@didiglobal.com>
Signed-off-by: Tao Chen <chen.dylane@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20240910144111.1464912-2-chen.dylane@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/arraymap.c | 3 +++
 kernel/bpf/hashtab.c  | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index c76870bfd8167..2788da290c216 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -74,6 +74,9 @@ int array_map_alloc_check(union bpf_attr *attr)
 		 * access the elements.
 		 */
 		return -E2BIG;
+	/* percpu map value size is bound by PCPU_MIN_UNIT_SIZE */
+	if (percpu && round_up(attr->value_size, 8) > PCPU_MIN_UNIT_SIZE)
+		return -E2BIG;
 
 	return 0;
 }
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index f53b4f04b935c..d08fe64e0e453 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -464,6 +464,9 @@ static int htab_map_alloc_check(union bpf_attr *attr)
 		 * kmalloc-able later in htab_map_update_elem()
 		 */
 		return -E2BIG;
+	/* percpu map value size is bound by PCPU_MIN_UNIT_SIZE */
+	if (percpu && round_up(attr->value_size, 8) > PCPU_MIN_UNIT_SIZE)
+		return -E2BIG;
 
 	return 0;
 }
-- 
2.43.0


