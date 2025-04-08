Return-Path: <bpf+bounces-55447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8918FA7F8CD
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 11:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 450247A9A89
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 09:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1459264610;
	Tue,  8 Apr 2025 09:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTKH22s+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797B92641D7
	for <bpf@vger.kernel.org>; Tue,  8 Apr 2025 09:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744102858; cv=none; b=s0YULN6jn0LslCJs7gEAD5PHV8TgKkPTFrRd5Unq6jdXe5k2jHpCF4uGcSYKkAJ85c2OO0L8Fng0LHTJV/JFafgVciRdX8SUjhcDB9x8fpEPNng3iDrpopvf4pETk2EaIwMmGPxQiNodu3S5M1Iei22+TNAeTEb7evKb+8bYxyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744102858; c=relaxed/simple;
	bh=c83TZ4jSKABzhkQCUXoca9OE9cP3DZ7PDolQQhKJPDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HIKviGcvRQVvnHvFyf+0u9mGJjFH8e+upAOQ8evjCi63LvRWNnIeYbVfnK5d/ARE0BGd12Tx9IhmE2KoPldnB1fkSC9jICx3N1w3mH+TobR31g2PXzYbRh4CspdGNFQBRxCfNyb9QJa+ZtDE7feEhK8TRAqdNXQ/rR+PIFJ3PL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTKH22s+; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39ac8e7688aso3923140f8f.2
        for <bpf@vger.kernel.org>; Tue, 08 Apr 2025 02:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744102854; x=1744707654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FtVaHJRwJKxr5rNrk6bl6iL6//WQ89HK4FME6lsGodE=;
        b=iTKH22s+BDmJny6mPsqZSljps+CW9CoU2UVaF8ay+99xYFLOWO9mtwWSMlBBMxBgjR
         NdZm/1M0XzDZBEPsSDpyRmeHwfvW/+sYPENfNq+n0DAQT7r/05GpWqGB9WSQOvJxZ2J3
         YXVAnpfAaS+YFTCsXg0XG41aqzvfb4RkALx0UKhMkbPs0qw5vn6CZWhiQe3Klv6eF788
         1HXHhhNBJfvNlW+OfOOXbvP8xVO8LOKigLcqoFUWbioEgb7ol2AR2dMhpk8zM7TEERo5
         x4iIf5QwmHxBzuvadNDNiCOO9FmM005hhvpP4xgBC1inKswdxb3mt7d0EkE00ao3Jf/R
         juNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744102854; x=1744707654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtVaHJRwJKxr5rNrk6bl6iL6//WQ89HK4FME6lsGodE=;
        b=wqxktYPQfLeqS/+derAggqSpLmwWXgVuyGC7kWYIcm9ft4HnUK/lYkY7hNTcyYRZDo
         PMtcIRSHppNnQ4oe3ffXfyYpV+SBsiQj7BkSsCcV0D8p6Bww3kbZrRObu61Srgf9kqjC
         dxcKR5nFTopTcfHSX/ytFbGHfq718a/6M8or3ooo9eS28p1ndhnAgQZX8QhGS4Uy1Fmw
         bmfT3Lw06dAhJcxVkZHG4b0v1iI6SJL5l7/mJcSfLX/61+GiQ+2/gAuZ5O3sNO8pemE8
         WWingtYjh/2Vl/jQvZB5ui1QSGTdnVUM7un4vhHbrQJKo7UcAdI9kpGlZ5DyySBsztXz
         1uCg==
X-Gm-Message-State: AOJu0YyWRb7Pn85kPzKcXbexKiEedHPSl+lREqVqb075JvBeoztG3ItF
	c3RoKkyttljkeSfm3GUaV0ED6cnZxbKvWLn5OmPuWiHyeBO3msf0n8cASw==
X-Gm-Gg: ASbGncvrgq/a0N3hviWQfFe8oF30j0aKZfKCk1VldiBVRFV+vWmD6CtZOgaCFZRp+uW
	OHcnSQktaMp2UTCHYEuQgDFODK/4CWpESnFCBBO8Ig2SlO/3uP+fi/5TbzE+sJ1U/sOFG9D5CYV
	5hH9GQz90ncoOiyOqZ3vYwpxfMz/UDEbmeTOgZYL3hHz1PXrSy4u6H2CnXDGWEXdIvml8o5QnEs
	SYO4XrXDxaD8qkfTsB8toYJLiN4sujbpHOJ59b/1WPZJNfm0zRL3uMur+tuO+rzFDeE9JmYJqaw
	QwgYMWemzCms+5qurxhkq6hNj/UPNoBOGZU+9kYnvYD226VYBuj9TLuQulCK1bjMZXDo16fuje/
	xI04XTi9icyQ2UTlJTxUNAGsx2LHd7FC7/dex92K3y7M=
X-Google-Smtp-Source: AGHT+IHXJf8gSaWjXnDrr44PODMB74onV6GCNLHm4O4PiKf1pGxwVv5dXIc/qcmDLZmQyjDEQneAfw==
X-Received: by 2002:a05:6000:4310:b0:391:3bba:7f18 with SMTP id ffacd0b85a97d-39d6fc01096mr9650589f8f.12.1744102853563;
        Tue, 08 Apr 2025 02:00:53 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0024496da6ab48450e.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:2449:6da6:ab48:450e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34af0e6sm156518475e9.16.2025.04.08.02.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 02:00:52 -0700 (PDT)
Date: Tue, 8 Apr 2025 11:00:51 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 2/2] bpf: Clarify the meaning of BPF_F_PSEUDO_HDR
Message-ID: <5126ef84ba75425b689482cbc98bffe75e5d8ab0.1744102490.git.paul.chaignon@gmail.com>
References: <ff6895d42936f03dbb82334d8bcfd50e00c79086.1744102490.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff6895d42936f03dbb82334d8bcfd50e00c79086.1744102490.git.paul.chaignon@gmail.com>

In the bpf_l4_csum_replace helper, the BPF_F_PSEUDO_HDR flag should only
be set if the modified header field is part of the pseudo-header.

If you modify for example the UDP ports and pass BPF_F_PSEUDO_HDR,
inet_proto_csum_replace4 will update skb->csum even though it shouldn't
(the port and the UDP checksum updates null each other).

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 include/uapi/linux/bpf.h       | 2 +-
 tools/include/uapi/linux/bpf.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 9c184a66ebcd..0cebb0a83541 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2055,7 +2055,7 @@ union bpf_attr {
  * 		untouched (unless **BPF_F_MARK_ENFORCE** is added as well), and
  * 		for updates resulting in a null checksum the value is set to
  * 		**CSUM_MANGLED_0** instead. Flag **BPF_F_PSEUDO_HDR** indicates
- * 		the checksum is to be computed against a pseudo-header.
+ * 		that the modified header field is part of the pseudo-header.
  *
  * 		This helper works in combination with **bpf_csum_diff**\ (),
  * 		which does not update the checksum in-place, but offers more
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 9c184a66ebcd..0cebb0a83541 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2055,7 +2055,7 @@ union bpf_attr {
  * 		untouched (unless **BPF_F_MARK_ENFORCE** is added as well), and
  * 		for updates resulting in a null checksum the value is set to
  * 		**CSUM_MANGLED_0** instead. Flag **BPF_F_PSEUDO_HDR** indicates
- * 		the checksum is to be computed against a pseudo-header.
+ * 		that the modified header field is part of the pseudo-header.
  *
  * 		This helper works in combination with **bpf_csum_diff**\ (),
  * 		which does not update the checksum in-place, but offers more
-- 
2.43.0


