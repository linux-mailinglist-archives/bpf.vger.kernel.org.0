Return-Path: <bpf+bounces-2093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CA872761E
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 06:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9449528162A
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 04:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215A61396;
	Thu,  8 Jun 2023 04:30:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE54B628
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 04:30:56 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE6E2680;
	Wed,  7 Jun 2023 21:30:54 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b1b72dc2feso886951fa.3;
        Wed, 07 Jun 2023 21:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686198653; x=1688790653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OE9R4OpDBmY/ZEKRpjJ+jXLtRrcCOtHc/gOShUxPD5I=;
        b=EGMPdTdkFpAQkAsiaPsDmbfsn98yQuQZ7Un0TRx27tvxY2b/xjnl2xXedGmJXq5q2w
         ksW45wgxTMZshV6S6Rbscg5IiAc0dheh974sXJ0XjpudyuoRX4wJXlO41eVxLfUXGzeS
         MucM1RsGkGGqKwM8dmyCHWFs/OUbAAe7a2jUrQ3RkiUkzS8D7ag2yV81E59Rcr4gT/+5
         +zUha3L403+DQbF+P/BAESmqzbIIxP9lxWx90z1mTU8XHmQexlfDJVkbHPTzjRN55Qku
         rZ9vBG+nI95YERQmm0TiZeRTCflYFT4RNK2+6k7mtm3SVu4QzhOMGIsuqCY6ZQeqYVqr
         smDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686198653; x=1688790653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OE9R4OpDBmY/ZEKRpjJ+jXLtRrcCOtHc/gOShUxPD5I=;
        b=aM5/Lv7NgkX/dZbNCFKZYr/eQBm33sEZAcvfhlsJjX5GgzOBwmIIW7zKaQw23u/r6p
         E9l04thT8sKOZU/S5ykLssxJfF3PM3kFI0W7wwNtkyR4MmC2CoDD2K+RjW60quXGlcKB
         mjjA6EpbJXx93oUO9vlqcHgv3QhPFSDbfgWYCC9D04kFMfolrmMZRRwT6qeOwvB+QH8s
         RAaM+VvWE9P3ujvladSmeJZGF1FQd34hJ915jC/F8ZYU2HCP+COukePooz1XcmaLHqh+
         akh6r9hav1atHcRuykCcgxif8o3aZPHFZvxEXBaQpORbXIPjZQYtZzxhHska2PDc+nO4
         SS5w==
X-Gm-Message-State: AC+VfDz9NkH3WfODgjmVF/a5MFdT65SNM7DcGiJZmlKF2uVofEn6BdxN
	s8BUYhfVWSEUu8rRyhE3eLsdjs7Xqml/R/6XdPY=
X-Google-Smtp-Source: ACHHUZ6BT5X78UjW8S7AV6Tq3B1i47mZi50VLV40yUpPK/wb0YyKYi+PgmpdF97qcD4FLX43QU8WDzcv2cT9ioBCkqs=
X-Received: by 2002:a2e:b6c8:0:b0:2aa:3cee:c174 with SMTP id
 m8-20020a2eb6c8000000b002aa3ceec174mr3264847ljo.13.1686198652509; Wed, 07 Jun
 2023 21:30:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230606035310.4026145-1-houtao@huaweicloud.com>
 <f0e77d34-7459-8375-d844-4b0c8d79eb8f@huaweicloud.com> <20230606210429.qziyhz4byqacmso3@MacBook-Pro-8.local>
 <9d17ed7f-1726-d894-9f74-75ec9702ca7e@huaweicloud.com> <20230607175224.oqezpaztsb5hln2s@MacBook-Pro-8.local>
 <CAADnVQJMM2ueRoDMmmBsxb_chPFr_WCH34tyiYQiwphnDhyuGw@mail.gmail.com>
 <CAADnVQJ1njnHb96HfO4k48XDY9L3YXqQW1iUW=ti5iBNKKcE9A@mail.gmail.com>
 <55f5e64d-9d9e-4c65-8d1b-8fd4684ee9a3@paulmck-laptop> <CAADnVQLps=4CjVbZN6wfFWS9VnPE=1b4Gqmw-uPeH5=hGn_xwQ@mail.gmail.com>
 <3bddb902-de45-47d9-b9a2-495508133522@paulmck-laptop> <CAADnVQLhuBggNQxipbRM+E9fQ4wScYmg7-NWjfqAZyA5asw3JQ@mail.gmail.com>
 <a12008e9-f3f7-5050-e461-344d9d86e48f@huaweicloud.com>
In-Reply-To: <a12008e9-f3f7-5050-e461-344d9d86e48f@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 7 Jun 2023 21:30:41 -0700
Message-ID: <CAADnVQ+a4Ng0TEoK7W+KG1JfMvjzhdBNtSOx_2z0Mi=Fz1A0PA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v4 0/3] Handle immediate reuse in bpf memory allocator
To: Hou Tao <houtao@huaweicloud.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, rcu@vger.kernel.org, 
	"houtao1@huawei.com" <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 7, 2023 at 8:36=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> below. And Alexei, could you please also try the hack below for your
> multiple-rcu-cbs version ?

Before any further experiments... please fix the bench in patch 2.
Make sure it exits out of RCU CS after no more than 64 map_update_elem.
Just send that patch alone.

