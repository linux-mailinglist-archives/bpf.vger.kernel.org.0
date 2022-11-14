Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68D56278C3
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 10:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235889AbiKNJLJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 04:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236003AbiKNJLI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 04:11:08 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048C425DE
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 01:11:06 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so13165980pjc.3
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 01:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XtpGUTIvcbVcBcCeHMdtVclFveGnvGgjA5lPc1XoL+E=;
        b=nUmF5wsnAOTKZInKWNu47y2qvbiYKSD7RM+d7TtTVe/V/6/rBxzL25ESsTOnWtfsb+
         yeaLSdL3wlIJ/jUGMDnR+kKq5mf6EYC0lSGVFtFeaPRr4Wf0C+9xf4/R+svTc0BAhNd6
         B20/WGgSKiTSKSBYR3Hr/8cZd8HsgtPKxH+6JyTNTrfxkMPKY/c4uNHeyUg+4XBE2K3O
         3JGLG4LLA6olZRa5/+k9x7gvJtgeWPvi57gjuKsr1z8VB+c2KVwGmZ3NMZ2WZamoexNS
         I7M8cZsxCB0NffYiIAmhj8V8xwx/qqrgIqKgxfsHSaXpDh87pBYPTVKtnE7qoMdT3fTi
         YyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XtpGUTIvcbVcBcCeHMdtVclFveGnvGgjA5lPc1XoL+E=;
        b=E8HqL5atEo5e4YXCdRb8Y8RwJcBSgXGH7ABT7XpIOo3dBJOlsXzE6xdxMBeEVKHZbo
         uvJ3/z51YoSON+ahMouMzvaFka77pU2t0T/I8+tspHnjOBKTkLDCkm+LGzShPPtyCrvX
         o3Kuto/pJJGt2r+3kV7222yn/eHf16SGH+VadMZjvZZnVzAN4TEATn/H8gJTgdILdFWS
         ACMS4hC0pDG6J1Y3iYumcO183zrYxOFelcpSIg1LY7XYKqtNVOdZm4jNzLznaqrlyYM9
         dHa59irtI2aaEWeo0JiuhprpvC7pl2OPqVt6Z5kNIkoHmpXrBWg5mTKkmU0FiQzeDBT7
         pxsQ==
X-Gm-Message-State: ANoB5plY2IuId6eqG/NTTHZ0ebBpMubIE8nLGlh3mP932uGmyq8nRGkH
        1979moUH3cjK1Eu7ZJBUzBc=
X-Google-Smtp-Source: AA0mqf6L7YR/LReZ3rAijt6j+W3Xtbn39N1XZAaqyf7Ial22Wyi+OtlX9SX5TwzOKaRe0xGiYNMFYg==
X-Received: by 2002:a17:902:eb52:b0:186:cb27:4e01 with SMTP id i18-20020a170902eb5200b00186cb274e01mr12771579pli.139.1668417065330;
        Mon, 14 Nov 2022 01:11:05 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id y7-20020aa79e07000000b0056e8eb09d58sm6387207pfq.170.2022.11.14.01.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 01:11:05 -0800 (PST)
Date:   Mon, 14 Nov 2022 14:41:00 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     oe-kbuild@lists.linux.dev, bpf@vger.kernel.org, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: Re: [PATCH bpf-next v6 11/26] bpf: Allow locking bpf_spin_lock in
 allocated objects
Message-ID: <20221114091100.xc6manlxdjad2t24@apollo>
References: <20221111193224.876706-12-memxor@gmail.com>
 <202211140520.Q5kvXPSL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211140520.Q5kvXPSL-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 14, 2022 at 01:55:01PM IST, Dan Carpenter wrote:
> Hi Kumar,
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Kumar-Kartikeya-Dwivedi/Allocated-objects-BPF-linked-lists/20221112-033643
> base:   e5659e4e19e49f1eac58bb07ce8bc2d78a89fe65
> patch link:    https://lore.kernel.org/r/20221111193224.876706-12-memxor%40gmail.com
> patch subject: [PATCH bpf-next v6 11/26] bpf: Allow locking bpf_spin_lock in allocated objects
> config: x86_64-randconfig-m001
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
>
> smatch warnings:
> kernel/bpf/verifier.c:5623 process_spin_lock() error: uninitialized symbol 'rec'.
>
> vim +/rec +5623 kernel/bpf/verifier.c

Hi Dan,

Thanks for the report! I noticed it yesterday night.

How should I be crediting you in the respin? Not sure Reported-by: is ok if I
incorporate the fix into the patch and resend it. Would Fixed-by: be better?

> [...]
