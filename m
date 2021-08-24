Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F663F53F5
	for <lists+bpf@lfdr.de>; Tue, 24 Aug 2021 02:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbhHXACY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Aug 2021 20:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbhHXACW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Aug 2021 20:02:22 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004E8C061575
        for <bpf@vger.kernel.org>; Mon, 23 Aug 2021 17:01:32 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id h1so7204317pjs.2
        for <bpf@vger.kernel.org>; Mon, 23 Aug 2021 17:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=674RpNdxWoSkoPrbwPjoUiyxumKG2tsmoQ70QT49ot4=;
        b=ddXGQ4bQxfNVZT7TFeXvZ7VI6HF+tIMysLfw0JC4ygyMy+r4CkNmNCWCvjUZqL5dM9
         KgD64tRKvK2yzCjG4MVev/rPur17KnEF8jG1yTXf4z1G7H0YTsxTrduWrv75syI+U2k5
         0BkGMpQH+3QAKVEf2PloOzInvcSz/BdJ7+wsOQp93zjs04SgN4ypTZLaw6bPvNOCNEvr
         3qsM7KFQtbV6T5RFQcTXlJNpLM95xjGaruVKRqYswwgLbPkchwnre67Sg8HTspgd8AVj
         ZQWCC1leFGWp189l9S7Yva3/e66veSkgMqVr5mk3t+XbiiL8+xCP4Kt2RAr4v/MBQpFx
         SBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=674RpNdxWoSkoPrbwPjoUiyxumKG2tsmoQ70QT49ot4=;
        b=n4zMdiqt/8pfYDUMNEn6H84jVYhf8Zj/5kPN4R1/If/LfsmxZyS1spI67wv4W542tc
         WPyskDzU3dwIv+HPEtVn1yvlWgTsfZDXNy7AYIxkEVr2kENIHYbZIbH1pmriUmERFA42
         b8WsOKD8cAGCrV1GtQrxsOKBi5lDE79kp7yYlkPe14xIqHTk8VcPfzwiVZSoPqQho5Q6
         RTOrcJoZKvvEIwtsjs3syFwGnuN7f738hp6NrdOf7CRxSBM0UXqYeDxro5haq29FznTF
         NfnLKZz9VO5LNKRUZYYEUowwGrU+9BhfbqyV5uiwHY2zBYQwF7mVrUYqcnidbEWCdARt
         0XCQ==
X-Gm-Message-State: AOAM531k7V8Znj41ZtHlxMb5fDePuG3TdcyaTFdIKNGfWzH70IYXdlt1
        pH0r2uFfy9Yh4nSHN0aN4cN8KiwZgv8=
X-Google-Smtp-Source: ABdhPJxxS0cmruXlLfhe2B/PijNsJLV3JVlELsH0YyJWLrTEJ5rF40Iy7p0bg07H9PuoVYRlNn2Awg==
X-Received: by 2002:a17:90b:370d:: with SMTP id mg13mr1162110pjb.117.1629763292392;
        Mon, 23 Aug 2021 17:01:32 -0700 (PDT)
Received: from localhost ([2405:201:6014:d820:9cc6:d37f:c2fd:dc6])
        by smtp.gmail.com with ESMTPSA id c16sm17322784pfb.196.2021.08.23.17.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 17:01:32 -0700 (PDT)
Date:   Tue, 24 Aug 2021 05:31:29 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Yaniv Agman <yanivagman@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Subject: Re: libbpf: Kernel error message: Exclusivity flag on, cannot modify
Message-ID: <20210824000129.aybya44ymxssc3so@apollo.localdomain>
References: <CAMy7=ZXTiaX9xzNi5aOavwsf+mziJ=w-EcHH2f=cJmCGr3EPQA@mail.gmail.com>
 <20210823155149.3jg7nizcxgxf4tfv@apollo.localdomain>
 <CAMy7=ZWQCO0rkW979v6cF56x06G_kmA_qTDm9_yumJyjrcg47Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMy7=ZWQCO0rkW979v6cF56x06G_kmA_qTDm9_yumJyjrcg47Q@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 24, 2021 at 12:36:03AM IST, Yaniv Agman wrote:
> [...]
>
> Explicitly handling EEXIST solved the problem, however,
> libbpf_set_print in my setup is already set to ignore any message that
> is not LIBBPF_WARN.

You need to filter on LIBBPF_WARN for this one, the log level in
libbpf_nla_dump_errormsg is pr_warn.

> [...]

--
Kartikeya
