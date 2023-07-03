Return-Path: <bpf+bounces-3880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6B1745EC7
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 16:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF8B280DBF
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 14:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E724F9CE;
	Mon,  3 Jul 2023 14:42:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF683FDF
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 14:42:51 +0000 (UTC)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5A010E4
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 07:42:42 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-54290603887so2303988a12.1
        for <bpf@vger.kernel.org>; Mon, 03 Jul 2023 07:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688395362; x=1690987362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DrA308we96oVwz/kgmxRDcKXJtyEBbepsNUANAmoIY0=;
        b=Ipef32BA2RNaBK8hQFCP5rn7/iZ5F+7/2ITqgBNoT//Pyxpw5oJDZHImVjcaj/f9cr
         oBov6aTuCU/uWiIANJI0IGAVCGW2NceXrknYsmfRXoEStDWuLTlj0WO1coDT98FpDZpd
         OoSbiBIH1+0SnVorEzx6R15ihrj8UvThvWlRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688395362; x=1690987362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DrA308we96oVwz/kgmxRDcKXJtyEBbepsNUANAmoIY0=;
        b=j6VUBV+9M+K/W4IFDYNPeLtb2dK6cKCjSZhhcr8k8NhEjBg+SCQG8PmihLzR3mpTUu
         VR+pHjA0Rz+hFixSNHogSe0VVxG6IXD9Iubyolb9qjlE189MRr+my1MEl/Ypdivl/Hhe
         YG8BYhwe/uUkzN740m9mvRaKrT7mL/pQTDBCbG7wy2TKwoT+TI98kRJmZ8mXao62Nr2s
         wGGwe5tMM6azDxCjjcNMucSR/RQqGw7rFFwUjW3Xq4qHhko+RIXku46nnWH1gxSmeanZ
         MqYgpozyWS73TMaBRf2n4eDnxL1M41cSgMwLrGNhYroNbw2INjqaKxG4MvKiwRhES/P7
         hKYg==
X-Gm-Message-State: ABy/qLao3IB3UcQ5W7Srts+dmBoEUUFzyOmNwU7e0p026aSd8IU3Uv5x
	Xh2CHSuGKwAihag1ZQ6fRnVow+6jjRKi/JQUejnG3Q==
X-Google-Smtp-Source: ACHHUZ5mTAPpxbNhYNSgpszF3WnuYH2PV51tm62xSaVgy4bpo+CAIhriuYCoo7xWSfATi1JfQBwW7sG7ccxjqSs1lls=
X-Received: by 2002:a05:6a20:a128:b0:11a:c623:7849 with SMTP id
 q40-20020a056a20a12800b0011ac6237849mr10155512pzk.48.1688395361920; Mon, 03
 Jul 2023 07:42:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230615152918.3484699-1-revest@chromium.org> <ZJFIy+oJS+vTGJer@calendula>
 <CABRcYmJjv-JoadtzZwU5A+SZwbmbgnzWb27UNZ-UC+9r+JnVxg@mail.gmail.com>
 <20230621111454.GB24035@breakpoint.cc> <CABRcYmKeo6A+3dmZd9bRp8W3tO9M5cHDpQ13b8aeMkhYr4L64Q@mail.gmail.com>
 <20230621184738.GG24035@breakpoint.cc>
In-Reply-To: <20230621184738.GG24035@breakpoint.cc>
From: Florent Revest <revest@chromium.org>
Date: Mon, 3 Jul 2023 16:42:30 +0200
Message-ID: <CABRcYmKkDyMBqe0C5AGZVihGQhXzCjsQrg5fBhtTX3qjxe7jOA@mail.gmail.com>
Subject: Re: [PATCH nf] netfilter: conntrack: Avoid nf_ct_helper_hash uses
 after free
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, kadlec@netfilter.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, lirongqing@baidu.com, 
	daniel@iogearbox.net, ast@kernel.org, kpsingh@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 21, 2023 at 8:47=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
>
> Florent Revest <revest@chromium.org> wrote:
> > > in this case an initcall is failing and I think panic is preferrable
> > > to a kernel that behaves like NF_CONNTRACK_FTP=3Dn.
> >
> > In that case, it seems like what you'd want is
> > nf_conntrack_standalone_init() to BUG() instead of returning an error
> > then ? (so you'd never get to NF_CONNTRACK_FTP or any other if
> > nf_conntrack failed to initialize) If this is the prefered behavior,
> > then sure, why not.
> >
> > > AFAICS this problem is specific to NF_CONNTRACK_FTP=3Dy
> > > (or any other helper module, for that matter).
> >
> > Even with NF_CONNTRACK_FTP=3Dm, the initialization failure in
> > nf_conntrack_standalone_init() still happens. Therefore, the helper
> > hashtable gets freed and when the nf_conntrack_ftp.ko module gets
> > insmod-ed, it calls nf_conntrack_helpers_register() and this still
> > causes a use-after-free.
>
> Can you send a v2 with a slightly reworded changelog?
>
> It should mention that one needs NF_CONNTRACK=3Dy, so that when
> the failure happens during the initcall (as oposed to module insertion),
> nf_conntrack_helpers_register() can fail cleanly without followup splat?

Sure! :) On it.

