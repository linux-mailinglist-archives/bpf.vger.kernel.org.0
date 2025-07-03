Return-Path: <bpf+bounces-62344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E158AF82B2
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 23:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9797A58727A
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 21:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F67B2BE629;
	Thu,  3 Jul 2025 21:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxv4yIRu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3937029A300
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 21:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751578515; cv=none; b=XUCFRuLuUCx+nw//L3VM9cokbv8LaCxkd75Fj3egGTClmbY8g/BDO7xnbmdHVXbjiWLxuRO1D/uBVXe9hEONKkpoEgZo9IariF5eE2TRotOenpycqNnHf9knbD3JDx/GH2aGfXsdsPbdvRY9qhYEpaLvxh21qNXYv1LtH9Rn26I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751578515; c=relaxed/simple;
	bh=pVHVTa8FPYThapZvFW79iGfTEDdv9Y/fmRB2UDHgZro=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bLVjNz9N7ID0pnhEBK1Zp+NBgAD4AHA++m3KDIdZ98Mpq2XJr2a4hD+dg07euImTOtG15Zg0bFFnqwGUqGJf/IGDwu2Lc4zewzef3JQedlvuidTvQq0GKkXZiPkxici3pE+T/07UzdMfKqY7Fh7OHRjaLigi9jcB7nkHpVttAI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxv4yIRu; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4538bc1cffdso2579505e9.0
        for <bpf@vger.kernel.org>; Thu, 03 Jul 2025 14:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751578512; x=1752183312; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K0ErljqOcapH/DL7OpmwNPutEBArJZAQx/cMmvg4GmE=;
        b=cxv4yIRuBEt2w29Or84UoFuokMv9FzMFdSIvmKM/E/QfxqWZsBbQOSjOFRo/nM1FY9
         KFWgQy7q9KhrmhGWMgsKkFpDx+7RFZJtN7K3tia61z7P8eufT7LgVNonSIjKjetyeJ5f
         z3gb7fwzqgdQ56LDPhnVqizMGoyID3IELCxqmSPdkqJwpatpwoDGx7BMSL57FA/qg8tv
         Af0i5BJb/CXMd8oJuhjdBrGCYFeNqIlygRn9M2jI2GtUeMMm046o2jP38k763p6YKyRQ
         nqnJUWNy+87fSxgV/KIovy3vnuLv3w9XS31F8K89AccnLh+l6KDO1OUNKeVS0Zg17ask
         Yqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751578512; x=1752183312;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K0ErljqOcapH/DL7OpmwNPutEBArJZAQx/cMmvg4GmE=;
        b=D0UCV0Zx1ZN+yUC/uNmV03mJ3jLrAJQcBpErv9Rn/Qee6FIGkhgCWe5ymEewWHZk+a
         yZ9boc3O0R8exK/ueLz5feDZLQI6eZ1htDw4J6ynucA+hqSoJfYCXbTlrmhQ/X8I6hlw
         l8JXUpJ3s4A1LZsG7P8HvZ0ckfXGhUeuycbMAoaAJ02EtLzw/K88nxxclOBytQpYf/ae
         1UCYMLtSrTkhUAuqSWBxlaKq/XI44rUucyzOPJboJeJnVkSRkJy8yPt6QvNBjtnxPHsF
         UnJGoOgGz2NfQgwglipftDY0sbentAGztpg/LMT7/86veIJDZY+FIfFco7NQNJWpUbf7
         Bueg==
X-Gm-Message-State: AOJu0YxbPUGDnpjzc/a56QJud6+qGrbA+U2Xq9ESSb3LEYEelfZbOQyl
	F7q7EmbvRyDspWYpyFvGHGhQlhUPhqQQ6aUoM9xP23XUTaX5TL0PmBxELNeWfMaM
X-Gm-Gg: ASbGncsj0uRm+V+50RcHHfZtvywaq6XDdqxE3irfj/r0S4ZgP/ZCjfXfpVeIYdpJSSd
	R4aPv5dvo27NUtlsJo4TJBphqB7KxjB0Br5ZqqLGjdE0uuz0fnmJsQhBPpATHoAFITLYiWBM/Mp
	0P2IvrxjptLY2RRNpFLwwxb6D4+lYaZDlTiWowAYIVcqVzFtR0GyOGIVxFzbS97QXteivYibWRk
	vdzUEeUkwbXWb50O6Afoxpl4Uh3fontBPw0fk5lEmd6jTNP9haI7HZ/XA1Ok9Rx0A0Bs2md76eJ
	8bvgrF65hwAvAO/0kFol5XMTz7UB684fFKzYaN7nFg+ADY75iyM21Lo5dqqOFjE0CD66sNBRYqP
	7ammc9K7DuUTYop9X4RCzbcBg1lJvDY3WyV0Qf8LaWQNzg2YhAQ==
X-Google-Smtp-Source: AGHT+IHKAH2TusWGBJVgE0kSKB2N1Jsh63Qv/4HLGWk4HD248flLlP0COPNjGWAEq+crRN9buYN/pw==
X-Received: by 2002:a05:600c:608c:b0:43d:2230:300f with SMTP id 5b1f17b1804b1-454b31ef9c5mr933605e9.0.1751578512233;
        Thu, 03 Jul 2025 14:35:12 -0700 (PDT)
Received: from Tunnel (2a01cb089436c00023855d33d1cb3f03.ipv6.abo.wanadoo.fr. [2a01:cb08:9436:c000:2385:5d33:d1cb:3f03])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a9969409sm36943725e9.4.2025.07.03.14.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 14:35:11 -0700 (PDT)
Date: Thu, 3 Jul 2025 23:35:09 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 1/2] bpf: Avoid warning on unexpected map for tail
 call
Message-ID: <1f395b74e73022e47e04a31735f258babf305420.1751578055.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Before handling the tail call in record_func_key(), we check that the
map is of the expected type and log a verifier error if it isn't. Such
an error however doesn't indicate anything wrong with the verifier. The
check for map<>func compatibility is done after record_func_key(), by
check_map_func_compatibility().

Therefore, this patch logs the error as a typical reject instead of a
verifier error.

Fixes: d2e4c1e6c294 ("bpf: Constant map key tracking for prog array pokes")
Fixes: 0df1a55afa83 ("bpf: Warn on internal verifier errors")
Reported-by: syzbot+efb099d5833bca355e51@syzkaller.appspotmail.com
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
Note: I'm sending this to bpf-next and not bpf because the warning
addition from commit 0df1a55afa83 didn't make it into bpf yet.

 kernel/bpf/verifier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 52e36fd23f40..c71e75e4740a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11081,8 +11081,8 @@ record_func_key(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 	if (func_id != BPF_FUNC_tail_call)
 		return 0;
 	if (!map || map->map_type != BPF_MAP_TYPE_PROG_ARRAY) {
-		verifier_bug(env, "expected array map for tail call");
-		return -EFAULT;
+		verbose(env, "expected prog array map for tail call");
+		return -EINVAL;
 	}
 
 	reg = &regs[BPF_REG_3];
-- 
2.43.0


