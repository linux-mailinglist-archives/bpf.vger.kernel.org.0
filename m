Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50340590968
	for <lists+bpf@lfdr.de>; Fri, 12 Aug 2022 02:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbiHLABo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Aug 2022 20:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbiHLABn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Aug 2022 20:01:43 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B775DD9F;
        Thu, 11 Aug 2022 17:01:41 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id u10so2248004qvp.12;
        Thu, 11 Aug 2022 17:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=RQIMUXvQu1lrFisl+YhKEKIwxD9ItSNLTQ1u6o78Tyc=;
        b=lUtDTSXBjiaxm2j9W7XrBWS0x4As18mcZoOYkm/Hm5bjX/CFFs/f2BJuwJC6DoSaEl
         9yM+aHjmMWlR1x4TU1HAVykbDXyFzHWVHg6FwEGC4FL9WMCdIOgV/eInkJpUwzlpE0Z8
         GNrHz+nsW05sPB0CRbni+zugroA9bifvSAH8ABGtJiEmZkYcKN6KxdEfnKYYVFcv6Yfx
         zR/ZAR/2QeRFq25aHMd8MAvhBBcHc3DVXnXpP3ENskm9FMaesiVzv55cHancFWDyfr8N
         aa2x/6JYGd4FO5Nl8+gov6FNvTntUymyp7klI2vkPtYXblDy72qraiEOmqxUqwK7XGAu
         LX+Q==
X-Gm-Message-State: ACgBeo3ARjjFf08TUP1zivzrB10+0yGXtKwbDG62DR/Wpzdh1syJMhPG
        9Tl7VxvNts9lr1PeRg+Jkhs=
X-Google-Smtp-Source: AA6agR77MaoWHkH7Ba8WiEn+C7E8WupGslIKgYWsa6ECOFNdOrt04jjR5jPGqCxtlZ1Do7KGnozd5g==
X-Received: by 2002:a05:6214:21af:b0:476:cd63:f5d3 with SMTP id t15-20020a05621421af00b00476cd63f5d3mr1450508qvc.60.1660262500739;
        Thu, 11 Aug 2022 17:01:40 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::bfe0])
        by smtp.gmail.com with ESMTPSA id a7-20020a05622a02c700b003430cbb0006sm646272qtx.1.2022.08.11.17.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 17:01:40 -0700 (PDT)
Date:   Thu, 11 Aug 2022 19:01:38 -0500
From:   David Vernet <void@manifault.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, john.fastabend@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        joannelkoong@gmail.com, linux-kernel@vger.kernel.org,
        Kernel-team@fb.com
Subject: Re: [PATCH 3/5] bpf: Add bpf_user_ringbuf_drain() helper
Message-ID: <YvWYYhHfvEQ34wEv@maniforge.dhcp.thefacebook.com>
References: <20220808155341.2479054-1-void@manifault.com>
 <20220808155341.2479054-3-void@manifault.com>
 <CAEf4BzZ-m-AUX+1+CGr7nMxMDnT=fjkn8DP9nP21Uts1y7fMyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ-m-AUX+1+CGr7nMxMDnT=fjkn8DP9nP21Uts1y7fMyg@mail.gmail.com>
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

On Thu, Aug 11, 2022 at 04:22:43PM -0700, Andrii Nakryiko wrote:
> On Mon, Aug 8, 2022 at 8:54 AM David Vernet <void@manifault.com> wrote:
> >
> > Now that we have a BPF_MAP_TYPE_USER_RINGBUF map type, we need to add a
> > helper function that allows BPF programs to drain samples from the ring
> > buffer, and invoke a callback for each. This patch adds a new
> > bpf_user_ringbuf_drain() helper that provides this abstraction.
> >
> > In order to support this, we needed to also add a new PTR_TO_DYNPTR
> > register type to reflect a dynptr that was allocated by a helper function
> > and passed to a BPF program. The verifier currently only supports
> > PTR_TO_DYNPTR registers that are also DYNPTR_TYPE_LOCAL and MEM_ALLOC.
> 
> This commit message is a bit too laconic. There is a lot of
> implications of various parts of this patch, it would be great to
> highlight most important ones. Please consider elaborating a bit more.

Not a problem, I'll do this in v3.
