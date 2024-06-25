Return-Path: <bpf+bounces-33103-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F4291725A
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 22:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4CEBB21998
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 20:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28E017D353;
	Tue, 25 Jun 2024 20:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8/FlZir"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040EB176AD8
	for <bpf@vger.kernel.org>; Tue, 25 Jun 2024 20:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719346596; cv=none; b=QBsBXblPPzR0/sk6JUhBz9N0LvpGo7wI21sf5MsUKhRoMBNqj04GwPIOBhIZvq5nb2DnNpKVH/NAoZFcpO0hEdLGKxV1fF85v64VPQ7BME12H5siMme6g2704OhmtNfYzkcfwcGELqWW9WlR1wfGlfHbAJMQb9w7lCTNGjSI7k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719346596; c=relaxed/simple;
	bh=M3UCIQ8eFEHAGujLA+cytz+/g5O69OcS+eMq6dvf2fQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pV+lCKzNGlUCdc9BJBS8Ga5GEf7R5ze2nMhRDTV2LdLA+PMwHtFJ726csPcNV0Psm45n/VsMFfV2oukaVcUtH9HO9YFF2kP5tVJ1esI7ed8izJ5AOpj0Vk39sWWZpq+oLLh5SmqXf1Rhsee2VwIIQPaRsQb9yNFfmR8Clhez1oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8/FlZir; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f4c7b022f8so51040675ad.1
        for <bpf@vger.kernel.org>; Tue, 25 Jun 2024 13:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719346594; x=1719951394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iYGse+W4CjPsnrsjyd8/ga8OL/YPPZUTzLBYioxifnE=;
        b=F8/FlZirBEXfx4plsM/1qltMIaPbhGCBw3AZYU8mwQr5WIvs0Na+VBHgXTyQQ1TTmY
         lB3nWeJUmZ7HqykxbpKHhqZZf5RYkNQY5bJLkZDFf8Vl1L4BYMbI5frOTQxqTEmOZ8Lu
         s+iotKuzbBT2WqXUUrc4vkgMFfRwVXQUXq8yc1StD3QHiu/mmWRStg5GbcDXGG10Tuxx
         lOt27U7Bq0EUyantvgoJ4dqaDlxnrZRwE8dsqgjUXN5BBgjD+WHB7KqFjSxrCR6Z4N/D
         GfQB1Y1z+NMbQMNiVFNrH98wjFxZgF6Ef3me7VJPYa8eB7rhCjCGoB2Tx+zx60ULyy9e
         nbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719346594; x=1719951394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iYGse+W4CjPsnrsjyd8/ga8OL/YPPZUTzLBYioxifnE=;
        b=P7nCY4frNWyg0tymhnwL7RwtlgcQEsgS+eBHHxmuUqHQWZwj2dnMTlgttpipmNUYzw
         vyATmdiYfz/gCLX2PAWzwxz3jF1M4GpZrwzxdih7h+Fj0jNUc6dsVGDf3FDZOw27FEF/
         0z1BP7clWCp7eIc2gRVoyVJ6hsaD8c7gsBtwgXpRjV4t63pn0cGUk4sIzjSHPSxJD2za
         +o8/0OYqu0RkK9tPssNVSAX5m3pAXGK2G/dwmdXH7WYV71YEkMPGZ1UHf98xYNevchPl
         VX4sEINhgKbnESglCq6tvhv6TvavLfiQWK01W26sv/BgSIIdDDT690JyCH2GYl+qrJ5W
         m4CA==
X-Gm-Message-State: AOJu0YwCcGhP+c3mli744gZXcNoRZZ04LTPaGvwHwkN66+uhjQ48UqNI
	MA+TXvgNDAjUAQZjm9Npeg2uXgIcCdBalBUKHaR0QcET4CCikw/ZZj2Ewg==
X-Google-Smtp-Source: AGHT+IFq4sp9Yhgfh80z1XrHKkl9H6x4e5KbCGh757HJCZNasp0vvJWKItf/AtZCgPlfiowuwPxywg==
X-Received: by 2002:a17:902:e542:b0:1f6:51f5:540c with SMTP id d9443c01a7336-1fa23cd9623mr115681745ad.29.1719346594067;
        Tue, 25 Jun 2024 13:16:34 -0700 (PDT)
Received: from john.. ([98.97.39.193])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebabc13fsm85600725ad.250.2024.06.25.13.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 13:16:33 -0700 (PDT)
From: John Fastabend <john.fastabend@gmail.com>
To: bpf@vger.kernel.org,
	vincent.whitchurch@datadoghq.com
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com
Subject: [PATCH bpf 0/2] Fix reported sockmap splat
Date: Tue, 25 Jun 2024 13:16:30 -0700
Message-Id: <20240625201632.49024-1-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix regression introduced in sockmap for the case with strparser
and verdict and returning SK_PASS verdict on a skb. We did not
have a test for this case so we add it here as well.

Todo is to finalize porting all tests into normal CI coverage
to make it easier to audit and run tests. That will go through
bpf-next though.

John Fastabend (2):
  bpf: sockmap, fix introduced strparser recursive lock
  bpf: sockmap, add test for ingress through strparser

 include/linux/skmsg.h                      |  9 +++++++--
 net/core/skmsg.c                           |  5 ++++-
 tools/testing/selftests/bpf/test_sockmap.c | 13 ++++++++++++-
 3 files changed, 23 insertions(+), 4 deletions(-)

-- 
2.33.0


