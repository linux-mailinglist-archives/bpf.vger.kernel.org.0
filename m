Return-Path: <bpf+bounces-52883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5538EA4A0EA
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 18:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2209189A5DF
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 17:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7DC19993D;
	Fri, 28 Feb 2025 17:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/GWQ27F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F12225DD1D
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 17:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740765184; cv=none; b=P5dQbDlQq1GvczQcsD7Be/LyNMwvSP11lG5bYwa1N7rjxzQ5FFNHVf2/chsIO6QU7HEwQO7vjgupTxTmOwu+rT7Z5XdJtMU1Jj6B0eBnYSbMDmTEcmE00ZcCGGMX+gSm4plXDImJwm68VE+F3CgmCj/EYWbrJMfH4YKNJXo35yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740765184; c=relaxed/simple;
	bh=djHRTWj8GMjvKC+Sk4PqSl9QOHbVqhclJ6K5/ipudmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sdkMf76e7MuP5MtEJMrqOznO8xjhb48sVtwOymNg8risvCO1QSIKRj3nUqQeh7F6YxAS7GF5KAIj6rUdD3/gXR+eou6sWKAtnNnDIw6S62iEEd6JZkrQoMUBz1I8ufzsvbXYYW7Ts4IXOvoS5XfgFykqgItITIyYXhxWUjrddvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/GWQ27F; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-439950a45daso16035395e9.2
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 09:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740765181; x=1741369981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dlZ/cLdOxOne3MlN1QdaqteGr/tbesYtFFgTXtY6zAg=;
        b=F/GWQ27FFNB/tMsuGda6a5XZoIBRFuYciYliaUczaa0r438Ae7vxJcBYL78+vK/x+R
         1moJI9485cVPqV0SfwgFTwKFUV+g0z5b6qXRhOozXBHN8MVR3WgV5TALHJSHGbrANT9Y
         hpZwYvX4uczBMBG4S9AZsFtGSB8X4mUwU5eDH0tIfm8/ePdaWo4ljqgJoNs4i5BiqmAY
         zUc+pm/c6kG8yyONEN5jK/NIDcCeFhWkp6gpIry1y/DmGRf8F3PEzUrRBJhLxnW1lCYK
         YPeZufgjfY11lUg0bzEYZ7hyn4NrGKsQxJQTFAFI2pG+N30CJXeSK9ioZc+ZXjD8dfG/
         KqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740765181; x=1741369981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dlZ/cLdOxOne3MlN1QdaqteGr/tbesYtFFgTXtY6zAg=;
        b=jzuWkODAMVHEFdY31gjRdyY6r6ho9IQKfHcsB3GHGgzi+gWe/XdEiInvSDCZ+hKun5
         6/KMyExIaB0lr3nrUA7VCMyHOyIm+OnK6OBDbNzCZRzR7qlDGEYsf3raOMMoJcH7zQug
         9i4UiA1reOUDkbgd6rCVBd5PSf3sk17KguBGj9eAzoL0DTCgbFr9Ezzebe6D9zOMOKcH
         ZYF3kEKelDh+RcprwrFxIYdJCA5AVGFykYI7Wlzf1z3SxcPCELgP2H4TsZr3YJR2re86
         NtPH+mpbZ4HgFkmEgdrT8sD2y+2djyddCprA7/M0R5/0JPgO2MLa2z3lRSwQoBxDI9pn
         +ZNw==
X-Gm-Message-State: AOJu0YzCYh0RsHoBiapiagIsQEHdxzDwOMChohMHtCXNGUz7nLGKEXl4
	Jb3lXQwvatlDZZXCXJ9dUw49HjeNBgow01qUXYMcwMn/ppR1VWXH/JloBA==
X-Gm-Gg: ASbGncssk33C9W0yy+CmHUlQZknO8IdknHjTYU3w8jiMRRq7EdM5wslUpJb5IIK77nb
	P9D4iGlWml9uX5ByucUUzjCkJmRwFlKwvLhxEeyKap/w61x7B3QoUkeXpxNmjGD29hstQEi63qS
	ydBlC/fdfNZzStYY63Ln5NwTecd9Qt6E8hJJ8EiIzSVUY3mv340TmpsCrQrJZFWBzbgtgML7qV6
	a1kOqpZnLgBV9lR3twFFHgppj2R5qj3MFBYprvWGgLD6RxQkIs0RPoU9QTB4JWTcquPP20WnoeT
	tXhNLYZ//abPevYtA/SotBTKXKcblSDAISrskvk4AonXwyGB1jhpmCPYRDgAB11ZB6JuNI80A7v
	8GqZIfF9FAVr97L0lOzSejuDl7If6rIk=
X-Google-Smtp-Source: AGHT+IFxer7wznVbox7j9psYL9MYS2Q49lYbE7N84u2/dSDR441BRGoGZquRBFNdJIIetNedRdeJww==
X-Received: by 2002:a05:600c:3016:b0:439:9a5a:d3c4 with SMTP id 5b1f17b1804b1-43ba9279511mr26560105e9.2.1740765180371;
        Fri, 28 Feb 2025 09:53:00 -0800 (PST)
Received: from localhost.localdomain (cpc158789-hari22-2-0-cust468.20-2.cable.virginm.net. [86.26.115.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a7b88sm5861664f8f.40.2025.02.28.09.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 09:53:00 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next 0/3] Introduce bpf_object__prepare
Date: Fri, 28 Feb 2025 17:52:52 +0000
Message-ID: <20250228175255.254009-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Introduce a new libbpf API function bpf_object__prepare enabling more
granular control over the process of bpf_object loading.
bpf_object__prepare runs the same steps that bpf_object__load is running,
before the actual loading of BPF programs.
This API could be useful when we need access to initialized fields of
bpf_object before program loading, for example: currently we can't pass
bpf_token into bpf_program__set_attach_target, because token initialization
is done during loading.

Mykyta Yatsenko (3):
  libbpf: introduce more granular state for bpf_object
  libbpf: split bpf object load into prepare/load
  selftests/bpf: add tests for bpf_object__prepare

 tools/lib/bpf/libbpf.c                        | 194 ++++++++++++------
 tools/lib/bpf/libbpf.h                        |   9 +
 tools/lib/bpf/libbpf.map                      |   1 +
 .../selftests/bpf/prog_tests/prepare.c        |  99 +++++++++
 tools/testing/selftests/bpf/progs/prepare.c   |  28 +++
 5 files changed, 267 insertions(+), 64 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/prepare.c
 create mode 100644 tools/testing/selftests/bpf/progs/prepare.c

-- 
2.48.1


