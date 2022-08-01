Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDEE587071
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 20:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbiHASlQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 14:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiHASlP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 14:41:15 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668BC65C0;
        Mon,  1 Aug 2022 11:41:14 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id EDAA75C012F;
        Mon,  1 Aug 2022 14:41:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 01 Aug 2022 14:41:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1659379271; x=
        1659465671; bh=2KlCnkBZVyv2RtFsxMYINbCq6hQOqBhQcvfqziW3UYY=; b=k
        bcRPibTVijeTEjbozDTit/pwUYaNoUmMH9NQYxvYUHU3WUI3PhhTO6Y4/mZ5pm0m
        zidcs8qZWM0Wutqt5xz5/CYVD7je0Hj18bpn9HaD+2Np3DEDOdDUgUd+UZcZieRJ
        vDJP5I9vahcGTInJmD9+ztDioazDuOnp0GmH/smh5qlRSWdfwkWLJXVRvk9n6IpU
        dN4epuMRKS0wpvyp8pILSdbZ/GDrTB8/UfbCWsqNgFTEJWHMlR1nGA8ity9b/Fq5
        wx+uDaz4r2VT2t4fapoUhWYMarXL8nSRgnmwmU/GEfHLrQTYKugt/xKkY/VfyqmY
        U39rrifHeRr0fvayDPqAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1659379271; x=
        1659465671; bh=2KlCnkBZVyv2RtFsxMYINbCq6hQOqBhQcvfqziW3UYY=; b=p
        MGgccIgoiEt6CaIC0b0HoeF9Dm/MxlyISI4HtBqyygjyg95T638mhT7BwmQv11RA
        QlfCT8PDhVxm+u98Ef/UVxlBPUJ0at+zymYQog/m/NWC+jNSWGUt4Ock3Bgk0HsZ
        u0/JVnGgQd5YL1MiuPRfYsthwRruyfy+9odat6tevMcZ1IJLuOFqZToSuIfkGenK
        GfuM3HUhjxIUMgEGe94Y8C/2nJqxE9AH/J1N1wgMsaerrydidzJ4upfQPHEV8A63
        TQF45YTTxyibI0EDq7bl/NMFzUerSYRxOuyNkYIpbIPkrLuQhnGq8OrCOa5onOuo
        rvH24f4cZRmkq7lVJUi3g==
X-ME-Sender: <xms:Rx7oYkpRIPgOzJdZLb205a0x1pYV3OfPb9vJ0Z2RD8zxd37fLKOnGg>
    <xme:Rx7oYqo0-RKdqpOX3vM8VeonkkaL_WPv6GDgXFReKy84xfTJAsJFpAtPkBOfCl9g6
    yD3XmYrCXbrLLHv6A>
X-ME-Received: <xmr:Rx7oYpOAhOkWwF6x1BX-7GWAlx3EvgZfwwqnWM3Wn6fpxkcLBD6_heYyz5SiNWYTLxUwgw8gWjU0-_-TWRZWZhxaiuhDCFMDz5toQ9AKUPO9G1pvUyQF98ERtn4F>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvfedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheptehn
    ughrvghsucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecugg
    ftrfgrthhtvghrnhephfeitefgleevtedtffejvedujeekjedugfdtveffjeelvddtfeek
    gefgjefhgfegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnughrvghssegrnhgrrhgriigvlhdruggv
X-ME-Proxy: <xmx:Rx7oYr48Vr8tZJWuszOD_0LG25TMHKuMkhzOyUfytFUsH4vk9jdqXA>
    <xmx:Rx7oYj5VtvGUOHIizk34pXBuBdO2bH7_NJiwL0wHvKLAtOK168_sMQ>
    <xmx:Rx7oYribRpUkxNMz6evGvDGqRgHObjUc0zFhsG8oNoh7rmKBlwwQ4A>
    <xmx:Rx7oYtuz8O0xTIQTddL-MbMJQ2cH4MstFQ6CpJOyyytuQ0t0M-QNOw>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Aug 2022 14:41:11 -0400 (EDT)
Date:   Mon, 1 Aug 2022 11:41:10 -0700
From:   Andres Freund <andres@anarazel.de>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Ben Hutchings <benh@debian.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH v3 6/8] tools bpf_jit_disasm: Don't display
 disassembler-four-args feature test
Message-ID: <20220801184110.7wjntnjy65xwxsu6@awork3.anarazel.de>
References: <20220622231624.t63bkmkzphqvh3kx@alap3.anarazel.de>
 <20220801013834.156015-1-andres@anarazel.de>
 <20220801013834.156015-7-andres@anarazel.de>
 <YugbCvWlwSap23UB@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YugbCvWlwSap23UB@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 2022-08-01 15:27:22 -0300, Arnaldo Carvalho de Melo wrote:
> ⬢[acme@toolbox perf]$ git log --oneline -7
> cebe4f3a4a0af5bf (HEAD) tools bpf_jit_disasm: Don't display disassembler-four-args feature test
> 7f62593e5582cb27 tools bpf_jit_disasm: Fix compilation error with new binutils
> ee4dc290ee5c09b7 tools perf: Fix compilation error with new binutils
> 335f8d183a609793 tools include: add dis-asm-compat.h to handle version differences
> f2f95e8d0def9c5f tools build: Don't display disassembler-four-args feature test
> ede0fece841bb743 tools build: Add feature test for init_disassemble_info API changes
> 00b32625982e0c79 perf test: Add ARM SPE system wide test
> ⬢[acme@toolbox perf]$
> 
> ⬢[acme@toolbox perf]$ make -C tools/bpf/bpftool/ clean
> make: Entering directory '/var/home/acme/git/perf/tools/bpf/bpftool'
>   CLEAN   libbpf
>   CLEAN   libbpf-bootstrap
>   CLEAN   feature-detect
>   CLEAN   bpftool
>   CLEAN   core-gen
> make: Leaving directory '/var/home/acme/git/perf/tools/bpf/bpftool'
> ⬢[acme@toolbox perf]$ make -C tools/bpf/bpftool/
> make: Entering directory '/var/home/acme/git/perf/tools/bpf/bpftool'
> 
> Auto-detecting system features:
> ...                        libbfd: [ on  ]
> ...        disassembler-four-args: [ on  ]
> ...                          zlib: [ on  ]
> ...                        libcap: [ on  ]
> ...               clang-bpf-co-re: [ on  ]
> <SNIP>
> 
> It is still there, we need the hunk below, that I folded into your patch, to
> disable it, please ack :-)

This commit just removed disassembler-four-args display for bpf_jit_disasm,
not bpftool. That should be in a later commit.

Greetings,

Andres Freund
