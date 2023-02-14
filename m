Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D288F695795
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 04:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjBNDsZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Feb 2023 22:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjBNDsZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Feb 2023 22:48:25 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CE92124
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 19:48:24 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id fu4-20020a17090ad18400b002341fadc370so2299159pjb.1
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 19:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sPVS6zytFAph3nFXj2TNgimIerxD8FnE+DVKPSr9s2Y=;
        b=T4iAUP5n/ZXjLsO0iq+fBfs68HpDi8W290qpcD/CvH95keP8wS5EHwhvFBHSW2BtJ5
         iek47XRcC25skVEnmx1NVt6rIj/cTh598AoK3yHebkcGLKcyiFj2KGdZ2yeia9G5goqJ
         3nFHYq848zOotIXJ44WtINpplm0Q5Ni25Vse3itFbyJMFvi85ZIhomi3dDLHVLoLaODz
         uNBina6AjaJgTAddLSd9vw9Ipg+/ekzdMp3NSs1NP0egW1yWOd778H2SXcJDYwfCgtzb
         eFN3NYPBrK8QBMHLuX+wW15Hk9Tt7Y0QYgd9Gm1hgqAE4/8mVJ9jfKDc66Tt0MY+VS39
         XmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPVS6zytFAph3nFXj2TNgimIerxD8FnE+DVKPSr9s2Y=;
        b=CwCmbyT9+ObouyijQ9BA8ERpQs+nmLqKSKhA2s2IBhcVFiOYNpC4hWit7MFp4Bo7YM
         Y4MeTgsNuq3l49p+aEY1Uw8TAtkFrN2f2BVGn/xwKcDR5WamPJgY4izJfCL1yf9mMN8c
         OkUY2hb1LlvyxoWFeZXrlXON4TrSW49dd2ItQMuYleihSHgPy7VI0lZDd/qz+QlSZwBC
         iOw9EurQotMXVdk3cJkoMs7QtN8kQDss2dKG9APLL9VLzRYlbzssgfeNBK7LlVZn/QUP
         cPcZgwWIN9LWukpxLj9KCLA5MHkxiRUG8RULUMnlwDIxVGDK3yzJ37B+PKSz2lb6Ubvp
         k6Ow==
X-Gm-Message-State: AO0yUKWSJe3j3HZRlnbxIGATvnNBaQqocPnlxugBOrYy1fRDeIlrT6vd
        S2rrvdZLdVkkG3KtTPkJhg4=
X-Google-Smtp-Source: AK7set+ERw1ISNeI7R7UAXiDXmQsTiJ3VER1stXdHXnCFKcMS/1h+lcCbJ2XRtDPN2FJW+Gsj8wV4A==
X-Received: by 2002:a17:903:80c:b0:19a:9161:1e42 with SMTP id kr12-20020a170903080c00b0019a91611e42mr1062850plb.41.1676346503966;
        Mon, 13 Feb 2023 19:48:23 -0800 (PST)
Received: from MacBook-Pro-6.local ([2620:10d:c090:400::5:d0de])
        by smtp.gmail.com with ESMTPSA id je18-20020a170903265200b0019a96d3b456sm3692144plb.44.2023.02.13.19.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 19:48:23 -0800 (PST)
Date:   Mon, 13 Feb 2023 19:48:20 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v6 bpf-next 2/8] bpf: Add bpf_rbtree_{add,remove,first}
 kfuncs
Message-ID: <20230214034820.4fuws6skztaswg6r@MacBook-Pro-6.local>
References: <20230214004017.2534011-1-davemarchevsky@fb.com>
 <20230214004017.2534011-3-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214004017.2534011-3-davemarchevsky@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 13, 2023 at 04:40:11PM -0800, Dave Marchevsky wrote:
>  
> +struct bpf_rb_node *bpf_rbtree_remove(struct bpf_rb_root *root, struct bpf_rb_node *node)
...
> +void bpf_rbtree_add(struct bpf_rb_root *root, struct bpf_rb_node *node,
> +		    bool (less)(struct bpf_rb_node *a, const struct bpf_rb_node *b))
> +{
> +	__bpf_rbtree_add(root, node, (void *)less);
> +}
> +
> +struct bpf_rb_node *bpf_rbtree_first(struct bpf_rb_root *root)

__bpf_kfunc annotations were missing.
I've added them while applying.
The rest looks great. Very nice milestone.
