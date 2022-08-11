Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD38590964
	for <lists+bpf@lfdr.de>; Fri, 12 Aug 2022 01:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbiHKX7x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Aug 2022 19:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbiHKX7w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Aug 2022 19:59:52 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240009FABA;
        Thu, 11 Aug 2022 16:59:52 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id b24so8296487qka.5;
        Thu, 11 Aug 2022 16:59:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=nbDO+MStGNHKFrVFyc476CdkFiR1jhUSyExekmndj6g=;
        b=YFGTE6EjKTa9xDvHZ7sIvUt5/+Qz5NdEeioDzaNHtpyoNOu2myogbEBUPn7lbFyCSM
         6TcCnngflIx5ZFc0Bg62Jvf9Juj7LKWGp/gUdX3+ptzW05LtyT7dmBdmrhQoffVg6tb3
         UF1zjHYHyX6SqydVhR3MV6ht3aVPWm9joKrhxfDn/ZqVKvannEsCADzXrPaoE51MKgbU
         HhSayMFjt/mjmlyRB4I8Iya8YgqGRnQrYP0imefJj0jWHXQ9gh3CQMDBITEyZX7pwyPn
         WhHukCciQiUy8KBQVjSq5iAw8IfJBII+YHHwF13mcr6SgbcE/AiL+1h6Pn6lxfOpm0oG
         XOEg==
X-Gm-Message-State: ACgBeo0L4Tv9qJ55mUieqrd1QfGXkqiBhwQqGkqAustEzaqwnbTaUHli
        rREsiUFCbtOTvFojs5efgMg6WmjNA+Ggheyj
X-Google-Smtp-Source: AA6agR6BbeapvMgfRE5413qbReGVQkz0Cg1jEvIFBkW7bLODSxw83vfwhxnvGJ8xyG9At0zkVfrj7Q==
X-Received: by 2002:a05:620a:45a1:b0:6b9:b5cf:c7fc with SMTP id bp33-20020a05620a45a100b006b9b5cfc7fcmr1182172qkb.78.1660262390301;
        Thu, 11 Aug 2022 16:59:50 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::bfe0])
        by smtp.gmail.com with ESMTPSA id hf24-20020a05622a609800b0034361fb2f75sm534438qtb.22.2022.08.11.16.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 16:59:50 -0700 (PDT)
Date:   Thu, 11 Aug 2022 18:59:48 -0500
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net
Cc:     haoluo@google.com, joannelkoong@gmail.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com,
        song@kernel.org, yhs@fb.com, kernel-team@fb.com, tj@kernel.org
Subject: Re: [PATCH v2 0/4] bpf: Add user-space-publisher ringbuffer map type
Message-ID: <YvWX9GrJuTYfjjlK@maniforge.dhcp.thefacebook.com>
References: <20220811234941.887747-1-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811234941.887747-1-void@manifault.com>
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

On Thu, Aug 11, 2022 at 06:49:37PM -0500, David Vernet wrote:
> This patch set defines a new map type, BPF_MAP_TYPE_USER_RINGBUF, which
> provides single-user-space-producer / single-kernel-consumer semantics over
> a ringbuffer.  Along with the new map type, a helper function called
> bpf_user_ringbuf_drain() is added which allows a BPF program to specify a
> callback with the following signature, to which samples are posted by the
> helper:

[...]

I just noticed that Andrii left some comments on v1 about 20 mins ago.
Please disregard this version -- I'll apply Andrii's comments and then send
out a follow on v3 version.
