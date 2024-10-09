Return-Path: <bpf+bounces-41367-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81090996228
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 10:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EA2E1C20CC8
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 08:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3322184535;
	Wed,  9 Oct 2024 08:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ke1NOHd0"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE36C17E8E2
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 08:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728461677; cv=none; b=M6XnyCu6JvPeU+vJXgal7FxASDqayyfVYNqg2vves+jy56WmVwZi5s/h/xTUvDeg9rHLb1cYozSoQOAkmdswLIoxMwTWaT7LmoptaZY5dKEvIpgUUqsH0Vv+oBJIW0hwqymPCEIKWgcgmtV8sbSVvafMqPmD1fYtCPWDCSLJiHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728461677; c=relaxed/simple;
	bh=9dJzKEPFAD4JUvaS3jyOf92XvdpMOg2X+Hnh+1QsXE4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Uz2lstpyAX6tB1Zpz50BMbc0yyruRR74EL/laEJuQsoKf/0+xMDXDC/iOVB9ipTSye6zQcJK/n2Dba7yP76Er/fLreC0ndIeidBv8bfmrq2aNNEQPqC6RcXhIYXu4vxXlmf26EwwLZe1wkCPVxJNtMAFiqdPaOOmu7RnF4z/dSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ke1NOHd0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728461674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9dJzKEPFAD4JUvaS3jyOf92XvdpMOg2X+Hnh+1QsXE4=;
	b=Ke1NOHd0GsA1TnDoata2GVRXJIVwNsj+byifVaqKDZFF9kObI7sd7u4Z5tg+EXiSOt23So
	u/wCa6iYGjT5JYnXVwA+53ceSPufhQ9TFslOGtSrKfCbN4oGmr7dWL/pMOqfIvto3m9oY7
	xxSunkfz05KX53VfkX2qNQDst3fxfwI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-7dieWuyIN9i0pae8J2HFaw-1; Wed, 09 Oct 2024 03:39:24 -0400
X-MC-Unique: 7dieWuyIN9i0pae8J2HFaw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2fabdf87c02so48297991fa.3
        for <bpf@vger.kernel.org>; Wed, 09 Oct 2024 00:39:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728459563; x=1729064363;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dJzKEPFAD4JUvaS3jyOf92XvdpMOg2X+Hnh+1QsXE4=;
        b=fSXXZ7KiqktUgLf5fTSPfdlpSa6Mqa84J3bzeOCch8JR4QMxnVlVD4OI5DxuSklbGg
         HXcftRivR02tLVTvOvI+cx5fHEhcMTZiZLYQowv/xtJ9XXW9UKnaUgdr7EL85l1Uhv/8
         mlKbbe9PSa2+ckwFAd1uk9tvID4fQgj6cZxrDBtANREVYY1idM48IOCiO55VdjbecUxo
         KCXo5yoDf3c8sCo4+ZPSMgxNSoDf1Qw5n5/OC0Q0FowbCkRpRhP5+Tg3A9tlwrBwyffM
         fUxrOusNSGtJOF/Smd5D6XFrG9b0PcL9c/rMp2chycgO/drjT/Z8e+152FUk/z7QCvR7
         Miow==
X-Forwarded-Encrypted: i=1; AJvYcCVdPv7o9r1OJdlXuyRBdeLmWdsqlpRkNMQnq5YoGgi/m5LFo5qtYjwio1AhMiLkhHdvptY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDyU6sF115e2OCUZlmp4MppkyjrlQ15M+i1OnH5Q4Xk5ZKTK7i
	okC5S64TWu3hPPnJgV1lkmpNGc+N3bNoL7UybbMuU4DdsUrC8yNOIMRqF70/Fwg6s+pvT3vNPfx
	dUN9Nw/B+s4ALy7NnjeJIICBCbuPxpr76dRG2ccV9tCChf0h4AA==
X-Received: by 2002:a5d:6a0f:0:b0:374:c56e:1d44 with SMTP id ffacd0b85a97d-37d3aa83f66mr741056f8f.48.1728459551777;
        Wed, 09 Oct 2024 00:39:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYf5a/YJ8kLTN40pKDIOibKodHb2C12vO2gw43Om2R8cyTwst05scLhW8CZw3n+kl2AFVxTA==
X-Received: by 2002:a5d:6a0f:0:b0:374:c56e:1d44 with SMTP id ffacd0b85a97d-37d3aa83f66mr741029f8f.48.1728459551321;
        Wed, 09 Oct 2024 00:39:11 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d748dd50sm11261915e9.47.2024.10.09.00.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 00:39:09 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 7136315F3D4A; Wed, 09 Oct 2024 09:39:08 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Simon
 Sundberg <simon.sundberg@kau.se>, bpf <bpf@vger.kernel.org>, Network
 Development <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf 2/4] selftests/bpf: Consolidate kernel modules into
 common directory
In-Reply-To: <CAADnVQKM0Mw=VXp6mX2aZrHoUz1+EpVO5RDMq3FPm9scPkVZXw@mail.gmail.com>
References: <20241008-fix-kfunc-btf-caching-for-modules-v1-0-dfefd9aa4318@redhat.com>
 <20241008-fix-kfunc-btf-caching-for-modules-v1-2-dfefd9aa4318@redhat.com>
 <CAADnVQKM0Mw=VXp6mX2aZrHoUz1+EpVO5RDMq3FPm9scPkVZXw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 09 Oct 2024 09:39:08 +0200
Message-ID: <87bjztsp2b.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Tue, Oct 8, 2024 at 3:35=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@redhat.com> wrote:
>>
>> The selftests build two kernel modules (bpf_testmod.ko and
>> bpf_test_no_cfi.ko) which use copy-pasted Makefile targets. This is a
>> bit messy, and doesn't scale so well when we add more modules, so let's
>> consolidate these rules into a single rule generated for each module
>> name, and move the module sources into a single directory.
>>
>> To avoid parallel builds of the different modules stepping on each
>> other's toes during the 'modpost' phase of the Kbuild 'make modules', we
>> create a single target for all the defined modules, which contains the
>> recursive 'make' call into the modules directory. The Makefile in the
>> subdirectory building the modules is modified to also touch a
>> 'modules.built' file, which we can add as a dependency on the top-level
>> selftests Makefile, thus ensuring that the modules are always rebuilt if
>> any of the dependencies in the selftests change.
>
> Nice cleanup, but looks unrelated to the fix and hence
> not a bpf material.
> Why combine them?

Because the selftest adds two more kernel modules to the selftest build,
so we'd have to add two more directories with a single module in each
and copy-pasted Makefile rules. It seemed simpler to just refactor the
build of the two existing modules first, after which adding the two new
modules means just dropping two more source files into the modules
directory.

I guess we could technically do the single-directory-per-module, and
then send this patch as a follow-up once bpf gets merged back into
bpf-next, but it seems a bit of a hassle, TBH. WDYT?

-Toke


