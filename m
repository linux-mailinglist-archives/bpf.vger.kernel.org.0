Return-Path: <bpf+bounces-45086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAEB9D108E
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 13:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E465283765
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 12:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFB319924E;
	Mon, 18 Nov 2024 12:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iWtcCuI/"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CABC1E529
	for <bpf@vger.kernel.org>; Mon, 18 Nov 2024 12:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731932903; cv=none; b=O3naLexS3m8k6d7r8TzZPqwmdzsktuwk28nCZg8QgZKpmuqtWxo18AAIGlGEpulRSh6JFwQrTVcHSoObWFWON8VVWdFngv3kwn+79gZ6i2X/0fxE0bvu8yHg0U+xbdmQVH2zaHWsIbk2pUdZHOyaXGnvvUwln9bUTJFBqBGmJ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731932903; c=relaxed/simple;
	bh=a5PMJuIheTZSJYz9j4L7hnc4jQbZtmom0+ZK4aHxoNg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z3OaxCUSbddK1Eh9GjxYOahrVmXKGzLLCKGb2QdfcD37+y0poSDG0q32FRkH3RHbwlTF5TeXUbhBZQK7M5LHbtgPF8Q/JIRdSBtVD+w+MJpzE2+UrenAyJnmYyB55g7A3t3i54Ge3BndpbYXgrDUCuBKHsplhasEhxAOgE8crIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iWtcCuI/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731932900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a5PMJuIheTZSJYz9j4L7hnc4jQbZtmom0+ZK4aHxoNg=;
	b=iWtcCuI/PDEQ+akpMz7Wx7CLdvAY594WWrokZ81AniyYXtSW4BVvOQYGbGsFcCHU0byOwc
	lOqr5rczgVZEpXWbGPnDPwFCU+UfNapUA9au1PT8Nn7GiLvcv+DOwpXjSPOMK7nr+japqO
	2/u2luvsOslwf44Kt1uGXCxqCHIn240=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160--6PaQRAHNf-SOV_jNZu6Yw-1; Mon, 18 Nov 2024 07:28:19 -0500
X-MC-Unique: -6PaQRAHNf-SOV_jNZu6Yw-1
X-Mimecast-MFC-AGG-ID: -6PaQRAHNf-SOV_jNZu6Yw
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-382341057e6so938244f8f.2
        for <bpf@vger.kernel.org>; Mon, 18 Nov 2024 04:28:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731932898; x=1732537698;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5PMJuIheTZSJYz9j4L7hnc4jQbZtmom0+ZK4aHxoNg=;
        b=wI9HG9z/mWluxNj88G3OyDDxqyNI1OYRyEZdfcls0zw7/NfSfQJxmuLlxRs1CFJRhS
         3ocugXrmx98cMoAMR9NZI5knW4GcqOQFm8FeeJc/AvCZPF/onOVTaFpUZPKAVyd47jMC
         prJLVWLq35iNs+H/YxNpIbw+802ftIe1lzSED5uCxoPVD5VZvD2Qq21kRa8NPz2PDmRY
         9WbBXhxRtx5ooexauXAb9gV7o2PhtOWOQO16Amjrv5+nnY9dFH0Uje0H8G5v9QB9g0+2
         c7jLSuPp4oWCBcxlr2mr0W/8Kv3BqC358SKxRjEaP6Y71mmo/Xj0orjaV5l6mnqFG5uO
         JeKw==
X-Forwarded-Encrypted: i=1; AJvYcCX/Bu3uCaxK5/e+iWSRK8mfcNUB0QsZZ2rEisb8NESF/HyePaFjNQKHKzXskCuCzL5ror4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBYIc7b7QjLSEj8vmbvxUpvh0xqLm2yZAPWPa/YfPBFdNRx9Kx
	MfTonzPAz6IbOh4AEd5bCoWJNip/qUTnp4twUDhUzWKuAZMJ+elOujnmbcDSRXyOM6wfBo2Jj2t
	C++8pz/coBvhwpX2QEhkwf1i7OxVKgelbzNWSE3FQfQb5pqRmEw==
X-Received: by 2002:a05:6000:1f88:b0:37c:d276:f04 with SMTP id ffacd0b85a97d-38225a915fbmr8419320f8f.45.1731932897851;
        Mon, 18 Nov 2024 04:28:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvUSesMJRyfpD4TZAAq7HWvYwAaBvYrcLEgAyZnzJ30O5fX5SLDeKa4T0Pf5ECbNyeCQU7xg==
X-Received: by 2002:a05:6000:1f88:b0:37c:d276:f04 with SMTP id ffacd0b85a97d-38225a915fbmr8419306f8f.45.1731932897464;
        Mon, 18 Nov 2024 04:28:17 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38232cde8dasm7782246f8f.103.2024.11.18.04.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 04:28:16 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 9576C164D313; Mon, 18 Nov 2024 13:28:15 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v4] selftests/bpf: Consolidate kernel modules
 into common directory
In-Reply-To: <CAEf4Bzb7KXhZW06vB=01O3SstQo8zNYfooyMNSx=6O0VXH__Bw@mail.gmail.com>
References: <20241113-bpf-selftests-mod-compile-v4-1-730d5b824617@redhat.com>
 <CAEf4Bzb7KXhZW06vB=01O3SstQo8zNYfooyMNSx=6O0VXH__Bw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 18 Nov 2024 13:28:15 +0100
Message-ID: <87h684rajk.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Wed, Nov 13, 2024 at 3:25=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@redhat.com> wrote:
>>
>> The selftests build four kernel modules which use copy-pasted Makefile
>> targets. This is a bit messy, and doesn't scale so well when we add more
>> modules, so let's consolidate these rules into a single rule generated
>> for each module name, and move the module sources into a single
>> directory.
>>
>> To avoid parallel builds of the different modules stepping on each
>> other's toes during the 'modpost' phase of the Kbuild 'make modules', we
>> annotate the module copy target as .NOTPARALLEL, which makes all
>> its *dependencies* execute sequentially regardless of whether make is
>> doing parallel builds or not. This means the recursive make calls into
>> the test_kmods directory will be serialised, and when the first one
>> actually builds all four modules in the subdirectory, make will
>> correctly skip the three other calls, so we end up with just one build
>> of the subdir modules.
>>
>> Acked-by: Viktor Malik <vmalik@redhat.com>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>> Changes in v4:
>> - Rebase on bpf-next
>> - Link to v3: https://lore.kernel.org/r/20241111-bpf-selftests-mod-compi=
le-v3-1-e2e6369ed670@redhat.com
>>
>> Changes in v3:
>> - Use .NOTPARALLEL annotation instead of creating a modules.built file
>
> Is it just me, or did this make everything non-parallel? When I
> applied this locally, even .bpf.c compilation and skeleton generation
> was sequential despite `make -j$(nproc)`.
>
> We can't do that, it's too much of a regression.

Huh, no, that was certainly not the intention! Will take another look...

-Toke


