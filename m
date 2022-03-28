Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1BA4E9792
	for <lists+bpf@lfdr.de>; Mon, 28 Mar 2022 15:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242842AbiC1NJr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Mar 2022 09:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243019AbiC1NIL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Mar 2022 09:08:11 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5166633A33
        for <bpf@vger.kernel.org>; Mon, 28 Mar 2022 06:06:20 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z92so16809039ede.13
        for <bpf@vger.kernel.org>; Mon, 28 Mar 2022 06:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Y3lKHwg6Rmog8XGwJu/58P2Exvr4QzrjkX3wt9eMtW0=;
        b=KzzYV6d7pJV3i0I0x9jQXkziMteCyDfVHqa+b4uF9vCr4qJ1LiBXKTjpvBbf45XP8T
         gmshIsVZxsNn43eZVdK2hxetV+VDK4BFUXoq8dC/07NrKPrENzzZTCIvtl7W+6FW4B9S
         uuRISjV0fjvsRvZlqRNo+sgdWrMYTJSHyMmqCmX+CYZTMmLQh6Eh4WxbQNYJNVRiztRN
         7Hml33Rf38wdnTJeG4ows9IOOUhKoXRl3o66uAkAsKLE3RsdkToCM6WiwFr6Yd5gWX5C
         /rOrwP9FdprtJX4pPH1Wc7qGZRwBgUheXVETp/80UT4072DTZ6mPN+QFzZn+WTfn+Cdu
         TQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Y3lKHwg6Rmog8XGwJu/58P2Exvr4QzrjkX3wt9eMtW0=;
        b=RGRnMsGoAKWjmgYz8HZwxX8/lb1Yi8cjPyuslSja6DOFwMEpu+br21Y3VW/Z6tNUWA
         PTDzjaUvrvvvbYfRQCqVAYbhGfyud3Obvdr3WXujfmlyebnHnnTC7SIviGOyT4X294CT
         tSJSNmRvZ8kBpCXxh6lkDyvrk2vOiKvUtVV6fYoXlIPxsmbEcrPQS8FVFMpofzuB0y6i
         qDgZ49Tgk6nzqiX8QKQzOijqLg9sbySGvJicYY1EvnI8jRVwMauMzAvPlKigsa0hIESj
         aUYg/7jfO+Jal93Wc3P8Jc1XfUpBuUWDJJx3eS+2EmSX6pkHkuBQPajw2oPj5zAl91c/
         /8qQ==
X-Gm-Message-State: AOAM5334UAihCqnSYvpUWK3qBjwB3EHUcEs/X7An1aWPv1wmEeUPJM4t
        Uk9bRuKRgaYZxl2EXde3638=
X-Google-Smtp-Source: ABdhPJxuybCyH/0nxr5oZuSEQuoFsXi4LnwNVH56mNiIiSvhJ09H0O3m4rDHD2TEoWoPX++T1XXeow==
X-Received: by 2002:a05:6402:1d4d:b0:419:430b:5734 with SMTP id dz13-20020a0564021d4d00b00419430b5734mr16073817edb.212.1648472778798;
        Mon, 28 Mar 2022 06:06:18 -0700 (PDT)
Received: from ddolgov.remote.csb (dslb-094-222-030-091.094.222.pools.vodafone-ip.de. [94.222.30.91])
        by smtp.gmail.com with ESMTPSA id i12-20020aa7c9cc000000b004197a2d4ae7sm6956633edt.50.2022.03.28.06.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 06:06:18 -0700 (PDT)
Date:   Mon, 28 Mar 2022 15:06:16 +0200
From:   Dmitry Dolgov <9erthalion6@gmail.com>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, yhs@fb.com
Subject: Re: [PATCH bpf-next v6] bpftool: Add bpf_cookie to link output
Message-ID: <20220328130616.5p5qy7eqsdiere6r@ddolgov.remote.csb>
References: <20220309163112.24141-1-9erthalion6@gmail.com>
 <a9a2c8ba-ff17-eafe-5cf4-32e5ef19b656@isovalent.com>
 <20220326090834.f7ukfgjyfhk6sbws@erthalion.local>
 <6b558a11-7f5e-8a4e-b70b-e4c7d3c3e052@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b558a11-7f5e-8a4e-b70b-e4c7d3c3e052@isovalent.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> On Sun, Mar 27, 2022 at 11:03:49PM +0100, Quentin Monnet wrote:
>
> Correct, it's not implemented yet for multi-attach links. My concern
> here is to avoid changing the JSON structure in the future (to avoid
> breaking changes for tools that would process the JSON). If we know
> we're likely to have several cookies in the future, it may be worth
> using an array “from start” (since no version has been tagged yet after
> you added support for the cookie).

Yep, sounds convincing enough to me, will prepare the chance shortly.
