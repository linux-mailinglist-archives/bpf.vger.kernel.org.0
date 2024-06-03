Return-Path: <bpf+bounces-31191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE028D8203
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 14:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C77E61F22AED
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 12:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4427612AAC4;
	Mon,  3 Jun 2024 12:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApD1On5A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A17129E8E
	for <bpf@vger.kernel.org>; Mon,  3 Jun 2024 12:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717417013; cv=none; b=p1oYKd29ub6EfUZDCgiEydg0hPWWkYIexlv+eRxhFyJ7bAYHX+P4rUQlLtmIbni0+y+w/gUU9Og8qR1ryK3dK+DnzWZ41kTz4diBx7JoBdW6CJO/7lQKKwqyquW4bLXb06fMs5P02c0upAzbaVgT9nexbu8AfUY6js7JZflM5/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717417013; c=relaxed/simple;
	bh=LNoei3GA72yWTn14T/waYC4yTMKAPFmkf5G5r+ZC/y8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O/rMsrPSR7hC9wlN5e/P4w74kr/MfCtqE/wu2El7VVrMAeo1pN0o6zMGxdsqxOKm81QW7H7+DUYr7+KcgM/5hxtx65x6WAcGvQTVdDIzXqub/gVpPlXD0aqMSZOxnmEXM4pAqrnXrBt44amOJ2VQtdJPT3YpIdn53kc5Mrf+ghw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApD1On5A; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso2168582a12.2
        for <bpf@vger.kernel.org>; Mon, 03 Jun 2024 05:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717417012; x=1718021812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bc+5KmXQdR0YlvxYXrkRiQKWN0U+4M+4EeM39qU+Hik=;
        b=ApD1On5Ax3/2fhWa95FtmoEEy98z9KJpsjXhtbioHEbQceHFzgY958RpplYJXkmJYe
         +EksZ+nPEPuBVL0wBN9Lj2rIL61Pcg471Jp+kJ7cRozKOWp4Lub0tvUmbZIJudTSor0v
         rea7Nqp1DcIEU+1c6hnavj04KxCBPZRWDjK4wzXpvRy3ej/mEts/i0xQJkKCG0WcOnJq
         jFZMxzgdsbqMgXK/7JKCIqEB3+YOKzs3t089kFAbQVn/LS9R2JF57GYcccsfRH2QY+Np
         AYp6EpjnTVQERn4kJ01miQNXCbFmLhHOK+vKADQ1u0my+OODeAK9v4DEb8vqSj7Mj4y+
         tskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717417012; x=1718021812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bc+5KmXQdR0YlvxYXrkRiQKWN0U+4M+4EeM39qU+Hik=;
        b=w8AEp3LAkAR/CqZjF6Tb3y7mlbrujegSANSEkFygINz/G3c4OwCNwiGqzOt1mEVLrg
         7WHfIXUPEL4B6Q+j61Rk9Os7Hy7NeyQMbXrICixfhOEuOzozdps4Zq7jmd8xpXek774F
         OCNXkp+AVd3weXQA0Ecz2lJzJp8yswW2te0A9gImCExIvh8GdNnoJrcNMJGq2Z9Osl8H
         Fdf0c7iN9lUvJiSVFuLZwhW0+0dGxXSQ3qaqwc0glK603v5IgYl1axnFvWUlVVxbECo6
         aQfQqYtyq8rYmivvwpmJ/G1oIu31iN2+r2avskVcTEN8tDL5BQj3ijzSOyJgVfCfx7ju
         AeTw==
X-Gm-Message-State: AOJu0Yy7fi5DQtxiOj1q+88Fju5dYjEY2TUOqcBNBMoBSv1jIDIx+TYK
	USHVZfxbmjS5TBND5l62Fh/7WO0GuvFMJz2lRMckeSVfXqRQVfx3ce7wPnNI
X-Google-Smtp-Source: AGHT+IEX6nH+nI/tT/+hqygCT8QWW2tEToeh28Qjj6OFPlxyn7Hta7o0eiSAp9SiO44jQYZWbGWngQ==
X-Received: by 2002:a17:90b:5350:b0:2bf:e6f1:59e9 with SMTP id 98e67ed59e1d1-2c1dc5921b1mr7871408a91.20.1717417011604;
        Mon, 03 Jun 2024 05:16:51 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1a776f526sm8340820a91.13.2024.06.03.05.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 05:16:51 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
To: bpf@vger.kernel.org
Cc: Tony Ambardar <Tony.Ambardar@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH bpf v1 0/2] bpf: Fix linker optimization removing kfuncs
Date: Mon,  3 Jun 2024 05:16:42 -0700
Message-Id: <cover.1717413886.git.Tony.Ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Zl2GtXy7+Xfr66lX@kodidev-ubuntu>
References: <Zl2GtXy7+Xfr66lX@kodidev-ubuntu>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series fixes unwanted stripping of kernel kfuncs during linker
optimization, as indicated by build warnings from resolve_btfids e.g.
"WARN: resolve_btfids: unresolved symbol ...". This can happen because the
__bpf_kfunc macro annotating kfunc declarations is ignored during linking.

Patch 1 adds support for the compiler attribute "__retain__", used to
avoid linker garbage cleanup. Patch 2 then updates __bpf_kfunc to use this
attribute when LTO builds are enabled.


Tony Ambardar (2):
  Compiler Attributes: Add __retain macro
  bpf: Harden __bpf_kfunc tag against linker kfunc removal

 include/linux/btf.h                 |  2 +-
 include/linux/compiler_attributes.h | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.34.1


