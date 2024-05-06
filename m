Return-Path: <bpf+bounces-28735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 317668BD82F
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 01:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BAFB1F23CBF
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 23:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34BA15CD7D;
	Mon,  6 May 2024 23:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMB13Mdu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960AD8488
	for <bpf@vger.kernel.org>; Mon,  6 May 2024 23:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715038160; cv=none; b=VAQW/CmrL1EJaUwyJYkgUyNs9WAtQY8GQTkH3WcY0TwXYD5pLuWfTTwopajEcwPjGO2EEw8oQFtT874vW8txdk2VrDJa38QWHTC73r96+T1uvehY0LEfGl6eI6lTSBGFd+TrJ8FzUAx9Q2RaZabI89Ml545FXHO7UKRV2FwC6Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715038160; c=relaxed/simple;
	bh=ezVK+zkyzpvUg0cqM5WFF3qmKh3kV0DzQZ0Ltr+WFCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TRsJYa06CMm5NvYfWrLv1b6tEZ3W9D+YAWiS4WVix4RrQ2ixiTJ7hD+PeehHwz6YQddgBRkJBQK19K4SyNFh/hhGa1kLk97D9gDbzb9PWIPbovfpKEQwRAnOLTZuqfyI7QvYeJc5Cjd4KZTJ9Wf/jjbhpxxqThDpyxLy4u26tuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMB13Mdu; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41b7a26326eso18629845e9.3
        for <bpf@vger.kernel.org>; Mon, 06 May 2024 16:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715038157; x=1715642957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPvpEpXiPKr3u5v7Z/JE5OlI1VNsE+nCJE2v7Xrub9k=;
        b=NMB13Mdutnk6jOdXbUXc0F6aWaU4bqw2qO2Js60vGg/zkL/oQnznycbCnH5AnAQnMH
         +p40dNCG/95vsg+NYDNjoqvyIT7LpcyFhr8K1OSYcmWDGWoZ4w2zVeu9FRngLcYBfst9
         Y1FzUJ0DxO1UwoA1fy6OEbbTjXFvFezFJZX3tBydKdbVAwyqm3FT3cDk4oyBF509sV4i
         vTgyXKcXdBM9ueIF6o+77CRVp2t1rZRtH+06+QIwh3bkyEsXyU/9Rr/BIPvdjPQTWiMJ
         T84f3lf7bIM02Ib0T/9FIKPeT2zNWDELIDwqdXdxWBoJSQmfr6cs0ROXUB/MTXjv4ImU
         uUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715038157; x=1715642957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPvpEpXiPKr3u5v7Z/JE5OlI1VNsE+nCJE2v7Xrub9k=;
        b=jMnBASvdz1NN+RcHLG2Ywr6MR+qMhNOiGp7hhkrJqC6L6UgQqaH48VpfZ6hwER40eg
         VBW1ZMPZVvssOIF0Dy9JgvNEiZB/Z15hKBSpJeoLB0aca3AoaqA7vXXU1ebCdGPvCPDD
         FlhpnARU+rB94DtmAhNBhgIAhEI/6UprSLpiM4JKGWeQ62L+DofWkcoqmBpmGO0gRLFs
         7NTusWy0J7kbzyLXvYlSzKzIFO/ZeWCAnjr3y408bKAyJ0LeIkOeocoXfrTeQbWa2WVy
         yhugzuea9TyHRmT8NC3HGSOZHeUmU5WY21MdRa9IzVdrJ987Y5Pi144TUftftl3/F+qK
         iZ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXXxhZFF0worjjmiVQduWIYfT10AkQXRSE5Ro76T1XPDh8vsMGVywXMCwvz2PosX/58Yhy+h3axr4InhE1lCI6FYocu
X-Gm-Message-State: AOJu0YwQaB5Uc7TZOLntwUpkh7cSEqNKdX7elUP8c1vyWPSRi5VwuQ9O
	yX4LQps5O/FMLhlCvNe5+Zel3ssgMjxL/CoHdZ/fcpt4l5oJU1PQXFG/7cdpH/TfTj2NsLnzKrJ
	PehPEgnZqWInJLmLC64/jSIVgFLk=
