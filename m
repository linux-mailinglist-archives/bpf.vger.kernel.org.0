Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A23281445EC
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2020 21:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgAUU3T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jan 2020 15:29:19 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37822 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbgAUU3T (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jan 2020 15:29:19 -0500
Received: by mail-wm1-f65.google.com with SMTP id f129so4670816wmf.2
        for <bpf@vger.kernel.org>; Tue, 21 Jan 2020 12:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4v06OcVu6AWGAgREkUN+nJOIVq296IIoZLXUePQ8oZc=;
        b=XrBNnqp79Hr/DOZDtYgis7af+OtRIktTWNbtDXG8Y3/Qb8GRB3slWN5aPD9R7pTrKH
         JBnhybcpF1QDwrQadEzEW2ochphAXfVTSrRSEQouPnd0SbFrgughr7vA4JaBSnGSvqHG
         ICHqKKYVbqVzzNqFxuuHSutNnHmbBzCGww49E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4v06OcVu6AWGAgREkUN+nJOIVq296IIoZLXUePQ8oZc=;
        b=M4rjGv2eCzuKGEROHi1XW7cjvHa7rW6jSgKbeasgeWipavSoyZ5+N/H1TOlG/BqGXd
         XSS+5G6+VaRHOJGII2UVmqcjYWBKkNicuMc3RNLz4ULhE8T0n1vLZNL71UHXNSzxQRfn
         idaAiQ2WTgpRQducJKPwXJcLReSbGQwrGFW1aJN7tLbby+oAJDHqj69n/wjuS+ny99h+
         J88tvQNggX+xpIDP2CU7sFN8PbEv8M9nIDw7pq2N72ofSkU3x4dnnnAygAbC3ebvkmb7
         Ue7r8Oh6eRt8ConNxc1zbS66/D/x1JwM9wSoMTRufvLaLYBXHxN8tg6sb1OXkjA8rmc/
         h/DA==
X-Gm-Message-State: APjAAAXFnHH8N0LVpOuCu4I0ylUD+78D27fsOoCFyZ6MQ1KG1eu+86ha
        Wzr+fKqXK8xNSOSr5o7surjwmA==
X-Google-Smtp-Source: APXvYqzXKlscNyzgyDBzjygHPG9zXc5qiNK6Ib4TKhvYN1HXHb/DAgBd7X6W185JcEtce4e4RPF1Ow==
X-Received: by 2002:a05:600c:22d3:: with SMTP id 19mr193695wmg.92.1579638557788;
        Tue, 21 Jan 2020 12:29:17 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:db6c])
        by smtp.gmail.com with ESMTPSA id z187sm775841wme.16.2020.01.21.12.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 12:29:17 -0800 (PST)
Date:   Tue, 21 Jan 2020 20:29:16 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH] bpf: btf: Always output invariant hit in pahole DWARF to
 BTF transform
Message-ID: <20200121202916.GA204956@chrisdown.name>
References: <20200121150431.GA240246@chrisdown.name>
 <CAEf4BzZj4PEamHktYLHqHrau0_pkr_q-J85MPCzFbe7mtLQ_+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAEf4BzZj4PEamHktYLHqHrau0_pkr_q-J85MPCzFbe7mtLQ_+Q@mail.gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko writes:
>> --- a/scripts/link-vmlinux.sh
>> +++ b/scripts/link-vmlinux.sh
>> @@ -108,13 +108,15 @@ gen_btf()
>>         local bin_arch
>>
>>         if ! [ -x "$(command -v ${PAHOLE})" ]; then
>> -               info "BTF" "${1}: pahole (${PAHOLE}) is not available"
>> +               printf 'BTF: %s: pahole (%s) is not available\n' \
>> +                       "${1}" "${PAHOLE}" >&2
>
>any reason not to use echo instead of printf? would be more minimal change

I generally avoid using echo because it has a bunch of portability gotchas 
which printf mostly doesn't have. If you'd prefer echo, that's fine though, 
just let me know and I can send v2.
