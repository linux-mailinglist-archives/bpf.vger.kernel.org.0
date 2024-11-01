Return-Path: <bpf+bounces-43726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC9C9B909F
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 12:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46D07282886
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 11:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9FD19ADA6;
	Fri,  1 Nov 2024 11:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fiu0xZ9j"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB34B15359A
	for <bpf@vger.kernel.org>; Fri,  1 Nov 2024 11:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730461897; cv=none; b=W68FIMULv2hhodoFhr2YzEVQ2tq46Q9rFllEC45zd0IGFmAgSX8WtI140g2n+ULW+EA8kD9ONbY7CZ0OBBmUeZKVKY/lPeAAiTEcf9MjDufgKxUmZV4ihtg5cofj62ZEYDzJIsDDvYGAtXKEOstQ6Uq3Dyr+lOus4wtG8Krgk9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730461897; c=relaxed/simple;
	bh=rsEHgKLuWcvz36/Rz5yzfsGk6AH+liwbTq1/0AfcL1w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pi77l7ET+7VdV7aQEtqAqfOXBK1rWp7b18jPQBV19NlTWde9MBsFckT0WYT//3FDUZsdV2m7GxKmaMZhvquJmD71IxYOmSgj5nbtdAqMMcj/l+pcm3xQcbKh/JwF6s45ibtZcOFmuoKeTTzkhzu+x2kyQ2FJDWOclOR7U0pLGxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fiu0xZ9j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730461894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rsEHgKLuWcvz36/Rz5yzfsGk6AH+liwbTq1/0AfcL1w=;
	b=Fiu0xZ9jdKkSL+Wq0zuwFDV8SvtYVr4VZQ/pWLVAC7PluM2RKnd1sJsLwKzhwSnEL6sASh
	/WTNwZtvs7ASSOBKYGJW8FNikHnvbQ2ydiO6llf9k0biF3CNl01bIQnXUq063wf3R5xPaK
	AkdfBn9fU2mxXlkF7Q6I6LBWayuLCmg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-Ksoim_sgPXeAb-ufcVtf1w-1; Fri, 01 Nov 2024 07:51:33 -0400
X-MC-Unique: Ksoim_sgPXeAb-ufcVtf1w-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d531a19a9so1039506f8f.1
        for <bpf@vger.kernel.org>; Fri, 01 Nov 2024 04:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730461892; x=1731066692;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rsEHgKLuWcvz36/Rz5yzfsGk6AH+liwbTq1/0AfcL1w=;
        b=h8s1eUjUKUBzkp/yevqVkyZTeM2f5Q9ARvqqv4EzCClLEWo6C/4J/dkq8MVt6kDnWE
         oblvJ6DzA+EcBE2S0P0eEjP0HBYh2GiEyi76VBtJDH0/Ck7mIPOlUQErNvGSCN6DeOfc
         LhDopzB38Bzhv9PC4Tg99BKWYh2Px8cRHcB3bQQTgWkz2A1m5IYsjQAn9TiHl6QzUYe3
         EnVMeTEQhAWmy4QiixSwhichi2WBMHGc9C1FtIAUQ6+kUGYFPH6CqWycW/3SN962qOUz
         4AiTUHH/zD7w4gq6y+bvoo+5FhRHSBZEJ5WCRnF2srsi/Q7+lsaGy5aWmez/cOn84br9
         8kCA==
X-Forwarded-Encrypted: i=1; AJvYcCWkjejvfdDzl9/w+hYHmAKOB542jv4XFR71ISDXT0M83/TAQHTOLw2xHRTc6y46tycLWxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtXy7HgOmEc6gdjuqN+PXqPeBUmDNJz09iHe4PBCxzWXa3VoOj
	5NwY9+0vv3HWZQQj7JDoyXTLtV1cFaaGjr5+HupBvgcBEoLZeu8naWd3D+Um90GeHPYfNxGu9yw
	SzUH+T2TIacGmnS4I/vB7GsItUpWAInYO++8QHTDGd5moN6aJvw==
X-Received: by 2002:a05:6000:1564:b0:37d:94d6:5e20 with SMTP id ffacd0b85a97d-381be764e4amr6409657f8f.4.1730461892460;
        Fri, 01 Nov 2024 04:51:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGS/eOEyEN3rqadpyq16ef47A5nw2zggvZfNjgqN1OyQ1xs15a45QCa7mgQruSh8w34R8VLyg==
X-Received: by 2002:a05:6000:1564:b0:37d:94d6:5e20 with SMTP id ffacd0b85a97d-381be764e4amr6409639f8f.4.1730461892097;
        Fri, 01 Nov 2024 04:51:32 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113dd8asm4861201f8f.73.2024.11.01.04.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 04:51:31 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 9329C164B950; Fri, 01 Nov 2024 12:51:30 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Magnus Karlsson <magnus.karlsson@intel.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 06/18] xdp: allow attaching already
 registered memory model to xdp_rxq_info
In-Reply-To: <20241030165201.442301-7-aleksander.lobakin@intel.com>
References: <20241030165201.442301-1-aleksander.lobakin@intel.com>
 <20241030165201.442301-7-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 01 Nov 2024 12:51:30 +0100
Message-ID: <87r07v9np9.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> One may need to register memory model separately from xdp_rxq_info. One
> simple example may be XDP test run code, but in general, it might be
> useful when memory model registering is managed by one layer and then
> XDP RxQ info by a different one.
> Allow such scenarios by adding a simple helper which "attaches" an
> already registered memory model to the desired xdp_rxq_info. As this
> is mostly needed for Page Pool, add a special function to do that for
> a &page_pool pointer.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


