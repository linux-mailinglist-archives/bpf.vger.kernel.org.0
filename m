Return-Path: <bpf+bounces-76679-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1CDCC0EB3
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 05:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3C8D2311D72A
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 04:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B8633E376;
	Tue, 16 Dec 2025 04:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AucSs3Na"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A284329E7D
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 04:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765857997; cv=none; b=nW4jD9H+ZQ6SGn/T1PBDDjmXwb6QUo+Pwjp8vr8Q1D2HOg2XV9kMgOAQh63gsQKnwQNsoV+Au+L3G8v194dmIL6wGVrHERoNcXyJGHPVdaVVWJJF9mlnY8TT0sKwSEcCr3r0gowFLbj0eSzunm6aj883jwTKc1RNg7Tav9r1zjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765857997; c=relaxed/simple;
	bh=xZP+twLprQv0K1+jd7CCaPFU8HDDQTV9yaiBXS7TugE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QwoRGGAZxuo7QizCZrqxDnecdBkLdgSJ1Yy5ghC58TNFYcFJ8MwRP17CyMkdaZLicYd8y1mFieRpt45yjQNPsntgq6pUQIDrI+SEX8x2IAEE1/ZJCp3kq2OrUl1+0/U/SZ47kgRMudW34cNoppTQ/C+sBcKsC1w3erBE9NDMbvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AucSs3Na; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42e2d02a3c9so2831255f8f.3
        for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 20:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765857986; x=1766462786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNREp8PjCZDYXW0ypWF7XmSCt4g2PxdyE3cOeGMNSLU=;
        b=AucSs3NaTJ5MquLcknVxcgGMcylks8qEQfw2mGZXsOZ5wkRacinqBhG3sqYjY223JU
         dj4BhmXouprHVACvsU1m0hK1ZE9D6l9Y5kUhzTYC5/kZRbDwv+nE44KmnDwEF3FF2HGX
         3/ldc7+BGG6UWdSsITijgpn/k7p4ErjTsVIueyORoxxEiBXcSim6QEnnfimA9RjT/MAE
         5/99wryLio67kQN7sEQxVqngeD2LXANCZPOuald7vrgqs8sQzIIIaF9EWUyp5e25hbNJ
         wJsPoCj7Q3CTy19QXLnURi737JoqOoqetIdT5pK7ty8IE+cNleXTYuWMJ+WTvR+kbKKV
         6ppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765857986; x=1766462786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UNREp8PjCZDYXW0ypWF7XmSCt4g2PxdyE3cOeGMNSLU=;
        b=iaBWyELXcDKQA5yE5zauQKRLDGf3D1jVR6MWO3W6n7vuMjqt4wfJkaoDcE8FLd7JJs
         f4wseIglqvXDAMBXl/UhCxD17Z6+3tqFJUY5K/isg0H6ErFT7pFuvda7fgtNMQgVt+b/
         oFyyvh4GtNzsHpbxXIylYYvDKCmHp+gbk1ypS6LPw3FcACe5dN+U8rJSm+i2NsyrztG5
         IVVQT0YOhIb4HN+KgrC4qFzklQuHD+Sv3fcb5veyIQTRLo+VHlYvNo1ycRQlVjwrJy+J
         pcx+LjeUI7qrPt3oZkICVhUIhJbIRU6om6Yz2+teuDar6jvDKqSX9euS+oL7JMoEoftf
         Ae1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXGxlfqlZvIRPPKiuCFOm8+8Y4gD7FglkdkQgGLyDXO180tV9YpyXIyjmGCXk8m4uZrjYE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3MzSda3n8WBzRjxq/fsv9++po+q8DhuLMknQbWyC86wmlpdMb
	+9zPymAjFqX7l5Q+t12RFXFFoitx1lWeTI29JPQ/7/zhXlXZ5CViJa4Vpm54fIv13M/FlKcFxIC
	K+t9RisCANHeQAlSJ4hkcR1OjkU6rzjg=
X-Gm-Gg: AY/fxX73SjGK4UvZSSaSUKQM3pUq32hRZbBfrJFU8Bl2IFgbOneORuAhtXNsSvxgOid
	4tZ1yCLYj21naRCsQL2NPbSmjNPdf9M33mN+Uxn8dq2zYLAa6v9QNUCX8x24mnO0grR31VC05lS
	zRmnoMphcAN7ZUJ4NeC33SIYuFFt16aZDIDEOFeTCrlANnylOmLGrNqKXSTYESZzdde6g6GZVdx
	9Yv1BKEiM++CxEIKzbvhwsDLnyrkBnEvkggfQirTiT2ppbj+L8lTeoKZFzEJZHpYQnikayoPsIv
	bXnIb1yhhe6JbhcXgaunpnszQp0W
X-Google-Smtp-Source: AGHT+IGg4RK4X0c89fwbUT+qs3xmpvj/KNtnBvTxzR2P62xeszs879WnsX91nzMKck3SYSKeNjHGRHDKi90h0VTKDK8=
X-Received: by 2002:a05:6000:2204:b0:42b:3e60:18ba with SMTP id
 ffacd0b85a97d-42fb44d476bmr12637233f8f.8.1765857985995; Mon, 15 Dec 2025
 20:06:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69369331.a70a0220.38f243.009d.GAE@google.com> <20251216031018.1615363-1-donglaipang@126.com>
In-Reply-To: <20251216031018.1615363-1-donglaipang@126.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 15 Dec 2025 20:06:14 -0800
X-Gm-Features: AQt7F2oZh6qLy-QoTQsJ9jl61alA3wGuYXO2YwKaufcqONhpSJo0ZebaOx98zgI
Message-ID: <CAADnVQJxso-6vnGDQQitqCjQQRjc4R09ofdFKroZLFtENJq4dw@mail.gmail.com>
Subject: Re: [PATCH] bpf: Fix NULL deref in __list_del_clearprev for flush_node
To: donglaipang@126.com
Cc: syzbot+2b3391f44313b3983e91@syzkaller.appspotmail.com, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, Eduard <eddyz87@gmail.com>, 
	Hao Luo <haoluo@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Network Development <netdev@vger.kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 7:14=E2=80=AFPM <donglaipang@126.com> wrote:
>
> From: DLpang <donglaipang@126.com>
>
> #syz test
>
> Hi,
>
> This patch fixes a NULL pointer dereference in the BPF subsystem that occ=
urs
> when __list_del_clearprev() is called on an already-cleared flush_node li=
st_head.
>
> The fix includes two parts:
> 1. Properly initialize the flush_node list_head during per-CPU bulk queue=
 allocation
>    using INIT_LIST_HEAD(&bq->flush_node)
> 2. Add defensive checks before calling __list_del_clearprev() to ensure t=
he node
>    is actually in the list by checking if (bq->flush_node.prev)
>
> According to the __list_del_clearprev documentation in include/linux/list=
.h,
> 'The code that uses this needs to check the node 'prev' pointer instead o=
f calling list_empty()'.
>
> This patch fixes the following syzbot-reported issue:
> https://syzkaller.appspot.com/bug?extid=3D2b3391f44313b3983e91
>
> Reported-by: syzbot+2b3391f44313b3983e91@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D2b3391f44313b3983e91
> Signed-off-by: DLpang <donglaipang@126.com>

If you're going to throw AI slop at us, please do your homework
and root cause the issue.
Nothing in this AI generated commit log explains the bug.

pw-bot: cr

