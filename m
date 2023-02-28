Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6605B6A5DF2
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 18:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjB1RIq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 12:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjB1RIo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 12:08:44 -0500
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B1CDBCB
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 09:08:43 -0800 (PST)
Received: by mail-qv1-f47.google.com with SMTP id ne1so7317232qvb.9
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 09:08:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SF96aD5Pxmik0fGEQTvG0K63ve5cjLK5R5HqX++1LBk=;
        b=oVTvtY3pydLozoNm+UbFBJqyJqdLr+ufqykzb5+HjCF4vZHt7CZcoNgMsBtuoB1xR5
         z4uDcfwKp21jlq0gkrx1TmEUyJkofiTQ3odq/yMM8zkmeD2HthxAQk4008hAVbXAwHBl
         FKrvfSojB2DM6zCD8pXsEUDSv/+uGvb83rUdrQk6FWLs1BiefoGgwGdLJ2S0XLm0vKaH
         Ms2FrNytwaco9SzN+/0RGkp5aVi8kdkNZbEbZ2dzttTgsiB7UcZ9bmAeHEh6QFBz2z3m
         sySs9om3f5zyM91roH5hok10P18MwdmpL9vs7ylgrPtPgj4a7QmP5Ejpyywyl9HZ6srM
         gaPg==
X-Gm-Message-State: AO0yUKUwofTjVcqMS+MxSH5b7fEG2jF0s3qbym2r7HIxqXA03aL8mPh2
        QD/KcoJ1xnWBaRY/lWPKsOlm00uRRUxHi3gg
X-Google-Smtp-Source: AK7set95Ezcw2WH0pkb/pUIFwMSfZI4WFMcIMIcxNbSWmPqkXi9QqZITdUCHCQb069AKNA2KD8FNAw==
X-Received: by 2002:a05:6214:19c5:b0:535:1d24:2c5a with SMTP id j5-20020a05621419c500b005351d242c5amr6966460qvc.31.1677604122516;
        Tue, 28 Feb 2023 09:08:42 -0800 (PST)
Received: from maniforge ([2620:10d:c091:480::1:f172])
        by smtp.gmail.com with ESMTPSA id c202-20020a379ad3000000b007426e664cdcsm7048068qke.133.2023.02.28.09.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 09:08:42 -0800 (PST)
Date:   Tue, 28 Feb 2023 11:08:40 -0600
From:   David Vernet <void@manifault.com>
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf@ietf.org, Dave Thaler <dthaler@microsoft.com>,
        Yonghong Song <yhs@meta.com>
Subject: Re: [PATCH V5] bpf, docs: Document BPF insn encoding in term of
 stored bytes
Message-ID: <Y/41GJTQI6Lgikwo@maniforge>
References: <87r0ua7fu8.fsf@oracle.com>
 <d3dab9c1-5bb8-a23f-5ef5-2973ac05a554@meta.com>
 <87h6v6i0da.fsf_-_@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6v6i0da.fsf_-_@oracle.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 28, 2023 at 10:51:29AM +0100, Jose E. Marchesi wrote:
> 
> [Changes from V4:
> - s/regs:16/regs:8 in figure.]
> 
> [Changes from V3:
> - Back to src_reg and dst_reg, since they denote register numbers
>   as opposed to the values stored in these registers.]
> 
> [Changes from V2:
> - Use src and dst consistently in the document.
> - Use a more graphical depiction of the 128-bit instruction.
> - Remove `Where:' fragment.
> - Clarify that unused bits are reserved and shall be zeroed.]
> 
> [Changes from V1:
> - Use rst literal blocks for figures.
> - Avoid using | in the basic instruction/pseudo instruction figure.
> - Rebased to today's bpf-next master branch.]
> 
> This patch modifies instruction-set.rst so it documents the encoding
> of BPF instructions in terms of how the bytes are stored (be it in an
> ELF file or as bytes in a memory buffer to be loaded into the kernel
> or some other BPF consumer) as opposed to how the instruction looks
> like once loaded.
> 
> This is hopefully easier to understand by implementors looking to
> generate and/or consume bytes conforming BPF instructions.
> 
> The patch also clarifies that the unused bytes in a pseudo-instruction
> shall be cleared with zeros.
> 
> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>

Acked-by: David Vernet <void@manifault.com>