X-Google-Smtp-Source: AGHT+IHO0wVQSWlW2fcG43Y6ucF5jxPIOI/oTeSr9DRiRFOVE1pcuv7QYKewLrF+ekmxA+D/m+k9Oc4ZjRHsHNjbUG4=
X-Received: by 2002:a5d:654e:0:b0:34c:e44a:4620 with SMTP id
 z14-20020a5d654e000000b0034ce44a4620mr7440228wrv.28.1715038156663; Mon, 06
 May 2024 16:29:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430121805.104618-1-lulie@linux.alibaba.com>
 <20240430121805.104618-2-lulie@linux.alibaba.com> <5d4f681a-6636-4c98-9b1e-5c5170b79f7c@linux.dev>
In-Reply-To: <5d4f681a-6636-4c98-9b1e-5c5170b79f7c@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 6 May 2024 16:29:05 -0700
Message-ID: <CAADnVQJ1tycykaGEkD1ubi-kjFapKJBhffYePNsgQH7qh_9ivw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Allow bpf_dynptr_from_skb() for tp_btf
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Philo Lu <lulie@linux.alibaba.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Mykola Lysenko <mykolal@fb.com>, 
	Shuah Khan <shuah@kernel.org>, Daniel Rosenberg <drosen@google.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 2:39=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 4/30/24 5:18 AM, Philo Lu wrote:
> > Making tp_btf able to use bpf_dynptr_from_skb(), which is useful for sk=
b
> > parsing, especially for non-linear paged skb data. This is achieved by
> > adding KF_TRUSTED_ARGS flag to bpf_dynptr_from_skb and registering it
> > for TRACING progs. With KF_TRUSTED_ARGS, args from fentry/fexit are
> > excluded, so that unsafe progs like fexit/__kfree_skb are not allowed.
> >
> > We also need the skb dynptr to be read-only in tp_btf. Because
> > may_access_direct_pkt_data() returns false by default when checking
> > bpf_dynptr_from_skb, there is no need to add BPF_PROG_TYPE_TRACING to i=
t
> > explicitly.
> >
> > Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> > ---
> >   net/core/filter.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 786d792ac816..399492970b8c 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -11990,7 +11990,7 @@ int bpf_dynptr_from_skb_rdonly(struct sk_buff *=
skb, u64 flags,
> >   }
> >
> >   BTF_KFUNCS_START(bpf_kfunc_check_set_skb)
> > -BTF_ID_FLAGS(func, bpf_dynptr_from_skb)
> > +BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS)
>
> I can see the usefulness of having the same way parsing the header as the
> tc-bpf. However, it implicitly means the skb->data and skb_shinfo are tru=
sted
> also. afaik, it should be as long as skb is not NULL.
>
>  From looking at include/trace/events, there is case that skb is NULL. e.=
g.
> tcp_send_reset. It is not something new though, e.g. using skb->sk in the=
 tp_btf
> could be bad already. This should be addressed before allowing more kfunc=
/helper.

Good catch.
We need to fix this part first:
        if (prog_args_trusted(prog))
                info->reg_type |=3D PTR_TRUSTED;

Brute force fix by adding PTR_MAYBE_NULL is probably overkill.
I suspect passing NULL into tracepoint is more of an exception than the rul=
e.
Maybe we can use kfunc's "__" suffix approach for tracepoint args?
[43947] FUNC_PROTO '(anon)' ret_type_id=3D0 vlen=3D4
        '__data' type_id=3D10
        'sk' type_id=3D3434
        'skb' type_id=3D2386
        'reason' type_id=3D39860
[43948] FUNC '__bpf_trace_tcp_send_reset' type_id=3D43947 linkage=3Dstatic

Then do:
diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 49b5ee091cf6..325e8a31729a 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -91,7 +91,7 @@ DEFINE_RST_REASON(FN, FN)
 TRACE_EVENT(tcp_send_reset,

        TP_PROTO(const struct sock *sk,
-                const struct sk_buff *skb,
+                const struct sk_buff *skb__nullable,

and detect it in btf_ctx_access().

