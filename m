Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D7A674CC9
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 06:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjATFu4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 00:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjATFuv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 00:50:51 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833542B63D;
        Thu, 19 Jan 2023 21:50:45 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id x7so3401952qtv.13;
        Thu, 19 Jan 2023 21:50:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NG5+tmHyXpekUMb9UX3El+JSGlQkPkl7YXC+PKgRDIY=;
        b=yBueUWs1jYG+VAYxy3oP7mnl2L+tYaXa0Bd3D4cKxswCoxiCNfVcL5OlKxq+QMOTo0
         KNiRvcHZn6J8AQaWlx6c9tGvYyQ+ucro3z4Lj8z/+0/oZRtEmyf1ef6Pk8vcAcVx+A05
         QSpSUVqoRKf2rHb+1yrasCOxo02XH6pEAl8ceE5V2Z3kA9LAQRvayyxDySlfXcu+Gn4O
         abtyHhP4EyGR1967gNzErlnbi0OmzzwQOx6h5NSZ9EmGk8X6wfTMw2m3r2uX7WnyV4SQ
         ZbbzAQVjwyk6N9B4Lt9F3e77HQn3WK4SakVxb1L+9urYa35XlZHvS4f5iTAOny35PlAM
         cwBA==
X-Gm-Message-State: AFqh2kqrhf291WoW63Z0jmexSgDpKJ635MJ5LH7XSU4mdgrUobddgndx
        ZclKPTJ/LeCvUtTty6dR172HEk9GkCu3sNWs
X-Google-Smtp-Source: AMrXdXsDhXBDSR6nXmUJJJ2NzMUaG8CTeoDyeZthF9qrJ0dkw1WuDb7LoXRu337Kk68lGRVN1CfDbg==
X-Received: by 2002:ac8:760b:0:b0:3b6:8bc3:a09c with SMTP id t11-20020ac8760b000000b003b68bc3a09cmr8984984qtq.25.1674193844510;
        Thu, 19 Jan 2023 21:50:44 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:2fc9])
        by smtp.gmail.com with ESMTPSA id do26-20020a05620a2b1a00b0070648cf78bdsm11319963qkb.54.2023.01.19.21.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 21:50:44 -0800 (PST)
Date:   Thu, 19 Jan 2023 23:50:47 -0600
From:   David Vernet <void@manifault.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@meta.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com, tj@kernel.org
Subject: Re: [PATCH bpf-next 4/8] bpf: Enable cpumasks to be queried and used
 as kptrs
Message-ID: <Y8ort5rBVuHD6cdt@maniforge.lan>
References: <20230119235833.2948341-1-void@manifault.com>
 <20230119235833.2948341-5-void@manifault.com>
 <20230120054823.bldnkx5tl3jxejm3@MacBook-Pro-6.local.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120054823.bldnkx5tl3jxejm3@MacBook-Pro-6.local.dhcp.thefacebook.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 19, 2023 at 09:48:23PM -0800, Alexei Starovoitov wrote:
> On Thu, Jan 19, 2023 at 05:58:29PM -0600, David Vernet wrote:
> > silently check for and ignore these cases at runtime. When we have e.g.
> > per-argument kfunc flags, it might be helpful to add another KF_CPU-type
> > flag that specifies that the verifier should validate that it's a valid
> > CPU.
> 
> ...
> 
> > +void bpf_cpumask_set_cpu(u32 cpu, struct bpf_cpumask *cpumask)
> > +{
> > +	if (!cpu_valid(cpu))
> > +		return;
> > +
> > +	cpumask_set_cpu(cpu, (struct cpumask *)cpumask);
> > +}
> 
> ...
> 
> > +void bpf_cpumask_clear_cpu(u32 cpu, struct bpf_cpumask *cpumask)
> > +{
> > +	if (!cpu_valid(cpu))
> > +		return;
> 
> I don't think we'll be able to get rid of this with KF_CPU or special suffix.
> The argument might be a variable and not a constant at the verification time.
> We would have to allow passing unknown vars otherwise the UX will be too restrictive,
> so this run-time check would have to stay.

Makes sense. We'll just leave it as is then and document that passing in
cpu >= nr_cpus is silently ignored for any kfunc taking a cpu argument.
