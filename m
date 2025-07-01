Return-Path: <bpf+bounces-61996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDABFAF0410
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 21:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E8B94E4630
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 19:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2302749C5;
	Tue,  1 Jul 2025 19:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nW61sTpj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582771F37C5
	for <bpf@vger.kernel.org>; Tue,  1 Jul 2025 19:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751399256; cv=none; b=DoQ7AFMGund6xW+2SHoGFIb/hUFLOWVJv0Z3XocnlrIxjR/R2K7BzS5pozczBgIrAuc4569Ogx1v3TYFRvQ2OYevLC1JyrLHxKwPEEgx2yNQoA1ThllUGzM0XUuN8x9o02tJSYMJvd++nxpQZH6lFvJ2GVUapJr1VbhySwyQON0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751399256; c=relaxed/simple;
	bh=Sl+8Xm3gUfC6mqYAfh66xSsv6GEL517bNqw0jP3i8Bo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AHAdTb8sGVpPnWQJfIB7Kwd7qnfaW8L06LCfxg9fnDHWUz9kdf0vHvlJxT6ZtYkudnFyDKBMASyZW3vx0c6UJ/W1H+ujhI1gK2GGWpLXzqXOhp7au9nV6UNH4JP+ZLllNAu13DN61Y4VHRGwFQCTR1cxo3gEAHGVRpRgVDGnd6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nW61sTpj; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-450cfb79177so36354195e9.0
        for <bpf@vger.kernel.org>; Tue, 01 Jul 2025 12:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751399253; x=1752004053; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ea47hVOoa4/J50lDgOGo9mZqEd5hU+lF+C3KVpzUURM=;
        b=nW61sTpjQhwH/dqioPeyVMy7oufjqgI7uPx+MvIoeDOH/Xsd5us6nFmOPV+F6B3Byd
         lvhtAczoRVRrWj7p/mCbZ/0OPeOrcc0O2PR3+d78xsW9uHwg19nfqnOMTFGi63z/ONmE
         KKD86pBAQ3MqeVG6hc4aXjeyYt6RDfF//HxsMm+ExKReZatvejDrqrhsuPFKTMwvFX5S
         bVJ0jI7Y/WcmPKaE2Rmx4Tzl2gFWSpAQlJ0WkTGoX7N18oLsvAIROPwWFmtRSZryLRbw
         /+evpRH/rjSvKedAJ/gm2Q44dBdq9lsmDxA1KKDnKFx/e4aeogvynfGjTmfDPvZP4LTG
         YK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751399253; x=1752004053;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ea47hVOoa4/J50lDgOGo9mZqEd5hU+lF+C3KVpzUURM=;
        b=tqwq9zwfdvGhZ/ycg5QjZg+QldQrUdZliRo8yA3E0+4hllIzQ5tG/hnUhq1uEdFDKH
         WxWVWSCpGSQqi6xicfzI/G1byO2cjiy0kWSuANF4M7tob4kdcDNGipICJCeFv2orS4uD
         Ot984bijcEVzDMnIEfBH/wCB8ayhKnN6ZN04pqLvdfB4zTR+O3oG4dXXZAjqFXou3JRO
         I0LdFMr38Wxx08V81/miCNcBo7bjeGKlNx8KDXp/CTGH1hOrOabHQ0s8lUgcdNvdTl1y
         N1Rlk0aZsEtOGB1CBsTiFU4a9JA80p101+BgsJgfjgbvqHv+AdTIBSrNvU8bJIeTKrWk
         a0Hw==
X-Gm-Message-State: AOJu0Yz5Yriz0/PMOsV5XOSlyZ9m35zWsFvyNEeBNaq30UlXKHUp/MGI
	JuJfcHARGWfua2DSzM5cp8vENlVQpqMJwrnYgkL+cP96BcAhK/dT1QEz9EWvLKJx
X-Gm-Gg: ASbGncstJxnjsj4CXURZ7L+5wbGGKrqcUGGHxEuICwF18zenlEgbvSp8Qx3jpY4OOWA
	ZzUVhEm7ZxY7C+oPw6h/1b1/2Ydo5M7zkrYp0iIHGNMyDIVTbDxO2myi2ZGIiM1biO+HhkCo9d1
	RqF1MuIXYfkngG2/3BKA1ca8XniBw9fJ7XhwO03QShA04rOqrVJuEt5j2KQ/2cz58tcLENHamk4
	/1QCZFAbumxs/emN8zLD8N3uU2+Z0BTrNtAswOhk/RZ7WGEsbJ7eCvQZDtVMpveo7SL1rfcmNQa
	B9cbVzABGsyP6gEmGIS0Qz1u1lMFmmWDoNVYlgElQdmQeXU+x0eRLe0y/DCjuu7Q/uFulnQ22rE
	6KjmRPDzXy/5QzuZff1TkYGzgVNn/hv6IJwRaCupemAsevEJOgw==
X-Google-Smtp-Source: AGHT+IHH0KMP0Yku7xVzCQqj1gOETvRfvbkWISwMcIIBYqqg4wcinQgpdD72LPJvqxmLY7UjYkk40Q==
X-Received: by 2002:a05:600c:8212:b0:43c:fe15:41dd with SMTP id 5b1f17b1804b1-454a36ddc52mr4282245e9.6.1751399252301;
        Tue, 01 Jul 2025 12:47:32 -0700 (PDT)
Received: from Tunnel (2a01cb089436c00024ac52d8fa7f8001.ipv6.abo.wanadoo.fr. [2a01:cb08:9436:c000:24ac:52d8:fa7f:8001])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823ad0fesm210718885e9.25.2025.07.01.12.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 12:47:31 -0700 (PDT)
Date: Tue, 1 Jul 2025 21:47:30 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Florent Revest <revest@chromium.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf v2 1/2] bpf: Reject %p% format string in bprintf-like
 helpers
Message-ID: <a0e06cc479faec9e802ae51ba5d66420523251ee.1751395489.git.paul.chaignon@gmail.com>
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
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
Changes in v2:
  - Rebased.

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


