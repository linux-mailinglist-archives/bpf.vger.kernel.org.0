Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9CEB457B49
	for <lists+bpf@lfdr.de>; Sat, 20 Nov 2021 05:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbhKTEu6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Nov 2021 23:50:58 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:41923 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhKTEu6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Nov 2021 23:50:58 -0500
Received: by mail-wm1-f42.google.com with SMTP id f7-20020a1c1f07000000b0032ee11917ceso9053434wmf.0;
        Fri, 19 Nov 2021 20:47:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=aEc6h6UZDj3RJe5zAVD0JZ752OLm/zol4/Bf6vq8of0=;
        b=b5mCfltW8LGdF8w25Iyvax/w4kKycegKpfM00zO+rWxE7w1jWLsZzuVIKW/zIKrZzo
         iMeV0qF4YoACt/BWKpRpEltpbbwMYztGEluprMXW/vVX7s1YB6BEEDzbqVWKqwYEqP1k
         I6YdNFc2o7o8qqiqeOMViH5hF/HaSEFQlFyY+qB41fzcSYudEqjg08Nt9nDvkBxNTf5P
         Sazwu36SW15evYB8bUL8ovkvTrtTSuMX1xV0GCR1V9MPOnJQCuPF2UAwyNUpzmsXRh89
         2Uel8zf0os0WXrDav2p4S48ja1uSiLn33QuAEn/SSfnHN1ubUxZ/qOECHSgyS12w/83R
         3pJw==
X-Gm-Message-State: AOAM5321YvsM3Rz9+4IE1efeBg8yYArQB6q4mN+TqMrHrjTIIHpBEQ/m
        OC0Tbda5A42JJqOAHZ5ZRTo=
X-Google-Smtp-Source: ABdhPJwP2k7ucavsfoGlZJcK5To078c9aGO6heH2BJxEfkGEB243/CpxoDU2gn26fg/Nug2rn0s9+Q==
X-Received: by 2002:a1c:4d0b:: with SMTP id o11mr6635748wmh.68.1637383673623;
        Fri, 19 Nov 2021 20:47:53 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id l16sm1722475wmq.46.2021.11.19.20.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 20:47:53 -0800 (PST)
Date:   Sat, 20 Nov 2021 05:47:50 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     bpf@vger.kernel.org, axboe@kernel.dk,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, yuq825@gmail.com, robdclark@gmail.com,
        sean@poorly.run, christian.koenig@amd.com, ray.huang@amd.com,
        sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, jingoohan1@gmail.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com,
        krzysztof.kozlowski@canonical.com, mani@kernel.org,
        pawell@cadence.com, peter.chen@kernel.org, rogerq@kernel.org,
        a-govindraju@ti.com, gregkh@linuxfoundation.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sj@kernel.org, akpm@linux-foundation.org,
        thomas.hellstrom@linux.intel.com, matthew.auld@intel.com,
        colin.king@intel.com, geert@linux-m68k.org,
        linux-block@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH bpf] treewide: add missing includes masked by cgroup ->
 bpf dependency
Message-ID: <YZh99tLi9sekmJ3T@rocinante>
References: <20211120035253.72074-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211120035253.72074-1-kuba@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Jakub,

[...]
>  drivers/pci/controller/dwc/pci-exynos.c               | 1 +
>  drivers/pci/controller/dwc/pcie-qcom-ep.c             | 1 +

Happy to give 

Acked-by: Krzysztof Wilczyński <kw@linux.com>

for the the PCI drivers.  Thank you!

	Krzysztof
