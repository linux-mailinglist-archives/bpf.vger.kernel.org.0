Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1879F1962CF
	for <lists+bpf@lfdr.de>; Sat, 28 Mar 2020 02:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgC1BKD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Mar 2020 21:10:03 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:49626 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726518AbgC1BKC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 27 Mar 2020 21:10:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585357800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qzzl0eE8SHxYPT766r5JPV/lrOglXycsXu1ZgMGqThw=;
        b=d9iIrIyBMP+N59YoPO3T2fFwflLxrPXNyIpOzGCQou9hcbz5MJIy2BWlrLhdl8KoZQnOa2
        uOPo7nGGJpge+m6TY5jduf43xtl0Jipo8rZsq2lu06hDDJZ7jW1oWMhTq29aQhBGm1VN5T
        tvgLNPKRhnED2tHTpknefrJbr4THgJM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-k-OwkJxpPdayJpsw7LO4TA-1; Fri, 27 Mar 2020 21:09:59 -0400
X-MC-Unique: k-OwkJxpPdayJpsw7LO4TA-1
Received: by mail-lf1-f70.google.com with SMTP id l3so4303782lfe.22
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2020 18:09:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=qzzl0eE8SHxYPT766r5JPV/lrOglXycsXu1ZgMGqThw=;
        b=KlzOOVUNHo6qDTMrFwbrxd/GpOIEnDvWWDgZgvSoTlkhBgh98SLQJDnZWKOw0ROABX
         lBO5LWDKAcSXoC4gtjDu0aTD1urkCiq5WlPBfkB4JVJkPSguVLTcIfvPBYj/tDobLI56
         dJs+6XwTUi6hycD64h+0V9WDwhPiaN17fAoMux6zwziUr8JbioPT1sjmSH5dBfrIm6Xq
         dK+D5FA/8pBpPFhrweF1jI7q1rEkH05yiBmMR4Kq8czwq6PZIMxP/kTG4hB9CkFpW2h1
         nTRP42AtMq1xsPBS0BktUhq+H+LI019yFWknx+7zJYZ6wQ7d2DebfGbhP9TFUwptGl9s
         zlCA==
X-Gm-Message-State: AGi0PuYAWXUCYcuKXzpekiXaV7x+E4RRxOZBM0WsMyk8BXmJoMFFBEKi
        orEh240Mww91pZr7dCVMMrAZ/2v2bTKyuimP2jyCARwZe8pu/JAFPfvbD4Qt/wpagL6KDtZ5nsz
        4A77NJX32ihqx
X-Received: by 2002:a2e:8850:: with SMTP id z16mr909121ljj.284.1585357797677;
        Fri, 27 Mar 2020 18:09:57 -0700 (PDT)
X-Google-Smtp-Source: APiQypKIO+PoU79nKPwa7Gb2YuRWKgYiYZufJOF5n6ssiUcTAlOeDm8Z8gdHuR+sFAYC43D8J4me0g==
X-Received: by 2002:a2e:8850:: with SMTP id z16mr909094ljj.284.1585357797370;
        Fri, 27 Mar 2020 18:09:57 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id e2sm1074291ljl.83.2020.03.27.18.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 18:09:56 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 5251D18158B; Sat, 28 Mar 2020 02:09:55 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Andrey Ignatov <rdna@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/4] xdp: Support specifying expected existing program when attaching XDP
In-Reply-To: <CAEf4Bza8P3yT08NAaqN2EKaaBFumzydbtYQmSvLxZ99=B6_iHw@mail.gmail.com>
References: <158462359206.164779.15902346296781033076.stgit@toke.dk>
 <158462359315.164779.13931660750493121404.stgit@toke.dk>
 <20200319155236.3d8537c5@kicinski-fedora-PC1C0HJN>
 <875zez76ph.fsf@toke.dk>
 <20200320103530.2853c573@kicinski-fedora-PC1C0HJN>
 <5e750bd4ebf8d_233f2ab4c81425c4ce@john-XPS-13-9370.notmuch>
 <CAEf4BzbWa8vdyLuzr_nxFM3BtT+hhzjCe9UQF8Y5cN+sVqa72g@mail.gmail.com>
 <87tv2f48lp.fsf@toke.dk>
 <CAEf4BzYutqP0yAy-KyToUNHM6Z-6C-XaEwK25pK123gejG0s9Q@mail.gmail.com>
 <87h7ye3mf3.fsf@toke.dk>
 <CAEf4BzY+JsmxCfjMVizLWYU05VS6DiwKE=e564Egu1jMba6fXQ@mail.gmail.com>
 <87tv2e10ly.fsf@toke.dk>
 <CAEf4BzY1bs5WRsvr5UbfqV9UKnwxmCUa9NQ6FWirT2uREaj7_g@mail.gmail.com>
 <87369wrcyv.fsf@toke.dk>
 <CAEf4BzZKvuPz8NZODYnn4DOcjPnj5caVeOHTP9_D3=wL0nVFfw@mail.gmail.com>
 <87pncznvjy.fsf@toke.dk>
 <CAEf4BzaPQ6=h8a6Ngz638AtL4LmBLLVMV+_-YLMR=Ls+drd5HQ@mail.gmail.com>
 <87lfnmm35r.fsf@toke.dk>
 <CAEf4Bza7zQ+ii4SH=4gJqQdyCp9pm6qGAsBOwa0MG5AEofC2HQ@mail.gmail.com>
 <87wo75l9yj.fsf@toke.dk>
 <CAEf4Bza8P3yT08NAaqN2EKaaBFumzydbtYQmSvLxZ99=B6_iHw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 28 Mar 2020 02:09:55 +0100
