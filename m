Return-Path: <bpf+bounces-5120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB013756973
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 18:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 873CB2811AB
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 16:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6CE1855;
	Mon, 17 Jul 2023 16:45:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAE410E7
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 16:45:06 +0000 (UTC)
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACFC188
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 09:45:05 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 2adb3069b0e04-4fa48b5dc2eso7646522e87.1
        for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 09:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689612304; x=1692204304;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VzVfo3zjBI0pSTWTk0H6RFokCEQ5Oy1HPfPL8xTaH3A=;
        b=pvn66w3/oBBt8jMDGwnsv0xO/n+oqrd1eq+M2tgi6s6RpDgzL03za7OLoMSHg7G0GE
         90Ahr/InmJAolj7dyGvcb6qeC1VmWFhJTcjLFZpPGHsuXkfsUcf/o77xUkDAhGMp7I+Q
         Qvi2hV3k97z2jrTs4lyzl9s05E+Aq0Xp17JqylKQgc/sFeJMVTE4oZq/fJpm/ckyYOtS
         3bz6yysIJMDhggg+e8JDiJPkElgEUXmBzsFMAqZl09nu09BWl5qh1SsL81gsQGOLcuqR
         /Nl8kNy0lvM5Kc+4PgzRRAlgT80pwOSCOItDuFLiQGnHfCl9roUXp6pXn2akgXvk8HUB
         HhxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689612304; x=1692204304;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VzVfo3zjBI0pSTWTk0H6RFokCEQ5Oy1HPfPL8xTaH3A=;
        b=MdWxwP11/B//WfxmbiRcXB/jymrUfBcBpXF22yYXWpixY0g8Gw9nrt2ETGkjzZ0Ji3
         NN0nxk7xkJK5w7JjsMeUUiOS5u3faHpbk2NQUS8rAsltmZ9WEKyuLzXxkj9hGA4iY1qh
         LTOHj5kyb5NfsJen5sbfDo/WMS04kXsKdxeUHmiQGTUHDssFpz6XJ+mOsxOxkd1WRIq4
         x7Uym3KvuM0i7xG/8R3FVsQT5IP2IqMux2a6rQ6mBmZ9BFIS/rA2yE9PakJ6Nq6HyHAB
         5nW8OXJv8d1hyirDCQ9CRyAkXDInZgeLQztyFKvR0L8FV8QSqaNU4yXn0v08OhxGvj7J
         O5Zg==
X-Gm-Message-State: ABy/qLYbEKJIMc8tDN75udMHhiKn2lRZjr9C5MBSIgwcJR5pU/jjMcWZ
	bb4PuTU21UMxNqTrUfvktisDlUzYWjtr5eWfQEk=
X-Google-Smtp-Source: APBJJlFW4difg8KkvRGMeFltimaNMe4nl/vqpuYGhkYqugpC5geM0MAhQR4DNe8cocJWslQ+mAX7SXwiOwOsqZrWue0=
X-Received: by 2002:a19:ca4e:0:b0:4f8:6882:ae9d with SMTP id
 h14-20020a19ca4e000000b004f86882ae9dmr7914687lfj.69.1689612303703; Mon, 17
 Jul 2023 09:45:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230713023232.1411523-1-memxor@gmail.com> <20230713023232.1411523-7-memxor@gmail.com>
 <20230714225149.f3uy4oimdi6a5etu@MacBook-Pro-8.local>
In-Reply-To: <20230714225149.f3uy4oimdi6a5etu@MacBook-Pro-8.local>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 17 Jul 2023 22:14:23 +0530
Message-ID: <CAP01T77DnfHOEh5Rfw_38SMEp2kHG_aUHO_=osagN6gqcmUszQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 06/10] bpf: Implement bpf_throw kfunc
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, 15 Jul 2023 at 04:21, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jul 13, 2023 at 08:02:28AM +0530, Kumar Kartikeya Dwivedi wrote:
> > diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
> > index 209811b1993a..f1d7de1349bc 100644
> > --- a/tools/testing/selftests/bpf/bpf_experimental.h
> > +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> > @@ -131,4 +131,10 @@ extern int bpf_rbtree_add_impl(struct bpf_rb_root *root, struct bpf_rb_node *nod
> >   */
> >  extern struct bpf_rb_node *bpf_rbtree_first(struct bpf_rb_root *root) __ksym;
> >
> > +__attribute__((noreturn))
> > +extern void bpf_throw(u64 cookie) __ksym;
> > +
> > +#define throw bpf_throw(0)
> > +#define throw_value(cookie) bpf_throw(cookie)
>
> Reading the patch 10 I think the add-on value of these two macros is negative.
> If it was open coded as bpf_throw(0); everywhere it would be easier to read imo.

Ack, I will drop the macros.

