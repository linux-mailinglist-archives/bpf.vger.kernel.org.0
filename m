Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1F7615604
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 00:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiKAXVH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 19:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiKAXVG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 19:21:06 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A9817E39;
        Tue,  1 Nov 2022 16:21:01 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id bg9-20020a05600c3c8900b003bf249616b0so247535wmb.3;
        Tue, 01 Nov 2022 16:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxyxXUAbWcBHc9d21EGasKXnhPYfVJvAuFGJWn1enDs=;
        b=W4VJj2OxkzduLyb1JVdbRtO0v8jmkBqRu5rWTymTBs2xiND8ig1Kf6Dk6XCJ/2f9ep
         cQJzoRGlY6/DWX+5JYKcdKIHfr0JS0MdaBQyIDUhRd+FOJaZxF3pHcf2xbHChhlW4rty
         ILkUYe3cws4PsfmVl+bjjyCH5pdUl/TjK0Gb9vr9EHjpFN12YTCZePl8gviTuDyZCDK8
         0bez6hGXn81BQtpLrWRp/HB6XLFdulYs7Cg5evyxfNLJKpKuGR4tQyfTfrvvLO+6Uevh
         tYBaubwq+L0LF2LYlxCace4VZ7EeIJQm7yZYpxUbOkPwwXmHvp+E7J4lRV4blnxjtOVV
         JqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxyxXUAbWcBHc9d21EGasKXnhPYfVJvAuFGJWn1enDs=;
        b=WyJKLVRoyV9N9cf7pUk6rDRJ1x2mWnJMb9a+cln3bMvmVdMrfxOq3IkfSBFDDCWbAR
         axVbGykYJmtzsb7cHSgmNT3jnKPry6nxT/nFB50aPos9bJdMSILm/LsLLBzk4hN7DMV2
         tORYcxN/gqdVZ8yzCYsuFop2NJs5113NTROENdRAJlcdmZ+sL5o6XtfhOslY479sp5wf
         SkqKhEO9/ktTmnAeimyxajtI2++PdZLOCZ23Cx0666tWtCSPtFqWbhyiEgU6zZ9eeJK8
         FRwgEYm9ptx2W935NGbMK/hF5N8hM96b/9sRpuOwmILxacQAySz0oys23F27nhWt6m/L
         TSuA==
X-Gm-Message-State: ACrzQf0nHjgE+9gcfDo3T75wjXQZAirLE3WTFKeMdRL0LM0guHlVsve/
        MwdtuqWUHdE+XToGOU/Pkic=
X-Google-Smtp-Source: AMsMyM50e+QYw8SxGLXTQQSN/H4evMDT0wK2OPuH/ZtE+ylXd4szu1ziml/ktY5vD0j1TqS9pHNVkw==
X-Received: by 2002:a05:600c:1c0d:b0:3cf:5fd2:1fd1 with SMTP id j13-20020a05600c1c0d00b003cf5fd21fd1mr15921329wms.8.1667344860058;
        Tue, 01 Nov 2022 16:21:00 -0700 (PDT)
Received: from suse.localnet (host-79-43-11-206.retail.telecomitalia.it. [79.43.11.206])
        by smtp.gmail.com with ESMTPSA id dn12-20020a05600c654c00b003cf537ec2efsm123480wmb.36.2022.11.01.16.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 16:20:58 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Christian Brauner <brauner@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-hwmon@vger.kernel.org, linux-hardening@vger.kernel.org,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] drm/radeon: Replace kmap() with kmap_local_page()
Date:   Wed, 02 Nov 2022 00:11:53 +0100
Message-ID: <1942083.usQuhbGJ8B@suse>
In-Reply-To: <CADnq5_PP3VCXQ5rbC0-8Qsi5W7Ew87U_bRknz4=qxbrPxVQ+qA@mail.gmail.com>
References: <20221013210714.16320-1-fmdefrancesco@gmail.com> <fb0b7389-7121-04f8-176d-1ababe0ad8f2@amd.com> <CADnq5_PP3VCXQ5rbC0-8Qsi5W7Ew87U_bRknz4=qxbrPxVQ+qA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On luned=EC 17 ottobre 2022 18:52:10 CET Alex Deucher wrote:
> Applied.  Thanks!

Many thanks to you!

However, about a week ago, I received a report saying that this patch is "N=
ot=20
Applicable".=20

That email was also referring to another patch, for which I'll reply in its=
=20
own thread.

That report has a link to https://patchwork.linuxtv.org/project/linux-media/
patch/20221013210714.16320-1-fmdefrancesco@gmail.com/

Can you please let me understand why, despite it was applied, this patch la=
ter=20
shifted "State" to "Not Applicable"?

Thanks,

=46abio



