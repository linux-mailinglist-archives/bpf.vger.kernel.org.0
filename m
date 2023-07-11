Return-Path: <bpf+bounces-4782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B00EE74F64F
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 19:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ADE22818E6
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 17:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221EC1DDE3;
	Tue, 11 Jul 2023 17:00:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0EB1DDD9
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 17:00:55 +0000 (UTC)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8306F10D8
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 10:00:53 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-55adfa61199so4357186a12.2
        for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 10:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689094853; x=1691686853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjdBm9r4v+Ai8dx8XOLGpj/M16ExfA2ti1QWcSGJBEM=;
        b=D3eHX6mW8sRVZwL/LbZFwwUi4C6QNMl0EkyDqnWGMqIQVkll2TcyX3LLXdCUqLR1vp
         doNX6SB3xadoUNV7DvpW09dMeTFuWs8nzjCDf24V5DD5OTqOpkYLtGGy3fJt/YJhSTsE
         +P6I85DPmZGbZCnYUGXILkK7kaK6CTmYJDbag8jyPHWLkJst8NXJGZQmFBJ6NvfVy1wX
         Kqx5A/7Ts7vaWP93YOYfHxEBPTpWt8H9iUy0hvuzw8v35PuLie6mEYPsVgXE9saFUb16
         b9L+octD/weCgoaGamRF/oW28PCuLBTjHTMCYt8jUmoyg+hxIZAiI8Pd2DldLX4eY8/+
         CkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689094853; x=1691686853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NjdBm9r4v+Ai8dx8XOLGpj/M16ExfA2ti1QWcSGJBEM=;
        b=Ddyjm87VQFN6AvSl/Jc7rvg9A0bNu60Vp7t05Ttd3gF2QrZ/Xjyl6ff+vYoDVo218B
         +OCB8QErNkPWvnQwefQ0c8euAeHYRoW5hBG0UoPl3DaAwGSPAkfmoQixhiOuaT5VRtpf
         Ro6+X6RXMWswDHvz/ToMtfAP7PaFb7wpTz/uaS3L34UUAcAN66nsVsOEK0FFSixOIiwe
         OKTkmNiCOUYs2MAbItdjdcR/IisIhNaci++DlJWRJB6/drpySKzLL3lABWrsnNevKXiP
         1OuhEEiPMTQ2i2jtt2FmvTGO4G2eZTI+eeHE3Bt2SWWXrIf9vMt2n6LQ01YPOD4ZbEQw
         Ucyg==
X-Gm-Message-State: ABy/qLa43iApt9yR4/hCeEJ2Df6WIYRzEUNkACNk2O76f5bJZDYZuPqM
	iQB5i2VQz1IyAApkHXXCChf+j1h1bweteSJBfYVOlUjyW+/GJ3biJTRb8w==
X-Google-Smtp-Source: APBJJlElzBUqt9brN3WkdBYspoLN+ugvRwtHICbp2dyC6rSR+4Ol09QVGlmB5Ih44ZkXB+um4Wsu8SVymGBguo4iDvg=
X-Received: by 2002:a17:90a:d586:b0:263:4815:cb9a with SMTP id
 v6-20020a17090ad58600b002634815cb9amr15695007pju.41.1689094852746; Tue, 11
 Jul 2023 10:00:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230711105930.29170-1-larysa.zaremba@intel.com> <a05a4ac2-40c8-da67-6727-b9844930386e@redhat.com>
In-Reply-To: <a05a4ac2-40c8-da67-6727-b9844930386e@redhat.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Tue, 11 Jul 2023 10:00:42 -0700
Message-ID: <CAKH8qBtBHD=1bXQyPUczLRUSNagNTKC6DNhO1rqHmrGE5kLHWQ@mail.gmail.com>
Subject: Re: [PATCH bpf] xdp: use trusted arguments in XDP hints kfuncs
To: Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc: Larysa Zaremba <larysa.zaremba@intel.com>, bpf@vger.kernel.org, brouer@redhat.com, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 7:21=E2=80=AFAM Jesper Dangaard Brouer
<jbrouer@redhat.com> wrote:
>
>
> On 11/07/2023 12.59, Larysa Zaremba wrote:
> > Currently, verifier does not reject XDP programs that pass NULL pointer=
 to
> > hints functions. At the same time, this case is not handled in any driv=
er
> > implementation (including veth). For example, changing
> >
> > bpf_xdp_metadata_rx_timestamp(ctx, &timestamp);
> >
> > to
> >
> > bpf_xdp_metadata_rx_timestamp(ctx, NULL);
> >
> > in xdp_metadata test successfully crashes the system.
> >
> > Add KF_TRUSTED_ARGS flag to hints kfunc definitions, so driver code
> > does not have to worry about getting invalid pointers.
> >
>
> Looks good to me, assuming this means verifier will reject BPF-prog's
> supplying NULL.
>
> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
>
> > Fixes: 3d76a4d3d4e5 ("bpf: XDP metadata RX kfuncs")
> > Reported-by: Stanislav Fomichev <sdf@google.com>
> > Closes: https://lore.kernel.org/bpf/ZKWo0BbpLfkZHbyE@google.com/
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Acked-by: Stanislav Fomichev <sdf@google.com>

Thank you for the fix!

> > ---
> >   net/core/xdp.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/core/xdp.c b/net/core/xdp.c
> > index 41e5ca8643ec..8362130bf085 100644
> > --- a/net/core/xdp.c
> > +++ b/net/core/xdp.c
> > @@ -741,7 +741,7 @@ __bpf_kfunc int bpf_xdp_metadata_rx_hash(const stru=
ct xdp_md *ctx, u32 *hash,
> >   __diag_pop();
> >
> >   BTF_SET8_START(xdp_metadata_kfunc_ids)
> > -#define XDP_METADATA_KFUNC(_, name) BTF_ID_FLAGS(func, name, 0)
> > +#define XDP_METADATA_KFUNC(_, name) BTF_ID_FLAGS(func, name, KF_TRUSTE=
D_ARGS)
> >   XDP_METADATA_KFUNC_xxx
> >   #undef XDP_METADATA_KFUNC
> >   BTF_SET8_END(xdp_metadata_kfunc_ids)
>

