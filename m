Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74635437394
	for <lists+bpf@lfdr.de>; Fri, 22 Oct 2021 10:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbhJVIWo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Oct 2021 04:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbhJVIWo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Oct 2021 04:22:44 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8B2C061766
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 01:20:26 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id e12so2696505wra.4
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 01:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=neYj3P+KpD7Ixifz+7FY5d/nurCJB3b5gZwG2Bu+tWA=;
        b=MQQ96Ad3GvUJIHBvb4Bvf2VBFIMn8/IRihE+Dup8572sBeDX7PGZnKtEoPMl2AIzjH
         /fssTrL3B4HWFp9S1nmlFsTck7Gn62GI8uwtWYWoUDTAS8XkiM2IUBi3hq13f6B+IE9f
         u5W0qTMUviS9DeSypiuEfQEc8431st8buHB7Tr3h3ipEVVULCF+ezW1enOvaE/o6gEb1
         j4J1eGRmoImbo0EVixMm3p4J+luaFw+zRdQaaRW2KMrhm/lL+wHuUodLi4/7UjTC8RUW
         STXZJXmNWGrh1CZpajcDz7onv0BeB4z2Sz2HCGW6Kcar/f2IireW6sYAtAL+aNk61qir
         UtUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=neYj3P+KpD7Ixifz+7FY5d/nurCJB3b5gZwG2Bu+tWA=;
        b=GZ2Vi3HUhOLnfrSoWLcddxGuNfNc+Ku4f07HzN1oGDMxsg9njKmYvMFo2opSx/PFPI
         MJcFRfJXuqO/PrvQHzTkZ5dEtqw78eyKmciQRlkiO6U0QRlD6ZHrGJsV2DyquAHWj0S4
         PixEO5YX3V2Q+Mby5WdM0Ki9PaWxET040+dRUnA9qGV0gR+zqtsrziPxsaJX8qsi268t
         tO7+rZkrdkBFujzXG0GpiRv58j1+LEC9ZNSUk7LCwFBY4oF4XCLjekj83cQgwGrou4PL
         deF0pzRCNaAzsykVjkmTXJ6pVjUgdJBpb2gO8td9PlIt9g8ZJGDSJmiCrrJ6OE69c46g
         9TYw==
X-Gm-Message-State: AOAM531CJ/28WRkEOf+QyHw6/aP0R24+8gwWINzPNA/WOX5uR/oFY310
        tEhNkfOWceZtaOZ6dYAmZCHA4A==
X-Google-Smtp-Source: ABdhPJwwI2ntAGm8BDkW8fxgcUnYPYIusmCXdTeOURUv/D6LptPaPFSbmiraJ6C/sCdgDPXRRMQEfw==
X-Received: by 2002:a5d:4b51:: with SMTP id w17mr10585157wrs.47.1634890825468;
        Fri, 22 Oct 2021 01:20:25 -0700 (PDT)
Received: from [192.168.1.8] ([149.86.66.22])
        by smtp.gmail.com with ESMTPSA id o17sm1372876wmq.11.2021.10.22.01.20.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 01:20:25 -0700 (PDT)
Message-ID: <0d4e18a7-4db4-a942-60ad-a9e5312a316b@isovalent.com>
Date:   Fri, 22 Oct 2021 09:20:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH bpf-next v5 2/3] bpftool: conditionally append / to the
 progtype
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
References: <20211021214814.1236114-1-sdf@google.com>
 <20211021214814.1236114-3-sdf@google.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20211021214814.1236114-3-sdf@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2021-10-21 14:48 UTC-0700 ~ Stanislav Fomichev <sdf@google.com>
> Otherwise, attaching with bpftool doesn't work with strict section names.
> 
> Also, switch to libbpf strict mode to use the latest conventions
> (note, I don't think we have any cli api guarantees?).
> 
> Cc: Quentin Monnet <quentin@isovalent.com>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Thanks!
Reviewed-by: Quentin Monnet <quentin@isovalent.com>
