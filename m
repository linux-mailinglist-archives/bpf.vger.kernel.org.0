Return-Path: <bpf+bounces-6488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E07976A471
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 01:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4083E281455
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 23:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1331EA7A;
	Mon, 31 Jul 2023 23:02:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE011EA64
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 23:02:04 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324E61BEC
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 16:02:01 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-522382c4840so7331018a12.2
        for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 16:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1690844519; x=1691449319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4WL3gOAOsh8o0LXKeeq1iHRytJLE+8+Td/rKsOuxt3c=;
        b=ifhJ1b6gnzdlfV3hSa51bPaBs3eS8DGeEYJ1X56dUdEAsywWSe+UBM5K8J0teZorOw
         ZCeoSk2Wpbudv9QJbyUSVS61XtzgkEZLhUMfJhWJ/kMLB46f6ozvmjwPE8zS0H2Q+aBI
         xVI7E+FKWFVFUFnmjndaHdAva+vDU9TxrTfD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690844519; x=1691449319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4WL3gOAOsh8o0LXKeeq1iHRytJLE+8+Td/rKsOuxt3c=;
        b=To474NmZcpt34fspYS4ShCfKNkMXWDom01Falwmv+2hd6mPD/T8WunHp+HdBM3X4JV
         z7NbsWLmyL4L0EIkGEGEqj+i+XI95aOSyj/BxC3X5e/uRUbqWAjGKCvHv6zcntpECPHI
         Yn/Ujeo/lLqomDGGw10HLyK86s/nU6ig9tVnbx2u+5WkIQ5TxKaw5MUq/gpH5uITN+nB
         uWrVgauLl5uim6HvTk20F2cyR7eG1LqlC6itwKX4PuP8aIHLbmOnegXRZiPAp3y6w8sn
         GUeQXCXmWBXA1WGLk2vFGkLR1RYAhMGnCVvbPi0GWKslVtpjjj2ojO/7x8MNKRLvtHwo
         PSxA==
X-Gm-Message-State: ABy/qLYEme+zdwuEoyA0RICtGmcYAGqSfv2RqLScJ7zjv/aqJsEhydgQ
	+Kn5aMDGY8B0t5B7/rEOkUpAyG33mwVJoRtUTei0kw==
X-Google-Smtp-Source: APBJJlEArhe0cg2s67OkddzWHVkNzo44OpuZEBQ6YwO/CmvBOYKNaeen/qZXTJVAZN+WLMX4ggG5P4BVbhYZgzuz5ew=
X-Received: by 2002:a05:6402:14d1:b0:522:ba6c:9b1b with SMTP id
 f17-20020a05640214d100b00522ba6c9b1bmr880560edx.26.1690844519499; Mon, 31 Jul
 2023 16:01:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1690332693.git.yan@cloudflare.com> <e5d05e56bf41de82f10d33229b8a8f6b49290e98.1690332693.git.yan@cloudflare.com>
 <266ab56e-ae83-7ddc-618e-3af228df81bd@linux.dev> <CAO3-Pbon7tCdChnK9kZ4992C-AFPvE5gTDWre6dQT9npEMxS2Q@mail.gmail.com>
 <2f285967-6cc0-c492-6a79-edc233c1368e@linux.dev>
In-Reply-To: <2f285967-6cc0-c492-6a79-edc233c1368e@linux.dev>
From: Yan Zhai <yan@cloudflare.com>
Date: Mon, 31 Jul 2023 18:01:48 -0500
Message-ID: <CAO3-PboZ5eQUbL3UO1HsaQ0s5CyS0ch=ksFVP1R6s8zv0+FTAg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf 1/2] bpf: fix skb_do_redirect return values
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Mykola Lysenko <mykolal@fb.com>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team@cloudflare.com, 
	Jordan Griege <jgriege@cloudflare.com>, Markus Elfring <Markus.Elfring@web.de>, 
	Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 31, 2023 at 5:11=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 7/31/23 2:35 PM, Yan Zhai wrote:
> > On Fri, Jul 28, 2023 at 5:02=E2=80=AFPM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
> >>
> >> On 7/25/23 6:08 PM, Yan Zhai wrote:
> >>> skb_do_redirect returns various of values: error code (negative),
> >>> 0 (success), and some positive status code, e.g. NET_XMIT_CN,
> >>> NET_RX_DROP. Commit 3a0af8fd61f9 ("bpf: BPF for lightweight tunnel
> >>> infrastructure") didn't check the return code correctly, so positive
> >>> values are propagated back along call chain:
> >>>
> >>>     ip_finish_output2
> >>>       -> bpf_xmit
> >>>         -> run_lwt_bpf
> >>>           -> skb_do_redirect
> >>
> >>   From looking at skb_do_redirect, the skb_do_redirect should have con=
sumed the
> >> skb except for the -EAGAIN return value. afaik, -EAGAIN could only hap=
pen by
> >> using the bpf_redirect_peer helper. lwt does not have the bpf_redirect=
_peer
> >> helper available, so there is no -EAGAIN case in lwt. iow, skb_do_redi=
rect
> >> should have always consumed the skb in lwt. or did I miss something?
> >>
> >> If that is the case, it feels like the fix should be in run_lwt_bpf() =
and the
> >> "if (ret =3D=3D 0)" test in run_lwt_bpf() is unnecessary?
> >>
> >>                          ret =3D skb_do_redirect(skb);
> >>                          if (ret =3D=3D 0)
> >>                                  ret =3D BPF_REDIRECT;
> >>
> >>
> > Just fixing skb redirect return code won't be sufficient. I realized
> > there are other return paths that need to be treated, e.g. bpf reroute
> > path also directly returns dev_queue_xmit status. I plan to check for
> > LWTUNNEL_XMIT_CONTINUE (and change it to a value that does not
> > conflict with NET_RX_DROP and NET_XMIT_DROP) in the next revision. On
> > the other hand, the return value of NETDEV_TX_BUSY is another hassle.
>
> I suspect we are talking about different things or I am still missing som=
ething.
>
> I was thinking skb_do_redirect() should have always consumed the skb and
> bpf_xmit should always return LWTUNNEL_XMIT_DONE also (instead of
> LWTUNNEL_XMIT_CONTINUE described in the this patch commit message). It is=
 what
> sch_handle_egress() is doing also. Could you explain how is it different =
from
> the skb_do_redirect usage in sch_handle_egress() or you are suggesting th=
e
> current sch_handle_egress() has the issue too also?
>
I think we were not on the same page. You are absolutely right that
skb_do_redirect should consume the packet anyway. The difference
between your proposal and this patch is that this patch returns errno
or LWTUNNEL_XMIT_DONE, and yours does not even return errno. Both
approaches fix the issue of "redirect to down device crashes the
kernel".

What I commented was an exact same issue at different location: BPF
reroute may trigger the crash as well, since it also returns
dev_queue_xmit status in bpf_xmit. Need to fix this, or instead fixing
LWTUNNEL_XMIT_CONTINUE value and correct the behavior at lwtunnel_xmit
rather than bpf_xmit.

Yan

>
> > As Dan suggested, packets might not have been freed when this is
> > returned from drivers. The caller of dev_queue_xmit might need to free
> > skb when this happens.
> >
> > Yan
>

