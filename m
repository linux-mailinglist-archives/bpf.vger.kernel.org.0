Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970A9674B34
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 05:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjATEuL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 23:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjATEtV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 23:49:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDF2D0D9E
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 20:43:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75AC1B827E8
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 02:15:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A25C43396
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 02:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674180956;
        bh=bX0/q7PjcsSi4896E9fw8c7E2xywXdcBvGNiSmFIRzg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kLORRCsTgHwAljQrgXKnPxuo6+UG4ZPVNMJ+50EmGXu74LG+ECziJ58a0t0DmvGT+
         +/3x1+tAcGlUOfbZe7Ewyf4BR9tuOjv1nZhyfzqABP1Ltjo3H7l4tsUEW/Hy5NNdhf
         E9wgSiEOhHYxQiM7d9Buee3yjFRypBLv5rtVcXJqjcQC6Y5UqeHXBhOxyOuya8xEhq
         klSnY8AXDRkvxS9aA9rbPQMpclYH9BQYamSP8iXTLLu4x+osbQ+MfsymiCHQ7epyIB
         o6IzI0t6Ryqj3J2uxoGTmhJgwKWSnP3l1fnhBMZ8wcx79BtWHIFs7eR03eHRu5pgSS
         YLp9qHHVXPxmw==
Received: by mail-ej1-f50.google.com with SMTP id rl14so7213910ejb.2
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 18:15:56 -0800 (PST)
X-Gm-Message-State: AFqh2kqM0FEDZPs7wQ1UL0hmcj9TcJELNfOHGB5LU05HGQGZidj3z1Dt
        Hw5qR/qBHUFrqomCsOSJIEVqGRBv4DE0dWiV14Gvjw==
X-Google-Smtp-Source: AMrXdXsKppXlY4Gw0f8JZqhJqfVHOnKPlThA3uWn5l7Y5r98z4vj3hP/2lyDrDN4gFotKbpRFBhi34Ozxe/VUvxAipY=
X-Received: by 2002:a17:906:1796:b0:873:2ca1:9118 with SMTP id
 t22-20020a170906179600b008732ca19118mr871410eje.0.1674180954363; Thu, 19 Jan
 2023 18:15:54 -0800 (PST)
MIME-Version: 1.0
References: <20230119231033.1307221-1-kpsingh@kernel.org> <20230119231033.1307221-3-kpsingh@kernel.org>
 <5e99e2d6-30a8-ea94-d911-de272a2a0a69@schaufler-ca.com>
In-Reply-To: <5e99e2d6-30a8-ea94-d911-de272a2a0a69@schaufler-ca.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Fri, 20 Jan 2023 03:15:43 +0100
X-Gmail-Original-Message-ID: <CACYkzJ5LwLD_yo=b5MMvpDUBGJ_puzr2TLYEK-DR3NRDRwgSLw@mail.gmail.com>
Message-ID: <CACYkzJ5LwLD_yo=b5MMvpDUBGJ_puzr2TLYEK-DR3NRDRwgSLw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] security: Generate a header with the count
 of enabled LSMs
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, jackmanb@google.com,
        renauld@google.com, paul@paul-moore.com, song@kernel.org,
        revest@chromium.org, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 20, 2023 at 2:32 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 1/19/2023 3:10 PM, KP Singh wrote:
> > The header defines a MAX_LSM_COUNT constant which is used in a
> > subsequent patch to generate the static calls for each LSM hook which
> > are named using preprocessor token pasting. Since token pasting does not
> > work with arithmetic expressions, generate a simple lsm_count.h header
> > which represents the subset of LSMs that can be enabled on a given
> > kernel based on the config.
> >
> > While one can generate static calls for all the possible LSMs that the
> > kernel has, this is actually wasteful as most kernels only enable a
> > handful of LSMs.
>
> Why "generate" anything? Why not include your GEN_MAX_LSM_COUNT macro
> in security.h and be done with it? I've proposed doing just that in the
> stacking patch set for some time. This seems to be much more complicated
> than it needs to be.

The answer is in the commit description, the count is used in token
pasting and you cannot have arithmetic in when you generate tokens in
preprocessor macros.

you cannot generate bprm_check_security_call_1 + 1 + 1 this does not
get resolved by preprocessor.
