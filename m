Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2930D4A8247
	for <lists+bpf@lfdr.de>; Thu,  3 Feb 2022 11:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238589AbiBCKZc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Feb 2022 05:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiBCKZc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Feb 2022 05:25:32 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2AFC061714
        for <bpf@vger.kernel.org>; Thu,  3 Feb 2022 02:25:31 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id s18so4048590wrv.7
        for <bpf@vger.kernel.org>; Thu, 03 Feb 2022 02:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=c5fFSVcs/oBNAxu23X6OJxv8AR8T013Duq900LeDZDQ=;
        b=nnAbv41BBphhL2GDikdhSeI/d78Le9gZNkie9zabuTgap5TYHRkryrURkLxG2HUc3o
         7QOM15jlnLxxZSE0oYkJ04+aG7NmuYzGY+Kl524E83jh1PZFMxA/pdnayNZVvdFcw+iU
         GP8GA1cGVcOaesxxXkbuYlWUV41HcVdL7ndseJE71hg3Wj9we5L8C3fl2RBCjYQh4srV
         iGlEhefC3d6e1yTuC8UiMLjnKwVVk2HeqauZ4MMwvlQiqUP8bejy6//jrpOwEj74T9zy
         L0wgvnbfU9phEEPTSTNBYPcP2inTFALcZqELHPD7QGeeOeab7FeaKg82u2hGf9SbrXZc
         4yKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=c5fFSVcs/oBNAxu23X6OJxv8AR8T013Duq900LeDZDQ=;
        b=LKrsupZbHV4VElH5bu90iE6J400TXjV9yRvPVU42bGlLzrbsYYDHohU/tnhiGTK4F0
         31vfi6Wl0Sn+XnOVAbR8cSD6tXx3Snj6wtitpzpC9qxbr7CTbWv/yW3PhyDaMDO6tXHK
         DH3D3ElLRfPaTSB5j705rnAeKZV49TpXlQV4pmEiqlv+bq39gWSV/hVrA7/tHaS06hev
         1+FNKNLmZl41XdxRfAzbET+UxjOclWqi9KL0tdjNFXUmQF9lAAlqP3FB0fyz/otFzNMr
         WCo92w/FYb8U8Mk1QgvC6SQ74ISAQ+sb5PwidL9mRlO6WbTsv0t0pPn3m8kthSMsWGWM
         TDIA==
X-Gm-Message-State: AOAM532zsQf0rTPNloepeIzU76x+kQQHRkZV7HMFrWz4Bdc7Uyu6xP0v
        cKMeJtb6COJzFkFydmAGmHjoT0Q1PJa5og==
X-Google-Smtp-Source: ABdhPJybUvu2CXlKA5MRLaZuSfdJNvimFB/cmiFeocdbiz2W+9Ywwv3HH3WsnsTQERqhVyxesieqQw==
X-Received: by 2002:a05:6000:1081:: with SMTP id y1mr28883791wrw.660.1643883930549;
        Thu, 03 Feb 2022 02:25:30 -0800 (PST)
Received: from [192.168.1.8] ([149.86.71.48])
        by smtp.gmail.com with ESMTPSA id j13sm19632551wrw.116.2022.02.03.02.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 02:25:29 -0800 (PST)
Message-ID: <09bd1eda-ec6d-2c6f-4ef7-339e9da87f86@isovalent.com>
Date:   Thu, 3 Feb 2022 10:25:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH bpf-next 0/6] Clean up leftover uses of deprecated APIs
Content-Language: en-GB
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com
References: <20220202225916.3313522-1-andrii@kernel.org>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20220202225916.3313522-1-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-02-02 14:59 UTC-0800 ~ Andrii Nakryiko <andrii@kernel.org>
> Clean up remaining missed uses of deprecated libbpf APIs across samples/bpf,
> selftests/bpf, libbpf, and bpftool.
> 
> Also fix uninit variable warning in bpftool.

Looks all good.

Reviewed-by: Quentin Monnet <quentin@isovalent.com>
