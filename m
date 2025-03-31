Return-Path: <bpf+bounces-55010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 174A4A76FAB
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 22:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C70D31656F3
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 20:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0953021ABD7;
	Mon, 31 Mar 2025 20:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FByPDfeA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FAD214A7B
	for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 20:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743454195; cv=none; b=RVCzRPN872Pg6cvsWDy3AVJDxr22lHp7ISQVFm2V+hzv+tBO7kyEP3TjXia+mNwELa0Tue/SxuDC5SFS41wOKCvHS2e6ALYowB7zopSaxmyBLoFDIBYb1l/6A5HZmVKjm5UZuOxS/U1RS+iejy9kt4gJRIX2fvT5oeFTAb08MYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743454195; c=relaxed/simple;
	bh=iuujmaNpzAWPuKLMG1PGfiHggmcsIy/LHVzCDzTyWHM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZPLnqaz8t1kTNOvw7hv21L0WZVyTT8DqEM7dpfeqIr2SINhnHIcnAsNL5cKwJh8mptMuYR8QZGvKGWibYmZIm1XnG7nXRrS7TRdnZSDsWjnyg0KWsixQRIVC9pnOB260UnfgRQnLAAJs+DNs5QoIOzi/x9XR+opJDMYQVKmRCN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FByPDfeA; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30db3f3c907so46515911fa.1
        for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 13:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743454192; x=1744058992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=iuujmaNpzAWPuKLMG1PGfiHggmcsIy/LHVzCDzTyWHM=;
        b=FByPDfeAOz4fZ/8dXL1LRBQvSwMeyI2d9+guXKgo1al6EHap5x4paU2j/uNiJNV70V
         WqdKCeJ0e+beM1yfluEiAfXd+gQhDBS2JYS+LJvWD3vNPKPRiT/d9fbVSkUJfwkUyFqU
         zuVQsELKCttAhgLPBgOUVBaHtN5vdLw36Kit9BA8V1ATRht4gzNi2zvtu1lb47LIzC9l
         gshQ/neX/sYftDQGbjFh/QFiZKabboGk3quCL1mu3NHtSV05UX04jeeBGLImtsDld34/
         M4is49ek/ZxS+pcR2F6vGz+1mY+UbDYxt46JPPYe8P4X1bFLitrZo1O1p6vMlCTwnouX
         3JWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743454192; x=1744058992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iuujmaNpzAWPuKLMG1PGfiHggmcsIy/LHVzCDzTyWHM=;
        b=KwG5tyfFK/hjU2lrVJFfQNIYpPU4DgxhqVY4f83zc6ZUO5C1R1/9ujmbl2jznRBs76
         vbCaKJ0J7sf1NKPv34CO85nT2VxRrYhpwf+r7AqHumfMQoxRC7t/YHsqZRO4ICAcLucS
         CSnOdYIEJc6JDQjUswmRykPbTr7l2xifxfFWOuud9nQRM0lGWFv8VW0uIpOR51TTc7a9
         qkXpCWutjAj1I57SNM6cJcszd8jJ+1Soehv76QA1haEn6T6Sb42Injrm1PNuXE1sKiSX
         OOdRHBis4Xn8YgDdGudrKp0z5w69SKMDAvti9lPK8Mjgr6MD/VckNUpQgHkT8HYDmx9p
         3WVw==
X-Gm-Message-State: AOJu0YxqWUz+8Nfen6lezjWdwpw8fyDzEy+01ETlrVDGZawcloWSMZtZ
	O+LCG2q5aeR5Y2uj5F4W1ZJAX8cc74g1qWr3EXZe0iQ3OcbXfsDD9WVZJ41p
X-Gm-Gg: ASbGncuQzyG1NKRsmisno2Xf8e4W7LoDJSk31Cy723rN7joJioCCTmu+cc2iVvnuKp5
	F8fdwzQy9YlkCATr7rrP8hNZ1YwrSlCfdEjgxUsHRkKv4DAjDuYajVHJStX5zH8dTGyhLBF14mf
	aNn5co2MfeIRPwJXqUy5E2jzj3fAE6Pki4kxkMcuTkQOKujj8L2Z2Ncgdg5hYDi+EeIBJEeeZdM
	O3ZwVQ6GM6ryzwgU9X5AvE79sw1Ia6KaEImBCUiWfx4bKZ/1rZ2Bl+bvX3iKa7Cm9sGZUPZAXi5
	9+T4aIVqpIY+7JA69MaoU6VksshgA8e/HYuu2hDe60aLqHAmLyjyG4t1NQGn49Zl3J0YKrqyi77
	RR8ZIEZ73MzdsIhvC8eqzU8FRGpFKdwBd+umx7A==
X-Google-Smtp-Source: AGHT+IHjrqBMTBKGNgeB3s9tcSHYduv7BgkVIG3XFRfJK6fyuhUX8RHTTNlMMnBvIPYfE6mX/5aAXQ==
X-Received: by 2002:a2e:a889:0:b0:30c:50fd:925e with SMTP id 38308e7fff4ca-30de0231956mr28979901fa.3.1743454191727;
        Mon, 31 Mar 2025 13:49:51 -0700 (PDT)
Received: from cherry-pc-nix.. (static.124.213.12.49.clients.your-server.de. [49.12.213.124])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30dd2aa931dsm15134651fa.15.2025.03.31.13.49.50
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 13:49:50 -0700 (PDT)
From: Timur Chernykh <tim.cherry.co@gmail.com>
To: bpf@vger.kernel.org
Subject: Improvements of BTF sanitizing for old kernels
Date: Mon, 31 Mar 2025 23:45:06 +0300
Message-ID: <20250331204945.357823-1-tim.cherry.co@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm very sorry, but I found a small typo in 2nd patch, here's a
quick fix for one.

From: Timur Chernykh <tim.cherry.co@gmail.com>
To: bpf@vger.kernel.org
Subject: Improvements of BTF sanitizing for old kernels


