Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0233495847
	for <lists+bpf@lfdr.de>; Fri, 21 Jan 2022 03:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237776AbiAUC2L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Jan 2022 21:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237728AbiAUC2L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Jan 2022 21:28:11 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8995C061574
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 18:28:10 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id c5so6969350pgk.12
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 18:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZIzE3s87NdJjtj9GXOehrQHsBhnmxBeLYaJweYpOKrU=;
        b=e27YeDmCyt6RjNgBZZRfD8o/kAUS0QxgwbXQYGi/IOTC4xWcfe5z4RAX1INlZSXJHA
         JEcBMYxxTuE28RPF1sSac0WNyVWSpPQZGTZ8BuTGGL8L6vWUKaS9vN9lwc8gIXer4nDm
         NmfZ3dp12aS5xy8CTa26e4WZVc2IwVz/2PLcnT8pktx8lUTILWZAP9SQDwaRhkyOmOA7
         w1LhOGhpSzoHRVKki1swsBhSaX0I9wNx2aiSFDxOgCBLu5bA3xAGpcxkAkzVuOFGjJmR
         LkwVKI0BvDs8ij3vSpGQnNql+DKeMW7Vx9LWTr/xq6rKFnIlorZlV4lvWef0mi42r05f
         kI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZIzE3s87NdJjtj9GXOehrQHsBhnmxBeLYaJweYpOKrU=;
        b=OdEsJT2mfeRNgYnjNyFtdT2pOzwKwBOncknqw8IVPJZDOPuBOTqyfT4rABnELgeZIC
         /5zf9GJwin6tp5T0Yv8vTCPKug9VnWCHN5YzpdIt79PotKuip0GU9P25GaSwUX+Xt+QP
         8TYgqrAopRo8vekxXDHxue6m7fq5XQMo295yziHpCs5HpNsqGHwUgmLbz5QXdk0/vR1G
         GqQ1AboJFWmNLX0yI2DimToLcaeQT7fU7KhdQy2GDm2gQZXfpDuwIPJJHNyzdh55fGcV
         w9ysauww3S5TKfZ2HG2Ax2+599gidLTMQP8Uwu/xAv8zynHSk0nmM+sGGGbenMmz8bEZ
         YZgw==
X-Gm-Message-State: AOAM530+dEzTCdAKM35NrkIkoFjO0p+Zq+qA+jR7Cqx/smcjr24Eh2Wt
        Wnk0Aj3YDDBGE2PB7kObORfUND2QWSC928NtiUI=
X-Google-Smtp-Source: ABdhPJwNNWzVvU7aU2D5Hfd2YlzQYsBbT8Y3qCA7sO7G7QVvCwsaEjkGvPLrox8MznRl1eJ1G6w931VjySxjfTrBQPY=
X-Received: by 2002:a63:be49:: with SMTP id g9mr1356708pgo.375.1642732090278;
 Thu, 20 Jan 2022 18:28:10 -0800 (PST)
MIME-Version: 1.0
References: <20220113233158.1582743-1-kennyyu@fb.com> <20220120172942.246805-1-kennyyu@fb.com>
 <20220120172942.246805-2-kennyyu@fb.com> <CAEf4BzbEqSh36mFsrwtMYD6c-=LcJ3XbJsEa1ZatLdWkB+3mtQ@mail.gmail.com>
In-Reply-To: <CAEf4BzbEqSh36mFsrwtMYD6c-=LcJ3XbJsEa1ZatLdWkB+3mtQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 20 Jan 2022 18:27:59 -0800
Message-ID: <CAADnVQL-85q36gRvMGocXMLNk4WjDa_Xpi8Y9ZQS+qYLhF8E+A@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 1/3] bpf: Add bpf_access_process_vm() helper
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Kenny Yu <kennyyu@fb.com>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Gabriele <phoenix1987@gmail.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 20, 2022 at 2:46 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
a
> > + *             wrapper of **access_process_vm**\ ().
> > + *     Return
> > + *             The number of bytes written to the buffer, or a negative error
> > + *             in case of failure.
>
> wait, can it read less than *size* and return success?
>
> bpf_probe_read_kernel() returns:
>
> 0 on success, or a negative error in case of failure.
>
> Let's be consistent. Returning the number of read bytes makes more
> sense in cases when we don't know the amount of bytes to be actually
> read ahead of time (e.g., when reading zero-terminated strings).
>
> BTW, should we also add a C string reading helper as well, just like
> there is bpf_probe_read_user_str() and bpf_probe_read_user()?

That would be difficult. There is no suitable kernel api for that.

> Another thing, I think it's important to mention that this helper can
> be used only from sleepable BPF programs.
>
> And not to start the bikeshedding session, but we have
> bpf_copy_from_user(), wouldn't something like
> bpf_copy_from_user_{vm,process,remote}() be more in line and less
> surprising for BPF users. BTW, "access" implies writing just as much
> as reading, so using "access" in the sense of "read" seems wrong and
> confusing.

How about bpf_copy_from_user_task() ?
The task is the second to last argument, so the name fits ?
Especially if we call it this way it would be best to align
return codes with bpf_copy_from_user.
Adding memset() in case of failure is mandatory too.
I've missed this bit earlier.

The question is to decide what to do with
ret > 0 && ret < size condition.
Is it a failure and we should memset() the whole buffer and
return -EFAULT or memset only the leftover bytes and return 0?
I think the former is best to align with bpf_copy_from_user.
