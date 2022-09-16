Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A975BB378
	for <lists+bpf@lfdr.de>; Fri, 16 Sep 2022 22:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiIPU0c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Sep 2022 16:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiIPU0b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Sep 2022 16:26:31 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C895BA721E;
        Fri, 16 Sep 2022 13:26:30 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id y11so5183622pjv.4;
        Fri, 16 Sep 2022 13:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ZaXefymK0QQ3omBwZ2CuAmCbq/oi1OUvhWL+QxjZbqI=;
        b=XQiGJWHxpHggUSQ/7opTfL19T+ZP2WP/3QmBTZhnVWv/jKD9xarQ4V+y8K8pM6cMk7
         yALt0UdFV1dJrZglbOsMq1IKFHiQzfKaGkYglDa8kt7UGqepmz/MocuVUnM53unB0En1
         Y2QawnDskLffaWt4Ijz+4xa1w3JyXK5Jn/GchYHuJjkSxnRAGUlmILkT1ruvMB0NUXMc
         3J7o4z0DVUWkeUz29HItTzTTZVIYNvPJ0yLjeDel4HhmlYMNtRMjI7mhsObRq1hobqtx
         0Lwqn0BkEzS3mgMMRZo6Oy8v3hoV+BZdlMXWlEoT8Xqsasf0cWcank4EvkzkvUmXV04i
         8SbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ZaXefymK0QQ3omBwZ2CuAmCbq/oi1OUvhWL+QxjZbqI=;
        b=3MFjuoinHuKXFw2cvDlfdooqd1HPZt82tn3fwAz88gaRDHdWKn0bp1gmhfcU9qJ+6m
         D+iURxmkSTrHMElNT/SqEI0CLrd9x2BXr4SiCH/hSujaBr2h/xP4ZR+g5oD6Af0TZxvn
         WfhOXaQUNpqiGTBu/xtppa/i1M7WlrITFhNzjQm8GwwctsQykyKz8qGMGiCIq9EHf/qJ
         CsML5s9pJBH1tR15cwIPFCheXvwWZYdaRtmj/nAMm1N4HQvMWpzewU4jexBbfJXwZPPW
         Ak2DdSEinT31UFjN355Q8PCBCrPf05RzJS+x83txkTbPTrsKR8CSZdpbmSbkubM/Egbj
         Kvew==
X-Gm-Message-State: ACrzQf00sA+4ib/aL/sXhX3+sIQYp8GN9ffPey9xJnznpX8Ozkqo5/rp
        m7DIWj0sF7GZ2x3xk9n62A==
X-Google-Smtp-Source: AMsMyM5M0uFO7f88XfxT+l6Ls2oGNsWbQPNWO40sqL+m1kJz/Owx126/G/v4ucGRljMJndmFJwpu1Q==
X-Received: by 2002:a17:90b:4b4c:b0:203:1eef:d810 with SMTP id mi12-20020a17090b4b4c00b002031eefd810mr15729715pjb.75.1663359990182;
        Fri, 16 Sep 2022 13:26:30 -0700 (PDT)
Received: from bytedance ([12.125.146.54])
        by smtp.gmail.com with ESMTPSA id t14-20020a1709027fce00b001754064ac31sm15056821plb.280.2022.09.16.13.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 13:26:29 -0700 (PDT)
Date:   Fri, 16 Sep 2022 13:26:27 -0700
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Peilin Ye <peilin.ye@bytedance.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf/btf: Use btf_type_str() whenever possible
Message-ID: <20220916202627.GA31382@bytedance>
References: <20220914021328.17039-1-yepeilin.cs@gmail.com>
 <7c01a2b8-bfb7-df72-faae-0b940ea0f149@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c01a2b8-bfb7-df72-faae-0b940ea0f149@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 16, 2022 at 11:37:46AM -0700, Martin KaFai Lau wrote:
> This clean up makes sense.  The patch cannot be applied though [0], so it is
> marked as 'Changes Requested'.  Also, where is the cad4657ba2ce coming from?
> It can't be found in the bpf-next tree.  Please rebase on the bpf-next and
> resend.

Ah, I will fix it in v2 soon.

Thanks,
Peilin Ye

