Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2F62CDAE2
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 17:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731212AbgLCQLH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 11:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbgLCQLH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 11:11:07 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701FFC061A52
        for <bpf@vger.kernel.org>; Thu,  3 Dec 2020 08:10:26 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id g14so2398036wrm.13
        for <bpf@vger.kernel.org>; Thu, 03 Dec 2020 08:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4Ys3ZXevU8FZT2N8gxyqI3Tx9K/RTVhiVdtXVNw9PEo=;
        b=sdvE0+/yC/5v9KY9Rei+N0j7UpMD/vEsf7V+d1TNvhr5ndMlJO+pHfg5EzyHrZsPc5
         19mpSEmPKg5b7+nAibVksz7vmBNQlqy3ioadUgGdvSc00/eO4Uy+JluxKbglP8EWEESR
         dYttiMjD3cuEpRGP9hsN643yV/coqgo4vrUBBpAtHs0XoKH+nu355NVJwa8y3HkELqHU
         etSLK6SqiOL2+Edal0HK/abtbZ9kub8g/GSNhpyrXsF0uAojSnVliJN7pBvKP7QxcsxU
         KhpOxxJj8VAq2cDgMnOOMPME6o/FC6G0mVD+oY7p01K5V0Tf62VW+RXvryvENg43Xo2z
         Bspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4Ys3ZXevU8FZT2N8gxyqI3Tx9K/RTVhiVdtXVNw9PEo=;
        b=TfrWoQmR/pevcLGgxgbyscASkZBWc1BYzVKh1HxWE3YCcmsje8m7ro9NH8FyfszKl6
         TjCddeP5ZI/mF8aMcLMKcJvs1FeZPWhwffQt5WhrBEk3xa/OkK25vQ79EoT0vIhlMT37
         8p0rxgaZWmWofu6qS9+5Kth2c+MruydybREqa7z2Npt4XdNULyr7YdYCA/3FpQhjbAUX
         XvgCriOW4OqfmzaOuQis2xcquiU1544fZ9fMoVzeoLBnvyWpv7r0D1bauyGtTAw8mFK3
         yhzgip6iyQYzQwKa4Dw4Mt+t+bcYQ5dAnZWo43XeAIdKiT/d9Hyf6W4O38Dr2xeSGExU
         5W6A==
X-Gm-Message-State: AOAM531RUEpQezQYAP9B8nmGadYGJMi073gTF6wJuF33zSnKrBQMo8IM
        SzmWTLUgMbWrD9/4Bq5sHoVENOWTCcy5QQ==
X-Google-Smtp-Source: ABdhPJy99W3XtGDuvMMePWAVHNIdwn0O5cc55gtc4N0/Ln27hNzknMKSms6eQy2k9FsvKOsHqHGBWQ==
X-Received: by 2002:a5d:4004:: with SMTP id n4mr4559276wrp.230.1607011824754;
        Thu, 03 Dec 2020 08:10:24 -0800 (PST)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id w10sm2381396wra.34.2020.12.03.08.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 08:10:23 -0800 (PST)
Date:   Thu, 3 Dec 2020 16:10:20 +0000
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH bpf-next v3 00/14] Atomics for eBPF
Message-ID: <X8kN7NA7bJC7aLQI@google.com>
References: <20201203160245.1014867-1-jackmanb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203160245.1014867-1-jackmanb@google.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 03, 2020 at 04:02:31PM +0000, Brendan Jackman wrote:
[...]
> [1] Previous patchset:
>     https://lore.kernel.org/bpf/20201123173202.1335708-1-jackmanb@google.com/

Sorry, bogus link. That's v1, here's v2:
https://lore.kernel.org/bpf/20201127175738.1085417-1-jackmanb@google.com/
