Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D7B265CAA
	for <lists+bpf@lfdr.de>; Fri, 11 Sep 2020 11:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725710AbgIKJl1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Sep 2020 05:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgIKJlZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Sep 2020 05:41:25 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34923C061573
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2020 02:41:23 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id c13so8854694oiy.6
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2020 02:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dj1Up3Tml3GHc+qIEXaj4k6tm+Wtwnc13bHQ4K0nH2A=;
        b=kWnlk6AxCwgy+dBkDaqAEqqUsnrYFWszanPA7rcn6NMN5PHpioTksN4w5Cg8tJdQsh
         FXcJrkPC1xIOCCwlCTsUISNtgJzaTH2PQfw44KdmtBX8z3nCdSK4VkZBuAW9Z48+vC3y
         6xrJuKKtsM/zTcJb/xwORqsfoRwXDnGf2NnEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dj1Up3Tml3GHc+qIEXaj4k6tm+Wtwnc13bHQ4K0nH2A=;
        b=R1/4uz7TRLzaY1Psje1gh+t40ZqAwTbkcdeo7Uz/nfOE2IE01hx1p0k8GmONGDv1/r
         CziTTMC8dor4OBOxlXN1Usm33e4V4Ib95Iw1MencQA8RwpytIfuJgNOUTneQbKu8It/J
         /11p6GbgUNYgGmdlANufRDYkgtSykkJBIHRIy3ZA66LgU9KEti7Q4kF2JPlJyLgWH5pv
         elgYXXaax6guEruLDvVAj/YKHPY6R8tpY5oSnoQEkGrfrBaLYDXzYPpRJXNxgbx5DwpU
         fqk7UqK4f3kNE9JbB4n2O50qOGc/CLdcD6CgleAlk615TwtA+QVr34IQZXW+EbUxjwaM
         +Q2g==
X-Gm-Message-State: AOAM530mpemtxv5/GWC5v/23t2ky1imIioD2Zl7Q0xyyCZ1VAjLrBI4d
        wSu8dmYay6vCiYAywTkIuu66UFDZ5uxm7xBj/BtDrQ==
X-Google-Smtp-Source: ABdhPJzxKAFOZmGq5OV2BE4qGtrOs+klNitLxceegJJDSLcuOkcsrauazxMvfonrsXuPtvc03x3eE0ZXBvhKjYEgKRE=
X-Received: by 2002:aca:3e8b:: with SMTP id l133mr794528oia.110.1599817282341;
 Fri, 11 Sep 2020 02:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200910125631.225188-1-lmb@cloudflare.com> <20200910125631.225188-5-lmb@cloudflare.com>
 <20200910175839.su73mcscacfmrzhn@kafai-mbp>
In-Reply-To: <20200910175839.su73mcscacfmrzhn@kafai-mbp>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Fri, 11 Sep 2020 10:41:11 +0100
Message-ID: <CACAyw99sJ5aGk3W3a+iz3KBfTxne3R0DELqyjoGgzqBR6MaLRA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 04/11] bpf: allow specifying a BTF ID per
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

On Thu, 10 Sep 2020 at 18:59, Martin KaFai Lau <kafai@fb.com> wrote:
>
[...]
> > +
> > +             if (!btf_struct_ids_match(&env->log, reg->off, reg->btf_id, *btf_id)) {
> > +                     verbose(env, "R%d has incompatible type %s\n", regno,
> > +                             kernel_type_name(reg->btf_id));
> The original log has the expected kernel type also which will be a useful info.
> It could be a follow up.
>
> Acked-by: Martin KaFai Lau <kafai@fb.com>

Good idea. I'll way for feedback from Daniel or Alexei, and roll it
into a v4 or do a follow up.

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
