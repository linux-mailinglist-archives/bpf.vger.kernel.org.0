Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1841F524408
	for <lists+bpf@lfdr.de>; Thu, 12 May 2022 06:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346754AbiELEXd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 00:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346696AbiELEXc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 00:23:32 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C3D5F262;
        Wed, 11 May 2022 21:23:30 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id a15-20020a17090ad80f00b001dc2e23ad84so6715570pjv.4;
        Wed, 11 May 2022 21:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3sMtUXDobTN50cZtuQXjixiA5iNFti2MdqM5MfWA+Q4=;
        b=IiRocpH03fhDHnajz/bONND9yHKzig1P6S41AeZEbNmnVJRULBlCfIoFoyBwqw/RED
         G/7mZwkMez70Dv8R8vYpWYSlhDGScNKaoqIFpNSRR19xq+pf6QOfdjXb/K0mx7f0E0nW
         jeEAvis/LEnuQg/1QZ8YIn+VrvOYcbQARidjK3SDlAI38UOZmy07D7qlXHZOxO+NlW84
         Udk5Jc+k0kt/w5fwS81CUknetRV6Vx6kGSyKkKiym0W3Xc9Lmm83YvYibhqDaXJQqlKX
         +64AelaKO3gLTGu/D+dETrKw30bC/z4Vnn/IHuqh+22UyusZv4ydPOtVyPvUwqi8ru4V
         YJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3sMtUXDobTN50cZtuQXjixiA5iNFti2MdqM5MfWA+Q4=;
        b=0mXxY0VLD3p8h9wToThlewS3vptAuxRvF1yE+3x8U9YL5Sb5lLcHrs/sIbQMsuLDcj
         D1dZLRCdXbylKXAO88zsWV6Nal9pN+znuNoaWENnrGJTMHO/aiHOOfd16dA7BombPwP6
         bwS81C2HrVgVtpchJVghrSrI/x0h0vwnG7pYUZFPHsvy5Ye7xaVGftXO/5LyPe5Sg1q4
         YgFH2yCtsJ4ox7UMzg8ThsSUUkVEnxWq54eq0qN/h7GIYCu2sM7gUHmLb9HiFV0nhXJE
         iB9aXT/bo8CWaGxzFbVO/0Tip7GX8kl6X1mS/267GmagCBjsdLiQKq78mZapeKfp6Bev
         9Tpg==
X-Gm-Message-State: AOAM533wdzGuj5SheSV1sdh1207PdwdPvNzndz0fwS5gfvY3hfDh2HBP
        UZIMwlBeQyadAOkJCwkQOeU=
X-Google-Smtp-Source: ABdhPJzzdGy4yhxkLtrxKvlEPNkhd7bFeqxZhxj4hmN6nhOI6JnfA+k85r5zVswsxq/p/lOhJTWlqg==
X-Received: by 2002:a17:903:20d3:b0:15b:151c:cadb with SMTP id i19-20020a17090320d300b0015b151ccadbmr29015205plb.154.1652329410395;
        Wed, 11 May 2022 21:23:30 -0700 (PDT)
Received: from MBP-98dd607d3435.dhcp.thefacebook.com ([2620:10d:c090:400::4:6b86])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902a5c300b0015e8d4eb1besm2751909plq.8.2022.05.11.21.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 21:23:30 -0700 (PDT)
Date:   Wed, 11 May 2022 21:23:27 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [RFC bpf-next v4 0/7] Introduce eBPF support for HID devices
 (new attempt)
Message-ID: <20220512042327.vla3j7rjqrmjporp@MBP-98dd607d3435.dhcp.thefacebook.com>
References: <20220421140740.459558-1-benjamin.tissoires@redhat.com>
 <20220426040314.ez3cdpv2w45vbgkk@MBP-98dd607d3435.dhcp.thefacebook.com>
 <CAO-hwJLziatB9n5Rut_EYRgfN94t2XX8Zx8B_Zmu2nucTw3k8g@mail.gmail.com>
 <CAADnVQKN==eb3ASQhrJBg4yC8BuRdMQyY-OdRbXhdyv2P8L0-A@mail.gmail.com>
 <CAO-hwJ+HV=jZUgH1LXcPuBFirMzx3OAdSy4zvyyYh7PQhnaduQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO-hwJ+HV=jZUgH1LXcPuBFirMzx3OAdSy4zvyyYh7PQhnaduQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 30, 2022 at 09:12:09AM +0200, Benjamin Tissoires wrote:
> 
> Also, I wonder if we should not have some way to namespace kfuncs.
> Ideally, I would like to prevent the usage of those kfuncs outside of
> some helpers that I define in HID so I don't have to worry too much
> about other trace programs fuzzing and segfaulting the kernel.

That would be a great feature to have. Other folks expressed the same interest.
Just grouping them by prog type is not flexible enough.
It feels kfuncs could be scoped by (prog_type, attach_btf_id or attach_hook) pair.
What are your thoughts?
