Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E96455402
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 05:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhKRFBX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 00:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhKRFBX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Nov 2021 00:01:23 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC178C061570
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 20:58:23 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id j28so5227616ila.1
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 20:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=HpdcTSWBmRD3BaqaE28t2w2sxN2rJfW9odLU8OuaTrI=;
        b=JeZ8PLVhK4i/buU1x/IBSqtqLdEKNDunvwx/xbVKcDRRXdC6VIALitxl/jS9TL/YXf
         ytqXqbiIeRQ3BQkgld3VamGjFdz7H4tN5TTafsHzc+RvB4rFnu8LaT20XXV8l/C8sLeE
         xobMG0/w/ZYcvunHjSLjqtzRj9cE6D/389aeekkdOj2Br1NVts5cXM7M4y+cHH6YZana
         aYcHSt7b/LGVHkKU1WkKvoZIXv10D4svTbcKv5XG7ZOsuHYAsxu0uQaa09ljgM88BtpR
         PXtNQwE4OQsdwi2N5ahqOcZlluRVlE3c5VW8E11OGLD9Pk7OMsq38sMGgh1Rb5Wpu73c
         3o2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=HpdcTSWBmRD3BaqaE28t2w2sxN2rJfW9odLU8OuaTrI=;
        b=BGIx+69RFRqQRIJ+oCb8+h5AH3LEwLjbMjl6ZRCyMuntLl2tORykNovvn0aPCCX4jR
         SptVyKHabr+FrcgjK/89cRCkh7pzQs3R/6U/ktjuuB+edk+KKc+txUjzfWntMwoirYmK
         lHr5PSnSE6qHXcUZp49SKR+IVkArRhRRmfHYfBYBCBDS7j0lyx91jiJSeR1zbDxCg/iO
         hkapf+jAScjbtXhwsePXU1fTfiRHtqaf9FHtu/Ic06cEfw1BwvvSgAj4C5DC4pfiWDHN
         IjDbR2pOHq7WYC1Na1ox38jpl5nEqEINQG5LMEbvlbZO2kclP8HDYZanqxHtzJArZNro
         VUng==
X-Gm-Message-State: AOAM532hsSSNFXWuzLwoircfNlq0bTNlq1LPlJAuuopurudUjJaFV8Ns
        bee3Rt6Tk/iqy3R6hKXCkCU=
X-Google-Smtp-Source: ABdhPJxWceil6VXVCleQBWzt9x/2YTAfjoPnMF68A2ejt+XqMf30xAcCP8kcybOngBEqJ9Y4atdLgQ==
X-Received: by 2002:a92:c248:: with SMTP id k8mr14027601ilo.192.1637211503356;
        Wed, 17 Nov 2021 20:58:23 -0800 (PST)
Received: from localhost ([172.243.151.11])
        by smtp.gmail.com with ESMTPSA id b25sm1121287iob.27.2021.11.17.20.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 20:58:22 -0800 (PST)
Date:   Wed, 17 Nov 2021 20:58:14 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     andrii@kernel.org, kernel-team@fb.com
Message-ID: <6195dd6671071_2b4cc208ab@john.notmuch>
In-Reply-To: <20211118012018.2124797-1-andrii@kernel.org>
References: <20211118012018.2124797-1-andrii@kernel.org>
Subject: RE: [PATCH bpf-next] libbpf: add runtime APIs to query libbpf version
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko wrote:
> Libbpf provided LIBBPF_MAJOR_VERSION and LIBBPF_MINOR_VERSION macros to
> check libbpf version at compilation time. This doesn't cover all the
> needs, though, because version of libbpf that application is compiled
> against doesn't necessarily match the version of libbpf at runtime,
> especially if libbpf is used as a shared library.
> 
> Add libbpf_major_version() and libbpf_minor_version() returning major
> and minor versions, respectively, as integers. Also add a convenience
> libbpf_version_string() for various tooling using libbpf to print out
> libbpf version in a human-readable form. Currently it will return
> "v0.6", but in the future it can contains some extra information, so the
> format itself is not part of a stable API and shouldn't be relied upon.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

LGTM.

Acked-by: John Fastabend <john.fastabend@gmail.com>
