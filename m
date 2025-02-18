Return-Path: <bpf+bounces-51844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D754A3A44B
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 18:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD99F3A72B4
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 17:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8165226FA79;
	Tue, 18 Feb 2025 17:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jc3ajDCW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630B526F47F
	for <bpf@vger.kernel.org>; Tue, 18 Feb 2025 17:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739899597; cv=none; b=emS+qmKrPZrn+GmbjjOqfcWFpS4reAA/6uMFfpn0O0kxh6jKCgd1ViptQJhQJ44+kUnL/dWaJ0TugzHf+Z6Wa94kUtybpz5+qwxmTnAjzISC6Haxj32oIjBDN0lziAOJl6H9mr8g7b+7Qifwdwn4L7cOeM2hNHnneqtTLZh6aJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739899597; c=relaxed/simple;
	bh=Zrtq2iXJ1R9zrJjsGbg0ai3Opiay/ms9rP+3OS/dXNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FoAyImBA0VvJXorZrUJr6a6i4J8Wx6b1bAriItL5xe3ZmAKH08F52cJFkWXLTCZnNf/5ONLm6/e+TOYia3k6jyuErHHjVvOpvHnlxjB7WIyZ8rqjUXFJcRISqzm50Dfx8TeZjochqdEW4YXAuReiTyew77MBrceCYTXxRutBixY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jc3ajDCW; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so10651911a12.1
        for <bpf@vger.kernel.org>; Tue, 18 Feb 2025 09:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739899594; x=1740504394; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rlxHU4KF9LeyT+OFIbxItV22nV0X9vCpKs9TWYeCEnY=;
        b=Jc3ajDCWsHNyeVOwsLIbE08U+TTI8Nyd1UoNn97Gk7bxJS7l/dLe1XQiggiG+t0mh5
         KcY/9l+CUsG91GI3pcgfEozJaWxBjw6HVMrIIK9zlenUaNDOdOnMbgybCRsmliT5e/w9
         2zwH17IuQqIb7KQaVWo4n935cRxs9H673ienoQ8hSPKMQxWXTHbQKIo4b3SEhyD8pk43
         8y86ynGh6teBfZyYl4hPYh20RjUZCMVunpPdXyemcwldV1F4HilmPlC0BW4w3l/gQ1zV
         /kHHStP7WesluEZtX/vpY4Bru9GiPiAiKVnvgzFEy7Qeytd2PjVMyLptSXBjGhsn2CU1
         h0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739899594; x=1740504394;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rlxHU4KF9LeyT+OFIbxItV22nV0X9vCpKs9TWYeCEnY=;
        b=ddL1wXDCF7aWZaSj8PfadZ24HaA9lZQW5P6SY+8z3x7zwWeDV2M/Aunsm9b6oBG/H5
         EryGf3rQO5QBO+nd7sbN8qkXHv+npkkfgjzglM0uvipq7oZw/K9hIq0RT4BiB5g6NiG4
         PyGiQrpmF5rz/svkAcibLtZsB4OaB7RMt2M9zFBS/1OD+DUw+3L8M5iN/LCgBi187PH5
         vzqr1iGl/wx9HAOSv8/2l+JnoyQC1R4MXya9zLjhAyO+gwNIN7NITpRC2aAvYgl4oF+A
         gKYPighePrTZBknJsoj7L6Wc/DR/IkovRZWteBa133zRzaXFUUj92L1TS8ypjRJdb0wl
         8mkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEJ/Tye5z9avN76shZ03uto5IBqzrqBiiJqjeDl+2jBERrC/J7GKRuBZ+jkPuznEvxIIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAg3rpkkaHO3TsawmolqzpU5W+HsUNhnn9q0euoOdYCe1PtLbn
	I6IwiD9bporNy4BDPp2wg5qQEpxteWLSGAsxo2r8ctmTjeavkgiGE6XTWP+EshL2e2nAgIZaJhz
	YJlbKk67spDkLCpI69FjyIwL0MpM=
X-Gm-Gg: ASbGncvpMLMAsxtQgQQMR+iGCN3CRj78WjXvBe1vdsIa6TgcYEmaBmqlaWiEl6lFGpT
	U6aAQ14V855h6bQVp/WyCded0nDrKO1KY5xUNbcB5EDrdKV9wfPjGY+JhHDeh8lN/I02CgFxBOA
	==
X-Google-Smtp-Source: AGHT+IGDXvHUY7Ko/1wf8Xa6YqW3+QwANn90MttosUrnmwSv8Y85ZRrv4fc9tqGm5i/3NQ+ws0uXazSPLB56tV2qmts=
X-Received: by 2002:a05:6402:2397:b0:5e0:4276:c39e with SMTP id
 4fb4d7f45d1cf-5e04276c630mr9043664a12.30.1739899593348; Tue, 18 Feb 2025
 09:26:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAH4uRDZD5fV5ag6ZEz6F-y4ER=irbheX2CW9ng=Wrgmr0kK9g@mail.gmail.com>
In-Reply-To: <CAAH4uRDZD5fV5ag6ZEz6F-y4ER=irbheX2CW9ng=Wrgmr0kK9g@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 18 Feb 2025 18:25:57 +0100
X-Gm-Features: AWEUYZljLI9KQ_QNrfiA_89IEQHbm6DYD91bR0KtJW-HKzfke-bNAw8b7-FbhGc
Message-ID: <CAP01T76OPL3dH593X4H2UjubV-7k2aF=5eCN-3AC1p6w11FoCA@mail.gmail.com>
Subject: Re: failing bpftrace snippet after "Add missing size check for
 BTF-based ctx access"
To: Eric Hagberg <ehagberg@janestreet.com>, bpf <bpf@vger.kernel.org>
Cc: kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Feb 2025 at 17:42, Eric Hagberg <ehagberg@janestreet.com> wrote:
>
> Just came across someone trying to run this, which used to work:
>
> bpftrace -e 'kfunc:security_file_open { printf("%s", path(args->file->f_path)); }'
>
> But with the patch mentioned here this happens: (https://lore.kernel.org/all/20241212092050.3204165-2-memxor@gmail.com)
>
> stdin:1:41-64: ERROR: BPF_FUNC_d_path not available for your kernel version
> kfunc:security_file_open { printf("%s", path(args.file->f_path)); }
>                                         ~~~~~~~~~~~~~~~~~~~~~~~
>
> If I revert your patch, then the command works again.
>
> I also notice that the dpath and skboutput kernel helpers now show "no" rather than "yes" in "bpftrace --info" output. This is with bpftrace version v0.21.2 and 6.12 and 6.6 kernels
>
> Is this a known problem? I haven't been able to find other reports, but it seems like maybe your patch is catching some problems with helper interfaces passing around non-u64 arguments.
>
> What do you think?
>

Hello Eric, thanks for reporting.

The kernel fix shouldn't be wrong, as it's fixing incorrect behavior,
but it could be that bpftrace relied on the incorrectness for feature
detection.

The load for a pointer argument in the context should be 64-bit but I
see for both cases it's doing BPF_LDX_MEM(BPF_W, ...)

https://github.com/bpftrace/bpftrace/blob/d7c45063a20140b1b073f43cea97c40d8560bdcb/src/bpffeature.cpp#L368
https://github.com/bpftrace/bpftrace/blob/d7c45063a20140b1b073f43cea97c40d8560bdcb/src/bpffeature.cpp#L541

I have opened a PR with the fix here:
https://github.com/bpftrace/bpftrace/pull/3805

Please test it out (I have done so already) and let me know if it
fixes the problem.

Thanks

