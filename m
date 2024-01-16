Return-Path: <bpf+bounces-19693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D3F82FDB2
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 00:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FACEB250B6
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 23:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B96C5232;
	Tue, 16 Jan 2024 23:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3TnVDa2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2D91D68B
	for <bpf@vger.kernel.org>; Tue, 16 Jan 2024 23:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705446905; cv=none; b=ll9xSSKW6QPFPXfaGN1FG4zLTabE34fc8HaA9CF82bBvys3ZH744Ax1nQ5YDfqzBURezhrynxLz/lmL1vKu1/rV/OoAO7Uc7P7RFymF4ieJeccvQhD24QPbxOK3z4mUSvbMNnk4idzqDb156lrBr+SXrtR0rbt50w0rUcGNoG8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705446905; c=relaxed/simple;
	bh=/afTRlcM65OpbW9PuDzNp+BQWpR8b9v81Ck9pmYDyO4=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Autocrypt:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version; b=Y75jVjokWPy3yZMVqdoFxmaSobjNClCqylP8fUUlLmHqXbNFKwSp4ohRl6wfR+lF5TTPj5XysxJSO+qkITEz7lgDii1IkFPJkAINfFgtLzcUjEX0Md1N/Vw+SWWRHaadSZPLsAm7qXCjti99uSQGbLc8hPQV4aDlPpuFmkyd1eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3TnVDa2; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a298accc440so1280253966b.1
        for <bpf@vger.kernel.org>; Tue, 16 Jan 2024 15:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705446902; x=1706051702; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/afTRlcM65OpbW9PuDzNp+BQWpR8b9v81Ck9pmYDyO4=;
        b=d3TnVDa2cEY0RYNOGy2kY59/yIAC52XMfGonIXRyIjSKYzJWhDtsg8nglRQA1/76h7
         7I5LJdH3nRNYLOGakDNnMWroLqh/3GVbXyNcjgLgrfLsYKu3AkPOv+t1K7/XfcKcwmCS
         3WIKkLcUJjNg2UTu/jzQpIl8gMEzzjUHi7qzgWtYETy8CRsFguq/am2BXGOkQ+rwhwPl
         MwZE94c9ozs3EEzdICiZpl7ID1kRab27JM/QMijV2bpEm6w61T1ANcAtwW89u0uetukR
         SqdnA07kSPaWtmX901KLTgg9onlko8sm5oGwOJmZLNdK/ztonZ/yjLy69WJYNZKH3jAZ
         iOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705446902; x=1706051702;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/afTRlcM65OpbW9PuDzNp+BQWpR8b9v81Ck9pmYDyO4=;
        b=nCMubNAC37xniIHAjEVhSZ57QRJ5y6YaKQIlK4ISQQhAnVs067TWPxzny7wc7UVFDK
         GSICfPsqZCi6qVhRdOGwJ3xnRS5OSVlMAruOeInIfajfTAHSc6AYlefrmjyjneu9O4KP
         szF+bQ8s3nyMd+JebiskGSeQUfrPRj5F2xoA+DgfvG3nU0SnXxO7NKr3rZmaxdlBJeDo
         TW/Wvd/cAZgBAWpwtIHxJpG/4FPqqbaFqGIF6S3eZ8Gnnvjplv0YJdFa92udGWiSdN9W
         kUcvVUsr8WQ1/eiYnnKxS75mAzf/8lFt6eT80bNCeFkwN+BYiSufihjhSPMFpjW7UVPH
         fIiA==
X-Gm-Message-State: AOJu0YyoTR2m062AH/z1OPEIqSRnohg/Lbdo1GsE5E1WNKXQZA2YlpWe
	0ws8FXLGVLfeOpxzaDaoGUo=
X-Google-Smtp-Source: AGHT+IE2uEqf9jvmA2yGhTOlKIj0/4LadvnQxmqKsgA32TmSk5lgQSVqDBT19RSP4+As+tGekurHeA==
X-Received: by 2002:a17:907:a4e:b0:a28:7fe8:8b29 with SMTP id be14-20020a1709070a4e00b00a287fe88b29mr5044292ejc.68.1705446902139;
        Tue, 16 Jan 2024 15:15:02 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id bv9-20020a170906b1c900b00a2bfd60c6a8sm7001062ejb.80.2024.01.16.15.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 15:15:01 -0800 (PST)
Message-ID: <5b1caa7f70400e897bafcff489fb9c461f62db98.camel@gmail.com>
Subject: Re: asm register constraint. Was: [PATCH v2 bpf-next 2/5] bpf:
 Introduce "volatile compare" macro
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: "Jose E. Marchesi" <jose.marchesi@oracle.com>, "Jose E. Marchesi"
 <jemarch@gnu.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong
 Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>,  John Fastabend
 <john.fastabend@gmail.com>, bpf <bpf@vger.kernel.org>, Kernel Team
 <kernel-team@fb.com>
Date: Wed, 17 Jan 2024 01:15:00 +0200
In-Reply-To: <CAADnVQ+57cJ_ChW10jAwvxV03Tctx1ytMPParVocSYYxGuY5PQ@mail.gmail.com>
References: <20231221033854.38397-1-alexei.starovoitov@gmail.com>
	 <20231221033854.38397-3-alexei.starovoitov@gmail.com>
	 <CAP01T77fbW-9N+Z-2LFS=174HN6v_OJAbR_s6EOfLLW8Oceh_g@mail.gmail.com>
	 <CAADnVQKY4hB4quJX_oyq4GULEJkehXWx6uW1nAYHveyvdyG8sw@mail.gmail.com>
	 <CAADnVQ+tYBpt_aRG5aU3sAYEysKxUOKQ24dBG4bP2kLy8nmmgA@mail.gmail.com>
	 <44a9223b6638673487850eb9d70cc01ef58e9d93.camel@gmail.com>
	 <CAADnVQLmXxn9RrniktuW80XO14oyOmgJ_NboBBC_-CU4O=-v9g@mail.gmail.com>
	 <87h6jm6atm.fsf@oracle.com> <87mste4sjv.fsf@oracle.com>
	 <878r4vra87.fsf@oracle.com>
	 <95388269687be49d7896a881eda8aa3bb89e40a4.camel@gmail.com>
	 <CAADnVQ+57cJ_ChW10jAwvxV03Tctx1ytMPParVocSYYxGuY5PQ@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-01-16 at 10:40 -0800, Alexei Starovoitov wrote:
[...]
> The changes to all three make sense, but they might cause regressions
> if they are not synchronized with new llvm.
> cilium/tetragon can control the llvm version to some degree, but not self=
tests.
> Should we add clang macro like __BPF_CPU_VERSION__ and ifdef
> different asm style depending on that?
> I suspect this "(short)" workaround will still be needed for quite
> some time while people upgrade to the latest llvm.
> something like __BPF_STRICT_ASM_CONSTRAINT__ ?
> Maybe a flag too that can revert to old behavior without warnings?

After my changes selftests are passing both with old and new
constraint semantics, so such macro definitions / compiler flags
are not necessary for selftests.
(Although, I have not yet checked the codegen difference,
 so the absence of the "(short)" thing might be visible there).

As for Cilium / Tetragon: I checked verification of the object files
with both LLVM versions, but adding compiler flag might make sense.
Maybe compiler users should comment?

