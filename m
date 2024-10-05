Return-Path: <bpf+bounces-41058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B3A991869
	for <lists+bpf@lfdr.de>; Sat,  5 Oct 2024 18:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B39751F22A69
	for <lists+bpf@lfdr.de>; Sat,  5 Oct 2024 16:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CC41581E1;
	Sat,  5 Oct 2024 16:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLL5uvST"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895471CF96;
	Sat,  5 Oct 2024 16:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728146849; cv=none; b=gNSn5RyFeyrn6+xJgnScJmyNoOxHJURz8K2hwbEchJlik6heoSZmZ5Nx3jHucMrHsz7z/DxUcyu8o5q3AGkurcexRbXm3geGnOEB/Ql9Z39Wzw9QipqYl25MCo7eDmasqDj86HSF1rzg9HAQu/5AaH515HYJSlyMuVDL4cw/Aac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728146849; c=relaxed/simple;
	bh=SbzdiwL0NXE10tYG/iUtD+nmVPKazjue8fBEaGKTXV4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cyARIrj3mTRLd03xkWWt+1uEUluHmQOuKwEXuImYP0QMsF2FJZvqt88aqcE2U4E/oOsck1AdTor7hjEmhCh5CHsDh8bFHHTHti/Y75+rhzBQO/YerIYki0sYuq0LORQa8y3Xq+d1DW8hdcjZjJO5lYqf1xMDubGu3nx/fgbtljg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLL5uvST; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cb5b3c57eso29991135e9.2;
        Sat, 05 Oct 2024 09:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728146846; x=1728751646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hj1spl/h6f2LGGC+51xwjkCU2sNccvLDpAszxwH0jrg=;
        b=iLL5uvSTkMUJEeR9xb+mCmC1WMLfv+wn9NC5zTRGjuGsr5eIH0atWsB5IkuM/0xa32
         AHGzMHTGbKPeVgeqQSEDcTUQSf6Va6D8zwAsxUYGScpaAAZUzysmsxNUMBff60O0gJ4J
         QjEID3WpluAl5oKthTWkvml5GrY+gv5bDAeeRpZVDPNexYoruE90p11gYuIRidWS/TDN
         66Uthl0BxQ8GD5pvJrkoyuENv//fgjllFOIM3t4o7E9rk7pGNH3gz1q4ZH3kOK2EjoQr
         6IszltaZ1K+qzFl+rRbq+uhDDZz/3uxwo59UyTreVUPgEuD2z/G/zq4eR5Sisu5jkWPc
         Hf5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728146846; x=1728751646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hj1spl/h6f2LGGC+51xwjkCU2sNccvLDpAszxwH0jrg=;
        b=uN54t9jOZ9GxyEQVQ9GHXX4xW3svLPw2Ng/omw9rmOgNmGXacH+VbFyw3uFkvqm4mt
         KLJDosmLAwhvWIuJSDrICB5KKzXVtsX6BWwzJQ/l21EoZYmjghvfatnbzTt2ZuX7q6eX
         R5eOWUMRm3dZ99BmJ6lfNN1/ZQ332jbDx3gh95Oxb7Tf2DPHCjpj0nQWHL74Gz57MWX/
         prbDFPcNKb4H8IPnfFC2jgLPFNAedp9cBkLnFLfCbefmmMexOSl6eHntrXJ95iULf6Um
         4LZUNgBirnJ2M5WtYy6JsSf7tB5JzT5mQpJ5ujn+jp4uPqzkULMHkuw+53QELZPEwXIi
         k3rw==
X-Forwarded-Encrypted: i=1; AJvYcCUuZYPWPoM0+SFtu7Itf/sdJjbOhSxBUtX7iKd90Xkct+2y/u6irvyXGcoYDhFzk9xPGz8=@vger.kernel.org, AJvYcCVobz9x3SIH8UOkBh6GX2g5diL59RrjwWxIwslz5gBAy4rhlqOkXLYRZqYrq1z5iOkiES0OB+iXqlu6ojz0@vger.kernel.org
X-Gm-Message-State: AOJu0YwhuYUTaJmu04MBk+lOqMl87rrFny7Gx4dBz8CRaQr/nctxF4g2
	IqeiKfQLY65WHALa8KaPSdfLNVZfRhV2WGqKjvzgJWCvvYkBJHqk
X-Google-Smtp-Source: AGHT+IGxcHPGAqdaeGX/IKVLU9qDsvCJUH4HGqJju1lNE/OrMpBCi2/1enXsTVXUaN4RCxRoTRGzcw==
X-Received: by 2002:a05:600c:3ba9:b0:42c:ba83:3f0e with SMTP id 5b1f17b1804b1-42f85a6d73amr45501295e9.7.1728146845616;
        Sat, 05 Oct 2024 09:47:25 -0700 (PDT)
Received: from work.. ([94.200.20.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89ec71aesm26481515e9.33.2024.10.05.09.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 09:47:24 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: elver@google.com,
	akpm@linux-foundation.org
Cc: andreyknvl@gmail.com,
	bpf@vger.kernel.org,
	dvyukov@google.com,
	glider@google.com,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ryabinin.a.a@gmail.com,
	snovitoll@gmail.com,
	syzbot+61123a5daeb9f7454599@syzkaller.appspotmail.com,
	vincenzo.frascino@arm.com
Subject: [PATCH v2 0/1] mm, kasan, kmsan: copy_from/to_kernel_nofault
Date: Sat,  5 Oct 2024 21:48:12 +0500
Message-Id: <20241005164813.2475778-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CANpmjNOZ4N5mhqWGvEU9zGBxj+jqhG3Q_eM1AbHp0cbSF=HqFw@mail.gmail.com>
References: <CANpmjNOZ4N5mhqWGvEU9zGBxj+jqhG3Q_eM1AbHp0cbSF=HqFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch consolidates the changes from the two previously submitted patches:
1. https://lore.kernel.org/mm-commits/20240927171751.D1BD9C4CEC4@smtp.kernel.org
2. https://lore.kernel.org/mm-commits/20240930162435.9B6CBC4CED0@smtp.kernel.org

In the interest of clarity and easier backporting, this single patch
includes all changes and replaces the two previous patches.

Andrew,
Please drop the two previous patches from the -mm tree in favor of this one.
Apologies for the confusion. Will try to minimize it in future.

The patch is based on the latest Linus tree, where I've squashed
the latest 2 patches merged in -mm tree.

Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>

Sabyrzhan Tasbolatov (1):
  mm, kasan, kmsan: copy_from/to_kernel_nofault

 mm/kasan/kasan_test_c.c | 27 +++++++++++++++++++++++++++
 mm/kmsan/kmsan_test.c   | 17 +++++++++++++++++
 mm/maccess.c            |  7 +++++--
 3 files changed, 49 insertions(+), 2 deletions(-)

-- 
2.34.1


