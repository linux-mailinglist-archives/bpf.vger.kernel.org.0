Return-Path: <bpf+bounces-77866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D57CF5407
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 19:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 721983079CBD
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 18:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BA7340290;
	Mon,  5 Jan 2026 18:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McGQRb3x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2E9325716
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 18:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767638185; cv=none; b=nHRTsfosV3dhep+q1rcBRkbwGmhU2rimvI9TNH2fRR4F7dOyvmOJfKhjLgN1hWG0gf/t/joODZFun/flykvfkjvYx554awcT+qNhmQvEdlJleDUWxKbhrJYexLOmjMGxuBrugvJ8Kjik3BxiLtDPPP3bkRNK8uzmRVHaqLPc2y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767638185; c=relaxed/simple;
	bh=ucqQl+FAtGie7m8WW3t1QsIHEagAKMQim+7I8Wxk3TU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DwGkR/qd6kq91TFdZsmiSBDEBbkHOZyf90NyBBN82VyVkx5bUYYFZS4TLfNu98heAdaSw8qSh6gQonPBP0ZH03mwQ6Pi8hgMYN2zpVFHZvlwYc4nGOzFh7I3FQDzjtKhKTc7yNLun6Ntj0KdO+9GCNOCTViHD0+iwQFBtUoXRy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=McGQRb3x; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6446c1a7a1cso182877d50.3
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 10:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767638183; x=1768242983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHU17pbiQaZ2ROxmHDlC0PFz3LYB8rk8nJJmpPDTbbY=;
        b=McGQRb3xf2Gz9J1lbnhEOSZiBPDZaj933CInyujqUMXt67m68f+vnght1dlPpCDeQ5
         y4gIel9iFP/6oB4vE/d0F0MixjysUgTxHGVy/ynbMbeR+4GV0rv7NnByJ6TUkZw5HDfa
         XLtZxw5cm9BhIc0ikvUAXxEmC8w+n+WFR7P1tHgLrr/kwJP0UKJM1IxtHlHos0vWWstH
         hwFAjOJ76sSjPNpdpkO3OFsMbCpFqzBxxA0k1pwzvBH+ii1ly8WWa5uDTRMF+yA7mtc8
         loXkZo5/5pvnXBWWaDa6kDqS5/mJQfXPLwwnhmzts5rGVXph16dRxQZFlrz2KZ3+eF5r
         ypLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767638183; x=1768242983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PHU17pbiQaZ2ROxmHDlC0PFz3LYB8rk8nJJmpPDTbbY=;
        b=TieieAX+ym1xGIu8DrZrm3z/4Ir8YgKVeM1YXB5J8ZlZQqbAOL1S4zbsVomFBuTDMQ
         ytIeG0wfpynZp7fhvRxOAagzC+d3vwlFxNe0Dk5W77INmOoDeFLkYPknhFnN86oMCUrP
         EqTThp7AcyhLVqPJ3OVNdvbNZpqfjHBqqRCcaxlDq0fSvlFk4qmBFOoIhOQDlwyN5WzA
         U4LXSr5ZRFhMQ0Ndh7cy5sIab0HkaQ7S0M/2Ojpn3lKZe/r2hizRn06GUb1Af/R+/JSi
         QqdAoWJdDRSRV0nnupTDWsRWUEJLLj2hRvy+YSA1YptCDvalNWy8BSeLtWp0FOnPR5Fn
         E4gg==
X-Forwarded-Encrypted: i=1; AJvYcCVbAfkV9e+quVnvvS4BBVXMy3wVlXesOWFIH8AX1pB19Mpf7x8QWonCa4USaadkg06VhuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqymWdMHusqZpAU8yVx/PmZFidDqhf+cpX1NzAnXhaZj5WyL2i
	yPd9aQNo5uJQe/k8W9jyN4ZB0pBluhEVoXsgFCxr2Hu6AERxDi+I0Qw52eRGrjeDYmaFFXXxMAB
	xn75joLPWFrLpNmxGIuzQpTNzfKCGi8Y=
X-Gm-Gg: AY/fxX4rkiBoakessp6PRDFkdm3oFdFkDcOqJAm+h0lZE28HiKQc/svMPsMTs3UYc6K
	ZyJYJxb+Zh+ffePCixfjgE8Dl3h2FTMJWwue+rElP1/YBPw3dxTh7sXjTLr9Dimtq8lH4bKuaJV
	cg5bouh8K0uWauRXCHkXLDtMr2TY7BWpVkoW/JsqQLmD3kqXnvlyhrEJY2LNxkKXE854QKxpsuk
	xU0eYCEBsiotjkauX9i/y0UsRy9rSSR++2LIspHPvF1tKF7koASSCFCzOJlwdHEahCXLGktZ6k4
	YLzGkBJMPQs=
