Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A38041D989
	for <lists+bpf@lfdr.de>; Thu, 30 Sep 2021 14:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350772AbhI3MTC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Sep 2021 08:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350755AbhI3MTB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Sep 2021 08:19:01 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E194C06176C
        for <bpf@vger.kernel.org>; Thu, 30 Sep 2021 05:17:18 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id v127so4473584wme.5
        for <bpf@vger.kernel.org>; Thu, 30 Sep 2021 05:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FDCTavcZNTCR6IHT5nWxxzLFQomp0qMTNq4JyzyeK94=;
        b=7yEP0WyroleXj4pTqfXhw86YYpQF2i1z0EomN+pGqMUjn4IQcK3qO3N0eeldn0EVW9
         P6qfXNwvQz7rRgMshgXACc5ju/EIULMzzprty0wNoGL1Fi9GZihh4kcQcRcYiQfyQCIF
         g6+OP7niX2CIOUVSZmlT/6+5MRPRLknicuXqxmrSVkS94o0a6hzZkiLWCTyPMp2gjVVH
         4K3kfm2pIKTETJeRMoPM74JGeUsgBqGmO2u2dJXnSORbKm3far+ApFXfwxOLIJ5tMYAN
         7WjetPlngIAdX0zWf9pKSlIKVbDfUulTnxI5Ey/seZ1lnPiAe2C9AwHL/2pjyeplRRkQ
         6VLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FDCTavcZNTCR6IHT5nWxxzLFQomp0qMTNq4JyzyeK94=;
        b=W/qK/MpBSL+azr0mgduKvEYY8wWoFqkr+bsmHYIFIH8FQuTEOP5RNCZl6pgCZ0Dz/E
         3Etlid2/8KBcXB4SKpZ7LTNOESC6IJpclvEE8N3jIWLz6WhAj9GbEnyi+L35RZ48lnjF
         nzfI0sCXIhinvIYgy/6UqjNHObW/z2gaZR4eOX/H9Ecnpk5tdSERH55Kjq6Rz9xqa24n
         WcjsOl20m8a59ekMfr5AUMQfAnZ/tjZQ3qlxZTo1JehovoPUCRrUm4P+lR/VgoK5w4SU
         mI6VG8K5czdNNqb2tiL7BpzzfAmAO6O8QvLvntt74ipx+aW04ZSvYzT3e4bXoFFMKXLM
         evgQ==
X-Gm-Message-State: AOAM533WsPw4P6+ZqIIurFoYQYM7l7oNdi1P8/p1mcPioYNa1KWWyiyJ
        tdoH9U89USvmiVhqIlhv7i5gVA==
X-Google-Smtp-Source: ABdhPJyeQ5fdTRDeFrxGsq6dxtbfma6pFwoP4EBpPORVupU+1MzUN52F9vyl+owfIkg2a0B317OZ3A==
X-Received: by 2002:a05:600c:4f16:: with SMTP id l22mr15253270wmq.123.1633004237199;
        Thu, 30 Sep 2021 05:17:17 -0700 (PDT)
Received: from [192.168.1.8] ([149.86.91.95])
        by smtp.gmail.com with ESMTPSA id 8sm2811796wmo.47.2021.09.30.05.17.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Sep 2021 05:17:16 -0700 (PDT)
Message-ID: <354d2a7b-3dfc-f1b2-e695-1b77d013c621@isovalent.com>
Date:   Thu, 30 Sep 2021 13:17:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH bpf-next 6/9] bpf: iterators: install libbpf headers when
 building
Content-Language: en-US
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20210930113306.14950-1-quentin@isovalent.com>
 <20210930113306.14950-7-quentin@isovalent.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20210930113306.14950-7-quentin@isovalent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2021-09-30 12:33 UTC+0100 ~ Quentin Monnet <quentin@isovalent.com>
> API headers from libbpf should not be accessed directly from the
> library's source directory. Instead, they should be exported with "make
> install_headers". Let's make sure that bpf/preload/iterators/Makefile
> installs the headers properly when building.

CI complains when trying to build
kernel/bpf/preload/iterators/iterators.o. I'll look more into this.

Quentin
