Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B7D59526C
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 08:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiHPGR6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 02:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiHPGRn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 02:17:43 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522B4271D62
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 17:06:58 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id w28so7071634qtc.7
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 17:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=mASx77TxkIL7sUwPz2rOt+mGpKrNFR7948vBocw8t8s=;
        b=HWe+nX/LA2uCZuDMRx7TeyJzg79mUmCYZrnUef+uOIwvU/vEb0lqn+kI24qZaL0vjQ
         M4zxjiSQdQEg8JbsyGngN5E7QgQUnRCDLN1jchfwOlc6ECsqpEbCjJVCvvb6qAuaeHvk
         HQobCohaexC8i0vCZxYZNsnNLk2YoscgGs/VG56AY23r6J0xu0UNsoAo3zvBHoiRgVXp
         qOYwKVivoC5tPMh/kRKmCHdM2O3+AXw1xDfR0zgB80iRdpcnerSPe2nX97JaPDsu46YX
         dvXK41W0HuoubIYl/scENaXJ/zJjR+vco2zevO7jillWExrGgkCTxRxDeG/xfVsVaDp8
         eTqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=mASx77TxkIL7sUwPz2rOt+mGpKrNFR7948vBocw8t8s=;
        b=ykCZn9RyG7Z7aRjXmiNx3L05i/lXwBWuNJv78LCSg+6y/j1l6B1pOe7+OpntUuQcSI
         niJgh7evmb9cWZH01SzUpafca9DUjFG5Vh8cPGlgikbGHQbuFg3cNUhERxgfTAaPy6jl
         cKqiLeJV0nxx53dgSLtzPNeMlHLo9/wqL6doh5apabvn3+5S98cFMUxgHOgkpp5orgD5
         t+zCLQULp6hLj0q0Uk2PEn7n0a6rcp2UwCE2Hi/d5M6GRuExKLwZYoZW3B3iEZPief6c
         gf0GeRZR8RXsXnnCsxCvkcpZwiJvdzfY89uLgYdkE6f2vJuG7DWxkMXEy38zFXRjp6JO
         IAgg==
X-Gm-Message-State: ACgBeo0edWy+i2dIrPzzz/lAh1ikGaFmZr3VRzhBdCklD2dRlp4GmKHS
        2AeGcLQE394k6cMvmENTvkmFqN+zy6EvB3JwyuA/go4Tmu0=
X-Google-Smtp-Source: AA6agR4uIPxAGKw/vY2QNkdFf9Th4XAZT0OkD0LpoXUEFuqXXLpRnlDOvHIkPBz08KGEWzvho6t0P03nFXLbI8q+1FE=
X-Received: by 2002:a05:622a:20c:b0:343:f3:b191 with SMTP id
 b12-20020a05622a020c00b0034300f3b191mr16889866qtx.389.1660608417277; Mon, 15
 Aug 2022 17:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAK3+h2zUvfa8pQ37h3ZzSx9n34sTPSUAmSR8grvwQU3OtksiTg@mail.gmail.com>
 <CACdoK4LOu7S5GzDwjEBkOyFqEo2uG-0c7AQF7nN0Fif6rbHFKA@mail.gmail.com>
 <CAK3+h2x2dVepRCtt6MDQ-S_0HDxR1V9ZN2tHXHpfCDWuXW88Rw@mail.gmail.com> <CACdoK4+__ROeqa+P5jPvmVXMW4J48d1RUCW6czyZEKJQbv3mSg@mail.gmail.com>
In-Reply-To: <CACdoK4+__ROeqa+P5jPvmVXMW4J48d1RUCW6czyZEKJQbv3mSg@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Tue, 16 Aug 2022 01:06:46 +0100
Message-ID: <CACdoK4LuvFTOiUGMNC2-CbdrHguyec4_8cdQaVD2eNp3gvsGqA@mail.gmail.com>
Subject: Re: Error: bug: failed to retrieve CAP_BPF status: Invalid argument
To:     Vincent Li <vincent.mc.li@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 16 Aug 2022 at 01:05, Quentin Monnet <quentin@isovalent.com> wrote:
>
> On Mon, 15 Aug 2022 at 23:26, Vincent Li <vincent.mc.li@gmail.com> wrote:
> >
> > On Mon, Aug 15, 2022 at 3:18 PM Quentin Monnet <quentin@isovalent.com> wrote:

> So we investigated this on Slack. The issue is related to libcap (and
> to how libcap is built on CentOS); it is fixed in libcap 2.30 and
> older.

2.30 and newer, of course.
