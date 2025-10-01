Return-Path: <bpf+bounces-70085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE16FBB0AE2
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 16:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84B16189C31C
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 14:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B46302CBE;
	Wed,  1 Oct 2025 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAn3vjKh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43E32EC562
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 14:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759328499; cv=none; b=kOC7PQKYBnbmHcgB4sGqgGd+3dJ4bt+RMSRiLoQofJVboSQQiwL5MTJCmTiHqUGyccG4hlMsyiK9F4BPvdOU0T6KZH8JHWpQ2Sp6oM8tX1fGKlByFl4DWbLsZy+vNeGeUJwh/wBUY2s9AKkZndkJFAcg3oiDInqrq57Fn1PSNdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759328499; c=relaxed/simple;
	bh=7wPTpyELQmGX2/gHFloY/1M0+2rpxsGFoW7lJYsgJ+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IaJmn+9Yj5nUef9xmXFaWW2Z3JF1bDy6BOsZF7ASKKsdcp8/bYeAdnoWAChDn1sFo8PFEioy/d7lnyyuzLkCyImaYaMYFR/b0DUO/HeHYHoDRyegzkcL3Ye0rKRx5KRfsKpA7Z/0o8Gu5ixTa6LbkMyKbuYeB+QT7brUegtfwN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAn3vjKh; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-28e8c5d64d8so561905ad.1
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 07:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759328497; x=1759933297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lMWhSbeX6cw48fzbFoy1cFUgN3ejnL4612j1oxAE7Dk=;
        b=KAn3vjKhSUWz2ZlrV40yh3DsNyIluJrX/cz5wnu0PoKMUVNsBOosFOLleig1AOHn2h
         SHUMiNYcIgg93OZPBEJk5IUQeGrYNaxT697orU5i0jxfayn+Lja6X/yuj0fZwtOVqt6Z
         z/hThG/xjnZlCqVs4J8thT0z32uD1ijHH+zlna7o/xjh7g/s/R2e+Elr5Vf9JCQJUGHW
         aMGtI6FBlvH8zlIt/EehOpsz6tY5hKBZ6VGpjwNws5LZVY8uFUx+HGXMOVyQB+M5c3Aj
         O6YHnNW/3ndEpo4b3hXxlJrnQdz/0U+XTja0OkD9+E0FWizl2PZwH8cxhDQ2ufmWGG4p
         mnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759328497; x=1759933297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lMWhSbeX6cw48fzbFoy1cFUgN3ejnL4612j1oxAE7Dk=;
        b=dbNUZCCWDOd5mBCqI2XIya/1jYzD0D5SRinWSacSGO+Kb6lu6+uP62C0Yl/40YgVPl
         pU+ZwmxUKFHqo1y4jrUy2XQczyuKcnzqAZlVT00x8tDQCFZrGLAenQTpGHQddKI3bBqs
         hrx/BWPiFdLqNe4MggpSPeakmoyVeWqgIOJBQ2BJMoZyUHxq/63I7Jc1gfYW2l1x68k9
         C0eoPowgn7WirhyOPC7b1QGAa6qMvvVgtP1X/C7pJRQTC89IkPGU631OKMACq7OXJZRx
         F03a28duNyBZAyA8TlB9lRkQXGgi4cIZJ/vOFIpjkkrQ4Mb/m22yVjTBfh4zwbakcHI7
         IpVg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ73+TTV+I+S1E8x6LG7v0hekov8NlZd0p8SEAe9BrMnsyO9He5yq8T2UTbqBMCOZWkxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK70SuGU1SA6u7BckB4Udu9Pix+Ji3hAaq7VsQGBXaXOfYSjcm
	IKRosRluriLUqOHvhGfNMLiSMlQA/8sA3ll0Yj8o6mOy4Ck04FSAVrVK
X-Gm-Gg: ASbGncu19ZPsbqtMB92bbFVQa+YA7fhH1tmlob5KgMRAiVE1oeDGQk1OD0eN3e9eenz
	sbrTRDg3zj8MWWudPsUC5Xz73XeYIYJT1+IrCqA8VRIKauj3vqQdntV4RVxQV+QDEYfkhOQOle/
	2hSQbvps7lH/g7MFGjNlPKiZSJ/+jxWRowjWCwmcXDZJyZR4ZIFF5+7O2c8PvzKc3tNfcFx7zEj
	HX+77di6hz9Q4dSU5Wl9RE0007ZLwKCl8IJbt85UmHxGPgUZVRjOKGy1WcDj8xBqnDyPucZhkfC
	ysc80aHfYWnc8i53vgEqE7BLIL5RbvT/td5Kuxuw9ldtsxqOKf7MSkJfMTSLjc+fj2tRbHH6Fgx
	t4+7Iban4nAzEvouwIHCTCA9zdCnKFdr5pxvC/45Uwq2l4kJm1MHI6KDR
X-Google-Smtp-Source: AGHT+IER2jDS6uj2GDbaMnP6L4c3WqPqi3KT3PXd625o+OeslYZ1EKXr3ggxx/CbltvRyA/XG6FRGA==
X-Received: by 2002:a17:902:db11:b0:248:7018:c739 with SMTP id d9443c01a7336-28e7f2f7581mr50724135ad.28.1759328496781;
        Wed, 01 Oct 2025 07:21:36 -0700 (PDT)
Received: from archlinux ([205.254.163.110])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6089794447sm1598595a12.35.2025.10.01.07.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 07:21:36 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: verifier: should we handle mark_chain_precision return value properly in loop_flag_is_zero?
Date: Wed,  1 Oct 2025 19:51:26 +0530
Message-ID: <20251001142127.37559-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi folks,
While going through the verifier code, I noticed that the integer return value of mark_chain_precision() is ignored within loop_flag_is_zero().

static bool loop_flag_is_zero(struct bpf_verifier_env *env)
{
    struct bpf_reg_state *regs = cur_regs(env);
    struct bpf_reg_state *reg = &regs[BPF_REG_4];
    bool reg_is_null = register_is_null(reg);

    if (reg_is_null)
        mark_chain_precision(env, BPF_REG_4);

    return reg_is_null;
}

My question is:
Is this behavior intentional (i.e., errors from mark_chain_precision() are safe to ignore here)?
Or should loop_flag_is_zero() propagate the error to update_loop_inline_state() and from there to check_helper_call() function?
I’d appreciate any clarification or suggestions. Apologies if this kind of question isn’t appropriate for the mailing list, I wanted to clarify the intended semantics before attempting a fix.

Thanks,
Suchit Karunakaran

