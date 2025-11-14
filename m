Return-Path: <bpf+bounces-74530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A86B1C5E718
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 18:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB6E04F6B6D
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 16:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFE1334C16;
	Fri, 14 Nov 2025 16:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSVCwSij"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4926334690
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 16:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763138152; cv=none; b=T5miS4Qnxmb/+3HGWMeSLTCjvO1UOrF8ADzcKanZUQZ+8f7yD/vpMAL1Z9+SRiWM7nn6/zAFO/u2aqRKcPwtp7Knd/NNGx3r8WcT2eFO96R5+nEfiAS3C2nJK2k4JrecdcvFzwd8og5E7vFDxZpRFQeytkcMLlqgKl7I+zAiSUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763138152; c=relaxed/simple;
	bh=Xl5QLaKsroUW9SF19pUajhBIIA19ziJQBnwwtRl/LFg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Z831Xzf84Tn3OjVTTVXAjQR6iWJIAqOgtjLiWkvBpFwswNQWmTxJhXlZl2G8R6XHIPUzl03eRZ/To8mZUu09CEjcXTWcIXA59h/PZkTS9X/0IdswyP4CdU0GxFrkEf3eNNiGjbhb7B/fpgTEc4hpR97Lcze2SWCcGlhsIlKrzRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSVCwSij; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4775ae5684fso11744775e9.1
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 08:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763138149; x=1763742949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AejCe1AnGKxMQwM42EhlGVlRWc2gpkzytD6b1teK6Bo=;
        b=DSVCwSijmwj3QRBXRVCgdxub0m1cA1iipB9CpbU40g595aRFEnLIkKcEp2tTUVFrNP
         hPhz/dAGUiAxlcmIp514sEXy9OM0b2xCPYQ9OO+jrFHfpfIB8B27i+/kTrHmV/cRqBhF
         nHSAWIV//kZU3XImkc0WzFKQ4gxh2OIXgPdc6LbSHF+/M4aNpjBtQKukBz3G7e/rbTYL
         DwUz2v8hX/12Qz99Fn8C8YH7KTqEBQpmp1fIaHZpsRQ98G1bgKmxBzwayVDMesFg52OJ
         yR4bwc7PN3oHmuoT0gw8bA/zIiMV0S4znfqzvOlJtny5U/JDKwNv2YAOHbW3l0Bh6xh7
         jS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763138149; x=1763742949;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AejCe1AnGKxMQwM42EhlGVlRWc2gpkzytD6b1teK6Bo=;
        b=g8BmxChkN6gpVDUJro8ddK+mMPA7pYD8NA1Li6KoNErKDGAlKtRNQmfOXfUpWjhv5H
         vwyychJtcJz3449BYRwGBhqqxsXVVRZgAV/Kfdu/WObnQIjkFgZuWKi+c/WGfCvRB0Ip
         lKtdtYnonxjRwhkXlPuxrcom3IIH9jLChzvLass4n/2MOiWVsR/LKvDtBoyA/qo6Zf3p
         tpkad4WqZVsm4uea1ynbyRTQnPkAjBUkyZrCENW8MV8nfvOsH/PhbOp55/2gAnVmBhR4
         BVGh1edHObf8f3aJnZx+F/+pd2f4xdgZ2lg2uX56zhr7RlcWN9XZBGCXCH+OXoj3rf9e
         SCCw==
X-Forwarded-Encrypted: i=1; AJvYcCUaoow0T1UpVJi6qibXQFiZOuzuPuJIBpA94Yq1XRImwnav0aFN9xOCHPndpjOrOSduu7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrX3QH0IOTKV382Z40dODf5Im1HMgahRgSHDoPKtLQOEk1f8B6
	Q2WX3wziJEU/F5kPDOpSPnloJVvag2zjSBoFvcHxfZOAM7dMT3W7Dq4W
X-Gm-Gg: ASbGncvJX2X8BL3lwR/v2ZqdOfaQlZ169qvKD0SsxWgXWrPpQqPEPaBb2s5hFEgcDbr
	MOqSZqhRdAzpHv+zcRvORXq9FeZvEn+WWf4fL1vO9CSfEiCl91bJh9TYg8dMMN3bwpZnQ2IC4M1
	KPJmhrmWdgeY6//PGA/DBltHlmysyZNVC8HjYI8Lb2kW2DLN38yUJra5Nk2EWctEZ/W7Jug2Zn2
	byBYy291go5nYcF77EufMMyYzp9PkNbmpsrNnZPYX/Sgj+dG5r/6ld1pP093VBQsB2GagFEO4ln
	NMO2WstxVDeCs3lZ65a3cyVD8lihZRWkeqrs7yRt0AWVdTO+NUpRGWyH/vEPiBnkN0gbxLq3ppG
	mxbgakjC9hD6yMZdLpqVQnZRRDAbtKAoflqQBLVwBGFbTNFpG6SoezdpNnMQLSsGpNH6wcXhPXM
	Rq1dWYXKOVzZLp2Q==