X-Google-Smtp-Source: AGHT+IEstrxP9Y1l/jKDQ1YHFO6ej7iBq2wH4di7eyXfabmJYxlIjM5OV1543j27+iDSzHkb1n3zJPlxXkCEvI3Kz1U=
X-Received: by 2002:a05:690e:150f:b0:63f:b9b3:9c5 with SMTP id
 956f58d0204a3-6470c866128mr423097d50.34.1767638182823; Mon, 05 Jan 2026
 10:36:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105114747.1358750-1-toke@redhat.com>
In-Reply-To: <20260105114747.1358750-1-toke@redhat.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 5 Jan 2026 10:36:11 -0800
X-Gm-Features: AQt7F2p0_LafOePmVZFkODSfZQP5HwNcIHXP7vsdLGXeJLOiOearIcDS4ZYA5zk
Message-ID: <CAMB2axOsK+niZs38i7mjuuWcEUgJtPhoovsKHui3o=LvdraFnQ@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf, test_run: Subtract size of xdp_frame from
 allowed metadata size
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Yinhao Hu <dddddd@hust.edu.cn>, 
	Kaiyan Mei <M202472210@hust.edu.cn>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 3:48=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@redhat.com> wrote:
>
> The xdp_frame structure takes up part of the XDP frame headroom,
> limiting the size of the metadata. However, in bpf_test_run, we don't
> take this into account, which makes it possible for userspace to supply
> a metadata size that is too large (taking up the entire headroom).
>
> If userspace supplies such a large metadata size in live packet mode,
> the xdp_update_frame_from_buff() call in xdp_test_run_init_page() call
> will fail, after which packet transmission proceeds with an
> uninitialised frame structure, leading to the usual Bad Stuff.
>
> The commit in the Fixes tag fixed a related bug where the second check
> in xdp_update_frame_from_buff() could fail, but did not add any
> additional constraints on the metadata size. Complete the fix by adding
> an additional check on the metadata size. Reorder the checks slightly to
> make the logic clearer and add a comment.
>
> Link: https://lore.kernel.org/r/fa2be179-bad7-4ee3-8668-4903d1853461@hust=
.edu.cn
> Fixes: b6f1f780b393 ("bpf, test_run: Fix packet size check for live packe=
t mode")
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---
>  net/bpf/test_run.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 655efac6f133..e6c0ad204b92 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -1294,8 +1294,6 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, co=
nst union bpf_attr *kattr,
>                         batch_size =3D NAPI_POLL_WEIGHT;
>                 else if (batch_size > TEST_XDP_MAX_BATCH)
>                         return -E2BIG;
> -
> -               headroom +=3D sizeof(struct xdp_page_head);
>         } else if (batch_size) {
>                 return -EINVAL;
>         }
> @@ -1308,16 +1306,26 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, =
const union bpf_attr *kattr,
>                 /* There can't be user provided data before the meta data=
 */
>                 if (ctx->data_meta || ctx->data_end > kattr->test.data_si=
ze_in ||
>                     ctx->data > ctx->data_end ||
> -                   unlikely(xdp_metalen_invalid(ctx->data)) ||
>                     (do_live && (kattr->test.data_out || kattr->test.ctx_=
out)))
>                         goto free_ctx;
> -               /* Meta data is allocated from the headroom */
> -               headroom -=3D ctx->data;
>
>                 meta_sz =3D ctx->data;
> +               if (xdp_metalen_invalid(meta_sz) || meta_sz > headroom - =
sizeof(struct xdp_frame))
> +                       goto free_ctx;
> +
> +               /* Meta data is allocated from the headroom */
> +               headroom -=3D meta_sz;
>                 linear_sz =3D ctx->data_end;
>         }
>
> +       /* The xdp_page_head structure takes up space in each page, limit=
ing the
> +         * size of the packet data; add the extra size to headroom here =
to make
> +         * sure it's accounted in the length checks below, but not in th=
e
> +         * metadata size check above.
> +         */
> +        if (do_live)
> +               headroom +=3D sizeof(struct xdp_page_head);
> +
>         max_linear_sz =3D PAGE_SIZE - headroom - tailroom;
>         linear_sz =3D min_t(u32, linear_sz, max_linear_sz);

The fix makes sense to me.

Reviewed-by: Amery Hung <ameryhung@gmail.com>


>
> --
> 2.52.0
>
>

