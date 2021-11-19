Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D638D456891
	for <lists+bpf@lfdr.de>; Fri, 19 Nov 2021 04:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbhKSDX1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 22:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbhKSDX1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Nov 2021 22:23:27 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B39C061574
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 19:20:26 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id y7so7112637plp.0
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 19:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YZA+Aa1dg4lbYaiYjWtjEPIpIpUleKnf2U3Y2yl+Epc=;
        b=VHe/6XWMarNpWih1JqrWRbFEdaLgnoh9UST4FjO1BHfeF36SvQMqQTLo/3+oyqqsgi
         1g9IL1PQdJQ32qrI46tTY9rH1jx/+vhyPlpS49wUOJvmkNSuMonsDrpNF+Fzihg7gaov
         0+VwKUgpTGc6wkgnVSwktaycmKyleO9DXYIyZhYJf+TROZCFCJfTdOZ8C6xRnaWQZ8ft
         sGiHNRcBgjcKQtJBFMtgHehtYNYJNF5Wg+jlWClLdOhNTWm54yoS/pBWzUq8TYwnm1GE
         eFcwHmpt7d4N/jBVuuj/eXhXfntojKubo4Gu8PNP21UwipSyaEMCwG0w+WC1PCJazxqD
         ECMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YZA+Aa1dg4lbYaiYjWtjEPIpIpUleKnf2U3Y2yl+Epc=;
        b=j2dvXCxed/X3fFfHh5GkdeJmVKatKlPgkGbNEZh2fpS/UQTkldtlPbvG4alFrTCcdC
         MpczJ2n6QO4yfwx2NP8RpQf+iyz8C63zAxx8GS0YEQJVn0e0tPMdVC0YwLeb21cEGYgs
         ftmLitqypxLblB3Vo9+Fy+EJTFSDY8xsY36u8D5H9b6P3fphGCqmrMdCjf199GRSMQhb
         JlpKrPuqnT86UuSNnDLvzK1GR+F09utPjvwACpTH/r/SUZKncY0MHZbtJIp5AVFI4h+j
         O6PQs1XRynA/BBoVjFtah4unXWjrNeYaHf5pe7fONB8t6c2j8S1OgcpPVlIaJok5P+/g
         DHgw==
X-Gm-Message-State: AOAM532L0fqH+YRZJ+Uj31w3N2xnpAlv1rvWevX9Ssg+Gc9KyohRSVvo
        NQG9189GjP0menqppQCZ26QiqDao65U=
X-Google-Smtp-Source: ABdhPJwTopaOj/Hw5F9Tr6zIoVUpNqrCs7gseS7n6exeyniIOQ7w6WXgJkPLyzSB6tMtt1kJfms0cg==
X-Received: by 2002:a17:90a:af94:: with SMTP id w20mr515886pjq.223.1637292026287;
        Thu, 18 Nov 2021 19:20:26 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:4e33])
        by smtp.gmail.com with ESMTPSA id g17sm983196pfv.136.2021.11.18.19.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 19:20:26 -0800 (PST)
Date:   Thu, 18 Nov 2021 19:20:24 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 03/12] bpf: Prepare relo_core.c for kernel
 duty.
Message-ID: <20211119032024.kjk5wz3sbr5inaiz@ast-mbp.dhcp.thefacebook.com>
References: <20211112050230.85640-1-alexei.starovoitov@gmail.com>
 <20211112050230.85640-4-alexei.starovoitov@gmail.com>
 <CAEf4BzaY=waUdY2stYjmU=tT92BfqLoSiV7ytE_WX_sCr8RL=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzaY=waUdY2stYjmU=tT92BfqLoSiV7ytE_WX_sCr8RL=w@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 16, 2021 at 04:58:23PM -0800, Andrii Nakryiko wrote:
> >
> > -#define BPF_CORE_SPEC_MAX_LEN 64
> > +#define BPF_CORE_SPEC_MAX_LEN 32
> 
> This is worth calling out in the commit description, should have
> practical implications, but good to mention.

good point.

> 
> >
> >  /* represents BPF CO-RE field or array element accessor */
> >  struct bpf_core_accessor {
> > @@ -272,8 +325,8 @@ static int bpf_core_parse_spec(const struct btf *btf,
> >                                 return sz;
> >                         spec->bit_offset += access_idx * sz * 8;
> >                 } else {
> > -                       pr_warn("relo for [%u] %s (at idx %d) captures type [%d] of unexpected kind %s\n",
> > -                               type_id, spec_str, i, id, btf_kind_str(t));
> > +/*                     pr_warn("relo for [%u] %s (at idx %d) captures type [%d] of unexpected kind %s\n",
> > +                               type_id, spec_str, i, id, btf_kind_str(t));*/
> 
> we can totally pass prog_name and add "prog '%s': " to uncomment this.
> bpf_core_parse_spec() is called in the "context" of program, so it's
> known

Sure.

> >                         return -EINVAL;
> >                 }
> >         }
> > @@ -346,8 +399,8 @@ static int bpf_core_fields_are_compat(const struct btf *local_btf,
> >                 targ_id = btf_array(targ_type)->type;
> >                 goto recur;
> >         default:
> > -               pr_warn("unexpected kind %d relocated, local [%d], target [%d]\n",
> > -                       btf_kind(local_type), local_id, targ_id);
> > +/*             pr_warn("unexpected kind %d relocated, local [%d], target [%d]\n",
> > +                       btf_kind(local_type), local_id, targ_id);*/
> 
> sigh... it's a bit too intrusive to pass prog_name here but it's also
> highly unlikely that this happens (unless some compiler bug or
> corruption) and even in that case it's semantically correct that
> fields just don't match. So I'd just drop this pr_warn() instead of
> commenting it out

makes sense to me. will do.
