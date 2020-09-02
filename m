Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF2B25ACE1
	for <lists+bpf@lfdr.de>; Wed,  2 Sep 2020 16:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgIBOWR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Sep 2020 10:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgIBOWD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Sep 2020 10:22:03 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99ACEC061244
        for <bpf@vger.kernel.org>; Wed,  2 Sep 2020 07:22:02 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id k15so89586pji.3
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2020 07:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qOZ0s7nHe0Z+jxty1TvaCVltO/gewUvBynyNM6ssAPw=;
        b=cGXn8UPbrLL569/emVM4jpOxyyAmRrSayJCsLFniLC6kePIIb9t0L7nkTDT+NcGyeQ
         ifcIZT5fSXqCJ/I+MQwrIX1Kua1gVgRTyqLA/62KLlXvyb87IqCQPvEsnNnyHSbAf9ML
         Gs+MQdOd8Up3xFxVTqT7hyJb5Mb8LY0sINbZjWDShhb06N/3fOf/E5cy2A3mO5MSE0r3
         xs1Hj0E/00H50QVWEfjV77DU+etq8/goR+6MhwP9mkZKcKxpo8oIKxJBAP90IAJMoenB
         9cX4C8HZqB24bQQCmIME7rFe++4zQwoed7RQQsH7Y2eUk2p2I9QWSuH7W/h6FUTgdnwu
         b9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qOZ0s7nHe0Z+jxty1TvaCVltO/gewUvBynyNM6ssAPw=;
        b=Eayun2+P2yVH4gdjU7QH/hUwVIP3btclU5NV51vDQTqpwRkiNcyEn3ky2aMZnXCpsU
         +GDl0x/TCizIEppIakgWoXHQSsNGWIf3lQeI02GAENXFKSa0fbWpUepjAZ7sL67oE1kj
         JkscBkJRvOUCouGTcjr9Pg74a4/T4jWXIXFX7wnuFi40IluffoNFjOklLZ6dwkQ7+y1j
         5TewAZQgxIOywIG63sFQRcA4vYIL+KEVrNECsEM2XyvqBVuzyCGsFsOXML8aGXui8NrI
         NXodtBTZQZt2DrkwHA29nQxG8BbLFbYTaDWF4vFYgXaP0kWFToW+XJmvPVY+axgIfhoq
         4Gpw==
X-Gm-Message-State: AOAM533ltOnvGNC/kwkUDjVxf6JW+dyO40/lbD+ahfQk625tjDdzbAoW
        NjanJtRoWH7w2YOKkK4qKqI=
X-Google-Smtp-Source: ABdhPJy/1mWiTuTWdDR8wATQYTN3ovA2eVYoQ3qf7BIFvWeWKdKt4rMzKzTqBzpLtkD4G7lBByDkMg==
X-Received: by 2002:a17:902:864c:: with SMTP id y12mr2227779plt.155.1599056521328;
        Wed, 02 Sep 2020 07:22:01 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:b65c])
        by smtp.gmail.com with ESMTPSA id u65sm5721267pfb.102.2020.09.02.07.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 07:22:00 -0700 (PDT)
Date:   Wed, 2 Sep 2020 07:21:58 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: fix a verifier failure with xor
Message-ID: <20200902142158.hp26mv7dxphzyhun@ast-mbp.dhcp.thefacebook.com>
References: <20200825064608.2017878-1-yhs@fb.com>
 <20200825064608.2017937-1-yhs@fb.com>
 <CAEf4Bzb89dz_Sjy14LjQSDWrQ=TpSHAfgf=_Sa=bWUKGqJHCgQ@mail.gmail.com>
 <465da51a-793e-5ea0-85dc-56ab4f36ae34@fb.com>
 <87d034ikve.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87d034ikve.fsf@toke.dk>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 02, 2020 at 11:33:09AM +0200, Toke Høiland-Jørgensen wrote:
> Yonghong Song <yhs@fb.com> writes:
> 
> > On 9/1/20 1:07 PM, Andrii Nakryiko wrote:
> >> On Mon, Aug 24, 2020 at 11:47 PM Yonghong Song <yhs@fb.com> wrote:
> >>>
> >>> bpf selftest test_progs/test_sk_assign failed with llvm 11 and llvm 12.
> >>> Compared to llvm 10, llvm 11 and 12 generates xor instruction which
> >> 
> >> Does this mean that some perfectly working BPF programs will now fail
> >> to verify on older kernels, if compiled with llvm 11 or llvm 12? If
> >
> > Right.
> >
> >> yes, is there something that one can do to prevent Clang from using
> >> xor in such situations?
> >
> > The xor is generated by the combination of llvm simplifyCFG and 
> > instrCombine phase.
> >
> > The following is a hack to prevent compiler from generating xor's.
> 
> Wait, so this means that we can no longer tell people to just use the
> newest LLVM version - now we have to keep track of a minimum *and*
> maximum LLVM version for each kernel version?

No. The only way is forward. Everyone has to upgrade their llvm periodically.

> Could we maybe try to not *keep* making it harder for people to use BPF? :/

Whom do you mean by "we" ?

> As for the patch, sure, make the verifier smarter, but I also feel like
> LLVM should be fixed to not suddenly emit such xor instructions...

I don't think there is anything to be "fixed". It's not a bug form llvm
developers point of view. At least I suspect that's the response you
will get if you post the same sentence on llvm-dev mailing list.
If you care to help, please bisect which llvm commit introduced this change.
May be author (whoever that was) will have ideas how to pessimize it
specifically for bpf backend. But I suspect they will refuse to do so.
The discussion about partial disable of optimizations was brought up
several times. tldr optimizations cannot be disabled effectively.
Pretty much all of them may cause trouble for the verifier and
all of them are often necessary for the verifier as well.
Please read this thread:
http://clang-developers.42468.n3.nabble.com/Disable-certain-llvm-optimizations-at-clang-frontend-tp4068601.html
