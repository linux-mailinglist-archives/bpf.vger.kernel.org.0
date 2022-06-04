Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B420553D6E0
	for <lists+bpf@lfdr.de>; Sat,  4 Jun 2022 14:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236197AbiFDMxR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Jun 2022 08:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236162AbiFDMxQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 4 Jun 2022 08:53:16 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472CB7644
        for <bpf@vger.kernel.org>; Sat,  4 Jun 2022 05:53:15 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id v25so13289305eda.6
        for <bpf@vger.kernel.org>; Sat, 04 Jun 2022 05:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=PTGvKif3n/8vYuz9EBArfoBvEKhnTiAngqaxZzsiWTU=;
        b=jeee+3NRhKoLUSF/sdSzYD5VHOLnDJetqaO66HoPxo2vfVmIVvJOItVtVSg2fHgEmp
         dp+cGCf+oHWZWVZdxSIJ1WMWGeasTWt3CUCAKanaxFlPdOZyinHJwsFxCemoRwS/uf60
         GQmHOkOm5EviCsF5kNNCtLH0BuMChh9iqL7C9260JqgQpajOLw80kDLTVRr5fFdrs1qX
         2ctzdle792VtbyQlyje+FZP2c5TeuF24pOabwUC/1Dtwhp0jhEd3UnU1PsWYNss/cNAW
         USVmRjks8Hwi3M+MooBdjX/3438vsCkOEEZn7iRclSamjEscTyJzV0XtzUpvMpO9rpuf
         0lwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=PTGvKif3n/8vYuz9EBArfoBvEKhnTiAngqaxZzsiWTU=;
        b=IduqVOABu+SXq6hgUzQuMrAyq+3sldEBoM46C19o7PERPfPW7uDZeNxVR0RVLwJGiA
         XGvZvEbSNWZ+IM9YaisfONO3Fe8cDRiv1iahoeZG1NToukJx2+Gd2dVfMaWvgGVKFBcu
         l38BSRAw4s16OQgYwgA95ZrAVYpNk9piuSaGNtsCYI+1ajy9rb7pOxcIz34UKdTFkDjA
         9GZZd78dybtAdIybxrKr2IcAscDgOnP7g84QVLxps07ydvs+mXBuPhQOGruyAzNm0k2Q
         w34EAt2UW9Fd0oBq9Y0yrRjp4JXTuE5WP8RgQWW5DhxRhB/w6urncfTG9cXb3bBJ/mT+
         zGYg==
X-Gm-Message-State: AOAM53022bNbx42gCNY6f0878x3OfZ4c3uACPz7kODC4WjThyZ69gtgr
        k5+0m/CVDgWb01xpHdk5nDY2lX/7E1gG5w==
X-Google-Smtp-Source: ABdhPJxiPS42tBwO9FVqQhHlEAxml/GzCNPbMI/pMXSj4R6uXz+HJ8sx+KI0umOvz2fpFdLoxOi8GQ==
X-Received: by 2002:aa7:cacb:0:b0:428:b435:dc43 with SMTP id l11-20020aa7cacb000000b00428b435dc43mr15757125edt.123.1654347193903;
        Sat, 04 Jun 2022 05:53:13 -0700 (PDT)
Received: from pluto (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id w24-20020a17090633d800b006febc1e9fc8sm3935315eja.47.2022.06.04.05.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 05:53:13 -0700 (PDT)
Message-ID: <4a9a04727e708475105aff2f8b10b7eb5f14b654.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/5] selftests/bpf: specify expected
 instructions in test_verifier tests
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Song Liu <song@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Date:   Sat, 04 Jun 2022 15:53:12 +0300
In-Reply-To: <CAPhsuW6CgZQn_-uc1i7WVXcv2kGczEPEQRHGWAM5+S6dQyp9qQ@mail.gmail.com>
References: <20220603141047.2163170-1-eddyz87@gmail.com>
         <20220603141047.2163170-2-eddyz87@gmail.com>
         <CAPhsuW5WrL-4qZz-NPufj7SWbWe+z4rVzc0cN3ufU2M_PnTwoQ@mail.gmail.com>
         <cd7821030cd2fca945592a935c2c0853dd2852a4.camel@gmail.com>
         <CAPhsuW6CgZQn_-uc1i7WVXcv2kGczEPEQRHGWAM5+S6dQyp9qQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Song,

> Right. There are a few more in later patches.

Understood, thanks for the review, I'll apply the suggested fixes.

Thanks,
Eduard

