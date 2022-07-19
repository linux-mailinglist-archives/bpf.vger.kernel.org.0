Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745CF57A73C
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 21:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238704AbiGSTbr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 15:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237913AbiGSTbo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 15:31:44 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EE7186C3
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 12:31:43 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 72so14422187pge.0
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 12:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oTAUXijPpZLmZDkalJsrF+sDrQfgugPCAER8aC0JvOk=;
        b=opHaPbqKXxnQuVm1cVE4jCC+Jprt87heRiVrdSgXRgXAQ9pLs/9ACi/sjJMFH0fNkd
         vIQdJWzcBichE0QYGyibpcs+SH4N4b2JIPbSpCaIP/082BfN+arTcZ0jHyWotFVEtseP
         gY4kTzd6ihD2Di72/EJt20dxdUvLZ6T8Jso3EpzEMPCsG5ATZN8kZXgnGiYpFmm1U9zc
         r1hZhtRpHTke3C1y8ghuc/0yMFAhMevtvrRexoG0ZpOtkb6gG04ZiJdglfKn7bbXJxoV
         fjqdpa2fDHvZq9Am2eBfgQ51wL8nxUDyrGNjn+wDVJ/NYfnhylcCR7h3KcYJVSJH8yde
         w7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oTAUXijPpZLmZDkalJsrF+sDrQfgugPCAER8aC0JvOk=;
        b=41p/TX5e+bwYz4aMQ++lhJBYx+q82PDpEDXhQVvvRVYiN0VxW2nLRfx9g3YEd+3Dsg
         tvg7gQJY/yg/WH63CvrG2n21JjR7Oe9WElksgojYZXxiDM1RznerwK9FEnM1bcp3/Guo
         pllt+tPB0MRHlmXfUVBWl5wG2/R0kimlyPuzLcDJRf3slEcweMNbsuRSVc/S7+VqN3qX
         EKBMi1wlFWesicWOY6HX8l8qTwt/muXgt7ngj7f8M+ECyjVYwuIWqcVWI4/mc4Joh5U6
         2FxL2zqogtjCg+dpvbh0p0rJ9mBUswlz1xM+vYnNQknIL7U5ETDre9bZlsJB16LT8Y4g
         3ehQ==
X-Gm-Message-State: AJIora8dyY/KMkB7Dl+dejKTZN6vaWg/FWxcepfyI8cIwNZXVjql+Rbo
        /aiCtpW5jsOCGLZTKqaY6xt90w==
X-Google-Smtp-Source: AGRyM1ve/niHAaVq3Yd+4lfeMUAfS29AsNpxqy93U2w5fKjqApTP2AARU6wW38D9Ua1XFtd5qMQJzA==
X-Received: by 2002:a05:6a00:1a46:b0:525:82e2:a0d3 with SMTP id h6-20020a056a001a4600b0052582e2a0d3mr34657269pfv.48.1658259102693;
        Tue, 19 Jul 2022 12:31:42 -0700 (PDT)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id m1-20020a62a201000000b0052ab3039c4esm11980461pff.8.2022.07.19.12.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 12:31:42 -0700 (PDT)
Date:   Tue, 19 Jul 2022 19:31:37 +0000
From:   Joe Burton <jevburton@google.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Joe Burton <jevburton.kernel@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PATCH bpf-next] libbpf: Add bpf_obj_get_opts()
Message-ID: <YtcGmfjizpfyBSjz@google.com>
References: <20220718214633.3951533-1-jevburton.kernel@gmail.com>
 <CAKH8qBuAR2A4wyL7Xe_OY-pq_VaRRrP_e-P5py=rwf22mfr1VA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKH8qBuAR2A4wyL7Xe_OY-pq_VaRRrP_e-P5py=rwf22mfr1VA@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 18, 2022 at 02:50:26PM -0700, Stanislav Fomichev wrote:

> Needs a libbpf.map change as well?

Good catch. Done in v2. Sending the patch out in a moment.
