Return-Path: <bpf+bounces-1878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C433723240
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 23:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A01901C20DF6
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 21:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE66271FA;
	Mon,  5 Jun 2023 21:29:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33A224134
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 21:29:15 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C60C5
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 14:29:00 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5147f4bbfdaso7135205a12.0
        for <bpf@vger.kernel.org>; Mon, 05 Jun 2023 14:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686000538; x=1688592538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uy+nJiJhg4Ep/PU/cvSiUcw0kq4fTCp1cis4OHOhMP8=;
        b=JdxPR69ypzChqN+CUWxLsP4IiFdItpM4Tt+YsJtg1Xy4l5p1hvNh+KTYAfMP0uqCDU
         kLp3pzgyztufQFHjH2TdB/Fqe3fkRuzY0C93i7guwN5JicjwT2SS4NHFyluG/XOKDI3x
         AM2Aocs8MgsVX1PLrFqCteISRoZmzplsPWGKgOE/A9RBM2AS2jW6hFufLcoFgbF+8/Nx
         3DfmLDiILaso2Yjpza03tnj7fVyru8Gnn/rAGrQNEo0XjDlK8QiFmz0l1MHLGpAguYM1
         S1tZHREkd7VCPttI0kiRlwmtWNplFt18Up3ktdCih+2ao6+kkM8cc9YAMj8qG2zzkWRk
         +rRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686000538; x=1688592538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uy+nJiJhg4Ep/PU/cvSiUcw0kq4fTCp1cis4OHOhMP8=;
        b=PSF1UnCWh8T1xCDAEGARPTUtoSv2pUcvcrVMNo70JbhO6uWY0My0EW5kfP2xJNTgXw
         mZ+JlxfijOuTnQQHP+BPpWoJAJnJAq0hkMM+pAXhYMZRm4H8va+YTk7vu3SqZgNiV1aR
         zLwXhsnnqbDkPZE6ixLI3bh0wK4f2WG5WgN/Znn9e+34Yzb9+Ick0wh/zGYGSnYXeBUO
         4rtLhSP/6RAE6nYIH7LhiZ+PmbtZMf2obuSd8RUzdv8zixT3mAwumxuxnTcOyuXmqLut
         IXoDZDi7EV2pnKI/o5vhULwIhYEU3+P3HYLY0zd55MNMALP+SVO2gn1QJoYW+1fsDMii
         e8EQ==
X-Gm-Message-State: AC+VfDylt60SPylF8VfUBXrlR3v3APqn9shsH+zNjjvh3UJ1UYIaH6ZQ
	iuveksHmLksen6BXdopi85LT8NhWKdOG+FccW68JhPbH/VZgYg==
X-Google-Smtp-Source: ACHHUZ5aXL6+F1eKaPgVGwoIVkplC9oQpWn/Gyz4ZQsoFV8aztH4v9LjJaPiVRrWWHnd57/ytA1tuAyA+u6UfbArVhg=
X-Received: by 2002:a17:906:6a28:b0:973:92d4:9f4e with SMTP id
 qw40-20020a1709066a2800b0097392d49f4emr121492ejc.53.1686000537799; Mon, 05
 Jun 2023 14:28:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230605085733.1833-1-yb203166@antfin.com> <20230605085733.1833-2-yb203166@antfin.com>
In-Reply-To: <20230605085733.1833-2-yb203166@antfin.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 5 Jun 2023 14:28:46 -0700
Message-ID: <CAEf4BzZBC+nQEA5AWnmb9FhqWa6=y=zvfrcVbwa4sEjnRsp_Dg@mail.gmail.com>
Subject: Re: [PATCH 1/2] Add api to manipulate global variable
To: Yang Bo <yyyeer.bo@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, Yang Bo <bo@hyper.sh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 5, 2023 at 1:58=E2=80=AFAM Yang Bo <yyyeer.bo@gmail.com> wrote:
>
> From: Yang Bo <bo@hyper.sh>
>
> implement function.
> refactor code.
>
> Signed-off-by: Yang Bo <bo@hyper.sh>
> ---

There is no need for libbpf to add new APIs for this. First, BPF
skeleton is the preferred and natural way to work with BPF global
variables. Second, if you don't want to use BPF skeleton, you can find
all this information in BTF directly by using bpf_object__btf() +
bpf_map__btf_value_type_id() APIs.

>  tools/lib/bpf/bpf.c      | 808 +++++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/bpf.h      |   9 +
>  tools/lib/bpf/libbpf.map |   2 +
>  3 files changed, 819 insertions(+)
>

[...]

