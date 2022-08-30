Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53AB5A659D
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 15:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbiH3Nwc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 09:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbiH3NwL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 09:52:11 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2931EF9D3;
        Tue, 30 Aug 2022 06:50:33 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id n4so6125591qvt.7;
        Tue, 30 Aug 2022 06:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=KbHJHL8dnzmWMykR3oF9Hjfnh7AuBxlSpbgtqcM9Duo=;
        b=Iyj3hfyDqlssN9M8PypqLprSaNFNdRD45siazwjPwvWpHSbcmB0HwAKHYzQN0rIdZ9
         AAnxyGb0M7zICqdV4mU9ZLn5MD8SkXYbzy9SW2ndUJWmW+P5HxmHUsE3jM+aJ/XQQQCI
         rfjyt0OgC7+dj5Mgvh2ib6tx2GUWnkX3upHvyrVbbq+3YbxySJiDMtsCLAjP7oloDCns
         O10/Htl6X2Nva9d2oJRP9F4/wzHWyflAKrM8Z2qdZmX+06SbH97YkZ9kpfwj8P5pgH7s
         ouLy9fWKLfSqc8CJZjkcdQ7w4t3un+P7vDuIVhcCx3d274ZhIqYf2tNJbRVkot/3SRPP
         +3uw==
X-Gm-Message-State: ACgBeo3+3lATKaRkXYaGYfr9gcDPYmIT2mmetl/rS6W2aSE83emow2q0
        qdom48SPr6RG6TKshrQe6AA=
X-Google-Smtp-Source: AA6agR7Em/vAoQjas0z6sIqnGUR9ui9eHGr5NAV6irCM3/O6sVuQU2EhEsRJ75OxZ1lCZfgiD7v38g==
X-Received: by 2002:a0c:90a2:0:b0:47b:6b36:f94a with SMTP id p31-20020a0c90a2000000b0047b6b36f94amr15208351qvp.26.1661867431513;
        Tue, 30 Aug 2022 06:50:31 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::2341])
        by smtp.gmail.com with ESMTPSA id e8-20020ac84908000000b0031ef67386a5sm6934907qtq.68.2022.08.30.06.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 06:50:30 -0700 (PDT)
Date:   Tue, 30 Aug 2022 08:50:33 -0500
From:   David Vernet <void@manifault.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        kernel-team@fb.com, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        joannelkoong@gmail.com, tj@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] bpf: Add user-space-publisher ringbuffer map type
Message-ID: <Yw4VqWs4BLU/mVcN@maniforge.dhcp.thefacebook.com>
References: <20220818221212.464487-1-void@manifault.com>
 <81eff27a-652b-4b55-7a4a-31c421b7f0bb@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81eff27a-652b-4b55-7a4a-31c421b7f0bb@iogearbox.net>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 24, 2022 at 07:38:34PM +0200, Daniel Borkmann wrote:

Hey Daniel,

> On 8/19/22 12:12 AM, David Vernet wrote:
> > This patch set defines a new map type, BPF_MAP_TYPE_USER_RINGBUF, which
> > provides single-user-space-producer / single-kernel-consumer semantics over
> > a ringbuffer.  Along with the new map type, a helper function called
> > bpf_user_ringbuf_drain() is added which allows a BPF program to specify a
> > callback with the following signature, to which samples are posted by the
> > helper:
> 
> Looks like this series fail BPF CI, ptal:
> 
> https://github.com/kernel-patches/bpf/runs/7996821883?check_suite_focus=true

Thanks for the heads up. I'll make sure these are fixed these before
submitting v4 by following the instructions in [0].

[0]: https://github.com/qmonnet/whirl-offload/blob/wip/bpf-ci-check/_posts/2022-08-05-bpf-ci-check.md#running-the-bpf-ci-on-your-own-github-linux-fork.

Thanks,
David
