Return-Path: <bpf+bounces-55423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74326A7ECC4
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 21:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20F9417D2F5
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 19:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053642AEE2;
	Mon,  7 Apr 2025 19:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEgCzH9V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15FC207A06
	for <bpf@vger.kernel.org>; Mon,  7 Apr 2025 19:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744052529; cv=none; b=jTf8cIWqE/vXCqLWmwm+G98CCceNgwIyedpw/AhZf5MBqwmUQdIuflW+eq5nm2kfZwQ0ku8mNSbwFc8Qoxm6/usXUW1zWuNBbcDb1eRZ6lzR08G36sWRO+0pN9KHZFbTaZFPEpcfy0UVaEaMNHifG8sH19VkcE5sYiACr1IXCFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744052529; c=relaxed/simple;
	bh=iSIy/ozocTN1sMg6gmei0ZqB7S7w9IzUzMdAEHLMmvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qXPsxqgK5ga7JGCraz6Ku+kP+J0zXMwbF7SVgo352DMVpgzGbJ9CN+Hq6pVL/SUsGldXVI0o+3xCXWcvSqZB+hoZIX7X96cexLJ2e8e4gYhSLDJ6jBz3QnETBevQP9Nj43wB0oKgf1fxs8OyhO6CDLIohodLi/4N0gbD+/xSC6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEgCzH9V; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54b166fa41bso638560e87.0
        for <bpf@vger.kernel.org>; Mon, 07 Apr 2025 12:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744052526; x=1744657326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/5A+lefkCTNIM1Kmoz+JnU9CPXDJL/98eBVpxOGmfMs=;
        b=WEgCzH9VoDNAQiI7lNK9kF0r/u+jccMOositGxUSRJMkBdNt1bBHcgmExXWRAVGVzd
         1RdnArhSv+QDpOhwwIOHS5buNzxRSRbinhfOl1qTBp09xEz+d6fAuoeqUuhhdhdXwy0w
         FklkyHpAKY6vxl++MdnAQdFdgwcbIyQCWDDPVxyfbCVAi7/VKkBu4AEpycqrIwBB19CM
         B0yH+NXoGIOEybAmn6GBWOxs79oS99x5nm5KzrFXLoxAsUqzSQheJ8MUTKwdU+yMtnDF
         1lWxdySRWwYnq97Me2XxwhNIhiw8i1FAWC9kaAv1O3Z1+c+TaekttRABoU6AdsyETZVe
         7Rrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744052526; x=1744657326;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5A+lefkCTNIM1Kmoz+JnU9CPXDJL/98eBVpxOGmfMs=;
        b=dZQB9OHCn8LeEyl9ccsr6ZqYaqfluJqB2AOJ1I6Hmvaa5xInhKt74pmtwF3gWFsF7r
         zRO4lIESCKbqCzrBE4JdyKmhuK33JaucWO3qrk/xetzAyv0O2TJJgD82e7GImTloVl0T
         QS/vcoIaZ3/BOuW2SLgrdP5JfQ3Pa6Xrhff8mR0mCQHgpdNcWKBjcthUSsaRxdzBxUNd
         pux3hvf7voVESkkklLdaabFqznU8CxaxKaZ9n+HTNy0du/GVHEJxLERtcDsIqXPyUBwF
         UymvdMhXnOm+X7u5PWCTSfZtOJqUgd4y4z8/j7cpQukAynmnF+AwspkxkKOnDFjSjAxx
         3feg==
X-Gm-Message-State: AOJu0YzO7AiSaixg5bQZpz6lel5UkOgHHm1hykin/kYSVhb4c8AUBJJ6
	+s0uykyQdMSHlPauZVPMXF3hK6ILXbDMY5PSKdHbJihk84FNSdrAEOZlelDU
X-Gm-Gg: ASbGncvvgHdlJ3KXPNua62yD9uOMZHKQU8r7O01XMv+kLnFpx41RpO3G3vTd9hUKPQ+
	zVr9QEDstLyiWMD0EL8L6LUF7NbkiYIPrc+7sppe7UxySwK2qnsD7gFErUP6ZcZKPeZIw3zc3/m
	TJDainnlT1QbtIxqYKMjFqLbDfOyJecSRy0VWIUBQRB8UvAyIYEVnCDJTG5uLz6f7/DtdvOjaB1
	P5FlaAgz54/Adm3/oPSKhUIVHoJTVctk8TmpxftNGVXE/NmcdLg7Ng3G8M8t39mnfmiIqNTEZNt
	q27BMnQcUsZrUS+lIwsIWPYP9Z1yp/i/qw3ZOezgKkU3khd+upDlcGZ4m6yP/+s7KznUZdaVH+M
	9IYdJjO/+8xbvjtW300TZ5rVETk4=
X-Google-Smtp-Source: AGHT+IHwll0cOvAhm8XRb+NskRe3X8PlVosjYw+W0Tfx95BKuLLwTepD8xoVGqUtKEN7lVRNhQd2PA==
X-Received: by 2002:a05:6512:3c82:b0:545:1d96:d6f7 with SMTP id 2adb3069b0e04-54c232fd53emr3828716e87.32.1744052525324;
        Mon, 07 Apr 2025 12:02:05 -0700 (PDT)
Received: from cherry-pc-nix.. (static.124.213.12.49.clients.your-server.de. [49.12.213.124])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54c1e5c1c30sm1376997e87.75.2025.04.07.12.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 12:02:04 -0700 (PDT)
From: Timur Chernykh <tim.cherry.co@gmail.com>
To: bpf@vger.kernel.org
Cc: mykyta.yatsenko5@gmail.com
Subject: Improvements of BTF sanitizing for old kernels
Date: Mon,  7 Apr 2025 22:01:36 +0300
Message-ID: <20250407190158.351783-1-tim.cherry.co@gmail.com>
X-Mailer: git-send-email 2.49.0
Reply-To: 20250331201016.345704-1-tim.cherry.co@gmail.com
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I've done fixing comments for first version of patch set (thanks for
Mykyta).

Here's a second version. 

From: Timur Chernykh <tim.cherry.co@gmail.com>
To: bpf@vger.kernel.org
Cc: mykyta.yatsenko5@gmail.com
Bcc: 
Reply-To: 20250331201016.345704-1-tim.cherry.co@gmail.com
Subject: Improvements of BTF sanitizing for old kernels
In-Reply-To: 


