Return-Path: <bpf+bounces-33148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09900917EF8
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 12:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AAE61C2087D
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 10:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816E617F51C;
	Wed, 26 Jun 2024 10:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICdP34O3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8250617F397
	for <bpf@vger.kernel.org>; Wed, 26 Jun 2024 10:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719399200; cv=none; b=BDmyM5okp/a8hrZKkrcptZBXjNFQbZPcBBbL5oBgAe1dhRl0Isk0UqVKA1PfLS55MK7YgbMxcOL3O9oywe8oQ+aDXjTHhoVss1mWiQwdboTaxIrJd694j9Rv4K91fwsar3wHEvaXcP+zmsUAljZl11p+l6Efs1DxCr8RGmHqV3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719399200; c=relaxed/simple;
	bh=7x6qoPqkM5JAD+0GrYKIGYWqQMB48EnEzoHEPFAXIBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=owdqu1UnhsHruQxKvAfXomZ+wqVRn2c4uyxz5cAdmtUfj3f/UuQTybY4lGU6jZ25O0wp9AzlIb0j43BBa+Y/kf90dw3g71f3wgdECdS7EfmZ561WtXs23MtnE3NIUACtq/1WcQxyb+ELn1J7KTc5GJja4pXtsQMBd9I7CrpmhKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICdP34O3; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e02e4eb5c3dso5683508276.3
        for <bpf@vger.kernel.org>; Wed, 26 Jun 2024 03:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719399197; x=1720003997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4H6RAaaqEaUYZYrJwM8DXZtH3DktSwuSd3H+eHYf7s=;
        b=ICdP34O3JpDyk7DiGPzvqxi2mmEdRj15MqDvYnUmuI3D9Z71n8NEy1uDGFgOJg0KAr
         7T/TLEAZIgj+z/PViVoNMgAOxINdBWb0C+9oMMzkEuU61Rf3E5fKisx+plymVPOLTxka
         SFhqjJTBZvmPRXzsg/tAwd7Lsu7hyuEcLncdkz5tJ6eDrZsT3HLEmXWBbbytPAIhuqKp
         TBscfVN4dm5MgyDsEI7fy5d0IZId3vlHn53cyQyBxPBteBaW2jAmmaM/DTjolnT04CJ7
         FfrSk/fMoTP8A4zGx4c/HnLsoWZRabesn3vHm6MHc7VVXLc9DdxjvV+hYQIcSUTVtIWB
         ggMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719399197; x=1720003997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4H6RAaaqEaUYZYrJwM8DXZtH3DktSwuSd3H+eHYf7s=;
        b=PMDaC6TTvZIS2w7r8KDCmvqedtBAtLX31YLmCiakkMX8otdhSaltdl4Td7PRv1TtYq
         f8LyvPiWLejDnKMC4ZCdHKep8hXpwe06FSohmcwyTmnXh5UDA5V5LCyHwpS57c8YRpN/
         rJspOXMH5t8QlT8VXcr1V3lBrefF+r59TostWOQ4afyIq7HgxhFGdwb3jC21hAxcukEx
         S/BsYqfm+ahyjXFxzXHyO2+fBYCCjfRfiDxGTPet8NBeY32/Cmmfs2aNDWD3Hz4Lt2v3
         MhYNkf1HDzk/OP6JlC3n0fSkPITp/7NrPuLmuT3C482YacCZNuCIN+gOj50Co2rdoul6
         f+UA==
X-Gm-Message-State: AOJu0Ywm1U1ZzpOoZ+zlwXhQWjTLgZmXAW+xeMGzLOn7ubuZvtsS+9Pn
	ltTGSAQuY3slKhNsxJjEPx2kUkK86m7FJfXvis8L7OojhxM84yfjs8cZVrwAwffwhm+PQ8FL9wS
	2jwwIvocSMjUT0fkIio8STXhOO24=
X-Google-Smtp-Source: AGHT+IF96UAUQ3gkw/mnKELYtO/iWQaQAYL87vaY0glhQOjIor8s8PkbmfCsmHriFTSZ1yrkc9lA4OsgCwfJC59bKy0=
X-Received: by 2002:a25:bfc4:0:b0:e02:c343:ffa7 with SMTP id
 3f1490d57ef6-e02fc2a100cmr11159238276.25.1719399197406; Wed, 26 Jun 2024
 03:53:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFrM9zur6bHTXJha-=Jyq-qYiZGodD-8hf2vMFfjKrnF+ir-Wg@mail.gmail.com>
 <4f2abaab-bc61-4698-8497-f6597ac21e22@oracle.com>
