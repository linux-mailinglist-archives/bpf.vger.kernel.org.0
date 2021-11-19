Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73F84568A3
	for <lists+bpf@lfdr.de>; Fri, 19 Nov 2021 04:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhKSDfp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 22:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbhKSDfp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Nov 2021 22:35:45 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF622C061574
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 19:32:44 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id n8so7080434plf.4
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 19:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wRcBwa8DlrTCSLSfTO71U9xpzPe9QA0AUmHELWEieU8=;
        b=edoX6YT68OeT3XEpvYqJPp76EjYkUgtk7ksRR1lpVpQmItkGWp9bOx56pkrHJ2pLmM
         x7qrvNB3j4vdn0RA8BDhntsUKlPSGe/d6aJdbCHWs0MEeYxMMee9pO7oBPTECthYKTKO
         P4Xj1EDxAfo3AU2tVwDRaOmpqbf4njUgu4ivG4N2NRScg/I9AFyoFeAlDo1QMCJKgrix
         SDmYRqcnKk3ZVywivIfTXqGo/ZQOHf4vcwZz8TKvh7SKBGQgsDn3dldEMPRFKjbNTp5C
         Q3fLsqQLZu+whcZOymHzKSQOlRQI/zDR52M5n+ekqtG43T42P85vubAgkDhlF3WRh0kx
         pkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wRcBwa8DlrTCSLSfTO71U9xpzPe9QA0AUmHELWEieU8=;
        b=iFnu6+RYKbL2HVJyWHogvLp9V6dF8TU26uBouf6gmoX5gwrBs+ubzUxmlGVwWyRe5R
         7UdLqQYaptzfuL2gfNn2iOLBAGG1ad+BVy0elu8pi5SGUPnW8XwFNhnyp7i1VaPwRonG
         T+Q2OqCrDVOrfVZDGdu91MWx+QL0lea4JNEn3rJZ+5GrksGIHqeQPORDzB1zTJHXW01a
         lLmRlUWRbxAVgXqMmQG/ZiesdvZO3OqpIRw2v0D2gMedl5fkF4ohxq3Xc20NDMWnuX6I
         9r9YSaA7VAvw1m+k6Kyr/tV8p/1V9883UdDvh1pEzR8lKCBpEKD+GNVVj2hgWLWjUQwm
         VYuA==
X-Gm-Message-State: AOAM533AO4JCD98O9+lYxi/WqWgNEqcvtN8bhUMP56rhYHpMGsQ+a9/4
        deHECJhzJzaBsn7JvdMtRLU=
X-Google-Smtp-Source: ABdhPJzQyFhTP1RavlOi0QPJDIA/z/DDrFU8kAVxDxQLg3CYMz+zBqPP8OQGeC8mYFVQOQY1+SO+mw==
X-Received: by 2002:a17:90b:3b45:: with SMTP id ot5mr603455pjb.235.1637292764141;
        Thu, 18 Nov 2021 19:32:44 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:4e33])
        by smtp.gmail.com with ESMTPSA id p43sm995204pfw.4.2021.11.18.19.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 19:32:43 -0800 (PST)
Date:   Thu, 18 Nov 2021 19:32:42 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 05/12] bpf: Pass a set of bpf_core_relo-s to
 prog_load command.
Message-ID: <20211119033242.r4irsnacxtptibrc@ast-mbp.dhcp.thefacebook.com>
References: <20211112050230.85640-1-alexei.starovoitov@gmail.com>
 <20211112050230.85640-6-alexei.starovoitov@gmail.com>
 <CAEf4BzbqNxw9pDXNHrB9KAy6mbnspRxF5JtUv7kL6iisU02Efg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbqNxw9pDXNHrB9KAy6mbnspRxF5JtUv7kL6iisU02Efg@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 16, 2021 at 05:17:27PM -0800, Andrii Nakryiko wrote:
> > +
> > +       rec_size = attr->core_relo_rec_size;
> > +       if (rec_size != sizeof(struct bpf_core_relo))
> > +               return -EINVAL;
> 
> For func_info we allow trailing zeroes (in check_btf_func, we check
> MIN_BPF_FUNCINFO_SIZE and MAX_FUNCINFO_REC_SIZE). Shouldn't we do
> something like that here?

For both func_info and line_info the verifier indeed uses 252 as max rec_size.
I believe the logic is trying to help in the following case:
If llvm starts to produce a larger records the libbpf will test for the
new kernel and will sanize the newer records with zeros _in place_.

In case of bpf_core_relo the implementation of this patch doesn't
take llvm bytes as-is. The relo records saved and copied potentially
many times with every libbpf call relocations.
Then later they are prepared in the final form.

I don't mind doing the same 252 logic here, but when I wrote above
check it felt more natural to be strict and simple, but...

> > +
> > +       u_core_relo = make_bpfptr(attr->core_relo, uattr.is_kernel);
> > +       expected_size = sizeof(struct bpf_core_relo);
> > +       ncopy = min_t(u32, expected_size, rec_size);
> 
> I'm confused, a few lines above you errored out if expected_size != rec_size...

but then I kept this part and below bpf_check_uarg_tail_zero().
Clearly I couldn't make up my mind :)

So drop all future proofing ? or do 252 ?
