Return-Path: <bpf+bounces-2982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE94737C9B
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 10:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DA48281513
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 08:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A111C2E9;
	Wed, 21 Jun 2023 08:01:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573382AB55
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 08:01:30 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDA8170C
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 01:01:28 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-98934f000a5so199634566b.2
        for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 01:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1687334487; x=1689926487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/uzmr18bm+TTjaklP1XdaDPfpw9sySrUHmwXE1mODw=;
        b=e7vij1IPM9/UbQv7lIkfk8Pums7FuQF+Z4+boaRaq/yOmX5bRKsQ0mrPS3Nymz1VBd
         D5+sCrSIWI15UDJDg3dotNPf8SGLFkWOSu1UaY6atV+NXgkdQTzBpbFcQV7VxSsaJ3XK
         sPzb826AwJaHlXnRoouS1CGTsh4cJz/T9xQ2q1LJBpEBIkQ0yYZHUI+SkzDsny7n1MKx
         8j4OZcdBBOPx/MifQDfJLAkUYJtPabtLnY3FxTzDV0Js4uCMarY+tYYns35KlJX7t4Vr
         6E5qhNN1jySgnuAhgC38rBXoZIRUH+DXXCW8nAGs92odcVULACwpKbPON4RLt2T1EjnU
         APtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687334487; x=1689926487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/uzmr18bm+TTjaklP1XdaDPfpw9sySrUHmwXE1mODw=;
        b=MOWXMmYRSyYy3QAEgzwn1R8685qcIzFZCJ9HoPIxcQsK7K4Fbc2eF44FnG8quN4upM
         H+BDilZOsdwG4LXUHI0k4kdcO7xZfnC4sni5+P1gZmoZIE5hty8AC2NKtOJ65JV44Ytg
         Iuily2I/7ReA7mvdLAzmR/6hXBD3OzNGHC56oMvk33V7oGb2TrpHEmoXYNQpDXvX3g/S
         JVs2vLq5W20xhpPk1uUjzWgezowUoe2R6baQ4lPQfnUPJTt8Gd0iSGqCsTwerlVnTDqR
         iUWk0IgsWQDMelvBmabLR040tLL68h3GpDy5NmdfQmv9Jwvaj+R2iHdy5JgYBxn50zoe
         XboQ==
X-Gm-Message-State: AC+VfDxrDeuX5m6yIng78S6rdAU86HYJxVLfG945NWwmGjXFsxWWcKsD
	gkaW0KO2ezAxifQSv7hSNMTaD8n2epalln4jJaXKdg==
X-Google-Smtp-Source: ACHHUZ6zgnnZUzg5X4rETT0LUikk9eZ0usOgOL/ZRXRSJfQR8fNVFL4zwQoeQchY/gMVrgg7I66L8mMB3WJKnc5S+DQ=
X-Received: by 2002:a17:907:6095:b0:989:1cc5:24a with SMTP id
 ht21-20020a170907609500b009891cc5024amr4346200ejc.13.1687334486859; Wed, 21
 Jun 2023 01:01:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN+4W8ge-ZQjins-E1=GHDnsi9myFqt7pwNqMkUQHZOPHQhFvQ@mail.gmail.com>
 <20230620183123.74585-1-kuniyu@amazon.com>
In-Reply-To: <20230620183123.74585-1-kuniyu@amazon.com>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Wed, 21 Jun 2023 09:01:15 +0100
Message-ID: <CAN+4W8iSA0Y8iEvYg79=CTNvwkQB5qs_F3vjE7vep-eHR01oJw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/6] net: remove duplicate reuseport_lookup functions
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, haoluo@google.com, hemanthmalla@gmail.com, 
	joe@wand.net.nz, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, martin.lau@linux.dev, mykolal@fb.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, sdf@google.com, shuah@kernel.org, 
	song@kernel.org, willemdebruijn.kernel@gmail.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 20, 2023 at 7:31=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> Good point.  This is based on an assumption that all SO_REUSEPORT
> sockets have the same score, which is wrong for two corner cases
> if reuseport_has_conns() =3D=3D true :
>
>   1) SO_INCOMING_CPU is set
>      -> selected sk might have +1 score
>
>   2) BPF prog returns ESTABLISHED and/or SO_INCOMING_CPU sk
>      -> selected sk will have more than 8
>
> Using the old score could trigger more lookups depending on the
> order that sockets are created.

So the result will still be correct, but it's less performant? Happy
to fix a perf regression, but if the result is incorrect this might
need a separate fix?

Best
Lorenz

