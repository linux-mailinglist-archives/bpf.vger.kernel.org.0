Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A24556FB58
	for <lists+bpf@lfdr.de>; Mon, 11 Jul 2022 11:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbiGKJ3s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jul 2022 05:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbiGKJ3U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jul 2022 05:29:20 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EE26B275;
        Mon, 11 Jul 2022 02:16:22 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id ss3so1730936ejc.11;
        Mon, 11 Jul 2022 02:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eTTFKgH7hQtkU//+CmCIZWi4/NIjeedPCrqlPOr90W0=;
        b=XsHyUDFbnP3JUpUBo6IGZB42A+qynNMNTRaQ/PqHgOsAVE9ICzuqSQ+dPcRn5soSrT
         GXwyfgmLLC15MccjDYbPhtf5U+H9GbpDgvv1qWaUhzyFwnwELCHl0hdWMRMZ3GR1Sv7/
         6Wnj5yPHTbxVzcIL6X5UHdgO/D1cKuMFwt2WlvXBIwLP0QB0ZGBKhya/QmWSpRIZhTp6
         Zdvbb6q/DRMJZhA7dNdied/FH1tKWPfStMeqlFBS3OsqQzvkFiFoovdMe3eHvRsUrtKA
         4YtDuAANgveMffp6+gwprp/wiF5aondeK4RuIgheN45AQ5wE/8/oziGoOpy4kF/15EaC
         NZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eTTFKgH7hQtkU//+CmCIZWi4/NIjeedPCrqlPOr90W0=;
        b=XxkfvavMfkThwiPe8hwBZkC13rFsbA5DdmoJPCztCIvy+OQDL6PKwHrXZisUg1Xwl8
         g5ulc8oZFC1bDnxmXh0efTQyMKRFY7Mod6L8vjkHdIzmyy9JPv10rzAJG88Qy351K2o0
         kcXkVx/3M3A7wvaRjWyPU528BN77QbhAEOok6LdYiEpzRHfzRecd3DVf+FAGNKbKmSpe
         JrmrYr8e4TLqYPB3oZVMnuYFf4laNymYMHU69t53HpX64NQakNEpuc0ACJha3gtp6xJy
         sQbat/SrOCpwhGWJ2MfM8IooeQgptQr+L4jDLsS7xua+KlwXkQLQlE707KdTaAIw2WBB
         rIHQ==
X-Gm-Message-State: AJIora+OmEeLZxpo22r57HNXsTLhxPUIGVqVLgRKk299/Pl2XT+xLy+u
        QakVBOo6KQu3cDdeAMjEqlY=
X-Google-Smtp-Source: AGRyM1vyTdIavT8V7fN4xYPLAmk+pYeFH25gLXVUvcFm5e5YYgzRTa32QNKf7AhSCgFocjJwX5XFgw==
X-Received: by 2002:a17:907:6818:b0:72b:5bac:c3a3 with SMTP id qz24-20020a170907681800b0072b5bacc3a3mr2444303ejc.139.1657530980872;
        Mon, 11 Jul 2022 02:16:20 -0700 (PDT)
Received: from krava ([151.14.22.253])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906211100b006fefd1d5c2bsm2495099ejt.148.2022.07.11.02.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 02:16:20 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 11 Jul 2022 11:16:18 +0200
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Subject: Re: [PATCH dwarves v3 0/2] btf: support BTF_KIND_ENUM64
Message-ID: <YsvqYhbee6WpBckl@krava>
References: <20220629071213.3178592-1-yhs@fb.com>
 <YrzH1ABPYmKSEogS@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrzH1ABPYmKSEogS@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 29, 2022 at 06:44:52PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Jun 29, 2022 at 12:12:13AM -0700, Yonghong Song escreveu:
> > Add support for enum64. For 64-bit enumerator value,
> > previously, the value is truncated into 32bit, e.g.,
> > for the following enum in linux uapi bpf.h,
> >   enum {
> >         BPF_F_INDEX_MASK                = 0xffffffffULL,
> >         BPF_F_CURRENT_CPU               = BPF_F_INDEX_MASK,
> >   /* BPF_FUNC_perf_event_output for sk_buff input context. */
> >         BPF_F_CTXLEN_MASK               = (0xfffffULL << 32),
> >   };    
> 
> Applied, added the entry for skip generating enums to the man page,
> added support to the pahole BTF loader, used the new pahole to build
> bpf-next/master, all seems ok, pushing to next on git.kernel.org so that
> the libbpf github CI can give it a go.
> 
> To build with torvalds/master one has to add --skip_encoding_btf_enum64,
> I think, haven't tested with it, without it isn't working, libbpf
> complains at that btfids tool.
> 
> Please check/test what is in there now:
> 
>   git://git.kernel.org/pub/scm/devel/pahole/pahole.git next
>   https://git.kernel.org/pub/scm/devel/pahole/pahole.git/log/?h=next
> 
> Unless someone screams I plan pushing out a new release, update fedora
> packages, etc early next week its overdue by now.

I used this new pahole in kernel build and it looks ok,
but I'm getting following warning:

  BTFIDS  vmlinux
WARN: resolve_btfids: unresolved symbol mptcp_sock

might be specific to my .config, I'll check and let you know

jirka
