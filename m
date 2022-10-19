Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF92603B6D
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 10:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiJSIZw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 04:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJSIZv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 04:25:51 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729E77CAB1
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 01:25:50 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id cl1so16339648pjb.1
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 01:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j8nZEJ2Bqb84pBFypIyWOkeayr4KRwaoXcYe7DKAf4s=;
        b=Z4WSc6yd+rB++Y6ONx5tPRKbHiQ/QFrMDzMq+dOVMxXPEm0oPUGeNkwXNeF+Z1ui7R
         NI2WZMS31CRqIIsxmhCtuf0Y4cIoTaHxQgHjuZhLS4oKjXQrR0LA+OeCmrB0zkW50VSY
         WrV4qoVT3g7Ersnaxm3blu6qwL/ZYH0KQxCq/6piG1jcyMhWpEb1I3ZR6os5WliOTdFd
         n/UclON7ocOeVb4PwDiJh1074fsl3o68NA7XClDNJDKG8YPFBDpkEKXrM6WDlopFW8n5
         w7VeE03N5e6EpRUhPt+fBpG5IOFogbgtFdLs4eq9jrhfULnheKwnp5gPvCQMv9qb585o
         lVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8nZEJ2Bqb84pBFypIyWOkeayr4KRwaoXcYe7DKAf4s=;
        b=fONU2geEmXdCbfI4lW6lxrUS6VyXKAPx/y4ZobKUmdXxT492T0vqEIXUYqLC5wD/9u
         UAZm9XfuFGlsS1UcFPjuxV1dCnwhK9NetL34apl5hWwUgVDR1tokGSsAVOEW2WmI61nb
         ythGDZ3Hk1fDk8MPsi3j0o1b8Atu5dj0iEugIDrm9WVuV1nHveUTRZrDk7au8YMuix1x
         3WAyWmViqP89jkMng2TH5gS7JPxT/Eejby7KKymacHyTpE2cgC2Ll18969gukEy/fUVL
         aRMh41aR455TYT8IX4KklS76m8ckHKviH7NDRC5q41rUFl706tj7/yWpW2XfJxopdo+V
         kn3Q==
X-Gm-Message-State: ACrzQf3N5XnhOSP/gE3yWniZ7S+ZZi+RpMDRWVA0RNNzAKegbMbZt0yb
        L0IAsRFVllKAq/6CaNe5VQg=
X-Google-Smtp-Source: AMsMyM57dqsUvzRTMZqOIMNcHYv3rSotIfYCivMJkaZEe0ElwxzcGV4ScRAwewzQOTSarfRxJFzdKA==
X-Received: by 2002:a17:90b:384e:b0:20d:4b52:ddf0 with SMTP id nl14-20020a17090b384e00b0020d4b52ddf0mr8499959pjb.113.1666167949856;
        Wed, 19 Oct 2022 01:25:49 -0700 (PDT)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id y5-20020a636405000000b0042bf6034b3fsm9406240pgb.55.2022.10.19.01.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 01:25:49 -0700 (PDT)
Date:   Wed, 19 Oct 2022 13:55:31 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Subject: Re: [PATCH v2 bpf-next 0/3] libbpf: support non-mmap()'able data
 sections
Message-ID: <20221019082531.v7fsp7hlnbni5mfr@apollo>
References: <20221019002816.359650-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019002816.359650-1-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 19, 2022 at 05:58:13AM IST, Andrii Nakryiko wrote:
> Make libbpf more conservative in using BPF_F_MMAPABLE flag with internal BPF
> array maps that are backing global data sections. See patch #2 for full
> description and justification.
>
> Changes in this dataset support having bpf_spinlock, kptr, rb_tree nodes and
> other "special" variables as global variables. Combining this with libbpf's
> existing support for multiple custom .data.* sections allows BPF programs to
> utilize multiple spinlock/rbtree_node/kptr variables in a pretty natural way
> by just putting all such variables into separate data sections (and thus ARRAY
> maps).
>
> v1->v2:
>   - address Stanislav's feedback, adds acks.
>

Thanks a lot for working on this!

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

I like that __hidden also works for static variables, that allows hiding this
whole thing in a macro, like so:

#define private(name) SEC(".data." #name) __hidden

private(A) struct bpf_spin_lock lock;
private(A) struct bpf_list_head head __contains(foo, node);
