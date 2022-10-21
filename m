Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11791607E2E
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 20:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiJUSRG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 14:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiJUSRG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 14:17:06 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC209273567
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 11:17:03 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id o65so3007708iof.4
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 11:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wvLdmliFR2SKm6eCNwAm/4QIGsn5wXe4C8GHrmUGfXM=;
        b=oEO8rLolFNNWne18FpRM4cpwYEqfJCmMYpRueQWewdRlV93KrzlFgQJFN2NHciTuxt
         1EdwW1bruLPOEkJkFFJn6/GVSigF7QTeyejWONJs0fbfYA5dLko85h+vavqJBVGujI3R
         4ew6riNfdq09qAo7WYPjLmpRhHbQZH1RUF3jY0BElcPELZR4fDf1FRkgPkRHl+OFO3Qc
         uBmY2nWY6Oym9jPwFLZbHAMWel/JLey4YAqCZlxrdMZnOyVQ4fM3obvMreNIlhwILan8
         hd1oMx64KoF0qtATV5d+0Nyn/EdgvJ8XatsHqdnSZUgtk1M+l3GysqVbTdmCkgV8AFyY
         X2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wvLdmliFR2SKm6eCNwAm/4QIGsn5wXe4C8GHrmUGfXM=;
        b=D6VXasaOodena33JliqBisctvqV1bxvSgaRF8FTtnKYmUTzv9gMj0K+0CMmZwR9fcd
         e7ZEcBjnLxv75DH3iBeQFWjQ7VumMR6pv/8PRKEn8pOlNag64YNqn59/xArMplWC3SLt
         4toN4203tEyxWXLS8X/Vogpl3RlIpHGQYqTW8MiKApDPTi83DYlpDuh0mYDz3tNc2zdc
         /rLeY9bn3/v9VN8WD5U/EMcyhwUfCoeI6Gv7nEFVj5/LLI1PfzQOeExwK2HXlwKy86fL
         duq1MNZtteHD6dM5NL9GcVSn5yMmEOGZDWvj59k4/R1/62ErulJ90YwtdaLey1766QwW
         Wc+w==
X-Gm-Message-State: ACrzQf3eKDgxl0UGKEQyylN88ZxyJ/JOrlYvehrhNAnzt4OXmQv14fFI
        xaFDUX6N3+0sy2G1a9iatIXePAFLn7sy2qSXkBeNCqepyVY=
X-Google-Smtp-Source: AMsMyM7J4Kl/L/00vhnDMppduUu47qOi1Je4HGioL9myni1UY1dm0l9AKJbMYFH3WkpsCkch3nWw3SJDG+6HHCf2v68=
X-Received: by 2002:a05:6638:19c4:b0:363:afc3:b403 with SMTP id
 bi4-20020a05663819c400b00363afc3b403mr16736235jab.144.1666376222288; Fri, 21
 Oct 2022 11:17:02 -0700 (PDT)
MIME-Version: 1.0
References: <20221015092448.117563-1-shaozhengchao@huawei.com>
 <CAKH8qBugSdWHP7mtNxrnLLR+56u_0OCx3xQOkJSV-+RUvDAeNg@mail.gmail.com>
 <d830980c-4a38-5537-b594-bc5fb86b0acd@huawei.com> <CAKH8qBtyfS0Otpugn7_ZiG5APA_WTKOVAe1wsFfyaxF-03X=5w@mail.gmail.com>
 <87f67a8c-2fb2-9478-adbb-f55c7a7c94f9@huawei.com>
In-Reply-To: <87f67a8c-2fb2-9478-adbb-f55c7a7c94f9@huawei.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 21 Oct 2022 11:16:51 -0700
Message-ID: <CAKH8qBsOMxVaemF0Oy=vE1V0vKO8ORUcVGB5YANS3HdKOhVjjw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: fix issue that packet only contains l2 is dropped
To:     shaozhengchao <shaozhengchao@huawei.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
        jolsa@kernel.org, oss@lmb.io, weiyongjun1@huawei.com,
        yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 21, 2022 at 12:25 AM shaozhengchao <shaozhengchao@huawei.com> w=
