Return-Path: <bpf+bounces-8291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A01B6784A69
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 21:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0C561C20B45
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 19:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D46434CCD;
	Tue, 22 Aug 2023 19:27:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDB71DDE3;
	Tue, 22 Aug 2023 19:27:38 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465A9DB;
	Tue, 22 Aug 2023 12:27:37 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bb8a12e819so75636221fa.1;
        Tue, 22 Aug 2023 12:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692732455; x=1693337255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fht3QKsJ0Em+gRERcuW1SNPpfzbxKyt4TgAwcB5JFqw=;
        b=NOGNtkyMb09eNpbrAHsbuFUtWrnkqmG6s8qL5C5JR+15bJvedqjgin4gx1YkZFi7M0
         6PHscjMMWBkdGIf+AqKLlBeaePRGl4EBJd4vx57rsuW7dvAxs25QiCKjqRqq069CmO+Y
         TYA0Hbe6k6w7zQGbG55aUuo6f4zMIIIwNpvf7OgEZyXFEONR+hXFGc32jlN3E4SoqUK5
         bFGqcBjwXk7MjOOWVpszfcLgvAl4TzVJsUQ6MO8mqGJIeQJ1X/274dFuAIjiuqPSNtkH
         jnAlRAuW+sFESrlo/fy2MZ24+xcvr+F0glcLSowL6UV1f8G+S8XXu6T7HZzqx3S0eWKp
         c6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692732455; x=1693337255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fht3QKsJ0Em+gRERcuW1SNPpfzbxKyt4TgAwcB5JFqw=;
        b=ZT7dhpEsx3CgQ8ULOXT4TxW1cUp5iP+1Y5IqAIa77xWntA4QRvsihIPrV7X2kT0FA6
         dk9Z2s876X5hjDFOwr2tZyQu+GkAKVjGsOqbvuqVRwEiv8j11bqk3O+jkuGFwinz8rHn
         5xO/olHiHW+FzuHgOXpby71Y4KstnGQjJipI/ktFDgYVvyerhxoranHlUCrL90WV9eoY
         Jg27PWG8lE7zoY7w918/M7kROsd2AeZ+I1xTcmtIPQVawi7fJuDjM1OxXvyjUdAa1903
         9wLdKcyBrK55acSzRs5lhsoyJ8YpIoSCwaW02qkrsF/McxoVNlHgvb6gHcNTeMS+GeuL
         POKw==
X-Gm-Message-State: AOJu0Yw/q27zIBzcaOJyXyYDeGKJhG+ZgSG75FTydgxRqOW3ovL0ACrA
	TVkIMPcXYSrN7BvF6hH5+133orRRf6pnL3IyVwc=
X-Google-Smtp-Source: AGHT+IEm+x96sGisjUtLl777n7A0nCYqjUp4DkvVzc7IfagSJAkAQNDwSeM2PeWeKED1ANyxHFaqG6QqxeUvNdFqUug=
X-Received: by 2002:a2e:b0e4:0:b0:2bc:d0f8:fb4f with SMTP id
 h4-20020a2eb0e4000000b002bcd0f8fb4fmr2291557ljl.7.1692732455148; Tue, 22 Aug
 2023 12:27:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230822142255.1340991-1-toke@redhat.com>
In-Reply-To: <20230822142255.1340991-1-toke@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 22 Aug 2023 12:27:24 -0700
Message-ID: <CAADnVQKEru25sk8sP0L_GsCW67PUAfTukWNEpTc1nRafQa81GA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/6] samples/bpf: Remove unmaintained XDP sample utilities
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 22, 2023 at 7:23=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> The samples/bpf directory in the kernel tree started out as a way of show=
casing
> different aspects of BPF functionality by writing small utility programs =
for
> each feature. However, as the BPF subsystem has matured, the preferred wa=
y of
> including userspace code with a feature has become the BPF selftests, whi=
ch also
> have the benefit of being consistently run as part of the BPF CI system.
>
> As a result of this shift, the utilities in samples/bpf have seen little =
love,
> and have slowly bitrotted. There have been sporadic cleanup patches over =
the
> years, but it's clear that the utilities are far from maintained.
>
> For XDP in particular, some of the utilities have been used as benchmarki=
ng aids
> when implementing new kernel features, which seems to be the main reason =
they
> have stuck around; any updates the utilities have seen have been targeted=
 at
> this use case. However, as the BPF subsystem as a whole has moved on, it =
has
> become increasingly difficult to incorporate new features into these util=
ities
> because they predate most of the modern BPF features (such as kfuncs and =
BTF).
>
> Rather than try to update these utilities and keep maintaining them in th=
e
> kernel tree, we have ported the useful features of the utilities to the
> xdp-tools package. In the porting process we also updated the utilities t=
o take
> advantage of modern BPF features, integrated them with libxdp, and polish=
ed the
> user interface.
>
> As these utilities are standalone tools, maintaining them out of tree is
> simpler, and we plan to keep maintaining them in the xdp-tools repo. To d=
irect
> users of these utilities to the right place, this series removes the util=
ities
> from samples/bpf, leaving in place only a couple of utilities whose
> functionality have not yet been ported to xdp-tools.
>
> The xdp-tools repository is located on Github at the following URL:
>
> https://github.com/xdp-project/xdp-tools

Could you add this link with details to samples/bpf/README.rst,
so that folks know where to look for them?

Other than that the set makes sense to me.

