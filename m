Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74FB12D1821
	for <lists+bpf@lfdr.de>; Mon,  7 Dec 2020 19:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgLGSDi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 13:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgLGSDi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Dec 2020 13:03:38 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288E8C061749
        for <bpf@vger.kernel.org>; Mon,  7 Dec 2020 10:02:58 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id w3so12680155otp.13
        for <bpf@vger.kernel.org>; Mon, 07 Dec 2020 10:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2gKa2VMXYOhra4nPv0+tKTjCDtRbDIgbb+Ar/ivqWFg=;
        b=uZ1bZWBqjFPSWXiVQoVRI5V9bl91BujbXNaw+2I2qWcfZ4JllAzColhQthlRB5nkEX
         z0JxjXlf2jh5ztW+pHTtb19jGfNfcWnqmtLRyEmWNx2dBRgwYpYtsf1eCm02tTq9Qx4m
         GAe3bQKJ+8vE4WBKml/VAvxrkDfYSdeCyQUCtdJwFi0aS6fq4vywSFY1qkntAeLiC6bX
         0EAvbxw9mEBNScuZ3OXbUMEmq/FhbrkA7TDh/8X6R+YqvYVkBhdmeVmjH8A00bbfbHU+
         mqsDK4hXeIHVe7AIm7hNmlJih5IZNQp7GQ6qvBmPFBe6Nc6FqfxauCRu8CcZIWPNSZxK
         ZI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2gKa2VMXYOhra4nPv0+tKTjCDtRbDIgbb+Ar/ivqWFg=;
        b=o3La5ULTY3WCHUZFq+Cb7GnHQlaL/UtT6laVArNAC13h1ddg6b1CYmG0SdWcKu7ZbI
         ntr3Dn++AcZ4FtmtAbZvxO7JHiJ+iEdva+EVv5Udo8E3oot0pik+1yNd5ErEAiF0BKSV
         HveyJlIxhq/WNlFBPhfvEuMoceLyqB1lWavvmOqSHfWTEysQ5LFFJuR6z/c4eJSCY+P/
         CI5ih3K8dcrqeSOqP2esDjBCpPQdeDD4XeHuQFCyHWJy3lLxdaZU/rmApnIKYuqFL35p
         1MuhQM5knHvlK0mOo+bvrSkiudNGN4r1fwVLWsfVibCsvB62MjU8hKoPxmam6568KlQf
         QA5w==
X-Gm-Message-State: AOAM530PD3O0eI8k9ABgO3hzpqrWIfSW3CRlihSHVVSED1qfofXedCHv
        DSOfd1Z6KXrM/eS/0F3JTU2/qL7nbNM=
X-Google-Smtp-Source: ABdhPJzQ0Q9pcpzU/RWY3KTUC+nHnrE/1WZxWki4drkkgltbtYhYhU3EAuq7Cv7mr/tblxSSua/PZA==
X-Received: by 2002:a9d:3a24:: with SMTP id j33mr13809109otc.259.1607364176909;
        Mon, 07 Dec 2020 10:02:56 -0800 (PST)
Received: from Davids-MacBook-Pro.local ([8.48.134.51])
        by smtp.googlemail.com with ESMTPSA id l5sm2066181ooo.2.2020.12.07.10.02.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 10:02:56 -0800 (PST)
Subject: Re: Latest libbpf fails to load programs compiled with old LLVM
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>
References: <87lfeebwpu.fsf@toke.dk>
 <10679e62-50a2-4c01-31d2-cb79c01e4cbf@fb.com> <87r1o59aoc.fsf@toke.dk>
 <6801fcdb-932e-c185-22db-89987099b553@fb.com>
 <CAEf4BzZRu=sxEx7c8KGxSV1C6Aitrk01bSfabv5Bz+XUAMU6rg@mail.gmail.com>
 <875z5d7ufl.fsf@toke.dk>
 <CAADnVQ+qibC_8cDwaqOoAnL7CwXv85EjQ96Zcdtrm+86cgZq1g@mail.gmail.com>
 <878sa9619d.fsf@toke.dk>
 <CAADnVQKYaeF2KCC5SLBg3feUY_DBh-eq2_O=T10_+13z3wNm1Q@mail.gmail.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <82dc6d2b-95b6-ab50-8bdb-6e90cfb32059@gmail.com>
Date:   Mon, 7 Dec 2020 11:02:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <CAADnVQKYaeF2KCC5SLBg3feUY_DBh-eq2_O=T10_+13z3wNm1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/7/20 9:20 AM, Alexei Starovoitov wrote:
> The user space library is not a kernel.
> The library will change its interface. It will remove functions, features, etc.
> That's what .map is for.

So any user/package wanting to leverage libbpf can not expect stability
or consistency with its APIs?
