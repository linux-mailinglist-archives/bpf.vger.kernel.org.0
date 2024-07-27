Return-Path: <bpf+bounces-35792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D786A93DD08
	for <lists+bpf@lfdr.de>; Sat, 27 Jul 2024 04:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9453628517A
	for <lists+bpf@lfdr.de>; Sat, 27 Jul 2024 02:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67371B86E8;
	Sat, 27 Jul 2024 02:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQPpDsnD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91E4A21;
	Sat, 27 Jul 2024 02:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722046629; cv=none; b=UNoXNhL2dSjecoU7lk41Bc+mZNYxzTeb9Y0hyf0XjOm6STbo3pgZ48yBFjKP7WxXlvhzXw50jG09wStHMsRHPeUealuY/BARSKkVeUnsr3eeRh/EBIBVDzdWKFJP1bq5Pwg/Qs8lC42rN/zn9E7ulsfAp0+24AAQCh1T2mbV+dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722046629; c=relaxed/simple;
	bh=BDjSLFe/Eg1uSoN5uQ7Ddt0IXxjgIEDv5kppUv9pa0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jW8+JHx6iczbmh05nMPocGzU47uHnhCIjtdDaawhph9zfVqhGEqFPXeKjCvhd2UnMUmI3GnIb40K8COPwssnpkDi0uuFk4ZNMF4pr6wycJPOOHydBMUxCo5LRJoDNaLBM7d0vxZ00U518R5/b6SvREj0eDGVzwgyyO5dTIYBPwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQPpDsnD; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2cd48ad7f0dso1215709a91.0;
        Fri, 26 Jul 2024 19:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722046627; x=1722651427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDjSLFe/Eg1uSoN5uQ7Ddt0IXxjgIEDv5kppUv9pa0Q=;
        b=nQPpDsnD+DEKbWQXKCdRVHTCwUeevZm+bS304NjAWMhIODDqs3iAOLdNddvuJSqU7W
         tyAbGR/+u2VeVR/h90IakKL3fEsOFyRcAktFJ3HkipopKzxilEhC00j1RVo4LDaf0+Am
         nTJYgjuRMQ7Lmi6hW/HIjBXnj4s/ydJ/GlcdGCnmAIPSPw6AeU57Q7s93sT1xwYHNYgL
         rXJzM17JgEQqbIoQ79rGOqc3o4afhjQdI+mzUsJa4gTSXJ5Pa6hTHcCN2j9TgV9s67BW
         qFs17rrwJk/65ByUGhd5ff/Zg96QRxhFpdNJS/gYboZb+81lBmwY8oUcyWwfcxiaEB02
         kEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722046627; x=1722651427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BDjSLFe/Eg1uSoN5uQ7Ddt0IXxjgIEDv5kppUv9pa0Q=;
        b=UTx6A2YqAMBz0u0QnxJqvE+e+sOdzz3YlK3VWC+k3B7t8/jp4eaorytCvbF9HH3lrT
         4z8f3niRDWj60fMO32tAeiaUyOuOG2UjEeCFLqP7WZfGCSTliaf74iMB68p7j5LBEBMB
         0GJOogmjfH6G+0AqAIB5G5NDdIOUngSfZI5/HX47J3c+A1l6t6euoBHBzEOFEwIORVJA
         Ohv6yGGWfabKJdfMOmYPUkX656A7vXslzITYjLAs3vvKQ2a1QceJVE5Hj83aij7ikC78
         8a+3KK55EQeMasySquPWXztzBUCN2zZ+RuFZ4ITyI1H7rkSAnckWJEcrvKsgf5JS8m8+
         2oww==
X-Forwarded-Encrypted: i=1; AJvYcCX8rIfbZ2k/qtbwGfZlyPzIPI3oT+u5lfaB7NkGgSNUVYzzrjqzUw73CnN0LbNIH2fe+qMdjoi7gzN0lezq5yjS4rboBHZJrnAX72NLavutjgf0fxI0OS9/AldFBa5Qsme+ANwKKehwnnWq6x/VX2DbwcyEVHmbpDKE
X-Gm-Message-State: AOJu0YyW+4NpbL/qluYgw0tbZJh7IYsY51i4cUWb1XEZgpFz+hK9BnUC
	aBPoWFxglbTD21m1AWjFkbRmu3r4oezZW83PhiBHWrIRxonLCWfW
X-Google-Smtp-Source: AGHT+IHJfQVPM/JBsd02eXhUwqsCfqML4JLzqTVkRT2XuTtlADQJGUiLyVKqgi9zSD4xct1foY158Q==
X-Received: by 2002:a17:90a:a790:b0:2c9:1012:b323 with SMTP id 98e67ed59e1d1-2cf7e5f51d7mr1543837a91.27.1722046627011;
        Fri, 26 Jul 2024 19:17:07 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cf28e3f67csm4136160a91.53.2024.07.26.19.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 19:17:06 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: kuba@kernel.org
Cc: aha310510@gmail.com,
	ast@kernel.org,
	bigeasy@linutronix.de,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	edumazet@google.com,
	hawk@kernel.org,
	jasowang@redhat.com,
	john.fastabend@gmail.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	willemdebruijn.kernel@gmail.com
Subject: [PATCH net] tun: Add missing bpf_net_ctx_clear() in do_xdp_generic()
Date: Sat, 27 Jul 2024 11:16:59 +0900
Message-Id: <20240727021659.4659-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240726074102.74b42a9b@kernel.org>
References: <20240726074102.74b42a9b@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jakub Kicinski wrote:
>
> On Fri, 26 Jul 2024 06:40:49 +0900 Jeongjun Park wrote:
> > There are cases where do_xdp_generic returns bpf_net_context without
> > clearing it. This causes various memory corruptions, so the missing
> > bpf_net_ctx_clear must be added.
> >
> > Reported-by: syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com
> > Fixes: fecef4cd42c6 ("tun: Assign missing bpf_net_context.")
> > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
>
> Also likely:
>
> Reported-by: syzbot+3c2b6d5d4bec3b904933@syzkaller.appspotmail.com
> Reported-by: syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com
>
> Right?

Yes, both appear to be bugs with the same root cause.

Regards,
Jeongjun Park

