Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2795B3CC6
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 18:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiIIQQI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 12:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiIIQQH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 12:16:07 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205BE11B03C
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 09:16:06 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id nc14so5169175ejc.4
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 09:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=uZEnJLfJdi18Rz7LSxAFoiY4e8KxCzA6CYNwp7Kb4bc=;
        b=K0t4Kaf0YJaYRxPG4NAXZtTN8avNSBHLgHN/LwqkD7lGWyOiz16O3zFIdtpSO54C40
         fnpKpNCgSqdoM4iivMVJ3OMevVUcLJXZQF70WBAWXoJXrywozNgJaRe3r0Oab6IM/QIZ
         eSUXNI5akzIAfGx8KkBHDOIkrKv9/qdma3qEScK3VGyAhodJGKBTnlPKLfTMiB9KA/+F
         BKriItuQ6aWvVYNyzUN/2+Q5HKlbRJ82c36dByEOm3U4q/XueiraovtMrf2x/C6fBlbg
         cW/55FDCwjKhD8Kq4GbjNYGldRacPBsh4Z+Md4HQxL4T7qqPL/TqWRxnh7NrJIytryHN
         PrgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=uZEnJLfJdi18Rz7LSxAFoiY4e8KxCzA6CYNwp7Kb4bc=;
        b=OECRNNrY+0DJkLaRIkq4uPkS0Vc4ufYJC/lG0A4GDG/rWgqtmz52823WS73kU0Xxc0
         am2JegCajU+3jycISua082g+R8g/iDrGJc2TESLnb+7loyp2Ddbmgiaxyr3PBzmwziNR
         5gRmW9BT78qkoiLgsFUscsZaJhyJIVVCxJnxm33wRE+sB3eCEwHLR9cXGk7VOYYgWr1m
         flUhIymwzJKpNTkr8PFy1CDKQnsWDU12K0kFc015oD+HiDHUjwY4WQR4DmfG9rhHDczF
         I4FNEMbLzx4ggXfzUXL7tgjUal8vmxBXHY5pj/NXUvkzouArZJMkQotLDOadkxMkqyZ1
         dSPQ==
X-Gm-Message-State: ACgBeo0g+QZpHHteXaColYiQVhLht1WZBbLc/gNK4YrHAfusYULXe19C
        nh4iuR4ZbkAY++vpUD1jlpk=
X-Google-Smtp-Source: AA6agR664SzUHtMGxto1XgTACKnWUP5rGoRV5kxrx6vuFvIoLVIXeFaCWyVvynBUuyvFyjyR5miexw==
X-Received: by 2002:a17:907:2c74:b0:741:657a:89de with SMTP id ib20-20020a1709072c7400b00741657a89demr10312615ejc.58.1662740164452;
        Fri, 09 Sep 2022 09:16:04 -0700 (PDT)
Received: from blondie ([141.226.162.95])
        by smtp.gmail.com with ESMTPSA id l3-20020a056402344300b0044604ad8b41sm620614edc.23.2022.09.09.09.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 09:16:04 -0700 (PDT)
Date:   Fri, 9 Sep 2022 19:16:02 +0300
From:   Shmulik Ladkani <shmulik.ladkani@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
        andrii@kernel.org, ast@kernel.org, Kernel-team@fb.com
Subject: Re: [PATCH bpf-next v1 2/8] bpf: Add bpf_dynptr_trim and
 bpf_dynptr_advance
Message-ID: <20220909191602.1c2be862@blondie>
In-Reply-To: <20220908000254.3079129-3-joannelkoong@gmail.com>
References: <20220908000254.3079129-1-joannelkoong@gmail.com>
        <20220908000254.3079129-3-joannelkoong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed,  7 Sep 2022 17:02:48 -0700 Joanne Koong <joannelkoong@gmail.com> wrote:

> Add two new helper functions: bpf_dynptr_trim and bpf_dynptr_advance.
> 
> bpf_dynptr_trim decreases the size of a dynptr by the specified
> number of bytes (offset remains the same). bpf_dynptr_advance advances
> the offset of the dynptr by the specified number of bytes (size
> decreases correspondingly).
> 
> One example where trimming / advancing the dynptr may useful is for
> hashing. If the dynptr points to a larger struct, it is possible to hash
> an individual field within the struct through dynptrs by using
> bpf_dynptr_advance+trim.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Reviewed-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
