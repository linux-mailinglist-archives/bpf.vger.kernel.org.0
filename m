Return-Path: <bpf+bounces-73357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F0EC2CD56
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 16:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A24E461885
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 15:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01AA32E139;
	Mon,  3 Nov 2025 14:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="by9UlC4f";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RyaWd2qm"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEB632D0FC
	for <bpf@vger.kernel.org>; Mon,  3 Nov 2025 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181420; cv=none; b=gbtHZ0j/coP0aBCMcv215P5lOH+FggG/2sGFPInlFfSOROxULhkkMW8weVytrA3Z1C+kz73WCDeUmZW78JZkfRfP52H0ayCWrffZsL4Ok8Q3mpJQ4OcN+04pzolX207gtuiIpgup+NA9tN0wnjE6c03SfT7P5TMeI5SuOeOXYns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181420; c=relaxed/simple;
	bh=awDPBHUqeWdiCTx68GRboOT/DtuaFpnsr65AopF29ug=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kkz1m8t8Vv0ZywM7oty2EYXf5UJbL18V8c9SaJmDG1E+cB8fvkrQ5ThOnTeNRJluv9221CmuFfxknHuI3ocia8/qiKdKPZwAxNBTxL6/tHfTwEek0NysyxerR4e6Zd1VdKoofvD/3iUevQU+aKiYC9TK6SzunYYaKx8Kyan4x6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=by9UlC4f; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RyaWd2qm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762181417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+nMoLQg870a5vLIr0xXAcHBID4BH0thIsNlUoCS1bvw=;
	b=by9UlC4f58KcKtON0qHfnThNHBnkgATF9tGkDpuax+SaXKAXxXR/pokn5hgNG/jeFO4bCe
	1auCuJZ6e1x1h9RXq6DO39WTc1/rtLIBtNV+dpCQvbT0MbdSt2Q57nTCb4X2hJOsSiUL/U
	WYhTmzaIhNYxXA3aGw+eurkhXeYt+6Q=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-CAPk-mB4Mpi9saQmoMdZXw-1; Mon, 03 Nov 2025 09:50:13 -0500
X-MC-Unique: CAPk-mB4Mpi9saQmoMdZXw-1
X-Mimecast-MFC-AGG-ID: CAPk-mB4Mpi9saQmoMdZXw_1762181412
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-640a03bb8afso3920187a12.0
        for <bpf@vger.kernel.org>; Mon, 03 Nov 2025 06:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762181412; x=1762786212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+nMoLQg870a5vLIr0xXAcHBID4BH0thIsNlUoCS1bvw=;
        b=RyaWd2qmMgLNxTEMP+ty7Hf7+cPTiZbtYEZrbVlO5TCfB5ecEWMIgphfpThCwMzPk2
         CKGLsyeGz4mjIXYVawPbk3kfmpTVVOhno2tLd/+QP9NgFDiOEghCaFaSKI3VREeM7sBf
         0U91Mt2+hDO+jKrv4fXEcY+y0zVHcoGCa10Mo+KzHQ/QvfmUfY6neKC8sx/Be6gE99aV
         JjhLNkdAFVzQBA950JK0ynx+/Ypg1zCaZLz9hwFEAyWFJ4Ki+5oSlrNv/U84tOWOCAAd
         aTWnn/a9ozB6Z4Ktyze8X/yrGYEtRyBxki0m2v1suGKa6BZMw56FewcGoiqvVOfdOS6H
         YTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762181412; x=1762786212;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+nMoLQg870a5vLIr0xXAcHBID4BH0thIsNlUoCS1bvw=;
        b=dhrosKcoxine0LW8MVk13lTR58ayCvCDnBesYWmY/Kni9/NDHtkZLF5sISFJaCwmnE
         N5Qn1weo0NQZlcpAgOp6fOjLyXKBGnpZI04POcLICwxgI+hAEIYF5k0MNegVUUAWefRw
         vGVRmMOKVxKi/3euN2tYaugwrXhYc5/1ygvJKfSQwjf1ptkfNoeWKlmKkNlPvUZZbyO8
         jGfETleelJ9Y4WcsHZDM1HjA62urFvTmI5wmIUn7ytkGyYrquyNLFzrAJtcoWYAjdp0d
         vbQ9Qxn1kTUaQ4E6xyZMrzfXXHJ++XLCYEi2roifOWQsNe2BGeQIWE81nBI5SspkoB/U
         uZCg==
X-Forwarded-Encrypted: i=1; AJvYcCVoKX7uk7o64gpYmhLIlpAUKoYyCtJKmEi9gBiPcF+j9NEkmZCgcooxf1762wz3kwC+iZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMYLfjKJPC+v3+QmBfyJYQDrYkoZfwxjsqTPTXAHJX7OxTwSyR
	hE0R8c3y1wXSqGQfXhDSewJzDRyB/R97DeMCr01EnJQR7swBHjPEbdTqNUgX6e7uZRM1OWb3pKb
	0QreylEYbVcAqvd3TloNR3HsbzguHDIgwKHZ0TZ0hlO3gCVe+IfwxtQ==
