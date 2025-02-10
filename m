Return-Path: <bpf+bounces-50927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78999A2E541
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 08:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C92771888734
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 07:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01D31ADC8A;
	Mon, 10 Feb 2025 07:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="W8drf9h4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28E51A3159
	for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 07:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739172158; cv=none; b=UchFJC44/d4INpqNMpA5NzFIu7nBhyAMUh9g9N6kWvmQbDvyQPu9ASgJpB3KA0wu/BYYuZqo+g0AaFoTWk0anOkadgRxuicQc20EuieYvT6mFGVkOYv0CLMrGpC3LFZKlfPctU8YYFgJ4uC919/oFgBdKTi7/GWdJouboRJMbPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739172158; c=relaxed/simple;
	bh=Fq7AOqywtozLGyzDhVRKESkoXd49xTjrcIyMW3nGG/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CoRpr5fNIZ/Z2PIr1WGHeRc2Qdtexupl0vlXaVGLUtYCVeQV+KordcUxT2zFCWOQEPzRGIRKnmwGRQsBjwoIAmsJ/wBDp5dsafKky8GYCY4GVrb98EF4flXYmnkYW8nawcCimK1Ia0/Gc1Z8TraGfn+kdTdFpHMtCzEWXWkAgwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=W8drf9h4; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c05dc87ad9so88071185a.3
        for <bpf@vger.kernel.org>; Sun, 09 Feb 2025 23:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1739172155; x=1739776955; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2eifM2TJgSxcTeM2vc1cnmxmV71PALyO8f+gK0jI++w=;
        b=W8drf9h4j2l7W+FWvCLfUTf9EGst8FOk5l/3T+J6ICTl3A45vdlVbpEp3RznvCA6Rc
         DijWqsFFhngXXyZ0skLOGCsEniR6ag99tIihIdA6rM8VSqRQUw9nzffzGQFWVFcd8O+Z
         7z0iLWkeMN8McnOALFs5ymYnCPMIqjfOpK2i18a6YAykyfslgI7GVD+NgPnq+lZfrH34
         Qk/dxATBaGY90WLbdRB3otqVD2rqSuhZlhoLeG92FWS/e2STbA3bcAujJ9gdgFP28Gwd
         QWkS+CeVJ1W0AZ5u2NgNoX7Rg/gDz516oGIz+hxo3XrpQ9MdYPoiPphhboQeHFmRYCMw
         EHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739172155; x=1739776955;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2eifM2TJgSxcTeM2vc1cnmxmV71PALyO8f+gK0jI++w=;
        b=TlZXHQExWvgWYfOZ8IzuotJ6EDCJLT41rMNM5eC61JWZnBn/1sXEKn7QA043FV30Ds
         6EyynFY0xIcR4n4FDAB0Wr1TTXnKoMstWQUEXCSQS6wP4sFXtTe/vWkzWPlBXHIzXfBD
         pLVMEmdWhUu33CVFlDz80ES67PbFRPfiMtXpPuZWyhJcKuddtaapMudbIJ1/hCW985Q5
         Aa0q1SkRCBCk5KFODnqLstkz9+lM9JJ7BaLSp3q+jbVwe1oIYWMluYukxKaQ+G+lhKE/
         MDz55vkxJa8fhA1dB00NJcq2ZpzP2oJ0agNWFrXH/JcJAEFHeq9a/TICU3KJCDjgqJkV
         Qt8Q==
X-Gm-Message-State: AOJu0Yxu1ezApXGXp+4YCMo7d3EUbSIfck+dh0RKEjZHOP/F3cFGTiEj
	VxdaUNJ4ddFInsoqdz9FaxcRsmlSAkAdl918h/3jF3VAZY903raPqdjSHVhNKBTFSZ7RbnXI7xE
	D
X-Gm-Gg: ASbGncv2aWtaudZ7NFZIDjWuGKQtUVlfmzHkkyCAUcu41CHN9NnCKnf7vrbOuO47Hkg
	lhRHNUFcByX6t2bUoavfKFzuQo+G9nOcNk+dYKLUrNepinjUI3LI8bASiDaEbOUl5nXM7VriUZ6
	9MtnBUqdXVaqKvlIogd34O61pmVdXJUwhSNt6Va6/UhPa8ZQOX6PUGfnLmu1/Cc+zy4WfNvfK5v
	gjfSRCmbZ6ttD2KEdmVgX+1IUMsekDNb9Q9IDILWAwb1EytYZmug4hQ0FhXi11/FglOulZpEOxl
	0Xvn
X-Google-Smtp-Source: AGHT+IFqoVnPbfDlA0I7Lpzq5OYGCiuDOBCLRt/SyBPdEZ3hBHFAoO/pSle/c5P109+yMKGpe128IQ==
X-Received: by 2002:a05:620a:390e:b0:7b7:142d:53a4 with SMTP id af79cd13be357-7c047ca7edamr1803066785a.51.1739172155488;
        Sun, 09 Feb 2025 23:22:35 -0800 (PST)
Received: from debian.debian ([2a09:bac5:79dd:f9b::18e:183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041dec31dsm499971685a.1.2025.02.09.23.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 23:22:34 -0800 (PST)
Date: Sun, 9 Feb 2025 23:22:31 -0800
From: Yan Zhai <yan@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Yan Zhai <yan@cloudflare.com>, Brian Vazquez <brianvv@google.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@cloudflare.com, Hou Tao <houtao@huaweicloud.com>
Subject: [PATCH v3 bpf 0/2] bpf: skip non exist keys in
 generic_map_lookup_batch
Message-ID: <cover.1739171594.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The generic_map_lookup_batch currently returns EINTR if it fails with
ENOENT and retries several times on bpf_map_copy_value. The next batch
would start from the same location, presuming it's a transient issue.
This is incorrect if a map can actually have "holes", i.e.
"get_next_key" can return a key that does not point to a valid value. At
least the array of maps type may contain such holes legitly. Right now
these holes show up, generic batch lookup cannot proceed any more. It
will always fail with EINTR errors.

This patch fixes this behavior by skipping the non-existing key, and
does not return EINTR any more.

V2->V3: deleted a unused macro
V1->V2: split the fix and selftests; fixed a few selftests issues.

V2: https://lore.kernel.org/bpf/cover.1738905497.git.yan@cloudflare.com/
V1: https://lore.kernel.org/bpf/Z6OYbS4WqQnmzi2z@debian.debian/

Yan Zhai (2):
  bpf: skip non exist keys in generic_map_lookup_batch
  selftests: bpf: test batch lookup on array of maps with holes

 kernel/bpf/syscall.c                          | 18 ++----
 .../bpf/map_tests/map_in_map_batch_ops.c      | 62 +++++++++++++------
 2 files changed, 49 insertions(+), 31 deletions(-)

-- 
2.39.5



