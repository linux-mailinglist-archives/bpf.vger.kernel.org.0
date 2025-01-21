Return-Path: <bpf+bounces-49387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 364BBA17FA7
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 15:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 144A77A2629
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 14:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8181F3D56;
	Tue, 21 Jan 2025 14:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="XaQ3qI7R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85921F37D6
	for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 14:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737469387; cv=none; b=LKK5+bpReQgzK8Iq+rzoymDc35t4d6s+CgeGiw01L5aj9b/fXKJOXOW3s4x2ii6CL5/OzwjRqtcgJTdz9w1TeuYDAyslDmpc7BcxTe9RMq0XGc3WTdZiVzrwb8RbGt5slPnPbEqdHmKkPLFnIBmPIN1+ynmvVHMbjriBuOpEwak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737469387; c=relaxed/simple;
	bh=8LJL8YLTQX6WSmYSPdyTL4xFCKtXqCuDdTieXU+HLvc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BWRyaCEAQnBCCcMVC+JSJgyaQwOZSDZTi7Szonus+H1F4AnK0R5s6iR4ynmrCWScLvqm0R9tAKbA401wsnrbLr/EADqYoeLAwQmeW0t2FfoerxZ4BuewaNRFqTxTMk2NqcTFcGJuUy2PXmEw/9VFHy30iX9JiFOExicUiRpA0Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=XaQ3qI7R; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ab2bb0822a4so1120460566b.3
        for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 06:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1737469383; x=1738074183; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=24RDCBIR9iRuoTg3dMEiNWifEd1AZzAWzKfuB9PQfXw=;
        b=XaQ3qI7RvNa2NBV1K1JH0nic5Y+3rvcA6Z8t4BB68Gx5Ddt99coXv0ZpAvaREmNN15
         51Grft7W6/V7XgtFPe3XullaRN/n4TdlNPpB9p/41/tXzR9dpEtwDMl/twP96Cq3uyau
         axylKZu508/vuravlP31l9QOP5qa0UdoelmKmMwbzdRZ3cdONmMY9jrK2dDni7b5BkwB
         +A/PbVMQriJyRJ3NkefPUHtWCGP3Txam6OUTXPawwTj04XuZ815krlqwDfwZitqfPBck
         XuekrgqzVshkRHERsE04Scft9OD95YNRv5mfySX3wZUTw0jwCieQ9faMcCL8RaKoQA3P
         Kuow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737469383; x=1738074183;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=24RDCBIR9iRuoTg3dMEiNWifEd1AZzAWzKfuB9PQfXw=;
        b=GWJ76Ap7dyMQVRGbc+xNhiOGCSX0BrCBbWuXRaid8mDActE3Xs1yDOZiKjzPH6rJFj
         i7Oki6ViY/ihUL+oS+NIGjPPv0HsY/newVQY8h9OdZV2Tk/0y5aa2ePLXnv8mHRev59F
         ExN6DSW+WveZYt7xqXozmG85DdD2HZlao1vAQGsimq7HkIOV0mA2BoraZ9KAfbkITcBi
         kt47SaVczImWmf9mxr8B2GbkmwAMncVAAbcjaezlvnm8d6mFmIADzUlkMnrgAiHu/RBo
         1u5domvDbjwBkySgVRP0/A75tJg4+Mr8NtIu5K1LSWlV4wS5ZVroGLbES3pfJeB+GiaM
         ZzLw==
X-Gm-Message-State: AOJu0YwroF4bniQC5vaIAtwwrn+l/QcdsvEYZSUsnMGeDkPmxbgEw+Q/
	zNwWT1Upk7gqDApSjA1tpTtgopUCeDZbx43rAjVMOiFqyDy1h85GIJVvl4BGGC0=
