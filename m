Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B222626D6B
	for <lists+bpf@lfdr.de>; Sun, 13 Nov 2022 03:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbiKMCCG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 12 Nov 2022 21:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbiKMCCF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 12 Nov 2022 21:02:05 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF8B12096
        for <bpf@vger.kernel.org>; Sat, 12 Nov 2022 18:02:04 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id v18-20020a637a12000000b0046ed84b94efso4171478pgc.6
        for <bpf@vger.kernel.org>; Sat, 12 Nov 2022 18:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eCGTG+t8CEOeLJ2mF9QoY4cjEtCccQQqWmSrYL+4SQs=;
        b=QjjNEMQQbmc07pZWcM13Uw10BD5uoUNXuyEa19xtB1l523vYlkOLlHDIzgakxBiTG/
         ntpEf936UMMyF+czO0opx6oTJ2SsfyUEIO4wCD5GgnbcPRwzgrQcTcV7RyrZgTvi7aOd
         45FXnbW5SNCe2b37yakr2CFeR9tZUNnSJHZd/u+KUAxiw9Awd0guexCreUWaXADSGiiA
         TDyF36cTMdL9jILVvMLyOhQQFdMvlH9RNB/RU9J43bQRf1wvB0TKC0hVWnAKUoGM1uJ5
         LOacVap4uZ4cyl7cDAV5xg4OMGX/BKqIgD4CxVESx81NPEHwrQ4rz/6LvUHk66Hx1Pur
         X5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eCGTG+t8CEOeLJ2mF9QoY4cjEtCccQQqWmSrYL+4SQs=;
        b=daY9Ct6ILFbNLlgmNSvcf7FgDpX0hOhEOmfjzoeZ3y3O4/oPitDc1fD9ySisyX7/qG
         47m2/mE1gI7bHP2BRnmf6MmrW4k7LX5JpJL2KuzTjPxRkC35FR8TEGvNZLCN8oQW4/jS
         OEzFqxZjDrnGiNrTbPII2Z+ZuwBIWOAsEYx7LcUT/UfJliAEguyRYgzTxp4L+Du7uqjJ
         ln3u+Z9IDtJmxMo7L/E3oLhjbBX88Aj33WJuiRap3kXhN4X0F8rd0jdEpQYsHLgw4AOH
         pwFo6KtFUemRe0j8AQWrRqJTAjqkqeiJFlHMaLjGLuxKe9lEK3Dq4Unz7ae+YlRcECQc
         82VA==
X-Gm-Message-State: ANoB5pnCgwYcipHXUb0KlnTMQDXRqkztabdownVK4n/CJFcLaSfMdmg2
        5+mhKdICpSddD01E5pHkAU/dXo4=
X-Google-Smtp-Source: AA0mqf7ZR/6/FuhiYmFFKPYXQQRemvdZbiBCWMrZtEpPKzM2X/Tr6RTRxcdyLY4yXnYE0R6q9KT7+NA=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:cc7:b0:213:2708:8dc3 with SMTP id
 7-20020a17090a0cc700b0021327088dc3mr79989pjt.2.1668304923470; Sat, 12 Nov
 2022 18:02:03 -0800 (PST)
Date:   Sat, 12 Nov 2022 18:02:02 -0800
In-Reply-To: <CAFtvWZN937H9D2mKTXevpH8SvrZ_pSNGmAwT5vOR3CZoCzipZQ@mail.gmail.com>
Mime-Version: 1.0
References: <CAFtvWZN937H9D2mKTXevpH8SvrZ_pSNGmAwT5vOR3CZoCzipZQ@mail.gmail.com>
Message-ID: <Y3BQGgcCMaSptEFJ@google.com>
Subject: Re: Applicability of BPF as a general-purpose programming
 language/runtime platform?
From:   sdf@google.com
To:     Gavin Ray <ray.gavin97@gmail.com>
Cc:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/12, Gavin Ray wrote:
> Hi all,

> Apologies if questions/non-patch content aren't allowed on the mailing  
> list,
> I've not used the Linux kernel lists before so not certain of the
> rules/etiquette.

> I watched the talk from LPC, "The journey of BPF from restricted C  
> language
> towards extended and safe C" recently and many of the properties seemed
> desirable. Particularly things like bounds-checking and verifiable  
> locking.

> Is it possible to use BPF as a general-purpose language for writing  
> software?
> If not, is it planned for the future? (Or maybe it's not technically  
> possible)

I'm aware of at least the following:

https://github.com/iovisor/ubpf
https://github.com/qmonnet/rbpf

These projects are developed outside of the kernel and provide a
more-or-less-general-purpose BPF runtime.

> Would be pretty neat, in my opinion.
> Thanks and best regards,
> --
> Gavin

> (P.S. Will I receive replies to this message?)
