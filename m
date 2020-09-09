Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B517262CD5
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 12:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgIIKG3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 06:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgIIKG2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 06:06:28 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DEEC061573
        for <bpf@vger.kernel.org>; Wed,  9 Sep 2020 03:06:28 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id x19so1801317oix.3
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2020 03:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DyUasSaWsuqYqyOyKvhzNc5LKNDVaERwvWWg1aZ0k8g=;
        b=D57FHro8dIPfk9lesNUmgvmTr1UnifpyTfRIT2FEBON1lTQW6ntpO7oW3swXnQaPKO
         1YidovV/H9GbtCWrRdJ5mawLpRkwvNssnAFkXPBkYslE0FWe/HuKa5a7c3xLYXYYMqip
         t/Kb+KSJfJN23AHdLZYQGmtmgsT+droPgf5UU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DyUasSaWsuqYqyOyKvhzNc5LKNDVaERwvWWg1aZ0k8g=;
        b=G2IMGewbukLhKkVn2gxgTJSlTffxoa930MSFQTavH/fqYFUcGOAz9OvVy5ZNpf4n0f
         R8cT5GhQrm2cwmZIoA898zj+AW76/sWgla9yaltfHG1w1IE2ivZf611OUAL0xE+3I3Js
         QlLNnaOGl0bTaOOVtsPkCoRgT9yO2Mhgj5rcvSWBSv0YlZP2osRY2uhIQr2HNV/0C9Vt
         V9y96TKJgwgGnvWFbgGEQhYaCDeNFQwu9HqVw3F3y7Of1d90X1MggDSzEj4db0RnHyhx
         eyVLBNt4+FrIx5bn46AfRpG8iSaAimRHK37ZQh7kmeQuQFAmAvXCkE+uScfKEeA8a7dM
         8SKg==
X-Gm-Message-State: AOAM5311xaiknvrCzfrgngj1t0EcCgnxdoIUcjyGCXK9P+MMWSqiXZci
        kZSrLsd2guSK12/y0jbgctvyfrU8jZg2p5qiM4k5pA==
X-Google-Smtp-Source: ABdhPJwz3egmANBNDZuPjRohf4QCKEI7sO/rdUbaOs87SpmOLdT2Y1AEXBbq7wxUTASB6eq9Hds56s9qcsCcUATHGRg=
X-Received: by 2002:aca:3e8b:: with SMTP id l133mr120814oia.110.1599645987660;
 Wed, 09 Sep 2020 03:06:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200904112401.667645-1-lmb@cloudflare.com> <20200904112401.667645-6-lmb@cloudflare.com>
 <CAEf4BzbPJKK+YPTgPmaUVsKg3GQdwJKypfSZXg09M+sY8BzDbQ@mail.gmail.com> <20200909055654.sge564w5nws5krlj@kafai-mbp>
In-Reply-To: <20200909055654.sge564w5nws5krlj@kafai-mbp>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 9 Sep 2020 11:06:16 +0100
Message-ID: <CACAyw9_6Pksm3d0n5me5A9bpEyh10fkbbDCcg7652xGZO6N2iQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 05/11] bpf: allow specifying a set of BTF IDs for
 helper arguments
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 9 Sep 2020 at 06:57, Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Tue, Sep 08, 2020 at 09:47:04PM -0700, Andrii Nakryiko wrote:
> > On Fri, Sep 4, 2020 at 4:30 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
> > >
> > > Function prototypes using ARG_PTR_TO_BTF_ID currently use two ways to signal
> > > which BTF IDs are acceptable. First, bpf_func_proto.btf_id is an array of
> > > IDs, one for each argument. This array is only accessed up to the highest
> > > numbered argument that uses ARG_PTR_TO_BTF_ID and may therefore be less than
> > > five arguments long. It usually points at a BTF_ID_LIST. Second, check_btf_id
> > > is a function pointer that is called by the verifier if present. It gets the
> > > actual BTF ID of the register, and the argument number we're currently checking.
> > > It turns out that the only user check_arg_btf_id ignores the argument, and is
> > > simply used to check whether the BTF ID matches one of the socket types.
> > >
> > > Replace both of these mechanisms with explicit btf_id_sets for each argument
> > > in a function proto. The verifier can now check that a PTR_TO_BTF_ID is one
> > > of several IDs, and the code that does the type checking becomes simpler.
> > >
> > > Add a small optimisation to btf_set_contains for the common case of a set with
> > > a single entry.
> > >
> > > Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> > > ---
> >
> > You are replacing a more generic and powerful capability with a more
> > restricted one because no one is yet using a generic one fully. It
> > might be ok and we'll never need a more generic way to check BTF IDs.
> > But it will be funny if we will be adding this back soon because a
> > static set of BTF IDs don't cut it for some cases :)
> >
> > I don't mind this change, but I wonder what others think about this.
> With btf_struct_ids_match(), the only check_btf_id() use case is gone.
> It is better to keep one way of doing thing.  The check_btf_id can be
> added back if there is a need.
>
> I think this only existing check_btf_id() use case should be removed
> and consolidate to the bpf_func_proto.btf_id.
>
> Also, for the "struct btf_id_set *arg_btf_ids[5]" change,
> there is currently no use case that a helper can take two different
> btf_ids (i.e. two different kernel structs) at the verification time.
> The btf_id_set will always have one element then.  May be we can cross
> that bridge when there is a solid use case.

Sounds good to me, I'll give this a try.

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
