Return-Path: <bpf+bounces-4386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B605174A8CC
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 04:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720F8281413
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 02:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0617C1849;
	Fri,  7 Jul 2023 02:12:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11E37F;
	Fri,  7 Jul 2023 02:12:35 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0A61709;
	Thu,  6 Jul 2023 19:12:34 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b63e5f94f1so17041791fa.1;
        Thu, 06 Jul 2023 19:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688695952; x=1691287952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g29HbjlInMm5GWf20SLKYiHPaA8+w9L8CPsHRxnmhMc=;
        b=MgIzkSWt73UFF5aaLJwcx3GT5FndhEr2/TbF5am8s/c+crFKed/jK0usGcIKQTmEGG
         ys0TeuX78+EOYd+x0+SHyZ0eSL9JmhHj1u1nc4Cr6D0Lns4ufO59WfkHDqLpmFwxoshi
         B7rgqHCc8ytf+n2P7xEPbcXN7fvgHCvhgNPFhtFIpbtf5pwM1SCVKz8UpVbbtwoZVpxe
         9KPDe+lZBqlbmbPCsn/6LFvY9pOqnL+PYHII1SJKmeSHp1aMxuZWG7oeOBC2L/5cXIs3
         /Qu2BVn/b0h+DZhH+d4uVouPXPsqmVl/zC3vMc2FEaF/SMxRZ5ICQHrKZt0L0Cd1ciLt
         +N8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688695952; x=1691287952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g29HbjlInMm5GWf20SLKYiHPaA8+w9L8CPsHRxnmhMc=;
        b=lnexgHBHf59+s9qGBqXjG5a+uJql22lwb5GBkf0qbgFciVO8vyLBNqOPsMeVCCetax
         jxGQN8YIpY2HAUxq4+ighOIO10E6e8t7wS/uWyfCIWIC+h1hvYt7Iu2KMemGCxxziIJq
         jE9/ZxpwQA5REKf56lfRcho313CM746CX5FbWDU/Omnw/JUStsTskkoS+fwr5m78zwt3
         mxdqIcyOsFzQbQeWDVfjbRnAQuiVen1xy9NRvyzRDMtViVIcn7LSW0PTDGEWnTmo4xd/
         qFxx7pKC7IDEUqTDDc+yYH+XoRWJYOfliQ3OabdJt1UZ2oZa1t7V7wGTnJndK+Nj9Pul
         uvNg==
X-Gm-Message-State: ABy/qLa1lUlEyS0g3/iBYZ2eOKmWAXUL1LHKI9sTjakF9cYtFfWAv7k1
	Se2ovnllP/Se0BkXIttQFf9Mk8Q9WxP03Dh2vdU=
X-Google-Smtp-Source: APBJJlHdPrAmzpOlhStJIEu3wVJMtHEsNI+KlkrwpbEGiaO5ioCaIyIKOY9q3vG3RtCkxndsXbdAm8qIdMvUO7fLXvc=
X-Received: by 2002:a2e:8546:0:b0:2b6:cecb:c4a3 with SMTP id
 u6-20020a2e8546000000b002b6cecbc4a3mr1256109ljj.23.1688695952184; Thu, 06 Jul
 2023 19:12:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230706033447.54696-1-alexei.starovoitov@gmail.com>
 <20230706033447.54696-10-alexei.starovoitov@gmail.com> <fe733a7b-3775-947a-23c0-0dadacabdca2@huaweicloud.com>
In-Reply-To: <fe733a7b-3775-947a-23c0-0dadacabdca2@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 6 Jul 2023 19:12:21 -0700
Message-ID: <CAADnVQJ3mNnzKEohRhYfAhBtB6R2Gh9dHAyqSJ5BU5ke+NTVuw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 09/14] bpf: Allow reuse from
 waiting_for_gp_ttrace list.
To: Hou Tao <houtao@huaweicloud.com>
Cc: Tejun Heo <tj@kernel.org>, rcu@vger.kernel.org, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@fb.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, David Vernet <void@manifault.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 6, 2023 at 7:07=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> Hi,
>
> On 7/6/2023 11:34 AM, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > alloc_bulk() can reuse elements from free_by_rcu_ttrace.
> > Let it reuse from waiting_for_gp_ttrace as well to avoid unnecessary km=
alloc().
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  kernel/bpf/memalloc.c | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> >
> > diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> > index 9986c6b7df4d..e5a87f6cf2cc 100644
> > --- a/kernel/bpf/memalloc.c
> > +++ b/kernel/bpf/memalloc.c
> > @@ -212,6 +212,15 @@ static void alloc_bulk(struct bpf_mem_cache *c, in=
t cnt, int node)
> >       if (i >=3D cnt)
> >               return;
> >
> > +     for (; i < cnt; i++) {
> > +             obj =3D llist_del_first(&c->waiting_for_gp_ttrace);
> > +             if (!obj)
> > +                     break;
> > +             add_obj_to_free_list(c, obj);
> > +     }
> > +     if (i >=3D cnt)
> > +             return;
>
> I still think using llist_del_first() here is not safe as reported in
> [1]. Not sure whether or not invoking enque_to_free() firstly for
> free_llist_extra will close the race completely. Will check later.

lol. see my reply a second ago in the other thread.

and it's not just waiting_for_gp_ttrace. free_by_rcu_ttrace is similar.

