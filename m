Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CBA6970A7
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 23:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjBNWWI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 17:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBNWWG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 17:22:06 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9202213C
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 14:22:05 -0800 (PST)
Received: by mail-qt1-f171.google.com with SMTP id f10so19979347qtv.1
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 14:22:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yaedcf9hUrBivvZ+vAGaSsYmZvWZ5iF+NSYORDx5tE4=;
        b=emCLtGsjg6ixUn4inpFHiEVfGzF+P+ETk9AOv1m6kqga5ni5HFpmN7sEPuHcYjsRs3
         ddSmKsSVOikagmB8jWsK9l3gQu8bk0Ah6b63zaf9lLGrg/FE4blKMk1Z9HXzzpbaHiN0
         eS3CwF93bIceNdb+w8Om7Zzb4BeIJB8nJlRRnAaKb+3flVsEd+8OnnY19a8GL/MfHBrV
         /dChy9AzM+PE5H9AGaZASzpFJmXuu/dhZfFHgsuXmfi7bincPQBq5a8KPuxm6T/KA2j7
         eRALddhnKF7pJhaKkI+DbGs6dHaFMt0eea6DSQIwO34EMImpr7pIQibjTYfmpjZOy6aN
         skpg==
X-Gm-Message-State: AO0yUKXhdEi08RtizOBDYZuB6+7VXl0dcrqgeaamwJ5/qolNIGhRfB/M
        3ke8W1GHftIiCOKsN0IA/Us=
X-Google-Smtp-Source: AK7set80j4cQpNpi5DXL7wzBJJG6en/4T+cumdAmP7psdFnv/Fkzry1rn7WEKy4VRuZZ2X44imDahg==
X-Received: by 2002:ac8:5a08:0:b0:3b9:b450:61f6 with SMTP id n8-20020ac85a08000000b003b9b45061f6mr7602648qta.62.1676413324696;
        Tue, 14 Feb 2023 14:22:04 -0800 (PST)
Received: from maniforge ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id d10-20020ac800ca000000b003b0b903720esm12052429qtg.13.2023.02.14.14.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 14:22:04 -0800 (PST)
Date:   Tue, 14 Feb 2023 16:22:01 -0600
From:   David Vernet <void@manifault.com>
To:     hackathon@ietf.org
Cc:     bpf@ietf.org, ast@kernel.org, mykolal@meta.com, bpf@vger.kernel.org
Subject: Re: BPF Hackathon project
Message-ID: <Y+wJibgVRJg+8kNW@maniforge>
References: <Y+wFfL/ZB1aIPFTl@maniforge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+wFfL/ZB1aIPFTl@maniforge>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 14, 2023 at 04:04:44PM -0600, David Vernet wrote:
> Hello,
> 
> I just added a new BPF hackathon project for IETF 116:

Given that Daniel and Alexei recently added a MAINTAINERS entry for the
BPF documentation and standardization effort in [0], let's add bpf@vger
to the cc list.

[0]: https://lore.kernel.org/all/57619c0dd8e354d82bf38745f99405e3babdc970.1676068387.git.daniel@iogearbox.net/

> 
> **BPF***
> - Champion(s)
>   - David Vernet (void@manifault.com)
>   - Alexei Starovoitov (ast@kernel.org)
>   - Mykola Lysenko (mykolal@meta.com)
> - Project info
>   - Learn about [BPF](https://ebpf.io/what-is-ebpf/) and/or
>     [Sched Ext](https://lwn.net/Articles/922405/) by writing BPF
>     programs, creating custom Linux schedulers in BPF, and even
>     contributing to the BPF codebase itself.
>   - Add [BPF documentation]
>     (https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/Documentation/bpf)
>     to the upstream Linux kernel tree in support of BPF standardization
>     through IETF. Newcomers to Linux and BPF are welcome.
>   - Write custom schedulers in BPF, using the new Sched Ext feature
>     currently being [discussed upstream]
>     https://lore.kernel.org/bpf/20230128001639.3510083-1-tj@kernel.org/).
> 
> As stated in the description above, the project will be championed by
> myself, Alexei, and Mykola. If anyone has thoughts, feedback, or
> questions, please feel free to reach out to us!
> 
> - David
