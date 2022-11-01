Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D87615630
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 00:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiKAXkK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 19:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiKAXkI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 19:40:08 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C6A1C910
        for <bpf@vger.kernel.org>; Tue,  1 Nov 2022 16:40:07 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id u6so14992515plq.12
        for <bpf@vger.kernel.org>; Tue, 01 Nov 2022 16:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HMjoSMseYo9dv+OYtpDQcotuckgj0OnEhXYZObymQfA=;
        b=N4bCntNKJyNrCrWRnxFbKWGV538e38A/akJR4zZz/OuvuV1Bx92CKGBWkW4XIkb+mg
         at2PxLtvS+9V8fzxowpA0pMEHI/pFRmIUoF3dIlw96H4BwhgK79jOTHaNSb4ib3bQqJE
         AjvoxglA+JnoO3xYI+DkujScXt/j12hqgfLIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HMjoSMseYo9dv+OYtpDQcotuckgj0OnEhXYZObymQfA=;
        b=WR0ofyU+KCctnmK83OOkIUux81hs6WGOF5j6RFBZnouXZyo5RrO2KHtej+ka9HnF4J
         EkL/WlLzZ0qHOPKhHyhRqP7lpaTFo6vggSPPVInuAG7NBMphV6GIPT77QBpyKBO19FUD
         NiB1UZx44nGBkxgpBzCH9yJDNV7l160PRQMFB6dJVIGssMX79ldXTU16sDOFq1Z5hBAl
         OjxVhovsLkDqF6zOGzUFjfXYBdlgPcei/ui89CoXbGEA5Kj/PPamEfXspf29Lf+zhfgD
         P0aqvvP6dCEnmlOgzmuy9feR7SEyTEf3avqIqiAgQ0p8P20cvfwroPvk9k6DGjlIEYRv
         Yj6w==
X-Gm-Message-State: ACrzQf0cTbgnrshfpECB7iKgE9cc2UHC4No/+UEprDJYHX8U6xT8uwsD
        jsqZmRZoGOnpkV1O8jnISoucLg==
X-Google-Smtp-Source: AMsMyM4P4eIG6ZNPzEizuQdoi/YqYr8KPBMw3NArEJ1RJ/GARU4RtwCb2NPtiryMlgBp+ThPDf6xZw==
X-Received: by 2002:a17:90b:33c3:b0:213:f5be:c3ad with SMTP id lk3-20020a17090b33c300b00213f5bec3admr9845989pjb.123.1667346007336;
        Tue, 01 Nov 2022 16:40:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 20-20020a621714000000b0056ded8d5918sm636830pfx.134.2022.11.01.16.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 16:40:06 -0700 (PDT)
Date:   Tue, 1 Nov 2022 16:40:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexdeucher@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Christian Brauner <brauner@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-hwmon@vger.kernel.org, linux-hardening@vger.kernel.org,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] drm/radeon: Replace kmap() with kmap_local_page()
Message-ID: <202211011639.4938CC9@keescook>
References: <20221013210714.16320-1-fmdefrancesco@gmail.com>
 <fb0b7389-7121-04f8-176d-1ababe0ad8f2@amd.com>
 <CADnq5_PP3VCXQ5rbC0-8Qsi5W7Ew87U_bRknz4=qxbrPxVQ+qA@mail.gmail.com>
 <1942083.usQuhbGJ8B@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1942083.usQuhbGJ8B@suse>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 02, 2022 at 12:11:53AM +0100, Fabio M. De Francesco wrote:
> On lunedì 17 ottobre 2022 18:52:10 CET Alex Deucher wrote:
> > Applied.  Thanks!
> 
> Many thanks to you!
> 
> However, about a week ago, I received a report saying that this patch is "Not 
> Applicable". 
> 
> That email was also referring to another patch, for which I'll reply in its 
> own thread.
> 
> That report has a link to https://patchwork.linuxtv.org/project/linux-media/
> patch/20221013210714.16320-1-fmdefrancesco@gmail.com/
> 
> Can you please let me understand why, despite it was applied, this patch later 
> shifted "State" to "Not Applicable"?

The kernel has multiple patchwork instances, so you got an "N/A" from
linux-media, but it was applied to the drm tree. (Yes, confusing. :P)

-- 
Kees Cook
