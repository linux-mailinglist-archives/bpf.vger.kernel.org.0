Return-Path: <bpf+bounces-61682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F65AEA32E
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 18:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2829E56470D
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 16:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5031EA7CC;
	Thu, 26 Jun 2025 16:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaMPjkog"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD458632C
	for <bpf@vger.kernel.org>; Thu, 26 Jun 2025 16:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750954011; cv=none; b=TC+RpxXhpUaDa6WsOn/t1TyRp7/22IvZw/M+0SVMmgnnD9Rwhv+gGEQz3znAXbcAxjEKv9j8dDP1w04E/hvqgblnX0ruA5mjEO5kp6+FVtJh8MmVLEB4K083vxoEFQTtgLyr2Ejj4/rF3PoqTpEnSy2iSFZ5Eoo/oEmk1dOX5cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750954011; c=relaxed/simple;
	bh=CPv+h57roqoMlcIpiLcbaCIV52YfW3glAgWBhhfSIQE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=geKn3usgOU5/PjjHPb5xEstY5XQIoAhzACmS9pM9l8w6XNATwd99hpz0tgyshkUO8+WAqYeqI9Jj8aLZsk1l9ZAAA55KFaKC1j5myfdaREJCKrohNWC4hk2VuqZlA0Sba8sOEfQYCaUPt4zGjcSJ5fi1RsCrisA62aP82MtVqKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UaMPjkog; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-453634d8609so9144205e9.3
        for <bpf@vger.kernel.org>; Thu, 26 Jun 2025 09:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750954008; x=1751558808; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NBs2TD5EsOW9d9MYe/9/LhyEbhxsu9WLg4UzFZ75eGU=;
        b=UaMPjkogCwd9iVZEqbovQn3LI+CURncWau0Iqx8NvoZzdjEOWlEPab15O3G1+WShaS
         NB9zAmcbhBU+AIQVzdMQeTSoXPvWE2sa7hxMDu32TbpjuS4aE+anUV8xYy46k3L+6bi2
         A3la5APZa3uflVMxgUK8ssdL+GB/7agLnlNbNeM768rpLFsaS+dxheyXR9NkuOjjA+lk
         jQbXvj5JH4U9B2KRNJCxiMQa07jArpknEHzpIJKQk93P815TCkq2jMoLzlCl7BLqwy0v
         CWqqOXHJQPrTYVMyfbukBsYFV6stviytAusszqdreDptnStZrRgl/gjaEI5XC/LV97mK
         cEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750954008; x=1751558808;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NBs2TD5EsOW9d9MYe/9/LhyEbhxsu9WLg4UzFZ75eGU=;
        b=HXbEYxMbzuzBx/cW9ZiLK6ulSAcvxepo5ouMWJOOHIN2xMB/VWfqgPzYtdTqFGoNGB
         k3O04vSj+CwRJkVdKkn+NwAVVkg42QCOd1OpUbWCUlHj41vEwpPfYEIaL/gI0cxJklVv
         GiQGngi0TW3cxr0yNrYKpfCf7IhY6psD0X21p1riSZGF17MfCy5RE4dVPWvaZ1gAFm58
         W08XG/KNF+uTaoY02MSX4rq/7ZkCLH7mAwqx2BJ3Uzr9y5gxxsD77l3mrFiiuioVtxrd
         FhhPTcT0LHVxvZPV69p2OTEcFg7NfgZLT9BzJmQFm5oTW3Szv+bYKqubDpLzU9Oxj6Oe
         sNhg==
X-Gm-Message-State: AOJu0YwRaFYbf5SngxaqA6N0nWIfQRAhru+qzWVXhZogeIvC1r3ujjqp
	bcjtrC7Yr2+BIAHE57a3NkjUitRXs9bW0u8DBJCYnT1iSc2knvjnR/RiOjkod0Go
