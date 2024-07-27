Return-Path: <bpf+bounces-35793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D055E93DD0B
	for <lists+bpf@lfdr.de>; Sat, 27 Jul 2024 04:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C7792854AD
	for <lists+bpf@lfdr.de>; Sat, 27 Jul 2024 02:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656B24430;
	Sat, 27 Jul 2024 02:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RR5/7FGU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDFA186A;
	Sat, 27 Jul 2024 02:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722047296; cv=none; b=rQyaYgTz8YmVCNOj9WB7aAMoahGhuG3wdiWwg3Y1ENvUpCB54xKo81+pkfZc3Hb+7VMB4wG8YlBL4+Pt285/g0g181MphC+2bdllkXMIEaZiBkNu/vzjB/l8oYuFgl/3LdAkSDhdVjdQHP2SFk8xf/LJq5ccJt2yK/wzUtJTCO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722047296; c=relaxed/simple;
	bh=QgE+2tohIlFaIvSeizNcPlIcdxXHbiBqBFuQfm2XMEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qtp6/sEXFmdk926GRnDdeTKLnNLLk3i3tTElUmKNuZCX3cpufhULYRF/VmqKeIiExD0Uuugt83bm4S0SGPZJ0x2147qSjJ7XG6W5s5RT84z9zH9bkHGoW2ygGIxSmbuVi1vh5eIsqePk3naIKpgJWCCLtP1fB3A4Unyi1U8Ad2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RR5/7FGU; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-66acac24443so2744937b3.1;
        Fri, 26 Jul 2024 19:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722047293; x=1722652093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgE+2tohIlFaIvSeizNcPlIcdxXHbiBqBFuQfm2XMEc=;
        b=RR5/7FGU4r/2+PrnluYp1vhTwJSJ5fNTU5LcLTDP3IqywQKOOiHfXQByRYLTIa2Xyi
         kZ3zqPYODalfhYKAiGzVwdyMNDnmM1rzAffC19HQyZ01R3eO/q73M6PWTB+MEh6tJnkr
         0Fk4u8L+7z4j9FoMuqCW2IDfMjkg6I1BT5tgNzpCNocZll73oE4/egaKtuT7VA+lWfZX
         cfrSK304lgtelxNHXC9dUT22SAcaBFk5JRCHwZO4QhAcgUUP8kjvPjXOw8OYURsxKQ9+
         jiEMfeFwjQuvw5EDcqz9CiYFfUN5hW1A7tKlwe1YrnG+MhkDhc0BejqxWJaDlVrfSs9e
         eslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722047293; x=1722652093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QgE+2tohIlFaIvSeizNcPlIcdxXHbiBqBFuQfm2XMEc=;
        b=UA6mHQKSJSkhjZKgaTzrPWkI8tLgPjseRB0zFZ1qOysC/WZ12XFmGON2X7lWUC1OTl
         LurYC5KuV8AxgKKKCROWcz5gR2hGOqaZiOHenOakHiYf3uvKPhgGmc7bESqU/F8dD0UC
         fJ8rBMgtliGvG+422U7ch5m93kTFJOFsEo21AbWLplAE1HZzvnxloI2abjdujnmpG0yS
         BDMlm2MOx/iOc6OPHUdQtDZKxATK5bqv7E9ps/Wid3FEAalexFljNlp79OtYLjpXJEGz
         JoJkS+8YRLAmB0CNvYFQkF8wkjzeB2NOHlRXZ/Ji89+QyibbdXouj3l1Zf8PJaPCh6zi
         t5nQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5NcKbDjOvxSgXdOicSzPxBoWbHpMLLyS1wLVECSzpaNfWqKQE1Zbv2zgyhDohuWBzfBYGI9jeX10aHILWAH58jaeBta24plzG3piLU9046Pm4N8KvE+rYFZMPFhReY/Wm40jWjg0KRTvImLoO3Qzhr0gdIrCh4XED
X-Gm-Message-State: AOJu0YxbpLn1jUUy24uKNDDjru/QJ+doHmk47oOwLWAeQJXxUWdku6Qk
	SM6ReiskEn7Gr+theNs6IdUeraAcml3aTH5RlN1xNo9vwm21ZXr6WQ8+Vb0VTYs=
X-Google-Smtp-Source: AGHT+IEiIX02ECTYH9guefeA4G2o1QBuXsH8IeoGePYuSUu23zZuh7bRzIR1DPVGK1ExaJJZoOAnJg==
X-Received: by 2002:a0d:c8c6:0:b0:61b:1e81:4eb8 with SMTP id 00721157ae682-67a051e830dmr17563467b3.9.1722047293411;
        Fri, 26 Jul 2024 19:28:13 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8a39d8sm3356238b3a.213.2024.07.26.19.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 19:28:13 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: aha310510@gmail.com
Cc: ast@kernel.org,
	bigeasy@linutronix.de,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	edumazet@google.com,
	hawk@kernel.org,
	jasowang@redhat.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	willemdebruijn.kernel@gmail.com,
	syzbot+c226757eb784a9da3e8b@syzkaller.appspotmail.com,
	syzbot+61a1cfc2b6632363d319@syzkaller.appspotmail.com,
	syzbot+709e4c85c904bcd62735@syzkaller.appspotmail.com
Subject: Re: [PATCH net] tun: Add missing bpf_net_ctx_clear() in do_xdp_generic()
Date: Sat, 27 Jul 2024 11:28:03 +0900
Message-Id: <20240727022803.4809-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240725214049.2439-1-aha310510@gmail.com>
References: <20240725214049.2439-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 26 Jul 2024 06:40:49 +0900 Jeongjun Park wrote:
> There are cases where do_xdp_generic returns bpf_net_context without
> clearing it. This causes various memory corruptions, so the missing
> bpf_net_ctx_clear must be added.
>
> Reported-by: syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com
> Fixes: fecef4cd42c6 ("tun: Assign missing bpf_net_context.")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>

Reported-by: syzbot+c226757eb784a9da3e8b@syzkaller.appspotmail.com
Reported-by: syzbot+61a1cfc2b6632363d319@syzkaller.appspotmail.com
Reported-by: syzbot+709e4c85c904bcd62735@syzkaller.appspotmail.com

After searching, I found reports with the same root cause, so I added
them.

