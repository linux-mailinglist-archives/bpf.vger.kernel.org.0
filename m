Return-Path: <bpf+bounces-863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDEE707C4C
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 10:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45FAC2814C2
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 08:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC43AD38;
	Thu, 18 May 2023 08:42:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D056D2A9E9
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 08:42:42 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0768410CA
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 01:42:41 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-50bcb00a4c2so2627560a12.1
        for <bpf@vger.kernel.org>; Thu, 18 May 2023 01:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1684399359; x=1686991359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyiZQgT36LsZr8g4X4z/pK8Lc4mslR2lhG8l35ElJJs=;
        b=jX6ZMr1gj6JTheUW2U82Au/CqQ2LMduUavE0++1b0iZFUl+GxiQawna6AP/el6Bp/q
         8n1RP8rl6Woc1M4igGN7Uiir+TMJa2x8ldZiaMZxNceM4oED/iTznplNsPYXiMY6Md4l
         VgtQuYkytnxOUqRrkOB9GuZbHrdNvxeOH30Mz1w+pP8dpymVCe54gAW04ErXWnu11nUq
         OgoEevEPfauSZfKxFxB5AS93/g2OONXtDU28QvURhlee/OKt/fEGrF2TrMOnvxff5Czs
         Yf/PnDPMBKTsGX0BbhnNEx3Lla8HsC8SMZaXC5ohiXtaA9V4RWR0d9HPQF8kscTqsL7M
         8MyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684399359; x=1686991359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eyiZQgT36LsZr8g4X4z/pK8Lc4mslR2lhG8l35ElJJs=;
        b=ZWLDPRlqqmYOBD3uDpH02xwKX4wPhryY3KkTpZAoyKiNwDSv+hKVg1RhHKpZHvA6PO
         2TuP9M3fGJDzu6TVQGOmrgwJ9uBNO8mBgnJPyd7P+DzXSdlI/CI4rJcr4c7H8Fc9DpCQ
         koUVubtcXmkM1nCApmDFYCj1HY7Tpt85onhYeudwuxBY4MAUw3IHFmo8q2re2Ul9TEfP
         hT9yjOJXCgPGRdQEN9U37tydUq8U825fjkAAP9Vh9IUnBeF98+derUDi2qR7N2mtbJyX
         ATbnjtvZLxq6FW4BL3pUBXCF7vLY+uyMD5Dbhv++D9n/XnQYvwgn0F8cokU38/UaFL4f
         zRag==
X-Gm-Message-State: AC+VfDyLLGwIkAOS37/9DIUsmxi+Y/EuT7Bqwj4S6lfqX8OGfUUZg6WO
	8RquKo3nH5MdKBqkmrFg3mVK2LDKI/ketUo3b+EcnA==
X-Google-Smtp-Source: ACHHUZ5lVM3rBQYMsSwl1ZV4Nb1nlmzzwn8SEosCeirRzNgYGUo1cUR9zwyGTnuxyAJUwIadfPrUyeHsbLc8/xIjXqw=
X-Received: by 2002:a17:907:168d:b0:969:f677:11b9 with SMTP id
 hc13-20020a170907168d00b00969f67711b9mr35672579ejc.54.1684399359308; Thu, 18
 May 2023 01:42:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230515121521.30569-1-lmb@isovalent.com> <a29c604e-5a68-eed2-b581-0ad4687fda10@linux.dev>
 <CAN+4W8hixyHYOwYRh-3WedS-a0KTQk8VQ4JxqM8y-DQY-yjsNA@mail.gmail.com> <a453c3d4-5615-f445-17a8-92a1dc4282e6@linux.dev>
In-Reply-To: <a453c3d4-5615-f445-17a8-92a1dc4282e6@linux.dev>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Thu, 18 May 2023 09:42:28 +0100
Message-ID: <CAN+4W8iDy8w=aVErrSKA1OqJ7Onv3eszYOKHLr+zucfHRuHsVg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: btf: restore resolve_mode when popping the
 resolve stack
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 18, 2023 at 2:42=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 5/17/23 2:01 AM, Lorenz Bauer wrote:
> > On Wed, May 17, 2023 at 7:26=E2=80=AFAM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
>
> I can see your point to refactor it to make it work for all different BTF=
_KIND.
>
> Other than BTF_KIND_DATASEC, env->resolve_mode stays the same for all oth=
er
> kinds once it is decided. It is why resolve_mode is in the "env" instead =
of "v".
> My concern is this will hide some bugs (existing or future) that accident=
ally
> changed the resolve_mode in the middle. If there is another legit case th=
at
> could be found other than BTF_KIND_DATASEC, that will be a better time to=
 do
> this refactoring with a proper test case considering most bpf progs need =
btf to
> load nowadays and probably need to veristat test also. If it came to that=
, might
> as well consider moving resolve_mode from "env" to "v".
>
> btf_datasec_resolve() is acting as a very top level resolver like btf_res=
olve(),
> so it reset env->resolve_mode before resolving its var member like how
> btf_resolve() does. imo, together with env->resolve_mode stays the same f=
or
> others, it is more straight forward to reason. I understand that it is pe=
rsonal
> preference and could argue either way.

 Okay, let's drop it then :)

