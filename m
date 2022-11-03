Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D106189C9
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 21:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiKCUpL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 16:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiKCUpK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 16:45:10 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A1F1F2D7
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 13:45:07 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id hh9so1985978qtb.13
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 13:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvUeR17Dc3VeExLudEoYi9fj99bbNTo4qjP+ymZHUQ4=;
        b=D2xVNuZBzSYRgPq7en8jec27TO419WvYlN5pLhNGOyNQs9fHJI+nmcX6J1KH+h4nJI
         O4GqlFEbSE60Xgpe6s2I3LAfvQz9p6Og0YkMS1xD8Id0X9zyOdc++WGa8yn/XbdwODgo
         v7vOKdRjorLgaHF5Fcu/HLaVN6VO3tLmAu1RgBMsctn4lUVBHZqPhwHdKudRtTo3VIHk
         1cmbtJGINr/4NHJC3Lket/pK1tHZDtm31z7vr0j9kIZwoEp98CLXUA36D1JUPOUJE+FF
         NRe/Zqsh4aytNur6zbLWx++XkXLLRHg+I92Vj9A0zSru/LNrhPE6i/kFi8Biy3fWA1Lo
         tmvQ==
X-Gm-Message-State: ACrzQf0KeK+1+Sg3NR9Ls+eswOrqZ/FHGFeP0S5jpYvhybyyNk0XsJnY
        ajGys/ZSV6SPCwfBqL5TBSHNAUngYYzUh+eJ
X-Google-Smtp-Source: AMsMyM7TqlTYrGYSEWUDncnaZRjfm50LBCvnCR5o+ahlK/jb00lO850uo9FIL4RNUpkBKOTaSZb4yA==
X-Received: by 2002:a05:622a:164f:b0:3a4:f141:92fa with SMTP id y15-20020a05622a164f00b003a4f14192famr25681352qtj.447.1667508306536;
        Thu, 03 Nov 2022 13:45:06 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::b27e])
        by smtp.gmail.com with ESMTPSA id e17-20020ac84e51000000b0035d432f5ba3sm1146322qtw.17.2022.11.03.13.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 13:45:06 -0700 (PDT)
Date:   Thu, 3 Nov 2022 15:45:05 -0500
From:   David Vernet <void@manifault.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: Re: [PATCH bpf-next v4 02/24] bpf: Allow specifying volatile type
 modifier for kptrs
Message-ID: <Y2QoUdvhPaMq06Ub@maniforge.dhcp.thefacebook.com>
References: <20221103191013.1236066-1-memxor@gmail.com>
 <20221103191013.1236066-3-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103191013.1236066-3-memxor@gmail.com>
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

On Fri, Nov 04, 2022 at 12:39:51AM +0530, Kumar Kartikeya Dwivedi wrote:
> This is useful in particular to mark the pointer as volatile, so that
> compiler treats each load and store to the field as a volatile access.
> The alternative is having to define and use READ_ONCE and WRITE_ONCE in
> the BPF program.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Acked-by: David Vernet <void@manifault.com>
