Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5861E56298C
	for <lists+bpf@lfdr.de>; Fri,  1 Jul 2022 05:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbiGAD0d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jun 2022 23:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiGAD0d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jun 2022 23:26:33 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AB45C9F9;
        Thu, 30 Jun 2022 20:26:31 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id g20-20020a17090a579400b001ed52939d72so1397645pji.4;
        Thu, 30 Jun 2022 20:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PG5AhYoIdRr8hftfaH4HQ+U2ZyYad5zoCCH/IXcLGSA=;
        b=DDNHO4z1Xepl7Q3XmVKBG4VjEukeZsSSuMUY3FkQdPcEsoSQ9+c4xb9OzRPc/uh2jj
         7macgjWYfrz1Qeta1chrT2cxjxP7TuXd6EK0o/8ayXT5Rd7IgFAlAqFejh2UaGiaMUnB
         68Wo2RRHbO9hf/spbjM8KG3KOxN9tXX6E+K7OU4jPTmguQNw9boJucD9V99BPVZ1I7sA
         CwI0ZZ9YZFC1KPWC2nIkkhbHyBGN79pPvpdyiP2dxLGoF/58RWnJeJraVJNF0WNOQ0rp
         Bn/ZroPwjqN6mFbOK0iJcHMt2ewCrZej0gBQ2GyW8WofyR1hZ44a61+EtQJ3qlZDdNvj
         IbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PG5AhYoIdRr8hftfaH4HQ+U2ZyYad5zoCCH/IXcLGSA=;
        b=LjoDolqLcA7XYNt9xGgC7AelRzIUrKBYn5ynZnpWscFNbK+MCpyN68nsLHZL2N8NX/
         KoboK4RNMzxEfIWuh8weRejlTQp9ND/g0b5X14mGGstEWYtVUv2ssR0NVgLeAVPoMjV4
         dVuDtoASarwGbbQujRR+opGNq1cSH5TRHSGC7sT2uU+JETwHE8VTUqHG9c2V42YCskc+
         5RAJQ1+RWvy0knF0Umcxi8NfMh7xSrBM65R3eteByBk+N9eZnKGkVQ3L4V5gX7fk9AFV
         Cg5lDelCKbkOCyGo5PyGv9/qHN2A2la5kQ/tghiBWP/SERRwLjoFPbHwa3TFmrNqiiNQ
         kZLQ==
X-Gm-Message-State: AJIora/Vzg+JHcIAuXstN/HygQ4jRPV6iudUTaqVKzUWVdvBxMP1b3kc
        fxJ8gcVrEbEBZUVQYJVLpYI=
X-Google-Smtp-Source: AGRyM1uFgObytDbbIukP9x1A21itmngXZajIQu46vKpmIFkLsUb+TUpi6ahEOpftmv7vIog7rPipxg==
X-Received: by 2002:a17:902:aa47:b0:16b:8e4c:93d2 with SMTP id c7-20020a170902aa4700b0016b8e4c93d2mr17692203plr.27.1656645990890;
        Thu, 30 Jun 2022 20:26:30 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-70.three.co.id. [180.214.233.70])
        by smtp.gmail.com with ESMTPSA id l11-20020a170903120b00b0016b953872a7sm5992830plh.201.2022.06.30.20.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 20:26:30 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 1BB781038C1; Fri,  1 Jul 2022 10:26:25 +0700 (WIB)
Date:   Fri, 1 Jul 2022 10:26:25 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Dave Tucker <dave@dtucker.co.uk>
Cc:     bpf@vger.kernel.org, corbet@lwn.net, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 bpf-next 2/2] bpf, docs: document BPF_MAP_TYPE_ARRAY
Message-ID: <Yr5pYWg2YSyVgdqA@debian.me>
References: <cover.1656590177.git.dave@dtucker.co.uk>
 <ca8a57db17da57f403b029c14ba4f0b89774d361.1656590177.git.dave@dtucker.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ca8a57db17da57f403b029c14ba4f0b89774d361.1656590177.git.dave@dtucker.co.uk>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 30, 2022 at 01:04:09PM +0100, Dave Tucker wrote:
> This commit adds documentation for the BPF_MAP_TYPE_ARRAY including
> kernel version introduced, usage and examples.
> It also documents BPF_MAP_TYPE_PERCPU_ARRAY since this is similar.
> 

Use imperative mood instead of descriptive one for patch description.

> Signed-off-by: Dave Tucker <dave@dtucker.co.uk>
> ---
>  Documentation/bpf/map_array.rst | 183 ++++++++++++++++++++++++++++++++
>  1 file changed, 183 insertions(+)
>  create mode 100644 Documentation/bpf/map_array.rst
> 
> diff --git a/Documentation/bpf/map_array.rst b/Documentation/bpf/map_array.rst
> new file mode 100644
> index 000000000000..eadc714591d2
> --- /dev/null
> +++ b/Documentation/bpf/map_array.rst
> @@ -0,0 +1,183 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +.. Copyright (C) 2021 Red Hat, Inc.
> +
> +================================================
> +BPF_MAP_TYPE_ARRAY and BPF_MAP_TYPE_PERCPU_ARRAY
> +================================================
> +
> +.. note:: ``BPF_MAP_TYPE_ARRAY`` was introduced in Kernel version 3.19 and
> +   ``BPF_MAP_TYPE_PERCPU_ARRAY`` in version 4.6
> +

nit: s/Kernel/kernel/

> +Since Kernel 5.4, memory mapping may be enabled for ``BPF_MAP_TYPE_ARRAY`` by
> +setting the flag ``BPF_F_MMAPABLE``.  The map definition is page-aligned and
> +starts on the first page.  Sufficient page-sized and page-aligned blocks of
> +memory are allocated to store all array values, starting on the second page,
> +which in some cases will result in over-allocation of memory. The benefit of
> +using this is increased performance and ease of use since userspace programs
> +would not be required to use helper functions to access and mutate data.
> +

same nit above

> +Examples
> +========
> +
> +Please see the `tools/testing/selftests/bpf`_ directory for functional examples.
> +This sample code simply demonstrates the API.

Shouldn't the examples in this doc be put somewhere else in the tree? Or
where do they come from?

> +
> +.. section links
> +.. _tools/testing/selftests/bpf:
> +   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/bpf

I think the link isn't needed, since kernel developers will simply look at
their own tree instead.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
