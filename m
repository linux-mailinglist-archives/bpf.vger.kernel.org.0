Return-Path: <bpf+bounces-63067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D179B02271
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 19:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 667111C87873
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 17:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CC92EF293;
	Fri, 11 Jul 2025 17:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1J2UNJg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4241223B0;
	Fri, 11 Jul 2025 17:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752254286; cv=none; b=AQRLHA6Xdgk/XroyqSRE5f9ZD7m9aS5oVCY7Os5ooqUeIJg1tltVHzBX2ot6+TEH0K35rOIaHUXqwesSElaRYt83Ax2sbRL1ReedSHESV3YN60DI3sFnKnOaW8f+7nADJDssy9gbpaSWByDjpoweOcFpJIyal3drfFlCcVPpLZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752254286; c=relaxed/simple;
	bh=tRRgm1TCKRIxxicc390nlYIrkP0eQctG04d74RMi8ss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QvV+eMNnJFLR/EbRn4t39EqY/SDf9gL1Ubm+sv2KV8U3cQcAZoOCjZINsuhZM+i0zUoMXZumQNZ1gfTCrhJYCrnfW7PS7Z7ANi3Q3ATXPfwVScZv/HI+Dsv+UkuTOkwWD/r0c+RsCtLdtu4CG8tPt9k5iYBw1wA9iXnqriPKK40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1J2UNJg; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-313a188174fso2937614a91.1;
        Fri, 11 Jul 2025 10:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752254284; x=1752859084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YN8JhcJPAFmyUnXWefNQx1CdU4pcrbO6LEejen5i4nE=;
        b=G1J2UNJgP9OJBV7LocXmtw3V84CE+marCAGcU2aXinE01ajJWygXaAygQ2zMHzjLNB
         DIY1j/eABWkiUzwngJBRSh1SB/3JhQ6TGjbINTIPX+7wODiS4sDQI3eKHQ/TOfvNnxHK
         /Wvy02LApCWkLNzbWWQ1h+QCJvKoZ94crl6ApfLkTFaMGOWniyVviGJJrZSY+iB3z5MS
         miRSKHnKLk/dxheFXX20LhuF/fM/e8uXXRu4G4m0ZdFwpHJ9w0CX3u7iWLFaHlPehBVu
         W2rqsR5GBz4+mNReSOBYvZXOPUAxL1KuNFLUOs0Oq7mpakelXvkDWzt9475uqCCxq0Bf
         Q8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752254284; x=1752859084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YN8JhcJPAFmyUnXWefNQx1CdU4pcrbO6LEejen5i4nE=;
        b=Y3+fKAdFDEb3F52wnEPbJt84RVX6CrkDlnhkeLEn+r7OI7QYjQLu37+EFepa/slLUN
         wCU3BXG/h33l67mN4Hm2BewB1KJC5zaYYeKI4oEbqM2tbgR0D7btnZbKUCYyIOjxHB3v
         ESCC1cgp0UMK+cnOtfIjUn4VdyoBANmStftCNjwjh4dy0sJd/kahdj6FsH5ZLsvkrgXW
         ayFkfxIRhcPmo0V1jwWIIH4ONWw6HalFV49vf9tKNDtg6Vn7G0SM0MNmpX4mWV+c8x4o
         DiAUsUECSJLXPWp9ldiP3MfcewBW7kil/+zc0TE+F8AyxIUl+cTntzSrFzENdmdOZDD5
         3R8A==
X-Forwarded-Encrypted: i=1; AJvYcCUfuW9Pa54IQ/MCcpjIcpvkCdKmQd8T4JbIhfH0qQVeIQjryfQXd8okZXVw+iIREGWYCNIoqKsXwfHJxFAn@vger.kernel.org, AJvYcCWGWe/+/quA3OtKfF87dm6zzVrPReFlFQtfPRflZZCjvjObtkaldbiFEx7DFQDfs1B/eoY=@vger.kernel.org, AJvYcCXoQv62EXJM8liP4erz98gul92bioaa9+IjALIA0nyenpkbCSX2NxLom0+8HNVK9M74FXCizvryPsskdDgBzbdItqwP@vger.kernel.org
X-Gm-Message-State: AOJu0YyFIHGSouM4sVhJg0bi1ehoP40jGiSe8axHa+iNwlpSx7iCnImq
	Bv6l6CovPOY9tevFiGxVlr53iY2bCJunAATTf28OiLewnFSeeAG9sMh458RDyn2LkKbVqp4Cwwu
	CPtRYRNsBrf/4M08LgueMe632GfjOd50=
