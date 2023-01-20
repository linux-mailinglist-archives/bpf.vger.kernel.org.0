Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4F46760C3
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 23:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjATWuS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 17:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjATWuG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 17:50:06 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1794F84A
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 14:49:23 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id v23so6605013plo.1
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 14:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eObadKArSgHkepFrKBedeZ5xyeKR3KRJqKeEFPEYgXw=;
        b=pxXQriX7a1w5N5lVDMxWBmB2cm0i/lDxSVo1MNqVC5EnzDZbXdFjDSk5ehcuSArsFL
         YeCxPwZrHhckOqadcBQvADP3FPaE/2YEEZiXiBTTFTOPgp6nBI1fyeiLShNxweaHqpVb
         rPFWs4lLa+p4Fxvqh22RdOrBpvqRw1HGrd294gLX6HNe6yZHjtEyuWPudPe3MtrR0h1P
         Tw2HccuMtZh2qzxHRTchSZH6FFw1vuCfErVrIMyfvLNnfWm8dCcxtGpxafZS0DHtQ6F+
         TrTsaROGlcOP4PX9I9X9nH/6a0jgDIx7Gno2VsufuuEEYgmpQw6ZaR7teoABICaDXtNG
         me5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eObadKArSgHkepFrKBedeZ5xyeKR3KRJqKeEFPEYgXw=;
        b=l3eBMnv8jx8gxoF4HG76wTqx1iEtuC1YZOBUM2ON9rWZSwvtl8pi6UOCh478kiN9A4
         wIPWmmswjeItQRSY0aVez6gKtSKbHnMUrnVL1aX/Ja2dg/GnilR+zeQyhCY6NdorPfrb
         6IUtBNJhuPusjd5I64Pg2ptasLM8mtqyffMQqSi4IwmqwxZL2ER2k0ah+Ri672IwNgkK
         +NH3liCHZeAGheykcRYS/5Lh3QTBjW593K6GC9zZ4VykDweZ4RIS78+GPGOEWPzdjJFy
         45W7CEMp1X3ru1WRBH6pKnNxMTL9VtNxUVK1jPM2MqF6LaYxPQWLTdpiLmtqNDUol9vl
         ZYbg==
X-Gm-Message-State: AFqh2krENxBMaEAgu0Nyj4pFem4UlBZwsszaYGTxWijz3j81HRwYvuaU
        Uh+Rk3EgmL+oT+e91rxoYXYSsOD5vu6ms8ft8lPC6w==
X-Google-Smtp-Source: AMrXdXtao8z/kHlIVvd0cymJJDtEe0u2uVNNtlff2acD17VdLohukAXmnkI3YBg5bmyZqBXdzzfKawd4u6xMfGYPIqo=
X-Received: by 2002:a17:90b:3741:b0:219:fbc:a088 with SMTP id
 ne1-20020a17090b374100b002190fbca088mr2184826pjb.162.1674254926970; Fri, 20
 Jan 2023 14:48:46 -0800 (PST)
MIME-Version: 1.0
References: <20230119221536.3349901-1-sdf@google.com> <20230119221536.3349901-18-sdf@google.com>
 <dfa5590d-17a6-a1bc-62ef-235f0190f037@linux.dev>
In-Reply-To: <dfa5590d-17a6-a1bc-62ef-235f0190f037@linux.dev>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 20 Jan 2023 14:48:35 -0800
Message-ID: <CAKH8qBvgcA9e3S6vn61Qa3x36O69P0AWWt4YQobpE2hinUVrpg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 17/17] selftests/bpf: Simple program to dump
 XDP RX metadata
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
        David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 20, 2023 at 2:30 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> On 1/19/23 2:15 PM, Stanislav Fomichev wrote:
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > index e09bef2b7502..9c961d2d868e 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -83,7 +83,7 @@ TEST_PROGS_EXTENDED := with_addr.sh \
> >   TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
> >       flow_dissector_load test_flow_dissector test_tcp_check_syncookie_user \
> >       test_lirc_mode2_user xdping test_cpp runqslower bench bpf_testmod.ko \
> > -     xskxceiver xdp_redirect_multi xdp_synproxy veristat
> > +     xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metadata
> >
> >   TEST_CUSTOM_PROGS = $(OUTPUT)/urandom_read $(OUTPUT)/sign-file
> >   TEST_GEN_FILES += liburandom_read.so
> > @@ -383,6 +383,7 @@ test_subskeleton.skel.h-deps := test_subskeleton_lib2.bpf.o test_subskeleton_lib
> >   test_subskeleton_lib.skel.h-deps := test_subskeleton_lib2.bpf.o test_subskeleton_lib.bpf.o
> >   test_usdt.skel.h-deps := test_usdt.bpf.o test_usdt_multispec.bpf.o
> >   xsk_xdp_progs.skel.h-deps := xsk_xdp_progs.bpf.o
> > +xdp_hw_metadata.skel.h-deps := xdp_hw_metadata.bpf.o
> >
> >   LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.c,$(foreach skel,$(LINKED_SKELS),$($(skel)-deps)))
> >
> > @@ -580,6 +581,10 @@ $(OUTPUT)/xskxceiver: xskxceiver.c $(OUTPUT)/xsk.o $(OUTPUT)/xsk_xdp_progs.skel.
> >       $(call msg,BINARY,,$@)
> >       $(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
> >
> > +$(OUTPUT)/xdp_hw_metadata: xdp_hw_metadata.c $(OUTPUT)/network_helpers.o $(OUTPUT)/xsk.o $(OUTPUT)/xdp_hw_metadata.skel.h | $(OUTPUT)
> > +     $(call msg,BINARY,,$@)
> > +     $(Q)$(CC) $(CFLAGS) -static $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
>
> My dev machine fails on '-static' :(. A few machines that I got also don't have
> those static libraries, so likely the default environment that I got here.
>
> It seems to be the only binary using '-static' in this Makefile. Can it be
> removed or at least not the default?

Sure, I can leave it out. It's mostly here due to G's environment
where it is easier to work with static binaries.
