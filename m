Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89CE622C81
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 14:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiKINgA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 08:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiKINfs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 08:35:48 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F3C317F0
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 05:35:47 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id n12so46587049eja.11
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 05:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cn8ZkTP/lEnhagdUipSlkO1gR1vkbcyci7pEAyQEwJ8=;
        b=XvgNLENx6UJ07x5oVW40r1Hw82edGzlyatgIdK2vPz0NT/YWGDDvfdX5EtAgqBnav4
         nwf/SywxprN0DUR3msBZmRuFRUGNpewxtr1SQvCSZmKcYBvc6zUhIVm8bXdhyomrm18W
         cWGzvG+JyDbEc0kLqkZk7gnrPX+pCp/wC3fCEdWTmJ9zhjHTLZ4+nZ+0b0tmEB8sfGdJ
         jvfEsR+GgDe1P084ffU/S3UBbkFM/7ty1EXxh/f7EwdY4gA3b6u9jIac0sFBOpKR8uDb
         Eu4je1FtlcmQFAoQRYwi7oumJqQy2QGc3Xrc95vDX4MdAz0ZRWtjVSlmF2pBV+UiIuRx
         0hRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cn8ZkTP/lEnhagdUipSlkO1gR1vkbcyci7pEAyQEwJ8=;
        b=VdNhgWCmyyssBsICxi42cax1GFijuN97d0Au3A8OqetUozXroHDvc9a72//Umr/ULT
         yl1PgQxwTbHZgc85MbdNStkUurPzHEqAM3WYgIwb7o4ljYyD1tFOVfuclghySb34FXH8
         hRDG00tgxFO6jEojxNo3xq1lZ6yop1E3qkrFKcnxfwJbVbrUvg9cIw7IaIBX+QFESq4C
         aMZZ9iqJmT96+DKc0oOLZD4SR5aXhJAMaF0rgd4b0+Xk1LGd02cKogfepBzwitNCEwdW
         /cLSO+5H/+hdrU5JYJrwZxJAehcVKBwLKggi8JE8zYBy9X5KZ7IAdbBa7NQvA5iU1SpS
         Wawg==
X-Gm-Message-State: ACrzQf0odEC/3iZPDQLgePCDn+6d9bdp+O8orzCwL2+D/usaRpCqdo/U
        w2I4G6QMq1NMqt7yvqN6Puc=
X-Google-Smtp-Source: AMsMyM5GhrmuVEvS+SPPgT9EzCEi+sySqbTZzGQvsCRuKO0kvd56QYavgFbFQNQnylk/8hChgeMaWA==
X-Received: by 2002:a17:907:162a:b0:7a9:9875:3147 with SMTP id hb42-20020a170907162a00b007a998753147mr57419856ejc.546.1668000945963;
        Wed, 09 Nov 2022 05:35:45 -0800 (PST)
Received: from krava ([83.240.62.198])
        by smtp.gmail.com with ESMTPSA id hp20-20020a1709073e1400b0078d3f96d293sm5958819ejc.30.2022.11.09.05.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 05:35:45 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 9 Nov 2022 14:35:39 +0100
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Add bpf_vma_build_id_parse helper
Message-ID: <Y2ush9gEOVNXIMqn@krava>
References: <20221108222027.3409437-1-jolsa@kernel.org>
 <20221108222027.3409437-3-jolsa@kernel.org>
 <CAADnVQKyT4Mm4EdTCYK8c070E-BwPZS_FOkWKLJC80riSGmLTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKyT4Mm4EdTCYK8c070E-BwPZS_FOkWKLJC80riSGmLTg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 08, 2022 at 04:42:20PM -0800, Alexei Starovoitov wrote:
> On Tue, Nov 8, 2022 at 2:20 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding bpf_vma_build_id_parse helper that parses build ID of ELF file
> > mapped vma struct passed as an argument.
> >
> > I originally wanted to add this as kfunc, but we need to be sure the
> > receiving buffer is big enough and we can't check for that on kfunc
> > side.
> 
> Let's figure out how to do that with kfunc.
> 
> Sorry, but I'm going to insist on everything being kfuncs
> from now on.
> 200+ stable helpers. That's large enough uapi exposure already.

ok, I wasn't sure how the kfunc argument check would work.. I'll take
a look and send some rfc or questions ;-)

jirka
