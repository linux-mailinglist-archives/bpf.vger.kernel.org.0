Return-Path: <bpf+bounces-37884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0328B95BD20
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 19:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32B9A1C22AB0
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 17:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025601CEABB;
	Thu, 22 Aug 2024 17:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Po+FjjFJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4820E1CB33A
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 17:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724347653; cv=none; b=qgPeSxErLSeG2b0CF4q6ktM+wjHE6cvnFMDulJJUQZ7S15zjaAj2xDBEGCxOrSgq82JkGbW6knN7xpbIvUfb19dbWZ06zdHANtfXE/juTVcuTtlPM1fXawUqLzImEZf88Vl2/pnF92ib4dZDKXqq6hPNr2UlaYTyOncKzuG/wGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724347653; c=relaxed/simple;
	bh=7uA68/I+gyz9U4UAmAfDCVluZGNV/3tH0uCGDilkARY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rHwh4Lj+mvafEvdELMHQd/1rtJIV7JmcbFAqhDBur83JhsSW25HyV+Vh/C/deRSWfJwLCGEco55HF0OMK0Vch8O2bmxBXIkHJN3i6b2BAyIHvmXwh8VnhBxsQW/ErAWGIgxDBaLUwVkfuAOuMr5dyWHUzpkkSFbS6VBOysvaodg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Po+FjjFJ; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7c1324be8easo1576855a12.1
        for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 10:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724347650; x=1724952450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7uA68/I+gyz9U4UAmAfDCVluZGNV/3tH0uCGDilkARY=;
        b=Po+FjjFJpSTT8AbNTaUq+89nvYAtoFDQGcgNdkPE5MH8UaEJ2ypvsx24UBa/Oj9YEo
         I2aOqcNm5f7oAHvTTA7aqSC5n609gk5luLrmL52pRyTZ/io0BuLqVmd1L8sUxwE66as5
         fu4TFsDWaJdfyL4xRGrRbtCOwrPSfQEr7e92aDo0nH0J5ILhYyPZU/J9FgrPaVKhgbsM
         cRWaLaCXGAqZWghMaRB5do0bQPEatyf9Sj+drNwDKaz7hqBFkbnS/JI5d789vDnZGFzp
         LQzIYvX7lgNBIBp2a9KB/QuxqmdGGYP1+88Hy8BCMgvQXbdnpy4sfOrGXBiNPUT4WznX
         0PRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724347650; x=1724952450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7uA68/I+gyz9U4UAmAfDCVluZGNV/3tH0uCGDilkARY=;
        b=p20LdqgYtpEqj+qMl8JplAqayp0yuB6EihxNi1jzmEYVssWMZDu3koODLI6FOWB+Z8
         7SqVsPGPlb8qZ/yH/A8ZBJTriDO8uvf8wOLgLUFrRyO3gxqarJTO0xmBQ/iH3eTIo/SX
         Bb4NvvFp722W+STJDmLR6AOybNW97XreuRSvReQEJOpchz1epzgbeth2FiwwqGaGEjr7
         oFUtRhuAW1wlJbi2DRHpB9P7yzKN85zqhKynTa4Yiuyyh+6cDSQgCsv4lldLuFjHxR2o
         osXQH1peglZ1fXI9XpVDY8g/OMxubbm7HuBxlEy+mofqt9aPCRh3cXi4iUGymMQqjWnj
         tKqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuPf5dprIKEurwuJr54wz2I+0A+y3YYYqZa+MfTtNB4YOfX1/ntJLhqBeAWgjFacPiVek=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvsvvjhlNF09mhsNFUwG3OCMioTU2ZhYbErAZZO506Wpoo5Ce3
	2/hkyRlI9I1Z2BTj5vduFFJ07R3pXludsxKhGy1fkZhUivW0jrGrca0X1cTKujRB5QniaoV4gLK
	XKsoAn05R/yFjEaaln9thBd+OTH0=
X-Google-Smtp-Source: AGHT+IEBZGZSsPxvc3XUwvNvBpJcagtxLs/+LL29pvJ9zQb0CZkm7/YatsnxUgOKDDqVlAfNJiKPhrxJzitxKnVKiD4=
X-Received: by 2002:a17:90a:4bcf:b0:2c9:90fa:b9f8 with SMTP id
 98e67ed59e1d1-2d60a99f337mr5502167a91.10.1724347650428; Thu, 22 Aug 2024
 10:27:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822001837.2715909-1-eddyz87@gmail.com> <20240822001837.2715909-3-eddyz87@gmail.com>
 <CAEf4BzaVjrHSi9eh9-YP37tsH2B5n0ah3m290Y7_v6zBXrEBiw@mail.gmail.com>
 <b058840690d79648405839c2af767a783a41bef8.camel@gmail.com>
 <CAEf4BzYK9JpdPonHhSARkLRbStMA94URxZ0r5fpaOg693jtLpg@mail.gmail.com> <CAADnVQ+umPO=jSqv+boTqS_-r_PYJyzhVms4438SxeG1hN0GFA@mail.gmail.com>
In-Reply-To: <CAADnVQ+umPO=jSqv+boTqS_-r_PYJyzhVms4438SxeG1hN0GFA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 22 Aug 2024 10:27:17 -0700
Message-ID: <CAEf4BzZ6GZJWiy0+R3y3dtEjSeN9PK=BM2HozndP4C7M7cAGMw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: test for malformed
 BPF_CORE_TYPE_ID_LOCAL relocation
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kernel Team <kernel-team@fb.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Liu RuiTong <cnitlrt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 9:55=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Aug 22, 2024 at 9:51=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > > > I don't see why we can't extend the bpf_prog_load() API to allow to
> > > > specify those. (would allow to avoid open-coding this whole bpf_att=
r
> > > > business, but it's fine as is as well)
> > >
> > > Maybe extend API as a followup?
> > > The test won't change much, just options instead of bpf_attr.
> >
> > yep, follow up is good, thanks
>
> I don't think we want this extension to bpf_prog_load() libbpf api.
> This is internal gen_loader use.

bpf_prog_load() is just a wrapper around BPF_PROG_LOAD command of
bpf() syscall, so it feels appropriate to expose all the available
kernel functionality, even if libbpf itself doesn't use some parts of
it. Those core_relos fields are there in bpf_attr and are part of
UAPI, what's wrong with making them available in low-level API?

