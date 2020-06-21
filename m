Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEDC20282A
	for <lists+bpf@lfdr.de>; Sun, 21 Jun 2020 05:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbgFUD2k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 20 Jun 2020 23:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbgFUD2k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 20 Jun 2020 23:28:40 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C969C061794
        for <bpf@vger.kernel.org>; Sat, 20 Jun 2020 20:28:40 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id h3so12935558ilh.13
        for <bpf@vger.kernel.org>; Sat, 20 Jun 2020 20:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=qfZRQKahaMP1iQC1He5obiQMqMI1Ngq2/JVfI4CFjY8=;
        b=NnYMkwDyN26WVIt3/9V2HD04ewpzYOLSkCtCQu411YDbPAsf/wyzfmF9mSMrCoUMTa
         cBA1/bJ9bdj6bqUNd8EbX4P7PymvXJxNGnUP41eKRY0cbI3asIlsUZxGoYvjOXDbleGn
         Z62F/UdkXZOOZb0/v8QYwOj+8w9pnri3gouBBGu6+PRdXJCuRatW0r/FrqcNp2td2iCD
         7YLx29gl0MNMkD6VRVz5+DKtPoVqPaat+XBBVlCt1bP5oMd0PxCAbGBZUiWHwLE8CNaB
         Ej9Q/bDc56KdB/z1GuMAOfhefwbYf5x2C+hmExRGyJTL+Lcb3E3R9qm04ssM1vh5z3fu
         vPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=qfZRQKahaMP1iQC1He5obiQMqMI1Ngq2/JVfI4CFjY8=;
        b=QFHngodFxTHmzJNr92/ncj4HAuKx7ONGz0HNqUOspZ8idkJjHWTXixXVn44WaHYE3D
         sAuDjyDqdBIlC2I+3dM60ZQMm3MukMz1+XN8vSF0+CSBA44hNBpbLh32nCuEC0hcnAFl
         HQ8BoGaa17brSnofW6j/giDBVKCQnMjLaP+u+4Tv1Yx/IqAQcCHjhOld+Jf2zBC+Trhm
         wPv9CaCF1OqXq2rLWB2uD/euSNDBnnPLtg6RexDz4GdjbmN/ZkDo4PQTAOmKk1ef8xAR
         iUSsNAKK+es/aSc1VuQemrZUd0WQpxv0StlX4B7KZL78hSMedYkeb27df8DTbAAjEzvK
         Ac1w==
X-Gm-Message-State: AOAM530Q2hebDyJCX7oqsxSxGuPXHBmGSYdQsNHxVULP0fRFHh58bXCt
        qbpi/4wrfXMKK4PHP2pLGhA=
X-Google-Smtp-Source: ABdhPJwnMN6u3CIdMD41/XeG7SY3OZsDgKCL8WnKhEGVgDjaZTfo+ir6E0OUJTx25w+5AsBZ9YTB1A==
X-Received: by 2002:a05:6e02:eee:: with SMTP id j14mr11099741ilk.261.1592710119869;
        Sat, 20 Jun 2020 20:28:39 -0700 (PDT)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id w16sm5580669iom.27.2020.06.20.20.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 20:28:39 -0700 (PDT)
Date:   Sat, 20 Jun 2020 20:28:30 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Andrey Ignatov <rdna@fb.com>, bpf@vger.kernel.org
Cc:     Andrey Ignatov <rdna@fb.com>, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, andriin@fb.com, kernel-team@fb.com
Message-ID: <5eeed3dedaa37_38742acbd4fa45b862@john-XPS-13-9370.notmuch>
In-Reply-To: <a825f808f22af52b018dbe82f1c7d29dab5fc978.1592600985.git.rdna@fb.com>
References: <cover.1592600985.git.rdna@fb.com>
 <a825f808f22af52b018dbe82f1c7d29dab5fc978.1592600985.git.rdna@fb.com>
Subject: RE: [PATCH v2 bpf-next 4/5] bpf: Set map_btf_{name,id} for all map
 types
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrey Ignatov wrote:
> Set map_btf_name and map_btf_id for all map types so that map fields can
> be accessed by bpf programs.
> 
> Signed-off-by: Andrey Ignatov <rdna@fb.com>
> ---

Acked-by: John Fastabend <john.fastabend@gmail.com>
