Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5480C407F0D
	for <lists+bpf@lfdr.de>; Sun, 12 Sep 2021 19:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhILRtm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 12 Sep 2021 13:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhILRtm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 12 Sep 2021 13:49:42 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DBBC061574
        for <bpf@vger.kernel.org>; Sun, 12 Sep 2021 10:48:28 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id a20-20020a0568300b9400b0051b8ca82dfcso10149617otv.3
        for <bpf@vger.kernel.org>; Sun, 12 Sep 2021 10:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=0OEz0TL8bDvwR+2g1YmaSA5+YeQiHhPyK87nZ6cd/JQ=;
        b=mEAV/fRKYNHXklKNQvDVpswTwjmgsY+zCxyDq5hu3cZSunIFziTUt5ZY332EBy29g8
         qGLRFFpPpYiZ7Y0vNEJM+F6N1vjLPT33DyxnWN/ktIXq+LDNzIBEvv2Xit5AQg9mkypd
         NZbgDFo6U69qGWMS3iDNjxho0CMBFVuCcmFFXvH/V3D2m2KeCJPKvmLzbcyU7Cs38tuL
         nEefhxcfX3F92M8xsDFa17zRgii0QQjO4TxcEzkjpTiubrtewwHXUw39gAA2i7uapLoq
         3kbSqQwFGROfCX1GHaVrwu4C2U5aesVUdeXwK+U6Uopwe1rp1WslYvPxbmfkpCgVQ91R
         3Mug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=0OEz0TL8bDvwR+2g1YmaSA5+YeQiHhPyK87nZ6cd/JQ=;
        b=AeBR8r86NVB3qJ0PcuLsAEiCo117YhX1UhF3dzTuLJ1cuSnXnn/wKfSsjG8BIRpn8E
         BE/BKoL8fG7+DtUZkHsLrvudW6o+Waj2BZwE3RlCYTNkaozvEyA/Haqnov3GwgmmPp60
         4AxOuDq3NH0Q/Er9u4/PWs+yZe5dSNdQNSNQYofdq2JG9DJmQAyQgmGPMegGnsRkowfN
         qYNJQ+4f84ok+9AwTJj/1RyfnbtZc6gAhEUjEAwMtfjrCSOMWQ660LwQS/WVr2fOOwzU
         geAY936JE9dp7oMi7BLdG4uewoKiILfzhqmkDDUmjiDnemV0T7rW8s3qwOZjpYC0eJsq
         kPnA==
X-Gm-Message-State: AOAM531Krgmglgk71Vv0Uyf8ahwI6nHjv+cU3dU3tfWmMmaNJ0iNFEYe
        KRBnAuWr4ZtiDzaHpvQgvxf7vBpO0yo3Ng==
X-Google-Smtp-Source: ABdhPJxddukNhS9Pu/oqDgUzLl29swMw35P7ErhkXeZKc0SnLIfDSarHcHEqHGxFIl8Ps+pmzcaTpA==
X-Received: by 2002:a9d:7182:: with SMTP id o2mr6763872otj.173.1631468907197;
        Sun, 12 Sep 2021 10:48:27 -0700 (PDT)
Received: from [192.168.68.112] (192-241-58-141.ip.ctc.biz. [192.241.58.141])
        by smtp.gmail.com with ESMTPSA id i5sm1137293oie.11.2021.09.12.10.48.26
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Sep 2021 10:48:26 -0700 (PDT)
To:     bpf@vger.kernel.org
From:   Hsuan-Chi Kuo <hsuanchikuo@gmail.com>
Subject: Why does tail call only unwind the current stack frame instead of
 resetting the current stack?
Message-ID: <93b37b05-3aab-3e50-bd1b-e97a8d5776f2@gmail.com>
Date:   Sun, 12 Sep 2021 12:48:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

The function check_max_stack_depth 
(https://elixir.bootlin.com/linux/latest/source/kernel/bpf/verifier.c#L3574) 
is used to ensure the stack size is no greater than 8KB.

The stack can only grow over 8KB because of tail calls as they only 
unwind the current stack frame. I wonder why not make tail call reset 
the stack since what was on the stack

will never be used again?


Thanks

