Return-Path: <bpf+bounces-37771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 105E595A698
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 23:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C17B12845D2
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 21:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAD4176FA5;
	Wed, 21 Aug 2024 21:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b="LYCrD1vS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B76A16FF3B
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 21:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724275831; cv=none; b=QgmnFcZGM0+sZgbU4Ns64LO6j5hcw+M0DAnMl/jGa7WrobJYm8irKkaIhFL+G3lDrzUhXb2R2UjJgmXVg7nWCjzJ1LuT9k2hwVDw6otynDWSc2cCVqOeStHL+hfgxH9PN+Xux2mCfphKIcZfPEE+12HyzDwSxTXbAD/GYt+s4S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724275831; c=relaxed/simple;
	bh=QHk+qdsZW25HQ7w3PnN1ns7RmVSn8fnN4Gw9zaAVNcY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ep6sh26yIvaoQW/068ZOqykEp4sA3jBIgAQ4PbSjfVTviCmc8CF7n0FV6XgRmzplZeEb8Pi+4fPKiSq5LLkZk/uVsqqpJ2rRcq+ISz1oFJneHHTOfXuknKOr7ntJN8wfqgnVosejggiUSlp4AFVCS8iRm8Mptdb7/gpVwylc0bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu; spf=pass smtp.mailfrom=uci.edu; dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b=LYCrD1vS; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53349ee42a9so177468e87.3
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 14:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1724275828; x=1724880628; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3vgb9ZKIppyMEbPzhe2uzTBHHAKnXCzAdEglDrbqk2k=;
        b=LYCrD1vSuN1wxJJlm8a9vnEdbbPNIhiX9+xpJcEo/8iq99Nb5x/2P2yO452uPYM+MI
         2H52uTYG1GZRsbu8snETqeU6V8BqeLyuUMlHynyqUAPfX5EkiS2gZ9aZo0fSwKLWx64L
         IALHWCEMMpfbRJuoRWejzpVhzC+BMCHgjcWlnz9lujjCopQXHExTbHTS+YwSUKAViZus
         2Bf/hWgKJmOrC/xqSReM9YUx0fPsYgcveEmoH2xZwwiY1NleU+4lA0QJ2i0XdfQsVJpm
         2kmdDLDWvBhe5jlV9lz7fLFDxCV7PmlF/N20ZtyrvpxNkWvijyJLGmdiPAIzA0CdDBJK
         vTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724275828; x=1724880628;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3vgb9ZKIppyMEbPzhe2uzTBHHAKnXCzAdEglDrbqk2k=;
        b=RxDX7422DgcOVdrJyCPpaok98Uzxx0xGLfxGgB71ixiUIAEk4CUc+S0jVMR9Z/stZP
         HSP9/fZgeR8JmDh7g54pfePduvXwLXToWyEWBXpunpZPwKWhn6AKgGTYad/eroS7seQK
         fvtS2BTWp4ABe/Di5nmWn8Hcb5VPx2Xm3pHlDZzOV+/ZpujXGE0YwcOaim+X3o1hYO0I
         SxStTp0fHWmwPPQeyJ7zQPgd6G0ePoxiO1JtzYahzh9YMJ9si9m/BcFo1VPzy4pidowe
         8LwmuTIZrHs2RYt5qj6DOZebZcx9QrG+YmVVP/uM3WemTW8ZXFnJPqv+cQqwEvng/Plz
         8tLA==
X-Gm-Message-State: AOJu0YyWkLex5AbKOQ3DhwXuxZBgaus/OG9D8nq0Lz08Qt+0oGrUpu5B
	fBGKQk3MZjVioY0e6UwxhlYAfkPGeErB73Q14Dm6vFZpBF0/OczrqII7Vlfd3IhhYMgSSJgde3x
	AZ27zMs8h08fYjTIGv2jymOOvqKDxGElRFausrg==
X-Google-Smtp-Source: AGHT+IELbCvH3tF6wMuS3kyoeDkvCadS6CllDK3TUsVHvCxftiUPQLFPL1RUmpp0SnkE6JBUmzgonVJOpsAIWkZ26Pg=
X-Received: by 2002:a05:6512:2243:b0:52f:c148:f5e4 with SMTP id
 2adb3069b0e04-533485592e0mr2412515e87.21.1724275828074; Wed, 21 Aug 2024
 14:30:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Priya Bala Govindasamy <pgovind2@uci.edu>
Date: Wed, 21 Aug 2024 14:30:16 -0700
Message-ID: <CAPPBnEZmFA3ab8Uc=PEm0bdojZy=7T_F5_+eyZSHyZR3MBG4Vw@mail.gmail.com>
Subject: [PATCH bpf-next] bpf/bpf_lru_list: make bpf_common_lru_pop_free safe
 in NMI
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Ardalan Amiri Sani <ardalan@uci.edu>, 
	Hsin-Wei Hung <hsinweih@uci.edu>
Content-Type: text/plain; charset="UTF-8"

bpf_common_lru_pop_free uses raw_spin_lock_irqsave. This function is
used by htab_lru_map_update_elem() which can be called from an
NMI. A deadlock can happen if a bpf program holding the lock is
interrupted by the same program in NMI. Use raw_spin_trylock_irqsave if
in NMI.

Fixes: 3a08c2fd7634 (bpf: LRU list)
Signed-off-by: Priya Bala Govindasamy <pgovind2@uci.edu>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/bpf_lru_list.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
index c4a9e861369b..c575f27ddc31 100644
--- a/kernel/bpf/bpf_lru_list.c
+++ b/kernel/bpf/bpf_lru_list.c
@@ -450,7 +450,12 @@ static struct bpf_lru_node
*bpf_common_lru_pop_free(struct bpf_lru *lru,

        loc_l = per_cpu_ptr(clru->local_list, cpu);

-       raw_spin_lock_irqsave(&loc_l->lock, flags);
+       if (in_nmi()) {
+               if (!raw_spin_trylock_irqsave(&loc_l->lock, flags))
+                       return NULL;
+       } else {
+               raw_spin_lock_irqsave(&loc_l->lock, flags);
+       }

        node = __local_list_pop_free(loc_l);
        if (!node) {

