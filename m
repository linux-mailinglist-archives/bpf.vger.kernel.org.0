Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEF3396E98
	for <lists+bpf@lfdr.de>; Tue,  1 Jun 2021 10:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbhFAINh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Jun 2021 04:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbhFAINh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Jun 2021 04:13:37 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D25C061574
        for <bpf@vger.kernel.org>; Tue,  1 Jun 2021 01:11:56 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v23so10922909wrd.10
        for <bpf@vger.kernel.org>; Tue, 01 Jun 2021 01:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UxA3xbDhbZOB0OLDbSx73wTyxBOoUWuy5QnPRcZHvZE=;
        b=RyOX5+cWNXC7pfISDXVcSR1F61G3x56s9sg6LPuZjp3xtZDCLtYnLPNtR0Uwzjo5kb
         UsBnHlKQB1bH755cTkyjB+3uoU7WcEm4IJWQsqyjH8+dXr5Axvd/+G4JDlt6aA1T9uZs
         2BzIZq7X1etE3otoDn+mfmvrptEq9jX+22fpbg5ebQFEFGVc3nOpm8TAgEcYdQQkbSkc
         Ax5ClyP3xp7MMTW9YWOibMC0OjRwHPoH8SaFHiMlgVsbbxWiRX6zQgMvtDUsA44HCmay
         9XDFfE0FsEdwEBTBaL4BXgGy5ZeVAzpVnc7zfwCeB0+BrHIeS1nRr3pw3RFdTqEIJzXB
         eGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UxA3xbDhbZOB0OLDbSx73wTyxBOoUWuy5QnPRcZHvZE=;
        b=q4I1sF2Ap8gYbMGEXeOOKn2RnJmMATCxgikybafL+75BolstccyVyJPp2Ut2FzE+9x
         3B8Zro6vpOKzKo6IIsVDoTd70BTSCwSw7MKQ5d2B1susAXx6cUaHTA2aSqQSJDWu2e5t
         uHiPFg1ZvNu/fWb1TKFnrzP0e6cgIXwvwCdTXO+oRoOzpgdGJqYds0HPdHHOKFZ3YGYu
         Qs6nHnJGAVtHiGvJuuBeE7Dbdhim/hA2Z55n8eKL/XZ9hnoBtGr+vJ0p8TdZ0Ppm4ho2
         ZMqATBbeu/y45DK3U4CT0qZeZjIF/AeugdSKp7qsuagw5x486AEmECqTGgM5p6Z31NzZ
         6baw==
X-Gm-Message-State: AOAM530CN9NPY1CT+eI3/ZVG28Q+ttYWVuX8nkCy/EmJ/DLK0vSIs6o6
        8FCR0A8KiuDvRhfSeyr4cyM=
X-Google-Smtp-Source: ABdhPJwUD+KENoC9dRvqI35Q+FN4bn6V2Xj5V0MBE1ZFhxzmb9jLqsy8SM0ysxa4s5utbXLETjGi3Q==
X-Received: by 2002:a5d:52ce:: with SMTP id r14mr26676460wrv.395.1622535114732;
        Tue, 01 Jun 2021 01:11:54 -0700 (PDT)
Received: from [10.108.8.69] ([149.199.80.129])
        by smtp.gmail.com with ESMTPSA id l3sm17598406wmh.2.2021.06.01.01.11.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 01:11:54 -0700 (PDT)
Subject: Re: [PATCH bpf-next] bpf: tnums: Provably sound, faster, and more
 precise algorithm for tnum_mul
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        hv90@scarletmail.rutgers.edu
Cc:     Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Harishankar Vishwanathan <harishankar.vishwanathan@rutgers.edu>,
        Matan Shachnai <m.shachnai@rutgers.edu>,
        Srinivas Narayana <srinivas.narayana@rutgers.edu>,
        Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
References: <20210528035520.3445-1-harishankar.vishwanathan@rutgers.edu>
 <CAEf4BzYnTYdDnVuEuiHpg=LWT_JvwJim8kTEBpGKrH3wePez2Q@mail.gmail.com>
From:   Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <a4da47de-daf8-e167-a796-83bd4167341b@gmail.com>
Date:   Tue, 1 Jun 2021 09:11:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAEf4BzYnTYdDnVuEuiHpg=LWT_JvwJim8kTEBpGKrH3wePez2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 30/05/2021 06:59, Andrii Nakryiko wrote:
> I think your algorithm makes sense, but I've also CC'ed original
> author of tnum logic. Edward, please take a look as well.Yep, I've been in discussions with them about the paper and their
 algorithm appears fine to me.  As for the patch, nothing to add
 beyond your observations.

-ed
