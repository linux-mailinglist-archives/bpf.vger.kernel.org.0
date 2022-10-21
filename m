Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE14606F65
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 07:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiJUF0P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 01:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJUF0O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 01:26:14 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D7417D296
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 22:26:13 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id a24so1015633qto.10
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 22:26:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dz4H6WsAQP3bPYTaMwAewYsYHIKwwW6Pj9uziSyreC4=;
        b=rpJRjUGPyrW2r8hqUDdDJJfjHDJE8JoCftl4ZyRZx6P9WVD6WUO1CDRh6U9YWHoiPY
         cNh/Okpe+1HjgmMRB7r+kbLx9LeVw1TYMsxNx/UZgtQyUWBZwUd2xYTYJUc6geJVDSHI
         ELr+HtsN9ncxoO0d/wfQOkQn3xT9BcL8ZUH2TrRgJ8SchVxPscM3tlWO5dAXicRtI8AN
         DiKmZgiifPE6h6GXM18FZ3jer1f2/ovMyMYGxSc30TbP6JJKMsBwFPzcG9IDnb0PX+RB
         VCv8QHkCFaErUbDD2ZaBtvroV4FauivtIltzhw3buJQGgeLYYRbX1Gsg30GTgXmenb1u
         gi4A==
X-Gm-Message-State: ACrzQf0/SZahRrs8PLQSnJauZS29UQQFmVRnTntKi/0qGFfDdPd6XpNM
        Ecvb1PqpgDTTCmkzJKNGwqe9GnPA3deBmA==
X-Google-Smtp-Source: AMsMyM5vZIUrDu9xvO7UbVFajbENeJE82fb5ok4FZZx5d2eLUjGHYFHUEjCzjNUnrcT2BX+zTjdmZw==
X-Received: by 2002:a05:622a:18d:b0:39a:b98e:3d2b with SMTP id s13-20020a05622a018d00b0039ab98e3d2bmr14920884qtw.465.1666329972821;
        Thu, 20 Oct 2022 22:26:12 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::80b7])
        by smtp.gmail.com with ESMTPSA id az13-20020a05620a170d00b006eea461177csm9196181qkb.29.2022.10.20.22.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 22:26:11 -0700 (PDT)
Date:   Fri, 21 Oct 2022 00:26:14 -0500
From:   David Vernet <void@manifault.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next v2 2/6] bpf: Implement cgroup storage available
 to non-cgroup-attached bpf progs
Message-ID: <Y1ItdvLJNmYieeS+@maniforge.dhcp.thefacebook.com>
References: <20221020221255.3553649-1-yhs@fb.com>
 <20221020221306.3554250-1-yhs@fb.com>
 <Y1IsqVB2H7kksOh8@maniforge.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1IsqVB2H7kksOh8@maniforge.dhcp.thefacebook.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 21, 2022 at 12:22:49AM -0500, David Vernet wrote:
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 49fb9ec8366d..0ddf0834b1b8 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -1454,6 +1454,10 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> >  		return &bpf_get_current_cgroup_id_proto;
> >  	case BPF_FUNC_get_current_ancestor_cgroup_id:
> >  		return &bpf_get_current_ancestor_cgroup_id_proto;
> > +	case BPF_FUNC_cgrp_storage_get:
> > +		return &bpf_cgrp_storage_get_proto;
> > +	case BPF_FUNC_cgrp_storage_delete:
> > +		return &bpf_cgrp_storage_delete_proto;
> 
> Why the #ifdef CONFIG_CGROUPS check in bpf_base_func_proto(), but not
> here?

Sorry, just realized it's already in an #ifdef CONFIG_CGROUPS block.
