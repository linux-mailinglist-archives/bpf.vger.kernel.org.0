Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48668526377
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 16:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbiEMOLm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 May 2022 10:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbiEMOLl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 May 2022 10:11:41 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF95D1116C5
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 07:11:39 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id c1so7092422qkf.13
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 07:11:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ICDVSP/8Nb9VYLxvzUhB/HhzWa3OVuZWdEwhk0jD9lE=;
        b=POTmSvW+LMCHQne+Q8M65j8xVCT8xFWqjQ5Tpg7t0Bg0AZSWslnxWHo14wrGG2+j2i
         k3RllGyxM5I6g3FPxstqxMad4t3i/XnZe1C49riEe3HJI/eSejw4dJ9vVX3uFrNu5l/e
         odw0u46XznB3g6BHuhSJIykT4RGJkD+pg6zgsamv1DN1TfsNT0I34bI3bJzc0c/zlqp/
         KAp41lwgjNyzoQR4FFveic4D1L+QBfcWVTFENuxouRg0rhu1LVUJK6OfvxtBeAdVapxR
         nsZM8aqlrLnBBIq5jTwkzodVV+sSJe+Ly9fKa8j113Rxvg1E/I+8skZtuiy8bE4LiOvd
         l6gA==
X-Gm-Message-State: AOAM531I6wp2YyD+rKMCiP34q4O+g/wJKbu9/2l5rBWmC9sv7DSpaiPY
        W5lJiCn6ZonVGc4L9xGnKYM=
X-Google-Smtp-Source: ABdhPJzOf2FcfvNTLZXkZP/44FSJ7cbmvfRKJrUOTb+4D+77YgIKzocCxTW5M2ktixwXk7tLCGIHsg==
X-Received: by 2002:a05:620a:1a18:b0:6a0:1c02:4fde with SMTP id bk24-20020a05620a1a1800b006a01c024fdemr3756814qkb.184.1652451098727;
        Fri, 13 May 2022 07:11:38 -0700 (PDT)
Received: from dev0025.ash9.facebook.com (fwdproxy-ash-011.fbsv.net. [2a03:2880:20ff:b::face:b00c])
        by smtp.gmail.com with ESMTPSA id g25-20020ac84819000000b002f39b99f6b4sm1476934qtq.78.2022.05.13.07.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 07:11:38 -0700 (PDT)
Date:   Fri, 13 May 2022 07:11:36 -0700
From:   David Vernet <void@manifault.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net
Subject: Re: [PATCH bpf-next v4 1/6] bpf: Add MEM_UNINIT as a bpf_type_flag
Message-ID: <20220513141136.2z4674v64cqhcnje@dev0025.ash9.facebook.com>
References: <20220509224257.3222614-1-joannelkoong@gmail.com>
 <20220509224257.3222614-2-joannelkoong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509224257.3222614-2-joannelkoong@gmail.com>
User-Agent: NeoMutt/20211029
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 09, 2022 at 03:42:52PM -0700, Joanne Koong wrote:
> Instead of having uninitialized versions of arguments as separate
> bpf_arg_types (eg ARG_PTR_TO_UNINIT_MEM as the uninitialized version
> of ARG_PTR_TO_MEM), we can instead use MEM_UNINIT as a bpf_type_flag
> modifier to denote that the argument is uninitialized.
> 
> Doing so cleans up some of the logic in the verifier. We no longer
> need to do two checks against an argument type (eg "if
> (base_type(arg_type) == ARG_PTR_TO_MEM || base_type(arg_type) ==
> ARG_PTR_TO_UNINIT_MEM)"), since uninitialized and initialized
> versions of the same argument type will now share the same base type.
> 
> In the near future, MEM_UNINIT will be used by dynptr helper functions
> as well.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Looks great, thanks.

Acked-by: David Vernet <void@manifault.com>
