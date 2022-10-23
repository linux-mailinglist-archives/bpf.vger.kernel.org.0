Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BD56095F1
	for <lists+bpf@lfdr.de>; Sun, 23 Oct 2022 22:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiJWUDJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 Oct 2022 16:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiJWUDI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 23 Oct 2022 16:03:08 -0400
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2236D869
        for <bpf@vger.kernel.org>; Sun, 23 Oct 2022 13:03:07 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id e15so5288715qvo.4
        for <bpf@vger.kernel.org>; Sun, 23 Oct 2022 13:03:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LCEhSUUvA/ORDePsAHMmOSz3gf/Cs28hjFwEr4eXHJY=;
        b=0OH5P3cl/9UnJBppUJsV5sHOksSOHQ2K2wdCClWltTj9fGUYi73QGv74CoLsWB1edC
         LW7js4NrMFZdSF3Ff3LPXim/HW1D9cq1oUMLqG+kg0ArKugRmrkBotSO2b+JxE3J8DU1
         tuAhf77xiPzQjfp8K4arpl0jJ7o0H2nI6F7VTPg1cgsHFAWMG0LHeVzX2q+SjemiI7g7
         F0OtIJUCnTpjroRKyPAstlKqiKHkz4/G5Y+OeCnKCh90KS0rd1GlLCEZDSRb12hoXPff
         CpkCPQjXZGMPd6hkZVzFRn1Cvl6Eq0LTIu4Lp+2ByxSZ720UsUNvoCOen5K4HA6a7dHW
         6/Mg==
X-Gm-Message-State: ACrzQf2ZwVsGY7cdctxtrhAkVt5Rrokg/hIUeBC3HzMd/rH2LmchMhsa
        tbTNxUzN9j9om6x/1rg8iJE=
X-Google-Smtp-Source: AMsMyM6tcqWf/bGe4vR9fnd9LQMu4y0puYlGdE1/rQQPY7uvFakOI91mhyeGyUIWptVQYojLM7MVeQ==
X-Received: by 2002:a05:6214:5198:b0:4b1:c631:2ffa with SMTP id kl24-20020a056214519800b004b1c6312ffamr25734010qvb.86.1666555386478;
        Sun, 23 Oct 2022 13:03:06 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::3f58])
        by smtp.gmail.com with ESMTPSA id az14-20020a05620a170e00b006ce9e880c6fsm13447093qkb.111.2022.10.23.13.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 13:03:05 -0700 (PDT)
Date:   Sun, 23 Oct 2022 15:03:00 -0500
From:   David Vernet <void@manifault.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next v4 4/7] libbpf: Support new cgroup local storage
Message-ID: <Y1Wd9HfBqFqEwWbt@maniforge.dhcp.thefacebook.com>
References: <20221023180514.2857498-1-yhs@fb.com>
 <20221023180535.2861624-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221023180535.2861624-1-yhs@fb.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Oct 23, 2022 at 11:05:35AM -0700, Yonghong Song wrote:
> Add support for new cgroup local storage.
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Acked-by: David Vernet <void@manifault.com>
