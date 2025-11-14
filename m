Return-Path: <bpf+bounces-74482-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 54081C5C293
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 10:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C5FA4F2024
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 09:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350A2301704;
	Fri, 14 Nov 2025 09:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gh/v29D7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503762C326F
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 09:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763111036; cv=none; b=KGGsj6v8cUBSfa/xacG5dtpHd+L9/5F7iOPoHb1gayQPYfjkyVeQ7H5F1hRxB+dIvqDQRXrSirp917cjinJLpezQgqH1/5qdfj/43/7z/LquTvO+yFfXYF3vyX4VMJuVmwdAzhnhm+UiaMofCRS+pJX6NpVpIgq4dHhikNnGA0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763111036; c=relaxed/simple;
	bh=W8s5L5zmfwc+QGPC5hCWLSubohHOO0kKf62ifztROc4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oVtFQWbvH7ZKTlgMX7hhPcviUqaI72gOdzgsWb7LeMI3XGm+c/8uwWxhnQOGa9n2a9SAjNeG15cp2vIuAezAJ2FWp5Upf3874gQGbk/JnWuHhI7yyof8ThNy67em9j2hKySvS5xzdsqv9S5MgokHKIJGER0Okg8NpUUbZqE7698=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gh/v29D7; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-297e982506fso19756845ad.2
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 01:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763111033; x=1763715833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z4Shpf10YV3VCCnns60puz1byMeMWcftnP3LoSfYy/Y=;
        b=gh/v29D7g4q0KDtWQvUfWLJQs8cavk93sPN3L2amrjvX+VZJ0+W9ydzxggPnSpAzvo
         cR//LE+jQBqieAlW2c1PDaoKiVjrEHXwwraVZFJwhBU3IcrjvjX7zrVzDfUZPJdmyEVM
         qvTAevnvYXkVmAj3ZgAO5fKMD0JRNZ3546BqdjGXuzn2jY4/JJz5zofs8HpLHt/01fmb
         Zpjz8zYTxMNZhe2E6XMq65RtExl2uaxRPUBkqMsDkLxZr/hgMOY/JoazavgQIbZDr1uF
         sV7LO1qvS62yOSAohvUet1KShJ8z02dScOQ+bTblQL0IrYVMAIAlqJITyH42vAp/Bn5D
         coHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763111033; x=1763715833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4Shpf10YV3VCCnns60puz1byMeMWcftnP3LoSfYy/Y=;
        b=nHqoxceFclhPu6BMGxqI8kV5lJUjPBzCyZgQo9I+JxyiLasA0UtSfOxcoOpuFVoR+b
         Q5lMPV7Xgvd4j+cQ35sZVf09SnqWf8F7R7FIwCa/LXD7F7Mx4VNMVD1faNP3Dx77nnQp
         GMNYMdWRGt1m6jvS3DBOKZq9TPR0tQC89BmBwjAax8S2TLiOqvpciJunvmd6HoXzc9f4
         nGtuB0C4n4npHyxjRTQv7LevPJfEcGn0P/XkORH7MPpwaX835/yFgpr0n2E4khO+KWJV
         7EjfXsVVFtIJZw0zBBQ5hz2Iyz0zUU1ZQToWo7pGdN4xq4PRAzxk29hQ1iffMgJVDXDY
         W1zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVh+1JqH+p7NM6fZgLd+Ivvac6z0/lT3NZboVTO3zWHvgezY9txhlidJLlOA94/JWwycds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyndae/ndEda1jQVEyA+cBhWlBGTZhr3ANuG8QJGmzENAyXq4cf
	xKAwWFeL2iKn6wRQ60atxxpF28mEtHoSi9icPvYwOlJNOFKk/P2km2PN
X-Gm-Gg: ASbGnctJ7vdL9EmcX541kJpOjhHWcRAyce0HmB05HvYY3fhjK7w+9D6gm+gHgtfqzi9
	jrw926ocI95uWb3dY4d6HvqeGKoMSpUoSjNdS0Yu0ucEgPgRJ0srNpzopI4UO/n95Zcxnd8IXDz
	vtPw3lNNDX4tQAGV7EgmX1zXkYpkKrjx7/GshCDK5qb0zMlJ6+Jj0tSkx1TIZm1ZzslmAlcLncg
	bXgk71pTGFMqAj/I7goGqAyiUOSEjuiN0269RaL10JFdvcmFT++koTtANQSTBayRht2SrbM1uvv
	eymn0/D3YEyNjkmeUj57f05J7DPdUOV6WWs9XBXDvEBlI6dr8OHU3PcxfLc2naeQ7z1XFk5kwjr
	adFrV8t/pAgdGfPudHhtnqIDhWqXLNbgAFKaDyiLttcYZz+oqihVv9Wf5EBIPZfYyunyntu1h4w
	Q38DtEVc+G2wFjPXGp6lAcF7uPIHwN7Ycnb8DtNw==
X-Google-Smtp-Source: AGHT+IEWX+HXwjIwoEMhrfRmvFP6jpi3fidtv/m8yrQqLuzNZ8npKH8JVbjNH2ISoNhGz75HwyqwMw==
X-Received: by 2002:a17:903:2948:b0:298:485d:5576 with SMTP id d9443c01a7336-2986a6bd19dmr14108605ad.8.1763111033487;
        Fri, 14 Nov 2025 01:03:53 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2cca66sm48362605ad.99.2025.11.14.01.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 01:03:52 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org
Cc: eddyz87@gmail.com,
	andrii.nakryiko@gmail.com,
	zhangxiaoqin@xiaomi.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <pengdonglin@xiaomi.com>
Subject: [RFC PATCH 0/2] Add btf__permute API
Date: Fri, 14 Nov 2025 17:02:29 +0800
Message-Id: <20251114090231.2786984-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donglin Peng <pengdonglin@xiaomi.com>

This patch adds btf__permute() function that reorganizes BTF types according
to a provided ID mapping array, updating all internal type references to
maintain consistency after permutation.

The API enables custom BTF type layouts for specialized use cases such as
BTF sorting optimizations.

This series is extracted from the previous patch set:
https://lore.kernel.org/all/20251106131956.1222864-1-dolinux.peng@gmail.com/

Key difference: this implementation adopts the ID mapping approach
suggested by Andrii Nakryiko.

Link to v4:
https://lore.kernel.org/all/20251104134033.344807-1-dolinux.peng@gmail.com/

Link to v3:
https://lore.kernel.org/all/20251027135423.3098490-1-dolinux.peng@gmail.com/

Link to v2:
https://lore.kernel.org/all/20251020093941.548058-1-dolinux.peng@gmail.com/

Link to v1:
https://lore.kernel.org/all/20251013131537.1927035-1-dolinux.peng@gmail.com/

Donglin Peng (2):
  libbpf: Add BTF permutation support for type reordering
  selftests/bpf: Add test cases for btf__permute functionality

 tools/lib/bpf/btf.c                           | 186 ++++++
 tools/lib/bpf/btf.h                           |  43 ++
 tools/lib/bpf/libbpf.map                      |   1 +
 .../selftests/bpf/prog_tests/btf_permute.c    | 626 ++++++++++++++++++
 4 files changed, 856 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_permute.c

-- 
2.34.1


