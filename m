Return-Path: <bpf+bounces-69937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3D5BA85B3
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 10:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A2DC17CB93
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 08:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48E7273D6F;
	Mon, 29 Sep 2025 08:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="b0Mc6tJI"
X-Original-To: bpf@vger.kernel.org
Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de [131.188.11.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190AF241673;
	Mon, 29 Sep 2025 08:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759133230; cv=none; b=EhZYysxSRRJ73gpMcRtuKmh/xRAdrvAn0jl+pnXw6JOeoZvmI379GJnDYPFzlO1Js/qvuSxhKK0MwT97tks4Hey2jqwMNl6TLjWIFQLaL5K0mtpk+k0TA0y2D9r7pL3OFvnhEJV1J9LqmMbpZxGnlXgmyCf/2+FxkGhjnVsbSZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759133230; c=relaxed/simple;
	bh=7Uqa7d0X6TJXU6AvAUFfJg25iBgFiv06F0mlCO6N0iY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KFjUl/vawznTWoP6kE6aKhvUMPAXgdATq2zXF5S4RYcewW4ClrFnrjZ5oLzi78ZjDPpZAlH2TNVhB+iwgtCqp8XrZu8hfED5EU/G02w23TtnnSz5oJQN/0jbNnjbt/lwVbq8orjwx69+pe1c9wUFYjQgEulhKzh0PXrMdEHRAm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=b0Mc6tJI; arc=none smtp.client-ip=131.188.11.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1759132659; bh=tQjua46FvVJE9MzSMyz4WoXASez1e6t/wVOU6v9nlv0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From:To:CC:
	 Subject;
	b=b0Mc6tJII03ZeHPk+VhVTzzI2pXRDdiiwVTG6HJqqqXIsFQBmlaPrQjtEG0Se2JtT
	 b/FyXJ0hxD0EbOyuUUnYDXX8IKHXmhTcRhYtgAth3DgXdixans7BUEV1YDolkiFrQ6
	 y1Owc70+zpFZ+wGCNTUzlTGwuyGTLjh5M5DLLeeqaHQ0ZzJ9CoGKW/Qho6v+BaM8nw
	 jPHJlX8TcCfDaaFTOV83hvyrzCEpdyO9ShYim/DS5UnN8+hR4llOY2XnaXu29S2hFC
	 Evs+L9txvSBL+3WmA/BMGha/7aZI2/7+C+EktDzkjIvGJtU5DwNFRcAQ9B2dM69Rln
	 L/qYMx0BzLKBQ==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4cZtpC5BxCz8sj0;
	Mon, 29 Sep 2025 09:57:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 10.188.34.184
Received: from localhost (i4laptop33.informatik.uni-erlangen.de [10.188.34.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1/qSYmlndMZ2soByeqa6AAIxSVy7E6kwls=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4cZtp90K9cz8sjZ;
	Mon, 29 Sep 2025 09:57:37 +0200 (CEST)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,  ast@kernel.org,  daniel@iogearbox.net,
  eddyz87@gmail.com,  haoluo@google.com,  henriette.herzog@rub.de,
  john.fastabend@gmail.com,  jolsa@kernel.org,  kpsingh@kernel.org,
  linux-kernel@vger.kernel.org,  martin.lau@linux.dev,  memxor@gmail.com,
  sdf@fomichev.me,  song@kernel.org,  syzkaller-bugs@googlegroups.com,
  yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] WARNING in maybe_exit_scc
In-Reply-To: <68c939d3.050a0220.2ff435.03c1.GAE@google.com> (syzbot's message
	of "Tue, 16 Sep 2025 03:20:03 -0700")
References: <68c939d3.050a0220.2ff435.03c1.GAE@google.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 29 Sep 2025 09:57:36 +0200
Message-ID: <878qhxadxr.fsf@fau.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

syzbot <syzbot+3afc814e8df1af64b653@syzkaller.appspotmail.com> writes:

> syzbot has bisected this issue to:
>
> commit d6f1c85f22534d2d9fea9b32645da19c91ebe7d2
> Author: Luis Gerhorst <luis.gerhorst@fau.de>
> Date:   Tue Jun 3 21:24:28 2025 +0000
>
>     bpf: Fall back to nospec for Spectre v1
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17753762580000
> start commit:   f83ec76bf285 Linux 6.17-rc6
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=14f53762580000
> console output: https://syzkaller.appspot.com/x/log.txt?x=10f53762580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8f01d8629880e620
> dashboard link: https://syzkaller.appspot.com/bug?extid=3afc814e8df1af64b653
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=104a947c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14467b62580000
>
> Reported-by: syzbot+3afc814e8df1af64b653@syzkaller.appspotmail.com
> Fixes: d6f1c85f2253 ("bpf: Fall back to nospec for Spectre v1")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Sorry for the delay as I was out of office.

I will be looking into this and also [1] shortly.

[1] https://lore.kernel.org/bpf/68c8de6b.050a0220.3c6139.0d26.GAE@google.com/ ("Re: [syzbot] [bpf?] WARNING in do_check (2)")