Message-ID: <87o8shl1y4.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Fri, Mar 27, 2020 at 3:17 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>
>> > Please stop dodging. Just like with "rest of the kernel", but really
>> > "just networking" from before.
>>
>> Look, if we can't have this conversation without throwing around
>> accusations of bad faith, I think it is best we just take Ed's advice
>> and leave it until after the merge window.
>>
>
> Toke, if me pointing out that you are dodging original discussion and
> pivoting offends you,

It does, because I'm not. See below.

> But if you are still with me, let's look at this particular part of
> discussion:
>
>>> >> For XDP there is already a unique handle, it's just implicit: Each
>>> >> netdev can have exactly one XDP program loaded. So I don't really see
>>> >> how bpf_link adds anything, other than another API for the same thin=
g?
>>> >
>>> > I certainly failed to explain things clearly if you are still asking
>>> > this. See point #2, once you attach bpf_link you can't just replace
>>> > it. This is what XDP doesn't have right now.
>>>
>>> Those are two different things, though. I get that #2 is a new
>>> capability provided by bpf_link, I was just saying #1 isn't (for XDP).
>>
>> bpf_link is combination of those different things... Independently
>> they are either impossible or insufficient. I'm not sure how that
>> doesn't answer your question:
>>
>>> So I don't really see
>>> how bpf_link adds anything, other than another API for the same thing?
>>
>> Please stop dodging. Just like with "rest of the kernel", but really
>> "just networking" from before.
>
> You said "So I don't really see how bpf_link adds anything, other than
> another API for the same thing?". I explained that bpf_link is not the
> same thing that exists already, thus it's not another API for the same
> thing. You picked one property of bpf_link and claimed it's the same
> as what XDP has right now. "I get that #2 is a new capability provided
> by bpf_link, I was just saying #1 isn't (for XDP)". So should I read
> that as if you are agreeing and your original objection is rescinded?
> If yes, then good, this part is concluded and I'm sorry if I
> misinterpreted your answer.

Yes, I do believe that was a misinterpretation. Basically, by my
paraphrasing, our argument goes something like this:

What you said was: "bpf_link adds three things: 1. unique attachment
identifier, 2. auto-detach and 3. preventing others from overriding it".

And I replied: "1. already exists for XDP, 2. I don't think is the right
behaviour for XDP, and 3. I don't see the point of - hence I don't
believe bpf_link adds anything useful for my use case"

I was not trying to cherry-pick any of the properties, and I do
understand that 2. and 3. are new properties; I just disagree about how
useful they are (and thus whether they are worth introducing another API
for).

> But if not, then you again are picking one properly and just saying
> "but XDP has it" without considering all of bpf_link properties as a
> whole. In that case I do think you are arguing not in good faith.

I really don't see how you could read my emails and come to that
conclusion. But obviously you did, so I'll take that into consideration
and see if I can express myself clearer in the future. But know this: I
never deliberately argue in bad faith; so even if it seems like I am,
please extend me the courtesy of assuming that this is due to either a
misunderstanding or an honest difference in opinion. I will try to do
the same for you.

> Simple as that. I also hope I don't have to go all the way back to
> "rest of the kernel", pivoted to "just networking" w.r.t.
> subsystem-specific configuration/attachment APIs to explain another
> reference.

Again, I was not trying to "pivot", or attempting to use rhetorical
tricks to "win" or anything like that. I was making an observation about
how it's natural that when two subsystems interact, it's quite natural
that there will be clashes between their different "traditions". And
that how you view the subsystems' relationship with each other obviously
affects your opinion of what the right thing to do is in such a
situation. I never meant to imply anything concrete about BPF in
anything other than a networking context. And again, I don't understand
how you could read that out of what I wrote, but I'll take the fact that
you did into consideration in the future.

> P.S. I don't know how merge window has anything to do with this whole
> discussion, honestly...

Nothing apart from the merge window being a conveniently delimited
period of time to step away from things and focus on something else.

-Toke

