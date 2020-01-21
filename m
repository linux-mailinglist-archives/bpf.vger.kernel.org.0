Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69E5514488F
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2020 00:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgAUXtY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jan 2020 18:49:24 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44330 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgAUXtW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jan 2020 18:49:22 -0500
Received: by mail-wr1-f65.google.com with SMTP id q10so5345501wrm.11
        for <bpf@vger.kernel.org>; Tue, 21 Jan 2020 15:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tK7af4Yj21EpvGAZIaTRTJBlx41+rY2B9mDlWdbfbi8=;
        b=bTd9UkGog9xWCbHsbf0wHxECfn6qCYjmBs2H9GP/J+PfVO7g2dIAVALlh0QDr048GE
         aD0eafCfACbl+CDgL/jt7fkiQsb83EbB9QtXGcbbIGPR3RZ8Z/6d1Zu9dq19gNO0lvEa
         2vGvHLvS3XqTTA7qvK/yi9a1C7j7Zb2rxoMzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tK7af4Yj21EpvGAZIaTRTJBlx41+rY2B9mDlWdbfbi8=;
        b=MQMi6MITMg3is3Cym6MAWL0l9N/cf0ndypbhSVO7sBz6a0ZCiNIWbU9DWZcmctiIXU
         XmfVTfO6HL262WPPmqyef4csGebYG2eerti/z9VFLWkSsYJ54VLOCt/NIB5wvAL6YAKh
         gPMLKhWDRMgg6HIkagDRim83W5UDe7nMlqHQMRtedohJ0e9sIn3s9cb3nqs2z+hT0osi
         puEdJtLWO2ruKN6yRlfZvRXNwJtXUA7uAju1pxiXfwEA7hjzQyGmPmxbcNdnn52QOdv9
         GhbkQEvGJNNrmSt2W2+i7r7uMPgu51xMvWjcca0B8AafnIj3QdlqTlqM4BwJtU0d5pOC
         5K2w==
X-Gm-Message-State: APjAAAXFJHS2swMpMEfWlJlN0Jri1BGalwlND+0SXAJ5DyEmOEEmUITP
        RIfY7IhPavi1x/ZIX6gKvtwaWQ==
X-Google-Smtp-Source: APXvYqwoGBU6WnXPqYPEDv/r4bHvegGsbO7skJxxBVcEi/7SH5NMS2jak/GYVfHybnuWj7SYgBZ9Tw==
X-Received: by 2002:adf:eb89:: with SMTP id t9mr7679388wrn.5.1579650560374;
        Tue, 21 Jan 2020 15:49:20 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:58ec])
        by smtp.gmail.com with ESMTPSA id x11sm56093615wre.68.2020.01.21.15.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 15:49:19 -0800 (PST)
Date:   Tue, 21 Jan 2020 23:49:19 +0000
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
Message-ID: <20200121234919.GA309703@chrisdown.name>
References: <20200121150431.GA240246@chrisdown.name>
 <CAEf4BzZj4PEamHktYLHqHrau0_pkr_q-J85MPCzFbe7mtLQ_+Q@mail.gmail.com>
 <20200121202916.GA204956@chrisdown.name>
 <CAEf4BzZ5wR_jTEbwYVU-z3ZBP+06p9ZTOeF_DNxqe_nQW493CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ5wR_jTEbwYVU-z3ZBP+06p9ZTOeF_DNxqe_nQW493CA@mail.gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko writes:
>On Tue, Jan 21, 2020 at 12:29 PM Chris Down <chris@chrisdown.name> wrote:
>>
>> Andrii Nakryiko writes:
>> >> --- a/scripts/link-vmlinux.sh
>> >> +++ b/scripts/link-vmlinux.sh
>> >> @@ -108,13 +108,15 @@ gen_btf()
>> >>         local bin_arch
>> >>
>> >>         if ! [ -x "$(command -v ${PAHOLE})" ]; then
>> >> -               info "BTF" "${1}: pahole (${PAHOLE}) is not available"
>> >> +               printf 'BTF: %s: pahole (%s) is not available\n' \
>> >> +                       "${1}" "${PAHOLE}" >&2
>> >
>> >any reason not to use echo instead of printf? would be more minimal change
>>
>> I generally avoid using echo because it has a bunch of portability gotchas
>> which printf mostly doesn't have. If you'd prefer echo, that's fine though,
>> just let me know and I can send v2.
>
>The rest of the script is using echo for errors, so let's stick to it
>for consistency. Thanks!

Sure thing, I'll send v2. Thanks! :-)