X-Gm-Gg: ASbGncsklOX3uEAvblmU4ZPXEmdjpJERIOQjq8cHeY8XDQI7jIa07xpDn0cpxmvFfbo
	UHmlVF70NJimQ577oTu2c6FXpusORaip05BUD0dnFsspzlcztnntmQoC27G4zVHIRfKbdwoTdHD
	KIh7LvDPQWo/k22efms9ZEiuxeQls+hnckqI9LApcOHxPlLKLEIf38IGL2udrfDJXwxWPMRiUjO
	GzWELW6wU846SNpUJPAo1dM0MtRW+InFdt+2oXSxS4XI7kWI/9kcg2lrM3FsKURdjjkMrXxVd9Q
	dCKp+w4gkkwQFzoDVn8Xpbxu55eYjKJa39PIvUAlE1Y6Tkc/bZPNtE8dkiDqXL+e3KLqTr2cVG4
	uWDX1R42TH6I2A61RnO4DUddROoqcK34F1/2teTRS2k1+kP4XXM9g6L88YEzCGA==
X-Google-Smtp-Source: AGHT+IG2WaebGgLNib2/0k8U+yjwKM89JU2jZtRr6fyVpZ7tMkkDGzThbtlOGUGAfKK676d10Zu4iQ==
X-Received: by 2002:a05:6000:400b:b0:3a4:e4ee:4ca9 with SMTP id ffacd0b85a97d-3a8fe5b2bc9mr85555f8f.23.1750954007521;
        Thu, 26 Jun 2025 09:06:47 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00ba828d421a4aa7ad.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:ba82:8d42:1a4a:a7ad])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45380d628c6sm32778755e9.3.2025.06.26.09.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 09:06:44 -0700 (PDT)
Date: Thu, 26 Jun 2025 18:06:42 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Florent Revest <revest@chromium.org>
Subject: [PATCH bpf 1/2] bpf: Reject %p% format string in bprintf-like helpers
Message-ID: <9d7c0974af8ab9b99723bd3f72d4bea8972d7cb5.1750953849.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

    static const char fmt[] = "%p%";
    bpf_trace_printk(fmt, sizeof(fmt));

The above BPF program isn't rejected and causes a kernel warning at
runtime:

    Please remove unsupported %\x00 in format string
    WARNING: CPU: 1 PID: 7244 at lib/vsprintf.c:2680 format_decode+0x49c/0x5d0

This happens because bpf_bprintf_prepare skips over the second %,
detected as punctuation, while processing %p. This patch fixes it by
not skipping over punctuation. %\x00 is then processed in the next
iteration and rejected.

Reported-by: syzbot+e2c932aec5c8a6e1d31c@syzkaller.appspotmail.com
Fixes: 48cac3f4a96d ("bpf: Implement formatted output helpers with bstr_printf")
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 kernel/bpf/helpers.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b71e428ad936..ad6df48b540c 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -884,6 +884,13 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
 		if (fmt[i] == 'p') {
 			sizeof_cur_arg = sizeof(long);
 
+			if (fmt[i + 1] == 0 || isspace(fmt[i + 1]) ||
+			    ispunct(fmt[i + 1])) {
+				if (tmp_buf)
+					cur_arg = raw_args[num_spec];
+				goto nocopy_fmt;
+			}
+
 			if ((fmt[i + 1] == 'k' || fmt[i + 1] == 'u') &&
 			    fmt[i + 2] == 's') {
 				fmt_ptype = fmt[i + 1];
@@ -891,11 +898,9 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
 				goto fmt_str;
 			}
 
-			if (fmt[i + 1] == 0 || isspace(fmt[i + 1]) ||
-			    ispunct(fmt[i + 1]) || fmt[i + 1] == 'K' ||
+			if (fmt[i + 1] == 'K' ||
 			    fmt[i + 1] == 'x' || fmt[i + 1] == 's' ||
 			    fmt[i + 1] == 'S') {
-				/* just kernel pointers */
 				if (tmp_buf)
 					cur_arg = raw_args[num_spec];
 				i++;
-- 
2.43.0


