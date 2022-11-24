Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AC66376AB
	for <lists+bpf@lfdr.de>; Thu, 24 Nov 2022 11:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiKXKnE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Nov 2022 05:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiKXKnD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Nov 2022 05:43:03 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9F7C7696
        for <bpf@vger.kernel.org>; Thu, 24 Nov 2022 02:43:02 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-3b10392c064so12295987b3.0
        for <bpf@vger.kernel.org>; Thu, 24 Nov 2022 02:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mp2+HdFS7lMgdYtToA8jqrCUZEezu2Vjs1CqAMebdI0=;
        b=hhdz1eO9CkVWkOM5VL/QC5AH5EV7K+eO9lQfccN0H11us3/qE2FS9x6mthGzfiE6SO
         OYoxuH9XoqXloV6d4et1PY5GVIs7kT5ujQw3T7nEvyA6Rut1exv5z0MEr/jCq2pAXDDY
         ySuj4TxsfvGDeWF7mK6jT2MpYrOmiiClvY4FwuHIKwmrFDAmjsuo3iZbQnUy+s3p1FWE
         fNj34MUy39SU7+t0d8vFi66/7GJclfoJRWSmhNYtW7iP+R0fK0NQWzlZG8JUEjE3bdk0
         qocEaRs9P61lYFst2tAB+G+MUC+9tG1eO1DkspnseD3Zwm/xvOo4KgFDE5OfBbyBf8wI
         CPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mp2+HdFS7lMgdYtToA8jqrCUZEezu2Vjs1CqAMebdI0=;
        b=wpY+aefzKHNDNdAffRi20KPml5y6Gf/n7SFHPxmOT5MKt3bcdobkshGD5g/SyjvjMO
         kkvJ40wK8X9zeU14WorQfTjzLsh8Le6BrLA77Eq1rbaqFLed0gR2hmwN7ZPKUawyOPwp
         uqq/gKMzbxZhXdGGvszd7RHzPjxde9VNxZCLedJwp3q2lk/QyEa7u4vjAjNCyA/xn0t/
         E0ZtLd1yySeu3jSF3C7btTet5Wji56onThpeCghyENxb0zIPFhLII4qTFPb34A3rz6hd
         vkDsCGb7ichuUeFljXBUbO5ypmWeEvDg4ZlUX76sTatFs9udrldm9Z0pCvsimOpSRUsj
         KpEQ==
X-Gm-Message-State: ANoB5pnQYGAUYjr6YgSyl6wqjjK8lehdj0N72Zk7eS2I4mZvccr8Gzhj
        mARtxQuB3EY3B/xQqw8ZqIyw6M2g2Lu3NvD8dwy4cuPupfpRnxNq
X-Google-Smtp-Source: AA0mqf5fZ6u+ZZELxqXKPCingDv1ZPgfF/0iCzoj4FCJKuVP7ISITSUCQGExzzJL/9PvZLSeEKXSzDVfxPXTBM+AGs4=
X-Received: by 2002:a81:7dd5:0:b0:387:f835:77ec with SMTP id
 y204-20020a817dd5000000b00387f83577ecmr12820166ywc.125.1669286581202; Thu, 24
 Nov 2022 02:43:01 -0800 (PST)
MIME-Version: 1.0
References: <CAC=wTOgzZRjZ8zK6uV3u-HqG5WmBtgNWyc62HA7ns96_=6YHKQ@mail.gmail.com>
In-Reply-To: <CAC=wTOgzZRjZ8zK6uV3u-HqG5WmBtgNWyc62HA7ns96_=6YHKQ@mail.gmail.com>
Reply-To: tjcw@cantab.net
From:   Chris Ward <tjcw01@gmail.com>
Date:   Thu, 24 Nov 2022 10:42:50 +0000
Message-ID: <CAC=wTOiOFM6UKdHMjM1mBoGj3Se4itWv_LozN9nbx58J+E5+3Q@mail.gmail.com>
Subject: Re: xdp/bpf application getting unexpected ENOTSOCK
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I have just tried running the test case again, in a freshly-installed
Ubuntu 22.10 VM. I have checked out the 'latest' xdp-project/xdp-tools
and run 'make install' for libbpf and libxdp.
This time I get a trace which ends with
+ export LD_LIBRARY_PATH=/usr/local/lib
+ LD_LIBRARY_PATH=/usr/local/lib
+ ns2_pid=6487
+ sleep 20
+ ./af_xdp_user -S -d vpeer2 -Q 1 --filename ./af_xdp_kern.o
main cfg.filename=./af_xdp_kern.o
main Opening program file ./af_xdp_kern.o
libxdp: Couldn't find xdp program in bpf object
main xdp_prog=0xfffffffffffffffe

What am I doing wrong?

Chris Ward, IBM

On Thu, 24 Nov 2022 at 10:25, Chris Ward <tjcw01@gmail.com> wrote:
>
> I am writing a bpf/xdp example which I hope to put in
> xdp-project/bpf-examples when it is done. But I am finding that I get
> an unexpected ENOTSOCK return code from a bpf_map_update_elem function
> call. My test case is here
> https://github.com/tjcw/bpf-examples/tree/tjcw-integration-0.3/AF_XDP-filter
> ; see its README.md for what it does.
>
> I have a matching test case here
> https://github.com/tjcw/xdp-tutorial/tree/master/ebpf-filter which
> works normally.
>
> The problem may be a diffent libbpf level; the AF_XDP_filter version
> of the test case is running with libbpf set up by "git submodule
> update --init", where the ebpf-filter version has libbpf set up by the
> 'bleeding edge' libbpf being checked out at ~tjcw/workspace. I will
> try again with more careful version control.
>
> The last few lines written by the test case are
> libbpf: elf: skipping unrecognized data section(7) xdp_metadata
> libbpf: elf: skipping unrecognized data section(7) xdp_metadata
> xsk_socket__create_shared_named_prog returns 0
> bpf_map_update_elem(9,0x7ffcaea02670,0x7ffcaea02674,0)
> bpf_map_update_elem returns -88
> ERROR: Cannot set up socket 0
> ERROR: Can't setup AF_XDP sockets "Socket operation on non-socket"
>
> the full log of the test case is available here
> https://github.com/libbpf/libbpf/issues/630
>
> Thanks for any light you can throw on the issue !
>
> Chris Ward, IBM
