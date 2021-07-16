Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEAB3CB0FD
	for <lists+bpf@lfdr.de>; Fri, 16 Jul 2021 05:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbhGPDOs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Jul 2021 23:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbhGPDOr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Jul 2021 23:14:47 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4D8C06175F
        for <bpf@vger.kernel.org>; Thu, 15 Jul 2021 20:11:52 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id w22so839184ioc.6
        for <bpf@vger.kernel.org>; Thu, 15 Jul 2021 20:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=moXkIBs05dAYBJS0WJjXIVHYjdj5yZThjm81sXEWXB4=;
        b=tJMwv3DUfypFSHygrfNfWjzagWtGEIXbPxAVYd568quhpccay9jxLIS2B2b/K/Xc13
         jX1dyZ2vEJYcLjFJay+mcCYXLVNLXNgksmdOCMkLBKX9BWxaYMZwuSau8O8ZMlJOSC5Z
         AtgzfboRohVI8yXdzNYTdrBGaf94PPe2CUpWi799lIcR2wfgq6AU4pRkEbKSGeF8dph7
         I+WFRCEL5dJ5TQzlRmknBpxpf23uSCimqv9oNa1HrSZtM1vgcoNziJWcRhNjpSiZQ76v
         8BvR759fjoG7mfh1jcKEGqPCrjkbHo7FDUihE/ex/V7ILiET1IXtyGXrq40Ttav7mHfL
         jFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=moXkIBs05dAYBJS0WJjXIVHYjdj5yZThjm81sXEWXB4=;
        b=h8u0TR/4tjJihYvxPlPUi2hOQRKG5/GAUYhPFVNB7fvXXXSMgYu3R6CxS8njKUmLiI
         +XTTprmLdbfPuVDKxa7RO9fBPPy7yCQ5j7e3tLB0gO41O5t7+ZYE8XSRntyVt0flbOZ+
         nGTKJEfwBDd8xJUNsnySJ1ny4fUkCX48x5pnOv3nDtFLyCeBNMZDO6Ns/HpVlgmyyhYX
         Fh6AbmVXqcrGGeqpYNDkaXyYUWlQIAMFsFiFb7sfkqiagOj5g+EncJSXRBkLXn/DQu07
         +BitndzTK+ih5/onmPts1ZdpgxCqVEbJkYFStnuEnBfPX6I75UGtfQprsHcjJytj8b0C
         ErnQ==
X-Gm-Message-State: AOAM532DoTEEozoNOs+jAdk4PrMHkwNWDQtByXCa8rn3fCeLG4KXJNgU
        N3KLmRgjql73KKtzZWhaJLsP6BzDu+HsAA==
X-Google-Smtp-Source: ABdhPJx1ybmY3PF2//S8IwzbpXEPPefqLULnITN3OtYc1lnXO+33U7Vmg8TATqec6qzazhyH1u81rg==
X-Received: by 2002:a05:6602:10e:: with SMTP id s14mr5845224iot.52.1626405112169;
        Thu, 15 Jul 2021 20:11:52 -0700 (PDT)
Received: from localhost ([172.243.157.240])
        by smtp.gmail.com with ESMTPSA id p10sm3859811ilh.57.2021.07.15.20.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 20:11:51 -0700 (PDT)
Date:   Thu, 15 Jul 2021 20:11:45 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Martynas Pumputis <m@lambda.lt>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        m@lambda.lt
Message-ID: <60f0f8f125eef_2a5720899@john-XPS-13-9370.notmuch>
In-Reply-To: <20210714165440.472566-3-m@lambda.lt>
References: <20210714165440.472566-1-m@lambda.lt>
 <20210714165440.472566-3-m@lambda.lt>
Subject: RE: [PATCH bpf 2/2] selftests/bpf: check inner map deletion
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Martynas Pumputis wrote:
> Add a test case to check whether an unsuccessful creation of an outer
> map of a BTF-defined map-in-map destroys the inner map.
> 
> As bpf_object__create_map() is a static function, we cannot just call it
> from the test case and then check whether a map accessible via
> map->inner_map_fd has been removed. Instead, we iterate over all maps
> and check whether the map "$MAP_NAME.inner" does not exist.
> 
> Signed-off-by: Martynas Pumputis <m@lambda.lt>
> ---

Acked-by: John Fastabend <john.fastabend@gmail.com>
