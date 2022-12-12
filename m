Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDE464ABE1
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 00:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbiLLX65 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 18:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbiLLX6z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 18:58:55 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AF21B9F3
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 15:58:54 -0800 (PST)
Received: by mail-qt1-f181.google.com with SMTP id jr11so9903333qtb.7
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 15:58:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gypMXGCHGgNY+NqjyDDaQenYXt431V2UQAY79/tZRvA=;
        b=ZB+W4C1urvGtbMDnS2UPa4qB7owGs7XIXuU8v13BLvF6iMdD7/ur7vZsFOt2b8M+hN
         wxEbBkDjzKC+4AwwvmykT2mOl20EkFmrOE3kxjUSGVk1xtSQw2d8BioE3JRKAunKEqiE
         xIKkmuVU3XUXz7JKuorztdBDQiudgdQsY5colkmq0mjTmhFU5l1DFae8TfmCnDBsdwpz
         MwiQq6KR69yvOitlOGsxLE3KVkph7BXUT25e2L5XNNt7eXbzYmbgZ9TQlUnoVRdeKgWJ
         s0nUU4Hy8gmtpHvvNVxMoJhmvTNe+iMJ6tqkUS6rlkMYcvEOlT1Rh0I65zXWUFDB4TKL
         PomA==
X-Gm-Message-State: ANoB5pnX8AD6PQZCStyN/lj+GdCBxnxS/ml2igsaog7wjyiYpki3xgnf
        SWoRrj5LV+7lalLNRsi+8ak=
X-Google-Smtp-Source: AA0mqf7PT64DW75amj/rcs60lnBc5sSuYvUWPXbP5U3sMjNfrbMqC0X907wiknGEVsRWHncv6xCQ2Q==
X-Received: by 2002:ac8:4688:0:b0:3a7:d465:e with SMTP id g8-20020ac84688000000b003a7d465000emr26225321qto.13.1670889533748;
        Mon, 12 Dec 2022 15:58:53 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:6a51])
        by smtp.gmail.com with ESMTPSA id c17-20020ac86611000000b0035d432f5ba3sm6653177qtp.17.2022.12.12.15.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 15:58:53 -0800 (PST)
Date:   Mon, 12 Dec 2022 17:58:52 -0600
From:   David Vernet <void@manifault.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH bpf] selftests/bpf: Fix a selftest compilation error with
 CONFIG_SMP=n
Message-ID: <Y5fAPGtmyL7glLGq@maniforge.lan>
References: <20221212234617.4058942-1-yhs@fb.com>
 <Y5fAHJTI742+jte7@maniforge.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5fAHJTI742+jte7@maniforge.lan>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 12, 2022 at 05:58:20PM -0600, David Vernet wrote:
> On Mon, Dec 12, 2022 at 03:46:17PM -0800, Yonghong Song wrote:
> > Kernel test robot reported bpf selftest build failure when CONFIG_SMP
> > is not set. The error message looks below:
> > 
> >   >> progs/rcu_read_lock.c:256:34: error: no member named 'last_wakee' in 'struct task_struct'
> >              last_wakee = task->real_parent->last_wakee;
> >                           ~~~~~~~~~~~~~~~~~  ^
> >      1 error generated.
> > 
> > When CONFIG_SMP is not set, the field 'last_wakee' is not available in struct
> > 'task_struct'. Hence the above compilation failure. To fix the issue, let us
> > choose another field 'group_leader' which is available regardless of
> > CONDFIG_SMP set or not.
> 
> s/CONDFIG_SMP/CONFIG_SMP
> 
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Yonghong Song <yhs@fb.com>

Also:

Acked-by: David Vernet <void@manifault.com>
