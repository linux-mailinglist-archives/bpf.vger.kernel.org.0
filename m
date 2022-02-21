Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140D74BE863
	for <lists+bpf@lfdr.de>; Mon, 21 Feb 2022 19:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380274AbiBUQX0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Feb 2022 11:23:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380246AbiBUQXV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Feb 2022 11:23:21 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D51227174
        for <bpf@vger.kernel.org>; Mon, 21 Feb 2022 08:22:57 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id q11so3486617pln.11
        for <bpf@vger.kernel.org>; Mon, 21 Feb 2022 08:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xg7JmizVPqf+gO1VsEhCzsIdG3QaagjcZdM/9dJtk24=;
        b=Mdb7exeSd5jZXK0KyxCFWdEAQzafTtNUYZVnoigoKLgoOofKsp4QWBjZSYbCT6Ga7l
         KqqxPiLwIdSx6FfiYD/8dZpS5UiNkATjNdM6JNlZeokfhN84/UGeMZMQ5B7eHjA0Qth0
         uIkaieZ2hDzw7UaBQAE3NP9L2IqoVE44MjTLVqjRAPdUlk9C6AztCc6/VWT7t8ALPKid
         mrkw6kDOv6b5/dE/gHqbxLhTF5F98rJLMSwi6acSx6e8bxcA1JeDTkT6aw2O+H3SNwtD
         vRRLdIVNlIe+oJ02pEUVdMq9EmkBEmg3hADqVFvDFPZt63Y30laDkMvGkOiLAI09YtCt
         aMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xg7JmizVPqf+gO1VsEhCzsIdG3QaagjcZdM/9dJtk24=;
        b=HTFemhQ7gdFCK+ZfvO4I6p6YlwQE01NMQoXWuUMhiRtApp9bWKIvh4BqX0MchyLbWA
         vthtYniphSbQNKTX3D1hiSPvJUpdy+ONARqmY+KfSP9KQzdW4nWyJR6P7vIPwIicWq23
         Y9brr4yL2lyaVRF0dhzLT7IiIOoTqoW0m5DxZWYPvkKLNqdeYGmpqQa3JbfM8hUhPmm6
         hu7WBk4oqGTLQ3+wobExEfk6oPFWAAOg/CXT/iBMLVrtPAT4qhweiBCVAkjJLBB/JaDq
         4uOkVyO8adObxwjHGku5UV8vhTwPfdoFB3rRx3yTSnDMBlOY9890qCj3vkfNcOUABJTi
         7ujw==
X-Gm-Message-State: AOAM533LXSwEcah/iZP+ChdHjuICJJKnlR41T2T4Y2hs+fQVIWyb9MAH
        Zoim/i4FM9V9QXKIh345cEE=
X-Google-Smtp-Source: ABdhPJwgdocjW70ZBo5Vrw0Ky9CZLhxf93XZ1+bHcgrka0fN18rFGfJhF6fUnfA4xpKTJbMRt662xw==
X-Received: by 2002:a17:902:bd45:b0:14d:98e5:9899 with SMTP id b5-20020a170902bd4500b0014d98e59899mr19530371plx.79.1645460577071;
        Mon, 21 Feb 2022 08:22:57 -0800 (PST)
Received: from localhost.localdomain ([223.212.58.71])
        by smtp.gmail.com with ESMTPSA id z15sm13097180pfh.82.2022.02.21.08.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 08:22:56 -0800 (PST)
From:   Yuntao Wang <ytcoode@gmail.com>
To:     andrii.nakryiko@gmail.com
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, john.fastabend@gmail.com, kafai@fb.com,
        kpsingh@kernel.org, songliubraving@fb.com, yhs@fb.com,
        ytcoode@gmail.com
Subject: Re: [PATCH bpf-next] libbpf: Remove redundant check in btf_fixup_datasec()
Date:   Tue, 22 Feb 2022 00:22:50 +0800
Message-Id: <20220221162250.245059-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <CAEf4BzYYvHBbTKySwy-G9WttuWL1SD=S7RM=D39K8nfd-A_wCQ@mail.gmail.com>
References: <CAEf4BzYYvHBbTKySwy-G9WttuWL1SD=S7RM=D39K8nfd-A_wCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Feb 20, 2022 at 12:19 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sun, Feb 20, 2022 at 12:15 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>
> > On Sat, Feb 19, 2022 at 11:29 PM Yuntao Wang <ytcoode@gmail.com> wrote:
> > >
> > > The check 't->size && t->size != size' is redundant because if t->size
> > > compares unequal to 0, we will just skip straight to sorting variables.
> > >
> > > Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> > > ---
> > >  tools/lib/bpf/libbpf.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index ad43b6ce825e..7e978feaf822 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> > > @@ -2795,7 +2795,7 @@ static int btf_fixup_datasec(struct bpf_object *obj, struct btf *btf,
> > >                 goto sort_vars;
> > >
> > >         ret = find_elf_sec_sz(obj, name, &size);
> > > -       if (ret || !size || (t->size && t->size != size)) {
> >
> > t->size check is redundant, but  (t->size != size) is not
>
> ah, never mind :) applied to bpf-next
>
> >
> > > +       if (ret || !size) {
> > >                 pr_debug("Invalid size for section %s: %u bytes\n", name, size);
> > >                 return -ENOENT;
> > >         }
> > > --
> > > 2.35.1
> > >

Thanks for your reply.

It seems that the patch has not been applied to bpf-next yet,
I can't find it in the commits on the master branch.

Is there anything else I need to do?