rote:
>
>
>
> On 2022/10/21 1:45, Stanislav Fomichev wrote:
> > On Wed, Oct 19, 2022 at 6:47 PM shaozhengchao <shaozhengchao@huawei.com=
> wrote:
> >>
> >>
> >>
> >> On 2022/10/18 0:36, Stanislav Fomichev wrote:
> >>> On Sat, Oct 15, 2022 at 2:16 AM Zhengchao Shao <shaozhengchao@huawei.=
com> wrote:
> >>>>
> >>>> As [0] see, bpf_prog_test_run_skb() should allow user space to forwa=
rd
> >>>> 14-bytes packet via BPF_PROG_RUN instead of dropping packet directly=
.
> >>>> So fix it.
> >>>>
> >>>> 0: https://github.com/cilium/ebpf/commit/a38fb6b5a46ab3b5639ea4d4212=
32a10013596c0
> >>>>
> >>>> Fixes: fd1894224407 ("bpf: Don't redirect packets with invalid pkt_l=
en")
> >>>> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> >>>> ---
> >>>>    net/bpf/test_run.c | 6 +++---
> >>>>    1 file changed, 3 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> >>>> index 13d578ce2a09..aa1b49f19ca3 100644
> >>>> --- a/net/bpf/test_run.c
> >>>> +++ b/net/bpf/test_run.c
> >>>> @@ -979,9 +979,6 @@ static int convert___skb_to_skb(struct sk_buff *=
skb, struct __sk_buff *__skb)
> >>>>    {
> >>>>           struct qdisc_skb_cb *cb =3D (struct qdisc_skb_cb *)skb->cb=
;
> >>>>
> >>>> -       if (!skb->len)
> >>>> -               return -EINVAL;
> >>>> -
> >>>>           if (!__skb)
> >>>>                   return 0;
> >>>>
> >>>> @@ -1102,6 +1099,9 @@ int bpf_prog_test_run_skb(struct bpf_prog *pro=
g, const union bpf_attr *kattr,
> >>>>           if (IS_ERR(data))
> >>>>                   return PTR_ERR(data);
> >>>>
> >>>> +       if (size =3D=3D ETH_HLEN)
> >>>> +               is_l2 =3D true;
> >>>> +
> >>>
> >>> Don't think this will work? That is_l2 is there to expose proper l2/l=
3
> >>> skb for specific hooks; we can't suddenly start exposing l2 headers t=
o
> >>> the hooks that don't expect it.
> >>> Does it make sense to start with a small reproducer that triggers the
> >>> issue first? We can have a couple of cases for
> >>> len=3D0/ETH_HLEN-1/ETH_HLEN+1 and trigger them from the bpf program t=
hat
> >>> redirects to different devices (to trigger dev_is_mac_header_xmit).
> >>>
> >>>
> >> Hi Stanislav:
> >>          Thank you for your review. Is_l2 is the flag of a specific
> >> hook. Therefore, do you mean that if skb->len is equal to 0, just
> >> add the length back?
> >
> > Not sure I understand your question. All I'm saying is - you can't
> > flip that flag arbitrarily. This flag depends on the attach point that
> > you're running the prog against. Some attach points expect packets
> > with l2, some expect packets without l2.
> >
> > What about starting with a small reproducer? Does it make sense to
> > create a small selftest that adds net namespace + fq_codel +
> > bpf_prog_test run and do redirect ingress/egress with len
> > 0/1...tcphdr? Because I'm not sure I 100% understand whether it's only
> > len=3D0 that's problematic or some other combination as well?
> >
> yes, only skb->len =3D 0 will cause null-ptr-deref issue.
> The following is the process of triggering the problem:
> enqueue a skb:
> fq_codel_enqueue()
>         ...
>         idx =3D fq_codel_classify()        --->if idx !=3D 0
>         flow =3D &q->flows[idx];
>         flow_queue_add(flow, skb);       --->add skb to flow[idex]
>         q->backlogs[idx] +=3D qdisc_pkt_len(skb); --->backlogs =3D 0
>         ...
>         fq_codel_drop()                  --->set sch->limit =3D 0, always
> drop packets
>                 ...
>                 idx =3D i                  --->becuase backlogs in every
> flows is 0, so idx =3D 0
>                 ...
>                 flow =3D &q->flows[idx];   --->get idx=3D0 flow
>                 ...
>                 dequeue_head()
>                         skb =3D flow->head; --->flow->head =3D NULL
>                         flow->head =3D skb->next; --->cause null-ptr-dere=
f
> So, if skb->len !=3D0=EF=BC=8Cfq_codel_drop() could get the correct idx, =
and
> then skb!=3DNULL, it will be OK.
> Maybe, I will fix it in fq_codel.

I think the consensus here is that the stack, in general, doesn't
expect the packets like this. So there are probably more broken things
besides fq_codel. Thus, it's better if we remove the ability to
generate them from the bpf side instead of fixing the individual users
like fq_codel.

> But, as I know, skb->len =3D 0 is just invalid packet. I prefer to add th=
e
> length back, like bellow:
>         if (is_l2 || !skb->len)
>                 __skb_push(skb, hh_len);
> is it OK?

Probably not?

Looking at the original syzkaller report, prog_type is
BPF_PROG_TYPE_LWT_XMIT which does expect a packet without l2 header.
Can we do something like:

if (!is_l2 && !skb->len) {
  // append some dummy byte to the skb ?
}


}

> >>>
> >>>
> >>>
> >>>>           ctx =3D bpf_ctx_init(kattr, sizeof(struct __sk_buff));
> >>>>           if (IS_ERR(ctx)) {
> >>>>                   kfree(data);
> >>>> --
> >>>> 2.17.1
> >>>>
