Return-Path: <bpf+bounces-631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9149704ADD
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 12:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 807171C20E16
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 10:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9956D34CFC;
	Tue, 16 May 2023 10:33:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6766B34CC1
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 10:33:44 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CBD658F
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 03:33:07 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-966400ee79aso2157225466b.0
        for <bpf@vger.kernel.org>; Tue, 16 May 2023 03:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1684233185; x=1686825185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x37qfPv4F1ivF0FEc6v+EsmdjMxZQmhCoLQ4PfxHX24=;
        b=exJt95FT6D++7QGw38T8PESUYG9RwWgXQfPpVxa23dPBRK/SgUVv35cAnkwHT+sYoR
         d80g6jhqQQdWkBtsA4qxKsKR51gAgQMvar5nfZ7awHEOEu8whaCTDlefoGY7VDVcPfqe
         AunRo2jmCrBuko6E7qXhc77w4lcTsbTgyInIiRg9lDaxlDZ3B/myqdrAjFVqZzngd+xH
         qoew8hewgv+ry8ul5JS4Rrqo4jeX4DVjTRPPIN4wVUjJ6a31CWCblNozMP6yjc9UmpSg
         z2R1dqWiUR/aTxBo+eCjZcX5wGAoS7asplBVbV9LYcIcuBTn9aDocuhvfujy/XezXRnm
         A6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684233185; x=1686825185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x37qfPv4F1ivF0FEc6v+EsmdjMxZQmhCoLQ4PfxHX24=;
        b=loEJLCfhWvmlfxlXDJKSY07xH9E2Se7+5dOF+/oNCIPwmbibkDHg31WJeszN4ChdFy
         96agCCG3I8dXabjSXNfmGF+kNcpmMu8PA3HnO7wI/K8QJnugMjxzgw0sLroLbxwuWvFB
         X2GsdCP+JwkFWRKh054V+DZJK5lfr9GGGzchCiZ1sc5tvSsq8mrtmWVKvHJCNgzaoo78
         msqJp9U2x5BFYLx7Jq6nqVx9mpSEykpQT2caUQcuJECaWOz+SY2DD8ONlgseOrXQJMvd
         /YmxWAyIxPH+W8OAvnO5Ehf87IWiH1EBYm8DUAJRkITzrPQN9eFDSWRTJy3lj7mjoSCa
         dG5w==
X-Gm-Message-State: AC+VfDyuFaFqadDn3+qRYqa0HrF+nQeIJEzhKJOGXcgX4WX9100XK18B
	sxUe8Kl8SlLSliI0P2mR9t64OZKdqawe05dNYkz7eg==
X-Google-Smtp-Source: ACHHUZ5wkoypuJRnRMJparFQO88WuE3PT6iRYXdcIjlVz2IAnp8nPT7iwGtUlaR7r7jiHaUaP+srqSLIp4nHn+Udv5U=
X-Received: by 2002:a17:907:7fa3:b0:965:6075:d100 with SMTP id
 qk35-20020a1709077fa300b009656075d100mr39974288ejc.39.1684233185585; Tue, 16
 May 2023 03:33:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230515121521.30569-1-lmb@isovalent.com> <6b585a75-ae1a-1ad5-2756-bcce78fbd2fd@iogearbox.net>
In-Reply-To: <6b585a75-ae1a-1ad5-2756-bcce78fbd2fd@iogearbox.net>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Tue, 16 May 2023 11:32:54 +0100
Message-ID: <CAN+4W8jXG2dNTtksYtQPYQgpfGMKgMqLhW_jHJSY=HhZ6G9PeA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: btf: restore resolve_mode when popping the
 resolve stack
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, May 15, 2023 at 8:26=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 5/15/23 2:15 PM, Lorenz Bauer wrote:
> > In commit 9b459804ff99 ("btf: fix resolving BTF_KIND_VAR after ARRAY, S=
TRUCT, UNION, PTR")
> > I fixed a bug that occurred during resolving of a DATASEC by strategica=
lly resetting
> > resolve_mode. This fixes the immediate bug but leaves us open to future=
 bugs where
> > nested types have to be resolved.
>
> Lgtm, is there a way we could also craft a test case for this corner case=
?

There is a test for the datasec bug already, it went in with the
original patch. See commit dfdd608c3b36 ("selftests/bpf: check that
modifier resolves after pointer").

Not sure how to test this beyond that specific case.

