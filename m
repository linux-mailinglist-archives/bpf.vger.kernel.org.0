Return-Path: <bpf+bounces-44203-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7774F9BFE97
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 07:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 696A91C22330
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 06:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2144E1D5AC7;
	Thu,  7 Nov 2024 06:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhIrKvI1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9F8D53F;
	Thu,  7 Nov 2024 06:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730961435; cv=none; b=G3ARsKvVAsbbGP3cI0hlq56mB5INWzMqMO8sLBSjcVTA/9vejyyI9QV6E34NwdkvhBUr4QVFPk/0tNQpUJuQ21ZvbDHsjuLJftqnixriAExRiEzdjZYqSMV1XDLLy5yRlLH76GnSVBVGi9C41pmcBvRqFLoIDzmlphUs2GGPIDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730961435; c=relaxed/simple;
	bh=R7Agzor76R8cssshT5VP5bIKcU+JM+7fLhT/BpB5DJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MIqAYKspR8HuQhv17n7ZEZwcFJVMlz75D+xOA7LBzbSSNsA2I1iMCY/8r/EsiuFn6V1o8Det5gJ6Tsg6FVdjjgksnAGvRpZ8s4muGvU/H/UE1XosymOHoIJyivPkVgN/gKANp0oWwt/OJLuLvVAeoatlE+V+H2Rt57+pHSe7WL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhIrKvI1; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7181885ac34so437091a34.3;
        Wed, 06 Nov 2024 22:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730961433; x=1731566233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2DKKAPCqm3qy9Qkbsj/XEzvJTNx0NheCX+H6XvpWYI=;
        b=MhIrKvI1tdYtGc9OKrDNn57fL1mjDGHgL0FmFoiJrYhM77vzKh1/nbU19tbnu996tj
         8b3c+eKFH13Ry4jNJiYFGLg7QvakjsshRxU2UiS6XtoueFzvXPW45QX0aL962Vz74OEk
         9DeoENtTHrY58V5C7qDiMoMtMsDWMc+02Z2zVxC1MEwUr8MuLuh22ckzguSHUchQrBzb
         rmuvHcaTesm1/9+MOuZCjdq71DYNwqsz/ZtHhjlrC+Udw4hFF+1wCRveo0Xcv6qCumCH
         zna9+Rjh6h2u7BV5Gwz7satGirOawJ55wtPqFQhFNR1usdNNpgbqr/7J9TAxWh/iCkxV
         N31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730961433; x=1731566233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A2DKKAPCqm3qy9Qkbsj/XEzvJTNx0NheCX+H6XvpWYI=;
        b=BGx4uOufOx/2cYcUzF+VAQWKLMn5rbCBqEl2ETUf2u7My5HT6GEa+w/vO6ZQaMDkY+
         WQJFYo0e8+c6WWN7aPESaLQEhxFt7y53hmsKpVa9fL3SGzAO4CBEYFEUqy57E4RLP1Iu
         U2lkXvhyE4aT1ln5LTkU3jxYVxlfU1PEJ1ECsKks6u7KVNlSeOLZqI7qpjz1iH8R88+g
         I2mQuZv4E9FmcvRRncHonNtqfL2+wOpiv1NvKstX8NQYt2x2UBzz4HXJUaISp9hsx40o
         VeQCYkGcGbr0M3Kj4q/avCOubrUhkXl9j0BVKIhxshn8weL8JaZgxS9hWUpgvYsoYZ8a
         uh3A==
X-Forwarded-Encrypted: i=1; AJvYcCUVEVDjyfgqQyKS111LyC997x++xIUmetX4FkuPuQuAklt2s4yjZwrZfDsgGHqqXJWhWHdY33QPa8Zp@vger.kernel.org, AJvYcCX+niPa3ALypFHEqTDkTrdpxJustUo8ScqZ9V/dzCbbC2EDrMRZTzYWt8mBVgLYs0fSmqTNx9bWPyi+aYNB@vger.kernel.org, AJvYcCX1lgOQKzvv2elf9S4HeG/U7Ax6E2iZILWYIqDx+PfMUzbihVw3v2GnYxqlpjCKxorrQq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfOHvRnA8ZdqPfqeh2Winskl4G5Jsb48Hcdd//QwAwFPq3g8n1
	h0QRcnvR3zO56IKQbycu5amcV7gYsvC5g47jdzOSnykTTejf1+5L
X-Google-Smtp-Source: AGHT+IGs2DM71e9maKHXQ+AR3VNSQggk59vK7PPwYNupVqCEJ8J8WZE4T3dtfFxGit5d8SayinzITA==
X-Received: by 2002:a05:6830:6f83:b0:718:4395:1cc7 with SMTP id 46e09a7af769-71868118311mr47224102a34.12.1730961433243;
        Wed, 06 Nov 2024 22:37:13 -0800 (PST)
Received: from 1337.tail8aa098.ts.net (ms-studentunix-nat0.cs.ucalgary.ca. [136.159.16.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f48abbdsm616310a12.10.2024.11.06.22.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 22:37:12 -0800 (PST)
From: Abhinav Saxena <xandfury@gmail.com>
To: linux-kernel-mentees@lists.linuxfoundation.org,
	bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
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
	Jonathan Corbet <corbet@lwn.net>,
	Abhinav Saxena <xandfury@gmail.com>
Subject: [PATCH 1/1] docs: bpf: verifier: remove trailing whitespace
Date: Wed,  6 Nov 2024 23:37:08 -0700
Message-Id: <20241107063708.106340-2-xandfury@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107063708.106340-1-xandfury@gmail.com>
References: <20241107063708.106340-1-xandfury@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
---
 Documentation/bpf/verifier.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/bpf/verifier.rst b/Documentation/bpf/verifier.rst
index d23761540002..95e6f80a407e 100644
--- a/Documentation/bpf/verifier.rst
+++ b/Documentation/bpf/verifier.rst
@@ -507,7 +507,7 @@ Notes:
   from the parent state to the current state.
 
 * Details about REG_LIVE_READ32 are omitted.
-  
+
 * Function ``propagate_liveness()`` (see section :ref:`read_marks_for_cache_hits`)
   might override the first parent link. Please refer to the comments in the
   ``propagate_liveness()`` and ``mark_reg_read()`` source code for further
@@ -571,7 +571,7 @@ works::
   are considered equivalent.
 
 .. _read_marks_for_cache_hits:
-  
+
 Read marks propagation for cache hits
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.34.1


