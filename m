Return-Path: <bpf+bounces-7248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACCA773ED6
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 18:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AE431C20ED0
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 16:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754B814A86;
	Tue,  8 Aug 2023 16:37:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9E914A97
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 16:37:04 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBB0F1DBC
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 09:36:49 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-997c4107d62so818330266b.0
        for <bpf@vger.kernel.org>; Tue, 08 Aug 2023 09:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1691512570; x=1692117370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bw2MRgpkFm1vILiE0Y5MYyZNNxscMVN+eqSvqqHwK4=;
        b=EePW+ss015g11YgFFHMy90Z5WBj/PCKy6a/lhF3ExOntSwvl8wOFfJQ1JbeQoQrrOx
         xGv9mUGakIoi++O8fmZPptc9lYFC2bKDg9uXW/+1Mxi9bbiHs3cBrG5MKCqPjOigSNk/
         6O3T2Scei8koWcY2M/Eaj3ZH5HH0kvS2OwUipqKRF44XHNPvdm7NRKse4GbRIsRU3CNw
         MHRQ4gStC0CIZh/3TmsijzYoIO2grgcREPRoC80135uNlMXE9RheTTzhehwkkqfMOILw
         IG+BZkUNI0ZVxYlQC6LMviOYgjd4hQSn16di8r9dqB6kv/iUsDpTXsLNS+LLy0b/jFrX
         XBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691512570; x=1692117370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bw2MRgpkFm1vILiE0Y5MYyZNNxscMVN+eqSvqqHwK4=;
        b=UHssbm3XWaML6IUELu7Ad8XE9aaieMfPGD0OUkpj7LR2BArXZQmV5yuUpux12eoz2M
         eBOnFHwk4zGnbitTsizlM7DUzGY8PwT/ufaKJuIQhGupqjZfpFfbPYW2l/gGQV7ibzKO
         Ymr3d8oAbJCBmn06r/uRc2zGPAVC/jQLEdYClTwdvfanYs5jfUs4u7GqZAe2LdYZ8Dob
         0hnBbhC27LvpbMIlACBw0XGL0KV9Q2wArS4gFs1wStO3Proc7Q6TIq/KquPiREACxWRG
         w5unJUZxr2onEjbzgG1S/yXc7LDQjVfAzJGMxeqpTqREXdFBZaqWd1AR/qZC35z5fzLk
         SvPQ==
X-Gm-Message-State: AOJu0YzJN+wuKvDU3GHdi8ZCkbtI5yA/PszsI39s7EemWMLenBJIgN7d
	5AjsyY5E+cBnxeQfUmx5DCjd+a2JEhq/6jdjexuO+g==
X-Google-Smtp-Source: AGHT+IGyc5YFMEUdUm3mgxMUbhzIYZxUjCAeYEgPYwAXs5W80a27H3BIhOB0Da8QtwlqT/aZI8FmyxUNTteHqh8I214=
X-Received: by 2002:a17:906:217:b0:98d:4000:1bf9 with SMTP id
 23-20020a170906021700b0098d40001bf9mr85402ejd.65.1691512570147; Tue, 08 Aug
 2023 09:36:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230720-so-reuseport-v6-0-7021b683cdae@isovalent.com>
 <20230720-so-reuseport-v6-7-7021b683cdae@isovalent.com> <CAP01T76fZhrELGxsm5-u85AL5994mS0NGZd6gw-RYaHE8vKfTA@mail.gmail.com>
In-Reply-To: <CAP01T76fZhrELGxsm5-u85AL5994mS0NGZd6gw-RYaHE8vKfTA@mail.gmail.com>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Tue, 8 Aug 2023 17:35:59 +0100
Message-ID: <CAN+4W8j7Lyh4Zm1neabe2f+DJWbP4zRrATM4rwD3=EBS0s1CjA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 7/8] bpf, net: Support SO_REUSEPORT sockets
 with bpf_sk_assign
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
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
	linux-kselftest@vger.kernel.org, Joe Stringer <joe@cilium.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 8, 2023 at 5:23=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> Hi Lorenz, Kuniyuki, Martin,
>
> I am getting a KASAN (inline mode) splat on bpf-next when I run
> ./test_progs -t btf_skc_cls_ingress, and I bisected it to this commit:
> 9c02bec95954 ("bpf, net: Support SO_REUSEPORT sockets with bpf_sk_assign"=
)

Thanks for the report. I forgot about struct request_sock again...
I'll have a fix shortly, I hope.

Lorenz