In-Reply-To: <4f2abaab-bc61-4698-8497-f6597ac21e22@oracle.com>
From: Totoro W <tw19881113@gmail.com>
Date: Wed, 26 Jun 2024 18:51:47 +0800
Message-ID: <CAFrM9zv_NXxrcpFw6zCLzNSyNaT_Av1qRmkJ60_fNXgL+YNW7A@mail.gmail.com>
Subject: Re: A question about BTF naming convention
To: Alan Maguire <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Alan Maguire <alan.maguire@oracle.com> =E4=BA=8E2024=E5=B9=B46=E6=9C=8826=
=E6=97=A5=E5=91=A8=E4=B8=89 18:19=E5=86=99=E9=81=93=EF=BC=9A
>
> On 26/06/2024 08:29, Totoro W wrote:
> > Hi folks,
> >
> > This is my first time to ask questions in this mailing list. I'm the
> > author of https://github.com/tw4452852/zbpf which is a framework to
> > write BPF programs with Zig toolchain.
> > During the development, as the BTF is totally generated by the Zig
> > toolchain, some naming conventions will make the BTF verifier refuse
> > to load.
> > Right now I have to patch the libbpf to do some fixup before loading
> > into the kernel
> > (https://github.com/tw4452852/libbpf_zig/blob/main/0001-temporary-WA-fo=
r-invalid-BTF-info-generated-by-Zig.patch).
> > Even though this just work-around the issue, I'm still curious about
> > the current naming sanitation, I want to know some background about
> > it.
> > If possible, could we relax this to accept more languages (like Zig)
> > to write BPF programs? Thanks in advance.
> >
> > For reference, here the BTF generated by Zig for this program
> > (https://github.com/tw4452852/zbpf/blob/main/samples/perf_event.zig)
> >
> > [1] PTR '*[4]u8' type_id=3D3
>
> The problem here as Eduard mentioned is that the zig compiler appears to
> be generating unneeded names for pointers, and then you're working
> around this in zbpf, is that right?
Yes, you're right, I kind of workaround this issue in zbpf.

> It's not clear to me what that
> pointer name adds - I suspect it's saying it's a pointer to an array of
> 4 u8s, but we get that from the fact it's a PTR to type_id 3 - an ARRAY
> with element type 'u8' (type id 2) and nr_elems=3D4, no name is needed. S=
o
> the name doesn't add any information it seems; or at least the info the
> name provides can be reconstructed from the BTF without having the name.
Your guess is right.

>
> So the root problem here appears to be the zig compiler's BTF
> generation. If there are some language constraints that require some
> sort of name annotation for pointers, couldn't that be done via BTF type
> tags or via some other compatible mechanism?
>
> So I think we need to understand whether the BTF incompatibilities arise
> due to genuine language features or if they are the result of
> incorrectly-generated BTF during zig compilation. I dug around a bit in
> the zig github repo but could only find BTF parsing code, not code for
> BTF generation. Finding where the BTF is generated in the zig toolchain
> and understanding why it is generating names for pointers is the first
> step here I think.
Currently, for the BPF platform, Zig uses LLVM as backend. So the BTF
generation is done
by LLVM (https://github.com/llvm/llvm-project/blob/37eb9c9632fb5e82827d1a05=
59f2279e9a9f1969/llvm/lib/Target/BPF/BTFDebug.cpp)
with debug meta information provided by the Zig toolchain
(https://github.com/ziglang/zig/blob/master/src/codegen/llvm.zig)

>
> Alan
>
>
> > [2] INT 'u8' size=3D1 bits_offset=3D0 nr_bits=3D8 encoding=3D(none)
> > [3] ARRAY '(anon)' type_id=3D2 index_type_id=3D4 nr_elems=3D4
> > [4] INT '__ARRAY_SIZE_TYPE__' size=3D4 bits_offset=3D0 nr_bits=3D32 enc=
oding=3D(none)
> > [5] PTR '*u32' type_id=3D6
> > [6] INT 'u32' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3D(none)
> > [7] STRUCT 'map.Map.Def' size=3D24 vlen=3D3
> >         'type' type_id=3D1 bits_offset=3D0
> >         'key' type_id=3D5 bits_offset=3D64
> >         'value' type_id=3D5 bits_offset=3D128
> > [8] VAR 'events' type_id=3D7, linkage=3Dglobal
> > [9] PTR '*[2]u8' type_id=3D10
> > [10] ARRAY '(anon)' type_id=3D2 index_type_id=3D4 nr_elems=3D2
> > [11] PTR '*[1]u8' type_id=3D12
> > [12] ARRAY '(anon)' type_id=3D2 index_type_id=3D4 nr_elems=3D1
> > [13] STRUCT 'map.Map.Def' size=3D32 vlen=3D4
> >         'type' type_id=3D9 bits_offset=3D0
> >         'key' type_id=3D5 bits_offset=3D64
> >         'value' type_id=3D5 bits_offset=3D128
> >         'max_entries' type_id=3D11 bits_offset=3D192
> > [14] VAR 'my_pid' type_id=3D13, linkage=3Dglobal
> > [15] FUNC_PROTO '(anon)' ret_type_id=3D16 vlen=3D1
> >         '(anon)' type_id=3D17
> > [16] INT 'c_int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3DSIGNE=
D
> > [17] PTR '*perf_event.test_perf_event_array__opaque_478' type_id=3D18
> > [18] STRUCT 'perf_event.test_perf_event_array__opaque_478' size=3D0 vle=
n=3D0
> > [19] FUNC 'test_perf_event_array' type_id=3D15 linkage=3Dglobal
> > [20] FUNC_PROTO '(anon)' ret_type_id=3D21 vlen=3D1
> >         '(anon)' type_id=3D21
> > [21] INT 'usize' size=3D8 bits_offset=3D0 nr_bits=3D64 encoding=3D(none=
)
> > [22] FUNC 'getauxvalImpl' type_id=3D20 linkage=3Dglobal
> > [23] ARRAY '(anon)' type_id=3D2 index_type_id=3D4 nr_elems=3D3
> > [24] VAR '_license' type_id=3D23, linkage=3Dglobal
> > [25] DATASEC '.maps' size=3D0 vlen=3D2
> >         type_id=3D8 offset=3D0 size=3D24 (VAR 'events')
> >         type_id=3D14 offset=3D0 size=3D32 (VAR 'my_pid')
> > [26] DATASEC 'license' size=3D0 vlen=3D1
> >         type_id=3D24 offset=3D0 size=3D4 (VAR '_license')
> >
> >
> > Regards.
> >

