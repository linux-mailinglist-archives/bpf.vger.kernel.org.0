Return-Path: <bpf+bounces-11202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3FF7B53F4
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 15:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id BB5B72826C9
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 13:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160B718E3D;
	Mon,  2 Oct 2023 13:27:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A0E18E28
	for <bpf@vger.kernel.org>; Mon,  2 Oct 2023 13:27:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0DCAD
	for <bpf@vger.kernel.org>; Mon,  2 Oct 2023 06:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696253261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=59m/13BmYCgkDRehdAVuiN8WdhZBDHExskmCEgDJyAA=;
	b=aV1pMcWKWHkStyMPq7egq2yVOdNLLXYMZwGEMwJ7TBIyyMgQTBGYcRWG4WlFDpGlvbzeCf
	DjnrVkEbszrgXOUpsp06yqSN1tJ+TTHZ3qBdp42U4HR+qKJd8+aEv7RCfPQg/EnwWdqIEl
	gfpqL93XC1+UVumEw1M6GiDIBADfMf0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-j8xIMZF5NOSgKvtRiWwRLQ-1; Mon, 02 Oct 2023 09:27:39 -0400
X-MC-Unique: j8xIMZF5NOSgKvtRiWwRLQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3175b9a0094so2856396f8f.0
        for <bpf@vger.kernel.org>; Mon, 02 Oct 2023 06:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696253259; x=1696858059;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=59m/13BmYCgkDRehdAVuiN8WdhZBDHExskmCEgDJyAA=;
        b=KyONEESVrJ/kz1OFlsnT2AlTAZ4sdRlShB3v6KHHQmEt3S2IKRpi2LuEdn1mZRe9jN
         wBSYGWGp8Ov583B3+gbraRRuukGI9BhslfpYfDEHtMf4RFwwT+A8yzJ6YDkjuGZ8Y3Y8
         OzPnJoRcFHJOTerz94Q0nSm9aKv+ZoRGWsBSgUfkoZZlC4k1t3qJ0xqUJ6PIc2y6u6lS
         jTbZz7mznLYluIZd2IIiuoCGXb+VsNt9IFaZucwF7d/mm6mEkIkdS5rknuobOsJCrbb1
         wBIEg61VxZYLnVfJ1VUB+kdkvMjWfmWyPNsaopcoNYAqxlGeZd2hGTxMIJXC1Oz+OE5M
         HDOA==
X-Gm-Message-State: AOJu0YxBKYHB+EQ+6hFyA7juOCL4Af4R0vAiP9a1Z1e1tbA2ZdvKSSjL
	0iAkRhp4IOFaUz0wrsr1AngJphRa+NIABau3pQC8sgb6PlWeelfwKifVdm+Q64mzMsWermi7PSq
	Afa0jE+6QemQA
X-Received: by 2002:a5d:5385:0:b0:323:2df9:618f with SMTP id d5-20020a5d5385000000b003232df9618fmr8682059wrv.0.1696253258795;
        Mon, 02 Oct 2023 06:27:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHC3l5llIHRs15xuTf7Agy0aGt1ZhlFRJwaihUsayg9SBgDilx3BWdKcBdNOqGSMfpDFXRerA==
X-Received: by 2002:a5d:5385:0:b0:323:2df9:618f with SMTP id d5-20020a5d5385000000b003232df9618fmr8682039wrv.0.1696253258379;
        Mon, 02 Oct 2023 06:27:38 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-130.dyn.eolo.it. [146.241.225.130])
        by smtp.gmail.com with ESMTPSA id d18-20020a056402401200b00536246d1eadsm6795799eda.41.2023.10.02.06.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 06:27:37 -0700 (PDT)
Message-ID: <b22a8e3884fce6549378b00810a66491144ddb94.camel@redhat.com>
Subject: Re: [PATCH v5 0/5] Reduce overhead of LSMs with static calls
From: Paolo Abeni <pabeni@redhat.com>
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com, 
	song@kernel.org, daniel@iogearbox.net, ast@kernel.org, renauld@google.com
