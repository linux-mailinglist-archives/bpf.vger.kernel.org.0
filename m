Return-Path: <bpf+bounces-11186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEDD7B50D9
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 13:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id EC21D2826C7
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 11:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED1110A12;
	Mon,  2 Oct 2023 11:06:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AAC101F2
	for <bpf@vger.kernel.org>; Mon,  2 Oct 2023 11:06:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855EEB3
	for <bpf@vger.kernel.org>; Mon,  2 Oct 2023 04:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696244790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DYYchr75lPgIPVF4yIojNv4/SPtia6FPTBRWZDFa/Bo=;
	b=NJCiiFVeURy8dKmZA+Qf72P+nAxmSRTVY4+qdj9Obvm8MaYeLrEXsQGy0fsSr3QwS6rrB7
	f6nD7vrz+qHyw1WQWhjyqxk3cu9Z88NBXzMs721bGa04Dts9SUGMX0jjLtxE7z4V6M3CNW
	/crtFwuoHysBGzzPbwuGexxJ02srrU0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-BCrJCKfmP7ipLUTBN-UXiw-1; Mon, 02 Oct 2023 07:06:19 -0400
X-MC-Unique: BCrJCKfmP7ipLUTBN-UXiw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9ae5f4ebe7eso330914866b.0
        for <bpf@vger.kernel.org>; Mon, 02 Oct 2023 04:06:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696244778; x=1696849578;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DYYchr75lPgIPVF4yIojNv4/SPtia6FPTBRWZDFa/Bo=;
        b=CE4A98AuqKVJCh7qARKC2qIm9xyLtgcz8bOaHGW7GhQ13Ilgaffpc4Ut0V/O6ZBt/P
         PmCRFcqrhXiB+YwcvJ/PZcB1fvAf018PJQKp7se3z1SBH8JZOqZPzU9lbj5MVdytYW6X
         DvnFXdXbYP+Kgq8KwLNXeY/T7calJeYdcjmbckeiqqBnYBlDLKtQpTuIdzKnuLhjc61i
         0eNBD98OuPKWkuhPm+rsaDDqX6Sxub4BkIgz1HlFd72ZY5C1EuOh29LMR7jyXcP1bAbi
         E0P4qyOCeX6eWju8z4zb9V1cvKRmYH07n21DyO3qXVY74zV9g7yajbo2Smg04wfDmGp1
         3Ebg==
X-Gm-Message-State: AOJu0Yyyho3DiEk0CA90tk6u3Lr3SoWGUVG9OHXAmU62WVMVRxo+d6MS
	xpkia8IY6/kakFCzP8rRdokVHMIikwgAETjCRnNdvlelIKf+jKo46DFQJVZxZF08Fehpd8oWzxU
	RZjwznJw6zJkK
X-Received: by 2002:a17:906:7389:b0:9a1:d915:6372 with SMTP id f9-20020a170906738900b009a1d9156372mr9245947ejl.4.1696244778123;
        Mon, 02 Oct 2023 04:06:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFp+BfMhEWzXVb16vyxNML0UzJNiL7gyOvkLvcAWIYrSoBIAxKDqcE8idRquVxsjJRV7hR2hQ==
X-Received: by 2002:a17:906:7389:b0:9a1:d915:6372 with SMTP id f9-20020a170906738900b009a1d9156372mr9245928ejl.4.1696244777775;
        Mon, 02 Oct 2023 04:06:17 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-130.dyn.eolo.it. [146.241.225.130])
        by smtp.gmail.com with ESMTPSA id o24-20020a1709064f9800b0099cce6f7d50sm16963982eju.64.2023.10.02.04.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 04:06:17 -0700 (PDT)
Message-ID: <5a56953293ae90a1e20a414a44f45a94ee971792.camel@redhat.com>
Subject: Re: [PATCH v5 0/5] Reduce overhead of LSMs with static calls
From: Paolo Abeni <pabeni@redhat.com>
To: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org
Cc: paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com, 
	song@kernel.org, daniel@iogearbox.net, ast@kernel.org, renauld@google.com
Date: Mon, 02 Oct 2023 13:06:15 +0200
In-Reply-To: <20230928202410.3765062-1-kpsingh@kernel.org>
References: <20230928202410.3765062-1-kpsingh@kernel.org>
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
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-09-28 at 22:24 +0200, KP Singh wrote:
> # Background
>=20
> LSM hooks (callbacks) are currently invoked as indirect function calls. T=
hese
> callbacks are registered into a linked list at boot time as the order of =
the
> LSMs can be configured on the kernel command line with the "lsm=3D" comma=
nd line
> parameter.
>=20
> Indirect function calls have a high overhead due to retpoline mitigation =
for
> various speculative execution attacks.
>=20
> Retpolines remain relevant even with newer generation CPUs as recently
> discovered speculative attacks, like Spectre BHB need Retpolines to mitig=
ate
> against branch history injection and still need to be used in combination=
 with
> newer mitigation features like eIBRS.
>=20
> This overhead is especially significant for the "bpf" LSM which allows th=
e user
> to implement LSM functionality with eBPF program. In order to facilitate =
this
> the "bpf" LSM provides a default callback for all LSM hooks. When enabled=
,
> the "bpf" LSM incurs an unnecessary / avoidable indirect call. This is
> especially bad in OS hot paths (e.g. in the networking stack).
> This overhead prevents the adoption of bpf LSM on performance critical
> systems, and also, in general, slows down all LSMs.
>=20
> Since we know the address of the enabled LSM callbacks at compile time an=
d only
> the order is determined at boot time, the LSM framework can allocate stat=
ic
> calls for each of the possible LSM callbacks and these calls can be updat=
ed once
> the order is determined at boot.
>=20
> This series is a respin of the RFC proposed by Paul Renauld (renauld@goog=
le.com)
> and Brendan Jackman (jackmanb@google.com) [1]
>=20
> # Performance improvement
>=20
> With this patch-set some syscalls with lots of LSM hooks in their path
> benefitted at an average of ~3% and I/O and Pipe based system calls benef=
itting
> the most.
>=20
> Here are the results of the relevant Unixbench system benchmarks with BPF=
 LSM
> and SELinux enabled with default policies enabled with and without these
> patches.
>=20
> Benchmark                                               Delta(%): (+ is b=
etter)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> Execl Throughput                                             +1.9356
> File Write 1024 bufsize 2000 maxblocks                       +6.5953
> Pipe Throughput                                              +9.5499
> Pipe-based Context Switching                                 +3.0209
> Process Creation                                             +2.3246
> Shell Scripts (1 concurrent)                                 +1.4975
> System Call Overhead                                         +2.7815
> System Benchmarks Index Score (Partial Only):                +3.4859

FTR, I also measure a ~3% tput improvement in UDP stream test over
loopback.

@KP Singh, I would have appreciated being cc-ed here, since I provided
feedback on a previous revision (as soon as I learned of this effort).

Cheers,

Paolo


