Return-Path: <bpf+bounces-78204-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11171D00F18
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 04:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E94F300CB84
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 03:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAA02773F9;
	Thu,  8 Jan 2026 03:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ApOsPKZi"
X-Original-To: bpf@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CB71DDC1D
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 03:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767844336; cv=none; b=BpreD+JP5szRaBSw8AuQR1/w8Ke1JwwiDJpzMZd8cDOmtEESvDBzOlYHBVsk7jnzGA4rMuKBlaBqoPBTxUToKUHtzCGn7Q0TW8QLH0f/3tnqZ8XRaG/BUhUhaLiEu9aSLxU6j/mb8bh56bbl7TQHUbPxtkelDU4AVNGwL8yHWAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767844336; c=relaxed/simple;
	bh=N11ud/29/xb3iZMmXpKrXBXTa9bni9MiyylUgTmbtYM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=XUnN5E1nMGIhuiCx1QLr8kbrgzUWDDjRL9qFSsYUCexw2WQORLYlUo+02yTcSWJV6G+K9O5ky8tvzJZ/CDUSD2SZmfOs1YR10lZngrxi8r/l65hTCu78NCnI7lVwhjU8/aYnuSexWX8jQkJxObU1YLhpStxhOSkk7WFb0cydTZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ApOsPKZi; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1767844323; bh=vmPXkqU9yLiH93gm3VWlfOFiLqBtoUVm3HoDD1IKX60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ApOsPKZirq3t+vkYzL6/lvYqmxCgD99/dRdUEn+cnVYMBBxn6IHRF2EiW5mY/kPnH
	 4BJxNSh4JosqAzs03ss4ABUhtS4LvFKMy7cdKyXSHGS8ScWqnxhDRgos5hYu/U2hnD
	 P62kGvzypHN6MGMkw+RZekmbPEuXBHePUf5Nbg/w=
Received: from lxu-ped-host.. ([114.244.57.24])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id CFB99C1E; Thu, 08 Jan 2026 11:51:59 +0800
X-QQ-mid: xmsmtpt1767844319trs1jpa36
Message-ID: <tencent_1F9A6FB02D856F9C9550E80AEC3ECD30790A@qq.com>
X-QQ-XMAILINFO: Od8VqZhFMB3NLUra3EypMbPafKfoZi5h+aLWwHliwL/oL/OhOxcWvPKurQDQIC
	 g+p8obuBjkNWvvIYqS4zbfiHpFSpGBlJooYkH14P2fwpaC9IxLI7GQp0Dv2sDHvc3ro+zo4D8+/b
	 He02rn0CuGtAS76odeb/eoEExlFYssZgAffeXjB2pV4qHsRIdo/O0N6RljkZr36ZHo1JnKY1gF3p
	 8VlojG5HCgCBSVuRjXH+7MxhTgwtho9FmvwRXZusEHmK5mYWnFi88CZvyQBML6nXw0HrPzoeALf/
	 h6Jf29NV+SyD/pyllLhPCCG1tCHFyT+oFq+Cm4gxfOyNRpvNA+Hr7dsb2wkHNLmRcQb7uNRBL3qL
	 pcTTi9hI1kgYLaG0khXY9i2p/QOE4s4Yy2gBNsXS3MmMWdxdoZ0wZQ50YjnoQ/Fw1HV1CsRdRXuw
	 Gy3o4MP2/qK8bnA1Zya623JQB0c38wU1v9N9rQEfS0sC7PkYDzTPgne2B27ChWGc0dCT6m5iBWcP
	 5XeLyUVqbQTRpUSBNrAm7JTzM/70LBU0JFAv4G+PR7Mvn2IoTcisa9vg+yvBt4K02Vmer/2HjKCa
	 P966D+Ql2VwV3HzxXtifr4+KCIh915idUYczdEWIPUl6fSqRaiVS4zzeacKEmAW41gx/ZEyfQTDk
	 jowSs1bSgZFdmhsCE/YZoZyB+EIIeZyhenD5eCDNjNIpdg6x/y7YbZFhRLeZfT8VafZhcpxyBtsH
	 7K160SJEYQmH/l++y3/PAAFVrd7RCYzIcOpe+/RyHICczkil+2ahksQjeoClonEW9ccvu5HG5f3L
	 HCoL0NO18ph8aJo7rOJ6U46m3Zcc755DHXEIZZzqYEFNlm82y4P5dqSA6k83fXB43FWSdf3W4lmq
	 6c3kQ1GKImlmNyyays/CwjfzdjZTMZYSgx93eFMPDD3W6sIx7BDqVhiBp/vh+ZdD/MsXyN9VcLG0
	 4sKwLhN/Wz438JaMMszVJVsoQufZ1K77FOvlmPlPFoioeiD6N2IdIqLiMW+jgj/HYf9Q84SCw=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Edward Adam Davis <eadavis@qq.com>
To: alexei.starovoitov@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eadavis@qq.com,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	sdf@fomichev.me,
	song@kernel.org,
	syzbot+2c29addf92581b410079@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH] bpf: Format string can't be empty
Date: Thu,  8 Jan 2026 11:52:00 +0800
X-OQ-MSGID: <20260108035159.496633-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAADnVQ+oMVuUjZi0MtGf52P3Xg9p4RBFarwZ_PiLWMAu+hU=rg@mail.gmail.com>
References: <CAADnVQ+oMVuUjZi0MtGf52P3Xg9p4RBFarwZ_PiLWMAu+hU=rg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 7 Jan 2026 19:02:37 -0800, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index db72b96f9c8c..88da2d0e634c 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -827,7 +827,7 @@ int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, const u64 *raw_args,
> >         char fmt_ptype, cur_ip[16], ip_spec[] = "%pXX";
> >
> >         fmt_end = strnchr(fmt, fmt_size, 0);
> > -       if (!fmt_end)
> > +       if (!fmt_end || fmt_end == fmt)
> >                 return -EINVAL;
> 
> I don't think you root caused it correctly.
> The better fix and analysis:
I am keeping my analysis and patch.
The root cause of the problem is that the format string does not contain
a null terminator ('\0').
Filtering out map type 0x22 to solve the problem is too hasty, as it
would prevent all instructions from calling functions with constant
string arguments.


