Return-Path: <bpf+bounces-73110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0A6C23846
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 08:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0A8318981E3
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 07:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBC345038;
	Fri, 31 Oct 2025 07:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="geA/hab5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62F21FF1C7
	for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 07:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761895009; cv=none; b=Ic+HYIhpemJdiZQ9MNuCiSYiKgzBXwEgNVBj9WCbaVS8UDSfmBvwL6E90mFivmRsG9iJXeJhl4F7KC8FE5BN2BVwAXoZGT9UK5AoRTXD22ZsqDp9g1Tf15NrWR+SuB2N4fviP+wNgWQjekHoGJYkA6BdSADznXLRSSjuQDLPaB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761895009; c=relaxed/simple;
	bh=Vly4q/+fjEFA0Gvb0YnNMpF5OHTfP8EDgsNefR1fj/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0MpwSjYYRvUhYjQThtILJrXlw9ecSKR3ZWHizkiRwL+n5MDH5CSkPZLk4hv//ymEy+pzJQv4KLAiWzi1AWOpXYssRdvILmV9trCT/uXus9oOXiy6VOZ3Xk1oMcGDOqiny5yOB2VD8vVgYN84Y7pWm1fJ7U3bRbZp0EgEs/Hw88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=geA/hab5; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-429b85c3880so1724522f8f.2
        for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 00:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761895006; x=1762499806; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mzqltOJWaCS/8huAd/V73dCSxqRmhZ7JwPQqZdG9BCI=;
        b=geA/hab5NvmUsxRucATAuzMGK6Ul/HqCW5/UzmKCz3qrth5ULHdcJcuSRyN/6Kcuo+
         7RiKFbbhg7NOcOrePzwpUnH0s9yLl/FkpGmOwtwX3KPw8/OISnuVVzDLc9i7u4dwp+Yj
         Q4t9NIyxNuge7HbfDYLFaPNyTLGsEgavpsmHYH9wnm7dCqHO60Wp3WgqUDuWmfF++zSi
         WtbSf4r2BQW1/ET97bdr9Nc2ErWvXcp/pqc5inXt0j+wczB0N1Q9uVIJEcIJvgqOHmpK
         p52pg/LITZzIGEzrRcN3/GgdWiwgQJ/4C87+3OK5slMiHv/osGE+6gZMKM9EXNCrczYR
         wuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761895006; x=1762499806;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mzqltOJWaCS/8huAd/V73dCSxqRmhZ7JwPQqZdG9BCI=;
        b=ZE8FPRzv1gMSNhRV2T6OnnIXwzdTsjdOElw/SUPPpmRba3vAPXZdam7rHm43tqqat0
         CLkpBB7RaB1XY45QN7ihOpTKxIPGs9Pnz+Hpt18nrvkdy3OdanWwei4G7IJOd7ySQ8pK
         5QAbAayRCXxV9oVMX2sjrUxASrqTJ5t2Q4IFhMw4Qn5SbUMESycoDTayl2HJmDsD3Oqh
         kZ+M4al5YIJAQh9RO9l8H6TQUivWD5JLoVS93xxX/eGX2ZJqhGsEA3L9ijS6HLcwQj1I
         Jtw2Bs0VWQ+AGoMxYxiBb3jYSSX7VcO01/4I/1S3BpgQDF9a751QhLAfXGoOUQv2zdgI
         p6Jg==
X-Gm-Message-State: AOJu0Yxyd0/qWTU5y87N28VIPCP3uEo7SccelGkm+9Jtvf4Kl1YrB5DA
	9c0L03GwvUOI6escVdCLdMl8ZVbG6WeVjQ7orJsgUPGPX3NjC/nqWlcv
X-Gm-Gg: ASbGncux2Yr9guCBKxHmT7z7dQBUZPtNYE8NjhPq+HAHuC+gx9QDA6TK8ZLo2iQ6a1k
	oidSXiaUDDtrzqf9avSpEWQOrVTEtADUagYG0mQ4IyUBKgIggLr5wDz43nvHgjT30/CHb4VJxSq
	ZaIo8GVYigSFATYv5HEEkMO6AWXIvxZibqsH7MB0p6ehtI9SjEtu7aksUVCskilrKI60GhUy2JI
	yNhd1SraMSpOzzCktd2Zg4pieWgfBhaPLs2G7fPR4+FjP4rivpBkCf8bMZGV67Zab0zeLctn7s4
	UrDYOgn7MqOb6o7cpif7d5HshZ+S0H49yoa1Qz/9joBrStRcTPl3QAXX8dtddLayhJfXmJ8Hxjh
	zBHpjPLRc4plF2khGEQEugDiRvGf69KH3v2p7QeDdpDGAX4X6tVrKX+pXkQnYXOKNQ15XCI8rqY
	T9e72ghKx8KC2oFY7ZB/9h
X-Google-Smtp-Source: AGHT+IEYwdgcisWvS8vYtXefkTcxIZeEbax9ETaXjCIXXyWSBQDIoHO1gURbatU06buTwMs5uBcw0A==
X-Received: by 2002:a05:6000:43c5:20b0:428:4004:8226 with SMTP id ffacd0b85a97d-429bd6a6626mr1498675f8f.34.1761895005902;
        Fri, 31 Oct 2025 00:16:45 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c1142c3csm1918395f8f.16.2025.10.31.00.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 00:16:45 -0700 (PDT)
Date: Fri, 31 Oct 2025 07:23:13 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v8 bpf-next 01/11] bpf, x86: add new map type:
 instructions array
Message-ID: <aQRj4bxjbrECVIb9@mail.gmail.com>
References: <20251028142049.1324520-1-a.s.protopopov@gmail.com>
 <20251028142049.1324520-2-a.s.protopopov@gmail.com>
 <CAADnVQL1nznRsfdSgFPxSf1Rdhq7hpQMcmT7BKaRn9KHwD=P6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQL1nznRsfdSgFPxSf1Rdhq7hpQMcmT7BKaRn9KHwD=P6A@mail.gmail.com>

On 25/10/30 03:50PM, Alexei Starovoitov wrote:
> On Tue, Oct 28, 2025 at 7:15 AM Anton Protopopov
> <a.s.protopopov@gmail.com> wrote:
> >                 }
> > +
> > +               bpf_prog_update_insn_ptrs(prog, addrs, image);
> > +
> 
> I suspect there is off-by-1 bug somewhere in bpf_prog_update_insn_ptrs() math,
> since addrs[0] points to function prologue.
> addrs[1] is the offset of the first bpf insn.
> See how it's called in other place:
>    bpf_prog_fill_jited_linfo(prog, addrs + 1);

So all the maps I have in all selftests tests point to a wrong ip for
every goto, and still work?

In fact, addrs[0] points to right after the prologue, see how it is
initialized in do_jit:

  addrs[0] = proglen;

here proglen is the length of prologue. The loop in do_jit startrs
with i=1, but all addrs are referenced with i-1:

    case BPF_JMP | BPF_CALL: {
            u8 *ip = image + addrs[i - 1];

The bpf_prog_fill_jited_linfo internally also does the -1 thingy:

    insn_to_jit_off[linfo[i].insn_off - insn_start - 1];

> pw-bot: cr

^ will send v9 in a few days with minor fixes pointed by Eduard and Andrii

