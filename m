Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF839491E7
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2019 23:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbfFQVCB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Jun 2019 17:02:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35713 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfFQVCA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Jun 2019 17:02:00 -0400
Received: by mail-wm1-f66.google.com with SMTP id c6so868379wml.0
        for <bpf@vger.kernel.org>; Mon, 17 Jun 2019 14:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=Z/Z88bOWMmF4F62mamLrOyAebeVoxhvHlf2axRQroeU=;
        b=hKcBm6UoTrBy7uRJa3PJThXcNP0X/+3jcDF+wdINWuMTuZtCogg2mS3jiuBHJJdBFt
         H32ct4bwXNtqMYL4vYd55Kc1IHTgL4luvP8WAauQKenWJEAZXqk8J7hscskunQbBdzkP
         namNcI1mSUbbHm+LNnUeAerxpvHYZN7Wr1bdlX5E380zrj5hbAHelFB6MCgt5Xo+fL9Z
         pGKS+eBJSH/DW75my9a8S+cYl4ibMwRpRIctP5++38Z9FRgstwGJ9fG8ftWjx7wqNEyE
         rvnAm3s3JaEHRNCrbwvTIDhfft0nju+fN7zMZCsQBqfHK5dxGAyHBwZ+BSRPUVnoaDGL
         0PqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=Z/Z88bOWMmF4F62mamLrOyAebeVoxhvHlf2axRQroeU=;
        b=ZK+I3mWkZ//YsJlJQ934J21KsF/7PfE8vKTAkWNceVz7WI+zfVZEy6H44yjnPXbKV0
         S/5lb6wDb5nozU0WCySSYiT9XLiBSBvrWyV91zR/pr+yNB/REFjfhRWvXq9jAaYM+wS3
         y8/vYAGmI4BueqIMCDmWDXwN2+zH3EoALN/hzEtDbqOkC7+SMbEpFfvGnD9bNLsbI5QJ
         n/yZG43HPKqUDFPjmIC1LqS0ait4FN1jS5dm+hYGZMLcXtBk1Kmf0VY1aebQYrhZ8mB9
         Xn8xMI+V/ySRo+fy9LeiPC2oB9iDvjSLl5YZ7EDzEFyLbDfkx2NepkTPs3h+jlNfCHRg
         2JxQ==
X-Gm-Message-State: APjAAAULeJUngYp3XtT5gmpi5PsqmFTbEiOcuuWbpHmPIekV3A5eQvC+
        ZgNO5m4uz+ctgWOSwA2n8VHH+A==
X-Google-Smtp-Source: APXvYqw9eGOrJm9cvVJI/u97vASu90PAfxejcvtaMXaBWq9Lg070IASSwGhBLr2S/3CrJUJdaAQc+Q==
X-Received: by 2002:a1c:7614:: with SMTP id r20mr404224wmc.142.1560805318542;
        Mon, 17 Jun 2019 14:01:58 -0700 (PDT)
Received: from LAPTOP-V3S7NLPL (cpc1-cmbg19-2-0-cust104.5-4.cable.virginm.net. [82.27.180.105])
        by smtp.gmail.com with ESMTPSA id d4sm4647530wra.38.2019.06.17.14.01.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Jun 2019 14:01:57 -0700 (PDT)
References: <20190612113208.21865-1-naveen.n.rao@linux.vnet.ibm.com> <CAADnVQLp+N8pYTgmgEGfoubqKrWrnuTBJ9z2qc1rB6+04WfgHA@mail.gmail.com> <87sgse26av.fsf@netronome.com> <87r27y25c3.fsf@netronome.com> <CAADnVQJZkJu60jy8QoomVssC=z3NE4402bMnfobaWNE_ANC6sg@mail.gmail.com> <87ef3w5hew.fsf@netronome.com> <41dfe080-be03-3344-d279-e638a5a6168d@solarflare.com> <878su0geyt.fsf@netronome.com> <58d86352-4989-38d6-666b-5e932df9ed46@solarflare.com> <877e9kgd39.fsf@netronome.com> <CAADnVQLt7=9XQRccerLqHO8cdXTLy-uNBt-JOjbx=bAFouLf3Q@mail.gmail.com>
User-agent: mu4e 0.9.18; emacs 25.2.2
From:   Jiong Wang <jiong.wang@netronome.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiong Wang <jiong.wang@netronome.com>,
        Edward Cree <ecree@solarflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: Re: [PATCH] bpf: optimize constant blinding
In-reply-to: <CAADnVQLt7=9XQRccerLqHO8cdXTLy-uNBt-JOjbx=bAFouLf3Q@mail.gmail.com>
Date:   Mon, 17 Jun 2019 22:01:56 +0100
Message-ID: <87muig3ozf.fsf@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Alexei Starovoitov writes:

> On Mon, Jun 17, 2019 at 1:40 PM Jiong Wang <jiong.wang@netronome.com> wrote:
>>
>> After digest Alexei and Andrii's reply, I still don't see the need to turn
>> branch target into list, and I am not sure whether pool based list sound
>> good? it saves size, resize pool doesn't invalid allocated node (the offset
>> doesn't change) but requires one extra addition to calculate the pointer.
>
> I don't think it worth to do a pool to accelerate kmalloc.

Got it.

> I doubt it will be faster either.

Will benchmark.

Regards,
Jiong
