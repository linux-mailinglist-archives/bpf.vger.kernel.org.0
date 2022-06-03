Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C169E53C261
	for <lists+bpf@lfdr.de>; Fri,  3 Jun 2022 04:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239209AbiFCCAA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Jun 2022 22:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238728AbiFCCAA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Jun 2022 22:00:00 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C08639698
        for <bpf@vger.kernel.org>; Thu,  2 Jun 2022 18:59:59 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o6-20020a17090a0a0600b001e2c6566046so11028832pjo.0
        for <bpf@vger.kernel.org>; Thu, 02 Jun 2022 18:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MqFSQ7JwrMu9gS/4dQgsYHyf/4qxkz4eNPGGpzXZITY=;
        b=i/Kgrw1Rj0fKj9Pg49Qkv4AU+DYwf8ZXFE+VvjF/yTVYP0bJwkmXluKpL9FHNEcAtN
         /kNixOh2GYdhptkc1OECX4CmsKwbsQU5G/ct4qyohNSdG5+PztJxcC0Rs8iOBneGOCEX
         onHaj6tRl/FkSHAQ3ihoMPEygoOjkeJNwac0qblicqTQ6t7IzYqUAYOxq3Kekv+4jJIh
         etgMO08bb0MdkUXLgq25tAArgu7AVshD9PACc/OLQvPEhdbh5sZgXsqNp1/PcqoBMBLq
         3SdvKRnWHHOGHw0IsdpvPXVDxIxKUiuLPHDvDcmSDtpMNpH3l69+5mjQEDUFUg+lEehF
         0rAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MqFSQ7JwrMu9gS/4dQgsYHyf/4qxkz4eNPGGpzXZITY=;
        b=umEcygnnwNmBjRhg5rziwLxKGscTBgwGJPJTsAfOPY8Pd+oG1AuR9Q7U95YZrZyZsb
         gdlmlAZ8Ty6MLp4PMx3VjzGCDKUsvDirSbueEtU16ttQuSiom/gfjvb3/A1g+1MH5qz9
         WB/3L986csQzP+MXTan2cqs3VvK0oO23CsR0xnYAdGbXoTMlZvp3hsoew1jUNQQkjp1U
         kkeT8JmUVS41H8DABZUnVlH5kWWHaWeGB3/AaIZxDvW7vVK9LO0yIQ83jGP3Ga4ZY9Bv
         tcF7w7brahG0QZ4IIe737nSNOSTTflMrsovbv55+xryjO9lu6Y1nlYE1N+mjZzFUvCB+
         y99w==
X-Gm-Message-State: AOAM533F+pctG+v2U1fRdUE8N6rDb9womhLcgKMkzZn47aGTXw/sW6Zn
        1CHigtvXK79GbsGCYuuDePUKXPBtqu8/Oh1hTJpr1eiAj3g=
X-Google-Smtp-Source: ABdhPJyc3j6ZtNOJqT3kHLnbUcM2qz/0qtcGJgjhUrAJw71cTq3wpbWhIvr/BXKF8PZIjKNQI8wFZ50zKJVkDxM9A8w=
X-Received: by 2002:a17:90b:1a86:b0:1e8:2b80:5e07 with SMTP id
 ng6-20020a17090b1a8600b001e82b805e07mr1844193pjb.31.1654221598859; Thu, 02
 Jun 2022 18:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220601190218.2494963-1-sdf@google.com> <20220601190218.2494963-12-sdf@google.com>
 <20220603015225.lc4q3vkmsfnkgdq2@kafai-mbp>
In-Reply-To: <20220603015225.lc4q3vkmsfnkgdq2@kafai-mbp>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 2 Jun 2022 18:59:47 -0700
Message-ID: <CAKH8qBs6Wz+vukFomy7LEyohzM6mumsrgRRcyfy-0J_8drJ3ZQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 11/11] selftests/bpf: verify lsm_cgroup struct
 sock access
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 2, 2022 at 6:52 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Wed, Jun 01, 2022 at 12:02:18PM -0700, Stanislav Fomichev wrote:
> > sk_priority & sk_mark are writable, the rest is readonly.
> >
> > One interesting thing here is that the verifier doesn't
> > really force me to add NULL checks anywhere :-/
> Are you aware if it is possible to get a NULL sk from some of the
> bpf_lsm hooks ?

No, I don't think it's relevant for lsm hooks. I'm more concerned
about fentry/fexit which supposedly should go through the same
verifier path and can be attached everywhere?
