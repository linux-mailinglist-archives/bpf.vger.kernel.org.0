Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD7C1B7213
	for <lists+bpf@lfdr.de>; Fri, 24 Apr 2020 12:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgDXKdZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Apr 2020 06:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbgDXKdW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Apr 2020 06:33:22 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3EAC09B046
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2020 03:33:19 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k13so10161721wrw.7
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2020 03:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8mmiQQPPszvQVjLjDnxudjKdNdDpKLMPzK3SPDltDkg=;
        b=N8cVAR3SbbkajX3SjF3RCO2CXV0r0cDbs6A9cFr7RDZzz2oLXnQulRG380/+xo36j+
         MSLooZIdvpU9KwiPc2NSNyWUap0tcVSkYz+dBI0EfhLUEeSqW8Okkbv0NPiHGADCw/7v
         ZR+ijfUnXSaw8RKysnMQLWH4ChK3ZhiARb7bwarYyns+8cE7vN1FHnQGB9wkPUyjdK7D
         c1Wl8ep+cXAbR+TQOua8FVN5jIW+FyalKtxkpx2uuGWza2zKgoE4B1ZsmhUx6nampgNG
         9nXrqGGurZTjETYuFN4odxbxW4bpVmoDB5vyA8T6wfmGfzEEIN1zTMqi8qRmNbx9pmJC
         uUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8mmiQQPPszvQVjLjDnxudjKdNdDpKLMPzK3SPDltDkg=;
        b=k+Y4NYrffbyR80GV0XKEjppC1LwqSlnngOqjeP4aS8a0BE2JwEVTgBL04jvLYYiot9
         t2qtIzD4t+VVrBC4fbT1COWZlHxpZvGaElbEhYgOndGEL2kUBHbQUTJTdCOATergIISo
         z4Pf5QzxPAy30Xs1UJmpHW9P/t38ZS1EcLNn+bya+QWCjFlFk1otZ7W4fSFRIMOzmlKO
         eQWyzSPopIpzjzC/XIHfGVHqjs4+z9gOeAwu04GkFwBKddiEY2e81QyspWEJMBT/KEGb
         r1i3AERFooDff2NY/eCH4eSwqD53v/QBnjw1TGi6ArWS40wS5xcXk/D2F7ODBHfNtVp3
         jq/w==
X-Gm-Message-State: AGi0PuaaltE3FVqoUhYVkESy+xldiiUyKmcdk6pUJ2G6R1/q2F0h7UcU
        YHVXaf+kn+putekNKVB3w3kAJaxwTpo=
X-Google-Smtp-Source: APiQypKSinIlQfWTkZxmoBz6nD2ehaxyuCzlaY54OHochW6acrjfxEhPgTw5y641aF4rZ73Yv/+Pfw==
X-Received: by 2002:adf:f091:: with SMTP id n17mr10225990wro.200.1587724398492;
        Fri, 24 Apr 2020 03:33:18 -0700 (PDT)
Received: from [192.168.1.10] ([194.53.185.129])
        by smtp.gmail.com with ESMTPSA id z8sm7176272wrr.40.2020.04.24.03.33.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 03:33:18 -0700 (PDT)
Subject: Re: [PATCH bpf-next 10/10] bpftool: add link bash completions
To:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@fb.com, daniel@iogearbox.net
Cc:     andrii.nakryiko@gmail.com, kernel-team@fb.com
References: <20200424053505.4111226-1-andriin@fb.com>
 <20200424053505.4111226-11-andriin@fb.com>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <e52e945a-0a20-a93f-77f1-e2165fb4a3dd@isovalent.com>
Date:   Fri, 24 Apr 2020 11:33:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424053505.4111226-11-andriin@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2020-04-23 22:35 UTC-0700 ~ Andrii Nakryiko <andriin@fb.com>
> Extend bpftool's bash-completion script to handle new link command and its
> sub-commands.
> 
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Looks great, thanks!
Reviewed-by: Quentin Monnet <quentin@isovalent.com>

