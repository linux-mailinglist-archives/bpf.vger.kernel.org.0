Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FC564189C
	for <lists+bpf@lfdr.de>; Sat,  3 Dec 2022 20:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiLCTno (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 3 Dec 2022 14:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLCTnn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 3 Dec 2022 14:43:43 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91C06552;
        Sat,  3 Dec 2022 11:43:42 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id f9so7092990pgf.7;
        Sat, 03 Dec 2022 11:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Wip7VNHAeBJSUz4o+dzo5yQSZVeZvNE2xd3eHUcNhY=;
        b=PWwLZI2D9kN6A8HKAB8NLpg0bDYcB2DMyxEWLe4Yc/L9IjMgAGcRQO6TUQHZHCK9/V
         xEyadl424A2eS+YxwzzZQUw/VpgyaZ3EB2K12wkGYA3rluLCjaLluQ079Ah0nicQyLnS
         urRNeVaRWvSoDt7I5jCpyZVIGS7sOH/c37XQbXQ16K0fBTiXeIBBReoaTFJCzhT9XdEq
         UxMj3DocCSrSOpCiEX/E9nRM8VeePDgld00JmO3plLbNli+vPjiIg80DqLfm/CHMS6Pl
         uMPXSrFRCe3f1nyHMuLTgIt6M6Ym4DqRVN/74skOCI513efv3W9xU+DREL8Nd1ReBBG/
         xmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8Wip7VNHAeBJSUz4o+dzo5yQSZVeZvNE2xd3eHUcNhY=;
        b=Ww8mcsqQ5lmmVp3m+L75srmymNn+RT2jJf8djbdr8ygc8qJMdM8X4gpl8YD3CgNfaD
         RJ6M9tZKbE92jRgP5x49pybSSVqpldEZMqffBph1uxdBt5KJxwtkz9OTNQ4xTIC3Ii2H
         drlPlEukof3/sJ2gwvaCvS5F2v7oqMcNn2PXhtcoC/J4LwsM2ToC+HkFipr8cusED6Ia
         qql1UHoQCsYqmmoR5VI0tfsSU2lqGsNPrzV8hTX88AtIWK3AdZVFepQr1wPPMGRLYxH6
         ZDRPQCTC9/WlWdxxePKZjQYWUTGkBlMv5WVhVlUWXPVSRr5K5OqzcRCu6cTIaxSE2s/J
         WteQ==
X-Gm-Message-State: ANoB5pkas1XAyLPZbvYdw602KGeQWIrJwfpWi5PhyDWUWaHMeOvWu07Y
        N7ohGns3ypxPoRXGZb7CLsZQ3+s9Jls=
X-Google-Smtp-Source: AA0mqf6YU/p50wfEksJKwYy4ZuwSHxhLVxeZI4DoJs6Ew7clCncgr7tET8iILz3aeKqWh1EW2tEx3Q==
X-Received: by 2002:aa7:9e1a:0:b0:576:cd93:98cf with SMTP id y26-20020aa79e1a000000b00576cd9398cfmr394653pfq.53.1670096622136;
        Sat, 03 Dec 2022 11:43:42 -0800 (PST)
Received: from localhost ([129.95.228.55])
        by smtp.gmail.com with ESMTPSA id n13-20020a170903404d00b00189548573a2sm7716396pla.161.2022.12.03.11.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 11:43:41 -0800 (PST)
Date:   Sat, 03 Dec 2022 11:43:40 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     mtahhan@redhat.com, bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     jbrouer@redhat.com, thoiland@redhat.com, donhunte@redhat.com,
        john.fastabend@gmail.com, Maryam Tahhan <mtahhan@redhat.com>
Message-ID: <638ba6ecadfaf_16f042086c@john.notmuch>
In-Reply-To: <20221201151352.34810-1-mtahhan@redhat.com>
References: <20221201151352.34810-1-mtahhan@redhat.com>
Subject: RE: [PATCH bpf-next v2 1/1] docs: BPF_MAP_TYPE_SOCK[MAP|HASH]
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

mtahhan@ wrote:
> From: Maryam Tahhan <mtahhan@redhat.com>
> 
> Add documentation for BPF_MAP_TYPE_SOCK[MAP|HASH]
> including kernel versions introduced, usage
> and examples.
> 
> Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>

Thanks Maryam. LGTM.

Acked-by: John Fastabend <john.fastabend@gmail.com>