X-Google-Smtp-Source: AGHT+IFMxw/E0WMI+4r7Mu8aYWkB0mKLGicLqcZxZdWHoTwMNFrrH0PnDmIhtP1/6Fmivx7ublS0Pg==
X-Received: by 2002:a05:600c:6289:b0:477:54cd:200a with SMTP id 5b1f17b1804b1-4778fe50f5emr37643355e9.6.1763138148870;
        Fri, 14 Nov 2025 08:35:48 -0800 (PST)
Received: from ehlo.thunderbird.net ([176.223.172.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b589sm10547445f8f.23.2025.11.14.08.35.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 08:35:48 -0800 (PST)
Date: Fri, 14 Nov 2025 13:27:46 -0300
From: Arnaldo Melo <arnaldo.melo@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves <dwarves@vger.kernel.org>,
 Eduard <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Kernel Team <kernel-team@meta.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_dwarves_v4_0/3=5D_btf=5Fenco?=
 =?US-ASCII?Q?der=3A_refactor_emission_of_BTF_funcs?=
User-Agent: Thunderbird for Android
In-Reply-To: <cf503462-6616-4cdc-ae63-b126b28ae66a@oracle.com>
References: <20251106012835.260373-1-ihor.solodrai@linux.dev> <520bd6d8-b0a1-40f2-a674-b4c6ed02e254@oracle.com> <CAADnVQJj6EcntgiAm6Kv8FJvP3tQcG=EzWt-uFuzszHtcw4gmg@mail.gmail.com> <aRaPnq2QJN1iFF_3@x1> <cf503462-6616-4cdc-ae63-b126b28ae66a@oracle.com>
Message-ID: <136B81FE-DD5C-4B3D-BE61-1C8912428130@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

7

On November 14, 2025 12:40:36 PM GMT-03:00, Alan Maguire <alan=2Emaguire@o=
racle=2Ecom> wrote:
>On 14/11/2025 02:10, Arnaldo Carvalho de Melo wrote:
>> On Thu, Nov 13, 2025 at 09:20:44AM -0800, Alexei Starovoitov wrote:
>>> On Thu, Nov 13, 2025 at 8:37=E2=80=AFAM Alan Maguire <alan=2Emaguire@o=
racle=2Ecom> wrote:
>>>>
>>>> On 06/11/2025 01:28, Ihor Solodrai wrote:
>>>>> This series refactors a few functions that handle how BTF functions
>>>>> are emitted=2E
>>>>>
>>>>> v3->v4: Error handling nit from Eduard
>>>>> v2->v3: Add patch removing encoder from btf_encoder_func_state
>>>>>
>>>>> v3: https://lore=2Ekernel=2Eorg/dwarves/20251105185926=2E296539-1-ih=
or=2Esolodrai@linux=2Edev/
>>>>> v2: https://lore=2Ekernel=2Eorg/dwarves/20251104233532=2E196287-1-ih=
or=2Esolodrai@linux=2Edev/
>>>>> v1: https://lore=2Ekernel=2Eorg/dwarves/20251029190249=2E3323752-2-i=
hor=2Esolodrai@linux=2Edev/
>>>>>
>>>>
>>>> series applied to the next branch of
>>>> https://git=2Ekernel=2Eorg/pub/scm/devel/pahole/pahole=2Egit/
>>>
>>> Same rant as before=2E=2E=2E
>>> Can we please keep it normal with all changes going to master ?
>>> This 'next' branch confused people in the past=2E
>>=20
>> I think the problem before was that it sat there for far too long=2E
>>=20
>> I see value in it staying there for a short period for some eventual
>> rebase and for some CI thing, to avoid polluting, think of it as some
>> topic branch on the way to master=2E
>>
>
>Yeah, I think if we can augment CI to cover more we can narrow this
>window, aiming for zero as the test coverage improves=2E

I slept over this and think that is we can have the CI test patches direct=
ly from the mailing list, doing AI reviewing even, then the next thing can =
get a good riddance=2E

 The other thing
>we should think about maybe is syncing github=2Ecom/acmel/dwarves with
>pahole=2Egit as many people are pulling from github=2E Should we discoura=
ge
>using the github repo, or just find a way to mirror pahole=2Egit
>automatically? Thanks!

I think we should create a GitHub=2Ecom/pahole/ and have shared maintainer=
ship, will look into that=2E

Meanwhile, today, I'll check what's in next, test it and move it to master=
 both in kernel=2Eorg and GitHub=2E

- Arnaldo


>
>Alan
>
>> - Arnaldo
>>=20
>>> I see no value in this 'next' thing=2E
>>> All development should happen in master and every developer
>>> should base their changes on top of it=2E
>>> Eventually the release happens out of master too when it's deemed stab=
le=2E
>>=20
>

- Arnaldo 