X-Gm-Gg: ASbGncucGMLZwBNUr1a1RjeM2nNA353niAELt6hDaTh3nbmxddiO73zWUGK6NiyC43i
	1/s7fZRvtINyyY11xq/Xoho6JjS/CxMdkm/MujtTzXXd2Q+8iynlhsUecORH9EPHRkWFDX3jV7C
	fDkzsM+NxKOL1Y8/tOC9Is13FfS3w/A1JMcbChpqktkUEFdKvhfiHPFdN5I+4eYYxoqwEnWIwb9
	VLqehf96otlB7SMEwKykio=
X-Google-Smtp-Source: AGHT+IFAYCkRpVVEg0QdLRvRVHmC8QaVJXMfi9fmJHYomD6pCx7wxiWWUcIXcZjMo1+KVeUZKV95FSYT0bwK6iyXmYg=
X-Received: by 2002:a17:90b:56ce:b0:315:f6d6:d29c with SMTP id
 98e67ed59e1d1-31c3d0c3803mr13249177a91.15.1752254283864; Fri, 11 Jul 2025
 10:18:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711082931.3398027-1-jolsa@kernel.org>
In-Reply-To: <20250711082931.3398027-1-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 11 Jul 2025 10:17:50 -0700
X-Gm-Features: Ac12FXyY6qtXVwPUhYw-o64HRgW0NuQb1LV0LQ1wJ9aG7f6XWtpN8LrQvHGnlSA
Message-ID: <CAEf4Bzbg2ROstG5+1XUoZre403n-B3CHuW9E0UECNY364giDcw@mail.gmail.com>
Subject: Re: [PATCHv5 perf/core 00/22] uprobes: Add support to optimize usdt
 probes on x86_64
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Alejandro Colomar <alx@kernel.org>, Eyal Birger <eyal.birger@gmail.com>, 
	kees@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, David Laight <David.Laight@aculab.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 1:29=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> hi,
> this patchset adds support to optimize usdt probes on top of 5-byte
> nop instruction.
>
> The generic approach (optimize all uprobes) is hard due to emulating
> possible multiple original instructions and its related issues. The
> usdt case, which stores 5-byte nop seems much easier, so starting
> with that.
>
> The basic idea is to replace breakpoint exception with syscall which
> is faster on x86_64. For more details please see changelog of patch 8.
>
> The run_bench_uprobes.sh benchmark triggers uprobe (on top of different
> original instructions) in a loop and counts how many of those happened
> per second (the unit below is million loops).
>
> There's big speed up if you consider current usdt implementation
> (uprobe-nop) compared to proposed usdt (uprobe-nop5):
>
> current:
>         usermode-count :  152.501 =C2=B1 0.012M/s
>         syscall-count  :   14.463 =C2=B1 0.062M/s
> -->     uprobe-nop     :    3.160 =C2=B1 0.005M/s
>         uprobe-push    :    3.003 =C2=B1 0.003M/s
>         uprobe-ret     :    1.100 =C2=B1 0.003M/s
>         uprobe-nop5    :    3.132 =C2=B1 0.012M/s
>         uretprobe-nop  :    2.103 =C2=B1 0.002M/s
>         uretprobe-push :    2.027 =C2=B1 0.004M/s
>         uretprobe-ret  :    0.914 =C2=B1 0.002M/s
>         uretprobe-nop5 :    2.115 =C2=B1 0.002M/s
>
> after the change:
>         usermode-count :  152.343 =C2=B1 0.400M/s
>         syscall-count  :   14.851 =C2=B1 0.033M/s
>         uprobe-nop     :    3.204 =C2=B1 0.005M/s
>         uprobe-push    :    3.040 =C2=B1 0.005M/s
>         uprobe-ret     :    1.098 =C2=B1 0.003M/s
> -->     uprobe-nop5    :    7.286 =C2=B1 0.017M/s
>         uretprobe-nop  :    2.144 =C2=B1 0.001M/s
>         uretprobe-push :    2.069 =C2=B1 0.002M/s
>         uretprobe-ret  :    0.922 =C2=B1 0.000M/s
>         uretprobe-nop5 :    3.487 =C2=B1 0.001M/s
>
> I see bit more speed up on Intel (above) compared to AMD. The big nop5
> speed up is partly due to emulating nop5 and partly due to optimization.
>
> The key speed up we do this for is the USDT switch from nop to nop5:
>         uprobe-nop     :    3.160 =C2=B1 0.005M/s
>         uprobe-nop5    :    7.286 =C2=B1 0.017M/s
>

We've been waiting for this to land for so long, I hope this gets
applied soon...

Once this lands, we can finally start implementing USDT support that
can take advantage of this transparently and with no performance
regression on old kernel.

For the series:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

