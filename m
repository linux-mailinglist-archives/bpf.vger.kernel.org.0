Return-Path: <bpf+bounces-2594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 654BA73040B
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 17:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F189D281499
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 15:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9A610791;
	Wed, 14 Jun 2023 15:43:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6A42C9C
	for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 15:42:59 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F24D1FFF
	for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 08:42:58 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-977e83d536fso121521866b.3
        for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 08:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1686757376; x=1689349376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtT0/eZ+pzVcJ4kjv037r9aHK8XNjhCtUjr9Gr9jvYU=;
        b=ZP/SamkUlMwFjkSD+wrJBR2kE19TzHG8u/731TAnTAmVaSTQXtc0WwSReIL1pIoYyf
         hAj1Fc83SjRkaP/Jd8z+8vJrD7kacBt1WV+EFkP6WCPbUg1TFiUki5IQEAS5cjPTJIfl
         NuAVoDBcAtSqb1N6akK+1QNhFDl0FUCmiUU2J30qDEaelyMgFfmxTcRgPY5ojlK3pt8V
         UILRh0iEMQtUeodX9l9Q6zlGZ8C+tDuwTXnydiJL+4X4PwVEcM3pmQl6eSYDSyZC6CZo
         whkT1upUUDa2NpmYHxgN9lR0xKmCB5JsX4htzUiT/chQYtbB1TGedl3PqHXWnyOmSWGp
         rPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686757376; x=1689349376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtT0/eZ+pzVcJ4kjv037r9aHK8XNjhCtUjr9Gr9jvYU=;
        b=CJGhEGE5iH9QLd9lCW59GIgxcLSAnLBOfEr/TiDWtjX3Div8y3BHT5nCQp2tfyMMP4
         N5ewuAuDeGLg3TPQDo/MbN/QcnDdKc5KZYqQ9VRgy/kULPe5z97vz8tf60CxezxuS7Tt
         ow8G6yhIWwVrVbbEoCjyXChJrp3qvRZmV2RuMToofgQ1TmRk2yrvwXqneBq4Ts5RegyJ
         Qy7J30d4Qkhvg1/LDKhzjEmLhwXtN+T4KX4x+W0VC69rpxv+8JoUny613XJgNJE4ba4s
         XJDFODLnhbvMguFI+8Tst/9Fv2TuwsmaBsshpxD2JuvepflXNcl4dfU2KznWHVypryHN
         cNMA==
X-Gm-Message-State: AC+VfDxPpZfXoga6UTeBJELzeJUC5G2a6EimuPo0uU5a5Ue6KP84nEVR
	LYvdftvA3ndwsKSQgEIqVV45Th7lj3lS7H3UPH66tQ==
X-Google-Smtp-Source: ACHHUZ5MvmIC2GdVwJiGsq0XfnMom2QZJ/Olx8aWbiV58zzX/ROjObQVmYDJgQ/CvJ/oOynYK5NegYFewhrN1Ut0aiU=
X-Received: by 2002:a17:907:6d08:b0:978:992e:efc4 with SMTP id
 sa8-20020a1709076d0800b00978992eefc4mr14322051ejc.8.1686757376686; Wed, 14
 Jun 2023 08:42:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230613-so-reuseport-v2-0-b7c69a342613@isovalent.com>
 <20230613-so-reuseport-v2-3-b7c69a342613@isovalent.com> <ZIiMKgt6iQwJ6vCx@corigine.com>
In-Reply-To: <ZIiMKgt6iQwJ6vCx@corigine.com>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Wed, 14 Jun 2023 16:42:45 +0100
Message-ID: <CAN+4W8jTTQqz2Fgzz4AndzpEo=Xteqisv88HqQu=j_VPcu3OVQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/6] net: remove duplicate reuseport_lookup functions
To: Simon Horman <simon.horman@corigine.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Joe Stringer <joe@wand.net.nz>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Hemanth Malla <hemanthmalla@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 13, 2023 at 4:33=E2=80=AFPM Simon Horman <simon.horman@corigine=
.com> wrote:
> >
> > +INDIRECT_CALLABLE_DECLARE(u32 udp_ehashfn(const struct net *,
> > +                                       const __be32, const __u16,
> > +                                       const __be32, const __be16));
> > +
>
> Hi Lorenz,
>
> Would this be better placed in a header file?
> GCC complains that in udp.c this function is neither static nor
> has a prototype.

Hi Simon,

The problem is that I don't want to pull in udp.h in
inet_hashtables.c, but that is the natural place to define that
function. I was hoping the macro magic would solve the problem, but oh
well. How do you make gcc complain, and what is the full error
message?

Thanks
Lorenz

