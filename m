Return-Path: <bpf+bounces-11187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CC27B50DE
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 13:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 46FC028279C
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 11:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0984310A14;
	Mon,  2 Oct 2023 11:09:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6B0101F2
	for <bpf@vger.kernel.org>; Mon,  2 Oct 2023 11:09:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D821C433C7
	for <bpf@vger.kernel.org>; Mon,  2 Oct 2023 11:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696244971;
	bh=LFIkEJxKj39+G0xdPbzbpEvV+aZGYSxDvW3UdKnI8YU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jU48H6Z85SoI4bvHsglDlIvUNNltjFozhFKPK0B24DaY9v8W2AjiWyxA595umKOQ2
	 t8eKGR3tEhX9cAUORZmDC8zzW6M+fjlu4loz6BJG/E++cz5SEiUFdiVqrdrWD7rJ2o
	 NcftJNUYWS/XnON1/vUP5FAQdr9GUMzJsLpXtzSJflXBtZbx8VV8ctEgIKYcCYqNnw
	 I/9dSyqMkIlhrxgt4/jjF7B0CjA4b9FchDGhLtpk11ZCV1heYIXU74mCiHuEGnJL5B
	 4GhyXYqs8LP/Op8/yNSmqrKRCIIlisw/z4xaBitjzZma9tpFJFmGcENBY/0DaECaHt
	 p3xIgHLUTfqvQ==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5334f9a56f6so21839860a12.3
        for <bpf@vger.kernel.org>; Mon, 02 Oct 2023 04:09:30 -0700 (PDT)
X-Gm-Message-State: AOJu0YxlK2Jj7cxqNEqAApAnRMRYztxpZcNgpDpBZ9BA/6EjUr0L7Rvl
	JvVoEy9DmVax0wzLTY2Q+EnvUQSmX+fZ/5ic3/UGfQ==
X-Google-Smtp-Source: AGHT+IG5//BwdyivHsNtJ6eiYEhdWWsaRBVErTlMqE4p5cbki/l1LY3rauw8/Uyb9b2DDqFv3X5QTRzAJPrOQSkrNNY=
X-Received: by 2002:a05:6402:5178:b0:531:a63:cf25 with SMTP id
 d24-20020a056402517800b005310a63cf25mr9537586ede.33.1696244969424; Mon, 02
 Oct 2023 04:09:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230928202410.3765062-1-kpsingh@kernel.org> <5a56953293ae90a1e20a414a44f45a94ee971792.camel@redhat.com>
In-Reply-To: <5a56953293ae90a1e20a414a44f45a94ee971792.camel@redhat.com>
From: KP Singh <kpsingh@kernel.org>
Date: Mon, 2 Oct 2023 13:09:18 +0200
X-Gmail-Original-Message-ID: <CACYkzJ71Pp7k=0k=5ieki13mtxv=FmuOgzYAFKiy3LVBNT+HNQ@mail.gmail.com>
Message-ID: <CACYkzJ71Pp7k=0k=5ieki13mtxv=FmuOgzYAFKiy3LVBNT+HNQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] Reduce overhead of LSMs with static calls
To: Paolo Abeni <pabeni@redhat.com>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com, 
	song@kernel.org, daniel@iogearbox.net, ast@kernel.org, renauld@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 2, 2023 at 1:06=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On Thu, 2023-09-28 at 22:24 +0200, KP Singh wrote:
> > # Background
> >
> > LSM hooks (callbacks) are currently invoked as indirect function calls.=
 These
> > callbacks are registered into a linked list at boot time as the order o=
f the
> > LSMs can be configured on the kernel command line with the "lsm=3D" com=
mand line
> > parameter.
> >
> > Indirect function calls have a high overhead due to retpoline mitigatio=
n for
> > various speculative execution attacks.
> >
> > Retpolines remain relevant even with newer generation CPUs as recently
> > discovered speculative attacks, like Spectre BHB need Retpolines to mit=
igate
> > against branch history injection and still need to be used in combinati=
on with
> > newer mitigation features like eIBRS.
> >
> > This overhead is especially significant for the "bpf" LSM which allows =
the user
> > to implement LSM functionality with eBPF program. In order to facilitat=
e this
> > the "bpf" LSM provides a default callback for all LSM hooks. When enabl=
ed,
> > the "bpf" LSM incurs an unnecessary / avoidable indirect call. This is
> > especially bad in OS hot paths (e.g. in the networking stack).
> > This overhead prevents the adoption of bpf LSM on performance critical
> > systems, and also, in general, slows down all LSMs.
> >
> > Since we know the address of the enabled LSM callbacks at compile time =
and only
> > the order is determined at boot time, the LSM framework can allocate st=
atic
> > calls for each of the possible LSM callbacks and these calls can be upd=
ated once
> > the order is determined at boot.
> >
> > This series is a respin of the RFC proposed by Paul Renauld (renauld@go=
ogle.com)
> > and Brendan Jackman (jackmanb@google.com) [1]
> >
> > # Performance improvement
> >
> > With this patch-set some syscalls with lots of LSM hooks in their path
> > benefitted at an average of ~3% and I/O and Pipe based system calls ben=
efitting
> > the most.
> >
> > Here are the results of the relevant Unixbench system benchmarks with B=
PF LSM
> > and SELinux enabled with default policies enabled with and without thes=
e
> > patches.
> >
> > Benchmark                                               Delta(%): (+ is=
 better)
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > Execl Throughput                                             +1.9356
> > File Write 1024 bufsize 2000 maxblocks                       +6.5953
> > Pipe Throughput                                              +9.5499
> > Pipe-based Context Switching                                 +3.0209
> > Process Creation                                             +2.3246
> > Shell Scripts (1 concurrent)                                 +1.4975
> > System Call Overhead                                         +2.7815
> > System Benchmarks Index Score (Partial Only):                +3.4859
>
> FTR, I also measure a ~3% tput improvement in UDP stream test over
> loopback.
>

Thanks for running the numbers and testing these patches, greatly appreciat=
ed!

> @KP Singh, I would have appreciated being cc-ed here, since I provided

Definitely, a miss on my part. Will keep you Cc'ed in any future revisions.

I think we can also add a Tested-by: tag on the main patch and add
your performance numbers to the commit as well.

- KP

> feedback on a previous revision (as soon as I learned of this effort).
>
> Cheers,
>
> Paolo
>

