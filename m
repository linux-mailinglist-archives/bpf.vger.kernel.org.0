Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 992EB2C5970
	for <lists+bpf@lfdr.de>; Thu, 26 Nov 2020 17:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403868AbgKZQoM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Nov 2020 11:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730181AbgKZQoM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Nov 2020 11:44:12 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0255C0617A7
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2020 08:44:11 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id l1so2802036wrb.9
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2020 08:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=cd7iNQed0zlJwSeDfpiUl39uv1gJodD4NzCVOu8rCLs=;
        b=fAOYntqjNSrmZCwKFUIYdAFgeo+8pFj+pDznCxjxqeJdUzBJ/0eMOlnLYFOU8NqK3Y
         HlUHqRm9tqTPXXGghmEX5SORn5DSzu2nfA2JTibhv0xMElsW3qEU/uh8qLNiaeWmkxtZ
         Rb7pgkmYZj/F55O9vuMC6rivibeoTzHQwaVpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=cd7iNQed0zlJwSeDfpiUl39uv1gJodD4NzCVOu8rCLs=;
        b=eQjIjt3qzcdlVT35jOLtkLGQRwyp+USUbFIPpWN8RYqbUr5HM2Vg+x7/KR4CUFImIk
         Nr3yneqHSf9Ngx8O4yjA0WDW/r0WrRbhly5NkUQ+1G7Tl8xBdCeN4SwkShHbPkUE8iEU
         npGOexCGIYxpJ/6BX/ZxltyYEzj2gEu3McoUeX3Q/96WJ9WVXVPPdwtxzGGyW3C7yxUw
         iVC+YyDOpNkOLXL32Gee84lAM8XwZOBRXrKuRqAgM+EDCWeQk56PbUjqkA8G9Tn8Cijo
         ZIrUVSkivOYyGevikNUKxPSg/4sza7vTTSEq15nD2Eq2Y79lsbCbCTgqYBE7EBzihUXy
         8Ukg==
X-Gm-Message-State: AOAM532KbWWLgr3vX/Tgpx+kzMQUv3EwqV7CgqAblNRbhi0XfNcGg248
        YqQMQr8ilpkXpsEdlyFjJw3T0w==
X-Google-Smtp-Source: ABdhPJzCECSTqybxZwNMLU3z8wPPcNZPtnErYQbKZEh9rgbFgJqc+U0CS3Js0s4gt/MwduQ4oqGH3Q==
X-Received: by 2002:adf:f181:: with SMTP id h1mr4829890wro.267.1606409050689;
        Thu, 26 Nov 2020 08:44:10 -0800 (PST)
Received: from ?IPv6:2a04:ee41:4:1318:ea45:a00:4d43:48fc? ([2a04:ee41:4:1318:ea45:a00:4d43:48fc])
        by smtp.gmail.com with ESMTPSA id v7sm2871733wma.26.2020.11.26.08.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 08:44:10 -0800 (PST)
Message-ID: <7893b7adbe4a3e676b329cb0d88cf315217686b2.camel@chromium.org>
Subject: Re: [PATCH v2 5/5] bpf: Add an iterator selftest for
 bpf_sk_storage_get
From:   Florent Revest <revest@chromium.org>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, viro@zeniv.linux.org.uk, davem@davemloft.net,
        kuba@kernel.org, ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        andrii@kernel.org, kpsingh@chromium.org, revest@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date:   Thu, 26 Nov 2020 17:44:09 +0100
In-Reply-To: <20201120003217.pnqu66467punkjln@kafai-mbp.dhcp.thefacebook.com>
References: <20201119162654.2410685-1-revest@chromium.org>
         <20201119162654.2410685-5-revest@chromium.org>
         <20201120003217.pnqu66467punkjln@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2020-11-19 at 16:32 -0800, Martin KaFai Lau wrote:
> Does it affect all sk(s) in the system?  Can it be limited to
> the sk that the test is testing?

Oh I just realized I haven't answered you here yet! Thanks for the
reviews. :D I'm sending a v3 addressing your comments

