Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED04A551751
	for <lists+bpf@lfdr.de>; Mon, 20 Jun 2022 13:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241491AbiFTLYf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jun 2022 07:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239503AbiFTLYe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jun 2022 07:24:34 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6D215A30
        for <bpf@vger.kernel.org>; Mon, 20 Jun 2022 04:24:32 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id q11so10738529iod.8
        for <bpf@vger.kernel.org>; Mon, 20 Jun 2022 04:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FUqDMG0XOCjNk9u7JfOrzADWcMXkkEdMVjWM9dkWZMQ=;
        b=WQ9xZ9gfWTvp12lEg+DR7D7oAGFhChWC+apop6OnhiGM8Q1gH82QZLi2gm/tHTTNrv
         MCEfPX9ttbYvMITJuGo26cUnWmHevohbkKdg97ipxrIsNFYNeJ324dFcdnX2U6BsfA/Q
         FvU1sdllB+7hvg/MZ+VwxQZSfHfGiQs+oL7tgEwcLCj4HBXZf/ZlZuwscCRivchwRamy
         7fxn7bWAgOSCYNQeVK9/66cIFj+uT399h3wl302bDl1MZr5nOfXwHJWIaQo6K50MhV4n
         DKhtH0yqA4d8lGdC7kQc+OEv1MowPWcc18ns0w889MnRB1+2RTxFHR+6Hk7Ds2RAEfUA
         CqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FUqDMG0XOCjNk9u7JfOrzADWcMXkkEdMVjWM9dkWZMQ=;
        b=fBI37oAyveKluzPvoQ+d9KfReIqwkB6Wn7gvGdfK9a23xA6AtFoA71sE06zzVtZZ9W
         OG9DDmlijFraBMsd9W+aZzmMLXB/ubqAuQcwm0O5voOnd207N5MwV6taOS5Br28xyYi1
         ndm5r5QxxTwCREZQs6UG8PXjXgnZC9pB5vL92dL+i/FyVzKdB25dhzIlGbg5M78argdM
         1vU4Lz6b+yGkwpqoY17HKHL9W3sigS4QLuJhl9o5gq17VzQbccsIAhxSP6gQ8f49EYRy
         Zyg/3dqE84TwfjRixRQXeNOpRy4AiQNR0AawykAFcfN1CDKTXC82hKxAn4dZgntNte8q
         8pOg==
X-Gm-Message-State: AJIora/wdxQ8ONwyS6dkhH4JAHojqrKeWXiJpmpu2CFBAokmUq+H5RTj
        5ZM5o6BtJsQz/XalGQdwvZYtRRPa/d+prwTWGj+eBw==
X-Google-Smtp-Source: AGRyM1uAApzSsJL6vFFVTOlh+TYoym0VhJDEk+1tEoaCqlkbpyH6Wr0UzGyoXr4xmejJIEEcOMmz7t4KGhFDM4CCTLc=
X-Received: by 2002:a05:6638:2486:b0:331:f9b9:a8ef with SMTP id
 x6-20020a056638248600b00331f9b9a8efmr12526984jat.139.1655724271369; Mon, 20
 Jun 2022 04:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000e57c2b05e1c03426@google.com> <YrBJxrbq8Yvrpshj@linutronix.de>
In-Reply-To: <YrBJxrbq8Yvrpshj@linutronix.de>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Mon, 20 Jun 2022 13:24:20 +0200
Message-ID: <CANp29Y54ygc45-RX+HAXExLsOQgKqbrJ_7CDt6-kRsUwFdNp_Q@mail.gmail.com>
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in __vmalloc_node_range
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     syzbot <syzbot+b577bc624afda52c78de@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        brauner@kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        david@redhat.com, ebiederm@xmission.com,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        "'Aleksandr Nogikh' via syzkaller-bugs" 
        <syzkaller-bugs@googlegroups.com>, tglx@linutronix.de,
        Yonghong Song <yhs@fb.com>, linux-mm@kvack.org,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Sebastian,

Syzbot has noted the new fixing commit -- "mm/page_alloc: protect PCP
lists with a spinlock", but it's not really happy with two commands in
one email.

Let's try it one more time in this separate email:

#syz dup: BUG: sleeping function called from invalid context in relay_open_=
buf

--
Best Regards,
Aleksandr

On Mon, Jun 20, 2022 at 12:19 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> #syz fix: mm/page_alloc: protect PCP lists with a spinlock
> #syz dup: BUG: sleeping function called from invalid context in relay_ope=
n_buf
>
> The version of the patch above in next-20220614 is buggy leading to the
> report below. The version in next-20220620 is fine. Not sure how to tell
> syz bot this=E2=80=A6
>
> On 2022-06-18 15:15:20 [-0700], syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    35d872b9ea5b Add linux-next specific files for 20220614
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D155b0d10080=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dd7bf2236c6b=
b2403
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Db577bc624afda=
52c78de
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binu=
tils for Debian) 2.35.2
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+b577bc624afda52c78de@syzkaller.appspotmail.com
> >
> > BUG: sleeping function called from invalid context at mm/vmalloc.c:2980
> =E2=80=A6
> > Preemption disabled at:
> > [<ffffffff81bc76f5>] rmqueue_pcplist mm/page_alloc.c:3813 [inline]
> > [<ffffffff81bc76f5>] rmqueue mm/page_alloc.c:3858 [inline]
> > [<ffffffff81bc76f5>] get_page_from_freelist+0x455/0x3a20 mm/page_alloc.=
c:4293
>
> Sebastian
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/YrBJxrbq8Yvrpshj%40linutronix.de.
