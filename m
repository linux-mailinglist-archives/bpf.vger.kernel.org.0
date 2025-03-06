Return-Path: <bpf+bounces-53484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DC3A5513A
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 17:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AE95175125
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 16:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9655921E091;
	Thu,  6 Mar 2025 16:28:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A0A21D3E7;
	Thu,  6 Mar 2025 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741278486; cv=none; b=sTzv2aFwv5rowEn00cauGoDnuYovzE8AlnKezS5q7WKtP0boBAqyxttJcSTlg/ArcYpSILjvdqSSlxovYM862rUpZLEUN1NFwxPujiB+tLWrlCrFqotoyYCgiXrfN7wzhmRqfF9MVIMOI6pV9qhugvVtLcaDX6k6SE4Tu5R/Q4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741278486; c=relaxed/simple;
	bh=RieI6T8+GnLltjFdq+B3y0WTT5CK4xQkz/PyogGNpso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oaDwyM9oGuHU9cx/RPDwK9TIN0xk5C9CU9Nyji62vaO3jQrHb1sblDHpypTecixH8x61uQrnaUm4jUqqB458SJlWjYYoPnSGepJ2hrVOk9qaCu3+D0u1Q0ck30TnI3Lx2/ySWgg4c328CKu3mlwNodOYk+zKXK+CqN+Gq9GUpK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaec111762bso168363766b.2;
        Thu, 06 Mar 2025 08:28:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741278483; x=1741883283;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zWz3562ixpgOjZyLkTmlCW12K3CVuT3pKkHg+iSiURk=;
        b=ky+gxJFj8A1EZWesaz7LmEXiy3Al80geBNWoJl0bsAtXOFcrVY7PkPEmloofxUBVJi
         +fPuzvfRiNXotoUwBJCXGbCl02zUsIig+gs2KMPeG+0ai2+SdeZCm7rU2Kk3KJJ+vPfO
         6AcB1sSj6dT0XEaaLUpu0/k5GnVGU0qrpieCaHOSJG2vaHQsPbxtPTbKAyGpwNxKbouv
         fi5OEXtDMsH4zLWKK6UhPaC0PFcyY/y4lMTtpg8zV6oW9xBHI4e2Y/aCHQY7ZK7TgpDV
         GwdaCWzq9FHr6K+bS1GPUAx7mhvFoaL9iFsdpvQFCxmBiBCLBKEdYZ2DdH7Tk1dL2R+P
         4jJg==
X-Forwarded-Encrypted: i=1; AJvYcCWvRY/CRnBGZeh/YFxJt7jewuPuOGirVbmKwvFZ3u2iMH/A591uEx5RomtPrYp3s37d2i0=@vger.kernel.org, AJvYcCXl7I1Zz0TbJCHdrLOt0Duwhyb8IROImD9JpIrdk07bks5sc4VzndG2ENPohH9HU65/vDy7CLUG3XyG1Qjj@vger.kernel.org
X-Gm-Message-State: AOJu0YwxMy1gcpiGHB2BBqJWDQFyP9GbDORSvqPwP4J2C5sTjSadhv6G
	mMnW3RznsSfcm+fjIgoqxmgqWw8Bx7szonI6EcQPvjo/qH+fKPdP
X-Gm-Gg: ASbGncu4ffDkAbLF01e4AuSp6/VDieSSjBIA190UEo0ACccl/oZrSzPHhE6W3i1mtX3
	QuToHbN5cDOuYsTKtG0bW8Xgdx0EB60d80c+/CWYgTU8W4cka0bZ82JjlxB+1+/q3UoM22ia7Od
	fPhW7gOk6MR2N+L9N+5+0Tcou5J4wH444ARKL9C6pIhhatjkZEWTRYkaU608X/U8iXAUTQsylYa
	nD92WFPfCI3T1xIl3ZIfVQwphoJR1xKo1BTB4NsDBalh+uRj/vHSQV81gEqN4v/5C+FycakAHpT
	FiRc4w0hYKfjeN9I3L6o6tLWDHyV7CzMIF7+
X-Google-Smtp-Source: AGHT+IEJV2JOj1YXcWKWdKaU/xsu6mOtDGDJCcjrKsMH1t7e24mfeW+ZSvxc5C6UG8THTxQ2XKEKFg==
X-Received: by 2002:a17:906:6290:b0:ac1:d878:f87d with SMTP id a640c23a62f3a-ac20db04e4bmr917411066b.56.1741278482515;
        Thu, 06 Mar 2025 08:28:02 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23973a74bsm115734966b.123.2025.03.06.08.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 08:28:01 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 06 Mar 2025 08:27:51 -0800
