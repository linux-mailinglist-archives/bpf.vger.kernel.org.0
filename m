Return-Path: <bpf+bounces-35245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 335B093934F
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 19:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AC8F28208A
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 17:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2B916EC05;
	Mon, 22 Jul 2024 17:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G27ltCv9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7819316C864
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 17:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721670709; cv=none; b=NHQ+l5e/feB6Xl9+c/jhCbZ3EWPnjg8UEgf++BzJ30fCFag8+mZWq5goxsyT4XGT3hyRDVuuJArY4kKJwg2zWWKrUy0A8YCpFdHpV09Y/E9UTrdT3pE+KvTP6dsiggtVOxFD6JFjRGm3lLC51dvYKav6kHu661Xt4fnEM7WBMVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721670709; c=relaxed/simple;
	bh=cmF5DEFKI8z1rSVCGkBt58tN+EEwVFzLp0IKO0V7Vyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SiCoPBPVuvVNMao7qa1Golk60LH8r16owz3w5g11TPVtHT7graqgdj1LrRCLV2qg1ngWpwNUn3oEP3zeAycr3xyBu4hlE5cBa877L6EpztlbjX50RLmFFlWafmnOGlnmNl3HvVuUZ3Qf8eKQCor7QzmMq/hETcUZhZFcHJLvNmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G27ltCv9; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-36887ca3da2so1953254f8f.2
        for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 10:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721670706; x=1722275506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6tnaEM6coNoEk88BKzMcb5O4I8SAaipUoYJhnKkdsY=;
        b=G27ltCv9YOytjNSsEXs/ha23vVZmi0Jtrk6TX7W1Z+AS/S9XynWtLDD1bweErF+grD
         0de23tKQqM2HgV59QQGHVIyXyZRkMkUeijGTJuCjz/60CcgH7BV/MmCiz7p99uGDLbYV
         NDs3607mvFeB8Cqamh1aIU7XP2CyRkZOxCES7VwLZ4RqpUgdqlFcaIydrH9D5h5pazoV
         SFV8RYx8tChPNcK8nZi39+ta4LsrZD1aSYjZsLn5i7OAHVOJHmd2UoZS3jex13QrW8w3
         boG4+YytWpa2cooYU511Mo9YFYpYnHLIMAYdEMU8EI/k4xtGRe2QYnwK3fYn0kTH2oTP
         WzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721670706; x=1722275506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6tnaEM6coNoEk88BKzMcb5O4I8SAaipUoYJhnKkdsY=;
        b=qXTzTY+ZxEoQRVzm9LVSBCtXQTFGBaClgnyDyQKuS1HdIBhkt+nugHr3r81iHKtMWQ
         etOD7KYTa2GgV19E7mGQcDCXkjYlz0+wuvAaGpraLW77FgEGDKG3wNkzV7fDIFsEf1dV
         0nZ29anyOQc4P6GJ3gGqyxHbqJRPQD7BytS+UCafx8qGZWxfoDlUy/fi8dffPF01gtAL
         07Xr8NoNjy/CLKvhJ4cP1eMoUctRtd/28YqrARMNjs7+1qDxvwLi2vOTVMFZSyIk19Px
         944k/OVeiFuJskkDOBzeDX8H733fJBOwUQvpdczHXZXHoMsk8lwn2Z9KIEcRoO/JLSZd
         Xm4w==
X-Forwarded-Encrypted: i=1; AJvYcCWm00tc2CxL0/FLqUZsazBCmbCpQlsfDU5UpqVbmVl7b1oFCny63jWUEStfZyBzqzjRJLDnTlhh+j758nGVHMLXdltu
X-Gm-Message-State: AOJu0Yzs7f7SeSdHCWSYYxDcaK3Uhx0AjHtAtqQU6wVjjD40JQdWypfr
	kxas3HT0KEu444kaCuEPEY/UJURRqcA91qGfQuNRLgfxy4oes3htxQdepSW3vhx7DGaoShFL0n6
	l7sxwqZZShEIBvG/zIL8kE5b++/E=
X-Google-Smtp-Source: AGHT+IEGTh+mZtTv0oisgdzDQIbyxGb8SsGIlzYNJpQuLMNgPNqiLaJVi09SD7lLywiXy73d4br6hJllapfIbGIV3Vs=
X-Received: by 2002:a5d:4d41:0:b0:368:6f64:3072 with SMTP id
 ffacd0b85a97d-369dec047f5mr434962f8f.7.1721670705660; Mon, 22 Jul 2024
 10:51:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718205158.3651529-1-yonghong.song@linux.dev> <86b7ae7ea24239db646ba6d6b4988b4a5c8b30cd.camel@gmail.com>
In-Reply-To: <86b7ae7ea24239db646ba6d6b4988b4a5c8b30cd.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 22 Jul 2024 10:51:34 -0700
Message-ID: <CAADnVQLJrCv=2QKRr0g=cL3DzDBw5=tO=ufrA21KK-go-_y+Gw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Support private stack for bpf progs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 21, 2024 at 8:33=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>

> Aside from testing I agree with Andrii regarding rbp usage,
> it seems like it should be possible to do the following in prologue:
>
>     movabs $0x...,%rsp
>     add %gs:0x...,%rsp
>     push %rbp
>
> and there would be no need to modify translation for instructions
> accessing r10, plus debugger stack unrolling logic should still work?.
> Or am I mistaken?

It's not that simple.
Above sequence violates -mno-red-zone.
The part of the fix may look like:
movabs .., rax
add %gs.., rax
mov rbp, qword ptr [rax - ...]

mov rax, rsp
mox rax, rbp
sub rsp, ...

it's probably correct from mno-red-zone pov and
end result is maybe correct for stack unwind,
but if irq happens in the middle it won't crash,
but unwind will not work.
The main reason to use r9 is to have valid unwind
at any point of the prog.

