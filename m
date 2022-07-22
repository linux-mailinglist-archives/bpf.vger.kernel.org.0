Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880EF57E60C
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 19:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235970AbiGVRze (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 13:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbiGVRzd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 13:55:33 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EFA186DF
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 10:55:32 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id g17so5179653plh.2
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 10:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x9mUgUlLelfiYpMAS0AawhxvSmSAgtwPkT+u5kRHeFg=;
        b=pztXqAAeYfPTwlfJaqOsWmhBDxF0DUp1mc7zYxX0zBCOc0tqnCj75ShwrLEt4A8GaZ
         BtPKOKx+Ppg0P1OzoeiKi80lLLZizk2FTsrCxt+DOBbrQiFhD4dAZU0JXKBxohf2JpSh
         1FTLEVOPYPilavW+3h0o849QFdt09hDP30NRyTT1kYaOa5E9m0bn+BomHPmN76vY2tNZ
         o6AQfLJdfX626drd5dCQB7MIT/5ie+eqHyPgy85C5ea41VXy57Ew/g6L/yciYnLm7n68
         u75S+huuwtVNouOnXttw3ZAFh+2LIL5IMygbDeVZoI394G/6A2iA31O0fp1K9qL0iox+
         uuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x9mUgUlLelfiYpMAS0AawhxvSmSAgtwPkT+u5kRHeFg=;
        b=GV8xejJFjrQk30ZW7twlgaPY1pgbF0VFyBus8dfQmywuYUnXWZsaspAlFJter/bUpV
         BsBQ+4NvS8e1PaaHvOBhL9UGPoBq0x5quOrrnVSpdAcOHGoGNOCXboVFqGfm2g6V9gSI
         5VhKo5ze3jMeIOhfvSP4vbEPo7ejCRrQX/JDhwiDHZ+HjjAe2OyiKtmp7dgsVvcUwkg7
         8kgp0LGGzx9H7ryiJGaYNl4m15EPpMvUux8cqKwE5jmuTRcwqMGr7v4iGaa4kYRnGpxK
         DG6Tw2g9Ip7s/TYM3dVzILyoAh1hT9OLvmqqWv01fmUZqVMkaetXDrH816q1BW4Wva6a
         qewQ==
X-Gm-Message-State: AJIora/F/4uShE3z3kMIUVB+jcsyOdCKe8d/+PDu/NsuI9DSdw4MMJrS
        rr9XJNi+Xag7YQQ/fMQ2BXA=
X-Google-Smtp-Source: AGRyM1uIGD4mxh0INsQk2bi51d2TYys2AfqVTW8QNVhf+yNlNjHVP9BxtXJqA339TAFtO1uFFYVKCg==
X-Received: by 2002:a17:90a:1943:b0:1ef:8146:f32f with SMTP id 3-20020a17090a194300b001ef8146f32fmr845317pjh.112.1658512532244;
        Fri, 22 Jul 2022 10:55:32 -0700 (PDT)
Received: from macbook-pro-3.dhcp.thefacebook.com ([2620:10d:c090:400::5:8bc8])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902ed8c00b0016cd74dae66sm4021496plj.28.2022.07.22.10.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 10:55:31 -0700 (PDT)
Date:   Fri, 22 Jul 2022 10:55:28 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     quentin@isovalent.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        jevburton.kernel@gmail.com, bpf@vger.kernel.org
Subject: Re: [RFC][PATCH v3 02/15] bpf: Set open_flags as last bpf_attr field
 for bpf_*_get_fd_by_id() funcs
Message-ID: <20220722175528.26ve4ahnir6su5tu@macbook-pro-3.dhcp.thefacebook.com>
References: <20220722171836.2852247-1-roberto.sassu@huawei.com>
 <20220722171836.2852247-3-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722171836.2852247-3-roberto.sassu@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 22, 2022 at 07:18:23PM +0200, Roberto Sassu wrote:
> The bpf() system call validates the bpf_attr structure received as
> argument, and considers data until the last field, defined for each
> operation. The remaing space must be filled with zeros.
> 
> Currently, for bpf_*_get_fd_by_id() functions except bpf_map_get_fd_by_id()
> the last field is *_id. Setting open_flags to BPF_F_RDONLY from user space
> will result in bpf() rejecting the argument.

The kernel is doing the right thing. It should not ignore fields.
