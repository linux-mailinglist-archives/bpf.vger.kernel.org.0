Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08783265492
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 23:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725287AbgIJV6l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 17:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730104AbgIJLmi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Sep 2020 07:42:38 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1D6C0617A3
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 04:36:16 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id e23so5042251otk.7
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 04:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v7qU59td4f/wfIVmYHr+2m6mJskxyiXGH+oQIfVprO8=;
        b=Ao2yLx67/bQYk2S+RnsOt6h3DukZgONMuNmdXmf9A9QTrze05mpdmk7D0F7tKkrWH1
         hgYnGT0jSEfI8qtLtQFFlTuz1EHobjeORSzvGD8xaJtWZiSvSpROfgXXs5drL4py123H
         9Yzjrxe9HAyY4feBnSdK/Wh5JHArWzz/g70PE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v7qU59td4f/wfIVmYHr+2m6mJskxyiXGH+oQIfVprO8=;
        b=cWofemeS3ormodkTcwpKCLCY/uGs5cPAZZ8PUNTzJ5O5GlZ9Soq1o8ltEVuvc+E28I
         6DeVcmf7kxUBkk7Zk//omQgkm/G9K4KtaMB1FjBPd3QVe8yxSzE0AdWq8jMhSMFoOL3t
         zTScLz/JkIUXO8uL9EUiVP7VDkUbA70FJJ9MvrEjrV/KuCUkFdPIjnzkbMgkiFEbXwQu
         vAgTUVP1OfRXWhm3UANqrPuetfghO4XpEEnfrmhMlt42ekTEBe9ykFFt0EBG7PL8b8xO
         MrtbzCF8s+XnBAgqor9Rot5BLa+VgEPaRVDDiXZMA8CLEh1/fyxOHIsuKKEiQP/y5AjQ
         MEgg==
X-Gm-Message-State: AOAM533nxFpx1IZ8TrKcvnm100LRN5FBweYK2hs/g2h75ZjckxKlhTwm
        hFBWBRc0rfgieOWYSO3RkvP7bZdS93WkWy43hUaWEg==
X-Google-Smtp-Source: ABdhPJzcPj4jfOIFf0QrmMNVaoPiv6JOcF24wmiNkSG7ALAOPaOEoHnBaNyo5/+NKfJnyagohoElQc/IevflZUtmmyo=
X-Received: by 2002:a05:6830:12c7:: with SMTP id a7mr3801466otq.334.1599737775957;
 Thu, 10 Sep 2020 04:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200909171155.256601-1-lmb@cloudflare.com> <20200909171155.256601-5-lmb@cloudflare.com>
 <20200909200309.psebk7iweqmugkcu@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20200909200309.psebk7iweqmugkcu@kafai-mbp.dhcp.thefacebook.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Thu, 10 Sep 2020 12:36:04 +0100
Message-ID: <CACAyw99Ny4Y_KifNRF4HDW1BYbw16D+nqtnkDuA2xfg1HS0-VA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 04/11] bpf: allow specifying a BTF ID per
 argument in function protos
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 9 Sep 2020 at 21:03, Martin KaFai Lau <kafai@fb.com> wrote:
>
[...]
> > @@ -4002,29 +4001,23 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> >                               goto err_type;
> >               }
> >       } else if (arg_type == ARG_PTR_TO_BTF_ID) {
> > -             bool ids_match = false;
> > +             const u32 *btf_id = fn->arg_btf_id[arg];
> >
> >               expected_type = PTR_TO_BTF_ID;
> >               if (type != expected_type)
> >                       goto err_type;
> > -             if (!fn->check_btf_id) {
> > -                     if (reg->btf_id != meta->btf_id) {
> > -                             ids_match = btf_struct_ids_match(&env->log, reg->off, reg->btf_id,
> > -                                                              meta->btf_id);
> > -                             if (!ids_match) {
> > -                                     verbose(env, "Helper has type %s got %s in R%d\n",
> > -                                             kernel_type_name(meta->btf_id),
> > -                                             kernel_type_name(reg->btf_id), regno);
> > -                                     return -EACCES;
> > -                             }
> > -                     }
> > -             } else if (!fn->check_btf_id(reg->btf_id, arg)) {
> > -                     verbose(env, "Helper does not support %s in R%d\n",
> > -                             kernel_type_name(reg->btf_id), regno);
> >
> > +             if (!btf_id) {
> > +                     verbose(env, "verifier internal error: missing BTF ID\n");
> check_func_proto() could be a better place for this check.

The wrinkle here is that this also protects from someone adding PTR_TO_BTF_ID to
compatible_reg_types without specifying a btf_id. I want to do that for
ARG_PTR_TO_SOCK_COMMON_OR_NULL in a follow up, so I think the test here makes
sense.

However, I think ensuring btf_id in check_func_proto in addition to
this is a good idea.

[...]

> > diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> > index a0d1a3265b71..442a34a7ee2b 100644
> > --- a/net/core/bpf_sk_storage.c
> > +++ b/net/core/bpf_sk_storage.c
> > @@ -357,6 +357,7 @@ const struct bpf_func_proto bpf_sk_storage_get_proto = {
> >       .ret_type       = RET_PTR_TO_MAP_VALUE_OR_NULL,
> >       .arg1_type      = ARG_CONST_MAP_PTR,
> >       .arg2_type      = ARG_PTR_TO_SOCKET,
> > +     .arg2_btf_id    = &btf_sock_ids[BTF_SOCK_TYPE_SOCK_COMMON],
> This change is not needed.  It is not taking ARG_PTR_TO_BTF_ID.
>
> >       .arg3_type      = ARG_PTR_TO_MAP_VALUE_OR_NULL,
> >       .arg4_type      = ARG_ANYTHING,
> >  };
> > @@ -377,21 +378,18 @@ const struct bpf_func_proto bpf_sk_storage_delete_proto = {
> >       .ret_type       = RET_INTEGER,
> >       .arg1_type      = ARG_CONST_MAP_PTR,
> >       .arg2_type      = ARG_PTR_TO_SOCKET,
> > +     .arg2_btf_id    = &btf_sock_ids[BTF_SOCK_TYPE_SOCK_COMMON],
> Same here.

Don't know where these came from, sorry.

--
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