X-Gm-Gg: ASbGncvDd/PSgRlw7hycyU+qc1W2imlgNc0HQ1IoBPMp51s4Wg0JRwZrP6z/BJ+pwn/
	EtOYyTb4wtNO7IS8ezO2DlQQv353Q7GKnrssaxZGTx3PLfbRqxHYMnl7L1YPxhZ7ptaA9rOPYHq
	ONFWF0gnCXPAJx5TYmx22LGmD9O7JUCtygr7FtJnNH9Or6hMXZXUBXn1pWdAyiwgH3Ums9v541w
	UKpq9vquSzgpWQbXyLndV1zl8QXPIEeHbIOt6uOwTJ4bb/tnVWg1SdnglD69TJmtJUtP0M8r9Vs
	FuUhbAKksCQVd93J4lfuWkK3oY2xXzbcM2d77mZ0ZuiieoKbcpaCh/Jqb3dkj95bee5xzh3s0fG
	kAiMqa6xnP7D/fzaRRuFDZJ0=
X-Received: by 2002:a05:6402:34ca:b0:640:b497:bf71 with SMTP id 4fb4d7f45d1cf-640b497c2admr4755542a12.8.1762181411931;
        Mon, 03 Nov 2025 06:50:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNHHGCfan3xN8hz0VQLwH+oMIT11J2vhXom0DZu1MBhk6Duw5v6C2YzkNLZvnmt+vEeRS3LQ==
X-Received: by 2002:a05:6402:34ca:b0:640:b497:bf71 with SMTP id 4fb4d7f45d1cf-640b497c2admr4755480a12.8.1762181411457;
        Mon, 03 Nov 2025 06:50:11 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640b977e6acsm4056741a12.25.2025.11.03.06.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 06:50:10 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id B7D07328476; Mon, 03 Nov 2025 15:50:09 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Byungchul Park <byungchul@sk.com>
Cc: linux-mm@kvack.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
 harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, horms@kernel.org, jackmanb@google.com,
 hannes@cmpxchg.org, ziy@nvidia.com, ilias.apalodimas@linaro.org,
 willy@infradead.org, brauner@kernel.org, kas@kernel.org,
 yuzhao@google.com, usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
 almasrymina@google.com, asml.silence@gmail.com, bpf@vger.kernel.org,
 linux-rdma@vger.kernel.org, sfr@canb.auug.org.au, dw@davidwei.uk,
 ap420073@gmail.com, dtatulea@nvidia.com
Subject: Re: [RFC mm v5 2/2] mm: introduce a new page type for page pool in
 page type
In-Reply-To: <20251103123942.GA64460@system.software.com>
References: <20251103075108.26437-1-byungchul@sk.com>
 <20251103075108.26437-3-byungchul@sk.com> <87jz07pajq.fsf@toke.dk>
 <20251103123942.GA64460@system.software.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 03 Nov 2025 15:50:09 +0100
Message-ID: <87h5vbp3vi.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byungchul Park <byungchul@sk.com> writes:

> On Mon, Nov 03, 2025 at 01:26:01PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Byungchul Park <byungchul@sk.com> writes:
>>=20
>> > Currently, the condition 'page->pp_magic =3D=3D PP_SIGNATURE' is used =
to
>> > determine if a page belongs to a page pool.  However, with the planned
>> > removal of ->pp_magic, we should instead leverage the page_type in
>> > struct page, such as PGTY_netpp, for this purpose.
>> >
>> > Introduce and use the page type APIs e.g. PageNetpp(), __SetPageNetpp(=
),
>> > and __ClearPageNetpp() instead, and remove the existing APIs accessing
>> > ->pp_magic e.g. page_pool_page_is_pp(), netmem_or_pp_magic(), and
>> > netmem_clear_pp_magic().
>> >
>> > This work was inspired by the following link:
>> >
>> > [1] https://lore.kernel.org/all/582f41c0-2742-4400-9c81-0d46bf4e8314@g=
mail.com/
>> >
>> > While at it, move the sanity check for page pool to on free.
>> >
>> > Suggested-by: David Hildenbrand <david@redhat.com>
>> > Co-developed-by: Pavel Begunkov <asml.silence@gmail.com>
>> > Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> > Signed-off-by: Byungchul Park <byungchul@sk.com>
>> > Acked-by: David Hildenbrand <david@redhat.com>
>> > Acked-by: Zi Yan <ziy@nvidia.com>
>> > Acked-by: Mina Almasry <almasrymina@google.com>
>>=20
>> Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>=20
>> IIUC, this will allow us to move the PP-specific fields out of struct
>> page entirely at some point, right? What are the steps needed to get to
>> that point after this?
>
> Yes, it'd be almost done once this set gets merged :-)
>
> Will check if I can safely remove pp fields from struct page, and do
> it!

Sounds good, thanks!

-Toke


