Return-Path: <bpf+bounces-11368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA03C7B7FA6
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 14:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 705761F224D5
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 12:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2BC13FE6;
	Wed,  4 Oct 2023 12:48:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF332C9D;
	Wed,  4 Oct 2023 12:48:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98219C433C8;
	Wed,  4 Oct 2023 12:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696423724;
	bh=6WYm0QAkHROFtznZ1wtrRyn0Hg3tizoNA4DjPeeCKhQ=;
	h=From:To:Cc:Subject:Date:From;
	b=id+lIPc/S1N9uh1vYCyOj8zuYxrHSja3cnTjcJQWVwZGp148U0se12TmgjWVVSn4r
	 uB864HMagHQTift/X0AsbICKwd8SG00N8OfNGhvxuhM74Xhzf394sOWXAMQUPwZiG3
	 uJVuq79glRRC0ZddkQ+c9zjCRPK38GoGskZ4cOg7Oa59ixC+zEqrhknPSpK11XuDOI
	 DB2Ol/aUC/X3jr+tvPDwYlE0u5NTYnPpUdbmglZr0b4PHdspFA7DF8wVYJnxquHJpd
	 hPVOvWwfaWrQgj3SaOcZ0PDWz/Ew2GRBIjgVdFlY6O10ycUiRjsOeput3usxmd/DmT
	 ghbIfw6Du3CEg==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kbuild@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 0/2] kbuild: kselftest-merge target improvements
Date: Wed,  4 Oct 2023 14:48:35 +0200
Message-Id: <20231004124837.56536-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

Two minor changes to the kselftest-merge target:

1. Let builtin have presedence over modules when merging configs
2. Merge per-arch configs, if available


Björn

Björn Töpel (2):
  kbuild: Let builtin have precedence over modules for kselftest-merge
  kbuild: Merge per-arch config for kselftest-merge target

 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
-- 
2.39.2


