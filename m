Return-Path: <bpf+bounces-68521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 519A7B59BDA
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 17:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E58367A4CDF
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 15:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4CF34A337;
	Tue, 16 Sep 2025 15:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXFScTw9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37CA317708
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 15:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758035866; cv=none; b=jOiz+rB5HwOOgN9HPtCnud1Gx3ewJKi/WSB0aMXy9u647P54z/2sJDPujVn0q65TK53KFnZhotV4/owCHY9SP5OVvRFsSn/PYERe89ZdNzkX/LY5f0HBMT/JtAQNf1PyjJE3Emyq+o/FaV9+1aQg8AGw3Y+JHFtmMZAFksty51k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758035866; c=relaxed/simple;
	bh=ww2Qo6ksIVrVIiMzunXN8x3X70yIUyDALWMYtl3zSOc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=S2ofxbN16vU5019VOIrKPjIvEF73SEz0fn3BxZYgTVMpwP6tbLzbL8zbUN6l9RCGxG/07gVjLENUFvKEdW94CUoyVgZHv6ryfo5TSSvLoutgHmMXEPcrYiBjvnQO3y/XlNq28fjIAYtTWhJN+FKg83adGyM1wNoBw/roNFrcXWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXFScTw9; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45f2f7ae386so17038615e9.3
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 08:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758035863; x=1758640663; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QVGm5GtBbdu8k9yhNK1mV2mCRVwFrsiON4Hc2d0ZA84=;
        b=HXFScTw9Vdp0Isq8c7ZIAlMetq9OeRg1nup4q+Dv9ND0nMVebilWv6wr4mFgzEWJTK
         VqnRiWRUYlIJ6AqQ8TAAi2cTvdAtuAge0GzKwIiNMx9vTU/Ge+Poe49x2U3ygPeIhISF
         FuUDH+BlR2i42yotFiFNytx3o6ttDZX6evu1z0FGn+GCaWi0UUVzMks6MTJ9MnaL95CV
         Yg1XigqGRd1A6jLLTATFWLA67HeLFVmoe0oeXktmaaNVKYeHgtXUswpr3EkTWYR0D3xv
         4H+xKhwFpsdT3zl09QDcQ40mO8p/5bsWjkEifLlIprzNOP1Ibf0cbG4zkrkkN1gGHF/3
         SeeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758035863; x=1758640663;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QVGm5GtBbdu8k9yhNK1mV2mCRVwFrsiON4Hc2d0ZA84=;
        b=T6qNX/ze+iOD6QQIwhEzkRWO/LS7H5/A4M/AD3cLgPrVNjqrmikl1xz+r91EHySZU4
         VFXGg17Zi9xGL/SJY/fuY++a+AyxU0H0ENSLGGZ3/d3YWjq/PDoernzT4UD5fW7UXZV8
         PDKcP6CWLtHqo/ldDOTgOFuESr/DrR0/q86x1zsMnMtLdYFOBBu3S8RnN1W/bS5LKfEO
         jKx6sgDUHpDnXKX6NAcfbwvl2BlrYcWi4pCo7UlCu1lbbIRz4X3VKLiJrBXqHQfOoG6l
         Nf6l7LBdxpVfZ73IF+UG0CGADphElre4QB5D576YGScvEKXCtkf+KVNUFKmOV54MUoN1
         rweQ==
X-Gm-Message-State: AOJu0Yy5p6ZqrufMesC89ALmtn6Ku8glS+m0Yxocbkn+aINAqtdesbva
	375FIMnkTE5yaU813F06OwCbfedRbRZxJzhvg3+AWIff6977g9Cmlsm8hi/vEDlm
X-Gm-Gg: ASbGncs1A4GgXBm176sUDovy0MPV0kW9sOqzvX3sDqXTK3sOV9I1mwVpNMc6hbUyUST
	l24fet0yeyDOCpeyGSqmGhIL12Dgu/PcwsagU0U/WCSD94vsGjbGnaRyDd37wQkP5vaPzdzbBSa
	Fx6h3CvSUIyGHaEbe22mCJEKe62LCju9rs0sDzKOdVh8IluaFdvAyLiOXmsfc5J3txIKoKVHE+P
	tJU/95+GRaNafP2Wt5T8AOZGeVKz0Hl20B6JaiD3F5f0MOKgj+bY2GXHQt02ssJ9IkJ4elBfkUW
	QRGKp1Jq+f7poNb2HwXIL/g77xMGX1HsrSsq8v+N9nL20OGo8eugHduKDlsqW+ClWFIp5rYkY48
	oVXrAkbBlmwtK7IDj+t9ohzZDGe8ZuZ0TTICkz5agBHyjAAdS2gI/wVCrLNUNO3WedI7+lBrFxv
	uGtud8sZd4pW/qO9fYRL03
X-Google-Smtp-Source: AGHT+IFl8/lEyIe/fBzHn7X3DPJolj3EfexriONqfFL49b6lg0vOTjpT3ZL8tty2BR2ItuqBUFYhbw==
X-Received: by 2002:a5d:64c8:0:b0:3eb:dcf:bfad with SMTP id ffacd0b85a97d-3eb0dcfc667mr6483505f8f.34.1758035862907;
        Tue, 16 Sep 2025 08:17:42 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00b660ca331402f663.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:b660:ca33:1402:f663])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e01baa70dsm236131385e9.15.2025.09.16.08.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:17:42 -0700 (PDT)
Date: Tue, 16 Sep 2025 17:17:40 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf 1/3] bpf: Explicitly check accesses to bpf_sock_addr
Message-ID: <f5310453da29debecc28fe487cd5638e0b9ae268.1758032885.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Syzkaller found a kernel warning on the following sock_addr program:

    0: r0 = 0
    1: r2 = *(u32 *)(r1 +60)
    2: exit

which triggers:

    verifier bug: error during ctx access conversion (0)

This is happening because offset 60 in bpf_sock_addr corresponds to an
implicit padding of 4 bytes, right after msg_src_ip4. Access to this
padding isn't rejected in sock_addr_is_valid_access and it thus later
fails to convert the access.

This patch fixes it by explicitly checking the various fields of
bpf_sock_addr in sock_addr_is_valid_access.

I checked the other ctx structures and is_valid_access functions and
didn't find any other similar cases. Other cases of (properly handled)
padding are covered in new tests in a subsequent patch.

Fixes: 1cedee13d25a ("bpf: Hooks for sys_sendmsg")
Reported-by: syzbot+136ca59d411f92e821b7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=136ca59d411f92e821b7
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 net/core/filter.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index da391e2b0788..9ac58960e59e 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -9284,13 +9284,19 @@ static bool sock_addr_is_valid_access(int off, int size,
 			return false;
 		info->reg_type = PTR_TO_SOCKET;
 		break;
-	default:
+	case bpf_ctx_range(struct bpf_sock_addr, user_family):
+	case bpf_ctx_range(struct bpf_sock_addr, family):
+	case bpf_ctx_range(struct bpf_sock_addr, type):
+	case bpf_ctx_range(struct bpf_sock_addr, protocol):
 		if (type == BPF_READ) {
 			if (size != size_default)
 				return false;
 		} else {
 			return false;
 		}
+		break;
+	default:
+		return false;
 	}
 
 	return true;
-- 
2.43.0


