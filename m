Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FB0565E55
	for <lists+bpf@lfdr.de>; Mon,  4 Jul 2022 22:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiGDUTa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Jul 2022 16:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiGDUT3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Jul 2022 16:19:29 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327FD9D;
        Mon,  4 Jul 2022 13:19:28 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 228075C00BB;
        Mon,  4 Jul 2022 16:19:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 04 Jul 2022 16:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1656965964; x=1657052364; bh=00wajHBD1Y
        dQZRoyQhxG6eyVYzxLaf4iqwOqn9a8ZcY=; b=PrhBhsEFdtMU3VTPRHYDF5dgeH
        +GwgzjeacV059QpdfO051gMNfKYE1NRwkuyZWSf1EwT8oZ9CE8DEhvyLxh8xRnv+
        wNVI5L13G/qMKnI4j7LNIRt+7sPhLT3ZJaqyY6yLBzUp2u3LGKdmAfkChXGdCG3k
        ayv459Sa/tvFeo2XGM3lCuHou8Ppc+jJWF3evEkuKznf4SeW4B001C4yH+1V7jxc
        scDtAJ7Rh5QbnGn6eC9EsWYH+9LRBZNt81epmTBamOVKPq/0cj8hdJfqAyh5rDZe
        Gvs3I8EqcSFEUvQWEsiBKYTYKLVGO9VWvkd5/35zY28Y6GfboEwWciZfndyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1656965964; x=1657052364; bh=00wajHBD1YdQZRoyQhxG6eyVYzxL
        af4iqwOqn9a8ZcY=; b=Nxy9qk/fUEvGkzs7zTiYZTcEAz20BnqqJbj+Z7/PHPGU
        Iog7MO2ob2CxK6Q63Zyn/2P575XgprIUsWgABI9siFAgUWQ8eLyXhnoB88sWE2m0
        Wl+5XfVtKT2wi/aaT+DCfzhmRHsxjGLBX5rVduPPifOu8cXk5kYfkYagxGqY8dpO
        Eu/I5wluQmMAZec+R5S4s+jY6PAq1EfKFFCLe/fkDS6xuUh79E0vGsLJJIQy8yip
        gXBSbvKK3+gpNXFmXPedj0C2rHXsXZuaahfoV3cblHn7UlT7tEMfQHxxsWEJnWOU
        t/8qt0Ii5u0vfVYVR/F8Wa2lUFUeVPXyEApFi1+i3g==
X-ME-Sender: <xms:S0vDYjEzKc2JNffSuTBs3BsdA_No9foKKZ-nPnO6pDl1aFkgPZwuKg>
    <xme:S0vDYgXuqlW47atC2UXxnuVhuPH_osc32Gcu6Z0KMtLbcF0VGAymWhj92bitmgynE
    5tmBoBdg9O9v7Nleg>
X-ME-Received: <xmr:S0vDYlIunMW0b2kg0-RsulYVxPyg2x-d4UZZAOExHU2aSM4jqfY3NqSHQhu8hQqsnv3k8gOPpjsA-GpmOrmFvWVVJQiALWeSimKMmMu8OR9LGA6QWrvV38RZL1B9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehledgudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetnhgu
    rhgvshcuhfhrvghunhguuceorghnughrvghssegrnhgrrhgriigvlhdruggvqeenucggtf
    frrghtthgvrhhnpedvffefvefhteevffegieetfefhtddvffejvefhueetgeeludehteev
    udeitedtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhgurhgvshesrghnrghrrgiivghlrdguvg
X-ME-Proxy: <xmx:TEvDYhHRmIn-eEytWXVxyvGyanFxac3v8_MWcO3smunLbzSA54FHBg>
    <xmx:TEvDYpUO1pegndjVfQ2yPlwoIYiIpZw-Bq2IZmbkSmSmJJCYhhV0WA>
    <xmx:TEvDYsOvgB8b1ZLsZi74q54Zdld5VG0qWXb1po_xdrKi862msxde9Q>
    <xmx:TEvDYndFbe39HwWUXmpV87rgKkTR_0qfK2ff7ZKlDssc0voisIQFsg>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Jul 2022 16:19:23 -0400 (EDT)
Date:   Mon, 4 Jul 2022 13:19:22 -0700
From:   Andres Freund <andres@anarazel.de>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: Re: [PATCH v2 0/5] tools: fix compilation failure caused by
 init_disassemble_info API changes
Message-ID: <20220704201922.pvrh4cmmjxjn4mkx@awork3.anarazel.de>
References: <20220622231624.t63bkmkzphqvh3kx@alap3.anarazel.de>
 <20220703212551.1114923-1-andres@anarazel.de>
 <YsKvPW+1RkVvq8aX@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsKvPW+1RkVvq8aX@krava>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 2022-07-04 11:13:33 +0200, Jiri Olsa wrote:
> I think the disassembler checks should not be displayed by default,
> with your change I can see all the time:
> 
> ...        disassembler-four-args: [ on  ]
> ...      disassembler-init-styled: [ OFF ]
> 
> 
> could you please squash something like below in? moving disassembler
> checks out of sight and do manual detection

Makes sense - I was wondering why disassembler-four-args is displayed, but
though it better to mirror the existing behaviour. Does "hiding"
disassembler-four-args need to be its own set of commits?


> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index ee417c321adb..2aa0bad11f05 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -914,8 +914,6 @@ ifndef NO_LIBBFD
>          FEATURE_CHECK_LDFLAGS-disassembler-init-styled += -liberty -lz -ldl
>        endif
>      endif
> -    $(call feature_check,disassembler-four-args)
> -    $(call feature_check,disassembler-init-styled)
>    endif
>  
>    ifeq ($(feature-libbfd-buildid), 1)
> @@ -1025,6 +1023,9 @@ ifdef HAVE_KVM_STAT_SUPPORT
>      CFLAGS += -DHAVE_KVM_STAT_SUPPORT
>  endif
>  
> +$(call feature_check,disassembler-four-args)
> +$(call feature_check,disassembler-init-styled)
> +
>  ifeq ($(feature-disassembler-four-args), 1)
>      CFLAGS += -DDISASM_FOUR_ARGS_SIGNATURE
>  endif

This I don't understand - why do we want these to run under NO_LIBBFD etc?

Greetings,

Andres Freund
