Return-Path: <bpf+bounces-68643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31825B7ECD7
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 15:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7388A16B7BA
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 08:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E5A215F7D;
	Wed, 17 Sep 2025 08:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nU9ln9p+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E1A24A07C
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 08:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758096485; cv=none; b=lYc4IZYJl81DTYw4UQcx0mTqE9sol6gHCbcD87j4rHsAFxdDZq1f5cADDrx5s8uj02LWPuOIpentlgb1Rg4XImP/bfoZsg9nmJRJVYcNgk5vcqI+NTvN/2SRRGxBFap27Bg8hoxnKRfRvkERGHwhx802vk9p6sGjfSNN2YX7+rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758096485; c=relaxed/simple;
	bh=PWofUjmw+XjtRUIAT3Hi26wZ2+m7yciIuj1DtrXYuvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lru5m8om85KXrxZldEvCgNPO0zuyeHE1+d/BBNh1nFshDxEn3J3lIqAgXDO6839DwVEJb69R8CpsFrUnM/znouL0ztC7G3tz69lyUrkq8WlwJGvpfb+ojwOyIEctncnWL5ez/iorcfKbaIWgmU57xifoZ35iZOgt0z1+v64df9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nU9ln9p+; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3eb0a50a4c3so1959827f8f.1
        for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 01:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758096482; x=1758701282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DeHYSQMhobBGeL0062IBYDFq9yjWkMlMlFRKc6p1v1A=;
        b=nU9ln9p+7Aej2dZhLuq9OmPT/X4+A0OdHGWmAD6qLRjpgxpKPy56cjNO1uIeE3UWF/
         Wp6XkW6QJK/oI3vutxcptRuSXxdoBZkcjr1uafvOj+QniKcwFeK5XWqngzkIUyTARMO7
         dXQ5glBfmnjUTx5mhDXU+vtA1L7t6zVbJVU+ysY6+VjX/V2xcznI+cJLdZ4cuLxa+DoX
         kEWrgjLiviKX+F6vgAUV8IFzplgBksUqonniazWpZG0XaxRbr/lCiTMcfDoWosFdIVtg
         5HdUtMj1lwBstn4JB6JuGcVuqKCydGZBc+tr9UNd1l6lr4lPahgzqua1PxC6f2HQ8m42
         fJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758096482; x=1758701282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DeHYSQMhobBGeL0062IBYDFq9yjWkMlMlFRKc6p1v1A=;
        b=fFK0x+I4DqfNbIQd9nohiLzDm9D/pquT0DTuV/7BwZVpDL/iWKW8ayS26EJE+61d+H
         cG5Myg3gymAuf5CixiNsVdTnd41BcuSgRV7mNIo8qCmVOw20dDQRsLW+3CLMy5BUeX17
         xiquhwlLeKeZP0lEmptZAbxI6KdDljU/ZhfEpi2CsJxBJS0oltWJmBJz+qA296Jf9VrW
         ZzYurLNVTrfDS5gLeR0l7kjX+KTUU/qh4fYW3ZILlcLSrPvxJsYeLUzTfWT6y0NckH5i
         i0xb4/bC7qLTBgC8BNs36okvIKvCy6NMV++KADlDtLvLqgrC4G0IUyMv/2/GHBTBGM3H
         dZAQ==
X-Gm-Message-State: AOJu0Yz8xk3oqltr7SPKmhhJ6XxuV40u3ksYvSjOavs3Q8ova0FqZvSC
	oLI3q6O1aLVeH9/ZswD5y8Rd2H8Q79/hjF+gD9Mn3A5Q68DdlcTvaod7ZHS7n2dw
X-Gm-Gg: ASbGnctX6EMz3LP3q4nu9cbeOYRHS+EEMlXEi/KdOAOG498YRbEQvK8+v3+vPQBp/o2
	hEIPCbTPdvCHd3YB1kwoMX1asbmtnk5j/bgDrwzgb4BaLIShXzhx7mv9H+FG1lVbaWRIpl24mCH
	dbWSkXTjZ+zJSwexFnRjg0Mv5g/HjhDzhdMxwoTEt0/XFuXoGgvIsGGvJ85gHsUJ0bqjBibcNNV
	kHFAw8ENMZ+bjyYON+P7MEY5QKYVDZChtCo2xzgR3Qp3fpX0NEnKjzLGSgZvQRUe97lznOTE+PM
	WO4n/y9D7rrSUQqGj4IgfIZE+8toItlyPyHwF1K2pxGFKbQLAyqvFWnsH6j8Oq2s0aGJLTMp2Av
	AJzIGU8I9bLUyghxBXM/Kc9iyguGBnBeVihpgsCuF26OjqPNaACQSdruRM1k/rBVW59+S1eFioA
	sPwHj5dxeAWtbdbLGEP+VO
X-Google-Smtp-Source: AGHT+IGsAMtPn6JOWZY/3XUO96WzI8IE9XbQlmfJP5RHsy6gnxxVSUl89ULi53G40cVMhcWAWg3SWA==
X-Received: by 2002:a05:6000:1844:b0:3da:37de:a3c0 with SMTP id ffacd0b85a97d-3ecdf9b9dd5mr1054756f8f.15.1758096482368;
        Wed, 17 Sep 2025 01:08:02 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00f6fdfecb9884ca93.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:f6fd:fecb:9884:ca93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3eb9a95d225sm9958555f8f.54.2025.09.17.01.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 01:08:01 -0700 (PDT)
Date: Wed, 17 Sep 2025 10:08:00 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 1/3] bpf: Explicitly check accesses to
 bpf_sock_addr
Message-ID: <b58609d9490649e76e584b0361da0abd3c2c1779.1758094761.git.paul.chaignon@gmail.com>
References: <cover.1758094761.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1758094761.git.paul.chaignon@gmail.com>

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
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 net/core/filter.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 63f3baee2daf..8342f810ad85 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -9284,13 +9284,17 @@ static bool sock_addr_is_valid_access(int off, int size,
 			return false;
 		info->reg_type = PTR_TO_SOCKET;
 		break;
-	default:
-		if (type == BPF_READ) {
-			if (size != size_default)
-				return false;
-		} else {
+	case bpf_ctx_range(struct bpf_sock_addr, user_family):
+	case bpf_ctx_range(struct bpf_sock_addr, family):
+	case bpf_ctx_range(struct bpf_sock_addr, type):
+	case bpf_ctx_range(struct bpf_sock_addr, protocol):
+		if (type != BPF_READ)
 			return false;
-		}
+		if (size != size_default)
+			return false;
+		break;
+	default:
+		return false;
 	}
 
 	return true;
-- 
2.43.0


