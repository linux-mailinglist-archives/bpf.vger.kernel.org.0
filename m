Return-Path: <bpf+bounces-26563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2A88A1CE4
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 19:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CC231C203D5
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 17:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46451BED9B;
	Thu, 11 Apr 2024 16:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="PuQsFBwt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC28B4779C
	for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 16:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712853903; cv=none; b=RnHqzKYP5D3WVV2tfF949mXFm7/P+OrvB4HZZ4D/qa71WQviXjjaXRJBLFbACky/MyqCnct6tvCxiYpmIcRW6N/bjXsJ9jI6fkoFZfa67QEJjuuTLOyzYCcqJh+Zs8KPLLHiQXmzgkDO4HUsHKxriV3n1Wc2MuoZJeXuAJ79VwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712853903; c=relaxed/simple;
	bh=L/lbl4FoIUs6UZhGod6ET5XcpMpQIGR9o3M2LvmcI74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lGpLUodgEZ3v+eJskK7fZNF8DwbzPGmS61RKF8qYM2SPyLhN5AjN27n/7qBaQJw9IeyirpVau9rqDdZgdCFgyBLVRvFgxwxjWwOkrN8yKzN32H8GoOKf8xp3TdSytauH4jB+HKLx8Jt24GdO75/veSjrYf7scYqIt2o2M6LLhCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=PuQsFBwt; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d718ee7344so92551941fa.2
        for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 09:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1712853899; x=1713458699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rciLgnl7jf3ltOZtOlJxI5UnFTTiSa13ydmrz5IK0H8=;
        b=PuQsFBwtol4LegRne+QPeidNSP82MtA9+eOEw6uWQLB9Hoz1VUYaUz3yLHFhvIuqzx
         VdKYsGeNhTikBlGgNpk97+uWrfmsKbRiSs7KfQYyKQz91jdRb0H1N2V9ovBlkh6RcWsf
         Uq6liugBhxqu/7g/mcC3MUDMPpvNF9nwMYO3Hsdx7tWnBCuMWEUhMBNjjcPIrzwrKyL5
         DkWTUAZ+HIv3WxGCdmIfVLZJej1aAa9MzBvogbsuzbOQV97NbiNFTWcIUct5lAa9BnZ6
         QhduDU8DuFnjlpu1mEAqUKfS5AEFoxF+llXPaoKwI7Jb7qldEHlNyz11jxAY3jvM9d5j
         WOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712853899; x=1713458699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rciLgnl7jf3ltOZtOlJxI5UnFTTiSa13ydmrz5IK0H8=;
        b=eGtWVgayLS0qysZ4UlonJXsn59FRW5N/DJKD+DRkrv4o/2PstwXZGOthURCp8rJgfA
         dQB72Sih5Aio7Ly3MBnF3LCGN1loGHzOXShVRJYWmdjFUeiBFmyxc8K3+su7WXMSzYqS
         5HW3Cnl4Ri9D5atSn/s5ljp85tP2wOoc+c74SdkVaezSf1HHLc0MbNBiNnB+HDFsLLZX
         /bCXOWEnT8kzaV3P6jd2BZgpapgs67McrCMvebA3ST287okfspdC1fjZfwvOWMU59ScF
         pC7g8EGZQdTU8X9TZ2Th2EmBrNk/2byUerPMvSsu92L8J09K1TQjHB+hsAroDk0z80vg
         nXfw==
X-Forwarded-Encrypted: i=1; AJvYcCW2IRSPDMWmiU+aWES4/qodB0bnzvnt5Uh4x7gVlnj8a5dlGevWsPs92N8nBlasXGnxlJsRE5qYBPTlgFf7KMBQ4wv4
X-Gm-Message-State: AOJu0YxAy56IDOOeNmkAFtWdEPYLYXkT6mygglLxuwm7Ybo+gDMq/9fS
	mgC0hJdoEKM8/x+HnND7A0FQKUSyPGptoOoEGG/bMgJZS1Gb6JzGMJT+TPokpNo=
X-Google-Smtp-Source: AGHT+IEwll1rsUMGNeW1FuXusul1A8HmVEsJ7Cvp9KCtA/BhU0LJTecUFPwwGIjIOVXlugNh32cL9w==
X-Received: by 2002:a05:651c:512:b0:2d6:8e54:80a1 with SMTP id o18-20020a05651c051200b002d68e5480a1mr168779ljp.19.1712853898891;
        Thu, 11 Apr 2024 09:44:58 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id ig4-20020a056402458400b0056fe7e308c3sm766529edb.0.2024.04.11.09.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 09:44:58 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Quentin Monnet <qmo@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [RESEND PATCH] bpftool: Fix typo in error message
Date: Thu, 11 Apr 2024 18:43:00 +0200
Message-ID: <20240411164258.533063-3-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

s/at at/at a/

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
Resending this because I forgot to CC the mailing lists
---
 tools/bpf/bpftool/prog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 9cb42a3366c0..c5cb0f9beb07 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -2078,7 +2078,7 @@ static int profile_parse_metrics(int argc, char **argv)
 		NEXT_ARG();
 	}
 	if (selected_cnt > MAX_NUM_PROFILE_METRICS) {
-		p_err("too many (%d) metrics, please specify no more than %d metrics at at time",
+		p_err("too many (%d) metrics, please specify no more than %d metrics at a time",
 		      selected_cnt, MAX_NUM_PROFILE_METRICS);
 		return -1;
 	}
-- 
2.44.0


