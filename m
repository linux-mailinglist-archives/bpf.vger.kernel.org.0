Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3BE6ADAFC
	for <lists+bpf@lfdr.de>; Tue,  7 Mar 2023 10:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjCGJws (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 04:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjCGJwq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 04:52:46 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE65F61A6
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 01:52:45 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so11371256pjp.2
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 01:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678182765;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DKVBc7cLT17uNrNeY+fVgvT0rrII222leitHj/RWk5c=;
        b=fkUOCOjLAcXq6DuRk4c1iWHWUkJ8t75iFyrIyPN/VOSnZZT8d3R9CZbYIfysnVD5L/
         nkn7Pty7Ob0hdxP34J4KHO9zNF6Jhjzi7ASxqoxgX3cl8T2dksNyRzAxHWOIeIwu4G3T
         1XFfGUgBiaqoFn+jxx7jTK2eiVd0mq/fJ8LySSG7jQCo3Ow1+wQUQPTkrvfkL9ZZvrco
         tr3FxpX1lHq84hN5OXeDYm9Ze6U8CJgkupyd9glARVtZH3akUVAWWYslfe9yu+2PZ0C4
         B+l7SQkVjpFaLq9MD8RM6D8z8EmpWFDRL9RRMxYkAh5e1fd93mXbgoq5IsG2wjHBHux6
         1TKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678182765;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DKVBc7cLT17uNrNeY+fVgvT0rrII222leitHj/RWk5c=;
        b=nbDcWa78ouyGhbnucBrTBMPbtUUqikGj7ZP0lO4k+6icKQHAfkHNfa3DWXFJjiztU5
         qbbBcnXBMTO6EUFBzcJ7MiYZGQYnZpWR1mtD/sqthQAz6PAMr3pbALofKNagXK6ZRbSE
         xBBTGriV5m1H9kIVxJY0r5GpHmJZ+cUiym56XuA/7Nme2Th3Hblwp7q06IciNPiDxcEa
         FmpWOtjOW3PsCPu/2tuC+UkkfzegomS4qb2FvsaMOi5SilL9RGCL2LVlDdc65mLHz4Kq
         a4DqvcYMiDJ75Qg9WMEtly+XBjgkhQmL/nSO6Swq4zVJBvsl1RGyM8EvrH3rSOjjPUPt
         5qiw==
X-Gm-Message-State: AO0yUKW2lwkYag2vGbnfS2LkPcpvWjclWmceTjOYlm9RuslqkdjR8bIZ
        nqRZlSNOVWZ6hLf/1XOsYGXhEPfJcn+i3O4TTpc3CiwzOGPZiYj4
X-Google-Smtp-Source: AK7set8Rgli52JRSPf65q96wT4dFYI+/StDGQhApDGK2Yhag+SXSxgKGOwP+JRwMzWuwVAuT3dEA3TC1g/vs0IU6Iy0=
X-Received: by 2002:a17:902:f782:b0:19d:13d2:550c with SMTP id
 q2-20020a170902f78200b0019d13d2550cmr5398571pln.10.1678182765200; Tue, 07 Mar
 2023 01:52:45 -0800 (PST)
MIME-Version: 1.0
From:   Dominic <d.dropify@gmail.com>
Date:   Tue, 7 Mar 2023 15:22:34 +0530
Message-ID: <CAJxriS2W9S7xQC-gVPSAAkfim5EBfQhKBSLzYaq6EyOAWG-sCQ@mail.gmail.com>
Subject: Selectively delay loading of eBPF program.
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, I have multiple eBPF programs compiled into a single skeleton file
and I need a way to delay loading of one of the programs.

I am aware of `bpf_program__set_autoload()` API but once an object is
loaded using `bpf_object__load()`, there are no APIs to selectively
load a program (bpf_prog_load() has been deprecated). Calling
bpf_object__load() again fails.

Wondering if there are any options to achieve the above mentioned behavior.

Thanks & Regards,
Dominic
