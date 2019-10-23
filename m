Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAD3BE14D9
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2019 10:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387829AbfJWI6Z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 23 Oct 2019 04:58:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34522 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390231AbfJWI6Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Oct 2019 04:58:25 -0400
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 50AEE37E79
        for <bpf@vger.kernel.org>; Wed, 23 Oct 2019 08:58:24 +0000 (UTC)
Received: by mail-lj1-f197.google.com with SMTP id p14so3489431ljh.22
        for <bpf@vger.kernel.org>; Wed, 23 Oct 2019 01:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=mf4WOh51Zg6z2zfBbUrjyJlfNmFhpUPJsIm4EmT0Y0E=;
        b=TZ2OAqQA/Y3bn5G8E0BrOnxtBS37zvVGEGS0t+bZU9fv1OcfnRShxRM5wnwWXXT7Bd
         aCIuGp5gYJkSyZHoxXd4kk6I0/Rc8UM0tpDAevJ/EB0bnsz6e4OVCpz47sDBCYpJ5wvL
         BA6k62nELd3j+fKikrOcgDhu8ZuNzDpQBX5c91EWaCnsmPUfV3Y3QjyBTTofjgiS0wfv
         VueIo8sDE3ucqh0azuHHAdC4RkRj+EViBPSSlemhSoqTc199Rfn63RxXMPeIzwT0WlDi
         LQQCqy6PCGYIG26CKjE+vI+NLK+B6Zu4kfDN5c+IURNhcUWRHkRknj8AVqYYF99UaAXy
         istw==
X-Gm-Message-State: APjAAAVwrktV5uwVHVj3P/HhcXvJfimqh8eFaNeA0SXtZz7GdnM475no
        7tTNrscMt5DGVsVBMXP2o6w8+Vt8/ugN7TH3cfTkGDWqypr7B38H7OXez0LMp9YbUMcvAhzcEI+
        KnFZE7P+aYJ6f
X-Received: by 2002:a19:1ce:: with SMTP id 197mr4525868lfb.16.1571821102862;
        Wed, 23 Oct 2019 01:58:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx0AQ+rCuAgJOCHjdQK8e+vJDc0fCcRLEudl7MFd5H1Z5t6Ceyv3QLlGtaMUaqlOk+jCQZFzQ==
X-Received: by 2002:a19:1ce:: with SMTP id 197mr4525854lfb.16.1571821102686;
        Wed, 23 Oct 2019 01:58:22 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id r18sm1153165ljg.32.2019.10.23.01.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 01:58:21 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 387F41804B1; Wed, 23 Oct 2019 10:58:21 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 3/3] libbpf: Add pin option to automount BPF filesystem before pinning
In-Reply-To: <CAEf4Bzap3oMPnGJQAsoV-g77ux0FdELiJpvpxn9_zadVnHYdSA@mail.gmail.com>
References: <157175668770.112621.17344362302386223623.stgit@toke.dk> <157175669103.112621.7847833678119315310.stgit@toke.dk> <CAEf4BzbfV5vrFnkNyG35Db2iPmM2ubtFh6OTvLiaetAx6eFHHw@mail.gmail.com> <8736fkob4g.fsf@toke.dk> <CAEf4Bzap3oMPnGJQAsoV-g77ux0FdELiJpvpxn9_zadVnHYdSA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 23 Oct 2019 10:58:21 +0200
Message-ID: <87o8y7n8ia.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Tue, Oct 22, 2019 at 12:04 PM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>>
>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>
>> > On Tue, Oct 22, 2019 at 9:08 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>> >>
>> >> From: Toke Høiland-Jørgensen <toke@redhat.com>
>> >>
>> >> While the current map pinning functions will check whether the pin path is
>> >> contained on a BPF filesystem, it does not offer any options to mount the
>> >> file system if it doesn't exist. Since we now have pinning options, add a
>> >> new one to automount a BPF filesystem at the pinning path if that is not
>> >
>> > Next thing we'll be adding extra options to mount BPF FS... Can we
>> > leave the task of auto-mounting BPF FS to tools/applications?
>>
>> Well, there was a reason I put this into a separate patch: I wasn't sure
>> it really fit here. My reasoning is the following: If we end up with a
>> default auto-pinning that works really well, people are going to just
>> use that. And end up really confused when bpffs is not mounted. And it
>> seems kinda silly to make every application re-implement the same mount
>> check and logic.
>>
>> Or to put it another way: If we agree that the reasonable default thing
>> is to just pin things in /sys/fs/bpf, let's make it as easy as possible
>> for applications to do that right.
>>
>
> This reminds me the setrlimit() issue, though.

Heh, yeah. I personally consider the rlimit issue one of the top
usability issues with BPF :/

> And we decided that library shouldn't be manipulating global resources
> on behalf of users. I think this is a similar one.

Hmm, that's a fair point, actually. I do get twitchy watching most
applications just blindly setting rlimit to unlimited before they try to
load BPF programs...

I think I'll just drop this patch for now :)

-Toke
