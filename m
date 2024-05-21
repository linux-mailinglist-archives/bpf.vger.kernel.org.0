Return-Path: <bpf+bounces-30181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 163838CB63E
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 01:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EE311C21C0A
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 23:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06BF148FF1;
	Tue, 21 May 2024 23:00:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail115-63.sinamail.sina.com.cn (mail115-63.sinamail.sina.com.cn [218.30.115.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28F1149C5D
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 23:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716332420; cv=none; b=CMfhGekvtssSxlG/8MX/tUeCH1SdKXXENBcPbyhK/C7kwzeVW0cFLS8txgRciMllTJoU1+Wl1vhYK9nx2hKSoCOxmcBZ6VVCZhsCKTCtzhDmznscFIul7ZEhCEUkoDaAWgXddws925s1pEuruY1Tg10OySLAmnDisLyk90Tyr3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716332420; c=relaxed/simple;
	bh=I9pWAFXJ3AMw6DqR5IFHPFrnDHTvYEknL09DRYwfhrk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fHWZJdJuLhS8mZUz6Bslc7kX7SY9CaRw2eNzMTRsGQTR+xb28L5v06At/kwxBeOX8Nc9HP14dmFlNlui4BXBn8X0/xST+kqtQTtgYgxa8e5F7luRCOj1XYyQSSMlKpK1XKHKZxNgg8trtbu0C/8VDRiAkN/W+GbNpNG8xLLqWY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.71.62])
	by sina.com (10.75.12.45) with ESMTP
	id 664D275000005F68; Tue, 22 May 2024 06:59:31 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 86682131457761
X-SMAIL-UIID: 9AC7B9FBA6F44293AB002770D67E5E3C-20240522-065931-1
From: Hillf Danton <hdanton@sina.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Eric Dumazet <edumazet@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf, sockmap: defer sk_psock_free_link() using RCU
Date: Wed, 22 May 2024 06:59:18 +0800
Message-Id: <20240521225918.2147-1-hdanton@sina.com>
In-Reply-To: <CAADnVQKuPJv-GNH9SAWL-esSERMXJmSamWRe7AG3cW=NTnf51w@mail.gmail.com>
References: <838e7959-a360-4ac1-b36a-a3469236129b@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 21 May 2024 08:38:52 -0700 Alexei Starovoitov <alexei.starovoitov@gmail.com>
> On Sun, May 12, 2024 at 12:22=E2=80=AFAM Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > --- a/net/core/sock_map.c
> > +++ b/net/core/sock_map.c
> > @@ -142,6 +142,7 @@ static void sock_map_del_link(struct sock *sk,
> >         bool strp_stop =3D false, verdict_stop =3D false;
> >         struct sk_psock_link *link, *tmp;
> >
> > +       rcu_read_lock();
> >         spin_lock_bh(&psock->link_lock);
> 
> I think this is incorrect.
> spin_lock_bh may sleep in RT and it won't be safe to do in rcu cs.

Could you specify why it won't be safe in rcu cs if you are right?
What does rcu look like in RT if not nothing?
> 
> pw-bot: cr

