Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70FC55EA5B
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 18:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbiF1QzN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 12:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234076AbiF1Qye (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 12:54:34 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF09C0
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 09:52:37 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 189so7257189wmz.2
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 09:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lFKEEyiTQsvs2ddCbf3cjiC1UaHwb4p7/C9iETksuO8=;
        b=CjZanmBpOZVdIhdZrYwxOXbpdv6zqkxzEuKTNItGvSCPZhoMuKkyIBBjzqWaM1qIkT
         4cp1CBG4bkgLSyZM63b4xOp9YC40E7Hw9Y81hA6LlZIKIZNzhCpLP/yjlAZqS0MHocPi
         +5ErFzJmdTCRdGrH2mnRMpRerFtOO7ltlVAK3kwCwVTt4qeM0XsU87BvgnNUW+b9fwlq
         rvn6C379YPkF/5omQaIHDjn5PsmmNsT2HSutk2gY7aps9yZgeYYB1oHYHJvsdHNFdRTg
         6EUDCy3t2JRq5syjjCwa+rp51Gptse7IBxpneCgSdFOVZKIk2nRF9Ktyom3HAKdzzIvO
         1aRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lFKEEyiTQsvs2ddCbf3cjiC1UaHwb4p7/C9iETksuO8=;
        b=zGd7r0Rf1ruUNnK4nHq1Uy5jmy4oehcQ+NJDekW11VGVyuJAkgGbxU5L2/rqwGSPWF
         4bfugO+awrejSiV4WU+lbhW2j7rcNl8N4t7fTolUhr60txUIpVnooYjzeoE89UegOIeX
         mnHvX6qV3Avx/Omc3+b0zL8bRJy1VghnDYotHJgcyjBzOJMEKMcjws1pGWpfcTQt69f9
         xn6RcR5zk/DE+A5Srdp6Y19FM3WeByAaE5Q2bxiXT1xT48nVizWpjnZi5uKoTUjQB2St
         c+o0AHlCmLPI+X7728DKqulX6pDvMQlCK4vUtNQ7t3Sc0YTVyMPw3mZRA86BJRJQGIDS
         E69A==
X-Gm-Message-State: AJIora/47ygKxJ2PQ6GWTg6c8AJmTkeOetgnvpXDQiyHncgbCNL7wtXs
        RLLLmBCSaCnYwM80jXFt8w57HA==
X-Google-Smtp-Source: AGRyM1sydGLUZduCj94shSkzl/ouVI7Gpo7XW+fVDk5SXwhYfIOPIuulXGtRLG87TmyLgSpCA4qnPg==
X-Received: by 2002:a05:600c:3d92:b0:3a0:4b71:f2c4 with SMTP id bi18-20020a05600c3d9200b003a04b71f2c4mr638988wmb.160.1656435156093;
        Tue, 28 Jun 2022 09:52:36 -0700 (PDT)
Received: from [192.168.178.21] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id j3-20020a05600c410300b0039c4506bd25sm160657wmi.14.2022.06.28.09.52.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 09:52:35 -0700 (PDT)
Message-ID: <2acc744b-be20-2503-2c2d-40a0a8d47a57@isovalent.com>
Date:   Tue, 28 Jun 2022 17:52:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH bpf-next v3 02/10] bpftool: Honor BPF_CORE_TYPE_MATCHES
 relocation
Content-Language: en-GB
To:     =?UTF-8?Q?Daniel_M=c3=bcller?= <deso@posteo.net>,
        bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     joannelkoong@gmail.com
References: <20220628160127.607834-1-deso@posteo.net>
 <20220628160127.607834-3-deso@posteo.net>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20220628160127.607834-3-deso@posteo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-06-28 16:01 UTC+0000 ~ Daniel Müller <deso@posteo.net>
> bpftool needs to know about the newly introduced BPF_CORE_TYPE_MATCHES
> relocation for its 'gen min_core_btf' command to work properly in the
> present of this relocation.
> Specifically, we need to make sure to mark types and fields so that they
> are present in the minimized BTF for "type match" checks to work out.
> However, contrary to the existing btfgen_record_field_relo, we need to
> rely on the BTF -- and not the spec -- to find fields. With this change
> we handle this new variant correctly. The functionality will be tested
> with follow on changes to BPF selftests, which already run against a
> minimized BTF created with bpftool.
> 
> Cc: Quentin Monnet <quentin@isovalent.com>
> Signed-off-by: Daniel Müller <deso@posteo.net>

Acked-by: Quentin Monnet <quentin@isovalent.com>

Thanks!

