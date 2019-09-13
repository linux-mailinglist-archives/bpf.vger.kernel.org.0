Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 559CDB1D7F
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2019 14:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388312AbfIMMTa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 13 Sep 2019 08:19:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41106 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388307AbfIMMT3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Sep 2019 08:19:29 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2AFA53C916
        for <bpf@vger.kernel.org>; Fri, 13 Sep 2019 12:19:29 +0000 (UTC)
Received: by mail-ed1-f69.google.com with SMTP id z39so17088515edc.15
        for <bpf@vger.kernel.org>; Fri, 13 Sep 2019 05:19:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=FUyOcPi0NHmHBGgNXqP+P7obEs5/r8uMUZC4jE6n+fs=;
        b=ONBeVn33mqAOPNvFIOU1KKjpo/1v0pkcbAprRG9MPWUR53nPF3v6VDGK0yH+2VzRJm
         nMQ0kmmtH/fw/PyhfVm7rOapGA2mBN3qc9WYxHZI8y9scx5XcqLcoq75a1fTGRy4jv6s
         4eg0cH5mP/lnngniG1lCUQ+IKaURtVWTQdgJlgIj5ZZ839+BWDHMa9TqOTM1QaHIb1ha
         refwdxT9KExluudljTdcaGOBcXpuANgNFdKHVZtAINsgx/Ac+XcnNETvFFbQ2PW0u8Oc
         U0qk7wX19V6hnnfXlldZdYt1kOEVCTMNrD/7ScKTwpzXb+DtRD8P8OFA6QKFYd7dJamK
         sxrQ==
X-Gm-Message-State: APjAAAWefGEf2Kov+YZewmFdu765ZU1amNYrXQie4mtulm5nfvARlXzn
        +yFTQpPPLuxuRbt8ZDfQD0UzStW2UJg9X0XPRRu28kIK0HoZuUGKWHtXoof4yk8LkLq7f0KMSlH
        BnhZwXHjf5yWG
X-Received: by 2002:a50:f30c:: with SMTP id p12mr46858198edm.299.1568377167950;
        Fri, 13 Sep 2019 05:19:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyyJlvDFyQWbdgNap7j6wIzmKQY/VrKSgEVURx/1Gzi41LI0cvKYDz9tVgKPwUjHeIr/5xDNA==
X-Received: by 2002:a50:f30c:: with SMTP id p12mr46858177edm.299.1568377167788;
        Fri, 13 Sep 2019 05:19:27 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id p11sm5241842edh.77.2019.09.13.05.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 05:19:26 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 68597180613; Fri, 13 Sep 2019 14:19:26 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf\@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH] bpf: validate bpf_func when BPF_JIT is enabled
In-Reply-To: <CABCJKufGy0aRDSUPQEOKYZ9tLjqwQDcDaTW-6im-VfjkB_gUsw@mail.gmail.com>
References: <20190909223236.157099-1-samitolvanen@google.com> <4f4136f5-db54-f541-2843-ccb35be25ab4@fb.com> <20190910172253.GA164966@google.com> <c7c7668e-6336-0367-42b3-2f6026c466dd@fb.com> <fd8b6f04-3902-12e9-eab1-fa85b7e44dd5@intel.com> <87impzt4pu.fsf@toke.dk> <CABCJKufCwjXQ6a4oLjywDmxY2apUZ1yop-5+qty82bfwV-QTAA@mail.gmail.com> <87sgp1ssfk.fsf@toke.dk> <CABCJKufGy0aRDSUPQEOKYZ9tLjqwQDcDaTW-6im-VfjkB_gUsw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 13 Sep 2019 14:19:26 +0200
Message-ID: <87h85gs81d.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sami Tolvanen <samitolvanen@google.com> writes:

> On Thu, Sep 12, 2019 at 3:52 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>> I think it would be good if you do both. I'm a bit worried that XDP
>> performance will end up in a "death by a thousand paper cuts" situation,
>> so I'd rather push back on even relatively small overheads like this; so
>> being able to turn it off in the config would be good.
>
> OK, thanks for the feedback. In that case, I think it's probably
> better to wait until we have CFI ready for upstreaming and use the
> same config for this one.

SGTM, thanks!

>> Can you share more details about what the "future CFI checking" is
>> likely to look like?
>
> Sure, I posted an overview of CFI and what we're doing in Pixel devices here:
>
> https://android-developers.googleblog.com/2018/10/control-flow-integrity-in-android-kernel.html

Great, thank you.

-Toke
