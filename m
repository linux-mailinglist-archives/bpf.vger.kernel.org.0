Return-Path: <bpf+bounces-50381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A85A26D47
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 09:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A3C57A2CBC
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 08:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128C12066FF;
	Tue,  4 Feb 2025 08:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmXt1LiV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2152063CB;
	Tue,  4 Feb 2025 08:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738657762; cv=none; b=OtnP7jAKhRh8pvoVV9JyIcXim82xQ53jYrpLCE8RlO56UJq4MjPjM15AiLwuehPk1uG3MPPbZJ6KRKQ9xNYEfujOSDDw4Cdg3CBoLoW9263Ezl4F9e8jav3MJAE60snpNaUG0zoST/asb8NHArcCUpHWnpxBKgNwAic69R+Oc/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738657762; c=relaxed/simple;
	bh=Xfkt8fZ+JpdUzPN5rTmZxcrfTbfunSR06WpL4I0awQk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M1vSPD6eEhDmuUa1OYeZCttt9EqF9RBUamoJ9+7MjK3VXDLvCpsPfF1i9l5uBbsEyjqJ6Wz95aCGqYbZv2Dib4xz+38jb7G0vdW/fBZ1o4ZNwb0Hsv8mpYVfne6kLlnuh0+UWSZLoXf4RwdCerRS6/eXGFenQdRwi9ogKFVT9mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmXt1LiV; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2f9cd8ecbceso179323a91.0;
        Tue, 04 Feb 2025 00:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738657759; x=1739262559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g2Dv2MabKf7GM0y0RYZjLpYk+XxX2jVAnC2rU3V8oZs=;
        b=GmXt1LiVtrg3YqZgwwwh5CZ6fNFme5NSg1uQPqbey+AKZ3y7uqhgjc83QYXYe9c9AP
         mAn/csdLYfY9rS+IItBVW7Kpx7eHqeSyQHVI5iHklGTcPtc2yodjmF39JawDM3dFQejK
         V619qZy6LiXoY9R9W0sFxzrWqHlnACmXEVT96vcO/qWiEkKtAl+G8P7AxtBVri1aJqnR
         3Vj1sYuA5muGN3GjHtgXjl0+DYzC+Jlyrqyj0UfEpXAhKe8DSO7rSOzlvor+KMTBhXsf
         xMnx4UH8E11XVwfFCGzVMJ7LYjZHrJy9MTDfV//8tJfIRSbX4+z/lHqHP7izPlEqxMoV
         fDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738657759; x=1739262559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g2Dv2MabKf7GM0y0RYZjLpYk+XxX2jVAnC2rU3V8oZs=;
        b=uC2n3v1XDmWUNqa7VI9RoxWjUnys5aX3CQPXJfnfEWnnq/211VQ7yXPnpSAcZF3Zop
         P85FDY1sWuzGPLdI0hpp9lWoehHaMKWbsS4Erh7GW1/2NizND/HEf37LLwdffziC900b
         rkITXE0SB0L7eCd3oxzOQrzsa3laVp2I2bRhA8F7KaOx3ALYlKMXfmnPTViEc2k+pA/N
         Mbm+kmdleEmM4aEAnqVISsb7F0JCVrqfACvj+hAqO/aaNlR6a2g8Qt9AP2KgApfM9XJl
         nq3yAnQM+QDW143nXPw+k6pR9nCjJB8J8TrG2hYo8pDGtlfrWQpj0IeBNWOYwJejVKUE
         l1Mg==
X-Forwarded-Encrypted: i=1; AJvYcCUnNUwfxnffzsfD6pZFWHvgRjyS9rcrMAB55Yqy7aKz9x2TyWt78f/sWvG7qG7EvrjPSK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYEOqY8KIX9SS26z0OfjF6zccgVRbYGKCZZxIfvrZ9KRJTkSI6
	s9UCRAiCdM96aCARJgB//8LjeZ/nKWDO8mo4Mf+NE/NzmFJUpDdu8K6nKKCS289G2Q==
X-Gm-Gg: ASbGncs0UjcrCYv0Nndeo5JuswZmEPthbnvbQRf9R9j9ECEJZTTIkuxHsw1fNITbdQy
	17g46ZTSV3X4N2ibUb23RtXCZFuhKst6wduJLTncLsWoU7dWd9TJe/W+VSvApECFAw/GJXQLmS8
	LOYPcbmtTGIFBbFXSBVACJDW356iwFXdqqQyX4IOVSXEXNoG0/x68hw77+Lxw86oGUnaz7/sVRA
	FxNmfCNE0ZqxNflx5ukxb2DywagkM5xSJo/jjVSIdfgzqUeIAJ/eFWkUTDkBW9KpxYEBumRLQDj
	XRWWBEcfQDNG
X-Google-Smtp-Source: AGHT+IElqtljF8Xy5uzt8RAc0QM8ldeMHG/zIvSiMa8wiiLWB4Z6oYpdrVY0Q11Ao2wY0I0FEdadxg==
X-Received: by 2002:a17:90b:1d47:b0:2ee:7862:1b10 with SMTP id 98e67ed59e1d1-2f83abdebd4mr39118286a91.11.1738657759403;
        Tue, 04 Feb 2025 00:29:19 -0800 (PST)
Received: from fedora.. ([183.156.115.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de32ea80csm90826685ad.140.2025.02.04.00.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 00:29:18 -0800 (PST)
From: Hou Tao <hotforest@gmail.com>
To: bpf@vger.kernel.org,
	rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	houtao1@huawei.com,
	hotforest@gmail.com
Subject: [PATCH bpf-next 0/3] bpf: Overwrite the htab element atomically
Date: Tue,  4 Feb 2025 16:28:45 +0800
Message-ID: <20250204082848.13471-1-hotforest@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The motivation for the patch set comes from the question raised by Cody
Haas [1]. He asked whether or not the update of htab of map is atomic in
the perspective of lookup operation. Currently, the update is not atomic
because the overwrite of existing element happens in a two-steps way,
but the support of atomic update is feasible. Initiallly, I only plan to
support atomic update for htab of map because array of map has already
supported that. Afterwards, I think it may be reasonable to support
atomic update for all kinds of hash map. However, for the BPF_F_LOCK
case, although the update is protected by a spin-lock, the update is
still not atomic in the perspective of the lookup operation.

Please see individual patches for details. Comments are always welcome.

---

[1] : https://lore.kernel.org/xdp-newbies/07a365d8-2e66-2899-4298-b8b158a928fa@huaweicloud.com/T/#m06fcd687c6cfdbd0f9b643b227e69b479fc8c2f6

Hou Tao (3):
  rculist: add hlist_nulls_replace_rcu() helper
  bpf: Overwrite the element in hash map atomically
  selftests/bpf: Add test case for atomic htab update

 include/linux/rculist_nulls.h                 |  42 ++++++
 kernel/bpf/hashtab.c                          |  14 +-
 .../selftests/bpf/prog_tests/htab_lookup.c    | 130 ++++++++++++++++++
 .../testing/selftests/bpf/progs/htab_lookup.c |  13 ++
 4 files changed, 193 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/htab_lookup.c
 create mode 100644 tools/testing/selftests/bpf/progs/htab_lookup.c

-- 
2.48.1


