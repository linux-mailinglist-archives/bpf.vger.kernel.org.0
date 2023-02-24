Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6590C6A18C6
	for <lists+bpf@lfdr.de>; Fri, 24 Feb 2023 10:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjBXJdy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Feb 2023 04:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjBXJdw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Feb 2023 04:33:52 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EB44AFE6
        for <bpf@vger.kernel.org>; Fri, 24 Feb 2023 01:33:49 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id ay29-20020a05600c1e1d00b003e9f4c2b623so1662807wmb.3
        for <bpf@vger.kernel.org>; Fri, 24 Feb 2023 01:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mcLXJ6tt5hmVp0MEko8n3OYYJHQCNN6tlpbn6Qy2oU0=;
        b=BI4UX2+on8pyzZt6htQ2xO3Hss0VsMso7q8p7gTwTxq8OHcO75ePXYkilklkGKcPSx
         87GKJxpwkDgmsE8so1JQzYnJJIFTadSrBuoAA4Lp4x5pPJpc4muXdfIRCwQbZniG4GnF
         AIk3B9YoFG701LC5Ekw525yItPHoRJAzXtKcnLtjZ3NAKmQyvxnVVgRyjVBiFjG66phh
         FUqF1d11J9/SIxHd3Gy7GVztc3IzwOfcosJN/8IJ9O1HtW6bZNAtFGXdD/0BfBPwZf37
         febXQUocn69x5MjV4PRSeARmMtbPOlxKElzyVI4L7cKuWZhRsNVE8w8zv1fCIn2uAQ7N
         o3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mcLXJ6tt5hmVp0MEko8n3OYYJHQCNN6tlpbn6Qy2oU0=;
        b=iHF3nlQbPRioDfYaDstrKJxOh76bxykPahDlzXBc/ap8x2K7HrB4QlnCnKjyDiBNDU
         2b7tOSHECxJR9kkegNtIyrUt7rp5A8EfXHEqUaugBeyOnm/KIt6KE1tsCru/bO+9/Qbg
         J9Fz8eged5Ju1YdmP0UQVsW7P7r0Arf23+YqsVnZQ01iIWSMP9NeQIDTTp1v4jV8WO+H
         yi5DarRORqMObvPED1QTuDci/2K2TlV5B/kOwq5FR690DauTszvfVsdSBZ+YYvn7Lyk1
         Kz9A1VN+f4nhFFg+Qijja/Xm3E54TXdMfQh1dIx2378s4oRgMep1aY2JiHYZIkfjqb9Z
         ZYRg==
X-Gm-Message-State: AO0yUKUwB1d4/0yDVq4Gx92BieBXabXzupI9EUvY59TG3hxspm2FX+Gz
        detYbgk1IFKlQDdLMLzpy04=
X-Google-Smtp-Source: AK7set92st08Jth09TgcTNNQMftdKBrc6wwfvusKGwWGKZ6z+ZFNW1uxFGBi4yE1+VZwzAZX87dFbg==
X-Received: by 2002:a1c:4b13:0:b0:3de:d52:2cd2 with SMTP id y19-20020a1c4b13000000b003de0d522cd2mr5268654wma.4.1677231228083;
        Fri, 24 Feb 2023 01:33:48 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id n22-20020a1c7216000000b003e2059c7978sm2159735wmc.36.2023.02.24.01.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 01:33:47 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 24 Feb 2023 10:33:45 +0100
To:     lsf-pc@lists.linux-foundation.org
Cc:     bpf <bpf@vger.kernel.org>, Timo Beckers <timo@incline.eu>,
        Alan Maguire <alan.maguire@oracle.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [LSF/MM/BPF TOPIC] BTF function/address resolving
Message-ID: <Y/iEeeAKkQZ3Zt6K@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The process of resolving function from its BTF ID could get us wrong address
when there are more functions with the same name in BTF data.

We retrieve the function name from BTF data (the first match we find) and look
it up in kallsyms with kallsyms_lookup_name functions (which also finds the
first match). This brings lot of ambiguity and we can't be sure we get the
proper function address.

Currently we are about to eliminate multiple definitions of static functions
with same name and not matching declarations [1], so current resolve process
should work reliably, but at the expense of removing functions from BTF.

As a next step it'd great to have non ambiguous way to resolve function by
its BTF ID to its address.

Ideas that came around so far:

  - prefix symbols with filenames in BTF [Timo], like:
    fentry/kernel/reboot.c:type_show
  - using declaration tags [Yonghong] [2]

It'd be great to have a discussion about that.

thanks,
jirka


[1] https://lore.kernel.org/bpf/1675790102-23037-1-git-send-email-alan.maguire@oracle.com/
[2] https://lore.kernel.org/bpf/ac273c04-3066-dd63-934c-f62650c41f8f@meta.com/
