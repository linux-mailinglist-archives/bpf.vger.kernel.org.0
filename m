Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02FE03CB0F7
	for <lists+bpf@lfdr.de>; Fri, 16 Jul 2021 05:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhGPDMp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Jul 2021 23:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbhGPDMo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Jul 2021 23:12:44 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC49C06175F
        for <bpf@vger.kernel.org>; Thu, 15 Jul 2021 20:09:49 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id j5so6981085ilk.3
        for <bpf@vger.kernel.org>; Thu, 15 Jul 2021 20:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=89Yy9Yfqsl9fXcFhG5acEYeez4Tu6o4nOz9lXOt+q3w=;
        b=nkO0vrJOKiAbHX+4Oiipjx75BPJCkJTSiRJlfMGZ4zoSlmVDwGWATB7rULC/nBJAUl
         A3Cs3U1icWouH8NI/F2XVviI9BJ5UXMMG8HVxS1Y6+SaaMGFM7zeKC7UBFbE1BpwgJMk
         TdhyZln7X1GW4CtAxcRfMaKlnMLvSs5F8ZHC3x+E/5qDrnz0RRoRJ00biNlFki0w4tH/
         yWXrr7n1dUg4XCqdMuuAErmENJfdUJ2WTnJXjPgX8toKMcbBS6bsnEMmLKiTUwpvG8b1
         59E9GYgZZ+n3M27mxY7wXBXIWmXj6bZ8VsA7221i9LeESZLE7/jwJvEKSR6kdg3rB7ct
         D2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=89Yy9Yfqsl9fXcFhG5acEYeez4Tu6o4nOz9lXOt+q3w=;
        b=cAdImdZZ1zdbtZR4zwwSMUogaFH9JEzrjcbA84byON8jWhmoBDx/a61nqjaKwGXZp6
         OWPG5L1CYq/ERTTaoDGhRXhS0lVmncOt3V4DNAj8R6ETSyEdsEkCF5wT/hq6Do3t/KRJ
         VvpMJuqQ8JwZYZVWk0GJrpUi8fUCTuEt+9PVYN+ffN+L2c7Z1Pp4nujVvWohLUhcL2TN
         TvcYMrFPOwxJSu8I5cRcc3mKDFgDExSkrv8f3v6065oWT38H02daRKLiAoKHRyXUFUwe
         HRenOK+mFNNstCc4cqmFX4VkfcArgNki17QyRs0PLRHVvX14a+36kT4jXP98OmvXz+MB
         IU4A==
X-Gm-Message-State: AOAM5322YNzcLrtesfayrML2B3FFuh0QIYpnDLj5B4WQWkEZEMY7YBo7
        ZyZ3ka16FeLe7sc9UBwpKAQ=
X-Google-Smtp-Source: ABdhPJzhBHy2zdNPY0Vyjzua5bGOtqy2IONBoE/YnxLHUfWmf8OR97otboQtAgXpF32U8cogXZcfig==
X-Received: by 2002:a92:c7a6:: with SMTP id f6mr4892124ilk.20.1626404989324;
        Thu, 15 Jul 2021 20:09:49 -0700 (PDT)
Received: from localhost ([172.243.157.240])
        by smtp.gmail.com with ESMTPSA id r14sm3948578ilm.77.2021.07.15.20.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 20:09:48 -0700 (PDT)
Date:   Thu, 15 Jul 2021 20:09:42 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Martynas Pumputis <m@lambda.lt>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        m@lambda.lt
Message-ID: <60f0f8764bb9c_2a5720890@john-XPS-13-9370.notmuch>
In-Reply-To: <20210714165440.472566-2-m@lambda.lt>
References: <20210714165440.472566-1-m@lambda.lt>
 <20210714165440.472566-2-m@lambda.lt>
Subject: RE: [PATCH bpf 1/2] libbpf: fix removal of inner map in
 bpf_object__create_map
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Martynas Pumputis wrote:
> If creating an outer map of a BTF-defined map-in-map fails (via
> bpf_object__create_map()), then the previously created its inner map
> won't be destroyed.
> 
> Fix this by ensuring that the destroy routines are not bypassed in the
> case of a failure.
> 
> Fixes: 646f02ffdd49c ("libbpf: Add BTF-defined map-in-map support")
> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Martynas Pumputis <m@lambda.lt>
> ---

LGTM.

Acked-by: John Fastabend <john.fastabend@gmail.com>
