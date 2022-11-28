Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5A863AE15
	for <lists+bpf@lfdr.de>; Mon, 28 Nov 2022 17:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiK1Qr4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Nov 2022 11:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiK1Qrz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Nov 2022 11:47:55 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F1513F08
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 08:47:55 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id d128so14046116ybf.10
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 08:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYrgy0UH329zf0vfNIKSu4JlSQguP8II2dnT5Hbx8XQ=;
        b=crRx0LA4HupLBzkSRY3pKfoCrVsX+96QFZyyqXoScK8KLW6lQgk9I7SNBE2OanCuyD
         cD+hfpZOSIssVpMoU0mlBmyns1njkfa3kLdsKnVlrr0AHQR/q41MXKm5kqeJ7d/vsBYi
         hXs+bKRAhzjhtCvjUJ4vBTHGeL/T/9aeom5ByRVSbRxV60K9/Rw6ZkIdS3R1hZRckLPr
         8hKHwy8FNrSZygMdt3lLc1+E9yNZJXUTHg/9UfYCihSptIPYy2IHGYrGRqJqDePlguJu
         kPu5LPDOxcjtXMkTw8jcslVBsCDQw0bb25dCeycvyGkrbpn8jDtHS3YmBRLWsGjJN6+W
         /VNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WYrgy0UH329zf0vfNIKSu4JlSQguP8II2dnT5Hbx8XQ=;
        b=ib4Si2kH92fkvUSy5aoQ5S3gXgSTmywTYeEwkFxytWaHsBGhDTPnQ8ML0KUgQ88y+4
         ZAjcTlUWYYAB+3GyARQLaRtnE5WlRHtfS5ijNs2u6KdzPokILH0cI+H5MZstGujYpBcZ
         0kOwSg8U867JSvn1hsUblFW5tJ6K458qvy6gfE9YfnQgqepb4gFsPyqRVRWl8TDn+XQ8
         OrSssqphNzPmpgHsCUVr+qfgublb7mn2Ez1ry0hAZ4lvU2JlKPiffxB3hCiRYEegwY+b
         whL18q+IbgN7XAL1hPnC3VPrkcd6nn38EW7uom4HIGAj+zgPEA+iMA06aggGYNnTBKZw
         JorQ==
X-Gm-Message-State: ANoB5pms6rUK8oMqBvLv5NI7hgLdRzkO8Zqgw7IwfCnbE7sStBSaq3nU
        suEZQ02QTkFuHq3ZI/iM+QCBRSAhr+rgdl/13jwCFflCmQ/su5eH
X-Google-Smtp-Source: AA0mqf6jp6jEogHfF1ToHjGG4XKcI2ms9gQUDE9McosTlJpsgE05+cwF6EEk13kF5SMOVSehI7apR92ZsyX9NSLT5nw=
X-Received: by 2002:a25:6814:0:b0:6cf:dfbf:bf29 with SMTP id
 d20-20020a256814000000b006cfdfbfbf29mr48974284ybc.90.1669654074182; Mon, 28
 Nov 2022 08:47:54 -0800 (PST)
MIME-Version: 1.0
Reply-To: tjcw@cantab.net
From:   Chris Ward <tjcw01@gmail.com>
Date:   Mon, 28 Nov 2022 16:47:43 +0000
Message-ID: <CAC=wTOhBfH8GA4t=DspjK4GdBAS3ezNBxzz5RWsFmGavkpz3nA@mail.gmail.com>
Subject: Investigating network performance when eBPF is in use
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I have a test case which shows unexpectedly poor performance for one
scenario (TCP_CRR netperf test between 2 namespaces on 1 machine).
This test case delivers under 1 round-trip per second, where it should
be delivering more than 10000 round-trips per second.
I have tried disabling Nagle, but that does not increase the observed rate.

Are there any tools I should be using to investigate what is happening
? Or does anyone on this lisk know what is going on and how to fix it
?

My test case is available here
https://github.com/tjcw/bpf-examples/tree/tjcw-integration-1.2/AF_XDP-filter/netperf-namespace
if anyone wants to try repeating my results.

Chris Ward, IBM