Date: Mon, 02 Oct 2023 15:27:36 +0200
In-Reply-To: <CACYkzJ71Pp7k=0k=5ieki13mtxv=FmuOgzYAFKiy3LVBNT+HNQ@mail.gmail.com>
References: <20230928202410.3765062-1-kpsingh@kernel.org>
	 <5a56953293ae90a1e20a414a44f45a94ee971792.camel@redhat.com>
	 <CACYkzJ71Pp7k=0k=5ieki13mtxv=FmuOgzYAFKiy3LVBNT+HNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-10-02 at 13:09 +0200, KP Singh wrote:
> On Mon, Oct 2, 2023 at 1:06=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
> > On Thu, 2023-09-28 at 22:24 +0200, KP Singh wrote:
> > > # Background
> > >=20
> > > LSM hooks (callbacks) are currently invoked as indirect function call=
s. These
> > > callbacks are registered into a linked list at boot time as the order=
 of the
> > > LSMs can be configured on the kernel command line with the "lsm=3D" c=
ommand line
> > > parameter.
> > >=20
> > > Indirect function calls have a high overhead due to retpoline mitigat=
ion for
> > > various speculative execution attacks.
> > >=20
> > > Retpolines remain relevant even with newer generation CPUs as recentl=
y
> > > discovered speculative attacks, like Spectre BHB need Retpolines to m=
itigate
> > > against branch history injection and still need to be used in combina=
tion with
> > > newer mitigation features like eIBRS.
> > >=20
> > > This overhead is especially significant for the "bpf" LSM which allow=
s the user
> > > to implement LSM functionality with eBPF program. In order to facilit=
ate this
> > > the "bpf" LSM provides a default callback for all LSM hooks. When ena=
bled,
> > > the "bpf" LSM incurs an unnecessary / avoidable indirect call. This i=
s
> > > especially bad in OS hot paths (e.g. in the networking stack).
> > > This overhead prevents the adoption of bpf LSM on performance critica=
l
> > > systems, and also, in general, slows down all LSMs.
> > >=20
> > > Since we know the address of the enabled LSM callbacks at compile tim=
e and only
> > > the order is determined at boot time, the LSM framework can allocate =
static
> > > calls for each of the possible LSM callbacks and these calls can be u=
pdated once
> > > the order is determined at boot.
> > >=20
> > > This series is a respin of the RFC proposed by Paul Renauld (renauld@=
google.com)
> > > and Brendan Jackman (jackmanb@google.com) [1]
> > >=20
> > > # Performance improvement
> > >=20
> > > With this patch-set some syscalls with lots of LSM hooks in their pat=
h
> > > benefitted at an average of ~3% and I/O and Pipe based system calls b=
enefitting
> > > the most.
> > >=20
> > > Here are the results of the relevant Unixbench system benchmarks with=
 BPF LSM
> > > and SELinux enabled with default policies enabled with and without th=
ese
> > > patches.
> > >=20
> > > Benchmark                                               Delta(%): (+ =
is better)
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > > Execl Throughput                                             +1.9356
> > > File Write 1024 bufsize 2000 maxblocks                       +6.5953
> > > Pipe Throughput                                              +9.5499
> > > Pipe-based Context Switching                                 +3.0209
> > > Process Creation                                             +2.3246
> > > Shell Scripts (1 concurrent)                                 +1.4975
> > > System Call Overhead                                         +2.7815
> > > System Benchmarks Index Score (Partial Only):                +3.4859
> >=20
> > FTR, I also measure a ~3% tput improvement in UDP stream test over
> > loopback.
> >=20
>=20
> Thanks for running the numbers and testing these patches, greatly appreci=
ated!
>=20
> > @KP Singh, I would have appreciated being cc-ed here, since I provided
>=20
> Definitely, a miss on my part. Will keep you Cc'ed in any future revision=
s.

Thanks!

> I think we can also add a Tested-by: tag on the main patch and add
> your performance numbers to the commit as well.

Feel free to include that, even if my testing is limited to the
performance test described above.

Cheers,

Paolo