Subject: [PATCH] block: Name the RQF flags enum
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-rqf_flags-v1-1-bbd64918b406@debian.org>
X-B4-Tracking: v=1; b=H4sIAAbNyWcC/x3MUQqAIBAFwKss7zvBjIK8SkRYrrUQVgoRhHcPm
 gPMi8xJOMPSi8S3ZDkiLNUVYdlcXFmJhyUYbVrd6E6lK0xhd2tWvfOzq72Z2QRUhDNxkOe/hrG
 UDyo4NfhbAAAA
X-Change-ID: 20250306-rqf_flags-9adba1d2be2f
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, kernel-team@meta.com, 
 Yonghong Song <yonghong.song@linux.dev>, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1399; i=leitao@debian.org;
 h=from:subject:message-id; bh=RieI6T8+GnLltjFdq+B3y0WTT5CK4xQkz/PyogGNpso=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnyc0QW/hz0BGrRvx8XmUY7nab78lXrA0HoGbbN
 Jh8nRxPDEKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ8nNEAAKCRA1o5Of/Hh3
 bdo4EACQnyP8l8apbcsGVhMgcyjKLgdrM9fPbwprHvM2TtW2qrmIm8Cy/g+R4EhQvNJ3erB0prR
 XyxKI4A91hNfQ5b/cEADyIwv8iXP5djZNhex+09TZLdCJuy7ujCz9DDuu6hf25wgPEHhHhXadBJ
 9e7VxmRPEwFQZKO/miEAjkxPg9G5fMYxK9vHrKr+xYOqpg1gAVfHyhsTq/rZgR43YjG7h5idpR8
 5FEGM2by5b/LQAL7H0cRTL1i5OXEBobjf5t16fA9d1ibijRhKVglbuvYr/XS/1qOxVf+bbwGwVp
 1aukJqRge6lZOzdL0/LwrWQpDr1V2pT+55ayVDlkJ/v7EA3VEmhgQ/CV0yJ/4RSAbIx4712cQGq
 gMYNwGaK2s+5QLk6jwD6qYsYpwNZ22+U5Bqs2ZWvz4l2D28rbD9F3JPEGS+K2V+dfXGVRdWGJxt
 9UKWf7nq09QIrkcxzOhNeGTmsNQTxbMGfn4DocdPQmnJqKnoAnWQ8ydIeNvlHtKWNWTFKdpeR/Z
 29POjUD/cqUCJQUmXy1yR2UzAGUX5ZzU1RPDiyBFya5Ou5X1Fc/j8FGFLYImdu3Qp+1cvUK8DMN
 ArhsS2+GBBstUsrkbZ1xRXsxFaQXScsOh+r607Vz2ZPrW3IBXNuf+NeM2x71dIsc2oJQe0l6+JU
 CfBlPbHTIsQdxBw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Commit 5f89154e8e9e3445f9b59 ("block: Use enum to define RQF_x bit
indexes") converted the RQF flags to an anonymous enum, which was
a beneficial change. This patch goes one step further by naming the enum
as "rqf_flags".

This naming enables exporting these flags to BPF clients, eliminating
the need to duplicate these flags in BPF code. Instead, BPF clients can
now access the same kernel-side values through CO:RE (Compile Once, Run
Everywhere), as shown in this example:

    rqf_stats = bpf_core_enum_value(enum rqf_flags, __RQF_STATS)

Suggested-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/blk-mq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index fa2a76cc2f73d..71f4f0cc3dac6 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -28,7 +28,7 @@ typedef enum rq_end_io_ret (rq_end_io_fn)(struct request *, blk_status_t);
 typedef __u32 __bitwise req_flags_t;
 
 /* Keep rqf_name[] in sync with the definitions below */
-enum {
+enum rqf_flags {
 	/* drive already may have started this one */
 	__RQF_STARTED,
 	/* request for flush sequence */

---
base-commit: c42048cee22435a6ea0de68cc02231cf359ca8b2
change-id: 20250306-rqf_flags-9adba1d2be2f

Best regards,
-- 
Breno Leitao <leitao@debian.org>


