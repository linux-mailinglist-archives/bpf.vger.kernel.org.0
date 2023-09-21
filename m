Return-Path: <bpf+bounces-10505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B13BE7A906F
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 03:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AF8F281646
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 01:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3ABA50;
	Thu, 21 Sep 2023 01:28:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE07622
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 01:28:18 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9158BA9
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 18:28:16 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c00b37ad84so6762611fa.0
        for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 18:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695259695; x=1695864495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQ/y3ERH7fFx5BdBa8OdmQHUXFfJCN8aSe0N+TJG6OM=;
        b=ZQEDH4gzpNvFEPRDTenYNRQExv+uE/dJ//z2iHqQmP63PLzTR6G21lc9D3e7DFAtsY
         CEi+i+In4D9zAK1BzxXimGOHrLhiz/A/YhXsUkcnTnbXUzVYLUSAbkQMnDNKjKHilK4n
         4u6K8EqGiAJB8yX3TmM5Bn5ZB0sStLD3hOdQecgFxJ8M1BLLY3keb3hYJVgk4cPLh/gQ
         nxcNhl5ZaAQU/XnqKKC5+BZVBMfGO81Ld49i7mEj/6OrEt0oIvvHiPEHrvaCh6QnsRqI
         uLiqy7PUceVbmHXE8ax9Z8+qpgkkjIxXqHFmnooUi3KnyTHFtTLgrjVXeS7EEsX7xGa+
         ++eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695259695; x=1695864495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQ/y3ERH7fFx5BdBa8OdmQHUXFfJCN8aSe0N+TJG6OM=;
        b=czc6gNLfR5MN26mOC8SikVLoTJaKlAfuje9vBhG8kE7jPX8IOHcerB8l8LMCYlNGuw
         v0iN2j0/AYrbX+gBjf9FZUruRePGui26UBjyErgPBAKdACrSbEPOvaK7Jgil1hXt2G2U
         GQvPEEe+GcVJDeJ6IkHipr0vf7CNFXwr3ty2WihHsR2wuF8+5rFTU36K85Wc926ksG7v
         wx79lYN/N6/6GOzq/WVQJF8STBqlH1Zv3Q1LJOEL7Ullu8nkSz23E29HZeicOCIK4iiZ
         XytXbZXlnDDxAgBdl3UowUrPdq7PkqtqbP9eEIi38PHGplwv7sErzGwx/EgJ6em7xZKv
         bGNQ==
X-Gm-Message-State: AOJu0YysK6+WP9NLnISvAGRAoiNBLxszNF+YZI0HJivkJB/EiB6aPFCW
	j/gaDNsQQO1EQp6wxHdebVxYSJFmsZHSSJmFN6Q=
X-Google-Smtp-Source: AGHT+IGFDHBc1m/i6ruD7q/JWkgum2I7ZSpOKabCXu2+o3oizfUWCK93ptA/AC6zrJVJJS762+raTy2cPnjI8gEQ4NU=
X-Received: by 2002:a2e:9317:0:b0:2bb:aaec:abad with SMTP id
 e23-20020a2e9317000000b002bbaaecabadmr3423624ljh.30.1695259694433; Wed, 20
 Sep 2023 18:28:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230914231123.193901-1-martin.kelly@crowdstrike.com>
In-Reply-To: <20230914231123.193901-1-martin.kelly@crowdstrike.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 20 Sep 2023 18:28:02 -0700
Message-ID: <CAEf4Bzai8oxP6MkyGumt08WKcdOToHrt2ZqF1bgESJ-xi+2Aag@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/14] add libbpf getters for individual ringbuffers
To: Martin Kelly <martin.kelly@crowdstrike.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 14, 2023 at 4:12=E2=80=AFPM Martin Kelly
<martin.kelly@crowdstrike.com> wrote:
>
> This patch series adds a new ring__ API to libbpf exposing getters for ac=
cessing
> the individual ringbuffers inside a struct ring_buffer. This is useful fo=
r
> polling individually, getting available data, or similar use cases. The A=
PI
> looks like this, and was roughly proposed by Andrii Nakryiko in another t=
hread:
>
> Getting a ring struct:
> struct ring *ring_buffer__ring(struct ring_buffer *rb, unsigned int idx);
>
> Using the ring struct:
> unsigned long ring__consumer_pos(const struct ring *r);
> unsigned long ring__producer_pos(const struct ring *r);
> size_t ring__avail_data_size(const struct ring *r);
> size_t ring__size(const struct ring *r);
> int ring__map_fd(const struct ring *r);
> int ring__consume(struct ring *r);
>
> Martin Kelly (14):
>   libbpf: refactor cleanup in ring_buffer__add
>   libbpf: switch rings to array of pointers
>   libbpf: add ring_buffer__ring
>   selftests/bpf: add tests for ring_buffer__ring
>   libbpf: add ring__producer_pos, ring__consumer_pos
>   selftests/bpf: add tests for ring__*_pos
>   libbpf: add ring__avail_data_size
>   selftests/bpf: add tests for ring__avail_data_size
>   libbpf: add ring__size
>   selftests/bpf: add tests for ring__size
>   libbpf: add ring__map_fd
>   selftests/bpf: add tests for ring__map_fd
>   libbpf: add ring__consume
>   selftests/bpf: add tests for ring__consume
>
>  tools/lib/bpf/libbpf.h                        | 68 +++++++++++++++
>  tools/lib/bpf/libbpf.map                      |  7 ++
>  tools/lib/bpf/ringbuf.c                       | 87 +++++++++++++++----
>  .../selftests/bpf/prog_tests/ringbuf.c        | 38 +++++++-
>  .../selftests/bpf/prog_tests/ringbuf_multi.c  | 16 ++++
>  5 files changed, 199 insertions(+), 17 deletions(-)
>
> --
> 2.34.1
>

Looks mostly good, sorry for taking a while to get to these. I left a
few comments here and there, please address and submit v2. Try to use
consistent "ring buffer manager" and "ring buffer map" to distinguish
them in doc comments. And also please don't add new CHECK() uses to
selftests, we have a whole family of ASSERT_xxx() macros, please use
them.

