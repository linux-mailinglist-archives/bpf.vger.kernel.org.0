Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE2423E146
	for <lists+bpf@lfdr.de>; Thu,  6 Aug 2020 20:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgHFSmZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Aug 2020 14:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbgHFSWw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Aug 2020 14:22:52 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D582C061575
        for <bpf@vger.kernel.org>; Thu,  6 Aug 2020 11:22:12 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id y185so1301669pfb.3
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2020 11:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eZGw4D0hFAb3nEJ/BxXu4ur7Q7JmFu4sgP7DPLUaQCk=;
        b=Seomrp3G9pyZOfFPTaf3c0hryPLPKNktWbwPc7/XzFqO4Ig83A0Hbg4KzVZihOLtbZ
         0uAlVSAhkEyAPBIcTl2vJoziIH1i5rGKotUov4MgTVsoppdOV5tcpRGlrM218eBHpF8q
         LwXgdcFzuyf2m+vumEMsJRygBzT9w53SGgq4XUJL4y83yqLivrKAZ/3BQ+6uBm9AdHu7
         Jad78mxBaAjslErtp/Pe+hOXUYk+aQ45weABCiZr6w+JMG4VTm+poz4mlenU2KZgvBUC
         e0bTN0m+U+6iFFS9n3j71l5+ww/daNROUYp7iQ+HkHwbT3JRAXlkbg6Ptqds5B5rMVO/
         EE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eZGw4D0hFAb3nEJ/BxXu4ur7Q7JmFu4sgP7DPLUaQCk=;
        b=ekvL7+RkCuPP6gKsvvyYHAIWAIe8EPlOp57A5gep5zsE3JVsj94EzjrGCqgxqSC4B5
         8HThcSbkiKouAbHp4T9SCcAI/HB/ZkOlrOuqZR9bsUz0GIJ1aMQOP+X18JC5+D9I8zqd
         Xa4ge4HuLCRhKy3iJuUUs5R1w93E8txh52f+dTaF2PbUBsKf3bm7IyLdoIqIvh52jhl8
         N1c/6ibZ9vVa9iAOWsn8bTjwhSL0J24xMVuOXbn+x1+69/NoV9pDVXu5DwFxHX9nzVeO
         DvybV/2GMnRmzjsCjpkIFfLR7p/mGd2aZ7sNIQIkp05bEm4ZZEVL5wdFGk1ySzUkZAyP
         qyBA==
X-Gm-Message-State: AOAM533XqzUsgqZPITV818Ewec9Qgp9TPvTglOJbC/tNhD3+6fsyQIW6
        e3I2oFg2TREdM31Opk1WRSfera0=
X-Google-Smtp-Source: ABdhPJzjYl3T67ANMsiVXYbzueltnnaExCsuaDVgnrJUvxLnfoaP562t4Cjb8+NmROC3jGusa63+2Zs=
X-Received: by 2002:a17:90a:f014:: with SMTP id bt20mr1601886pjb.0.1596738131438;
 Thu, 06 Aug 2020 11:22:11 -0700 (PDT)
Date:   Thu, 6 Aug 2020 11:22:09 -0700
In-Reply-To: <20200806155225.637202-1-sdf@google.com>
Message-Id: <20200806182209.GG184844@google.com>
Mime-Version: 1.0
References: <20200806155225.637202-1-sdf@google.com>
Subject: Re: [PATCH bpf] bpf: add missing return to resolve_btfids
From:   sdf@google.com
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 08/06, Stanislav Fomichev wrote:
> int sets_patch(struct object *obj) doesn't have a 'return 0' at the end.

> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>   tools/bpf/resolve_btfids/main.c | 1 +
>   1 file changed, 1 insertion(+)

> diff --git a/tools/bpf/resolve_btfids/main.c  
> b/tools/bpf/resolve_btfids/main.c
> index 52d883325a23..4d9ecb975862 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -566,6 +566,7 @@ static int sets_patch(struct object *obj)

>   		next = rb_next(next);
>   	}
> +	return 0;
>   }

>   static int symbols_patch(struct object *obj)
> --
> 2.28.0.236.gb10cc79966-goog

Sorry, forgot:

Fixes: fbbb68de80a4 ("bpf: Add resolve_btfids tool to resolve BTF IDs in  
ELF object")