X-Gm-Gg: ASbGncuOX4y2Ta3O9w2eHO8ZTVmXgiiv2O7K9hrTs5fHKQoqh5/wxDMeorqnviw2SEt
	2tefu2Pwz1yT6MtAFK1lYF7rOe0CxQMJFsGMLF5ojl7oeuBKYjP+lu5M+Q7QoMM/HXFqHOPfznu
	Ga0jKGIsN579HB9tKIlgpWmnjqDtP3+ksDSRWvAcWfPqTmyBfJ3ntyHnqpOx2MxZj/WOmXrSW++
	ObVX9QT5C3VGllhGJekWbUmObDXqXWjz454sstRtilLupklb9rKYnAfQdE78g==
X-Google-Smtp-Source: AGHT+IFUeRUyejArjy8Ob6cNoRY58VolLrz0RuIWmIcvYqgW/FaOF7yendQ3SxB3TDqJWgJ96/D/pQ==
X-Received: by 2002:a17:907:7f9f:b0:aab:d8de:217e with SMTP id a640c23a62f3a-ab38b163550mr1641019466b.26.1737469382986;
        Tue, 21 Jan 2025 06:23:02 -0800 (PST)
Received: from cloudflare.com ([2a09:bac1:5ba0:d60::38a:3e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384fc35b9sm748662866b.161.2025.01.21.06.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 06:23:02 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <mrpre@163.com>
Cc: bpf@vger.kernel.org,  john.fastabend@gmail.com,  netdev@vger.kernel.org,
  martin.lau@linux.dev,  ast@kernel.org,  edumazet@google.com,
  davem@davemloft.net,  dsahern@kernel.org,  kuba@kernel.org,
  pabeni@redhat.com,  linux-kernel@vger.kernel.org,  song@kernel.org,
  andrii@kernel.org,  mhal@rbox.co,  yonghong.song@linux.dev,
  daniel@iogearbox.net,  xiyou.wangcong@gmail.com,  horms@kernel.org,
  corbet@lwn.net,  eddyz87@gmail.com,  cong.wang@bytedance.com,
  shuah@kernel.org,  mykolal@fb.com,  jolsa@kernel.org,  haoluo@google.com,
  sdf@fomichev.me,  kpsingh@kernel.org,  linux-doc@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v8 3/5] bpf: disable non stream socket for strparser
In-Reply-To: <20250121050707.55523-4-mrpre@163.com> (Jiayuan Chen's message of
	"Tue, 21 Jan 2025 13:07:05 +0800")
References: <20250121050707.55523-1-mrpre@163.com>
	<20250121050707.55523-4-mrpre@163.com>
Date: Tue, 21 Jan 2025 15:23:00 +0100
Message-ID: <87wmeogsaj.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 21, 2025 at 01:07 PM +08, Jiayuan Chen wrote:
> Currently, only TCP supports strparser, but sockmap doesn't intercept
> non-TCP to attach strparser. For example, with UDP, although the
> read/write handlers are replaced, strparser is not executed due to the
> lack of read_sock operation.
>
> Furthermore, in udp_bpf_recvmsg(), it checks whether psock has data, and
> if not, it falls back to the native UDP read interface, making
> UDP + strparser appear to read correctly. According to it's commit

Nit: typo, "its"

> history, the behavior is unexpected.
>
> Moreover, since UDP lacks the concept of streams, we intercept it
> directly.
>
> Signed-off-by: Jiayuan Chen <mrpre@163.com>
> ---
>  net/core/sock_map.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index f1b9b3958792..3b0f59d9b4db 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -303,7 +303,10 @@ static int sock_map_link(struct bpf_map *map, struct sock *sk)
>  
>  	write_lock_bh(&sk->sk_callback_lock);
>  	if (stream_parser && stream_verdict && !psock->saved_data_ready) {
> -		ret = sk_psock_init_strp(sk, psock);
> +		if (sk_is_tcp(sk))
> +			ret = sk_psock_init_strp(sk, psock);
> +		else
> +			ret = -EOPNOTSUPP;
>  		if (ret) {
>  			write_unlock_bh(&sk->sk_callback_lock);
>  			sk_psock_put(sk, psock);

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

