Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7E16A3DEB
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 10:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjB0JLU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 04:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjB0JLG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 04:11:06 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB62BDC3
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 01:02:59 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id s20so7513607lfb.11
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 01:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6udAyQPPrefxwSMfHOHyGD+EHASxuRkF7yTsrJyUE/g=;
        b=TUplo9vBcOMf4p0LoDNPO8ULnf1wGx8PAbgHaFrbkwJrJ/iZ/6Rm+lsI+InqAmhHeC
         9mQjKjFQiGWz9lI6PBR/nAbAfBpxKv7yldsGXPrJbTiITy6uAVXBV8V9XtD/OSdLyYC4
         LiZV6naaURrKvrldN6eQ00y7LTcVNP7qUxLghgUAHLl2UAgPPRrnlY7gFccsgVtqaX1m
         Z4013+0cdL8UesyZeiquQb7KEwrHkSlrsi0B5LfAB5b90Q6JKorOGlT009XuHwpYSG26
         nCjzEx5z7aCYnoK/XnRJyBByDiYpb/J+RfxbSPYwuX3jxfHR0bA9oxrYrRsmDwJ2QbPw
         OGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6udAyQPPrefxwSMfHOHyGD+EHASxuRkF7yTsrJyUE/g=;
        b=qAMn3yUDoPbnQcXwKgT50jK4hI59eH0eeZmkhtNgGmhKqM2XkkIlO6AnmKCd3AYQ26
         36djX8Ho12bm603SbaYTiRu5lwB6EItRZFtJVV7Jt0diO4DicyMBtnZLKYdNRDZ8Uzcw
         W6q86pQh3Ar0cv1NY4JwcJyr8ghOdN5otikhRyVuI12tAVz6So7736rR4hzFS7vtvAbl
         Vx3hJrcrOdObuJ9/zffkwIdIdLuUgn1M6QOJllHhoQEdh2LdUc37sArwbxRd/4iymryv
         grt494wIn0oSWd/dN8YU8icF75JXaQmwSSrmEonJgOHyomF/0McjkJp9Np9zjd3x+iAM
         JO+A==
X-Gm-Message-State: AO0yUKUsVDM/zlMQp56EbxcfbkCV+i/VJXvqcfAq/njxV+RgQMaA6k+E
        TomBEMGSbdzFvM8HCnF/r9FApiIEuCmXPvh0LSQul5CqwYAc+JII
X-Google-Smtp-Source: AK7set+B4q4Fi/QH0Pq0VlcFQ/wh1I/5vGX1NUEv85QPR8/6bPc5aA96UWXfYy7iKDp29FiV1xllWMwW2cOsakNNmow=
X-Received: by 2002:a05:6512:b10:b0:4dd:9eb6:444e with SMTP id
 w16-20020a0565120b1000b004dd9eb6444emr3636434lfu.5.1677488577975; Mon, 27 Feb
 2023 01:02:57 -0800 (PST)
MIME-Version: 1.0
From:   Anton Protopopov <aspsk@isovalent.com>
Date:   Mon, 27 Feb 2023 10:02:47 +0100
Message-ID: <CAPyNcWfEVqJ562MAwXZZ75-Kz_e6hDGHTAFg9Z8ANfdUQUqZtQ@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] BPF Static Keys Support
To:     lsf-pc@lists.linux-foundation.org, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It will be beneficial to support a zero-overhead (when disabled) mechanism
to trace/debug BPF programs. One possible way is to add the static keys [1]
support to BPF. This topic is to discuss the design and/or alternatives.

[1] https://docs.kernel.org/staging/static-keys.html
