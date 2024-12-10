Return-Path: <bpf+bounces-46488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBD99EA719
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 05:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04DC288F81
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 04:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E2822618A;
	Tue, 10 Dec 2024 04:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cd+D7N2m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14186226179
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 04:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733803882; cv=none; b=JYjMUwP5mTxWZxTIy9+JZSLVFdGe+Py2E+asg778jFmT+EIhFDd3hswjjASx/8Q47AUvgPoYQBwDKDqYGtD49z2LdiBRd/+VJrebNrWPG+RmXW+QNApeONTtCjtvroSf92jhSvN47aMAhHJ/uwPfdEYlFZXASQW7VjwoM7tZ0e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733803882; c=relaxed/simple;
	bh=exvqnr87Qc6EueSTnOwgtR564j6q0koMZrddowX5G3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V9vyoEfz4oB2JQZta9Je2A1VcPYAOOoeNSN/Yfb9B3BWOEG2PHuKkmZM3LhV8CpOuKdjd6iF8wrRNdUYnyVg6ZVZsRk0Ln1QkrUIc33hgMeFQ56Z+cRdtgf4dE2xPVDSBbKLqZ+Um1N88DnPFJXSqNvRVBFErvex5hCqre7yzqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cd+D7N2m; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7fcfb7db9bfso3907791a12.1
        for <bpf@vger.kernel.org>; Mon, 09 Dec 2024 20:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733803880; x=1734408680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=niuGxcXNQ0TnVzFv8lzYzTN1QAlStTCPrAkZlwl8hYY=;
        b=Cd+D7N2mxCKgvUdVE4gpwhW91dxHkEZH3rM05KYWyIOy1SAR+pgvcVhrtuRgYcFgYf
         1h3Vavl3hFFnvvJLu2rbNZCWgor8jgkpELdWPenU1v14GocxmuWK86Bz7dYL3YiP1YDu
         n7HUxVWKmDm5j7GmxuwIDm7yFVA0Swf0sR+sFEFVLdfYLdHH/HthwTmnBwYwDyKHZnrI
         OMNUvP5KkW4IoG9T40stkET+qxjLU77NAvEK/XabKzYjGGWr2/ODrOhKuaY0cZFGjR5o
         y1AVMDnUchnKd5dE9Wc9iIac43tBfq475XbdiqrSlRLyD6DrzVmSi2g00F8VWEqu6a+z
         ZPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733803880; x=1734408680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=niuGxcXNQ0TnVzFv8lzYzTN1QAlStTCPrAkZlwl8hYY=;
        b=crGy/RCbSNsMn4dvlSn1M8Rei+yR+B7pTfNlInt++FgALExvcbaFl9xX5y2Sm32DVL
         r8njB7k/cKIu5mnNhNmbiEeKuOjOEfeh82OPHRLu4OqXamZ+kYZuno/wZpnmTFoczD2+
         dkBI1piEo8kbIaK2WBp7yFx5GfKYmUgk+GX8RaJnXzfQi8TcdGLJZaQj5nKGgW7z7yQg
         IR5Odkrqw3uSg/Q7ElNVF/yRW26xWNQsBj9AWZProd13Y5Uy7ktVd3tJuxUX+/Vfo4yX
         xuh8ZgKKWqUGWdliWwJHpHcrSKU0gOTGWKtQZ+rWt7sn0vM1dHF2L9SRUYVqM7f47vRN
         H1Hw==
X-Gm-Message-State: AOJu0YwWQu/GIZKYXE/i6LzKK1Qo2ODBMyuqPGjjuKnDIqE7y8aAcXVj
	aM3DGv13iR7590Uw/BtNGwU7kKAHSCtCjc0Fuxz08TRXC/vDbbZHcw8ZEw==
X-Gm-Gg: ASbGncuqvjQ+2in7w5SPEmz7ufQBvLa173HVvYsL5RzVfKoDxN37yQ5ecZ0SWJGtp+F
	mfYg9bnvYjcht/AISHfmJo+tGRoPT4Z3aLHKjDMi/CxuUklaisC9i4AvSpVcMrSXouIxp/kJsnF
	Ii6XgTY8xBJhuKzhd4e8eiO/06WwhBRsSo5s5YYLYkhznfk+S8xoADWbHeZvlCcvomCEC2MlegR
	7UFJQ7gIQQDyd99PP0+9qq0+IofqwrrTGMzw1EOac17yrn4Hw==
X-Google-Smtp-Source: AGHT+IGHl7wf12CCq2tk9O0w17ZLE1AbXNmUyS3wy7w3Pw7re4Q0WXFoS1sO6b1a7JPRaiej7Z/waw==
X-Received: by 2002:a17:902:d4cb:b0:216:6590:d472 with SMTP id d9443c01a7336-21669fe23fdmr43631015ad.21.1733803880075;
        Mon, 09 Dec 2024 20:11:20 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21631d6b3b8sm44296265ad.136.2024.12.09.20.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 20:11:19 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	mejedi@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf v2 7/8] bpf: consider that tail calls invalidate packet pointers
Date: Mon,  9 Dec 2024 20:10:59 -0800
Message-ID: <20241210041100.1898468-8-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241210041100.1898468-1-eddyz87@gmail.com>
References: <20241210041100.1898468-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tail-called programs could execute any of the helpers that invalidate
packet pointers. Hence, conservatively assume that each tail call
invalidates packet pointers.

Making the change in bpf_helper_changes_pkt_data() automatically makes
use of check_cfg() logic that computes 'changes_pkt_data' effect for
global sub-programs, such that the following program could be
rejected:

    int tail_call(struct __sk_buff *sk)
    {
    	bpf_tail_call_static(sk, &jmp_table, 0);
    	return 0;
    }

    SEC("tc")
    int not_safe(struct __sk_buff *sk)
    {
    	int *p = (void *)(long)sk->data;
    	... make p valid ...
    	tail_call(sk);
    	*p = 42; /* this is unsafe */
    	...
    }

The tc_bpf2bpf.c:subprog_tc() needs change: mark it as a function that
can invalidate packet pointers. Otherwise, it can't be freplaced with
tailcall_freplace.c:entry_freplace() that does a tail call.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 net/core/filter.c                              | 2 ++
 tools/testing/selftests/bpf/progs/tc_bpf2bpf.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index efb75eed2e35..21131ec25f24 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7924,6 +7924,8 @@ bool bpf_helper_changes_pkt_data(enum bpf_func_id func_id)
 	case BPF_FUNC_xdp_adjust_head:
 	case BPF_FUNC_xdp_adjust_meta:
 	case BPF_FUNC_xdp_adjust_tail:
+	/* tail-called program could call any of the above */
+	case BPF_FUNC_tail_call:
 		return true;
 	default:
 		return false;
diff --git a/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c b/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
index d1a57f7d09bd..fe6249d99b31 100644
--- a/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
@@ -11,6 +11,8 @@ int subprog_tc(struct __sk_buff *skb)
 
 	__sink(skb);
 	__sink(ret);
+	/* let verifier know that 'subprog_tc' can change pointers to skb->data */
+	bpf_skb_change_proto(skb, 0, 0);
 	return ret;
 }
 
-- 
2.47.0


