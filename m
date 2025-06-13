Return-Path: <bpf+bounces-60625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED95AD93FF
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 19:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 093463BB86C
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 17:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC7622839A;
	Fri, 13 Jun 2025 17:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cegDHkEM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF7D1E5729
	for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 17:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749837216; cv=none; b=p8JAtS2gxkExo+JbeUev1zyx6mkl5/kIaU4gMYQdZ34MmRAZP+BOfSJxOCwJ3Yj6EQ7McDAAXClEptWHz8v0ztSFIIr5smzmRMfVd5/W3Ycdx32ZutjOX32cvg2tg1D57vKyZ+qmeHYR+or7DZksVkXgpnx1cp0BGYtlu4av+Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749837216; c=relaxed/simple;
	bh=1GRWsFRJ3GmLZFcQle22u7krkRFbEJfqAWrJ18LHURw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ny2PhuU/4AyOo/2JYHNyvth/Vs9sIzo3PNEidGvNpMhOk2U+W2jcuyj4FChIq4gtztfnmQGyp4EIo+m1RtTOhgqs7w2ji4qCt2lKuWXyWRhqSpodX8qr1d3Ie/YVTNJnHGMQ2ZLfhZW/pKlbwoEUvfRuy5vQh5X0s9JfkYNF14E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cegDHkEM; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-70f147b5a52so17214627b3.3
        for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 10:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749837214; x=1750442014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SeSV/2/ei9POAep2ohfWBpVKq3RLuq6eW35/jrkAgA0=;
        b=cegDHkEMLfHm7Vi6GDIbU4DEBKR9SsY3H9yE5HbCcxxxrXQwgvngVx6WaOqAoypzx8
         2/6RA+aOeBF0dthxUrr9qlKiSNB0ats6wtkMJq9B3KMlGyPtBQ65TkRXGZIlC+B/j4PX
         9Bjthu1xvSs6oJ6U0mHm+i0cYeCOTZtrVWAfGjqJh+5HT40RPBDN4dqFf8KYKqcBBkS7
         cboucyTEuvct06dyeXGN5ifX4uZgCjR6nSVH6jMCbbAKEbJqcp9uhIekM3LjlXb25vbT
         umubFjFpiOeqrbl8WZ+EaXbqb5fF890YJsnFCp9qG4OKMvhFI0aKa06gvGFP//O9TPR0
         GpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749837214; x=1750442014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SeSV/2/ei9POAep2ohfWBpVKq3RLuq6eW35/jrkAgA0=;
        b=RUqHzsCjx4pthCa3YQGAXwnjC7UCXVTUI89k74ex0Ji5/IuQR8fC4NPsVVS8A2JuJd
         IHAfXX2mOdUjVDEBZM0Bd0NTZQVkz7LvOZPo+gfXTrXZqzbhV/Yx1XjDmi1BL+YMxR23
         Czdu9+Kuhy9p3ZzQ9VQfOJ/n3WCwx6sRbOrZclx8fzAdjKpaU6seAmqtvJIBwS5cAFyt
         d0WTJ6svnXEPucjx614X7jS7yDP8D815pNHRScMsg6nkNBiJyFWw8qn+L8urkOvlodrH
         1uLwrRwJRXJTUe5fkm2aZugqTvaMfsMoS1LgJ0XSBBP+pJslVz6H9yokZS+ODgJK5ALQ
         B96A==
X-Gm-Message-State: AOJu0Yx7sy4gAftA2HmjR8IlWMrRhwkUMJG0zEDMfZtLaTyeN/tdD4SV
	nd4Q0OTDT15PDpiSLg2v9oRFaJvRMTHjHWVdCFxnH1LzQ/BAsHpovNl1gdXexAoU
X-Gm-Gg: ASbGnct1C7wFWigeVXqXibelZyTE2uknimldTkf1oG46TpzKm5ov7Ms7tDWcTKO/rQF
	Kzp5fgf77u3QevHwj6l1yiX8On54GLKEUxxqYlRmEc5gWl8l2r5u7WUOrAgkZh34bA+A1MuaI1R
	3UIw11eBvO4biet/0XtYiKI+JJwQ/B3UibmsuJw5P0spJvThVi7WEjDcTS81e/Xf6ratHBO00zS
	vO9SmlicgZ9lyhG6tkqgkLAxjQS1QTjV1iZP5xXbjXCY29qLz1N6Syya79n1b96L18TENBoewo7
	ohBO87A9TDdCDgzRhM5aCl+sj4pyQwJW5n9c4VeuH6vjC8SXMHwx
X-Google-Smtp-Source: AGHT+IED4fGfSEynlvzxaHFeSKB+3ArMnCu7nfxVNlbwvsehomTOyV58vPQ8cDS4yaGPzBLIRuPfjQ==
X-Received: by 2002:a05:690c:670a:b0:70e:1771:c165 with SMTP id 00721157ae682-71175440978mr5667967b3.29.1749837213986;
        Fri, 13 Jun 2025 10:53:33 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7115206130csm7277357b3.1.2025.06.13.10.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 10:53:33 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	syzbot+a36aac327960ff474804@syzkaller.appspotmail.com,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH bpf-next v1 1/2] bpf: handle jset (if a & b ...) as a jump in CFG computation
Date: Fri, 13 Jun 2025 10:53:30 -0700
Message-ID: <20250613175331.3238739-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF_JSET is a conditional jump and currently verifier.c:can_jump()
does not know about that. This can lead to incorrect live registers
and SCC computation.

E.g. in the following example:

   1: r0 = 1;
   2: r2 = 2;
   3: if r1 & 0x7 goto +1;
   4: exit;
   5: r0 = r2;
   6: exit;

W/o this fix insn_successors(3) will return only (4), a jump to (5)
would be missed and r2 won't be marked as alive at (3).

Fixes: 14c8552db644 ("bpf: simple DFA-based live registers analysis")
Reported-by: syzbot+a36aac327960ff474804@syzkaller.appspotmail.com
Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c378074516cf..e76eb0322912 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23950,6 +23950,7 @@ static bool can_jump(struct bpf_insn *insn)
 	case BPF_JSLT:
 	case BPF_JSLE:
 	case BPF_JCOND:
+	case BPF_JSET:
 		return true;
 	}
 
-- 
2.47.1


